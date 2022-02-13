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

;----------------------------EQU--------------------------------------

;---------------------------HEADER--------------------------------------
					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\MACROS_LCD.ASM>		
					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\RETARDOS_MACROS.ASM> ;MACRO DE RETARDO
					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\PLANTILLA.ASM>	;CONFIGURACION BASICA

			;NOS DEJA EN EL BANCO 1	

;-----------------------CODIGO PRINCIPAL------------------------------
;ETIQUETAS			|NEMONICOS		| OPERANDOS 		| COMENTARIOS	
					CLRF			TRISB
					BCF				STATUS,RP0
					CALL			INIT_LCD

				
					FILA1_COLUMNA	.3
					MENSAJE_FILA1	
					
					FILA2_COLUMNA	.0
					MENSAJE_FILA2

						
					GOTO			$
;-------------------------SUBRUTINAS----------------------------------

;----------------------------TABLAS----------------------------------

					MENSAJE_F1		"ENSAMBLADOR PARA"
					MENSAJE_F2		"HOLA_MUNDO"

;---------------------------LIBRERIAS--------------------------------
					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\LIBRERIA_RETARDOS.asm>
					INCLUDE		<D:\Archivos\Programacion\Microcontroladores\PIC\ASSEMBLER\MPASM\PIC16F887\LIBRERIAS\LIBRERIA_LCD.asm>		
					END