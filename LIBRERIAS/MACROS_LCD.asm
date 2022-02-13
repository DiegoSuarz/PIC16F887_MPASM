;PUERTO EQU PORTB
;PUERTO	 EQU 	PORTC
;;---------------------------DEFINE-----------------------------------
;#DEFINE		RS_0	BCF		PUERTO,4
;#DEFINE		RS_1	BSF		PUERTO,4
;#DEFINE		E_0		BCF		PUERTO,5
;#DEFINE		E_1		BSF		PUERTO,5

;----------------------------EQU--------------------------------------
DATO		EQU		0X2A

;---------------------------MACROS-----------------------------------

FILA1_POSICION		MACRO			POSICION1
					MOVLW			POSICION1					;POSICIONARSE EN LA SEGUNDA FILA
					CALL			DIRECCION_DDRAM
					ENDM

FILA2_POSICION		MACRO			POSICION2
					MOVLW			0X40+POSICION2					;POSICIONARSE EN LA SEGUNDA FILA
					CALL			DIRECCION_DDRAM
					ENDM

