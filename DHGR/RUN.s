NEW
  
AUTO 4,1
			.LIST OFF
            .OP	65C02
*			.TF /DEV/TILES/OBJ/RUN
*--------------------------------------
            JMP RUN
*--------------------------------------
			.INB /DEV/TILES/SRC/DEF.S
			.INB /DEV/TILES/SRC/GFXTABLES.S
			.INB /DEV/TILES/SRC/DHGR.TOOLS.S
			.INB /DEV/TILES/SRC/RND.S
			.INB /DEV/TILES/SRC/DHGR.SPRITE.S
            .INB /DEV/TILES/SRC/BKGROUND.S
            .INB /DEV/TILES/SRC/PLAYER.S
            .INB /DEV/TILES/SRC/ENEMY.S
*--------------------------------------
			.MA WAITVBL
:01			BIT VBL
            BPL :01
:02			BIT VBL
            BMI :02
            .EM
*--------------------------------------

RUN         JSR INIT
            JSR RESEED
            LDA #$00
            JSR DHGR_CLR

GAMELOOP
            JSR BKGROUND
            JSR ENEMY

            JSR MV_PLAYER

            JMP GAMELOOP

GAMELOOPEND
            LDA #$03
            JSR $FDED
            RTS
*--------------------------------------
MAN
SAVE /DEV/TILES/SRC/RUN.S
TEXT /DEV/TILES/TXT/RUN.S

ASM
