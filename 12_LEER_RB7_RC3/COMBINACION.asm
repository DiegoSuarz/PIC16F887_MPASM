;DESCRIPCION:
;PB.7==0 ,PC.3==0 -> PD=0XF3 ,PA=0X89
;PB.7==0 ,PC.3==1 -> PD=0X45 ,PA=0X7C
;PB.7==1 ,PC.3==0 -> PD=0X94 ,PA=0X42
;PB.7==1 ,PC.3==1 -> PD=0XFF ,PA=0XDE

			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\00_PLANTILLA\PLANTILLA.ASM>
			;NOS DEJA EN EL BANCO 1	
			
;ETIQUETAS | NEMONICOS | OPERANDOS 		| COMENTARIOS	
			
			MOVLW		0XFF
			MOVWF		TRISB
			MOVWF		TRISC
			CLRF		TRISD
			CLRF		TRISA
			BCF			STATUS,RP0
			
LOOP	
			BTFSC		PORTB,7
			GOTO		COMP_1
			BTFSC		PORTC,3				;PB.7==0 ,PC.3==0
			GOTO 		COMBINACION_1		;PB.7==0 ,PC.3==1
			MOVLW		0XF3 				
			MOVWF		PORTD
			MOVLW		0X89
			MOVWF		PORTA
			GOTO		LOOP
			
COMP_1			
			BTFSC		PORTC,3				;PB.7==1 ,PC.3==0
			GOTO		COMBINACION_2		;PB.7==1 ,PC.3==1
			MOVLW		0X94				
			MOVWF		PORTD
			MOVLW		0X42 
			MOVWF		PORTA
			GOTO		LOOP
			GOTO 		LOOP
			
COMBINACION_1 								
			MOVLW		0X45  
			MOVWF		PORTD
			MOVLW		0X7C
			MOVWF		PORTA
			GOTO		LOOP
			

COMBINACION_2 
			MOVLW		0XFF 
			MOVWF		PORTD
			MOVLW		0XDE 
			MOVWF		PORTA
			GOTO		LOOP	
			END