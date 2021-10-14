NEW
    
AUTO 4,1
            .OP	65C02
            .LIST OFF
*			.OR	$800
*			.TF /DEV/TILES/OBJ/BKGROUND
*--------------------------------------
;  0: Coord X
; +1: Coord Y
; +2: Speed X
; +3: Speed Y
; +4: Timer Default
; +5: Timer compter
; +6: Sprite def LO
; +7: Sprite def HI
STAR1_NFO   .HS 08,06,81,00,00,00
            .DA #STAR,/STAR
STAR2_NFO   .HS 18,24,81,00,00,00
            .DA #STAR,/STAR
STAR3_NFO   .HS 24,06,81,00,00,00
            .DA #STAR,/STAR
STAR4_NFO   .HS 12,18,81,00,00,00
            .DA #STAR,/STAR

PLANET_NFO  .HS 22,00,00,00,00,00
            .DA #PLANET,/PLANET

NB_OBJ      .HS 09
OBJ_LIST    .DA #STAR1_NFO,/STAR1_NFO,#STAR2_NFO,/STAR2_NFO,#STAR3_NFO,/STAR3_NFO,#STAR4_NFO,/STAR4_NFO
            .DA #PLANET_NFO,/PLANET_NFO
*--------------------------------------
BKGROUND
            LDY NB_OBJ

.01         LDA OBJ_LIST,Y
            STA SPRT_INF_HI
            DEY
            LDA OBJ_LIST,Y
            STA SPRT_INF_LO
            DEY
            PHY
            JSR MV_SPRITE
            LDA (SPRT_INF_LO)
            BNE .02

            >GET_COORD
            LDY #$02        ; Y: Nb bytes per line
            LDA #$01        ; A: Nb lines 
            LDX #$02        ; X: Total bytes
            JSR FILL_AREA

            LDA #$24
            STA (SPRT_INF_LO)
.02         JSR DRAW_SPRITE
            PLY
            BPL .01
            RTS
*--------------------------------------
MAN
SAVE /DEV/TILES/SRC/BKGROUND.S
TEXT /DEV/TILES/TXT/BKGROUND.S
