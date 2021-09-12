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
			.INB /DEV/TILES/SRC/DHGR.SPRITE.S
            .INB /DEV/TILES/SRC/DIV7.S
*--------------------------------------
INIT        STA GRAPHON         ;Turn on graphics
            STA HIRESON         ;Turn on hi-res 
            STA FULLON          ;Turn on fullscreen
            LDA AN3             ;Turn on DHR
            STA ON80COL         ;Turn on 80 columns
            STA ON80STOR        ;Use PAGE1/PAGE2 to switch between MAIN and AUX
            RTS
*--------------------------------------
			.MA WAITVBL
:1			BIT VBL
            BPL :1
:2			BIT VBL
            BMI :2
            .EM
*--------------------------------------
PLAYER_DESC .HS 00,00           ; Player X,Y
OBJECT_DESC .HS 00,00
*--------------------------------------

READKEYB    BIT KBD
            BPL .1
            LDA KBD
            BIT KBDSTRB
            AND #$7F
.1          RTS

DEL_OBJECT  LDA OBJECT_DESC
            STA SPRT_X
            LDA OBJECT_DESC+1
            STA SPRT_Y
            LDA #$04
            LDY #$10
            LDX #$40
            JSR DEL_ZONE
            RTS

DEL_PLAYER  LDA PLAYER_DESC
            STA SPRT_X
            LDA PLAYER_DESC+1
            STA SPRT_Y
            LDA #$02
            LDY #$10
            LDX #$20
            JSR DEL_ZONE
            RTS

DRAW_OBJECT
            LDA #01
            BIT OBJECT_DESC
            BEQ .1
            LDA #MONSTER2
            STA SPRT_LO
            LDA /MONSTER2
            STA SPRT_HI
            JMP .2
.1          LDA #MONSTER
            STA SPRT_LO
            LDA /MONSTER
            STA SPRT_HI
.2          LDA OBJECT_DESC
            STA SPRT_X
            LDA OBJECT_DESC+1
            STA SPRT_Y
            JSR DRW_SPRITE
            RTS

DRAW_PLAYER
            LDA #01
            BIT PLAYER_DESC
            BEQ .1
            LDA #PLAYER2
            STA SPRT_LO
            LDA /PLAYER2
            STA SPRT_HI
            JMP .2
.1          LDA #PLAYER
            STA SPRT_LO
            LDA /PLAYER
            STA SPRT_HI
.2          LDA PLAYER_DESC
            STA SPRT_X
            LDA PLAYER_DESC+1
            STA SPRT_Y
            JSR DRW_SPRITE
            RTS

MOVE_OBJECT
            JSR DEL_OBJECT
            INC OBJECT_DESC
            LDA #$12
            CMP OBJECT_DESC
            BNE .1
            LDA #00
            STA OBJECT_DESC
.1          RTS

RUN         JSR INIT
            LDA #$00
            JSR DHGR_CLR
;            JSR CORNER

GAMELOOP
            JSR MOVE_OBJECT
            JSR DRAW_OBJECT
            JSR DRAW_PLAYER

            JSR READKEYB
            CMP #$15
            BEQ PLYR_RIGHT
            CMP #$08
            BEQ PLYR_LEFT
            CMP #$0A
            BEQ PLYR_DOWN
            CMP #$0B
            BEQ PLYR_UP
            JMP GAMELOOP

PLYR_RIGHT  JSR DEL_PLAYER
            INC PLAYER_DESC
            JMP GAMELOOP

PLYR_LEFT   JSR DEL_PLAYER
            DEC PLAYER_DESC
            JMP GAMELOOP

PLYR_DOWN   JSR DEL_PLAYER
            INC PLAYER_DESC+1
            INC PLAYER_DESC+1
            INC PLAYER_DESC+1
            INC PLAYER_DESC+1
            JMP GAMELOOP

PLYR_UP     JSR DEL_PLAYER
            DEC PLAYER_DESC+1
            DEC PLAYER_DESC+1
            DEC PLAYER_DESC+1
            DEC PLAYER_DESC+1
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
