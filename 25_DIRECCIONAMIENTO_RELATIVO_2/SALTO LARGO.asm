DESCRIPCION:
;SE SALTARA DE LA DIRECCION 0X000A A LA DIRECCION 0X8000,
;DE LA 0X0800 A LA 0X1000, DE LA 0X1000 A LA DIRECCION 0X1F30
;Y FINALMENTE DE LA DIRECCION 0X1F30 A LA DIRECCION 0X000A
			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\RETARDOS_MACROS.ASM> ;MACRO DE RETARDO
			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\PLANTILLA.ASM>	;CONFIGURACION BASICA

			;NOS DEJA EN EL BANCO 1, EN LA DIRECCION 0X000A
					
;---------------------------MACROS-----------------------------------

;---------------------------DEFINE-----------------------------------

;-----------------------CODIGO PRINCIPAL------------------------------
;ETIQUETAS | NEMONICOS | OPERANDOS 		| COMENTARIOS	

			MOVLW		0X08
			MOVWF		PCLATH
			CLRF		PCL				;PC(CONTADOR DE PROGRAMA) = 0X08 00
			
			ORG			0X0800		
			MOVLW		0X10
			MOVWF		PCLATH
			CLRF		PCL				;PC(CONTADOR DE PROGRAMA) = 0X10 00	
			
			ORG			0X1000		
			MOVLW		0X1F
			MOVWF		PCLATH
			MOVLW		0X30
			MOVWF		PCL				;PC(CONTADOR DE PROGRAMA) = 0X1F 30	
			
			ORG			0X1F30		
			CLRF		PCLATH
			MOVLW		0X0A
			MOVWF		PCL				;PC(CONTADOR DE PROGRAMA) = 0X000A

;--------------------------SUBRUTINAS--------------------------------


;---------------------------LIBRERIAS--------------------------------
;			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\RETARDOS.asm>
					
			END