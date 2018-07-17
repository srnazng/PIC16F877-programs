
#include <p16f887.inc>
__CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _BOREN_OFF & _LVP_OFF & _CPD_OFF & _WRT_OFF & _CP_OFF

	ORG 0
	GOTO main
	ORG 4
	GOTO isr
	
count1 EQU 0x20
 count2 EQU 0x21
 count3 EQU 0x22

main:
	BANKSEL TRISD
	MOVLW 0x00
	MOVWF TRISD
	BANKSEL TRISA
	MOVLW 0xFF
	MOVWF TRISA
	BANKSEL ADCON1
	MOVLW 0x06
	MOVWF ADCON1
	BANKSEL PORTD
	MOVLW 0x01
	MOVWF PORTD
	
setup:
	BTFSC PORTA, 0
	GOTO right
	GOTO left
	
left:
	RLF PORTD, 1 
	CALL delay
	GOTO setup

right:
	RRF PORTD, 1
	CALL delay
	GOTO setup
	
delay: 
	MOVLW .100
	MOVWF count1
loop1:
	MOVLW .100
	MOVWF count2
loop2:	
	MOVLW .25
	MOVWF count3
loop3: 
	NOP
	DECFSZ count3
	GOTO loop3
	
	DECFSZ count2
	GOTO loop2
	
	DECFSZ count1
	GOTO loop1
	
	RETURN
	
isr:
	NOP
	RETFIE

	END