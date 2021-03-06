DESCRIPCION:
;PORTD = PWM F = 1000HZ. CADA QUE SE APRIENTE A RE0, CAMBIAR EL PWM A:
;a) 0% AL 5%
;b) 5% AL 20%
;c) 20% AL 50%
;d) 50% AL 80%
;e) 80% A 0% Y COMENZAR DENUEVO
;MOSTRAR RE2=1  PARA COMPARAR  CON EL PWM.

			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\MACROS_RETARDO.ASM> ;MACRO DE RETARDO
			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\PLANTILLA.ASM>	;CONFIGURACION BASICA

			;NOS DEJA EN EL BANCO 1	
					
;---------------------------MACROS-----------------------------------
PUSH_ANTIR	MACRO	PUERTO,PIN
			BTFSS	PUERTO,PIN
			GOTO    $-1
			CALL	T25MS
			BTFSC	PUERTO,PIN
			GOTO	$-1
			CALL	T25MS
			ENDM

;SUBT25MS	MACRO
;T25MS:		SUBT3V	.3,.47,.25
;			RETURN
;			ENDM
;---------------------------DEFINE-----------------------------------

;ETIQUETAS | NEMONICOS | OPERANDOS 		| COMENTARIOS	
			MOVLW		0X01
			MOVWF		TRISE			;RE0 COMO ENTRADA			
			CLRF		TRISD			;PUERTO D COMO SALIDA
			BCF			TRISE,2			;RE2 COMO SALIDA
			BCF			STATUS,RP0		;BANCO 0
			CLRF		PORTD
		
			BSF			PORTE,2			;RE2 EN ALTO
INICIO:		CALL		TEST_RE0
PWM5:		COMF		PORTD,F
			SUBT3V		.1,.2,.2		;RETARDO 50uS
			COMF		PORTD,F			
			SUBT2V		.9,.14			;RETARDO 950uS
			NOP
			BTFSS		PORTE,0			;RE0==1?
			GOTO		PWM5

			CALL		TEST_RE0
PWM20:		COMF		PORTD,F
			SUBT2V		.4,.6			;RETARDO 200uS
			COMF		PORTD,F			
			SUBT2V		.37,.3			;RETARDO 800uS
			BTFSS		PORTE,0			;RE0==1?
			GOTO		PWM20

			CALL		TEST_RE0
PWM50:		COMF		PORTD,F
			SUBT2V		.17,.4			;RETARDO 500uS
			COMF		PORTD,F			
			SUBT1V		.70 			;RETARDO 500uS
			NOP
			BTFSS		PORTE,0			;RE0==1?
			GOTO		PWM20	


			CALL		TEST_RE0
PWM80:		COMF		PORTD,F
			SUBT2V		.1,.72			;RETARDO 800uS
			COMF		PORTD,F			
			SUBT1V		.27 			;RETARDO 200uS
			NOP
			NOP
			BTFSS		PORTE,0			;RE0==1?
			GOTO		PWM80						
					
			CALL		TEST_RE0
			CLRF		PORTD
			GOTO		INICIO


TEST_RE0
			PUSH_ANTIR	PORTE,0			;RE0 == 1?


T25MS:		SUBT3V	.3,.47,.25
			RETURN


			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\RETARDOS.asm>
					
			END