NEW
  
AUTO 4,1
            .OP	65C02
            .LIST OFF
*			.OR	$6000
*			.TF /DEV/TILES/OBJ/GFXTABLES
*--------------------------------------
HTAB_LO		.HS 00,00,00,00,00,00,00,00
			.HS 80,80,80,80,80,80,80,80
			.HS 00,00,00,00,00,00,00,00
			.HS 80,80,80,80,80,80,80,80
			.HS 00,00,00,00,00,00,00,00
			.HS 80,80,80,80,80,80,80,80
			.HS 00,00,00,00,00,00,00,00
			.HS 80,80,80,80,80,80,80,80
			.HS 28,28,28,28,28,28,28,28
			.HS A8,A8,A8,A8,A8,A8,A8,A8
			.HS 28,28,28,28,28,28,28,28
			.HS A8,A8,A8,A8,A8,A8,A8,A8
			.HS 28,28,28,28,28,28,28,28
			.HS A8,A8,A8,A8,A8,A8,A8,A8
			.HS 28,28,28,28,28,28,28,28
			.HS A8,A8,A8,A8,A8,A8,A8,A8
			.HS 50,50,50,50,50,50,50,50
			.HS D0,D0,D0,D0,D0,D0,D0,D0
			.HS 50,50,50,50,50,50,50,50
			.HS D0,D0,D0,D0,D0,D0,D0,D0
			.HS 50,50,50,50,50,50,50,50
			.HS D0,D0,D0,D0,D0,D0,D0,D0
			.HS 50,50,50,50,50,50,50,50
			.HS D0,D0,D0,D0,D0,D0,D0,D0

HTAB_HI		.HS 20,24,28,2C,30,34,38,3C
			.HS 20,24,28,2C,30,34,38,3C
			.HS 21,25,29,2D,31,35,39,3D
			.HS 21,25,29,2D,31,35,39,3D
			.HS 22,26,2A,2E,32,36,3A,3E
			.HS 22,26,2A,2E,32,36,3A,3E
			.HS 23,27,2B,2F,33,37,3B,3F
			.HS 23,27,2B,2F,33,37,3B,3F
			.HS 20,24,28,2C,30,34,38,3C
			.HS 20,24,28,2C,30,34,38,3C
			.HS 21,25,29,2D,31,35,39,3D
			.HS 21,25,29,2D,31,35,39,3D
			.HS 22,26,2A,2E,32,36,3A,3E
			.HS 22,26,2A,2E,32,36,3A,3E
			.HS 23,27,2B,2F,33,37,3B,3F
			.HS 23,27,2B,2F,33,37,3B,3F
			.HS 20,24,28,2C,30,34,38,3C
			.HS 20,24,28,2C,30,34,38,3C
			.HS 21,25,29,2D,31,35,39,3D
			.HS 21,25,29,2D,31,35,39,3D
			.HS 22,26,2A,2E,32,36,3A,3E
			.HS 22,26,2A,2E,32,36,3A,3E
			.HS 23,27,2B,2F,33,37,3B,3F
			.HS 23,27,2B,2F,33,37,3B,3F
*--------------------------------------
MBOFFSET	.HS FF,00,00,00,FF,01,01,FF,02,02,02,FF,03,03
			.HS FF,04,04,04,FF,05,05,FF,06,06,06,FF,07,07
			.HS FF,08,08,08,FF,09,09,FF,0A,0A,0A,FF,0B,0B
			.HS FF,0C,0C,0C,FF,0D,0D,FF,0E,0E,0E,FF,0F,0F
			.HS FF,10,10,10,FF,11,11,FF,12,12,12,FF,13,13
			.HS FF,14,14,14,FF,15,15,FF,16,16,16,FF,17,17
			.HS FF,18,18,18,FF,19,19,FF,1A,1A,1A,FF,1B,1B
			.HS FF,1C,1C,1C,FF,1D,1D,FF,1E,1E,1E,FF,1F,1F
			.HS FF,20,20,20,FF,21,21,FF,22,22,22,FF,23,23
			.HS FF,24,24,24,FF,25,25,FF,26,26,26,FF,27,27

ABOFFSET	.HS 00,00,FF,01,01,01,FF,02,02,FF,03,03,03,FF
			.HS 04,04,FF,05,05,05,FF,06,06,FF,07,07,07,FF
			.HS 08,08,FF,09,09,09,FF,0A,0A,FF,0B,0B,0B,FF
			.HS 0C,0C,FF,0D,0D,0D,FF,0E,0E,FF,0F,0F,0F,FF
			.HS 10,10,FF,11,11,11,FF,12,12,FF,13,13,13,FF
			.HS 14,14,FF,15,15,15,FF,16,16,FF,17,17,17,FF
			.HS 18,18,FF,19,19,19,FF,1A,1A,FF,1B,1B,1B,FF
			.HS 1C,1C,FF,1D,1D,1D,FF,1E,1E,FF,1F,1F,1F,FF
			.HS 20,20,FF,21,21,21,FF,22,22,FF,23,23,23,FF
			.HS 24,24,FF,25,25,25,FF,26,26,FF,27,27,27,FF
