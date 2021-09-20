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
MV_PLAYER   LDA #PLYR_NFO
            STA SPRT_INF_LO
            LDA /PLYR_NFO
            STA SPRT_INF_HI

            JSR READKEYB
            TAX
            BEQ END_MV_PLAYER

            PHX
            >GET_COORD
            >GET_SHAPE
            JSR DEL_ZONE

            PLX
            TXA
            CMP #$15
            BEQ PLYR_RIGHT
            CMP #$08
            BEQ PLYR_LEFT
            CMP #$0A
            BEQ PLYR_DOWN
            CMP #$0B
            BEQ PLYR_UP
            JMP END_MV_PLAYER

PLYR_RIGHT  INC PLYR_NFO
            JMP END_MV_PLAYER

PLYR_LEFT   DEC PLYR_NFO
            JMP END_MV_PLAYER

PLYR_DOWN   INC PLYR_NFO+1
            INC PLYR_NFO+1
            INC PLYR_NFO+1
            JMP END_MV_PLAYER

PLYR_UP     DEC PLYR_NFO+1
            DEC PLYR_NFO+1
            DEC PLYR_NFO+1

END_MV_PLAYER
            JSR DRAW_SPRITE
            RTS
*--------------------------------------
MAN
SAVE /DEV/TILES/SRC/PLAYER.S
TEXT /DEV/TILES/TXT/PLAYER.S
