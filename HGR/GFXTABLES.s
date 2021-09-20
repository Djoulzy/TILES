NEW
  
AUTO 4,1
            .OP	65C02
            .LIST OFF
*			.OR	$6000
*			.TF /DEV/TILES.HR/OBJ/GFXTABLES
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
LETTER_A
			.HS 01,08,08
			.DA #%00000000
			.DA #%00000000
			.DA #%00011100
			.DA #%00100000
			.DA #%00111100
			.DA #%00100010
			.DA #%00111100
			.DA #%00000000
*--------------------------------------
; [["blck","blck","blck","blck","blck","blck","blck","blck","blck","blck","blck","blck","blck","blck"],
; ["blck","blck","blck","blck","blck","blck","blck","blck","blck","blck","blck","blck","blck","blck"],
; ["col2","col2","blck","blck","blck","blck","blck","blck","blck","blck","blck","blck","blck","blck"],
; ["whte","whte","col2","col2","col2","col2","col2","blck","blck","blck","blck","blck","blck","blck"],
; ["blck","whte","whte","whte","blck","blck","blck","blck","blck","blck","blck","blck","blck","blck"],
; ["blck","whte","whte","whte","whte","blck","blck","whte","whte","whte","blck","col1","blck","blck"],
; ["col2","blck","whte","whte","whte","whte","whte","whte","col1","col1","whte","whte","blck","blck"],
; ["col2","col2","whte","whte","whte","whte","whte","whte","whte","col1","col1","col2","col1","blck"],
; ["col2","col2","whte","whte","whte","whte","whte","whte","whte","col1","col1","col2","col1","blck"],
; ["col2","blck","whte","whte","whte","whte","whte","whte","col1","col1","whte","whte","blck","blck"],
; ["blck","whte","whte","whte","whte","blck","blck","whte","whte","whte","blck","col1","blck","blck"],
; ["blck","whte","whte","whte","blck","blck","blck","blck","blck","blck","blck","blck","blck","blck"],
; ["whte","whte","col2","col2","col2","col2","col2","blck","blck","blck","blck","blck","blck","blck"],
; ["col2","col2","blck","blck","blck","blck","blck","blck","blck","blck","blck","blck","blck","blck"],
; ["blck","blck","blck","blck","blck","blck","blck","blck","blck","blck","blck","blck","blck","blck"],
; ["blck","blck","blck","blck","blck","blck","blck","blck","blck","blck","blck","blck","blck","blck"]]
PLAYER
			.HS 04,10,40
			.HS 00,00,00,00
			.HS 00,00,00,00
			.HS 0A,00,00,00
			.HS 2F,55,00,00
			.HS 7C,01,00,00
			.HS 7C,07,3F,02
			.HS F2,7F,D7,07
			.HS FA,7F,DF,0C
			.HS FA,7F,DF,0C
			.HS F2,7F,D7,07
			.HS 7C,07,3F,02
			.HS 7C,01,00,00
			.HS 2F,55,00,00
			.HS 0A,00,00,00
			.HS 00,00,00,00
			.HS 00,00,00,00
*--------------------------------------
MAN
SAVE /DEV/TILES.HR/SRC/GFXTABLES.S
TEXT /DEV/TILES.HR/TXT/GFXTABLES.S
