BIN_A_DECIMAL				CLRF			UNIDADES
					CLRF			DECENAS
					CLRF			CENTENAS

************************EXTRAER CENTENAS*********************************
RESTA100:			MOVLW			.100
					SUBWF			NUMERO,F
					BTFSS			STATUS,C
					GOTO			SUMA100
					INCF			CENTENAS,F
					GOTO			RESTA100
SUMA100:			MOVLW			.100
					ADDWF			NUMERO,F

;******************EXTRAER DECENAS*********************************
RESTA10:			MOVLW			.10
					SUBWF			NUMERO,F
					BTFSS			STATUS,C
					GOTO			SUMA10
					INCF			DECENAS,F
					GOTO			RESTA10
SUMA10:				MOVLW			.10
					ADDWF			NUMERO,F

;******************EXTRAER UNIDADES********************************************************
					MOVF			NUMERO,W
					MOVWF			UNIDADES

								
;***************DE BCD A DECIMAL USANDO CARACTERES ASCII*****************		
					MOVLW			0X30				;EN CODIGO ASCII LOS NUMERO EMPIEZAN DESDE LA POSICION 0X30
					ADDWF			UNIDADES,F
					ADDWF			DECENAS,F
					ADDWF			CENTENAS,F
					RETURN