NEW
    
AUTO 4,1
            .OP	65C02
            .LIST OFF
*			.OR	$800
*			.TF /DEV/TILES/OBJ/ENEMY
*--------------------------------------
OBJ1_NFO    .HS 24,06,00,01,00,00
            .DA #MONSTER,/MONSTER
OBJ2_NFO    .HS 20,06,00,81,00,00
            .DA #MONSTER,/MONSTER
OBJ3_NFO    .HS 1C,06,00,01,00,00
            .DA #MONSTER,/MONSTER
OBJ4_NFO    .HS 18,06,00,81,00,00
            .DA #MONSTER,/MONSTER

NB_ENEMY    .HS 07
ENEMY_LIST  .DA #OBJ1_NFO,/OBJ1_NFO,#OBJ2_NFO,/OBJ2_NFO,#OBJ3_NFO,/OBJ3_NFO,#OBJ4_NFO,/OBJ4_NFO
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
*--------------------------------------
ENEMY
            LDY NB_ENEMY

.01         LDA ENEMY_LIST,Y
            STA SPRT_INF_HI
            DEY
            LDA ENEMY_LIST,Y
            STA SPRT_INF_LO
            DEY
            PHY
            JSR MV_MONSTER
            PLY
            BPL .01
            RTS
*--------------------------------------
MAN
SAVE /DEV/TILES/SRC/ENEMY.S
TEXT /DEV/TILES/TXT/ENEMY.S
