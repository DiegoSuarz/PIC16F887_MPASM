;DESCRIPCION:
;USANDO EL TIMER 0 COMO FUENTE DE INTERRUPCION,
;DEBE CONTAR EVENTOS POR LA TERMINAL RA4,
;AL LLEGAR A 2500 DEBE EMITIR UN TONO DE 1KHZ(RC2) DURANTE 500ms
;EN EL PROGRAMA PRINCIPAL ESTARÁ DE FORMA PERMANENTE EL CONTADOR DE 
;00 A 99 POR LOS DISPLAYS DE 7 SEGMENTOS, PERO ESTA SECUENCIA TAMBIÉN
;PUEDE SER INTERRUPIDA POR RB0/INT, AL ENTRAR A LA INTERRUPCION 
;GENERARÁ EL NUMERO ALEATORIO Y LO IMPRIMIRÁ EN LA LCD
;---------------------------MACROS----------------------------
;---------------------------DEFINE----------------------------
;----------------------------EQU------------------------------
CONT5 EQU 0X20
CONT_T0 EQU 0X23
DECIMAL EQU 0X24
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
					CONFIGURACION				;NOS DEJA EN EL BANCO 1
;-----------------------CODIGO PRINCIPAL------------------------------
;ETIQUETAS			|NEMONICOS		| OPERANDOS 		| COMENTARIOS	
					CLRF			TRISB
					CLRF			TRISD
					BCF				TRISA,0
					BCF				TRISC,1
					BCF				TRISC,2
				;	BSF				STATUS,RP0
					MOVLW			B'11010101'
					MOVWF			OPTION_REG
					BCF				STATUS,RP0
					CLRF			CONT_T0
					
					MOVLW			.131				;TIMER CUENTA A 125 X 64 PREE = 8000
					MOVWF			TMR0
					
					MOVLW			.125
					MOVWF			CONT5
					
					BCF				INTCON,T0IF
					BSF				INTCON,T0IE
					BSF				INTCON,GIE
					
					CALL			INIT_LCD
					FILA1_COLUMNA	.0
					MENSAJE_FILA1
		;			FILA1_COLUMNA	.0
		;			MENSAJE_FILA1
					FILA2_COLUMNA	.0
					MENSAJE_FILA2
				
;*************************************************************************
					GOTO			$
;*************************************************************************
					
;------------------SERVICIO DE RUTINA DE INTERRUPCION-----------------
ISR:				BTFSS			INTCON,T0IF	
					GOTO			FIN_INT
					DECFSZ			CONT5,F
					GOTO			CLR_FLAG
					MOVLW			.125
					MOVWF			CONT5
					
					INCF			CONT_T0,F
					
					MOVF			CONT_T0,W
					MOVWF			DECIMAL
					CALL			BIN_A_ASCII
					
					FILA1_COLUMNA	.13					;UBICAMOS EL CURSOR EN LA FILA 2 COLUMNA 14
					MOVF			CENTENAS,W
					CALL			ESCRIBE_CARACTER	;ESCRIBE CARACTER DE CENTENAS EN LA POSICION 14
					MOVF			DECENAS,W						
					CALL			ESCRIBE_CARACTER	;ESCRIBE CARACTER DE DECENAS EN LA POSICION 15
					MOVF			UNIDADES,W
					CALL			ESCRIBE_CARACTER	;ESCRIBE CARACTER DE UNIDADES EN LA POSICION 16
					
CLR_FLAG:			MOVLW			.131
					MOVWF			TMR0
					BCF				INTCON,T0IF
						 			
					
FIN_INT:			RESTORE_REG							;RESTAURAMOS LOS REGISTROS DE INTERES
					RETFIE								;REGRESAMOS DE LA INTERRUPCION
					
;-------------------------SUBRUTINAS----------------------------------

					
BIN_A_ASCII:		CLRF			UNIDADES
					CLRF			DECENAS
					CLRF			CENTENAS

;******************EXTRAER CENTENAS*********************************
RESTA100:			MOVLW			.100
					SUBWF			DECIMAL,F
					BTFSS			STATUS,C
					GOTO			SUMA100
					INCF			CENTENAS,F
					GOTO			RESTA100
SUMA100:			MOVLW			.100
					ADDWF			DECIMAL,F

;******************EXTRAER DECENAS*********************************
RESTA10:			MOVLW			.10
					SUBWF			DECIMAL,F
					BTFSS			STATUS,C
					GOTO			SUMA10
					INCF			DECENAS,F
					GOTO			RESTA10
SUMA10:				MOVLW			.10
					ADDWF			DECIMAL,F

;******************EXTRAER UNIDADES*********************************
					MOVF			DECIMAL,W
					MOVWF			UNIDADES

					BSF				STATUS,RP0
					COMF			TRISB,F				;PUERTO B COMO ENTRADA PARA ENVIAR COMANDOS LCD
					BCF				STATUS,RP0
			
;***************DE BCD A DECIMAL USANDO CAR ASCII*****************		
					MOVLW			0X30				;EN CODIGO ASCII LOS NUMERO EMPIEZAN DESDE LA POSICION 0X30
					ADDWF			UNIDADES,F
					ADDWF			DECENAS,F
					ADDWF			CENTENAS,F
					RETURN
					
					
					
				
						
;---------------------------TABLAS------------------------------------


;----------------------------TABLAS_LCD-------------------------------
;************************************0123456789ABCDEF*****************
					;MENSAJE_F1		"EL CONTADOR ES: "		
					;MENSAJE_F2		"EN NUMERO:      "	
					TABLA_LCD			ADDWF			PCL,F
										DT				"EL CONTADOR ES: "
										DT				"EN NUMERO:      "
				
;---------------------------LIBRERIAS--------------------------------
					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\LIBRERIA_RETARDOS.asm>
					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\LIBRERIA_LCD.asm>							END
					END
;*************************************************************************
;COMENTARIOS
;PARA USAR ANTIREBOTE COPIAR EN SUBRUTINA 	SUBT25MS:			RETARDO_3V		.3,.47,.25
;*************************************************************************
;PARA INICIALIZAR PANTALLA LCD: LLAMAR SUBRUTINA   INIT_LCD
;PARA ESCOJER UNA COLUMNA DE LA FILA1:  	FILA1_COLUMNA	.X		X: 0-15
;MOSTRAR MENSAJE EN LA FILA 1 CON LA MACRO  	MENSAJE_FILA1	
;PARA ESCOJER UNA COLUMNA DE LA FILA2:  	FILA2_COLUMNA	.X		X: 0-15
;MOSTRAR MENSAJE EN LA FILA 2 CON LA MACRO  	MENSAJE_FILA2	