*--------------------------------------
SPRITE
			.HS 04,10,40
			.DA #%01101110,#%00111011,#%01101110,#%00111011
			.DA #%00001110,#%00110000,#%00110000,#%00000010
			.DA #%00001110,#%00110000,#%00110000,#%00001010
			.DA #%00001110,#%00110000,#%00110000,#%00000010
			.DA #%00001110,#%00110000,#%00110000,#%00001010
			.DA #%00001110,#%00110000,#%00110000,#%00000010
			.DA #%00001110,#%00110000,#%00110000,#%00001010
			.DA #%00001110,#%00110000,#%00110000,#%00000010
			.DA #%00001110,#%00110000,#%00110000,#%01111110
			.DA #%00001110,#%00110000,#%00110000,#%00000010
			.DA #%00001110,#%00110000,#%00110000,#%01100110
			.DA #%00001110,#%00110000,#%00110000,#%00000010
			.DA #%00001110,#%00110000,#%00110000,#%01100110
			.DA #%00001110,#%00110000,#%00110000,#%00000010
			.DA #%00001110,#%00110000,#%00110000,#%01000010
			.DA #%01101110,#%00111011,#%01101110,#%00111011

			.DA #%11011101,#%01110111,#%01011101,#%01110111
			.DA #%10011000,#%00110000,#%01000000,#%01110000
			.DA #%10011000,#%00110000,#%01000000,#%01110001
			.DA #%10011000,#%00110000,#%01000000,#%01110000
			.DA #%10011000,#%00110000,#%01000000,#%01110001
			.DA #%10011000,#%00110000,#%01000000,#%01110000
			.DA #%10011000,#%00110000,#%01000000,#%01110001
			.DA #%10011000,#%00110000,#%01000000,#%01110000
			.DA #%10011000,#%00110000,#%01000000,#%01110111
			.DA #%10011000,#%00110000,#%01000000,#%01110000
			.DA #%10011000,#%00110000,#%01000000,#%01110100
			.DA #%10011000,#%00110000,#%01000000,#%01110000
			.DA #%10011000,#%00110000,#%01000000,#%01110100
			.DA #%10011000,#%00110000,#%01000000,#%01110000
			.DA #%10011000,#%00110000,#%01000000,#%01110111
			.DA #%11011101,#%01110111,#%01011101,#%01110111
*--------------------------------------
SPRITE2
			.HS 02,10,20
			.DA #%01111111,#%01111111
			.DA #%00001111,#%00000000
			.DA #%00001111,#%00000000
			.DA #%00001111,#%00000000
			.DA #%00001111,#%00000000
			.DA #%00001111,#%00000000
			.DA #%00001111,#%00000000
			.DA #%00001111,#%00000000
			.DA #%00001111,#%00000000
			.DA #%00001111,#%00000000
			.DA #%00001111,#%00000000
			.DA #%00001111,#%00000000
			.DA #%00001111,#%00000000
			.DA #%00001111,#%00000000
			.DA #%00001111,#%00000000
			.DA #%01111111,#%01111111
			.DA #%11111111,#%01111111
			.DA #%10000000,#%01111000
			.DA #%10000000,#%01111000
			.DA #%10000000,#%01111000
			.DA #%10000000,#%01111000
			.DA #%10000000,#%01111000
			.DA #%10000000,#%01111000
			.DA #%10000000,#%01111000
			.DA #%10000000,#%01111000
			.DA #%10000000,#%01111000
			.DA #%10000000,#%01111000
			.DA #%10000000,#%01111000
			.DA #%10000000,#%01111000
			.DA #%10000000,#%01111000
			.DA #%10000000,#%01111000
			.DA #%11111111,#%01111111
