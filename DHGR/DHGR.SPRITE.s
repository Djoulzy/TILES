NEW
    
AUTO 4,1
            .OP	65C02
            .LIST OFF
*			.OR	$800
*			.TF /DEV/TILES/OBJ/DHGR.SPRITE
*--------------------------------------
            .MA GET_SHAPE
            LDY SPRT_SHAPE_LO       ; Récupération du shape (pos 6 et 7)
            LDA (SPRT_INF_LO),Y
            STA SHAPE_LO
            INY
            LDA (SPRT_INF_LO),Y
            STA SHAPE_HI
            .EM
*--------------------------------------
            .MA GET_COORD       
            LDA (SPRT_INF_LO)       ; Récupération des coord (pos 0 et 1)
            STA SPRT_X
            LDY SPRT_COORD_Y
            LDA (SPRT_INF_LO),Y
            STA SPRT_Y
            .EM
*--------------------------------------
            .MA SAVE_COORD
            LDA SPRT_X
            STA (SPRT_INF_LO)       ; On stocke la nouvelle valeur de Coord X
            LDY SPRT_COORD_Y
            LDA SPRT_Y
            STA (SPRT_INF_LO),Y     ; On stocke la nouvelle valeur de Coord X
            .EM
*--------------------------------------
; Input:
; Coord zone    -> SPRT_X, SPRT_Y
; Shape address -> SHAPE_LO,SHAPE_HI
; 
; Output:
; void
DEL_ZONE   
            LDA (SHAPE_LO)      ; Lecture de nb de byte par ligne
			STA .02+1

            LDY #$02            ; Lecture de nb total de bytes
            LDA (SHAPE_LO),Y
            TAX

            LDY #$01
            LDA (SHAPE_LO),Y     ; Lecture de nb total de lignes

            CLC
            ADC SPRT_Y
            STA SPRT_Y

.01			DEC SPRT_Y
            LDY SPRT_Y          ; On cherche la position memoire de Y
			LDA HTAB_HI,Y		; Find the high byte of the row address
            STA .04+2           ; On réecrit l'instruction .4 et .6 pour placer
            STA .06+2           ; l'adresse du début de ligne 
			LDA HTAB_LO,Y		; Find the low byte of the row address
            CLC
            ADC SPRT_X
            STA .04+1           ; On réecrit l'instruction .4 et .6 pour placer
            STA .06+1           ; l'adresse du début de ligne 

.02			LDY #$AA
            DEY

.03			DEX
            BMI END_DEL_ZONE
            LDA #$00
            STA PAGE2           ; Bascule vers AUX
.04         STA $AAAA,Y
            STA PAGE1           ; Bascule vers MAIN
.06         STA $AAAA,Y
            DEY
            BMI	.01             ; Fin d'une ligne		
            JMP .03

END_DEL_ZONE
            RTS
*--------------------------------------
; Input:
; A: Nb lines 
; X: Total bytes
; Y: Nb bytes per line
; Coord zone    -> SPRT_X, SPRT_Y
;
; Output:
; void
FILL_AREA
            STY .02+1           ; Récriture (Nb bytes per line)

            CLC
            ADC SPRT_Y
            STA SPRT_Y

.01			DEC SPRT_Y
            LDY SPRT_Y          ; On cherche la position memoire de Y
			LDA HTAB_HI,Y		; Find the high byte of the row address
            STA .04+2           ; On réecrit l'instruction .4 et .6 pour placer
            STA .06+2           ; l'adresse du début de ligne 
			LDA HTAB_LO,Y		; Find the low byte of the row address
            CLC
            ADC SPRT_X
            STA .04+1           ; On réecrit l'instruction .4 et .6 pour placer
            STA .06+1           ; l'adresse du début de ligne 

.02			LDY #$AA
            DEY

.03			DEX
            BMI END_FILL_AREA
            LDA #$00
            STA PAGE2           ; Bascule vers AUX
.04         STA $AAAA,Y
            STA PAGE1           ; Bascule vers MAIN
.06         STA $AAAA,Y
            DEY
            BMI	.01             ; Fin d'une ligne		
            JMP .03

END_FILL_AREA
            RTS
*--------------------------------------
; Dessine une image en mode DHGR
;
; Input:
; Coord zone    -> SPRT_X, SPRT_Y
; Shape address -> SHAPE_LO,SHAPE_HI
; 
; Output:
; void
DRAW_SHAPE
            >GET_COORD
            LDA #$05            ; On va réécrire le code en AA avec l'adresse du sprite
            CLC                 ; à laquelle on ajoute le nb de byte par ligne
            ADC SHAPE_LO        ; On evite de lire directement l'adresse du sprite pour    
            STA .03+1           ; ne pas manipuler inutilement la pile
            LDA #$00            ; On additionne 3 pour sauté les byte qui definissent sa taille
            ADC SHAPE_HI
            STA .03+2           ; L'adresse AA devient : LDA SPRITE+3,X

            LDY #$02
            LDA (SHAPE_LO),Y    ; Meme chose pour les données du sprite pour la zone MAIN
            TAX                 ; Compteur du nombre de bytes composant le sprite
            CLC                 ; Du coup on lui additionne le nb total de byte de la zone AUX
            ADC #$05            ; + le poid de l'entete
            ADC SHAPE_LO        ; pour trouver le debut des data
            STA .05+1
            LDA #$00
            ADC SHAPE_HI
            STA .05+2           ; L'adresse BB devient : LDA SPRITE+nb+3,X

            LDY #$01            ; On recupère le nb de ligne du sprite
            LDA (SHAPE_LO),Y    ; On ajoute le nombre de ligne du sprite à la pos Y de départ
            CLC
            ADC SPRT_Y
            STA SPRT_Y

