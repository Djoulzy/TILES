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
PLAYER
; [["blck","blck","brwn","brwn","brwn","blck","blck"],["blck","blck","brwn","pink","brwn","blck","blck"],
; ["blck","blck","brwn","pink","brwn","blck","blck"],["blck","blck","blck","vilt","blck","blck","whte"],
; ["blck","blck","ylow","ylow","ylow","gry2","whte"],["blck","ylow","ylow","ylow","gry2","gry1","blck"],
; ["blck","ylow","ylow","gry2","gry1","ylow","blck"],["ylow","ylow","gry2","pink","ylow","ylow","blck"],
; ["gry2","gry2","gry1","ylow","ylow","blck","blck"],["pink","gry2","gry1","gry1","gry1","blck","blck"],
; ["blck","gry2","mdbl","mdbl","mdbl","blck","blck"],["blck","blck","mdbl","mdbl","mdbl","blck","blck"],
; ["blck","blck","mdbl","blck","mdbl","blck","blck"],["blck","blck","mdbl","blck","mdbl","blck","blck"],
; ["blck","blck","mdbl","blck","mdbl","blck","blck"],["blck","blck","mdbl","blck","mdbl","blck","blck"]]
			.HS 02,10,20
			.DA #PLAYER2,/PLAYER2
			.HS 00,11
			.HS 00,13
			.HS 00,13
			.HS 00,02
			.HS 00,7B
			.HS 60,17
			.HS 60,29
			.HS 6E,3B
			.HS 55,3B
			.HS 5D,2A
			.HS 50,0C
			.HS 00,0C
			.HS 00,0C
			.HS 00,0C
			.HS 00,0C
			.HS 00,0C
			.HS 08,00
			.HS 28,00
			.HS 28,00
			.HS 20,78
			.HS 5C,7A
			.HS 5D,05
			.HS 3D,07
			.HS 2B,07
			.HS 54,00
			.HS 54,00
			.HS 66,00
			.HS 66,00
			.HS 06,00
			.HS 06,00
			.HS 06,00
			.HS 06,00

PLAYER2
			.HS 02,10,20
			.DA #PLAYER,/PLAYER
			.HS 00,44
			.HS 00,4D
			.HS 00,4D
			.HS 00,09
			.HS 00,6E
			.HS 00,5E
			.HS 00,25
			.HS 38,6D
			.HS 54,6E
			.HS 74,2A
			.HS 40,33
			.HS 00,33
			.HS 00,30
			.HS 00,30
			.HS 00,30
			.HS 00,30
			.HS 20,00
			.HS 20,00
			.HS 20,00
			.HS 00,60
			.HS 70,6B
			.HS 77,14
			.HS 77,1D
			.HS 2F,1D
			.HS 52,01
			.HS 52,01
			.HS 1A,00
			.HS 18,00
			.HS 18,00
			.HS 18,00
			.HS 18,00
			.HS 18,00
*--------------------------------------
MONSTER
			.HS 04,10,40
			.DA #MONSTER2,/MONSTER2
			.HS 00,00,00,00
			.HS 00,00,01,00
			.HS 00,40,11,00
			.HS 00,44,11,00
			.HS 00,04,11,04
			.HS 00,70,41,07
			.HS 00,72,46,47
			.HS 10,28,66,46
			.HS 00,18,66,05
			.HS 00,68,2A,28
			.HS 00,0C,33,0C
			.HS 00,0C,33,0C
			.HS 00,00,00,40
			.HS 00,40,00,40
			.HS 00,24,00,02
			.HS 00,00,00,00
			.HS 00,00,00,00
			.HS 00,00,00,00
			.HS 00,08,02,00
			.HS 00,08,22,00
			.HS 20,0E,38,00
			.HS 22,67,1F,00
			.HS 42,67,1F,00
			.HS 22,36,58,00
			.HS 22,33,4C,00
			.HS 20,51,35,00
			.HS 00,05,74,00
			.HS 60,00,00,00
			.HS 06,18,06,01
			.HS 12,01,06,04
			.HS 12,00,32,00
			.HS 00,00,00,00
MONSTER2
			.HS 04,10,40
			.DA #MONSTER,/MONSTER
			.HS 00,00,00,00
			.HS 00,00,04,00
			.HS 00,00,44,00
			.HS 00,10,44,01
			.HS 00,11,44,11
			.HS 00,41,04,1C
			.HS 00,4A,18,1C
			.HS 40,21,18,1A
			.HS 00,61,18,16
			.HS 00,21,28,21
			.HS 00,30,4C,33
			.HS 00,33,4C,30
			.HS 00,00,00,00
			.HS 00,00,00,00
			.HS 00,10,00,09
			.HS 00,00,00,00
			.HS 00,00,00,00
			.HS 00,00,00,00
			.HS 00,22,08,00
			.HS 00,22,08,00
			.HS 00,38,60,00
			.HS 08,1F,7E,00
			.HS 08,1F,7E,02
			.HS 08,59,63,02
			.HS 08,4C,33,00
			.HS 00,47,55,01
			.HS 00,14,51,00
			.HS 00,00,01,00
			.HS 18,60,18,06
			.HS 48,06,18,12
			.HS 48,01,48,00
			.HS 00,00,00,00
