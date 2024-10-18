IMPRIME_CAD MACRO MSJ
    MOV AH, 09H
    MOV DX, OFFSET MSJ
    INT 21H
IMPRIME_CAD ENDM

IMPRIME_CAD MSG1

LEER:
    MOV AH, 0AH
    LEA DX, MAX
    INT 21H
         
    XOR SI, SI

CONVERTIR:
    MOV AL, CAD[SI]
    
    CMP AL, 24H  
    JE IMPRIMIR
    
    CMP AL, 20H
    JE SUMA 
    
    CMP AL, 41H
    JGE CMPMAY
    
    CMP AL, 61H
    JGE CMPMIN
    
SUMA:
    INC SI
    JMP CONVERTIR
    
CMPMAY:
    CMP AL, 5AH
    JL MAY
    
CMPMIN:
    CMP AL, 7AH
    JL MIN 
    
MAY:
    ADD AL, 20H
    MOV CAD[SI], AL
    INC SI
    JMP CONVERTIR
    
MIN:
    SUB AL, 20H
    MOV CAD[SI], AL
    INC SI
    JMP CONVERTIR  
               
IMPRIMIR:
    
    MOV AH, 02H
    MOV DL, 0AH 
    INT 21H
    
    MOV AH, 02H
    MOV DL, 0AH 
    INT 21H
    
    MOV AH, 02H
    MOV DL, 0DH
    INT 21H
    
    IMPRIME_CAD MSG2
    
    IMPRIME_CAD CAD
    
    
FIN:
    INT 20H
    
    
    
    

MSG1 DB "INGRESE LA CADENA : $"
MSG2 DB "CADENA MODIFICADA : $"
MAX DB 30
LEIDOS DB 00
CAD DB 30 DUP('$')
 