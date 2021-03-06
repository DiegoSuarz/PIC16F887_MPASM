;DESCRIPCION:
;USAR LAS DIRECTIVAS "DEFINE" Y "MACROS"
			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\MACROS_RETARDO.ASM>
			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\PLANTILLA.ASM>

			;NOS DEJA EN EL BANCO 1	
					
;---------------------------MACROS-----------------------------------
PUSH_ANTIR	MACRO		PUERTO,PIN
			BTFSS		PUERTO,PIN
			GOTO		$-1
			CALL		T25MS
			BTFSC		PUERTO,PIN
			GOTO		$-1
			CALL		T25MS
			ENDM

;---------------------------DEFINE-----------------------------------
	#DEFINE		P_SALIDA	PORTD				

;ETIQUETAS | NEMONICOS | OPERANDOS 		| COMENTARIOS	
			
			MOVLW		0X01
			MOVWF		TRISE
			CLRF		TRISD
			BCF			STATUS,RP0
			
		;	PUSH_ANTIR	PORTE,0
			MOVLW		0XF0
			MOVWF		P_SALIDA
			CALL		T200MS
			SWAPF		P_SALIDA,F
			GOTO    	$-2
			
T25MS:		SUBT3V		.3,.47,.25
			RETURN

T200MS:		SUBT2V		.117,.243
			RETURN		
			

			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\RETARDOS.asm>
					
			END