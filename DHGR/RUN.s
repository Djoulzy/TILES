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
;  0: Coord X
; +1: Coord Y
; +2: Speed X
; +3: Speed Y
; +4: Timer Default
; +5: Timer compter
; +6: Sprite def LO
; +7: Sprite def HI
PLYR_NFO    .HS 00,0C,00,00,00,00
            .DA #PLAYER,/PLAYER
OBJ1_NFO    .HS 24,06,00,01,00,00
            .DA #MONSTER,/MONSTER
OBJ2_NFO    .HS 20,06,00,81,00,00
            .DA #MONSTER,/MONSTER
OBJ3_NFO    .HS 1C,06,00,01,00,00
            .DA #MONSTER,/MONSTER
OBJ4_NFO    .HS 18,06,00,81,00,00
            .DA #MONSTER,/MONSTER
*--------------------------------------
MV_MONSTER
            LDY #$03                ; Lecture de speed Y
            LDA #$8F
            AND (SPRT_INF_LO),Y     ; On teste si speed X est negatif
            BEQ .04                 ; Si c'est zero : pas de mouvements
            BPL .06                 ; sinon on branche

            ; Decrementation de Y
            LDY #$01
            LDA (SPRT_INF_LO),Y     ; On charge Coord Y
            DEC
            TAX
            BNE .3                  ; On teste si on atteint le haut de l'écran
            LDA #$01                ; Oui, on passe Speed Y en positif
            JMP .2

            ; Incrementation de Y
.06         LDY #$01
            LDA (SPRT_INF_LO),Y     ; On charge Coord Y        
            INC
            TAX
            CMP #$B0                ; On teste si on atteint le bas de l'ecran
            BNE .3                  ; non, on sort 
            LDA #$81                ; Valeur negative pour Speed Y

.2          LDY #$03          
            STA (SPRT_INF_LO),Y     ; Sauvegarde de la nouvelle vitesse
.3          LDY #$01
            TXA
            STA (SPRT_INF_LO),Y     ; Sauvegarde de Coord Y
.4          JSR DRAW_SPRITE
            RTS

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
            LDA #OBJ1_NFO
            STA SPRT_INF_LO
            LDA /OBJ1_NFO
            STA SPRT_INF_HI
            JSR MV_SPRITE
            JSR DRAW_SPRITE

;            LDA #OBJ2_NFO
;            STA SPRT_INF_LO
;            LDA /OBJ2_NFO
;            STA SPRT_INF_HI
;            JSR MV_MONSTER
;
;            LDA #OBJ3_NFO
;            STA SPRT_INF_LO
;            LDA /OBJ3_NFO
;            STA SPRT_INF_HI
;            JSR MV_MONSTER
;
;            LDA #OBJ4_NFO
;            STA SPRT_INF_LO
;            LDA /OBJ4_NFO
;            STA SPRT_INF_HI
;            JSR MV_MONSTER

            JSR MV_PLAYER

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
