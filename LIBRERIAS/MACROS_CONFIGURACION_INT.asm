;PLANTILLA PARA CONFIGURACION BASICA
VECTOR_INTERRUPCION		MACRO		
					ORG			0X0004			;VECTOR DE INTERRUPCION
					SAVE_REG					;GUARDAR REGISTROS DE INTERES
					GOTO		ISR				;IR A RUTINA DE SERVICIO DE INTERRUPCION
				ENDM



;ETIQUETAS | NEMONICOS | OPERANDOS 		| COMENTARIOS	

CONFIGURACION		MACRO
		
INICIALIZA:   		BSF			STATUS,RP0
					BSF			STATUS,RP1		;ACCEDIENDO AL BANCO 3
					CLRF		ANSEL
					CLRF		ANSELH			;TODOS LOS PINES DIGITALES
			
					BCF			STATUS,RP1
					BSF			STATUS,RP0		;ACCEDIENDO AL BANCO 1
					CLRF		TRISA			;PUERTO A COMO ENTRADA
					CLRF		TRISB			;PUERTO B COMO SALIDA
					CLRF		TRISC			;PUERTO C COMO ENTRADA
					CLRF		TRISD			;PUERTO D COMO SALIDA
					CLRF		TRISE			;PUERTO E COMO ENTRADA
			

					BCF			STATUS,RP0		
					BCF			STATUS,RP1		;ACCEDIENDO AL BANCO 0
					CLRF		PORTA			;LIMPIAR EL PUERTO A
					CLRF		PORTB			;LIMPIAR EL PUERTO B
					CLRF		PORTC			;LIMPIAR EL PUERTO C
					CLRF		PORTD			;LIMPIAR EL PUERTO D
					CLRF		PORTE			;LIMPIAR EL PUERTO E
		
					BCF			STATUS,RP1
					BSF			STATUS,RP0		;ACCEDIENDO AL BANCO 1
					ENDM	

	PROCESSOR	16F887
		 			__CONFIG	0X2007,23E4
					__CONFIG	0X2008,3FFF
					INCLUDE		<P16F887.INC>	