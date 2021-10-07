var colors = [
    {
        id: 0, // BLACK
        2: {
            0: {class: "blck", bin: "00"},
            1: {class: "blck", bin: "00"},
            alt: {}
        },
        4: {
            0: {class: "blck", bin: "0000"},
            1: {class: "blck", bin: "0000"},
            alt: {class: "blck", bin: "0000"},
        }
    },
    {
        id: 1, // MAGENTA / RED
        2: {},
        4: {
            0: {class: "red", bin: "1000"},
            1: {class: "red", bin: "1000"},
            alt: {class: "red", bin: "0010"},
        }
    },
    {
        id: 2, // BROWN
        2: {},
        4: {
            0: {class: "brwn", bin: "0100"},
            1: {class: "brwn", bin: "0100"},
            alt: {class: "brwn", bin: "0001"},
        }
    },
    {
        id: 3, // ORANGE
        2: {},
        4: {
            0: {class: "orng", bin: "1100"},
            1: {class: "orng", bin: "1100"},
            alt: {class: "orng", bin: "0111"},
        }
    },
    {
        id: 4, // DARK GREEN
        2: {},
        4: {
            0: {class: "dgrn", bin: "0010"},
            1: {class: "dgrn", bin: "0010"},
            alt: {class: "dgrn", bin: "0001"},
        }
    },
    {
        id: 5, // GREY 1 / DARK GREY
        2: {},
        4: {
            0: {class: "gry1", bin: "1010"},
            1: {class: "gry1", bin: "1010"},
            alt: {class: "gry1", bin: "1010"},
        }
    },
    {
        id: 6, // GREEN
        2: {
            0: {class: "gren", bin: "10"},
            1: {class: "orng", bin: "10"},
            alt: {}
        },
        4: {
            0: {class: "gren", bin: "0110"},
            1: {class: "gren", bin: "0110"},
            alt: {class: "gren", bin: "1001"},
        }
    },
    {
        id: 7, // YELLOW
        2: {},
        4: {
            0: {class: "ylow", bin: "1110"},
            1: {class: "ylow", bin: "1110"},
            alt: {class: "ylow", bin: "1011"},
        }
    },
    {
        id: 8, // DARK BLUE
        2: {},
        4: {
            0: {class: "dblu", bin: "0001"},
            1: {class: "dblu", bin: "0001"},
            alt: {class: "dblu", bin: "1000"},
        }
    },
    {
        id: 9, // VIOLET / PURPLE
        2: {
            0: {class: "prpl", bin: "01"},
            1: {class: "mblu", bin: "01"},
            alt: {}
        },
        4: {
            0: {class: "prpl", bin: "1001"},
            1: {class: "prpl", bin: "1001"},
            alt: {class: "prpl", bin: "0110"},
        }
    },
    {
        id: 10, // GREY 2
        2: {},
        4: {
            0: {class: "gry2", bin: "0101"},
            1: {class: "gry2", bin: "0101"},
            alt: {class: "gry2", bin: "1010"},
        }
    },
    {
        id: 11, // PINK
        2: {},
        4: {
            0: {class: "pink", bin: "1101"},
            1: {class: "pink", bin: "1101"},
            alt: {class: "pink", bin: "0111"},
        }
    },
    {
        id: 12, // MEDIUM BLUE
        2: {},
        4: {
            0: {class: "mblu", bin: "0011"},
            1: {class: "mblu", bin: "0011"},
            alt: {class: "mblu", bin: "0011"},
        }
    },
    {
        id: 13, // LIGHT BLUE
        2: {},
        4: {
            0: {class: "lblu", bin: "1101"},
            1: {class: "lblu", bin: "1101"},
            alt: {class: "lblu", bin: "1110"},
        }
    },
    {
        id: 14, // AQUA
        2: {},
        4: {
            0: {class: "aqua", bin: "0111"},
            1: {class: "aqua", bin: "0111"},
            alt: {class: "aqua", bin: "1101"},
        }
    },
    {
        id: 15, // WHITE
        2: {
            0: {class: "whte", bin: "11"},
            1: {class: "whte", bin: "11"},
            alt: {}
        },
        4: {
            0: {class: "whte", bin: "1111"},
            1: {class: "whte", bin: "1111"},
            alt: {class: "whte", bin: "1111"},
        }
    }
]

colors.get = function(index, mode, palette) {
    return this[index][mode][palette]
}

colors.displayPalette = function(tagId, mode) {
    switch(mode) {
        case 2:
            let hgrColors = [0, 6, 9, 15]
            hgrColors.forEach(function(value) {
                let colorValue = colors.get(value, 2, 0)
                let elmt = document.createElement('div')
                elmt.id = "ColorCell_" + value + "_"
                if (value == 6 || value == 9) {
                    elmt.id += 0
                    elmt.paletteIndex = 0
                }
                elmt.className = "paletteCell " + colorValue.class
                elmt.colorIndex = value
                tagId.appendChild(elmt)
                if (value == 6 || value == 9) {
                    let colorValue = colors.get(value, 2, 1)
                    let elmt = document.createElement('div')
                    elmt.id = "ColorCell_" + value + "_" + 1
                    elmt.className = "paletteCell " + colorValue.class
                    elmt.colorIndex = value
                    elmt.paletteIndex = 1
                    tagId.appendChild(elmt)
                }
            })
            break
        case 4:
            for(var i=0; i<16; i++) {
                let colorValue = colors.get(i, 4, 0)
                let elmt = document.createElement('div')
                elmt.id = "ColorCell_" + i + "_" + 0
                elmt.className = "paletteCell " + colorValue.class
                elmt.colorIndex = i
                elmt.paletteIndex = 0
                tagId.appendChild(elmt)
            }
            break
    }
}