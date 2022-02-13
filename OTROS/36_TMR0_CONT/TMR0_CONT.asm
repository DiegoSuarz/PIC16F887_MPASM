;DESCRIPCION:
;
;---------------------------MACROS----------------------------
;---------------------------DEFINE----------------------------
;----------------------------EQU------------------------------
CONT5 EQU	0X23
;---------------------------CBLOCK----------------------------
;---------------------------HEADER----------------------------
					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\MACROS_INTERRUPT.ASM>
					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\MACROS_LCD.ASM>		
					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\RETARDOS_MACROS.ASM> ;MACRO DE RETARDO
					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\MACROS_CONFIGURACION_INT.ASM> ;MACRO DE CONFIGURACION BASICA
					ORG			0X0000			;EMPEZAR EN LA DIRECCION 0 DE LA MEMORIA DE PROGRAMA
					GOTO		INICIALIZA
					VECTOR_INTERRUPCION
					CONFIGURACION				;NOS DEJA EN EL BANCO 1
;-----------------------CODIGO PRINCIPAL------------------------------
;ETIQUETAS			|NEMONICOS		| OPERANDOS 		| COMENTARIOS	
					BCF				TRISC,2
					MOVLW			B'11110000'
					MOVWF			OPTION_REG
					BCF				STATUS,RP0
					MOVLW			.6					;TMR CUENTA HASTA 250 , X2 =500
					MOVWF			TMR0
					MOVLW			.5					;500 X 5 = 2500 CUENTAS TMR0
					MOVWF			CONT5
					BSF				INTCON,T0IE					
					BCF				INTCON,T0IF
					BSF				INTCON,GIE
;*************************************************************************
					GOTO			$
;*************************************************************************
					
;------------------SERVICIO DE RUTINA DE INTERRUPCION-----------------
ISR:				
					BTFSS			INTCON,T0IF
					GOTO			FIN_INT
					DECFSZ			CONT5,F
					GOTO			CLR_FLAG
					MOVLW			.5
					MOVWF			CONT5
					
					MOVLW			.2			
					MOVWF			0X28
RECARGA_TONO:		MOVLW			.3						;2X3 = 6 REPETICIONES
					MOVWF			0X29
TONO:				BSF				PORTC,2
					RETARDO_3V		.1,.69,.1				;RETARDO DE 500US
					BCF				PORTC,2
					RETARDO_3V		.1,.69,.1				;RETARDO DE 500US
					DECFSZ			0X29,F
					GOTO			TONO
					DECFSZ			0X28,F			
					GOTO			RECARGA_TONO
					

CLR_FLAG:			MOVLW			.6
					MOVWF			TMR0
					BCF				INTCON,T0IF
					GOTO			FIN_INT



FIN_INT:			RESTORE_REG							;RESTAURAMOS LOS REGISTROS DE INTERES
					RETFIE								;REGRESAMOS DE LA INTERRUPCION
					
;-------------------------SUBRUTINAS----------------------------------
;T500US				RETARDO_3V		.1,.69,.1
;					RETURN
;---------------------------TABLAS------------------------------------


;----------------------------TABLAS_LCD-------------------------------
;************************************0123456789ABCDEF*****************
;					MENSAJE_F1		"EL NUMERO       "		
;					MENSAJE_F2		"ALEATORIO ES:   "	

;---------------------------LIBRERIAS--------------------------------
					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\LIBRERIA_RETARDOS.asm>
					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\LIBRERIA_LCD.asm>		
					END

;COMENTARIOS
;PARA USAR ANTIREBOTE COPIAR EN SUBRUTINA 	SUBT25MS:			RETARDO_3V		.3,.47,.25
;*************************************************************************
;PARA INICIALIZAR PANTALLA LCD: LLAMAR SUBRUTINA   INIT_LCD
;PARA ESCOJER UNA COLUMNA DE LA FILA1:  	FILA1_COLUMNA	.X		X: 0-15
;MOSTRAR MENSAJE EN LA FILA 1 CON LA MACRO  	MENSAJE_FILA1	
;PARA ESCOJER UNA COLUMNA DE LA FILA2:  	FILA2_COLUMNA	.X		X: 0-15
;MOSTRAR MENSAJE EN LA FILA 2 CON LA MACRO  	MENSAJE_FILA2	