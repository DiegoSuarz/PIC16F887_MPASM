;DESCRIPCION:
;INICIALIZAR LA PANTALLA LCD
;(PB0-PB3 SE CONECTAN A D4-D7 DE LA LCD
;RS SE CONECTA A PB4 Y E  A PB5
;IMPRIME USANDO 4BITS DE BUS DE DATOS
;LAS CADENAS (EN LA LCD):
;"ENSAMBLADOR PARA"
;"PIC16F887       :)"
;---------------------------MACROS-----------------------------------

;---------------------------DEFINE-----------------------------------
#DEFINE		RS_0	BCF		PORTB,4
#DEFINE		RS_1	BSF		PORTB,4
#DEFINE		E_0		BCF		PORTB,5
#DEFINE		E_1		BSF		PORTB,5
;----------------------------EQU--------------------------------------
DATO		EQU		0X2A
;---------------------------HEADER--------------------------------------
					
			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\RETARDOS_MACROS.ASM> ;MACRO DE RETARDO
			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\PLANTILLA.ASM>	;CONFIGURACION BASICA

			;NOS DEJA EN EL BANCO 1	

;-----------------------CODIGO PRINCIPAL------------------------------
;ETIQUETAS			|NEMONICOS		| OPERANDOS 		| COMENTARIOS	
					CLRF			TRISB
					BCF				STATUS,RP0
					CALL			INIT_LCD
					
					CLRF			0X20
TABLA_1				MOVF			0X20,W
					CALL			TABLA_LCD
					CALL			ESCRIBE_CARACTER
					INCF			0X20,F
					MOVLW			.16
					XORWF			0X20,W
					BTFSS			STATUS,Z
					GOTO			TABLA_1
					
					MOVLW			0X40					;POSICIONARSE EN LA SEGUNDA FILA
					CALL			DIRECCION_DDRAM


					MOVLW			.16
					MOVWF			0X20
TABLA_2				MOVF			0X20,W
					CALL			TABLA_LCD
					CALL			ESCRIBE_CARACTER
					INCF			0X20,F
					MOVLW			.32
					XORWF			0X20,W
					BTFSS			STATUS,Z
					GOTO			TABLA_2
					CALL			LCD_ON			
					GOTO			TABLA_1
					

					
;--------------------------SUBRUTINAS--------------------------------
INIT_LCD:			RETARDO_2V		.61,.232			;100mS
					CALL			MINISALUDO
					CALL			MINISALUDO
					CALL			MINISALUDO
					MOVLW			B'00000010'
					MOVWF			PORTB
					CALL			ACTIVA_E
					CALL			FUNCTION_SET
					CALL			LCD_OFF
					CALL			LIMPIA_LCD
					CALL			ENTRY_MODE
					RETURN					 			

FUNCTION_SET:		MOVLW			B'00101000'			;4BITS, 2FILAS, 5X7 PIXELS	
					GOTO			ESCRIBE_DATO

LCD_OFF:			MOVLW			B'00001000'			
					GOTO			ESCRIBE_DATO

LIMPIA_LCD:			MOVLW			B'00000001'
					GOTO			ESCRIBE_DATO

ENTRY_MODE:			MOVLW			B'00000110'			;NO RECORRE INFORMACION AL ESCRIBIR,APUNTADOR CON INCREMENTE
					GOTO			ESCRIBE_DATO

LCD_ON:				MOVLW			B'00001100'
					GOTO			ESCRIBE_DATO

LCD_ON_CURSOR:		MOVLW			B'00001110'
					GOTO			ESCRIBE_DATO	

LCD_ON_CURS_BLINK:  MOVLW			B'00001111'
					GOTO			ESCRIBE_DATO

HOME:				MOVLW			B'00000010'
					GOTO			ESCRIBE_DATO	

RECORRE_DER_LCD:	MOVLW			B'00011100'
					GOTO			ESCRIBE_DATO	

RECORRE_IZQ_LCD:	MOVLW			B'00011000'
					GOTO			ESCRIBE_DATO	

RECORRE_DER_CUR:	MOVLW			B'00010100'
					GOTO			ESCRIBE_DATO	

RECORRE_IZQ_CUR:	MOVLW			B'00010000'
					GOTO			ESCRIBE_DATO

DIRECCION_DDRAM:	IORLW			B'10000000'
					GOTO			ESCRIBE_DATO
	
ESCRIBE_CARACTER:	MOVWF			DATO
					SWAPF			DATO,W
					ANDLW			B'00001111'
					MOVWF			PORTB
					RS_1
					CALL			ACTIVA_E			;ENVIAR LOS 4BITS MSB
					MOVF			DATO,W
					ANDLW			B'00001111'
					MOVWF			PORTB
					RS_1
					CALL			ACTIVA_E			;ENVIAR LOS 4BITS LSB
					RETURN 

ESCRIBE_DATO:		MOVWF			DATO
					SWAPF			DATO,W
					ANDLW			B'00001111'
					MOVWF			PORTB
					CALL			ACTIVA_E			;ENVIAR LOS 4BITS MSB
					MOVF			DATO,W
					ANDLW			B'00001111'
					MOVWF			PORTB
					CALL			ACTIVA_E			;ENVIAR LOS 4BITS LSB
					RETURN 

					
MINISALUDO:			MOVLW			B'00000011'
					MOVWF			PORTB
					CALL			ACTIVA_E
					RETARDO_2V		.4,.156				;5mS
					RETURN

ACTIVA_E:			E_1
					NOP
					NOP
					NOP
					NOP
					NOP
					E_0
					RETARDO_2V		.35,.8
					RETURN
;----------------------------TABLAS----------------------------------
TABLA_LCD			ADDWF			PCL,F
					DT				"ENSAMBLADOR PARA"
					DT				"PIC16F887     :)"
;---------------------------LIBRERIAS--------------------------------
			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\RETARDOS.asm>
					
			END