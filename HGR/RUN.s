NEW
  
AUTO 4,1
			.LIST OFF
            .OP	65C02
*			.TF /DEV/TILES.HR/OBJ/RUN
*--------------------------------------
            JMP RUN
*--------------------------------------
			.INB /DEV/TILES.HR/SRC/DEF.S
			.INB /DEV/TILES.HR/SRC/GFXTABLES.S
			.INB /DEV/TILES.HR/SRC/HR.TOOLS.S
			.INB /DEV/TILES.HR/SRC/HR.SPRITE.S
*           .INB /DEV/TILES.HR/SRC/DIV7.S
*--------------------------------------
INIT        STA GRAPHON         ;Turn on graphics
            STA HIRESON         ;Turn on hi-res 
            STA FULLON          ;Turn on fullscreen
            RTS
*--------------------------------------
			.MA WAITVBL
:1			BIT VBL
            BPL :1
:2			BIT VBL
            BMI :2
            .EM
*--------------------------------------
PLAYER_DESC .HS 00,01           ; Player X,Y
*--------------------------------------
CLRKBD      LDA #$00
            STA $C000
            STA $C010
            RTS

READKEYB    LDA $C000
            BPL READKEYB
            AND #$7F
            STA STROBE
            RTS

RUN         JSR INIT
            LDA #$00
            JSR HR_CLR

GAMELOOP    
            LDA #PLAYER
            STA SPRT_LO
            LDA /PLAYER
            STA SPRT_HI
            LDA PLAYER_DESC
            STA SPRT_X
            LDA PLAYER_DESC+1
            STA SPRT_Y
            JSR DRW_SPRITE

;            LDA #LETTER_A
;            STA SPRT_LO
;            LDA /LETTER_A
;            STA SPRT_HI
;            LDA PLAYER_DESC
;            STA SPRT_X
;            LDA PLAYER_DESC+1
;            STA SPRT_Y
;            JSR DRW_SPRITE
            RTS
*--------------------------------------
MAN
SAVE /DEV/TILES.HR/SRC/RUN.S
TEXT /DEV/TILES.HR/TXT/RUN.S

ASM
