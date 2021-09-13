NEW
    
AUTO 4,1
            .OP	65C02
            .LIST OFF
*			.OR	$800
*			.TF /DEV/TILES/OBJ/DHGR.SPRITE
*--------------------------------------
            .MA GET_SHAPE
            LDY #$06                ; Récupération du shape (pos 6 et 7)
            LDA (SPRT_INF_LO),Y
            STA SPRT_LO
            INY
            LDA (SPRT_INF_LO),Y
            STA SPRT_HI
            .EM
*--------------------------------------
            .MA GET_COORD
            LDY #$00                ; Récupération des coord (pos 0 et 1)
            LDA (SPRT_INF_LO),Y
            STA SPRT_X
            INY
            LDA (SPRT_INF_LO),Y
            STA SPRT_Y
            .EM
*--------------------------------------
            .MA SAVE_COORD
            LDY #$00
            LDA SPRT_X
            STA (SPRT_INF_LO),Y     ; On stocke la nouvelle valeur de Coord X
            INY
            LDA SPRT_Y
            STA (SPRT_INF_LO),Y     ; On stocke la nouvelle valeur de Coord X
            .EM
*--------------------------------------
; Coord zone -> SPRT_X, SPRT_Y
; Shape -> SPRT_LO,SPRT_HI

; Nb total de bytes -> X
; Nb lignes -> Y
; Nb bytes par ligne -> A
DEL_ZONE
            LDY #$00            ; Lecture de nb de byte par ligne
            LDA (SPRT_LO),Y
			STA .02+1

            LDY #$02            ; Lecture de nb total de bytes
            LDA (SPRT_LO),Y
            TAX

            LDY #$01
            LDA (SPRT_LO),Y     ; Lecture de nb total de lignes

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
; Coord sprite -> SPRT_X, SPRT_Y
; Data du sprite dans SPRT_LO, SPRT_HI
; 
; Les 3 premier byte du sprite sont :
; nb bytes sur 1 ligne / nb lignes / nb total de bytes
DRAW_SHAPE
            LDA #$05            ; On va réécrire le code en AA avec l'adresse du sprite
            CLC                 ; à laquelle on ajoute le nb de byte par ligne
            ADC SPRT_LO         ; On evite de lire directement l'adresse du sprite pour    
            STA .03+1           ; ne pas manipuler inutilement la pile
            LDA #$00            ; On additionne 3 pour sauté les byte qui definissent sa taille
            ADC SPRT_HI
            STA .03+2           ; L'adresse AA devient : LDA SPRITE+3,X

            LDY #$02
            LDA (SPRT_LO),Y     ; Meme chose pour les données du sprite pour la zone MAIN
            TAX                 ; Compteur du nombre de bytes composant le sprite
            CLC                 ; Du coup on lui additionne le nb total de byte de la zone AUX
            ADC #$05            ; + le poid de l'entete
            ADC SPRT_LO         ; pour trouver le debut des data
            STA .05+1
            LDA #$00
            ADC SPRT_HI
            STA .05+2           ; L'adresse BB devient : LDA SPRITE+nb+3,X

            LDY #$01            ; On recupère le nb de ligne du sprite
            LDA (SPRT_LO),Y     ; On ajoute le nombre de ligne du sprite à la pos Y de départ
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

            LDY #$00            ; Mise en place du compteur de byte par ligne
            LDA (SPRT_LO),Y 
            TAY                 ; Y sert de compteur
            DEY

.02			DEX
            BMI END_DRAW_SHAPE
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
; Adresse de la structure descriptive du sprite
; dans SPRT_INF :
; #<desc_sprite> -> SPRT_INF_LO
; /<desc_sprite> -> SPRT_INF_HI
DRAW_SPRITE
            >GET_SHAPE
 
            >GET_COORD

            LDA #01
            BIT SPRT_X
            BEQ .1

            LDY #$03
            LDA (SPRT_LO),Y
            TAX
            LDY #$04
            LDA (SPRT_LO),Y
            STA SPRT_HI
            STX SPRT_LO

.1          JSR DRAW_SHAPE
            RTS
*--------------------------------------
MAN
SAVE /DEV/TILES/SRC/DHGR.SPRITE.S
TEXT /DEV/TILES/TXT/DHGR.SPRITE.S
