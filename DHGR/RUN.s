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
;  0: Coord X
; +1: Coord Y
; +2: Speed X
; +3: Speed Y
; +4: Timer Default
; +5: Timer compter
; +6: Sprite def LO
; +7: Sprite def HI
PLYR_NFO    .HS 00,00,00,00,00,00
            .DA #PLAYER,/PLAYER
OBJ1_NFO    .HS 00,00,00,00,FF,FF
            .DA #MONSTER,/MONSTER
*--------------------------------------
MV_SPRITE
            LDY #$05                ; Lecture du timer
            LDA (SPRT_INF_LO),Y
            BEQ .01
            DEC
            STA (SPRT_INF_LO),Y
            BNE END_MV_SPRITE       ; Test si le timer arrive à zero

.01         LDA #$00                ; On va tester si le sprite doit bouger
            LDY #$02                ; En regardant si Speed X ou Speed Y
            ORA (SPRT_INF_LO),Y     ; sont different de 0
            LDY #$03
            ORA (SPRT_INF_LO),Y
            BEQ END_MV_SPRITE       ; Si les deux sont à 0, on sort

            >GET_COORD
            >GET_SHAPE
            JSR DEL_ZONE
            >GET_COORD

            LDY #$04
            LDA (SPRT_INF_LO),Y
            LDY #$05
            STA (SPRT_INF_LO),Y     ; On reinitialise le timer

            ; Mouvement sur l'axe des X
            LDY #$02                ; Lecture de speed X
            LDA #$8F
            AND (SPRT_INF_LO),Y     ; On teste si speed X est negatif
            BEQ .03                 ; Si c'est zero : pas de mouvements
            BPL .05                 ; sinon on branche
            DEC SPRT_X
            JMP .03
.05         INC SPRT_X

            ; Mouvement sur l'axe des X
.03         LDY #$03                ; Lecture de speed X
            LDA #$8F
            AND (SPRT_INF_LO),Y     ; On teste si speed X est negatif
            BEQ .07                 ; Si c'est zero : pas de mouvements
            BPL .06                 ; sinon on branche
            DEC SPRT_Y
            JMP .07
.06         INC SPRT_Y

.07         >SAVE_COORD
                                
            LDA #$00
            LDY #$02
            STA (SPRT_INF_LO),Y     ; On reset Speed X
            LDY #$03
            STA (SPRT_INF_LO),Y     ; On reset Speed Y

END_MV_SPRITE
            RTS

RUN         JSR INIT
            LDA #$00
            JSR DHGR_CLR

GAMELOOP
            LDA #OBJ1_NFO
            STA SPRT_INF_LO
            LDA /OBJ1_NFO
            STA SPRT_INF_HI
            LDA #$81
            STA OBJ1_NFO+2
            JSR MV_SPRITE
            LDA SPRT_X
            BMI .1
            CMP #$26
            BNE .2
            STZ OBJ1_NFO
            JMP .2
.1          LDA #$24
            STA OBJ1_NFO
.2          JSR DRAW_SPRITE

            LDA #PLYR_NFO
            STA SPRT_INF_LO
            LDA /PLYR_NFO
            STA SPRT_INF_HI
            JSR MV_SPRITE
            JSR DRAW_SPRITE

            JSR READKEYB
            CMP #$15
            BEQ PLYR_RIGHT
            CMP #$08
            BEQ PLYR_LEFT
            CMP #$0A
            BEQ PLYR_DOWN
            CMP #$0B
            BEQ PLYR_UP

            JMP GAMELOOP

PLYR_RIGHT  INC PLYR_NFO+2
            JMP GAMELOOP

PLYR_LEFT   DEC PLYR_NFO+2
            JMP GAMELOOP

PLYR_DOWN   INC PLYR_NFO+3
            JMP GAMELOOP

PLYR_UP     DEC PLYR_NFO+3
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