*--------------------------------------
LETTER_A
			.HS 01,08,08
			.DA #%00000000
			.DA #%00000000
			.DA #%01110000
			.DA #%00000000
			.DA #%01110000
			.DA #%00001100
			.DA #%01110000
			.DA #%00000000
			.DA #%00000000
			.DA #%00000000
			.DA #%00000111
			.DA #%00011000
			.DA #%00011111
			.DA #%00011000
			.DA #%00011111
			.DA #%00000000
*--------------------------------------
STAR
			.HS 02,01,02
			.DA #STAR2,/STAR2
			.DA #%01100000,#%00000000
			.DA #%01100000,#%00000000
STAR2
			.HS 02,01,02
			.DA #STAR,/STAR
			.DA #%01100000,#%00000000
			.DA #%01100000,#%00000000
*--------------------------------------

PLANET
			.HS 06,10,60
			.DA #PLANET,/PLANET
			.HS 3C,70,00,50,00,00
			.HS 7C,00,00,00,14,00
			.HS 7C,00,14,00,00,00
			.HS 7C,00,7C,00,00,00
			.HS 7C,00,7C,70,00,00
			.HS 40,70,00,00,00,00
			.HS 40,75,00,00,00,00
			.HS 00,75,14,00,00,00
			.HS 00,05,00,00,00,00
			.HS 00,55,00,00,00,05
			.HS 00,5F,7C,00,00,00
			.HS 00,70,00,05,14,50
			.HS 00,70,3C,05,00,00
			.HS 00,70,3C,00,00,05
			.HS 00,70,00,00,40,70
			.HS 00,6F,54,0F,14,6F
			.HS 00,3F,00,20,00,00
			.HS 07,3E,28,7E,00,00
			.HS 02,7E,00,3E,00,00
			.HS 7A,00,02,1E,00,00
			.HS 7A,00,2F,01,00,00
			.HS 7F,21,00,00,00,00
			.HS 2F,01,00,00,00,00
			.HS 78,1F,00,00,00,00
			.HS 78,00,00,00,00,00
			.HS 78,1E,00,00,00,0A
			.HS 00,6A,02,20,00,60
			.HS 00,0B,00,00,28,60
			.HS 00,0B,00,20,00,7E
			.HS 00,3F,78,0A,00,5E
			.HS 00,3F,78,0A,02,7D
			.HS 00,7F,07,00,00,7F

PLANET2
			.HS 06,10,60
			.DA #PLANET2,/PLANET2
			.HS 40,7E,7C,70,00,0E
			.HS 40,7F,40,0F,40,7F
			.HS 3C,70,40,00,3C,4C
			.HS 3C,7E,7C,7F,38,70
			.HS 7C,6E,00,6E,30,7F
			.HS 40,4C,38,4F,70,00
			.HS 40,7F,30,7C,7C,50
			.HS 00,7F,7C,7F,14,0F
			.HS 00,00,00,00,54,50
			.HS 00,00,00,00,7C,00
			.HS 00,00,00,00,40,70
			.HS 00,00,00,00,40,55
			.HS 00,00,00,00,00,7F
			.HS 00,00,00,00,00,00
			.HS 00,00,00,00,00,00
			.HS 00,00,00,00,00,00
			.HS 7F,01,02,1F,78,1E
			.HS 77,01,2F,00,77,79
			.HS 76,01,2F,60,7F,61
			.HS 06,7F,7F,7F,60,1F
			.HS 67,01,70,5D,60,01
			.HS 07,79,7F,01,7F,00
			.HS 7F,1F,66,7F,07,20
			.HS 00,61,7F,7F,00,00
			.HS 00,7E,00,60,02,3E
			.HS 00,00,00,00,7A,00
			.HS 00,00,00,00,2F,61
			.HS 00,00,00,00,7F,1E
			.HS 00,00,00,00,00,2B
			.HS 00,00,00,00,00,7E
			.HS 00,00,00,00,00,00
			.HS 00,00,00,00,00,00

*--------------------------------------
MAN
SAVE /DEV/TILES/SRC/GFXTABLES.S
TEXT /DEV/TILES/TXT/GFXTABLES.S
