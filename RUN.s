NEW
  
AUTO 4,1
			.LIST OFF
            .OP	65C02
*			.TF /DEV/TILES/OBJ/RUN
*--------------------------------------
            JMP RUN
*--------------------------------------
GRAPHON     .EQ $C050
HIRESON     .EQ $C057
FULLON      .EQ $C052
DHRON       .EQ $C05E
ON80STOR    .EQ $C001
ON80COL     .EQ $C00D
PAGE1       .EQ $C054
PAGE2       .EQ $C055
WRT_MAIN	.EQ $C004			;RAMWRTOFF
WRT_AUX		.EQ $C005			;RAMWRTON
SCRN_LO		.EQ $1D				;Zero page location for low byte of our screen row
SCRN_HI		.EQ $1E				;Zero page location for high byte of our screen row
SPRT_LO		.EQ $FA
SPRT_HI		.EQ $FB
SPRT_X		.EQ $FC
SPRT_Y		.EQ $FD
CPT         .EQ $FE
*--------------------------------------
			.INB /DEV/TILES/SRC/GFXTABLES.S
			.INB /DEV/TILES/SRC/DHGR.CLR.S
            .INB /DEV/TILES/SRC/DIV7.S
*--------------------------------------
* Y in Y
			.MA FINDY
			LDA HTAB_LO,Y		;Find the low byte of the row address
			STA SCRN_LO 
			LDA HTAB_HI,Y		;Find the high byte of the row address
			STA SCRN_HI
			.EM
*--------------------------------------
INIT        STA GRAPHON         ;Turn on graphics
            STA HIRESON         ;Turn on hi-res 
            STA FULLON          ;Turn on fullscreen
            STA DHRON           ;Turn on DHR
            STA ON80COL         ;Turn on 80 columns
            STA ON80STOR        ;Use PAGE1/PAGE2 to switch between MAIN and AUX
            RTS
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
RUN         JSR INIT
            LDA #$00
            JSR DHGR_CLR

            LDA #SPRITE
            STA SPRT_LO
            LDA /SPRITE
            STA SPRT_HI
            LDA #$00
            STA SPRT_X
            LDA #$00            ; Coord Y du sprite
            STA SPRT_Y
            JSR DRW_SPRITE

            LDA #SPRITE2
            STA SPRT_LO
            LDA /SPRITE2
            STA SPRT_HI
            LDA #$00
            STA SPRT_X
            LDA #$00            ; Coord Y du sprite
            STA SPRT_Y
            JSR DRW_SPRITE

            LDA #SPRITE
            STA SPRT_LO
            LDA /SPRITE
            STA SPRT_HI
            LDA #$00
            STA SPRT_X
            LDA #$20            ; Coord Y du sprite
            STA SPRT_Y
            JSR DRW_SPRITE

;            LDA #$00
;            LDY #$7C            ; Coord X du sprite
;            JSR DIVMOD7YA
;            ASL
;            STA SPRT_X
;            LDA #$01
;            STA SPRT_X
;            LDA #$10            ; Coord Y du sprite
;            STA SPRT_Y
;            JSR DRW_SPRITE
;
;            LDA #$02
;            STA SPRT_X
;            LDA #$20            ; Coord Y du sprite
;            STA SPRT_Y
;            JSR DRW_SPRITE
;
;            LDA #$03
;            STA SPRT_X
;            LDA #$30            ; Coord Y du sprite
;            STA SPRT_Y
;            JSR DRW_SPRITE
;
;            LDA #$04
;            STA SPRT_X
;            LDA #$40            ; Coord Y du sprite
;            STA SPRT_Y
;            JSR DRW_SPRITE

            RTS
*--------------------------------------

MAN
SAVE /DEV/TILES/SRC/RUN.S
TEXT /DEV/TILES/TXT/RUN.S

ASM
