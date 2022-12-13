;
; Capstone_Project.asm
;
; Created: 12/12/2022 6:49:59 PM
; Author : conne
;
.ORG $0000
	JMP main
.ORG $0002
	JMP Button_up
.ORG $0004
	JMP Button_down

Button_up:
	  INC R31
	  CPI R22, 0x0
	  BREQ game_over
	  DEC R22
	  DEC R22
	  RCALL delay_ms
	  RETI
Button_down:
	  INC R31
	  CPI R22, 0x6
	  BREQ game_over
	  INC R22
	  INC R22
	  RCALL delay_ms
	  RETI
.ORG $25
game_over:
	  LDI R16, 1
	  RCALL command_wrt
	  LDI R16, 'G'
	  RCALL data_wrt
	  LDI R16, 'A'
	  RCALL data_wrt
	  LDI R16, 'M'
	  RCALL data_wrt
	  LDI R16, 'E'
	  RCALL data_wrt
	  LDI R16, ' '
	  RCALL data_wrt
	  LDI R16, 'O'
	  RCALL data_wrt
	  LDI R16, 'V'
	  RCALL data_wrt
	  LDI R16, 'E'
	  RCALL data_wrt
	  LDI R16, 'R'
	  RCALL data_wrt
	  RCALL delay_seconds
	  RCALL delay_seconds
	  RCAll game_over
main:
	  LDI	R23, ' '
	  LDI	R24, ' '
	  LDI	R25, ' '
	  LDI	R26, ' '
	  LDI	R27, ' '
	  LDI	R28, ' '
	  LDI	R29, ' '
	  LDI	R30, ' '
	  LDI	R22, 0x0
      LDI   R16, 0xFF
      OUT   DDRD, R16         ;set port D o/p for data
      OUT   DDRB, R16         ;set port B o/p for command
      CBI   PORTB, 0          ;EN = 0
	  CBI	DDRD, 2
	  CBI	DDRD, 3
	  LDI R16, (1<<ISC01)|(1<<ISC11)
	  STS EICRA, R16
	  LDI R16, (1<<INT0)|(1<<INT1)
	  OUT EIMSK, R16
	  SEI
      RCALL delay_ms          ;wait for LCD power on
      ;-----------------------------------------------------
      RCALL LCD_init          ;subroutine to initialize LCD
      ;-----------------------------------------------------
	  LDI R16, 2
	  RCALL command_wrt
	  LDI R31, 0
Stall:	  
	  RCALL disp_start    
	  LDI R16, 0b11001101
	  RCALL command_wrt
	  LDI R16, ' '
	  RCALL data_wrt
	  RCALL data_wrt
	  RCALL data_wrt
	  RCALL delay_seconds
	  CPI R31,0
	  BREQ Stall
again:
	  ANDI R31, 0x07
	  ORI R31, 0x01
	  RCALL update_screen      
      ;-----------------------------------------------------
	  LDS R16, $100
      LDI R17, 2            ;wait 1 second
l1:   RCALL delay_seconds
      DEC R17
      BRNE l1
	  INC R16
	  STS $100, R16
      ;-----------------------------------------------------
      RJMP  again             ;jump to again for another run
;================================================================
	  
