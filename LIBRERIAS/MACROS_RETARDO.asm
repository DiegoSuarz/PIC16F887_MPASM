;---------RETARDO 1 VARIABLE-----------------

SUBT1V		MACRO		VAR1
		MOVLW		VAR1
		MOVWF		0X60
		CALL		ST1V
		ENDM

;---------RETARDO 2 VARIABLES-----------------
SUBT2V		MACRO		VAR1,VAR2
		MOVLW		VAR1
		MOVWF		0X61
		MOVLW		VAR2
		MOVWF		0X62
		CALL		ST2V
		ENDM

;---------RETARDO 3 VARIABLES-----------------

SUBT3V		MACRO		VAR1,VAR2,VAR3
		MOVLW		VAR1 				;VAR1
		MOVWF		0X64
		MOVLW		VAR2				;VAR2
		MOVWF		0X65			
		MOVLW		VAR3				;VAR3
		MOVWF		VAR3
		CALL		ST3V
		ENDM
;------------------------------------------------------