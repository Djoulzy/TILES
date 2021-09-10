NEW
    
AUTO 4,1
            .OP	65C02
            .LIST OFF
*			.OR	$800
*			.TF /DEV/TILES/OBJ/DHGR.SPRITE
*--------------------------------------
* Y in Y
			.MA FINDY
			LDA HTAB_LO,Y		;Find the low byte of the row address
			STA SCRN_LO 
			LDA HTAB_HI,Y		;Find the high byte of the row address
			STA SCRN_HI
			.EM
*--------------------------------------
; Coord zone -> SPRT_X, SPRT_Y
; Nb total de bytes -> X
; Nb lignes -> Y
; Nb bytes par ligne -> A
DEL_ZONE
            CLC
            ADC SPRT_X
			STA .02+1

			TYA
            CLC
            ADC SPRT_Y
            STA SPRT_Y

.01			DEC SPRT_Y
            LDY SPRT_Y          ; On cherche la position memoire de Y
            >FINDY

.02			LDY #$AA

.03			DEX
            BMI END_DEL_ZONE
            DEY
            LDA #$00
            STA PAGE2           ; Bascule vers AUX
            STA (SCRN_LO),Y
            STA PAGE1           ; Bascule vers MAIN
            STA (SCRN_LO),Y
			CPY SPRT_X
            BEQ .01				; Fin d'une ligne
            JMP .03

END_DEL_ZONE
            RTS
*--------------------------------------
; Coord sprite -> SPRT_X, SPRT_Y
; Data du sprite dans SPRT_LO, SPRT_HI
; 
; Les 3 premier byte du sprite sont :
; nb bytes sur 1 ligne / nb lignes / nb total de bytes
DRW_SPRITE
            LDA #$03            ; On va réécrire le code en AA avec l'adresse du sprite
            CLC                 ; à laquelle on ajoute le nb de byte par ligne
            ADC SPRT_LO         ; On evite de lire directement l'adresse du sprite pour    
            STA .3+1            ; ne pas manipuler inutilement la pile
            LDA #$00            ; On additionne 3 pour sauté les byte qui definissent sa taille
            ADC SPRT_HI
            STA .3+2            ; L'adresse AA devient : LDA SPRITE+3,X

            LDY #$02
            LDA (SPRT_LO),Y     ; Meme chose pour les données du sprite pour la zone MAIN
            TAX                 ; Compteur du nombre de bytes composant le sprite
            CLC                 ; Du coup on lui additionne le nb total de byte de la zone AUX
            ADC #$03
            ADC SPRT_LO         ; pour trouver le debut des data
            STA .4+1
            LDA #$00
            ADC SPRT_HI
            STA .4+2            ; L'adresse BB devient : LDA SPRITE+nb+3,X

            LDY #$01            ; On recupère le nb de ligne du sprite
            LDA (SPRT_LO),Y     ; On ajoute le nombre de ligne du sprite à la pos Y de départ
            CLC
            ADC SPRT_Y
            STA SPRT_Y

.01			DEC SPRT_Y
            LDY SPRT_Y          ; On cherche la position memoire de Y
			LDA HTAB_HI,Y		; Find the high byte of the row address
			STA SCRN_HI
			LDA HTAB_LO,Y		; Find the low byte of the row address
            CLC
            ADC SPRT_X
			STA SCRN_LO         ; Contient l'addresse du début de ligne

            LDY #$00            ; Mise en place du compteur de byte par ligne
            LDA (SPRT_LO),Y     
            TAY                 ; Y sert de compteur
            DEY

.02			DEX
            BMI END_DRW_SPRITE
.03			LDA $AAAA,X
            STA PAGE2           ; Bascule vers AUX
            STA (SCRN_LO),Y
.04			LDA $BBBB,X
            STA PAGE1           ; Bascule vers MAIN
            STA (SCRN_LO),Y
            DEY
            BMI	.01
            JMP	.02

END_DRW_SPRITE
            RTS
*--------------------------------------
MAN
SAVE /DEV/TILES/SRC/DHGR.SPRITE.S
TEXT /DEV/TILES/TXT/DHGR.SPRITE.S
