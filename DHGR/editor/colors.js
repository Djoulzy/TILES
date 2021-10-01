var colorValues = {
    blck: {val: 0, bin: "0000"},
    dkbl: {val: 1, bin: "0001"},
    dkgr: {val: 2, bin: "0010"},
    mdbl: {val: 3, bin: "0011"},
    brwn: {val: 4, bin: "0100"},
    gry2: {val: 5, bin: "0101"},
    gren: {val: 6, bin: "0110"},
    aqua: {val: 7, bin: "0111"},
    mgta: {val: 9, bin: "1001"},
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
    mgta: {val: 9, bin: "0110"},
    gry1: {val: 10, bin: "1010"},
    ltbl: {val: 11, bin: "1110"},
    orge: {val: 12, bin: "0011"},
    pink: {val: 13, bin: "0111"},
    ylow: {val: 14, bin: "1011"},
    whte: {val: 15, bin: "1111"},
}

var colors = [
    {
        id: 0,
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
        id: 1,
        2: {},
        4: {
            0: {class: "dkbl", bin: "0001"},
            1: {class: "dkbl", bin: "0001"},
            alt: {class: "dkbl", bin: "0100"},
        }
    },
    {
        id: 2,
        2: {},
        4: {}
    },
    {
        id: 3,
        2: {},
        4: {}
    },
    {
        id: 4,
        2: {},
        4: {}
    },
    {
        id: 5,
        2: {},
        4: {}
    },
    {
        id: 6,
        2: {
            0: {class: "gren", bin: "10"},
            1: {class: "orge", bin: "10"},
            alt: {}
        },
        4: {
            0: {class: "gren", bin: "0110"},
            1: {class: "gren", bin: "0110"},
            alt: {class: "gren", bin: "1001"},
        }
    },
    {
        id: 7,
        2: {},
        4: {}
    },
    {
        id: 8,
        2: {},
        4: {}
    },
    {
        id: 9,
        2: {
            0: {class: "mgta", bin: "01"},
            1: {class: "mdbl", bin: "01"},
            alt: {}
        },
        4: {
            0: {class: "mgta", bin: "1001"},
            1: {class: "mgta", bin: "1001"},
            alt: {class: "mgta", bin: "0110"},
        }
    }
]