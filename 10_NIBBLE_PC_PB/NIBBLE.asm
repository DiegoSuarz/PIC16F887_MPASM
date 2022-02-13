;DESCRIPCION:
;LEA EL NIBBLE BAJO DEL PC
;Y SAQUE ESE VALOR COMO EL NIBBLE ALTO DEL PD.
;LEA EL NIBBLE ALTO DEL PB
;Y SAQUE ESE VALOR COMO EL NIBBLE BAJO DEL PD:

			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\00_PLANTILLA\PLANTILLA.ASM>
			;NOS DEJA EN EL BANCO 1	
CBLOCK	0x20				    
	VAR
	VAR1
 ENDC			
;ETIQUETAS | NEMONICOS | OPERANDOS 		| COMENTARIOS	
			
			MOVLW		0XFF
			MOVWF		TRISC
			MOVWF		TRISB
			CLRF		TRISD
			BCF			STATUS,RP0
			
LOOP:
			MOVF		PORTB,W			;lEER PUERTO B, PB->W
			MOVWF		0X20			;MOVER EL RESULTADO A LA POSICION 20 DE LA MEMORIA RAM, DONDE EMPIEZAN LOS REGISTRO DE PROPOSITO GENERAL Y SIRVE PARA ALMACENAR VARIABLES
			SWAPF		0X20,F			;INTERVAMBIAR NIBBLES EJM: 0X21 -> 0X12
			MOVLW		0X0F		
			ANDWF		0X20,F			;HACER UNA MASCARA PARA PASAR SOLO LOS NIBBLE BAJOS Y GUARDAR EL RESULTADO EN LA MISMA VARIABLE	

			MOVF		PORTC,W
			MOVWF		0X21
			SWAPF		0X21,F
			MOVLW		0XF0
			ANDWF		0X21,W
			IORWF		0X20,W
			MOVWF		PORTD
			
			GOTO		LOOP
						
			END