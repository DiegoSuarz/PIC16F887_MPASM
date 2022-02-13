;DESCRIPCION:
;
;---------------------------MACROS----------------------------
PUSH_ANTIR	MACRO	PUERTO,PIN
			BTFSC	PUERTO,PIN
			GOTO    $-1
			CALL	SUBT25MS
			BTFSS	PUERTO,PIN
			GOTO	$-1
			CALL	SUBT25MS
			ENDM

;---------------------------DEFINE----------------------------
;----------------------------EQU------------------------------
;---------------------------CBLOCK----------------------------
CBLOCK		0X25
					UNIDADES,DECENAS,CENTENAS
			ENDC
;---------------------------HEADER----------------------------
					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\MACROS_INTERRUPT.ASM>	;MACRO PARA EL USO DE INTERRUPCIONES
					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\MACROS_LCD.ASM>	;MACRO PARA EL USO DISPLAY LCD
					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\MACROS_7SEG.ASM>	;MACRO PARA EL USO DISPLAY 7 SEG					
					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\RETARDOS_MACROS.ASM> ;MACRO DE RETARDO
					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\MACROS_CONFIGURACION_INT.ASM> ;MACRO DE CONFIGURACION BASICA
					ORG			0X0000			;EMPEZAR EN LA DIRECCION 0 DE LA MEMORIA DE PROGRAMA
					GOTO		INICIALIZA
					VECTOR_INTERRUPCION			;SI SE USA INTERRUPCIONES DESCOMENTAR
;					SIETE_SG_KC				;SI SE USA DISPLAY 7 SEG DESCOMENTAR
					
;************************************************************************                *************************************************************************
TABLA_LCD			ADDWF			PCL,F
LCD_FILA1			ADDWF			PCL,F
					DT				"EL NUMERO       "
LCD_FILA2			ADDWF			PCL,F
					DT				"ALEATORIO ES    "						
					CONFIGURACION				;NOS DEJA EN EL BANCO 1
;-----------------------CODIGO PRINCIPAL------------------------------
;ETIQUETAS			|NEMONICOS		| OPERANDOS 		| COMENTARIOS	
					CLRF			TRISB

;************CONFIGURACION INTERRUPCION EXTERNA***************************************
					BCF				OPTION_REG,INTEDG	;DETECCION DE FLANCO DE BAJADA
					BCF				INTCON,INTF			;LIMPIAR BANDERA DE INTERRUPCION
					BSF				INTCON,INTE			;HABILITAR INTERRUPCION EXTERNA
					BSF				INTCON,GIE			;HABILITAR INTERRUPCIONES GLOBALES

					BCF				STATUS,RP0			;BANCO 0

					CALL			INIT_LCD	
					FILA1_POSICION	.0
					CALL			MENSAJE_FILA1
					FILA2_POSICION	.0
					CALL			MENSAJE_FILA2

					BSF				STATUS,RP0			;BANCO 1
					COMF			TRISB,F				;PUERTO B COMO ENTRADA
					BCF				STATUS,RP0			;BANCO 0

					INCF			0X21,F				;INCREMENTAR REGISTRO DE PROPOSITO GENERAL
					GOTO			$-1					;IR A LA POSICION ANTERIOR

;*************************************************************************
					
;*************************************************************************
					
;------------------SERVICIO DE RUTINA DE INTERRUPCION-----------------
ISR:				PUSH_ANTIR		PORTB,0
					CLRF			UNIDADES
					CLRF			DECENAS
					CLRF			CENTENAS

;******************EXTRAER CENTENAS*********************************
RESTA100:			MOVLW			.100
					SUBWF			0X21,F
					BTFSS			STATUS,C
					GOTO			SUMA100
					INCF			CENTENAS,F
					GOTO			RESTA100
SUMA100:			MOVLW			.100
					ADDWF			0X21,F

;******************EXTRAER DECENAS*********************************
RESTA10:			MOVLW			.10
					SUBWF			0X21,F
					BTFSS			STATUS,C
					GOTO			SUMA10
					INCF			DECENAS,F
					GOTO			RESTA10
SUMA10:				MOVLW			.10
					ADDWF			0X21,F

;******************EXTRAER UNIDADES*********************************
					MOVF			0X21,W
					MOVWF			UNIDADES

					BSF				STATUS,RP0
					COMF			TRISB,F				;PUERTO B COMO ENTRADA PARA ENVIAR COMANDOS LCD
					BCF				STATUS,RP0
			
;***************DE BCD A DECIMAL USANDO CAR ASCII*****************		
					MOVLW			0X30				;EN CODIGO ASCII LOS NUMERO EMPIEZAN DESDE LA POSICION 0X30
					ADDWF			UNIDADES,F
					ADDWF			DECENAS,F
					ADDWF			CENTENAS,F
				
					FILA2_POSICION	.13					;UBICAMOS EL CURSOR EN LA FILA 2 COLUMNA 14
					MOVF			CENTENAS,W
					CALL			ESCRIBE_CARACTER	;ESCRIBE CARACTER DE CENTENAS EN LA POSICION 14
					MOVF			DECENAS,W						
					CALL			ESCRIBE_CARACTER	;ESCRIBE CARACTER DE DECENAS EN LA POSICION 15
					MOVF			UNIDADES,W
					CALL			ESCRIBE_CARACTER	;ESCRIBE CARACTER DE UNIDADES EN LA POSICION 16

				
					BSF				STATUS,RP0			;BANCO 1
					COMF			TRISB,F				;PUERTO B COMO ENTRADA
					BCF				STATUS,RP0			;BANCO 0
					
					BCF				INTCON,INTF			;LIMPIAMOS LA BANDERA DE INTERRUPCION	
				
					RESTORE_REG							;RESTAURAMOS LOS REGISTROS DE INTERES
					RETFIE								;REGRESAMOS DE LA INTERRUPCION
					
;-------------------------SUBRUTINAS----------------------------------
SUBT25MS:			RETARDO_3V		.3,.47,.25
					RETURN
;---------------------------TABLAS------------------------------------
;---------------------------LIBRERIAS--------------------------------
					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\LIBRERIA_RETARDOS.asm>
					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\LIBRERIA_LCD.asm>		
					END
;*************************************************************************
;COMENTARIOS
;PARA USAR ANTIREBOTE COPIAR EN SUBRUTINA 	SUBT25MS:			RETARDO_3V		.3,.47,.25
;*************************************************************************
;PARA INICIALIZAR PANTALLA LCD: LLAMAR SUBRUTINA   INIT_LCD
;PARA ESCOJER UNA COLUMNA DE LA FILA1:  	FILA1_POSICION	.X		X: 0-15
;MOSTRAR MENSAJE 1 LLAMAMOS A LA SUBRUTINA 	CALL			MENSAJE_FILA1
;PARA ESCOJER UNA COLUMNA DE LA FILA2:  	FILA2_POSICION	.X		X: 0-15
;MOSTRAR MENSAJE 2 LLAMAMOS A LA SUBRUTINA 	CALL			MENSAJE_FILA2