
const NB_PIXELS_BY_PACK = 7
const ALT_MODE = true

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
    constructor(bitsPerPixel) {
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
            parent.element[index].innerHTML = colorValue.bin +"<br/>"+ index+ "<br/>"+ paletteValue
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
            tmp.push(this.stack[i].id)
        }
        return tmp
    }

    render(parent) {
        if (!isset(parent)) parent = document.body
        for(var i=0; i<this.pixelsInPack; i++) {
            this.element[i] = document.createElement('div')
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
        this.width = width
        this.height = height
        this.name = name.toUpperCase()
        this.nbPackPerLine = Math.round(width / NB_PIXELS_BY_PACK)
        this.totalPacks = this.nbPackPerLine * height
        this.grid = new Array(this.totalPacks)
        
        this.mode = 2
        
        switch(type) {
            case 'mono': break
            case 'hgr':
                for(let i=0; i<this.totalPacks; i++) this.grid[i] = new Pack(2)
                this.mode = 2
                break
            case 'dhgr':
                for(let i=0; i<this.totalPacks; i++) this.grid[i] = new Pack(4)
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

        var tmp = this.name+"<br/>"
        var aux = ""
        var main = ""
        tmp += "&nbsp;&nbsp;&nbsp;&nbsp;.HS " + DecHex(pixWidth) + "," + DecHex(this.height) + "," + DecHex(totalBytes) + "<br/>"
        tmp += "&nbsp;&nbsp;&nbsp;&nbsp;.DA #"+this.name+"_ALT,/"+this.name+"_ALT<br/>"
        this.grid.forEach(function(value) {
            let res = value.get(format)
            aux += "&nbsp;&nbsp;&nbsp;&nbsp;." + macro + " " + res[0] + "<br/>"
            main += "&nbsp;&nbsp;&nbsp;&nbsp;." + macro + " " + res[1] + "<br/>"
        })
        tmp += aux + main

        var aux = ""
        var main = ""
        tmp += "<br/>"+this.name+"_ALT<br/>"
        tmp += "&nbsp;&nbsp;&nbsp;&nbsp;.HS " + DecHex(pixWidth) + "," + DecHex(this.height) + "," + DecHex(totalBytes) + "<br/>"
        tmp += "&nbsp;&nbsp;&nbsp;&nbsp;.DA #"+this.name+",/"+this.name+"" + "<br/>"
        this.grid.forEach(function(value) {
            let res = value.get(format, ALT_MODE)
            aux += "&nbsp;&nbsp;&nbsp;&nbsp;." + macro + " " + res[0] + "<br/>"
            main += "&nbsp;&nbsp;&nbsp;&nbsp;." + macro + " " + res[1] + "<br/>"
        })
        tmp += aux + main
        return tmp
    }

    save() {
        var tmp = []
        this.grid.forEach(function(value) {
            tmp.push(value.save("bin"))
        })
        return tmp
    }

    render(tagId) {
        var parent = this;
        this.grid.forEach(function(value, index) {
            value.render(tagId)
            if ((index+1) % parent.nbPackPerLine == 0) {
                var elemt = document.createElement('div');
                elemt.className = "clearBoth"
                tagId.appendChild(elemt);
            }
        })
    }

    displayPalette(tagId) {
        colors.displayPalette(tagId, this.mode)
    }
}

function saveSprite(sprite) {
    localStorage.setItem(sprite.name, JSON.stringify(sprite.save()))
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

    console.log(mode, width, height, name)
    sprite = new Sprite(mode, width, height, name)
    sprite.render(draw)
    sprite.displayPalette(pal)
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

    $("#compute").on("click", function() {
        let name = $("#name").val()
        let format = $('input[name=format]:checked').val()
        let tmp = sprite.get(format, name)

        $("#dialogOutput").html(tmp)
        $("#dialogOutput").dialog("open");
        navigator.clipboard.writeText(tmp);
    })

    $("#save").on("click", function() {
        saveSprite(sprite)
    })

    $("#load").on("click", function() {
        console.log("load")
        let list = Object.keys(localStorage)
        $("#dialogLoad").html(list)
        $("#dialogLoad").dialog("open");
    })

    $("#apply").on("click", function() {
        let mode = $("#type").val()
        let size = $("#size").val().split('x')
        let name = $("#name").val()
        initSprite(mode, size[0], size[1], name)
    })
})