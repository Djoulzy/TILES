NEW
    
AUTO 4,1
            .OP	65C02
            .LIST OFF
*			.OR	$800
*			.TF /DEV/TILES/OBJ/DHGR.TOOLS
*--------------------------------------
INIT        STA GRAPHON         ;Turn on graphics
            STA HIRESON         ;Turn on hi-res 
            STA FULLON          ;Turn on fullscreen
            LDA AN3             ;Turn on DHR
            STA ON80COL         ;Turn on 80 columns
            STA ON80STOR        ;Use PAGE1/PAGE2 to switch between MAIN and AUX
            RTS
*--------------------------------------
DHGR_CLR    STA PAGE1       ;Select MAIN memory
            LDY #$02        ;Counter for MAIN/AUX
.21         LDX #$00        ;Start at byte 0
.22         STA $2000,X
            STA $2100,X
            STA $2200,X
            STA $2300,X
            STA $2400,X
            STA $2500,X
            STA $2600,X
            STA $2700,X
            STA $2800,X
            STA $2900,X
            STA $2A00,X
            STA $2B00,X
            STA $2C00,X
            STA $2D00,X
            STA $2E00,X
            STA $2F00,X
            STA $3000,X
            STA $3100,X
            STA $3200,X
            STA $3300,X
            STA $3400,X
            STA $3500,X
            STA $3600,X
            STA $3700,X
            STA $3800,X
            STA $3900,X
            STA $3A00,X
            STA $3B00,X
            STA $3C00,X
            STA $3D00,X
            STA $3E00,X
            STA $3F00,X
            INX
            BNE .22
            LSR             ;Turn 55 into 2A otherwise do nothing
            DEY
            STA PAGE2       ;Now do it all over again
            BNE .21         ;in AUX memory
            RTS
*--------------------------------------
DHGR2_CLR   PHA
            STA WRT_AUX     ;Select MAIN memory
            LDY #$02        ;Counter for MAIN/AUX
.21         LDX #$00        ;Start at byte 0
.22         STA $2000,X
            STA $2100,X
            STA $2200,X
            STA $2300,X
            STA $2400,X
            STA $2500,X
            STA $2600,X
            STA $2700,X
            STA $2800,X
            STA $2900,X
            STA $2A00,X
            STA $2B00,X
            STA $2C00,X
            STA $2D00,X
            STA $2E00,X
            STA $2F00,X
            STA $3000,X
            STA $3100,X
            STA $3200,X
            STA $3300,X
            STA $3400,X
            STA $3500,X
            STA $3600,X
            STA $3700,X
            STA $3800,X
            STA $3900,X
            STA $3A00,X
            STA $3B00,X
            STA $3C00,X
            STA $3D00,X
            STA $3E00,X
            STA $3F00,X
            INX
            BNE .22
            LSR             ;Turn 55 into 2A otherwise do nothing
            DEY
            STA WRT_MAIN    ;Now do it all over again
            BNE .21         ;in AUX memory

            PLA
            STA WRT_AUX     ;Select MAIN memory
            LDY #$02        ;Counter for MAIN/AUX
.24         LDX #$00        ;Start at byte 0
.23         STA $4000,X
            STA $4100,X
            STA $4200,X
            STA $4300,X
            STA $4400,X
            STA $4500,X
            STA $4600,X
            STA $4700,X
            STA $4800,X
            STA $4900,X
            STA $4A00,X
            STA $4B00,X
            STA $4C00,X
            STA $4D00,X
            STA $4E00,X
            STA $4F00,X
            STA $5000,X
            STA $5100,X
            STA $5200,X
            STA $5300,X
            STA $5400,X
            STA $5500,X
            STA $5600,X
            STA $5700,X
            STA $5800,X
            STA $5900,X
            STA $5A00,X
            STA $5B00,X
            STA $5C00,X
            STA $5D00,X
            STA $5E00,X
            STA $5F00,X
            INX
            BNE .23
            LSR             ;Turn 55 into 2A otherwise do nothing
            DEY
            STA WRT_MAIN    ;Now do it all over again
            BNE .24         ;in AUX memory
            RTS
*--------------------------------------
MAN
SAVE /DEV/TILES/SRC/DHGR.TOOLS.S
TEXT /DEV/TILES/TXT/DHGR.TOOLS.S
