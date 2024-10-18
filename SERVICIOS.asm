MOV AH, 09H     ;SERVICIO PARA MANDAR A IMPRIMIR UNA CADENA
                ;AH = 09 
              
MOV DX, OFFSET MENSAJE ;CARGAR LA DIRECCION EFECTIVADE MENSAJE
                      ;DX =&MENSAJE, CALCULA LA DIRECCION DE LA CADENA

INT 21H                ;LLAMADO A LA INT 21H DEL S.O. 
           

;LEER 1ER NUMERO

LEER:
    MOV AH, 01H; AH=01H, SERVICIO 01 LECTURA DE UN CARACTER DESDE TECLADO
    INT 21H; DEJA EN AL EL CODIGO ASCII

;CONVERTIR DE ASCII A HEXA, RESTAR 30
CMP AL, 30H 
    JL LEER; MENOR QUE 30
CMP AL, 39H
    JG LEER; MAYOR QUE 39    

SUB AL, 30H ; AL = VALOR EN HEXA 
MOV NUM1, AL  
     
;LEER SIGNO                  
SIGNO:
    MOV AH, 01H; AH=01H, SERVICIO 01 LECTURA DE UN CARACTER DESDE TECLADO
    INT 21H; DEJA EN AL EL CODIGO ASCII

CMP AL, 2BH 
    JL RES; MENOR QUE 2BH
CMP AL, 2BH
    JG RES; MAYOR QUE 2BH    
    MOV SIGNOOP, AL; SIGNOOP='+'  
    JMP LEER2; LEE EL SIGUIENTE NUMERO
    
RES:
    CMP AL, 2DH
        JL MULT; MENOR QUE 2DH
    CMP AL, 2DH
        JG MULT; MAYOR QUE 2DH
    MOV SIGNOOP, AL; SIGNOOP='-' 
    JMP LEER2; LEE EL SIGUIENTE NUMERO
    
MULT:
    CMP AL, 2AH
        JL DIVI; MENOR QUE 2AH
    CMP AL, 2AH
        JG DIVI; MAYOR QUE 2AH
    MOV SIGNOOP, AL; SIGNOOP='*' 
    JMP LEER2; LEE EL SIGUIENTE NUMERO 
    
DIVI:
    CMP AL, 2FH
        JL SIGNO; MENOR QUE 2FH
    CMP AL, 2FH
        JG SIGNO; MAYOR QUE 2FH
    MOV SIGNOOP, AL; SIGNOOP='/'
    JMP LEER2; LEE EL SIGUIENTE NUMERO
                  
                  
;LEER 2DO NUMERO  

LEER2:
    MOV AH, 01H; AH=01H, SERVICIO 01 LECTURA DE UN CARACTER DESDE TECLADO
    INT 21H; DEJA EN AL EL CODIGO ASCII

;CONVERTIR DE ASCII A HEXA, RESTAR 30
CMP AL, 30H 
    JL LEER2; MENOR QUE 30
CMP AL, 39H
    JG LEER2; MAYOR QUE 39    

SUB AL, 30H ; AL = VALOR EN HEXA 
MOV NUM2, AL




;RESULTADO
CMP SIGNOOP, 2BH
    JL RESTA
CMP SIGNOOP, 2BH
    JG RESTA
        ADD AL, NUM1; SUMA
        MOV RESULTADO, AL; RESULTADO SUMA
        JMP TERMINA 
        
  
RESTA:
CMP SIGNOOP, 2DH
    JL MULTIPLICACION
CMP SIGNOOP, 2DH
    JG MULTIPLICACION
        MOV AL, NUM1
        SUB AL, NUM2; RESTA
        MOV RESULTADO, AL; RESULTADO RESTA
        JMP TERMINA 
        
MULTIPLICACION:
CMP SIGNOOP, 2AH
    JL DIVISION
CMP SIGNOOP, 2AH
    JG DIVISION
        MOV AL, NUM1
        MOV BL, NUM2
        MUL AX      ; MULTIPLICACION
        MOV RESULTADO, AH; RESULTADO MULTIPLICACION
        JMP TERMINA
        
DIVISION:
MOV AL, NUM1
MOV BL, NUM2
DIV BL      ; DIVISION
MOV RESULTADO, AL; RESULTADO DIVISION  
MOV RESIDUO, AH

; TERMINA EL PROGRAMA
TERMINA:
    INT 20H

NUM1 DB 00H  
SIGNOOP DB 00H
NUM2 DB 00H 
RESULTADO DB 00H
RESIDUO DB 00H
MENSAJE DB "INGRESE LA OPERACION : $",10