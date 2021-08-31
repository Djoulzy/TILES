NEW
    
AUTO 4,1
            .OP	65C02
            .LIST OFF
*			.OR	$800
*			.TF /DEV/TILES/OBJ/DHGR.SPRITE
*--------------------------------------
DRW_SPRITE
            LDA #$03            ; On va réécrire le code en AA avec l'adresse du sprite
            CLC                 ; à laquelle on ajoute le nb de byte par ligne
            ADC SPRT_LO         ; On evite de lire directement l'adresse du sprite pour    
            STA AA+1            ; ne pas manipuler inutilement la pile
            LDA #$00            ; On additionne 3 pour sauté les byte qui definissent sa taille
            ADC SPRT_HI
            STA AA+2            ; L'adresse AA devient : LDA SPRITE+3,X

            LDY #$02
            LDA (SPRT_LO),Y     ; Meme chose pour les données du sprite pour la zone MAIN
            TAX                 ; Compteur du nombre de bytes composant le sprite
            CLC                 ; Du coup on lui additionne le nb total de byte de la zone AUX
            ADC #$03
            ADC SPRT_LO         ; pour trouver le debut des data
            STA BB+1
            LDA #$00
            ADC SPRT_HI
            STA BB+2            ; L'adresse BB devient : LDA SPRITE+nb+3,X

            LDY #$01            ; On recupère le nb de ligne du sprite
            LDA (SPRT_LO),Y     ; On ajoute le nombre de ligne du sprite à la pos Y de départ
            CLC
            ADC SPRT_Y
            STA SPRT_Y

NEW_LINE    DEC SPRT_Y
            LDY SPRT_Y          ; On cherche la position memoire de Y
            >FINDY

            LDY #$00
            LDA (SPRT_LO),Y     ; Compteur du nombre de byte par ligne
            CLC
            ADC SPRT_X          ; On place dans Y la position Xorigine + Compteur
            TAY

LOOP        DEX
            BMI END_DRW_SPRITE
            DEY
AA          LDA $AAAA,X
            STA PAGE2           ; Bascule vers AUX
            STA (SCRN_LO),Y
BB          LDA $BBBB,X
            STA PAGE1           ; Bascule vers MAIN
            STA (SCRN_LO),Y
            BMI NEW_LINE
            JMP LOOP

END_DRW_SPRITE
            RTS
*--------------------------------------
MAN
SAVE /DEV/TILES/SRC/DHGR.SPRITE.S
TEXT /DEV/TILES/TXT/DHGR.SPRITE.S

ASM
