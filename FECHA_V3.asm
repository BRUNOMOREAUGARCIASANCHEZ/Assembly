
;FECHA DEL SISTEMA 

;MACRO PARA IMPRIMIR 
IMP_CAD MACRO MSG
    MOV AH, 09H
    LEA DX, MSG
    INT 21H
IMP_CAD ENDM

; MACRO QUE COLOCA EL CURSOR
COLOCA MACRO X, Y
    MOV DH, X  ;REN
    MOV DL, Y  ;COL
    MOV AH, 02H       
    INT 10H
COLOCA ENDM

;CONVERSION HEXA-DECIMAL
CONV_HD MACRO X ;DOS DIGITOS
    MOV AUX,00H
    LOCAL CONV,RES1,RES2,RES3,CONTINUACION, IMP2DIG  
    MOV COCIENTE,X
    CONV:
        MOV AH,00H                       
        MOV AL,COCIENTE
        MOV BL,0AH
        DIV BL    ;AL/BL
        MOV COCIENTE, AL
        
        MOV BH,AUX
        
        CMP BH,00h
        JE RES1
        CMP BH,01h
        JE RES2
        CMP BH,02h
        JE RES3
        
        RES1:
        MOV RESIDUO1,AH
        JMP CONTINUACION
        RES2:
        MOV RESIDUO2,AH
        JMP CONTINUACION
        RES3:
        MOV RESIDUO3,AH
        JMP CONTINUACION                
        
        CONTINUACION:
        ADD BH,01H
        MOV AUX,BH        
        CMP AL,00H
    JNE CONV
    
    CMP RESIDUO3, 00H
    JE IMP2DIG  
    MOV DL, RESIDUO3
    ADD DL,30H
    MOV AH, 02H  
    INT 21H
    
    IMP2DIG:
    MOV DL, RESIDUO2
    ADD DL,30H
    MOV AH, 02H  
    INT 21H
    MOV DL, RESIDUO1
    ADD DL,30H
    MOV AH, 02H  
    INT 21H
                
ENDM 

CONV2_HD MACRO X ;TRES DIGITOS
    
        MOV AX,00H                       
        MOV AX,X
        MOV BL,0AH
        DIV BL    ;AL/BL
        ;AL:QUITIENT, AH:REMINDER
        MOV RESIDUO4,AH 
        CONV_HD AL
        MOV DL, RESIDUO4
        ADD DL,30H
        MOV AH, 02H  
        INT 21H
              
ENDM

;--------------HOY ES MARTES 15 DE MARZO DE 07E6-------------------
    COLOCA 11, 23
    IMP_CAD HOY
                   
;(CX=ANIO, DH=MES, DL=DIA, AL=DIA DE LA SEMANA 0-DOMINGO)
    MOV AH, 2AH
    INT 21H
    
    MOV DD, AL
    MOV DIA, DL
    MOV MES, DH
    MOV SANIO, CX
    
    PUSH DX     ;GUARDA TEMPORALMENTE DX
    
;------------------------IMPRIMIR EL DIA DE LA SEMANA---------------------                   

    CALL IMP_DIAN

DIAMES:
    MOV DL, DIA   
    
    CALL DOSDIG
    
    IMP_CAD DE

;-------------------IMP MES DEL ANIO---------------------------------
     
    CALL IMP_MES

ANIO:
    IMP_CAD DE
    
    MOV CX, SANIO
    MOV DL, CH
    CALL DOSDIG
    
    MOV DL, CL
    CALL DOSDIG
    
;------------------FECHA EN DECIMAL-------------------------------------
    COLOCA 13, 23
    
    IMP_CAD HOY
    
    MOV AL, DD
    CALL IMP_DIAN

;-------------------NUM DIA------------------------------------
    MOV DL, DIA    
    CONV_HD DL

;------------------IMPRIME MES---------------------    
    IMP_CAD DE    
    CALL IMP_MES 
    IMP_CAD DE
    
;-----------------IMPRIME ANIO DEC----------------
    MOV CX, SANIO
    CONV2_HD CX      
    
;---------------TERMINA PROGRAMA-------------------    
FIN: 
    INT 20H

