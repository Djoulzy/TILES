
const NB_PIXELS_BY_PACK = 7
const ALT_MODE = true
const USE_AUX_MEM = true
const NO_AUX_MEM = false

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
    constructor(index, bitsPerPixel, pixSize, auxmem) {
        this.index = index
        this.pixelsInPack = NB_PIXELS_BY_PACK
        this.bitsPerPixel = bitsPerPixel
        this.nbBytes = bitsPerPixel
        this.auxmem = auxmem

        this.stack = new Array(this.pixelsInPack).fill(colors[0])
        this.palette = new Array(this.bitsPerPixel).fill(0)
        this.element = new Array(this.pixelsInPack)

        this.pixelClass = "pixel"
        this.previewClass = "previewcell"
        if (pixSize == 1) {
            this.pixelClass = "pixel1"
            this.previewClass = "previewcell1"
        }
    }

    getPaletteIndex(pos) {
        let paletIndex = Math.floor((this.nbBytes / this.pixelsInPack) * pos)
        return paletIndex
    }

    updatePack() {
        var parent = this;
        this.stack.forEach(function(value, index) {
            let paletteValue = parent.palette[parent.getPaletteIndex(index)]
            let colorValue = parent.stack[index][parent.bitsPerPixel][paletteValue]
            parent.element[index].className = parent.pixelClass + " "+ colorValue.class

            let prevId = "p" + parent.element[index].id
            let preview = document.getElementById(prevId)
            preview.className = parent.previewClass +" "+ colorValue.class
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

                if (this.auxmem) memSelector = Math.abs(memSelector-1)

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
            this.element[i].id = this.index + "_" + i
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
        this.modePalette = 2
        
        switch(type) {
            case 'mono_hgr':
                for(let i=0; i<this.totalPacks; i++) this.grid[i] = new Pack(i, 1, 1, NO_AUX_MEM)
                this.mode = 1
                this.modePalette = 1
                break
            case 'hgr':
                for(let i=0; i<this.totalPacks; i++) this.grid[i] = new Pack(i, 2, 2, NO_AUX_MEM)
                this.mode = 2
                this.modePalette = 2
                break
            case 'mono_dhgr':
                for(let i=0; i<this.totalPacks; i++) this.grid[i] = new Pack(i, 2, 1, USE_AUX_MEM)
                this.mode = 3
                this.modePalette = 1
                break
            case 'dhgr':
                for(let i=0; i<this.totalPacks; i++) this.grid[i] = new Pack(i, 4, 2, USE_AUX_MEM)
                this.mode = 4
                this.modePalette = 4
                break
        }
    }

    get(format, name) {
        let pixWidth = (this.width / NB_PIXELS_BY_PACK)
        if ((this.mode == 2) || (this.mode == 4)) pixWidth *= 2
        let totalBytes = pixWidth * this.height
        this.name = name.toUpperCase()

        let macro = ""
        if (format == "bin") macro = "\t.DA "
        else macro = "\t.HS "

        var parent = this
        var tmp = this.name+"\n"
        var aux = ""
        var main = ""
        var newLineCpt = 0
        tmp += "\t.HS " + DecHex(pixWidth) + "," + DecHex(this.height) + "," + DecHex(totalBytes)
        if (this.mode > 2) tmp += "\n\t.DA #"+this.name+"_ALT,/"+this.name+"_ALT"
        this.grid.forEach(function(value) {
            let res = value.get(format)

            newLineCpt--
            if (newLineCpt <= 0) {
                aux += "\n"+macro
                if (parent.mode > 2) main += "\n"+macro
                newLineCpt = 8
            } else {
                aux += ","
                if (parent.mode > 2) main += ","
            }

            aux += res[0]
            if (parent.mode > 2) main += res[1]
        })
        tmp += aux + main

        if (this.mode > 2) {
            var aux = ""
            var main = ""
            newLineCpt = 0
            tmp += "\n"+this.name+"_ALT\n"
            tmp += "\t.HS " + DecHex(pixWidth) + "," + DecHex(this.height) + "," + DecHex(totalBytes)
            tmp += "\n\t.DA #"+this.name+",/"+this.name
            this.grid.forEach(function(value) {
                let res = value.get(format, ALT_MODE)
                newLineCpt--
                if (newLineCpt <= 0) {
                    aux += "\n"+macro
                    main += "\n"+macro
                    newLineCpt = 8
                } else {
                    aux += ","
                    main += ","
                }
    
                aux += res[0]
                main += res[1]
            })
            tmp += aux + main
        }
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
        colors.displayPalette(tagId, this.modePalette)
    }

    displayPreview(tagId) {
        var cpt = 0
        for (var j=0; j<this.height; j++) {
            for (var p=0; p<this.nbPackPerLine; p++) {
                for (var i=0; i<NB_PIXELS_BY_PACK; i++) {
                    var elemt = document.createElement('div');
                    elemt.id = "p" + cpt + "_" + i
                    elemt.className = "previewcell"
                    tagId.appendChild(elemt);
                }
                cpt++
            }
            var elemt = document.createElement('br');
            tagId.appendChild(elemt);
        }
    }
}

function saveSprite(sprite) {
    let name = $("#name").val()
    let value = sprite.save()
    localStorage.setItem(name, JSON.stringify(value))
}

function download(sprite) {
    let filename = $("#name").val() + ".json"
    let data = JSON.stringify(sprite.save())
    var file = new Blob([data], {type: "text/plain"})
    if (window.navigator.msSaveOrOpenBlob) // IE10+
        window.navigator.msSaveOrOpenBlob(file, filename)
    else { // Others
        var a = document.createElement("a"),
                url = URL.createObjectURL(file)
        a.href = url
        a.download = filename
        document.body.appendChild(a)
        a.click()
        setTimeout(function() {
            document.body.removeChild(a)
            window.URL.revokeObjectURL(url)
        }, 0)
    }
}

function upload(e) {
    var file = e.target.files[0]
    if (!file) return

    var reader = new FileReader()
    reader.onload = function(e) {
        var contents = e.target.result
        console.log(contents)
    };
    reader.readAsText(file)
}

function storageAvailable(type) {
    try {
        var storage = window[type],
            x = '__storage_test__'
        storage.setItem(x, x)
        storage.removeItem(x)
        return true
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
            storage.length !== 0
    }
}

function initSprite(mode, width, height, name) {
    var draw = document.getElementById("drawzone")
    var pal = document.getElementById("palette")
    var prev = document.getElementById("preview")

    $("#apply").hide()
    $("#type").prop('disabled', true)
    $("#size").prop('disabled', true)
    sprite = new Sprite(mode, width, height, name)
    sprite.displayPreview(prev)
    sprite.render(draw)
    sprite.displayPalette(pal)

    if ((mode == "mono_hgr") || (mode == "mono_dhgr")) {
        $(".pixel1").on("click", function() {
            let packObject = $(this)[0].pack
            let pos = $(this)[0].posInPack
            packObject.setColor(pos, colors[SelectedColorIndex], SelectedPalette)
        })
    } else {
        $(".pixel").on("click", function() {
            let packObject = $(this)[0].pack
            let pos = $(this)[0].posInPack
            packObject.setColor(pos, colors[SelectedColorIndex], SelectedPalette)
        })
    }

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
                $("#"+pixId+"_"+index).trigger("click")
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

    $("#export").on("click", function() {
        download(sprite)
    })

    $("#import").on("change", upload)

    $("#load").on("click", function() {
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