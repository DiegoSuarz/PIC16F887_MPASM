DESCRIPCION:
;HAGA QUE EL PUERTO B CAMBIE DEL VALOR 0X00 AL VALOR 0XFF CON ESPACIOS
;DE TIEMPO DE 500MS.
;LOS REGISTROS TRIS Y PORT DEBEN SER USADOS EN MODO INDIRECTO.

			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\MACROS_RETARDO.ASM> ;MACRO DE RETARDO
			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\PLANTILLA.ASM>	;CONFIGURACION BASICA

			;NOS DEJA EN EL BANCO 1	
					
;---------------------------MACROS-----------------------------------

;---------------------------DEFINE-----------------------------------

;-----------------------CODIGO PRINCIPAL------------------------------
	
;ETIQUETAS | NEMONICOS | OPERANDOS 		| COMENTARIOS	
			
			BCF			STATUS,RP0
			BCF			STATUS,IRP		;9NO BIT (MSB) PARA EL DIRECCIONAMIENTO INDIRECTO, YA QUE PARA EL DIRECCIONAMIENTO SE USAN 9 BITS
			MOVLW		0X86			;DIRECCION DE MEMORIA DEL REGISTRO TRISB
			MOVWF		FSR				;REGISTRO QUE ALMACENA LOS 8 BITS LSB PARA EL DIRECCINAMIENTO INDIRECTO
			CLRF		INDF			;REGISTRO QUE PERMITE EL DIRECCIONAMIENTO INDIRECTO, SE BORRA EL REGISTRO DE LA DIRECCION 0X86(TRISB = 0X00)  
			
LOOP:		SUBT3V		.79,.3,.253		;RETARDO DE 500mS
			MOVLW		0X06			;DIRECCION DE REGISTRO PORTB
			MOVWF		FSR				
			COMF		INDF,F			;COMPLEMENTO DEL PUERTO B
			GOTO		LOOP
;-----------------------------SUBRUTINAS--------------------------------


;------------------------------LIBRERIAS--------------------------------
			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\RETARDOS.asm>
					
			END