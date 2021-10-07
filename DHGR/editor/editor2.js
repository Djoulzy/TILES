
const NB_PIXELS_BY_PACK = 7
const ALT_MODE = true

var SelectedColorIndex = 0
var SelectedPalette = 0

function isset(variable) {
    if(typeof(variable) != "undefined" && variable !== null) {
        return true
    }
    return false
}

function getHex(val) {
    return val.toString(16).padStart(2, '0').toUpperCase()
}

class Pack
{
    constructor(bitsPerPixel) {
        this.pixelsInPack = NB_PIXELS_BY_PACK
        this.bitsPerPixel = bitsPerPixel
        this.nbBytes = bitsPerPixel

        let defaultValue = "0".repeat(bitsPerPixel)

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
                else res[memSelector].push(getHex(computedValue))
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
        else res[memSelector].push(getHex(computedValue))
        console.log(res)
        return res
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

    get(format) {
        let pixWidth = (this.width / NB_PIXELS_BY_PACK) * 2
        let totalBytes = pixWidth * this.height

        let macro = ""
        if (format == "bin") macro = "DA"
        else macro = "HS"

        var tmp = this.name+"<br/>"
        var aux = ""
        var main = ""
        tmp += "&nbsp;&nbsp;&nbsp;&nbsp;.HS " + getHex(pixWidth) + "," + getHex(this.height) + "," + getHex(totalBytes) + "<br/>"
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
        tmp += "&nbsp;&nbsp;&nbsp;&nbsp;.HS " + getHex(pixWidth) + "," + getHex(this.height) + "," + getHex(totalBytes) + "<br/>"
        tmp += "&nbsp;&nbsp;&nbsp;&nbsp;.DA #"+this.name+",/"+this.name+"" + "<br/>"
        this.grid.forEach(function(value) {
            let res = value.get(format, ALT_MODE)
            aux += "&nbsp;&nbsp;&nbsp;&nbsp;." + macro + " " + res[0] + "<br/>"
            main += "&nbsp;&nbsp;&nbsp;&nbsp;." + macro + " " + res[1] + "<br/>"
        })
        tmp += aux + main
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

$(document).ready(function()
{
    var draw = document.getElementById("drawzone")
    var pal = document.getElementById("palette")

    let sprite1 = new Sprite("hgr", 7, 8, "name")
    sprite1.render(draw)
    sprite1.displayPalette(pal)

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
        let format = $('input[name=format]:checked').val()
        let tmp = sprite1.get(format)
        $("#output").html(tmp)
    })
})

// let obj1 = new Pack(2);

// obj1.setColor(0, "AA", 0)
// obj1.setColor(1, "BB", 0)
// obj1.setColor(2, "CC", 0)
// obj1.setColor(4, "EE", 0)
// obj1.setColor(5, "FF", 0)
// obj1.setColor(6, "GG", 0)
// obj1.setColor(3, "12", 1)

// document.write(obj1.get())
// document.write(obj1.render())
// document.write("<br/><br/>")

// let obj2 = new Pack(4);

// obj2.setColor(0, "AAAA")
// obj2.setColor(1, "BBBB")
// obj2.setColor(2, "CCCC")
// obj2.setColor(3, "1234")
// obj2.setColor(4, "EEEE")
// obj2.setColor(5, "FFFF")
// obj2.setColor(6, "GGGG")

// document.write(obj2.get())
// document.write("<br/><br/>")

