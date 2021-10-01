
const NB_PIXELS_BY_PACK = 7

function isset(variable) {
    if(typeof(variable) != "undefined" && variable !== null) {
        return true
    }
    return false
}

class Pack {
    constructor(bitsPerPixel) {
        this.pixelsInPack = NB_PIXELS_BY_PACK
        this.bitsPerPixel = bitsPerPixel
        this.nbBytes = bitsPerPixel

        let defaultValue = "0".repeat(bitsPerPixel)

        this.stack = new Array(this.pixelsInPack).fill(defaultValue)
        this.palette = new Array(this.bitsPerPixel).fill(0)
        this.element = new Array(this.bitsPerPixel)
    }

    getPaletteIndex(pos) {
        let paletIndex = Math.floor((this.nbBytes / this.pixelsInPack) * pos)
        return paletIndex
    }

    setColor(pos, val, pal) {
        this.stack[pos] = val
        if (isset(pal)) {
            if (pos == 3) {
                this.palette[0] = this.palette[1] = pal
            } else {
                let paletIndex = this.getPaletteIndex(pos)
                this.palette[paletIndex] = pal
            }
        }
    }

    get() {
        var res = ""
        var octect = ""
        var bits = 0
        for(var i=0; i<this.pixelsInPack; i++) {
            if (bits+this.bitsPerPixel > NB_PIXELS_BY_PACK) {
                let nb = 7 - bits
                octect = this.stack[i].substr(-nb) + octect

                res += " " + this.palette[this.getPaletteIndex(i)] + octect

                bits = this.bitsPerPixel - nb
                octect = this.stack[i].substr(0, bits)
            }  
            else {
                if (isset(this.stack[i])) octect = this.stack[i] + octect
                else octect = "--" + octect
                bits += this.bitsPerPixel
            }
        }
        res += " " + this.palette[this.getPaletteIndex(i-1)] + octect
        return res
    }

    render(parent) {
        var tmp = ''

        if (!isset(parent)) parent = document.body
        for(var i=0; i<this.pixelsInPack; i++) {
            // tmp += '<div class="pixel" data-pack="'+this+'" data-pos="'+ i +'">'+ this.stack[i] +'</div>'
            this.element[i] = document.createElement('div');
            this.element[i].className = "pixel"
            this.element[i].pack = this
            this.element[i].innerHTML = this.stack[i]
            parent.appendChild(this.element[i]);
        }
        return tmp;
    }
}

class Sprite {
    constructor(type, width, height) {
        this.nbPackPerLine = Math.round(width / NB_PIXELS_BY_PACK)
        this.totalPacks = this.nbPackPerLine * height
        switch(type) {
            case 'mono': break
            case 'hgr':
                this.grid = new Array(this.totalPacks).fill(new Pack(2))
                break
            case 'dhgr':
                this.grid = new Array(this.totalPacks).fill(new Pack(4))
                break
        }
    }

    get() {
        var tmp = "";
        this.grid.forEach(function(value) {
            tmp += value.get()
        })
        return tmp
    }

    render() {
        var parent = this;
        this.grid.forEach(function(value, index) {
            value.render()
            if (index % parent.nbPackPerLine == 0) {
                var elemt = document.createElement('br');
                document.body.appendChild(elemt);
            }
        })
    }
}

$(document).ready(function() {
    $(".pixel").on("click", function() {
        let packObject = $(this)[0].pack
        console.log(packObject.get())
    })
})

let obj1 = new Pack(2);

obj1.setColor(0, "AA", 0)
obj1.setColor(1, "BB", 0)
obj1.setColor(2, "CC", 0)
obj1.setColor(4, "EE", 0)
obj1.setColor(5, "FF", 0)
obj1.setColor(6, "GG", 0)
obj1.setColor(3, "12", 1)

document.write(obj1.get())
document.write(obj1.render())
document.write("<br/><br/>")

let obj2 = new Pack(4);

obj2.setColor(0, "AAAA")
obj2.setColor(1, "BBBB")
obj2.setColor(2, "CCCC")
obj2.setColor(3, "1234")
obj2.setColor(4, "EEEE")
obj2.setColor(5, "FFFF")
obj2.setColor(6, "GGGG")

document.write(obj2.get())
document.write("<br/><br/>")

let sprite1 = new Sprite("hgr", 7, 8)
sprite1.render()
document.write("<br/><br/>")
document.write(sprite1.get())