*--------------------------------------
SPRITE3
			.HS 04,10,40
			.HS 66,19,66,19
			.HS 66,19,66,19
			.HS 66,19,66,19
			.HS 66,19,66,19
			.HS 66,19,66,19
			.HS 66,19,66,19
			.HS 66,19,66,19
			.HS 66,19,66,19
			.HS 66,19,66,19
			.HS 66,19,66,19
			.HS 66,19,66,19
			.HS 66,19,66,19
			.HS 66,19,66,19
			.HS 66,19,66,19
			.HS 66,19,66,19
			.HS 66,19,66,19
			.HS CC,33,4C,33
			.HS CC,33,4C,33
			.HS CC,33,4C,33
			.HS CC,33,4C,33
			.HS CC,33,4C,33
			.HS CC,33,4C,33
			.HS CC,33,4C,33
			.HS CC,33,4C,33
			.HS CC,33,4C,33
			.HS CC,33,4C,33
			.HS CC,33,4C,33
			.HS CC,33,4C,33
			.HS CC,33,4C,33
			.HS CC,33,4C,33
			.HS CC,33,4C,33
			.HS CC,33,4C,33
*--------------------------------------
PLAYER
* [["blck","blck","orge","orge","orge","blck","blck"],
* ["blck","blck","pink","pink","pink","blck","blck"],
* ["blck","blck","pink","pink","pink","blck","blck"],
* ["blck","blck","blck","gry2","blck","blck","blck"],
* ["blck","blck","ylow","ylow","ylow","blck","blck"],
* ["blck","ylow","ylow","ylow","ylow","ylow","blck"],
* ["blck","ylow","blck","ylow","blck","ylow","blck"],
* ["ylow","ylow","blck","ylow","blck","ylow","ylow"],
* ["ylow","blck","blck","ylow","blck","blck","ylow"],
* ["pink","blck","gry2","gry2","gry2","blck","pink"],
* ["blck","blck","mdbl","mdbl","mdbl","blck","blck"],
* ["blck","blck","mdbl","blck","mdbl","blck","blck"],
* ["blck","blck","mdbl","blck","mdbl","blck","blck"],
* ["blck","blck","mdbl","blck","mdbl","blck","blck"],
* ["blck","blck","mdbl","blck","mdbl","blck","blck"],
* ["blck","blck","mdbl","blck","mdbl","blck","blck"]]
			.HS 02,10,20
			.DA #%00000000,#%00110011
			.DA #%00000000,#%00110111
			.DA #%00000000,#%00110111
			.DA #%00000000,#%00000001
			.DA #%00000000,#%00111011
			.DA #%01100000,#%00111011
			.DA #%01100000,#%00000011
			.DA #%01101110,#%00000011
			.DA #%00001110,#%00000011
			.DA #%00001101,#%00010101
			.DA #%00000000,#%00001100
			.DA #%00000000,#%00001100
			.DA #%00000000,#%00001100
			.DA #%00000000,#%00001100
			.DA #%00000000,#%00001100
			.DA #%00000000,#%00001100
			.DA #%00011000,#%00000000
			.DA #%00111010,#%00000000
			.DA #%00111010,#%00000000
			.DA #%00100000,#%00000000
			.DA #%01011100,#%00000000
			.DA #%01011101,#%00000111
			.DA #%01000001,#%00000111
			.DA #%01000001,#%01110111
			.DA #%01000000,#%01110000
			.DA #%00101010,#%01101000
			.DA #%01100110,#%00000000
			.DA #%00000110,#%00000000
			.DA #%00000110,#%00000000
			.DA #%00000110,#%00000000
			.DA #%00000110,#%00000000
			.DA #%00000110,#%00000000

PLAYER2
			.HS 02,10,20
			.HS 00,04
			.HS 00,1D
			.HS 00,1D
			.HS 00,02
			.HS 00,0C
			.HS 30,4C
			.HS 30,40
			.HS 33,40
			.HS 03,00
			.HS 07,2A
			.HS 00,33
			.HS 00,30
			.HS 00,30
			.HS 00,30
			.HS 00,30
			.HS 00,30
			.HS A2,00
			.HS EE,00
			.HS EE,00
			.HS C0,00
			.HS E6,00
			.HS E6,01
			.HS E0,01
			.HS E0,19
			.HS E0,18
			.HS D4,38
			.HS 98,00
			.HS 98,00
			.HS 98,00
			.HS 98,00
			.HS 98,00
			.HS 98,00
*--------------------------------------
LETTER_A
			.HS 01,08,08
			.DA #%00000000
			.DA #%00000000
			.DA #%00111100
			.DA #%01100000
			.DA #%01111100
			.DA #%01000010
			.DA #%01111100
			.DA #%00000000
			.DA #%00000000
			.DA #%00000000
			.DA #%00000000
			.DA #%00000000
			.DA #%00000000
			.DA #%00000000
			.DA #%00000000
			.DA #%00000000
*--------------------------------------
MAN
SAVE /DEV/TILES/SRC/GFXTABLES.S
TEXT /DEV/TILES/TXT/GFXTABLES.S
