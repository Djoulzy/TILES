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
            .INB /DEV/TILES/SRC/DIV7.S
*--------------------------------------
INIT        STA GRAPHON         ;Turn on graphics
            STA HIRESON         ;Turn on hi-res 
            STA FULLON          ;Turn on fullscreen
            STA DHRON           ;Turn on DHR
            STA ON80COL         ;Turn on 80 columns
            STA ON80STOR        ;Use PAGE1/PAGE2 to switch between MAIN and AUX
            RTS
*--------------------------------------
RUN         JSR INIT
            LDA #$00
            JSR DHGR_CLR

            LDA #SPRITE
            STA SPRT_LO
            LDA /SPRITE
            STA SPRT_HI
            LDA #$00
            STA SPRT_X
            LDA #$00            ; Coord Y du sprite
            STA SPRT_Y
            JSR DRW_SPRITE

            LDA #SPRITE2
            STA SPRT_LO
            LDA /SPRITE2
            STA SPRT_HI
            LDA #$00
            STA SPRT_X
            LDA #$00            ; Coord Y du sprite
            STA SPRT_Y
            JSR DRW_SPRITE

            LDA #SPRITE
            STA SPRT_LO
            LDA /SPRITE
            STA SPRT_HI
            LDA #$00
            STA SPRT_X
            LDA #$20            ; Coord Y du sprite
            STA SPRT_Y
            JSR DRW_SPRITE

;            LDA #$00
;            LDY #$7C            ; Coord X du sprite
;            JSR DIVMOD7YA
;            ASL
;            STA SPRT_X
;            LDA #$01
;            STA SPRT_X
;            LDA #$10            ; Coord Y du sprite
;            STA SPRT_Y
;            JSR DRW_SPRITE
;
;            LDA #$02
;            STA SPRT_X
;            LDA #$20            ; Coord Y du sprite
;            STA SPRT_Y
;            JSR DRW_SPRITE
;
;            LDA #$03
;            STA SPRT_X
;            LDA #$30            ; Coord Y du sprite
;            STA SPRT_Y
;            JSR DRW_SPRITE
;
;            LDA #$04
;            STA SPRT_X
;            LDA #$40            ; Coord Y du sprite
;            STA SPRT_Y
;            JSR DRW_SPRITE

            RTS
*--------------------------------------
MAN
SAVE /DEV/TILES/SRC/RUN.S
TEXT /DEV/TILES/TXT/RUN.S

ASM
