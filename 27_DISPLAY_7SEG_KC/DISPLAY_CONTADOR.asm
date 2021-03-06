DESCRIPCION:
;CONTADOR DE 00 A 99 EN DISPLAYS DE 7 SEGMENTOS
;TIEMPO DE CONTEO ES DE 1s ENTRE CADA NUMERO.
					
;---------------------------MACROS-----------------------------------
SIETE_SG_KC	MACRO
SIETE_SEG:						
			ADDWF		PCL,F

			DT			0X3F,0X06,0X5B,0X4F,0X66,0X7D,0X07,0X7F,0X6F,0X77,0X7C,0X39,0X5E,0X79,0X71
			ENDM

;---------------------------DEFINE-----------------------------------
			#DEFINE	UNIDAD_ENA	BSF	PORTA,0
			#DEFINE	UNIDAD_DIS	BCF	PORTA,0
			#DEFINE DECENA_ENA	BSF	PORTA,1
			#DEFINE DECENA_DIS	BCF	PORTA,1
			
;---------------------------EQU--------------------------------------
			UNIDAD	EQU	0X20
			DECENA	EQU 0X21	
			CONT60	EQU	0X22

;---------------------------INCLUDE--------------------------------------
					
			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\RETARDOS_MACROS.ASM> ;MACRO DE RETARDO
			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\PLANTILLA.ASM>	;CONFIGURACION BASICA

			;NOS DEJA EN EL BANCO 1	

;-----------------------CODIGO PRINCIPAL------------------------------
;ETIQUETAS | NEMONICOS | OPERANDOS 		| COMENTARIOS	
			
			CLRF		TRISD			;PUERTO D COMO SALIDA
			BCF			TRISA,0			;RA0 COMO SALIDA
			BCF			TRISA,1			;RA1 COMO SALIDA
			BCF			STATUS,RP0		;ACCEDER AL BANCO 0
			
			SIETE_SG_KC					;DEFINIMOS LA MACRO	
			
LIMPIA_DEC: CLRF		DECENA			;LIMPIAMOS LA VARIABLE DECENA (0X21)			
LIMPIA_UNI:	CLRF		UNIDAD			;LIMPIAMOS LA VARIABLE UNIDAD (0X20)

			
RECARGA60:	MOVLW		.60
			MOVWF		CONT60			;CARGARMOS LA VARIABLE CONT60 CON .60

VISUALIZAR:	MOVF		UNIDAD,W		;LEEMOS LA VARIABLE UNIDAD Y LO ALMACENAMOS EN W
			CALL		SIETE_SEG		;LLAMAMOS A LA RUTINA 7 SEG
			MOVWF		PORTD			;VISUALIZAMOS LA UNIDAD POR EL PUERTO D

			UNIDAD_ENA					;ENCENDER UNIDADES DISPLAY(ENCENDER TRANSITOR RA0)
			CALL		RETARDO_8mS
			UNIDAD_DIS					;ENCENDER UNIDADES DISPLAY(APAGAR TRANSITOR RA0)

			MOVF		DECENA,W		;LEEMOS LA VARIABLE UNIDAD Y LO ALMACENAMOS EN W
			CALL		SIETE_SEG		;LLAMAMOS A LA RUTINA 7 SEG
			MOVWF		PORTD			;VISUALIZAMOS LA DECENA POR EL PUERTO D

			DECENA_ENA					;ENCENDER DECENAS DISPLAY(ENCENDER TRANSITOR RA1)
			CALL		RETARDO_8mS
			DECENA_DIS					;APAGAR DECENAS DISPLAY(APAGAR TRANSITOR RA1)
			
			DECFSZ		CONT60,F		;BUCLE PARA REPETIR 60 VECES LA VISUALIZACION DE LOS DIGITOS
			GOTO		VISUALIZAR			
		
			INCF		UNIDAD,F		;INCREMENTAR LA VARIABLE UNIDAD
			MOVLW		0X09			
			XORWF		UNIDAD,W		
			BTFSS		STATUS,Z		;UNIDAD == 9?
			GOTO		RECARGA60		;NO, VE A REPETIR HASTA QUE SE CUMPLAN LOS 60 SIGLOS
			INCF		DECENA,F		;SI, INCREMENTA DECENA EN UNA UNIDAD, Y LIMPIA UNIDADES
			MOVLW		0X09
			XORWF		DECENA,W
			BTFSS		STATUS,Z		;DECENA == 9?
			GOTO		LIMPIA_UNI		;NO, VE A LIMPIAR UNIDADES, PERO MANTENER LAS DECENAS 
			GOTO		LIMPIA_DEC		;SI, VE Y LIMPIA UNIDADES Y DECENAS

;--------------------------SUBRUTINAS--------------------------------
RETARDO_8mS:
			RETARDO_2V	.6,.181			;RETARDO DE 8mS PARA LA PERSISTENCIA DE LA VISION
			RETURN

;---------------------------LIBRERIAS--------------------------------
			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\RETARDOS.asm>
					
			END