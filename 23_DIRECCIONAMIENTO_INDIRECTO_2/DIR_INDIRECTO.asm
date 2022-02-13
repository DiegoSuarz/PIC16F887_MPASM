DESCRIPCION:
;ESCRIBIR UN CODIGO QUE ESCRIBA EL VALOR 0XAB EN LOS SIGUIENTES
;REGISTROS: DEL REGISTRO 0X20 AL REGISTRO 0X6F DE LA RAM
			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\RETARDOS_MACROS.ASM> ;MACRO DE RETARDO
			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\PLANTILLA.ASM>	;CONFIGURACION BASICA

			;NOS DEJA EN EL BANCO 1	
					
;---------------------------MACROS-----------------------------------

;---------------------------DEFINE-----------------------------------

;-----------------------CODIGO PRINCIPAL------------------------------
;ETIQUETAS | NEMONICOS | OPERANDOS 		| COMENTARIOS	
			
			MOVLW		0X20
			MOVWF		FSR				;DIRECCIONAMIENTO INDIRECTO RPG DIRECCION 0X20
			
CARGA_DATO:	MOVLW		0XAB			;0X20 == 0XAB
			MOVWF		INDF
			
			INCF		FSR,F			;0X21
			
			MOVLW		0X70
			XORWF		FSR,W			;ES LA DIRECCION DE LA RAM ES IGUAL A 0X6F? -> Z==1
			
			BTFSS		STATUS,Z		;Z==1?		
			GOTO 		CARGA_DATO
			GOTO		$				;SE QUE EJECUTANDO SIEMPRE ESTA INSTRUCCION			
			
			
			
			

;--------------------------SUBRUTINAS--------------------------------


;---------------------------LIBRERIAS--------------------------------
;			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\RETARDOS.asm>
					
			END