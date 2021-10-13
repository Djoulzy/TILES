NEW
  
AUTO 4,1
			.LIST OFF
            .OP	65C02
*			.TF /DEV/TILES/OBJ/RUN
*--------------------------------------
            JMP RUN
*--------------------------------------
			.INB /DEV/TILES/SRC/DEF.S
			.INB /DEV/TILES/SRC/GFXTABLES.S
			.INB /DEV/TILES/SRC/DHGR.TOOLS.S
			.INB /DEV/TILES/SRC/DHGR.SPRITE.S
*--------------------------------------
			.MA WAITVBL
:1			BIT VBL
            BPL :1
:2			BIT VBL
            BMI :2
            .EM
*--------------------------------------
PLANET
	.HS 06,20,C0
	.DA #PLANET_ALT,/PLANET_ALT
	.HS 4F,33
	.HS 00,00
	.HS 00,00
	.HS 70,28
	.HS 0A,00
	.HS 00,28
	.HS 0F,00
	.HS 00,00
	.HS 00,2A
	.HS 00,00
	.HS 00,00
	.HS 20,02
	.HS 00,02
	.HS 20,28
	.HS 00,00
	.HS 00,00
	.HS 00,00
	.HS 00,00
	.HS 00,02
	.HS 00,00
	.HS 0A,00
	.HS 00,2A
	.HS 00,00
	.HS 00,00
	.HS 00,02
	.HS 0A,28
	.HS 00,00
	.HS 00,2A
	.HS 00,00
	.HS 00,02
	.HS 00,02
	.HS 0A,00
	.HS 00,00
	.HS 00,2A
	.HS 00,00
	.HS 00,00
	.HS 00,28
	.HS 00,28
	.HS 00,00
	.HS 00,28
	.HS 0A,00
	.HS 00,70
	.HS 00,28
	.HS 20,02
	.HS 20,73
	.HS 00,28
	.HS 0A,28
	.HS 00,47
	.HS 00,28
	.HS 20,00
	.HS 0A,24
	.HS 00,26
	.HS 0A,02
	.HS 40,26
	.HS 00,32
	.HS 0A,28
	.HS 1C,02
	.HS 00,02
	.HS 2A,2A
	.HS 11,00
	.HS 00,00
	.HS 2A,00
	.HS 19,02
	.HS 10,00
	.HS 0A,6A
	.HS 09,00
	.HS 10,00
	.HS 20,47
	.HS 20,02
	.HS 1C,00
	.HS 00,44
	.HS 0A,28
	.HS 49,00
	.HS 4A,64
	.HS 0A,02
	.HS 49,00
	.HS 1C,26
	.HS 20,02
	.HS 19,33
	.HS 11,02
	.HS 2A,28
	.HS 19,44
	.HS 11,00
	.HS 0A,28
	.HS 10,44
	.HS 09,00
	.HS 2A,02
	.HS 00,2A
	.HS 00,00
	.HS 20,00
	.HS 00,00
	.HS 00,00
	.HS 00,2A
	.HS 00,00
	.HS 00,00
	.HS 00,00
	.HS 75,7E
	.HS 1E,05
	.HS 1E,55
	.HS 15,00
	.HS 00,50
	.HS 00,05
	.HS 14,00
	.HS 00,00
	.HS 40,00
	.HS 14,00
	.HS 00,00
	.HS 4B,00
	.HS 54,05
	.HS 01,00
	.HS 00,00
	.HS 14,50
	.HS 00,00
	.HS 00,05
	.HS 54,00
	.HS 00,00
	.HS 00,00
	.HS 40,00
	.HS 00,00
	.HS 00,00
	.HS 40,05
	.HS 00,00
	.HS 00,00
	.HS 40,00
	.HS 00,00
	.HS 40,60
	.HS 40,05
	.HS 00,50
	.HS 00,60
	.HS 40,00
	.HS 14,00
	.HS 00,0E
	.HS 00,55
	.HS 00,00
	.HS 00,0E
	.HS 00,00
	.HS 00,00
	.HS 00,48
	.HS 00,55
	.HS 41,00
	.HS 01,48
	.HS 00,05
	.HS 14,00
	.HS 18,04
	.HS 00,55
	.HS 01,05
	.HS 38,00
	.HS 40,05
	.HS 40,50
	.HS 23,50
	.HS 20,56
	.HS 14,05
	.HS 22,00
	.HS 34,50
	.HS 41,50
	.HS 12,05
	.HS 12,00
	.HS 15,0E
	.HS 41,50
	.HS 01,00
	.HS 40,08
	.HS 00,00
	.HS 01,00
	.HS 15,48
	.HS 41,05
	.HS 01,00
	.HS 22,04
	.HS 14,00
	.HS 01,00
	.HS 23,54
	.HS 40,50
	.HS 19,00
	.HS 22,05
	.HS 41,05
	.HS 18,66
	.HS 32,05
	.HS 15,50
	.HS 22,08
	.HS 13,50
	.HS 00,05
	.HS 33,48
	.HS 00,00
	.HS 41,50
	.HS 54,05
	.HS 00,00
	.HS 15,55
	.HS 00,00
	.HS 00,00
	.HS 40,05
	.HS 00,00
	.HS 00,00
	.HS 00,78

