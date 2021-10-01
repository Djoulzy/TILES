
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
    }

    getPaletteIndex(pos) {
        let paletIndex = Math.floor((this.nbBytes / this.pixelsInPack) * pos)
        console.log(paletIndex)
        return paletIndex
    }

    add(pos, val, pal) {
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

    render() {
        var tmp = ''
        for(var i=0; i<this.pixelsInPack; i++) {
            tmp += '<div class="pixel" data-pos="'+ i +'">'+ this.stack[i] +'</div>'
        }
        return tmp;
    }
}

class Sprite {
    constructor(type, width, height) {
        let nbPackPerLine = Math.round(width / NB_PIXELS_BY_PACK)
        let totalPacks = nbPackPerLine * height
        switch(type) {
            case 'mono': break
            case 'hgr':
                this.grid = new Array(totalPacks).fill(new Pack(2))
                break
            case 'dhgr':
                this.grid = new Array(totalPacks).fill(new Pack(4))
                break
        }
    }

    display() {
        console.log(this.grid)
        this.grid.forEach(function(value) {
            document.write(value.get())
        })
    }

    renderGrid() {

    }
}

let obj1 = new Pack(2);

obj1.add(0, "AA", 0)
obj1.add(1, "BB", 0)
obj1.add(2, "CC", 0)
obj1.add(4, "EE", 0)
obj1.add(5, "FF", 0)
obj1.add(6, "GG", 0)
obj1.add(3, "12", 1)

document.write(obj1.get())
document.write(obj1.render())
document.write("<br/><br/>")

let obj2 = new Pack(4);

obj2.add(0, "AAAA")
obj2.add(1, "BBBB")
obj2.add(2, "CCCC")
obj2.add(3, "1234")
obj2.add(4, "EEEE")
obj2.add(5, "FFFF")
obj2.add(6, "GGGG")

document.write(obj2.get())
document.write("<br/><br/>")

let sprite1 = new Sprite("hgr", 7, 8)
sprite1.display()