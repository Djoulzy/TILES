NEW
  
AUTO 4,1
			.LIST OFF
            .OP	65C02
*			.TF /DEV/TILES/OBJ/RUN
*--------------------------------------
            JMP RUN
*--------------------------------------
			.INB /DEV/TILES.HR/SRC/DEF.S
			.INB /DEV/TILES.HR/SRC/GFXTABLES.S
			.INB /DEV/TILES.HR/SRC/HR.TOOLS.S
			.INB /DEV/TILES.HR/SRC/HR.SPRITE.S
*--------------------------------------
			.MA WAITVBL
:1			BIT VBL
            BPL :1
:2			BIT VBL
            BMI :2
            .EM
*--------------------------------------
SPRITE1
	.HS 01,10,10
	.HS 08
	.HS 08
	.HS 0C
	.HS 14
	.HS 12
	.HS 21
	.HS 26
	.HS 48
	.HS 48
	.HS 27
	.HS 11
	.HS 08
	.HS 64
	.HS 24
	.HS 62
	.HS 12

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
            .DA #SPRITE1,/SPRITE1
PLYR_NFO2   .HS 01,00,00,00,00,00
            .DA #SPRITE1,/SPRITE1
*--------------------------------------
RUN         JSR INIT
            LDA #$00
            JSR HR_CLR

GAMELOOP
            LDA #SPRITE1
            STA SPRT_LO
            LDA /SPRITE1
            STA SPRT_HI
            LDA PLYR_NFO
            STA SPRT_X
            LDA PLYR_NFO+1
            STA SPRT_Y
            JSR DRW_SPRITE

;           LDA #SPRITE1
;           STA SPRT_LO
;           LDA /SPRITE1
;           STA SPRT_HI
;           LDA PLYR_NFO2
;           STA SPRT_X
;           LDA PLYR_NFO2+1
;           STA SPRT_Y
;           JSR DRW_SPRITE

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
