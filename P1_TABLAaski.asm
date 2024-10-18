
;MOV AH, 02H ; SERV COLOCAR EL CURSO EN UNA POSICION
;MOV BH, 0 ; Página ACTUAL
;MOV DH, 0 ; Fila
;MOV DL, 02h ; = Columna
;INT 10H  
;MOV AH, 02  ;SERV IMPRIMIR ASCII
;MOV DL, 2AH ;CARACTER A IMPRIMIR
;INT 21H   

MOV CX,00FFH
 

TABLA:
    CURSOR:         ;POSICIONAR CURSOR    
        MOV AH, 02H ; SERV COLOCAR EL CURSO EN UNA POSICION
        MOV BH, 0   ; PAFNIA
        MOV DH, FILA ; Fila       
        MOV DL, COLUMNA ; = Columna
        INT 10H 
        
        INC DH
        MOV FILA,DH  
                                    
    ;    
    IMPNUM:
        MOV AL, I
        SHR AL, 4 
        CMP AL, 09H
            JG  HA
        ADD AL, 30H
        JMP IMPRIMIR_S
        
        HA:     
            ADD AL, 37H
            
        IMPRIMIR_S:
            MOV DL, AL
            MOV AH, 02H  
            INT 21H    
        ;SEGUNDO DIGITO
        MOV AL, I
        AND AL, 0FH 
        CMP AL, 09H
            JG HA2
        ADD AL, 30H
        JMP IMPRIMIR_S2
        
        HA2:     
            ADD AL, 37H
            
        IMPRIMIR_S2:
            MOV DL, AL
            MOV AH, 02H  
            INT 21H
    
    
        
    IMPCAR:
        MOV AH, 02  ;SERV IMPRIMIR ASCII
        MOV DL, ':' ;CARACTER A IMPRIMIR
        INT 21H  
        
        ;IMPRESION CARACTERES ESPECIALES
        MOV DL, I   ;CARACTER A EVALUAR
        MOV AH, 02  ;SERV IMPRIMIR ASCII
        INT 21H              
        
        
        MOV DL, I
        INC DL
        MOV I,DL
    
      
    CMP FILA,18H 
    JL  FIN_BUCLE       
 
    CAL_COL:
        MOV FILA,00H
        MOV AH,COLUMNA
        ADD AH,05H
        MOV COLUMNA,AH   
         
    FIN_BUCLE:      
        
LOOP TABLA
    
        MOV AH, 02H ; SERV COLOCAR EL CURSO EN UNA POSICION
        MOV BH, 0   ; PAFNIA
        MOV DH, FILA ; Fila       
        MOV DL, COLUMNA ; = Columna
        INT 10H 
        
        INC DH
        MOV FILA,DH  
                                        

        MOV AL, I
        SHR AL, 4 
        CMP AL, 09H
            JG  HA3
        ADD AL, 30H
        JMP IMPRIMIR_S3
        
        HA3:     
            ADD AL, 37H
            
        IMPRIMIR_S3:
            MOV DL, AL
            MOV AH, 02H  
            INT 21H    
        ;SEGUNDO DIGITO
        MOV AL, I
        AND AL, 0FH 
        CMP AL, 09H
            JG HA4
        ADD AL, 30H
        JMP IMPRIMIR_S3
        
        HA4:     
            ADD AL, 37H
            
        IMPRIMIR_S4:
            MOV DL, AL
            MOV AH, 02H  
            INT 21H
    
    
        
        MOV AH, 02  ;SERV IMPRIMIR ASCII
        MOV DL, ':' ;CARACTER A IMPRIMIR
        INT 21H  
        
        ;IMPRESION CARACTERES ESPECIALES
        MOV DL, I   ;CARACTER A EVALUAR
        MOV AH, 02  ;SERV IMPRIMIR ASCII
        INT 21H

INT 20H

I DB 00H
FILA DB 00H   
AUXF DB 20H
COLUMNA DB 00H
'