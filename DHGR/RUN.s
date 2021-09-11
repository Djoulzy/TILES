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
            LDA AN3             ;Turn on DHR
            STA ON80COL         ;Turn on 80 columns
            STA ON80STOR        ;Use PAGE1/PAGE2 to switch between MAIN and AUX
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
CORNER      LDA #%00001111
            STA PAGE2
            STA $2000
            STA $2002
            STA $2004
            RTS

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
;            JSR CORNER
    
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

;            LDA #$00
;            STA SPRT_X
;            STA SPRT_Y
;            LDX #$10            ; Nb total de bytes
;            LDY #$10            ; Nb lignes
;            LDA #$01            ; Nb bytes par ligne
;            JSR DEL_ZONE

            JSR READKEYB
            CMP #$15
            BEQ PLYR_RIGHT
            CMP #$08
            BEQ PLYR_LEFT
            JMP GAMELOOP

PLYR_RIGHT  LDA PLAYER_DESC
            STA SPRT_X
            LDA PLAYER_DESC+1
            STA SPRT_Y
            LDX #$20            ; Nb total de bytes
            LDY #$10            ; Nb lignes
            LDA #$02            ; Nb bytes par ligne
            JSR DEL_ZONE
            INC PLAYER_DESC
            JMP GAMELOOP

PLYR_LEFT   LDA #$02
            CLC
            ADC PLAYER_DESC
            STA SPRT_X
            LDA PLAYER_DESC+1
            STA SPRT_Y
            LDX #$20            ; Nb total de bytes
            LDY #$10            ; Nb lignes
            LDA #$02            ; Nb bytes par ligne
            JSR DEL_ZONE
            DEC PLAYER_DESC
            JMP GAMELOOP

GAMELOOPEND
            LDA #$03
            JSR $FDED
            RTS
*--------------------------------------
MAN
SAVE /DEV/TILES/SRC/RUN.S
TEXT /DEV/TILES/TXT/RUN.S

ASM
