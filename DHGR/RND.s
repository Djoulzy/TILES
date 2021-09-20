NEW
  
AUTO 4,1
			.LIST OFF
            .OP	65C02
*			.TF /DEV/TILES/OBJ/RND
*--------------------------------------
;HGR         .EQ $F3E2
;HPLOT       .EQ $F457
;IOADR       .EQ $C000
;KBSTR       .EQ $C010
;SETHCOL     .EQ $F6EC
;TEXT        .EQ $C050
;COLOR       .EQ $03
*--------------------------------------
RNDL        .EQ $4E 
RNDH        .EQ $4F 

SEED1       .HS AA
SEED2       .HS AA
SEED3       .HS AA
SEED4       .HS AA
PSR1        .HS AA
PSR2        .HS AA
PSR3        .HS 3B
PSR4        .HS AA
BSIZE       .HS FF
RSIZE       .HS 04
MODULO      .HS 07
HOLD        .HS 00

RESEED      LDA RNDL 
            STA SEED1
            LDA RNDH
            STA SEED4
            LDA PSR3
            STA SEED2
            LDA PSR2
            STA SEED3

RESET       LDY #$04
NXT7        LDA SEED1,Y 
            STA PSR1,Y
            DEY 
            BNE NXT7

            LDA PSR2
            BNE DONE7
            INC PSR2
DONE7       RTS
*--------------------------------------
RNDHL       LDA MODULO
RANDOM      STA MODULO
            BNE BSCALC
            LDA #$02
            STA MODULO 

BSCALC      LDA #$FF
            STA BSIZE
            LDY #$08
            LDA MODULO
SMALLER     ROL
            BCS ADVANCE
            LSR BSIZE
            DEY NEXT
            BNE SMALLER
            STY RSIZE
*--------------------------------------
REUSEN      LDY RSIZE
ADVANCE     LDA PSR4
            ASL
            ASL
            ASL
            EOR PSR4
            ASL
            ASL
            ROL PSR1
            ROL PSR2
            ROL PSR3
            ROL PSR4
            DEY
            BNE ADVANCE

RANGE       LDA PSR1
            AND BSIZE
            CMP MODULO
            BCS REUSEN
            STA HOLD
            RTS
*--------------------------------------
;FILL        JSR HGR
;            LDX #COLOR
;            JSR SETHCOL 
;            JSR RESEED
;
;PLOTDOT     LDA #$BF
;            STA MODULO 
;            JSR RANDOM
;            PHA
;            LDA #$FF
;            STA MODULO
;            JSR RANDOM
;            TAX
;            PLA
;            JSR HPLOT
;            BIT IOADR
;            BMI EXIT7
;            BPL PLOTDOT
;EXIT7       BIT KBSTR
;            RTS 
*--------------------------------------
MAN
SAVE /DEV/TILES/SRC/RND.S
TEXT /DEV/TILES/TXT/RND.S
