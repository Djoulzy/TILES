
const NB_PIXELS_BY_PACK = 7
const ALT_MODE = true

const urlParams = new URLSearchParams(window.location.search);

var SelectedColorIndex = 0
var SelectedPalette = 0
var sprite

function isset(variable) {
    if(typeof(variable) != "undefined" && variable !== null) {
        return true
    }
    return false
}

function BinHex(val) {
    let hex = parseInt(val, 2).toString(16).padStart(2, '0').toUpperCase()
    return hex
}

function DecHex(val) {
    let hex = val.toString(16).padStart(2, '0').toUpperCase()
    return hex
}

class Pack
{
    constructor(index, bitsPerPixel) {
        this.index = index
        this.pixelsInPack = NB_PIXELS_BY_PACK
        this.bitsPerPixel = bitsPerPixel
        this.nbBytes = bitsPerPixel

        this.stack = new Array(this.pixelsInPack).fill(colors[0])
        this.palette = new Array(this.bitsPerPixel).fill(0)
        this.element = new Array(this.pixelsInPack)
    }

    getPaletteIndex(pos) {
        let paletIndex = Math.floor((this.nbBytes / this.pixelsInPack) * pos)
        return paletIndex
    }

    updatePack() {
        var parent = this;
        this.stack.forEach(function(value, index) {
            let bitsPerPixel = parent.bitsPerPixel.toString()
            let paletteValue = parent.palette[parent.getPaletteIndex(index)].toString()
            let colorValue = parent.stack[index][bitsPerPixel][paletteValue]
            parent.element[index].className = "pixel "+ colorValue.class
            // parent.element[index].innerHTML = colorValue.bin +"<br/>"+ parent.element[index].id + "<br/>"+ paletteValue
        })
    }

    setColor(pos, val, pal) {
        this.stack[pos] = val
        let paletIndex = this.getPaletteIndex(pos)
        if (isset(pal)) {
            if (pos == 3) {
                this.palette[0] = this.palette[1] = pal
            } else {
                this.palette[paletIndex] = pal
            }
        }
        this.updatePack()
    }

    get(format, altMode = false) {
        var res = [[],[]]
        var memSelector = 0
        var octect = ""
        var bits = 0
        var computedValue = ""

        for(var i=0; i<this.pixelsInPack; i++) {
            let paletteValue = this.palette[this.getPaletteIndex(i)]
            let colorValue
            if (altMode) colorValue = this.stack[i][this.bitsPerPixel]["alt"]
            else colorValue = this.stack[i][this.bitsPerPixel][paletteValue]
            if (bits+this.bitsPerPixel > NB_PIXELS_BY_PACK) {
                let nb = 7 - bits

                octect = colorValue.bin.substr(-nb) + octect
                computedValue = paletteValue + octect

                if (format == "bin") res[memSelector].push("#%"+ computedValue)
                else res[memSelector].push(BinHex(computedValue))

                memSelector = Math.abs(memSelector-1)

                bits = this.bitsPerPixel - nb
                octect = colorValue.bin.substr(0, bits)
            }  
            else {
                octect = colorValue.bin + octect
                bits += this.bitsPerPixel
            }
        }

        computedValue = this.palette[this.getPaletteIndex(i-1)] + octect
        if (format == "bin") res[memSelector].push("#%"+computedValue)
        else res[memSelector].push(BinHex(computedValue))
        return res
    }

    save() {
        var tmp = []
        for(var i=0; i<this.pixelsInPack; i++) {
            tmp.push([this.stack[i].id, this.palette[this.getPaletteIndex(i)]])
        }
        return tmp
    }

    render(parent) {
        if (!isset(parent)) parent = document.body
        for(var i=0; i<this.pixelsInPack; i++) {
            this.element[i] = document.createElement('div')
            this.element[i].id = "" + this.index + i
            this.element[i].pack = this
            this.element[i].posInPack = i
            parent.appendChild(this.element[i]);
        }
        this.updatePack()
    }
}

class Sprite
{
    constructor(type, width, height, name) {
        this.type = type
        this.width = parseInt(width, 10)
        this.height = parseInt(height, 10)
        this.name = name.toUpperCase()
        this.nbPackPerLine = Math.round(width / NB_PIXELS_BY_PACK)
        this.totalPacks = this.nbPackPerLine * height
        this.grid = new Array(this.totalPacks)
        
        this.mode = 2
        
        switch(type) {
            case 'mono':
                this.mode = 1
                break
            case 'hgr':
                for(let i=0; i<this.totalPacks; i++) this.grid[i] = new Pack(i, 2)
                this.mode = 2
                break
            case 'dhgr':
                for(let i=0; i<this.totalPacks; i++) this.grid[i] = new Pack(i, 4)
                this.mode = 4
                break
        }
    }

