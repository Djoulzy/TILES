var colorValues = {
    black: {val: 0, bin: "0000"},
    dark_blue: {val: 1, bin: "0001"},
    dark_green: {val: 2, bin: "0010"},
    medium_blue: {val: 3, bin: "0011"},
    brown: {val: 4, bin: "0100"},
    grey2: {val: 5, bin: "0101"},
    green: {val: 6, bin: "0110"},
    aqua: {val: 7, bin: "0111"},
    magenta: {val: 8, bin: "1000"},
    violet: {val: 9, bin: "1001"},
    grey1: {val: 10, bin: "1010"},
    light_blue: {val: 11, bin: "1011"},
    orange: {val: 12, bin: "1100"},
    pink: {val: 13, bin: "1101"},
    yellow: {val: 14, bin: "1110"},
    white: {val: 15, bin: "1111"},
}

var pictoWidth = 0
var pictoHeight = 0

function isset(variable) {
    if(typeof(variable) != "undefined" && variable !== null) {
        return true
    }
    return false
}

function displayDrawZone(width, height) {
    pictoWidth = width
    pictoHeight = height

    var cpt = 1;
    document.write('<table class="drawzone">')
    for(let y = 1; y <= height; y++) {
        document.write('    <tr>')
        for(let x = 1; x <= width; x++) {
            document.write('        <td id="'+cpt+'" class="drawcell black" data-color="0000"></td>')
            cpt++
        }
        document.write('    </tr>')
    }
    document.write('</table>')
}

function displayPreview() {
    var cpt = 1;
    document.write('<table class="preview" cellspacing="0" cellpadding="0">')
    for(let y = 1; y <= pictoHeight; y++) {
        document.write('    <tr>')
        for(let x = 1; x <= pictoWidth; x++) {
            document.write('        <td id="p'+cpt+'" class="previewcell black"></td>')
            cpt++
        }
        document.write('    </tr>')
    }
    document.write('</table>')
}

function displayPalette() {
    document.write('<table class="palette">')
    for (const [key, value] of Object.entries(colorValues)) {
        document.write('\t<tr>')
        document.write('\t\t<td id="'+key+'" class="paletteCell '+key+'"></td>')
        document.write('\t</tr>')
    }
    document.write('</table>')
}

function displayResult(output) {
    let format = $('input[name=format]:checked').val()
    let prefix = ""
    var out_aux = ""
    var out_main = ""

    if (format == 'bin') prefix = ".DA "
    else prefix = ".HS "
    for(let y = 0; y<output.length; y++) {
        var aux = new Array
        var main = new Array
        for(let x = 0; x<output[y].length; x += 2) {
            if (format == 'bin') {
                aux.push("#%" + output[y][x])
                main.push("#%" + output[y][x+1])
            } else {
                aux.push(parseInt(output[y][x], 2).toString(16).padStart(2, '0').toUpperCase())
                main.push(parseInt(output[y][x+1], 2).toString(16).padStart(2, '0').toUpperCase())
            }
        }
        out_aux += prefix + aux.join(",") + "<br/>"
        out_main += prefix + main.join(",") + "<br/>"
    }
    let pixWidth = (pictoWidth / 7) * 2
    out_aux = ".HS " + pixWidth.toString(16).padStart(2, '0').toUpperCase()
        + "," + pictoHeight.toString(16).padStart(2, '0').toUpperCase()
        + "," + (pictoHeight*pixWidth).toString(16).padStart(2, '0').toUpperCase()
        + "<br/>" + out_aux
    $("#output_aux").html(out_aux)
    $("#output_main").html(out_main)
}

function swapBytes(line) {
    var tmp = 0
    var binaries = new Array
    for(let x = 0; x<line.length; x += 2) {
        console.log(x)
        tmp = (line[x+1] << 4) | line[x]
        binaries.push(tmp)
    }
    return binaries
}

function invertAndComplete(line) {
    var binaries = new Array
    for(let x = 0; x<line.length; x += 7) {
        var tmp = ""
        for(let cpt = 0; cpt<7; cpt++) {
            tmp = line[x+cpt] + tmp
        }
        binaries.push(tmp)
    }
    // console.log(binaries)
    return binaries
}

function addPaletteBit(lines) {
    var binaries = new Array
    lines.forEach(function(val, index) {
        let cpt = 6
        let tmp = ""
        for(let x = 0; x<val.length; x++) {
            cpt++
            if (cpt > 6) {
                if ((index == 0) && (x < 16) && (x > 8)) tmp += "1"
                else tmp += "0"
                cpt = 0
            }
            tmp += val[x]
            console.log(index, x, val[x])
        }
        binaries.push(tmp)
    })
    // console.log(binaries)
    return binaries
}

function extractBytes(lines) {
    var binaries = new Array
    lines.forEach(function(val, index) {
        var tmp = new Array
        for(let x = 0; x<val.length; x += 8) {
            tmp.push(val.substr(x, 8))
        }
        binaries = binaries.concat(tmp.reverse())
    })
    // console.log(binaries)
    return binaries
}

function computeSprite() {
    var cpt = 0
    var line = 0
    var output = new Array
    $(".drawcell").each(function(index) {
        if (!isset(output[line])) output[line] = new Array
        output[line][cpt] = $(this).data("color")
        cpt++
        if (cpt > 13) {
            // console.log(output[line])
            // output[line] = swapBytes(output[line])
            // output[line] = invertAndComplete(output[line])

            output[line] = invertAndComplete(output[line])
            output[line] = addPaletteBit(output[line])
            output[line] = extractBytes(output[line])
    
            line++
            cpt = 0
        }
    })

    displayResult(output)
}

$(document).ready(function() {

    var colorSelected = "black"

    $(".paletteCell").on("click", function() {
        $("#"+colorSelected).removeClass("selected")
        colorSelected = $(this).attr("id")
        $(this).addClass("selected")
    })

    $(".drawcell").on("click", function() {
        let previewId = "#p" + $(this).attr("id")
        $(this).removeClass()
        $(previewId).removeClass()
        $(this).addClass("drawcell "+colorSelected)
        $(previewId).addClass("previewcell "+colorSelected)
        $(this).data("color", colorValues[colorSelected].bin)
    })

    $("#compute").on("click", computeSprite)

    $("#black").addClass("selected")
})