.01			DEC SPRT_Y
            LDY SPRT_Y          ; On cherche la position memoire de Y
			LDA HTAB_HI,Y		; Find the high byte of the row address
            STA .04+2           ; On réecrit l'instruction .4 et .6 pour placer
            STA .06+2           ; l'adresse du début de ligne 
			LDA HTAB_LO,Y		; Find the low byte of the row address
            CLC
            ADC SPRT_X
            STA .04+1           ; On réecrit l'instruction .4 et .6 pour placer
            STA .06+1           ; l'adresse du début de ligne 
        
            LDA (SHAPE_LO)      ; Mise en place du compteur de byte par ligne
            TAY                 ; Y sert de compteur
            DEY

.02			DEX
            CPX #$FF
            BEQ END_DRAW_SHAPE
.03			LDA $AAAA,X
            STA PAGE2           ; Bascule vers AUX
.04         STA $AAAA,Y         ; STA (SCRN_LO),Y
.05			LDA $AAAA,X
            STA PAGE1           ; Bascule vers MAIN
.06         STA $AAAA,Y         ; STA (SCRN_LO),Y
            DEY
            BMI	.01
            JMP	.02

END_DRAW_SHAPE
            RTS
*--------------------------------------
; Selectionne le shape en rapport avec la memoire MAIN ou AUX
;
; Input:
; #<desc_sprite> -> SPRT_INF_LO
; /<desc_sprite> -> SPRT_INF_HI
; 
; Output:
; void
DRAW_SPRITE
            >GET_SHAPE

            LDY SPRT_ACTIVE     ; Doit-on afficher le sprite ?
            LDA (SPRT_INF_LO),Y
            BNE .2              ; Sinon on sort
            RTS

.2          LDA (SPRT_INF_LO)
            AND #$01
            BEQ .1

            LDY #$03
            LDA (SHAPE_LO),Y
            TAX
            LDY #$04
            LDA (SHAPE_LO),Y
            STA SHAPE_HI
            STX SHAPE_LO

.1          JSR DRAW_SHAPE
            RTS
*--------------------------------------
; Procede au calcul de déplacement automatique du sprite selon une direction X ou Y
;
; Input:
; #<desc_sprite> -> SPRT_INF_LO
; /<desc_sprite> -> SPRT_INF_HI
; 
; Output:
; void
MV_SPRITE   LDA #$00                ; On va tester si le sprite doit bouger
            LDY SPRT_SPEED_X        ; En regardant si Speed X ou Speed Y
            ORA (SPRT_INF_LO),Y     ; sont different de 0
            LDY SPRT_SPEED_Y
            ORA (SPRT_INF_LO),Y
            BEQ END_MV_SPRITE       ; Si les deux sont à 0, on sort

            ; Mouvement sur l'axe des X
            LDA (SPRT_INF_LO)       ; Récupération de Coord X
            TAX                     ; On place le res dans X
            LDY SPRT_SPEED_X        ; Lecture de speed X
            LDA #$8F
            AND (SPRT_INF_LO),Y     ; On teste si speed X est negatif
            BEQ .04                 ; Si c'est zero : pas de mouvements
            BPL .02                 ; sinon on branche
            DEX
            JMP .03
.02         INX
.03         TXA
            STA (SPRT_INF_LO)       ; On stocke la nouvelle valeur de CoordX

            ; Mouvement sur l'axe des Y
.04         LDY SPRT_COORD_Y        ; Récupération de Coord Y
            LDA (SPRT_INF_LO),Y
            TAX                     ; On place le res dans X
            LDY SPRT_SPEED_Y        ; Lecture de speed Y
            LDA #$8F
            AND (SPRT_INF_LO),Y     ; On teste si speed Y est negatif
            BEQ END_MV_SPRITE       ; Si c'est zero : pas de mouvements
            BPL .06                 ; sinon on branche
            DEX
            JMP .07
.06         INX
.07         TXA
            LDY SPRT_COORD_Y
            STA (SPRT_INF_LO),Y     ; On stocke la nouvelle valeur de CoordY

END_MV_SPRITE
            RTS
*--------------------------------------
MAN
SAVE /DEV/TILES/SRC/DHGR.SPRITE.S
TEXT /DEV/TILES/TXT/DHGR.SPRITE.S
