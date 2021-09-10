var colorValues = {
    blck: {bin: "00"},
    col1: {bin: "01"}, 
    col2: {bin: "10"},
    whte: {bin: "11"},
}
var colorSelected = "blck"
var paletteSelected = "0"
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

    var cpt = 0;
    document.write('<table class="drawzone">')
    for(let y = 1; y <= height; y++) {
        document.write('    <tr>')
        for(let x = 1; x <= width; x++) {
            let byte = Math.trunc(cpt/3.5)
            document.write('        <td id="'+cpt+'" class="drawcell p0 blck" data-palette="0" data-color="00" data-name="blck">'+byte+'</td>')
            cpt++
        }
        document.write('    </tr>')
    }
    document.write('</table>')
}

function displayPreview() {
    var cpt = 0;
    document.write('<table class="preview" cellspacing="0" cellpadding="0">')
    for(let y = 1; y <= pictoHeight; y++) {
        document.write('    <tr>')
        for(let x = 1; x <= pictoWidth; x++) {
            document.write('        <td id="p'+cpt+'" class="previewcell p0 blck"></td>')
            cpt++
        }
        document.write('    </tr>')
    }
    document.write('</table>')
}

function displayPalette() {
    document.write('<table class="palette">')
    document.write('\t<tr><td id="p0blck" class="paletteCell p0 blck" data-color="blck"></td></tr>')
    document.write('\t<tr><td id="p0col1" class="paletteCell p0 col1" data-palette="0" data-color="col1"></td></tr>')
    document.write('\t<tr><td id="p0col2" class="paletteCell p0 col2" data-palette="0" data-color="col2"></td></tr>')
    document.write('\t<tr><td id="p1col1" class="paletteCell p1 col1" data-palette="1" data-color="col1"></td></tr>')
    document.write('\t<tr><td id="p1col2" class="paletteCell p1 col2" data-palette="1" data-color="col2"></td></tr>')
    document.write('\t<tr><td id="p0whte" class="paletteCell p0 whte" data-color="whte"></td></tr>')
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
        var main = new Array
        for(let x = 0; x<output[y].length; x += 1) {
            if (format == 'bin') {
                main.push("#%" + output[y][x])
            } else {
                main.push(parseInt(output[y][x], 2).toString(16).padStart(2, '0').toUpperCase())
            }
        }
        out_main += prefix + main.join(",") + "<br/>"
    }
    let pixWidth = (pictoWidth / 7) * 2
    out_main = ".HS " + pixWidth.toString(16).padStart(2, '0').toUpperCase()
        + "," + pictoHeight.toString(16).padStart(2, '0').toUpperCase()
        + "," + (pictoHeight*pixWidth).toString(16).padStart(2, '0').toUpperCase()
        + "<br/>" + out_main
    $("#output_main").html(out_main)
}

function swapBytes(line) {
    var tmp = 0
    var binaries = new Array
    for(let x = 0; x<line.length; x += 2) {
        tmp = (line[x+1] << 4) | line[x]
        binaries.push(tmp)
    }
    return binaries
}

function invertAndComplete(line, id) {
    var binaries = new Array
    console.log(id)
    for(let x = 0; x<line.length; x += 7) {
        var tmp = ""
        for(let cpt = 0; cpt<7; cpt++) {
            if (cpt == 3) {
                tmp = line[x+cpt][0] + $("#"+(id-6)).data("palette") + line[x+cpt][1] + tmp
            }
            else tmp = line[x+cpt] + tmp
        }
        tmp = $("#"+id).data("palette") + tmp
        //tmp = "0000000000000000" + tmp
        binaries.push(tmp)
    }
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
    console.log(binaries)
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
            output[line] = invertAndComplete(output[line], index)
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

function changePalette(x) {
    let byte = Math.trunc(parseInt(x)/3.5)
    let first = Math.trunc(byte*3.5)
    let last = Math.trunc(byte*3.5+3.5)
    console.log(first, last)
    let invert = Math.abs(paletteSelected - 1)
    for(let i = first; i<last; i++) {
        $("#"+i).removeClass("p"+invert)
        $("#"+i).addClass("p"+paletteSelected)
        $("#"+i).data("palette", paletteSelected)
        $("#p"+i).removeClass("p"+invert)
        $("#p"+i).addClass("p"+paletteSelected)
        $("#p"+i).data("palette", paletteSelected)
    }
}

$(document).ready(function() {
    $(".paletteCell").on("click", function() {
        let precedent = 0
        if ((colorSelected == "blck") || (colorSelected == "whte")) precedent = "p0"+colorSelected
        else precedent = "p"+paletteSelected+colorSelected
        $("#"+precedent).removeClass("selected")
        colorSelected = $(this).data("color")
        paletteSelected = $(this).data("palette")
        if (!isset(paletteSelected)) paletteSelected = 0
        $(this).addClass("selected")
    })

    $(".drawcell").on("click", function() {
        let previewId = "#p" + $(this).attr("id")
        $(this).removeClass()
        $(previewId).removeClass()

        $(this).addClass("drawcell p"+paletteSelected+" "+colorSelected)
        $(previewId).addClass("previewcell p"+paletteSelected+" "+colorSelected)
        $(this).data("color", colorValues[colorSelected].bin)
        $(this).data("name", colorSelected)
        if (paletteSelected != $(this).data("palette")) changePalette($(this).attr("id"))
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