NEW
    
AUTO 4,1
            .OP	65C02
            .LIST OFF
*			.OR	$800
*			.TF /DEV/TILES/OBJ/PLAYER
*--------------------------------------
; Lecture du clavier non bloquant
; Retourne le KeyCode dans A
READKEYB    LDA #$00
            BIT KBD
            BPL .1
            LDA KBD
            BIT KBDSTRB
            AND #$7F
.1          RTS
*--------------------------------------
;  0: Coord X
; +1: Coord Y
; +2: Speed X
; +3: Speed Y
; +4: Timer Default
; +5: Timer compter
; +6: Sprite Active/hidden
; +7: Sprite def LO
; +8: Sprite def HI
; +9: Collision X
;+10: Collision Y
PLYR_NFO    .HS 00,0C,00,00,00,00,01
            .DA #SHIP,/SHIP

SHOOT_NFO   .HS 00,00,00,00,00,00,00
            .DA #SHOOT,/SHOOT
            .DA 00,00

NB_SHOOT    .HS 01
SHOOT_LIST  .DA #SHOOT_NFO,/SHOOT_NFO
*--------------------------------------
PLYR_RIGHT  LDY #$01        ; Y: Nb bytes per line
            LDA #$18        ; A: Nb lines 
            LDX #$18        ; X: Total bytes
            JSR FILL_AREA
            INC PLYR_NFO
            JMP END_MV_PLAYER

PLYR_LEFT   INC SPRT_X
            INC SPRT_X
            INC SPRT_X
            LDY #$01        ; Y: Nb bytes per line
            LDA #$18        ; A: Nb lines 
            LDX #$18        ; X: Total bytes
            JSR FILL_AREA
            DEC PLYR_NFO
            JMP END_MV_PLAYER

PLYR_DOWN   LDY #$02        ; Y: Nb bytes per line
            LDA #$03        ; A: Nb lines 
            LDX #$06        ; X: Total bytes
            JSR FILL_AREA
            LDA PLYR_NFO+1
            CLC
            ADC #$03
            STA PLYR_NFO+1
            JMP END_MV_PLAYER

PLYR_UP     LDA PLYR_NFO+1
            CLC
            ADC #$14
            STA SPRT_Y
            LDY #$04        ; Y: Nb bytes per line
            LDA #$04        ; A: Nb lines 
            LDX #$10        ; X: Total bytes
            JSR FILL_AREA
            LDA PLYR_NFO+1
            CLC
            SBC #$03
            STA PLYR_NFO+1
            JMP END_MV_PLAYER
*--------------------------------------

MV_PLAYER   LDA #PLYR_NFO
            STA SPRT_INF_LO
            LDA /PLYR_NFO
            STA SPRT_INF_HI

            JSR READKEYB
            TAX
            BEQ END_MV_PLAYER

            >GET_COORD 

            TXA
            CMP #$20
            BNE .01
            LDA SHOOT_NFO+6
            BNE .01
            JMP PLYR_SHOOT
.01         CMP #$15
            BNE .02
            JMP PLYR_RIGHT
.02         CMP #$08
            BEQ PLYR_LEFT
            CMP #$0A
            BEQ PLYR_DOWN
            CMP #$0B
            BEQ PLYR_UP

END_MV_PLAYER
            JSR DRAW_SPRITE

            LDY NB_SHOOT
MV_SHOOT    LDA SHOOT_LIST,Y
            STA SPRT_INF_HI
            DEY
            LDA SHOOT_LIST,Y
            STA SPRT_INF_LO
            DEY
            PHY
            JSR MV_SPRITE
            LDA (SPRT_INF_LO)
            CMP #$24
            BNE .01

            >GET_COORD      ; Le shoot sort de l'ecran
            LDY #$04        ; Y: Nb bytes per line
            LDA #$03        ; A: Nb lines 
            LDX #$12        ; X: Total bytes
            JSR FILL_AREA
            LDA #$00
            STA SHOOT_NFO
            STA SHOOT_NFO+1
            STA SHOOT_NFO+2
            STA SHOOT_NFO+6
            PLY
            JMP END_MV_SHOOT

.01         JSR DRAW_SPRITE
            LDA SHOOT_NFO
            CLC
            ADC #$04
            STA SHOOT_NFO+9
            LDA SHOOT_NFO+1
            INC
            STA SHOOT_NFO+10
            PLY
            BPL MV_SHOOT
END_MV_SHOOT
            RTS
*--------------------------------------
PLYR_SHOOT
            LDA PLYR_NFO
            CLC
            ADC #$02
            STA SHOOT_NFO
            ADC #$04
            STA SHOOT_NFO+9
            LDA PLYR_NFO+1
            CLC
            ADC #$0B
            STA SHOOT_NFO+1
            INC
            STA SHOOT_NFO+10
            LDA #$01
            STA SHOOT_NFO+2
            STA SHOOT_NFO+6
            JMP END_MV_PLAYER
*--------------------------------------
MAN
SAVE /DEV/TILES/SRC/PLAYER.S
TEXT /DEV/TILES/TXT/PLAYER.S
