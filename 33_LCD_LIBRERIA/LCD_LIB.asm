;DESCRIPCION:
;
;---------------------------MACROS----------------------------
;---------------------------DEFINE----------------------------
;----------------------------EQU------------------------------
;---------------------------CBLOCK----------------------------
;---------------------------HEADER----------------------------
					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\MACROS_INTERRUPT.ASM>	;MACRO PARA EL USO DE INTERRUPCIONES
					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\MACROS_LCD.ASM>	;MACRO PARA EL USO DISPLAY LCD
					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\MACROS_7SEG.ASM>	;MACRO PARA EL USO DISPLAY 7 SEG					
					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\RETARDOS_MACROS.ASM> ;MACRO DE RETARDO
					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\MACROS_CONFIGURACION_INT.ASM> ;MACRO DE CONFIGURACION BASICA
					ORG			0X0000			;EMPEZAR EN LA DIRECCION 0 DE LA MEMORIA DE PROGRAMA
					GOTO		INICIALIZA
;					VECTOR_INTERRUPCION			;SI SE USA INTERRUPCIONES DESCOMENTAR
;					SIETE_SG_KC				;SI SE USA DISPLAY 7 SEG DESCOMENTAR
LCD_FILA1			ADDWF			PCL,F
					DT				"EL NUMERO       "
LCD_FILA2			ADDWF			PCL,F
					DT				"ALEATORIO ES  :)"					
					CONFIGURACION				;NOS DEJA EN EL BANCO 1
;-----------------------CODIGO PRINCIPAL------------------------------
;ETIQUETAS			|NEMONICOS		| OPERANDOS 		| COMENTARIOS	
					CLRF			TRISB
					BCF				STATUS,RP0
					CALL			INIT_LCD
					FILA1_POSICION	.6
					CALL			MENSAJE_FILA1
					FILA2_POSICION	.6
					CALL			MENSAJE_FILA2
					GOTO			$
;*************************************************************************
				
;*************************************************************************
					
;------------------SERVICIO DE RUTINA DE INTERRUPCION-----------------
ISR:				
				
FIN_INT:			RESTORE_REG							;RESTAURAMOS LOS REGISTROS DE INTERES
					RETFIE								;REGRESAMOS DE LA INTERRUPCION
					
;-------------------------SUBRUTINAS----------------------------------
;---------------------------TABLAS------------------------------------


;----------------------------TABLAS_LCD-------------------------------
;************************************0123456789ABCDEF*****************
;					MENSAJE_F1		"EL NUMERO       "		
;					MENSAJE_F2		"ALEATORIO ES:   "	

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
;MOSTRAR MENSAJE EN LA FILA 1 CON LA MACRO  	MENSAJE_FILA1	
;PARA ESCOJER UNA COLUMNA DE LA FILA2:  	FILA2_COLUMNA	.X		X: 0-15
;MOSTRAR MENSAJE EN LA FILA 2 CON LA MACRO  	MENSAJE_FILA2	