DESCRIPCION:
;REALIZAR UN SALTO CORTO A LA DIRECCION 100 SIN GOTO
;PARA EL DIRECCIONAMIENTO RELATIVO SE USA PCLH(2BITS) + PCL(11BITS),
;COMO SON 13 BITS 00000 0110 100          PCLH= 00   PCL=000 0110 100 
			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\RETARDOS_MACROS.ASM> ;MACRO DE RETARDO
			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\PLANTILLA.ASM>	;CONFIGURACION BASICA

			;NOS DEJA EN EL BANCO 1	
					
;---------------------------MACROS-----------------------------------

;---------------------------DEFINE-----------------------------------

;-----------------------CODIGO PRINCIPAL------------------------------
;ETIQUETAS | NEMONICOS | OPERANDOS 		| COMENTARIOS	
			MOVLW		.100
			MOVWF		PCL				;CARGAMOS EL VALOR DEL REGISTRO PCL
			
			ORG			.100			;COLOCAR EL ORIGEN(DIRECCION DE MEMORIA DE PROGRAMA) EN LA UBICACION 100 
			NOP
			NOP			
			NOP
			MOVLW		.101
			MOVWF		PCL		
			
			

;--------------------------SUBRUTINAS--------------------------------


;---------------------------LIBRERIAS--------------------------------
;			INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\RETARDOS.asm>
					
			END