;================================================================
LCD_init:
      LDI R16, 0x33         ;init LCD for 4-bit data
      RCALL command_wrt       ;send to command register
      RCALL delay_ms
      LDI R16, 0x32         ;init LCD for 4-bit data
      RCALL command_wrt
      RCALL delay_ms
      LDI R16, 0x28         ;LCD 2 lines, 5x7 matrix
      RCALL command_wrt
      RCALL delay_ms
      LDI R16, 0x0C         ;disp ON, cursor OFF
      RCALL command_wrt
      LDI R16, 0x01         ;clear LCD
      RCALL command_wrt
      RCALL delay_ms
      LDI R16, 0x06         ;shift cursor right
      RCALL command_wrt
	  LDI R16, 0x40			;command for creation
	  RCALL command_wrt
	  LDI R16, 0
	  RCALL data_wrt
	  LDI R16, 0b00011000
	  RCALL data_wrt
	  LDI R16, 0b00011111
	  RCALL data_wrt
	  LDI R16, 0
	  RCALL data_wrt
	  RCALL data_wrt
	  RCALL data_wrt
	  RCALL data_wrt
	  RCALL data_wrt ;End of the first sprite creation
	  LDI R16, 0xFF
	  RCALL data_wrt
	  LDI R16, 0
	  RCALL data_wrt
	  RCALL data_wrt
	  LDI R16, 0xFF
	  RCALL data_wrt
	  RCALL data_wrt
	  RCALL data_wrt
	  RCALL data_wrt
	  RCALL data_wrt ;End of obstacle
	  LDI R16, 0
	  RCALL data_wrt
	  RCALL data_wrt
	  LDI R16, 0b00011000
	  RCALL data_wrt
	  LDI R16, 0b00011111
	  RCALL data_wrt
	  LDI R16, 0
	  RCALL data_wrt
	  RCALL data_wrt
	  RCALL data_wrt
	  RCALL data_wrt ;End of the first sprite creation
	  LDI R16, 0xFF
	  RCALL data_wrt
	  RCALL data_wrt
	  LDI R16, 0
	  RCALL data_wrt
	  RCALL data_wrt
	  LDI R16, 0xFF
	  RCALL data_wrt
	  RCALL data_wrt
	  RCALL data_wrt
	  RCALL data_wrt ;End of obstacle
	  LDI R16, 0
	  RCALL data_wrt
	  RCALL data_wrt
	  RCALL data_wrt
	  LDI R16, 0b00011000
	  RCALL data_wrt
	  LDI R16, 0b00011111
	  RCALL data_wrt
	  LDI R16, 0
	  RCALL data_wrt
	  RCALL data_wrt
	  RCALL data_wrt ;End of the first sprite creation
	  LDI R16, 0xFF
	  RCALL data_wrt
	  RCALL data_wrt
	  RCALL data_wrt
	  LDI R16, 0
	  RCALL data_wrt
	  RCALL data_wrt
	  LDI R16, 0xFF
	  RCALL data_wrt
	  RCALL data_wrt
	  RCALL data_wrt ;End of obstacle
	  LDI R16, 0
	  RCALL data_wrt
	  RCALL data_wrt
	  RCALL data_wrt
	  RCALL data_wrt
	  LDI R16, 0b00011000
	  RCALL data_wrt
	  LDI R16, 0b00011111
	  RCALL data_wrt
	  LDI R16, 0
	  RCALL data_wrt
	  RCALL data_wrt ;End of the first sprite creation
	  LDI R16, 0xFF
	  RCALL data_wrt
	  RCALL data_wrt
	  RCALL data_wrt
	  RCALL data_wrt
	  LDI R16, 0
	  RCALL data_wrt
	  RCALL data_wrt
	  LDI R16, 0xFF
	  RCALL data_wrt
	  RCALL data_wrt ;End of obstacle
      RET  
;================================================================
command_wrt:
      RCALL delay_ms
      MOV   R18, R16
      ANDI  R18, 0xF0         ;mask low nibble & keep high nibble
      OUT   PORTD, R18        ;o/p high nibble to port D
      CBI   PORTB, 1          ;RS = 0 for command
      SBI   PORTB, 0          ;EN = 1
      RCALL delay_short       ;widen EN pulse
      CBI   PORTB, 0          ;EN = 0 for H-to-L pulse
      RCALL delay_us          ;delay in micro seconds
      ;----------------------------------------------------
      MOV   R18, R16
      SWAP  R18               ;swap nibbles
      ANDI  R18, 0xF0         ;mask low nibble & keep high nibble
      OUT   PORTD, R18       ;o/p high nibble to port D
      SBI   PORTB, 0          ;EN = 1
      RCALL delay_short       ;widen EN pulse
      CBI   PORTB, 0          ;EN = 0 for H-to-L pulse
      RCALL delay_us          ;delay in micro seconds
      RET
;================================================================
data_wrt:
	  RCALL delay_ms
      MOV   R18, R16
      ANDI  R18, 0xF0         ;mask low nibble & keep high nibble
      OUT   PORTD, R18       ;o/p high nibble to port D
      SBI   PORTB, 1          ;RS = 1 for data
      SBI   PORTB, 0          ;EN = 1
      RCALL delay_short       ;make wide EN pulse
      CBI   PORTB, 0          ;EN = 0 for H-to-L pulse
      RCALL delay_us          ;delay in micro seconds
      ;----------------------------------------------------
      MOV   R18, R16
      SWAP  R18               ;swap nibbles
      ANDI  R18, 0xF0         ;mask low nibble & keep high nibble
      OUT   PORTD, R18        ;o/p high nibble to port D
      SBI   PORTB, 0          ;EN = 1
      RCALL delay_short       ;widen EN pulse
      CBI   PORTB, 0          ;EN = 0 for H-to-L pulse
      RCALL delay_us          ;delay in micro seconds
      RET
