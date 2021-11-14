NEW
    
AUTO 4,1
            .OP	65C02
            .LIST OFF
*			.OR	$800
*			.TF /DEV/TILES/OBJ/ENEMY
*--------------------------------------
OBJ1_NFO    .HS 24,06,00,01,00,00,01
            .DA #MONSTER1,/MONSTER1
OBJ2_NFO    .HS 20,30,00,82,00,00,01
            .DA #MONSTER1,/MONSTER1
OBJ3_NFO    .HS 1C,90,00,01,00,00,01
            .DA #MONSTER1,/MONSTER1
OBJ4_NFO    .HS 18,60,00,81,00,00,01
            .DA #MONSTER1,/MONSTER1

OBJ5_NFO    .HS 24,A4,00,01,00,00,01
            .DA #MONSTER2,/MONSTER2
OBJ6_NFO    .HS 20,74,00,82,00,00,01
            .DA #MONSTER2,/MONSTER2
OBJ7_NFO    .HS 1C,1A,00,01,00,00,01
            .DA #MONSTER2,/MONSTER2
OBJ8_NFO    .HS 18,44,00,81,00,00,01
            .DA #MONSTER2,/MONSTER2

NB_ENEMY    .HS 0F
ENEMY_LIST  .DA #OBJ1_NFO,/OBJ1_NFO,#OBJ2_NFO,/OBJ2_NFO,#OBJ3_NFO,/OBJ3_NFO,#OBJ4_NFO,/OBJ4_NFO
            .DA #OBJ5_NFO,/OBJ5_NFO,#OBJ6_NFO,/OBJ6_NFO,#OBJ7_NFO,/OBJ7_NFO,#OBJ8_NFO,/OBJ8_NFO
*--------------------------------------
MV_MONSTER
            LDY SPRT_SPEED_Y        ; Lecture de speed Y
            LDA #$8F
            AND (SPRT_INF_LO),Y     ; On teste si speed X est negatif
            BEQ .04                 ; Si c'est zero : pas de mouvements
            BPL .06                 ; sinon on branche

            ; Decrementation de Y
            LDY SPRT_COORD_Y
            LDA (SPRT_INF_LO),Y     ; On charge Coord Y
            DEC
            DEC
            TAX
            BNE .3                  ; On teste si on atteint le haut de l'écran
            LDA #$01                ; Oui, on passe Speed Y en positif
            JMP .2

            ; Incrementation de Y
.06         LDY SPRT_COORD_Y
            LDA (SPRT_INF_LO),Y     ; On charge Coord Y        
            INC
            INC
            TAX
            CMP #$B0                ; On teste si on atteint le bas de l'ecran
            BNE .3                  ; non, on sort 
            LDA #$81                ; Valeur negative pour Speed Y

.2          LDY SPRT_SPEED_Y          
            STA (SPRT_INF_LO),Y     ; Sauvegarde de la nouvelle vitesse
.3          LDY SPRT_COORD_Y
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
            
            LDY SPRT_ACTIVE
            LDA (SPRT_INF_LO),Y
            BEQ .02
            JSR COLLISION
            JSR MV_MONSTER

.02         PLY
            BPL .01
            RTS
*--------------------------------------
COLLISION
            LDY NB_SHOOT
.01         LDA SHOOT_LIST,Y
            STA SPRT2_INF_HI
            DEY
            LDA SHOOT_LIST,Y
            STA SPRT2_INF_LO
            DEY
            PHY

            LDY SPRT_ACTIVE
            LDA (SPRT2_INF_LO),Y    ; Le shoot est il actif ?
            BEQ END_COLLISION

            LDY SPRT_COORD_X
            LDA (SPRT_INF_LO),Y     ; Coord X du sprite
            LDY SPRT_COLLIS_X
            CMP (SPRT2_INF_LO),Y    ; comp avec Coord X du shoot
            BCS END_COLLISION       ; X_Sprite > X_Shoot
            CLC
            ADC #$04                ; X_Sprite + 4 octects (fin du sprite)
            CMP (SPRT2_INF_LO),Y    ; comp avec Coord X du shoot
            BCC END_COLLISION       ; X_Shoot > X_Sprite+4

            LDY SPRT_COORD_Y
            LDA (SPRT_INF_LO),Y     ; Coord Y du sprite
            LDY SPRT_COLLIS_Y
            CMP (SPRT2_INF_LO),Y    ; comp avec Coord X du shoot
            BCS END_COLLISION       ; Y_Sprite > Y_Shoot
            CLC
            ADC #$0F                ; Y_Sprite + 15 lignes (fin du sprite)
            CMP (SPRT2_INF_LO),Y    ; comp avec Coord Y du shoot
            BCC END_COLLISION       ; Y_Shoot > Y_Sprite+15

            LDA #$00
            LDY SPRT_ACTIVE
            STA (SPRT2_INF_LO),Y
            STA (SPRT_INF_LO),Y

            PLY
            BPL .01
            RTS
END_COLLISION            
            PLY
            RTS
*--------------------------------------
MAN
SAVE /DEV/TILES/SRC/ENEMY.S
TEXT /DEV/TILES/TXT/ENEMY.S
