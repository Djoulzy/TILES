NEW
    
AUTO 4,1
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
; +6: Sprite def LO
; +7: Sprite def HI
PLYR_NFO    .HS 00,0C,00,00,00,00
            .DA #PLAYER,/PLAYER
*--------------------------------------
PLYR_RIGHT  LDY #$01        ; Y: Nb bytes per line
            LDA #$10        ; A: Nb lines 
            LDX #$10        ; X: Total bytes
            JSR FILL_AREA
            INC PLYR_NFO
            JMP END_MV_PLAYER

PLYR_LEFT   INC SPRT_X
            LDY #$01        ; Y: Nb bytes per line
            LDA #$10        ; A: Nb lines 
            LDX #$10        ; X: Total bytes
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
            ADC #$0C
            STA SPRT_Y
            LDY #$02        ; Y: Nb bytes per line
            LDA #$04        ; A: Nb lines 
            LDX #$08        ; X: Total bytes
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

            ;PHX
            >GET_COORD 
            ;>GET_SHAPE
            ;JSR DEL_ZONE

            ;PLX
            TXA
            CMP #$15
            BEQ PLYR_RIGHT
            CMP #$08
            BEQ PLYR_LEFT
            CMP #$0A
            BEQ PLYR_DOWN
            CMP #$0B
            BEQ PLYR_UP

END_MV_PLAYER
            JSR DRAW_SPRITE
            RTS
*--------------------------------------
MAN
SAVE /DEV/TILES/SRC/PLAYER.S
TEXT /DEV/TILES/TXT/PLAYER.S
