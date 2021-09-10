NEW
    
AUTO 4,1
            .OP	65C02
            .LIST OFF
			.OR	$300
*			.TF /DEV/TILES.HR/OBJ/HR.TOOLS
*--------------------------------------
          CLD
          SEI
          STA $45
          STX $46
          STY $47
          LDX $07
          ASL A
          ASL A
          BCS L0312
          BPL L034E
          BMI L0316
L0312     BPL L0315
          INX
L0315     INX
L0316     ASL A
          STX $1B
          CLC
          ADC $06
          STA $1A
          BCC L0322
          INC $1B
L0322     LDA $28
          STA $08
          LDA $29
          AND #$03
          ORA $E6
          STA $09
          LDX #$08
L0330     LDY #$00
          LDA ($1A),Y
          BIT $32
          BMI L033A
          EOR #$7F
L033A     LDY $24
          STA ($08),Y
          INC $1A
          BNE L0344
          INC $1B
L0344     LDA $09
          CLC
          ADC #$04
          STA $09
          DEX
          BNE L0330
L034E     LDA $45
          LDX $46
          LDY $47
          CLI
          JMP $FDF0
          .END

;auto-generated symbols and labels
 L0312      $0312
 L034E      $034E
 L0316      $0316
 L0315      $0315
 L0322      $0322
 L033A      $033A
 L0344      $0344
 L0330      $0330