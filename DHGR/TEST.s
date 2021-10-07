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
			.INB /DEV/TILES/SRC/RND.S
			.INB /DEV/TILES/SRC/DHGR.SPRITE.S
            .INB /DEV/TILES/SRC/PLAYER.S
*--------------------------------------
			.MA WAITVBL
:1			BIT VBL
            BPL :1
:2			BIT VBL
            BMI :2
            .EM
*--------------------------------------
NAME
    .HS 02,10,20
    .DA #NAME_ALT,/NAME_ALT
    .DA #%00001000,#%00100010
    .DA #%00001000,#%00100010
    .DA #%01000100,#%00010001
    .DA #%01000100,#%00010001
    .DA #%01001100,#%00110011
    .DA #%01001100,#%00110011
    .DA #%00100010,#%00001000
    .DA #%00100010,#%00001000
    .DA #%00101010,#%00101010
    .DA #%00101010,#%00101010
    .DA #%01100110,#%00011001
    .DA #%01100110,#%00011001
    .DA #%01101110,#%00111011
    .DA #%01101110,#%00111011
    .DA #%00010001,#%01000100
    .DA #%00010001,#%01000100
    .DA #%00010001,#%01000100
    .DA #%00010001,#%01000100
    .DA #%00001000,#%00100010
    .DA #%00001000,#%00100010
    .DA #%00011001,#%01100110
    .DA #%00011001,#%01100110
    .DA #%01000100,#%00010001
    .DA #%01000100,#%00010001
    .DA #%01010101,#%01010101
    .DA #%01010101,#%01010101
    .DA #%01001100,#%00110011
    .DA #%01001100,#%00110011
    .DA #%01011101,#%01110111
    .DA #%01011101,#%01110111
    .DA #%00100010,#%00001000
    .DA #%00100010,#%00001000

NAME_ALT
    .HS 02,10,20
    .DA #NAME,/NAME
    .DA #%00100010,#%00001000
    .DA #%00100010,#%00001000
    .DA #%00010001,#%01000100
    .DA #%00010001,#%01000100
    .DA #%01110111,#%01011101
    .DA #%01110111,#%01011101
    .DA #%00010001,#%01000100
    .DA #%00010001,#%01000100
    .DA #%00101010,#%00101010
    .DA #%00101010,#%00101010
    .DA #%00011001,#%01100110
    .DA #%00011001,#%01100110
    .DA #%00111011,#%01101110
    .DA #%00111011,#%01101110
    .DA #%00001000,#%00100010
    .DA #%00001000,#%00100010
    .DA #%01000100,#%00010001
    .DA #%01000100,#%00010001
    .DA #%00100010,#%00001000
    .DA #%00100010,#%00001000
    .DA #%01101110,#%00111011
    .DA #%01101110,#%00111011
    .DA #%00100010,#%00001000
    .DA #%00100010,#%00001000
    .DA #%01010101,#%01010101
    .DA #%01010101,#%01010101
    .DA #%00110011,#%01001100
    .DA #%00110011,#%01001100
    .DA #%01110111,#%01011101
    .DA #%01110111,#%01011101
    .DA #%00010001,#%01000100
    .DA #%00010001,#%01000100
*--------------------------------------
;  0: Coord X
; +1: Coord Y
; +2: Speed X
; +3: Speed Y
; +4: Timer Default
; +5: Timer compter
; +6: Sprite def LO
; +7: Sprite def HI
PLYR_NFO    .HS 00,0C,00,00,00,00
            .DA #NAME,/NAME
*--------------------------------------
RUN         JSR INIT
            JSR RESEED
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
            JSR MV_PLAYER

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
