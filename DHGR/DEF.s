NEW
    
AUTO 4,1
            .OP	65C02
            .LIST OFF
*			.OR	$800
*			.TF /DEV/TILES/OBJ/DEF
*--------------------------------------
KBDSTRB		.EQ $C010
KBD         .EQ $C000

GRAPHON     .EQ $C050
HIRESON     .EQ $C057
FULLON      .EQ $C052
AN3         .EQ $C05E
ON80STOR    .EQ $C001
ON80COL     .EQ $C00D
PAGE1       .EQ $C054
PAGE2       .EQ $C055
WRT_MAIN	.EQ $C004			;RAMWRTOFF
WRT_AUX		.EQ $C005			;RAMWRTON
SCRN_LO		.EQ $1D				;Zero page location for low byte of our screen row
SCRN_HI		.EQ $1E				;Zero page location for high byte of our screen row
SHAPE_LO    .EQ $FA
SHAPE_HI    .EQ $FB
SPRT_INF_LO .EQ $FC
SPRT_INF_HI .EQ $FD
CPT         .EQ $FE
VBL			.EQ	$C019
*--------------------------------------
SPRT_X      .HS 00
SPRT_Y      .HS 00
*--------------------------------------
MAN
SAVE /DEV/TILES/SRC/DEF.S
TEXT /DEV/TILES/TXT/DEF.S