    get(format, name) {
        let pixWidth = (this.width / NB_PIXELS_BY_PACK) * 2
        let totalBytes = pixWidth * this.height
        this.name = name.toUpperCase()

        let macro = ""
        if (format == "bin") macro = "DA"
        else macro = "HS"

        var tmp = this.name+"\n"
        var aux = ""
        var main = ""
        tmp += "\t.HS " + DecHex(pixWidth) + "," + DecHex(this.height) + "," + DecHex(totalBytes) + "\n"
        tmp += "\t.DA #"+this.name+"_ALT,/"+this.name+"_ALT\n"
        this.grid.forEach(function(value) {
            let res = value.get(format)
            aux += "\t." + macro + " " + res[0] + "\n"
            main += "\t." + macro + " " + res[1] + "\n"
        })
        tmp += aux + main

        var aux = ""
        var main = ""
        tmp += "\n"+this.name+"_ALT\n"
        tmp += "\t.HS " + DecHex(pixWidth) + "," + DecHex(this.height) + "," + DecHex(totalBytes) + "\n"
        tmp += "\t.DA #"+this.name+",/"+this.name+"" + "\n"
        this.grid.forEach(function(value) {
            let res = value.get(format, ALT_MODE)
            aux += "\t." + macro + " " + res[0] + "\n"
            main += "\t." + macro + " " + res[1] + "\n"
        })
        tmp += aux + main
        return tmp
    }

    save() {
        var tmp = new Object()

        tmp.type = this.type
        tmp.width = this.width
        tmp.height = this.height
        tmp.grid = []
        this.grid.forEach(function(value) {
            tmp.grid.push(value.save())
        })
        return tmp
    }

    render(tagId) {
        var parent = this;
        this.grid.forEach(function(value, index) {
            value.render(tagId)
            if ((index+1) % parent.nbPackPerLine == 0) {
                var elemt = document.createElement('br');
                tagId.appendChild(elemt);
            }
        })
    }

    displayPalette(tagId) {
        colors.displayPalette(tagId, this.mode)
    }
}

function saveSprite(sprite) {
    let name = $("#name").val()
    let value = sprite.save()
    console.log(JSON.stringify(value))
    localStorage.setItem(name, JSON.stringify(value))
}

function storageAvailable(type) {
    try {
        var storage = window[type],
            x = '__storage_test__';
        storage.setItem(x, x);
        storage.removeItem(x);
        return true;
    }
    catch(e) {
        return e instanceof DOMException && (
            // everything except Firefox
            e.code === 22 ||
            // Firefox
            e.code === 1014 ||
            // test name field too, because code might not be present
            // everything except Firefox
            e.name === 'QuotaExceededError' ||
            // Firefox
            e.name === 'NS_ERROR_DOM_QUOTA_REACHED') &&
            // acknowledge QuotaExceededError only if there's something already stored
            storage.length !== 0;
    }
}

function initSprite(mode, width, height, name) {
    var draw = document.getElementById("drawzone")
    var pal = document.getElementById("palette")

    $("#apply").hide()
    $("#type").prop('disabled', true)
    $("#size").prop('disabled', true)
    sprite = new Sprite(mode, width, height, name)
    sprite.render(draw)
    sprite.displayPalette(pal)

    $(".pixel").on("click", function() {
        let packObject = $(this)[0].pack
        let pos = $(this)[0].posInPack
        packObject.setColor(pos, colors[SelectedColorIndex], SelectedPalette)
    })

    $(".paletteCell").on("click", function() {
        let id = "#ColorCell_"+SelectedColorIndex+"_"+SelectedPalette
        $(id).removeClass("selected")
        SelectedColorIndex = $(this)[0].colorIndex
        SelectedPalette = $(this)[0].paletteIndex
        id = "#ColorCell_"+SelectedColorIndex+"_"+SelectedPalette
        $(id).addClass("selected")
    })
}

function loadSprite(name) {
    let raw = localStorage.getItem(name)
    if (raw !== null) {
        let data = JSON.parse(raw)
        initSprite(data.type, data.width, data.height, name)
        data.grid.forEach(function(value, index) {
            var pixId = "" + index
            value.forEach(function(value, index) {
                SelectedColorIndex = value[0]
                SelectedPalette = value[1]
                $("#"+pixId+index).trigger("click")
            })
        })
    } else return
}

$(document).ready(function()
{
    if (!storageAvailable('localStorage')) {
        alert("Pas de LocaStorage")
    }

    $("#dialogSave").dialog({
        autoOpen: false,
        width: 1000,
        height: 500
    });

    $("#dialogLoad").dialog({
        autoOpen: false,
        width: 1000,
        height: 700
    });

    $("#dialogOutput").dialog({
        autoOpen: false,
        width: 1000,
        height: 700
    });

    $("#compute").on("click", function() {
        let name = $("#name").val()
        let format = $('input[name=format]:checked').val()
        let tmp = sprite.get(format, name)

        $("#dialogOutput").html("<pre>"+tmp+"</pre>")
        $("#dialogOutput").dialog("open");
        navigator.clipboard.writeText(tmp);
    })

    $("#save").on("click", function() {
        saveSprite(sprite)
        $("#dialogSave").html("Sprite <b>"+sprite.name+"</b> saved ...")
        $("#dialogSave").dialog("open");
    })

    $("#load").on("click", function() {
        console.log("load")
        let list = Object.keys(localStorage)
        var tmp = "<ul>"
        list.forEach(function(value, index) {
            tmp += '<li><a href="' + window.location.href.split('?')[0] + '?load=' + value + '">' + value + '</a></li>'
        })
        tmp += "</ul>"
        $("#dialogLoad").html(tmp)
        $("#dialogLoad").dialog("open");
    })

    $("#apply").on("click", function() {
        let mode = $("#type").val()
        let size = $("#size").val().split('x')
        let name = $("#name").val()
        initSprite(mode, size[0], size[1], name)
    })

    let loader = urlParams.get('load');
    if (loader !== null) {
        loadSprite(loader)
    }
})