;================================================================
disp_start:
	  LDI   R16, 0x80         ;clear LCD
      RCALL command_wrt       ;send command code
      LDI   R16, 'A'          ;display characters
      RCALL data_wrt          ;via data register
      LDI   R16, 's'
      RCALL data_wrt
      LDI   R16, 't'
      RCALL data_wrt
      LDI   R16, 'e'
      RCALL data_wrt
      LDI   R16, 'r'
      RCALL data_wrt
      LDI   R16, 'o'
      RCALL data_wrt
      LDI   R16, 'i'
      RCALL data_wrt
      LDI   R16, 'd'
      RCALL data_wrt
      LDI   R16, ' '
      RCALL data_wrt
      LDI   R16, 'S'
      RCALL data_wrt
      LDI   R16, 'C'
      RCALL data_wrt
      LDI   R16, 'O'
      RCALL data_wrt
      LDI   R16, 'R'
      RCALL data_wrt
      LDI   R16, 'E'
      RCALL data_wrt
      LDI   R16, ':'
      RCALL data_wrt
	  LDI   R16, ' '
      RCALL data_wrt
      ;----------------
      LDI   R16, 0xC0         ;cursor beginning of 2nd line
      RCALL command_wrt
      ;----------------
	  LDI R16, 'P'
	  RCALL data_wrt
	  LDI R16, 'r'
	  RCALL data_wrt
	  LDI R16, 'e'
	  RCALL data_wrt
	  LDI R16, 's'
	  RCALL data_wrt
	  LDI R16, 's'
	  RCALL data_wrt
      LDI   R16, ' '
      RCALL data_wrt
      LDI   R16, 'T'
      RCALL data_wrt
      LDI   R16, 'o'
      RCALL data_wrt
      LDI   R16, ' '
      RCALL data_wrt
      LDI   R16, 'P'
      RCALL data_wrt
      LDI   R16, 'l'
      RCALL data_wrt
      LDI   R16, 'a'
      RCALL data_wrt
      LDI   R16, 'y'
      RCALL data_wrt
	  RCALL delay_seconds
      LDI   R16, '.'
      RCALL data_wrt
	  RCALL delay_seconds
	  LDI   R16, '.'
      RCALL data_wrt
	  RCALL delay_seconds
	  LDI   R16, '.'
      RCALL data_wrt
      ;----------------
      LDI   R17, 4           ;wait 2 seconds
l2:   RCALL delay_seconds
      DEC   R17
      BRNE  l2
      RET
;================================================================
game_overcall:
	  RCALL game_over
;================================================================
update_screen:
	  LDI   R16, 0xC0         ;cursor beginning of 2nd line
      RCALL command_wrt
	  CPI R23, ' '
	  BREQ pass
	  DEC R23
	  CP R22, R23
	  BRNE game_overcall
pass:
	  LDI R16, 0xFF
	  RCALL data_wrt
	  RCALL data_wrt
	  RCALL data_wrt
	  RCALL data_wrt
	  RCALL data_wrt
	  RCALL data_wrt
	  MOV R16, R22
	  RCALL data_wrt
	  MOV R23, R24
	  MOV R24, R25
	  MOV R25, R26
	  MOV R26, R27
	  MOV R27, R28
	  MOV R28, R29
	  MOV R29, R30
	  MOV R30, R31

	  MOV R16, R23
	  RCALL data_wrt
	  MOV R16, R24
	  RCALL data_wrt
	  MOV R16, R25
	  RCALL data_wrt
	  MOV R16, R26
	  RCALL data_wrt
	  MOV R16, R27
	  RCALL data_wrt
	  MOV R16, R28
	  RCALL data_wrt
	  MOV R16, R29
	  RCALL data_wrt
	  MOV R16, R30
	  RCALL data_wrt
	  MOV R16, R31
	  RCALL data_wrt
	  RCALL delay_seconds
	  RET
;================================================================
delay_short:
      NOP
      NOP
      RET
;------------------------
delay_us:
      LDI   R20, 90
l3:   RCALL delay_short
      DEC   R20
      BRNE  l3
      RET
;-----------------------
delay_ms:
      LDI   R21, 40
l4:   RCALL delay_us
      DEC   R21
      BRNE  l4
      RET
;================================================================
delay_seconds:
    LDI   R19, 255    ;outer loop counter 
l5: LDI   R20, 255    ;mid loop counter
l6: LDI   R21, 20     ;inner loop counter to give 0.25s delay
l7: DEC   R21         ;decrement inner loop
    BRNE  l7          ;loop if not zero
    DEC   R20         ;decrement mid loop
    BRNE  l6          ;loop if not zero
    DEC   R19         ;decrement outer loop
    BRNE  l5          ;loop if not zero
    RET               ;return to caller
;----------------------------------------------------------------