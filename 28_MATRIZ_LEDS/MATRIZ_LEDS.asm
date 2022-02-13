;DESCRIPCION:
;PRUEBA DE MATRIZ DE LEDS
;PORTB =  RENGLONES, ACTIVAS LOS RENGLONES CON 0s 
;PORTD = DATOS 
;---------------------------MACROS-----------------------------------

;---------------------------DEFINE-----------------------------------

;----------------------------EQU--------------------------------------

;---------------------------HEADER--------------------------------------
					
			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\RETARDOS_MACROS.ASM> ;MACRO DE RETARDO
			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\PLANTILLA.ASM>	;CONFIGURACION BASICA

			;NOS DEJA EN EL BANCO 1	

;-----------------------CODIGO PRINCIPAL------------------------------
;ETIQUETAS			|NEMONICOS		| OPERANDOS 		| COMENTARIOS	
					CLRF			TRISD				;PUERTO D COMO SALIDA
					CLRF			TRISB				;PUERTO B COMO SALIDA
					BCF				STATUS,RP0			;ACCEDER AL BANCO 0
					COMF			PORTB,F				;COMPLEMENTO AL PORTB
		
LIMPIA				BCF				STATUS,C			;LIMPIAR EL BIT DE ACARREO
					BSF				PORTD,0				;RD0 EN ALTO
SACA_DATO			COMF			PORTD,W				;COMPLEMENTO AL PORTB -> W
					MOVWF			PORTB				; PORTB = W
				
					RETARDO_3V		.79,.3,.253			;RETARDO DE 500mS
				
					RLF				PORTD,F				;DESPLEZAR UN BIT A LA IZQUIERDA
					BTFSS			STATUS,C			;EL BIT CARRY ESTA EN ALTO?
					GOTO			SACA_DATO			;NO, SACA EL DATO HASTA QUE EL BIT DE ACARREO  ESTE EN ALTO
					GOTO			LIMPIA				;SI, LIMPIA EL ACARREO Y VUELVE A EMPEZAR
					
;--------------------------SUBRUTINAS--------------------------------


;---------------------------LIBRERIAS--------------------------------
			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\RETARDOS.asm>
					
			END