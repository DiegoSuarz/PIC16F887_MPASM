;DESCRIPCION:
;UTILIZANDO INTERRUPCIONES POR LA TERMINAL RB0/INT
;ESCRIBE UN CODIGO QUE GENERE NUMEROS PSEUDOALEATORIOS Y LOS
;IMPRIMA EN EL LCD
;---------------------------MACROS-----------------------------------
PUSH_ANTIR	MACRO	PUERTO,PIN
			BTFSC	PUERTO,PIN
			GOTO    $-1
			CALL	SUBT25MS
			BTFSS	PUERTO,PIN
			GOTO	$-1
			CALL	SUBT25MS
			ENDM


;---------------------------DEFINE-----------------------------------

;----------------------------EQU--------------------------------------

;--------------------------CBLOCK-------------------------------------
					CBLOCK		0X70
								SAVE_W,SAVE_STATUS,SAVE_PC
					ENDC

					CBLOCK		0X25
								UNIDADES,DECENAS,CENTENAS
					ENDC
;---------------------------HEADER------------------------------------


					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\MACROS_LCD.ASM>		
					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\RETARDOS_MACROS.ASM> ;MACRO DE RETARDO
					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\MACROS_CONFIGURACION_BASICA.ASM> ;MACRO DE CONFIGURACION BASICA
	
 					PROCESSOR	16F887
		 			__CONFIG	0X2007,23E4
					__CONFIG	0X2008,3FFF
					INCLUDE		<P16F887.INC>

					ORG			0X0000			;EMPEZAR EN LA DIRECCION 0 DE LA MEMORIA DE PROGRAMA
					GOTO		INICIALIZA
					ORG			0X0004

					MOVWF		SAVE_W
					SWAPF		STATUS,W
					MOVWF		SAVE_STATUS
					CLRF		STATUS
					MOVF		PCLATH,W
					MOVWF		SAVE_PC
					MOVF		0X60,W
					MOVWF		0X75
					MOVF		0X61,W
					MOVWF		0X76 
					MOVF		0X61,W
					MOVWF		0X76
					MOVF		0X62,W
					MOVWF		0X77
					MOVF		0X63,W
					MOVWF		0X78
					MOVF		0X64,W
					MOVWF		0X79
					MOVF		0X65,W
					MOVWF		0X7A
					MOVF		0X66,W
					MOVWF		0X7B
					MOVF		0X67,W
					MOVWF		0X7C
					MOVF		0X68,W
					MOVWF		0X7D

					GOTO		ISR
					CONFIGURACION
			;NOS DEJA EN EL BANCO 1	

;-----------------------CODIGO PRINCIPAL------------------------------
;ETIQUETAS			|NEMONICOS		| OPERANDOS 		| COMENTARIOS	
					CLRF			TRISB

					BCF				OPTION_REG,INTEDG	;DETECCION DE FLANCO DE BAJADA
					BCF				INTCON,INTF			;LIMPIAR BANDERA DE INTERRUPCION
					BSF				INTCON,INTE			;HABILITAR INTERRUPCION EXTERNA
					BSF				INTCON,GIE			;HABILITAR INTERRUPCIONES GLOBALES

					BCF				STATUS,RP0
					CALL			INIT_LCD
					FILA1_COLUMNA	.0
					MENSAJE_FILA1
					FILA2_COLUMNA	.0
					MENSAJE_FILA2	
					BSF				STATUS,RP0
					COMF			TRISB,F				;PUERTO B COMO ENTRADA
				
					BCF				STATUS,RP0
					
				

					INCF			0X21,F
					GOTO			$-1	

					BCF				STATUS,RP0
					
				
						

;------------------SUBRUTINAS DE INTERRUPCION-------------------------
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

					;MOVLW			0X4D					;UBICAMOS EL CURSOR EN LA FILA 2 COLUMNA 12
					;CALL			DIRECCION_DDRAM
					FILA2_COLUMNA	.13
					MOVF			CENTENAS,W
					CALL			ESCRIBE_CARACTER
					MOVF			DECENAS,W
					CALL			ESCRIBE_CARACTER
					MOVF			UNIDADES,W
					CALL			ESCRIBE_CARACTER

				
					
					BSF				STATUS,RP0
					COMF			TRISB,F				;PUERTO B COMO ENTRADA
					BCF				STATUS,RP0
					
					BCF				INTCON,INTF				;LIMPIAMOS LA BANDERA DE INTERRUPCION
					
					MOVF			0X75,W
					MOVWF			0X60
					MOVF			0X76,W
					MOVWF			0X61
					MOVF			0X77,W
					MOVWF			0X62
					MOVF			0X78,W
					MOVWF			0X63
					MOVF			0X78,W
					MOVWF			0X64
					MOVF			0X7A,W
					MOVWF			0X65
					MOVF			0X7B,W
					MOVWF			0X66
					MOVF			0X7C,W
					MOVWF			0X67
					MOVF			0X7D,W
					MOVWF			0X68
					MOVF			SAVE_PC,W
					MOVWF			PCLATH
					SWAPF			SAVE_STATUS,W
					MOVWF			STATUS
					SWAPF			SAVE_W,F
					SWAPF			SAVE_W,W
					RETFIE			
					
;-------------------------SUBRUTINAS----------------------------------
SUBT25MS:			RETARDO_3V		.3,.47,.25
;---------------------------TABLAS------------------------------------


;----------------------------TABLAS_LCD-------------------------------
;************************************                *****************
					MENSAJE_F1		"EL NUMERO       "		
					MENSAJE_F2		"ALEATORIO ES:   "	

;---------------------------LIBRERIAS--------------------------------
					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\LIBRERIA_RETARDOS.asm>
					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\LIBRERIA_LCD.asm>		
					END

;COMENTARIOS
;PARA INICIALIZAR PANTALLA LCD: LLAMAR SUBRUTINA   INIT_LCD
;PARA ESCOJER UNA COLUMNA DE LA FILA1:  	FILA1_COLUMNA	.X		X: 0-15
;MOSTRAR MENSAJE EN LA FILA 1 CON LA MACRO  	MENSAJE_FILA1	
;PARA ESCOJER UNA COLUMNA DE LA FILA2:  	FILA2_COLUMNA	.X		X: 0-15
;MOSTRAR MENSAJE EN LA FILA 2 CON LA MACRO  	MENSAJE_FILA2	