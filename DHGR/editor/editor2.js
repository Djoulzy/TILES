var pixelsPack = 7
var bytesPerPack = 2
var bitsPerPixel = 2

var byteAlloc = [2, 1, 0, 3, 6, 5, 4]

function isset(variable) {
    if(typeof(variable) != "undefined" && variable !== null) {
        return true
    }
    return false
}

class Pack {
    constructor(width, height) {
        this.stack = new Array(pixelsPack)
    }

    add(pos, val) {
        var destPos = byteAlloc[pos]
        this.stack[pos] = val
    }

    get() {
        var res = ""
        var octect = ""
        var bits = 0
        for(var i=0; i<pixelsPack; i++) {
            console.log(i)
            if (bits+bitsPerPixel > 7) {
                let nb = 7 - bits
                octect = this.stack[i].substr(-1, nb) + octect
                res += " " + octect

                bits = bitsPerPixel - nb
                octect = this.stack[i].substr(0, bits)
                console.log(octect)
            }  
            else {
                if (isset(this.stack[i])) octect = this.stack[i] + octect
                else octect = "--" + octect
                bits += bitsPerPixel
            }
        }
        res += " " + octect
        return res
    }
}

let obj1 = new Pack(14, 8);

obj1.add(0, "AA")
obj1.add(1, "BB")
obj1.add(2, "CC")
obj1.add(3, "DD")
obj1.add(4, "EE")
obj1.add(5, "FF")
obj1.add(6, "GG")

document.write(obj1.get())

document.write("<br/><br/>")

bitsPerPixel = 4
let obj2 = new Pack(14, 8);

obj2.add(0, "AAAA")
obj2.add(1, "BBBB")
obj2.add(2, "CCCC")
obj2.add(3, "DDDD")
obj2.add(4, "EEEE")
obj2.add(5, "FFFF")
obj2.add(6, "GGGG")

document.write(obj2.get())