;---------------PROCEDIMIENTOS---------------------

CONVHEX_ASC PROC     ;CONVERSIÓN A ASCII
    CMP DL, 09H
    JG SUMAR37
    ADD DL, 30H
    JMP IMPREDIG
SUMAR37:
    ADD DL, 37H
IMPREDIG:
    MOV AH, 02H      ; SERV PARA IMPRI 1 CARACTER
    INT 21H
    RET              ; REGRESO DEL PROCEDIMIENTO
CONVHEX_ASC ENDP

DOSDIG PROC
    PUSH DX
    SHR DL, 4
    CALL CONVHEX_ASC ; IMPRIME EL NIBLE ALTO
    
    POP DX
    AND DL, 0FH
    CALL CONVHEX_ASC ; IMPRIME EL NIBLE BAJO
    RET
DOSDIG ENDP

IMP_DIAN PROC
    CMP AL, 1
    JGE LUNES
    IMP_CAD DOM
    RET
    
    LUNES: 
        CMP AL, 2
        JGE MARTES
        IMP_CAD LUN
        RET
        
    MARTES:
        CMP AL, 3
        JGE MIERCOLES
        IMP_CAD MAR
        RET
        
    MIERCOLES:
        CMP AL, 4
        JGE JUEVES
        IMP_CAD MIER
        RET
        
    JUEVES:
        CMP AL, 5
        JGE VIERNES
        IMP_CAD JUE
        RET
        
    VIERNES:
        CMP AL, 6
        JGE SABADO
        IMP_CAD VIE
        RET
        
    SABADO:
        IMP_CAD VIE
        RET   
IMP_DIAN ENDP    

IMP_MES PROC
        MOV DH, MES 
        CMP DH, 2
        JGE FEBRERO
        IMP_CAD ENE
        RET 
    FEBRERO:
        CMP DH, 3
        JGE MARZO
        IMP_CAD FEB
        RET
         
    MARZO:
        CMP DH, 4
        JGE ABRIL
        IMP_CAD MARZ
        RET
        
    ABRIL:
        CMP DH, 5
        JGE MAYO
        IMP_CAD ABR
        RET
    
    MAYO:
        CMP DH, 6
        JGE JUNIO
        IMP_CAD MAY
        RET
        
    JUNIO:
        CMP DH, 7
        JGE JULIO
        IMP_CAD JUN
        RET
        
    JULIO:
        CMP DH, 8
        JGE AGOSTO
        IMP_CAD JUL
        RET   
     
    AGOSTO:
        CMP DH, 9
        JGE SEPTIEMBRE
        IMP_CAD AGO 
        RET 
        
    SEPTIEMBRE:
        CMP DH, 0AH
        JGE OCTUBRE
        IMP_CAD SEP
        RET
        
    OCTUBRE:
        CMP DH, 0BH
        JGE NOVIEMBRE
        IMP_CAD OCT
        RET
        
    NOVIEMBRE:
        CMP DH, 0CH
        JGE DICIEMBRE
        IMP_CAD NOV
        RET
        
    DICIEMBRE:
        IMP_CAD DIC
        RET
IMP_MES ENDP        


DD DB 00H
DIA DB 00H
MES DB 00H
SANIO DW 00H


HOY DB "HOY ES $"  
DOM DB "DOMINGO $"
LUN DB "LUNES $"
MAR DB "MARTES $"
MIER DB "MIERCOLES $"
JUE DB "JUEVES $"
VIE DB "VIERNES $"
SAB DB "SABADO $"
DE DB " DE $"
ENE DB "ENERO$"
FEB DB "FEBRERO$"
MARZ DB "MARZO$"
ABR DB "ABRIL$"
MAY DB "MAYO$"
JUN DB "JUNIO$"
JUL DB "JULIO$"
AGO DB "AGOSTO$"
SEP DB "SEPTIEMBRE$"
OCT DB "OCTUBRE$"
NOV DB "NOVIEMBRE$"
DIC DB "DICIEMBRE$"

AUX  DB 00H 
COCIENTE DB 00H
RESIDUO1 DB 00H
RESIDUO2 DB 00H
RESIDUO3 DB 00H

RESIDUO4 DB 00H