PLANET_ALT
	.HS 06,20,C0
	.DA #PLANET,/PLANET
	.HS 3F,4F
	.HS 00,00
	.HS 00,00
	.HS 70,28
	.HS 0A,00
	.HS 00,28
	.HS 0F,00
	.HS 00,00
	.HS 00,2A
	.HS 00,00
	.HS 00,00
	.HS 20,02
	.HS 00,02
	.HS 20,28
	.HS 00,00
	.HS 00,00
	.HS 00,00
	.HS 00,00
	.HS 00,02
	.HS 00,00
	.HS 0A,00
	.HS 00,2A
	.HS 00,00
	.HS 00,00
	.HS 00,02
	.HS 0A,28
	.HS 00,00
	.HS 00,2A
	.HS 00,00
	.HS 00,02
	.HS 00,02
	.HS 0A,00
	.HS 00,00
	.HS 00,2A
	.HS 00,00
	.HS 00,40
	.HS 00,28
	.HS 00,28
	.HS 00,40
	.HS 00,28
	.HS 0A,00
	.HS 00,0C
	.HS 00,28
	.HS 20,02
	.HS 20,0C
	.HS 00,28
	.HS 0A,28
	.HS 00,10
	.HS 00,28
	.HS 20,00
	.HS 0A,19
	.HS 00,1A
	.HS 0A,02
	.HS 30,19
	.HS 00,4D
	.HS 0A,28
	.HS 43,01
	.HS 00,01
	.HS 2A,2A
	.HS 44,00
	.HS 00,00
	.HS 2A,40
	.HS 66,02
	.HS 60,00
	.HS 0A,2A
	.HS 06,00
	.HS 60,00
	.HS 20,10
	.HS 20,02
	.HS 63,00
	.HS 00,11
	.HS 0A,28
	.HS 36,00
	.HS 3A,19
	.HS 0A,02
	.HS 36,00
	.HS 43,19
	.HS 20,02
	.HS 46,4C
	.HS 44,01
	.HS 2A,28
	.HS 46,11
	.HS 64,00
	.HS 0A,28
	.HS 60,11
	.HS 06,00
	.HS 2A,02
	.HS 00,2A
	.HS 00,00
	.HS 20,00
	.HS 00,00
	.HS 00,00
	.HS 00,2A
	.HS 00,00
	.HS 00,00
	.HS 00,00
	.HS 74,79
	.HS 1E,05
	.HS 1E,55
	.HS 15,00
	.HS 00,50
	.HS 00,05
	.HS 14,00
	.HS 00,00
	.HS 40,00
	.HS 14,00
	.HS 00,00
	.HS 4B,00
	.HS 54,05
	.HS 01,00
	.HS 00,00
	.HS 14,50
	.HS 00,00
	.HS 00,05
	.HS 54,00
	.HS 00,00
	.HS 00,00
	.HS 40,00
	.HS 00,00
	.HS 00,00
	.HS 40,05
	.HS 00,00
	.HS 00,00
	.HS 40,00
	.HS 00,00
	.HS 40,18
	.HS 40,05
	.HS 00,50
	.HS 00,18
	.HS 40,00
	.HS 14,00
	.HS 00,21
	.HS 00,55
	.HS 00,00
	.HS 00,21
	.HS 00,00
	.HS 00,00
	.HS 00,32
	.HS 00,55
	.HS 41,00
	.HS 61,32
	.HS 00,05
	.HS 14,00
	.HS 66,03
	.HS 00,55
	.HS 01,05
	.HS 06,00
	.HS 40,05
	.HS 40,50
	.HS 48,50
	.HS 40,51
	.HS 14,05
	.HS 48,00
	.HS 54,50
	.HS 41,50
	.HS 0C,05
	.HS 0C,00
	.HS 15,21
	.HS 40,50
	.HS 00,00
	.HS 40,22
	.HS 00,00
	.HS 00,00
	.HS 75,32
	.HS 41,05
	.HS 00,00
	.HS 08,03
	.HS 14,00
	.HS 00,00
	.HS 08,53
	.HS 40,50
	.HS 06,00
	.HS 48,05
	.HS 41,05
	.HS 66,19
	.HS 4C,05
	.HS 15,50
	.HS 08,22
	.HS 0C,50
	.HS 00,05
	.HS 0C,32
	.HS 00,00
	.HS 41,50
	.HS 54,05
	.HS 00,00
	.HS 15,55
	.HS 00,00
	.HS 00,00
	.HS 40,05
	.HS 00,00
	.HS 00,00
	.HS 00,78

*--------------------------------------
;  0: Coord X
; +1: Coord Y
; +2: Speed X
; +3: Speed Y
; +4: Timer Default
; +5: Timer compter
; +6: Sprite def LO
; +7: Sprite def HI
PLYR_NFO    .HS 00,00,00,00,00,00
            .DA #PLANET,/PLANET
*--------------------------------------
RUN         JSR INIT
            LDA #$00
            JSR DHGR_CLR

;            LDA #$B0
;            STA MODULO
;            JSR RANDOM
;            STA OBJ1_NFO+1
;
;            LDA #$B0
;            STA MODULO
;            JSR RANDOM
;            STA OBJ2_NFO+1
;
;            LDA #$B0
;            STA MODULO
;            JSR RANDOM
;            STA OBJ3_NFO+1

GAMELOOP
            LDA #PLYR_NFO
            STA SPRT_INF_LO
            LDA /PLYR_NFO
            STA SPRT_INF_HI
            JSR DRAW_SPRITE
            JMP GAMELOOP

GAMELOOPEND
            LDA #$03
            JSR $FDED
            RTS
*--------------------------------------
MAN
SAVE /DEV/TILES/SRC/TEST.S
TEXT /DEV/TILES/TXT/TEST.S

ASM
