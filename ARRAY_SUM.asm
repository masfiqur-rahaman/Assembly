                        ;INPUT: A NUMBER N
; OUTUT: PRINT N-1 TO 1

.MODEL SMALL
.DATA 
MSG DB 'abcde'
W DW 10,20,30,40,50,60
GAMMA DW 100 DUP(10) 
DELTA DW 100 DUP(?)
.CODE

MAIN PROC
 
    MOV AX, @DATA
    MOV DS, AX  
    CALL TESTER
MAIN ENDP   
    TESTER PROC
    
    XOR AX, AX
    MOV CX, 6
    LEA SI, W
    TOP:
    ADD AX, [si]
    ADD SI, 2
    
    LOOP TOP 
    
        
    TESTER ENDP


END MAIN