var colorValues = {
    blck: {val: 0, bin: "0000"},
    dkbl: {val: 1, bin: "0001"},
    dkgr: {val: 2, bin: "0010"},
    mdbl: {val: 3, bin: "0011"},
    brwn: {val: 4, bin: "0100"},
    gry2: {val: 5, bin: "0101"},
    gren: {val: 6, bin: "0110"},
    aqua: {val: 7, bin: "0111"},
    vilt: {val: 9, bin: "1001"},
    gry1: {val: 10, bin: "1010"},
    ltbl: {val: 11, bin: "1011"},
    orge: {val: 12, bin: "1100"},
    pink: {val: 13, bin: "1101"},
    ylow: {val: 14, bin: "1110"},
    whte: {val: 15, bin: "1111"},
}

var altColorValues = {
    blck: {val: 0, bin: "0000"},
    dkbl: {val: 1, bin: "0100"},
    dkgr: {val: 2, bin: "0010"},
    mdbl: {val: 3, bin: "1100"},
    brwn: {val: 4, bin: "0001"},
    gry2: {val: 5, bin: "0101"},
    gren: {val: 6, bin: "1001"},
    aqua: {val: 7, bin: "1101"},
    vilt: {val: 9, bin: "0110"},
    gry1: {val: 10, bin: "1010"},
    ltbl: {val: 11, bin: "1110"},
    orge: {val: 12, bin: "0011"},
    pink: {val: 13, bin: "0111"},
    ylow: {val: 14, bin: "1011"},
    whte: {val: 15, bin: "1111"},
}

var colorSelected = "blck"
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
            document.write('        <td id="'+cpt+'" class="drawcell blck" data-color="0000" data-name="blck"></td>')
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
            document.write('        <td id="p'+cpt+'" class="previewcell blck"></td>')
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
    let out  = ".HS " + pixWidth.toString(16).padStart(2, '0').toUpperCase()
        + "," + pictoHeight.toString(16).padStart(2, '0').toUpperCase()
        + "," + (pictoHeight*pixWidth).toString(16).padStart(2, '0').toUpperCase()
        + "<br/>" + out_aux + out_main
    $("#output").html(out)
}

function invertAndComplete(line) {
    var binaries = new Array
    for(let x = 0; x<line.length; x += 7) {
        var tmp = ""
        for(let cpt = 0; cpt<7; cpt++) {
            tmp = line[x+cpt] + tmp
        }
        //tmp = "0000000000000000" + tmp
        binaries.push(tmp)
    }
    console.log(binaries)
    return binaries
}

function invertAndCompleteAlt(line) {
    var binaries = new Array
    for(let x = 0; x<line.length; x += 7) {
        var tmp = ""
        for(let cpt = 0; cpt<7; cpt++) {
            tmp = line[x+cpt] + tmp
        }
        //tmp = "0000000000000000" + tmp
        tmp += "00"
        tmp = tmp.substr(2)
        binaries.push(tmp)
    }
    console.log(binaries)
    return binaries
    // 000000000000000000000000111100
    // 0000000000000000000000001111
}

function addPaletteBit(lines) {
    var binaries = new Array
    lines.forEach(function(val, index) {
        let cpt = 6
        let tmp = ""
        for(let x = 0; x<val.length; x++) {
            cpt++
            if (cpt > 6) {
                // if ((index == 0) && (x < 16) && (x > 8)) tmp += "1"
                // else
                tmp += "0"
                cpt = 0
            }
            tmp += val[x]
            // console.log(index, x, val[x])
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
        if (cpt == pictoWidth) {
            output[line] = invertAndCompleteAlt(output[line])
            output[line] = addPaletteBit(output[line])
            output[line] = extractBytes(output[line])
    
            line++
            cpt = 0
        }
    })

    displayResult(output)
}

function saveSprite() {
    var cpt = 0
    var line = 0
    var output = new Array
    $(".drawcell").each(function(index) {
        if (!isset(output[line])) output[line] = new Array
        output[line][cpt] = $(this).data("name")
        cpt++
        if (cpt == pictoWidth) {    
            line++
            cpt = 0
        }
    })

    let content = JSON.stringify(output)
    $("#dialogSave").html(content)
    $("#dialogSave").dialog("open");
    navigator.clipboard.writeText(content);
}

function loadSprite() {
    let data = JSON.parse($("#importData").val())
    var cpt = 1
    data.forEach(function(lines) {
        lines.forEach(function(cols) {
            colorSelected = cols
            $("#"+cpt).trigger("click")
            cpt++
        })
    })
}

$(document).ready(function() {
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
        $(this).data("name", colorSelected)
    })

    $("#compute").on("click", computeSprite)
    $("#save").on("click", saveSprite)
    $("#load").on("click", function() {
        $("#dialogLoad").dialog("open");
    })
    $("#import").on("click", loadSprite)

    $("#black").addClass("selected")

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
})