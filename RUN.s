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
PLAYER      .HS 00,00           ; Player X,Y
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
            JSR DHGR_CLR

GAMELOOP    
            LDA #SPRITE
            STA SPRT_LO
            LDA /SPRITE
            STA SPRT_HI
            LDA PLAYER
            STA SPRT_X
            LDA PLAYER+1
            STA SPRT_Y
            JSR DRW_SPRITE

            LDA #SPRITE3
            STA SPRT_LO
            LDA /SPRITE3
            STA SPRT_HI
            LDA PLAYER
            STA SPRT_X
            LDA PLAYER+1
            STA SPRT_Y
            JSR DRW_SPRITE

            LDA #$00
            STA SPRT_X
            STA SPRT_Y
            LDX #$40            ; Nb total de bytes
            LDY #$10            ; Nb lignes
            LDA #$04            ; Nb bytes par ligne
            JSR DEL_ZONE

;            JSR READKEYB
;            BRK
;            CMP #$51
;            BEQ GAMELOOPEND
;
;            JMP GAMELOOP
GAMELOOPEND
            LDA #$03
            JSR $FDED
            RTS
*--------------------------------------
MAN
SAVE /DEV/TILES/SRC/RUN.S
TEXT /DEV/TILES/TXT/RUN.S

ASM
