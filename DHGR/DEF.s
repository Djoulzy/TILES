NEW
    
AUTO 4,1
                .OP	65C02
                .LIST OFF
*			    .OR	$800
*			    .TF /DEV/TILES/OBJ/DEF
*--------------------------------------
KBDSTRB		    .EQ $C010
KBD             .EQ $C000

GRAPHON         .EQ $C050
HIRESON         .EQ $C057
FULLON          .EQ $C052
AN3             .EQ $C05E
ON80STOR        .EQ $C001
ON80COL         .EQ $C00D
PAGE1           .EQ $C054
PAGE2           .EQ $C055
WRT_MAIN	    .EQ $C004			;RAMWRTOFF
WRT_AUX		    .EQ $C005			;RAMWRTON
SCRN_LO		    .EQ $1D				;Zero page location for low byte of our screen row
SCRN_HI		    .EQ $1E				;Zero page location for high byte of our screen row
SHAPE_LO        .EQ $FA
SHAPE_HI        .EQ $FB
SPRT_INF_LO     .EQ $FC
SPRT_INF_HI     .EQ $FD
CPT             .EQ $FE
VBL			    .EQ	$C019
*--------------------------------------
SPRT_X          .HS 00
SPRT_Y          .HS 00

SPRT_COORD_X    .DA #$00
SPRT_COORD_Y    .DA #$01
SPRT_SPEED_X    .DA #$02
SPRT_SPEED_Y    .DA #$03
SPRT_TIME_DEF   .DA #$04
SPRT_TIME_CNT   .DA #$05
SPRT_ACTIVE     .DA #$06
SPRT_SHAPE_LO   .DA #$07
SPRT_SHAPE_HI   .DA #$08
*--------------------------------------
MAN
SAVE /DEV/TILES/SRC/DEF.S
TEXT /DEV/TILES/TXT/DEF.S
