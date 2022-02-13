DESCRIPCION:
;MOSTRAR 2 SEMAFOROS
				
			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\19_SEMAFORO\DEFINE_SEMAFORO.ASM> ;	
			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\MACROS_RETARDO.ASM> ;MACRO DE RETARDO
			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\PLANTILLA.ASM>	;CONFIGURACION BASICA

			;NOS DEJA EN EL BANCO 1	
					
;---------------------------MACROS-----------------------------------


;---------------------------DEFINE-----------------------------------
	
;ETIQUETAS | NEMONICOS | OPERANDOS 		| COMENTARIOS	
			
			CLRF		TRISD
			CLRF		TRISE
			BCF			STATUS,RP0
			
INICIO:		R1_A
			V1_E
			R2_E
			CALL		T30SEG
			V1_A

			MOVLW		.5
			MOVWF		0X20
					
PARPADE0_1:	A1_E		
			CALL		T600MS
			A1_A
			CALL		T600MS
			DECFSZ		0X20,F
			GOTO 		PARPADE0_1

			R2_A 
			V2_E
			R1_E
			CALL		T30SEG
			
			V2_A
			MOVLW		.5
			MOVWF		0X20
PARPADE0_2:	A2_E		
			CALL		T600MS
			A2_A
			CALL		T600MS
			DECFSZ		0X20,F
			GOTO 		PARPADE0_2
			GOTO		INICIO

;************************************************************************
T600MS:									;SUBRUTINA RETARDO 600MS
			SUBT3V      .7,.49,.247
			RETURN 

;************************************************************************
T30SEG:									;SUBRUTINA RETARDO 30 SEG
			SUBT3V		.211,.211,.96	
			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\RETARDOS.asm>
					
			END