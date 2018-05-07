;INPUT: A NUMBER N
; OUTUT: PRINT N-1 TO 1

.MODEL SMALL
.DATA  
MSG1 DW "Enter Input Array:$" 
MSG2 DW "Sorted Array:$"
W DW 16 DUP(?)
MIN_IDX DW ? 
ARR_SIZE DW 0 
MINUS_FLAG DW 0
PRINT_COUNTER DW 0;COUNT NUMBER OF ELEMENT PRINTS
.CODE

MAIN PROC
 
    MOV AX, @DATA
    MOV DS, AX 
    
    MOV AH,9
    LEA DX,MSG1
    INT 21H
    
    MOV SI,0            
    XOR BX,BX; BX: RESULT
    WHILE:
     MOV AH,1
     INT 21H
     CMP AL,' '
     JE A_NUMBER
     CMP AL,'x'
     JE END_WHILE
     CMP AL,'-'
     JE MINUS
        
        SUB AL,'0'
        MOV CL,AL ;CL: current input digit
        XOR CH,CH 
        MOV AX,BX; AX: temp result
        MOV BX,10
        MUL BX
        ADD AX,CX
        MOV BX,AX
        JMP WHILE
    MINUS:
    MOV MINUS_FLAG, 1; A minus sign found
    JMP WHILE
    
    A_NUMBER:    
    CMP MINUS_FLAG,1
    JE A_NEG_NUMBER    
    MOV W[SI],BX
    ADD SI,2 
    XOR BX,BX
    ADD ARR_SIZE, 1
    JMP WHILE 
    
    A_NEG_NUMBER:
    ;XOR CX,CX
    ;SUB CX,BX
    NEG BX
    MOV W[SI],BX
    ADD SI,2 
    XOR BX,BX
    ADD ARR_SIZE, 1
    MOV MINUS_FLAG, 0
    JMP WHILE 
    
    END_WHILE:
    CALL SELECTION_SORT
    
   
    ;PRINT OUTPUT
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    MOV AH,9
    LEA DX,MSG2
    INT 21H
    CALL PRINT 
     
    MOV AH,4CH
    INT 21H
MAIN ENDP
    PRINT PROC
     PUSH AX
     PUSH BX
     PUSH CX
     PUSH DX
     
     MOV SI,0
     WHILE2:      
     MOV AX,W[SI]
     ADD SI,2
     INC PRINT_COUNTER
     PUSH AX           ; FOR compare operation ax is used
     MOV AX,PRINT_COUNTER
     CMP AX,ARR_SIZE
     POP AX
     JG EXIT
     OR AX,AX
     JGE @END_IF1
     
     PUSH AX
     MOV DL,'-'
     MOV AH,2
     INT 21H
     POP AX
     NEG AX
     
     @END_IF1:
      XOR CX,CX
      MOV BX,10D
      
     @REPEAT1:
      XOR DX,DX
      DIV BX
      PUSH DX
      INC CX
      
      OR AX,AX
      JNE @REPEAT1
      
     MOV AH,2
     @PRINT_LOOP:
     POP DX
     OR DL,30H    
     INT 21H
     LOOP @PRINT_LOOP
      
     MOV DL, 20H
     INT 21H 
     JMP WHILE2
     EXIT:
     POP DX
     POP CX
     POP BX
     POP AX
     RET    
    PRINT ENDP
    
    SELECTION_SORT PROC 
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    ;MOV ARR_SIZE,6  
    
    MOV CX,1   ;CX: outer loop index counter
    
    LEA SI,W ;SI points 1st element
    
    OUTER_LOOP: 
    MOV DI,SI ; DI: INNER LOOP ARRAY index
    MOV DX,CX  ;DX: inner loop index counter
               
    ADD DX,1
    ADD DI,2  ;DI points [SI+1]  element 
    
    MOV BX,[SI] ;BX CONTAINS min element
   
    MOV MIN_IDX,CX
    INNER_LOOP_FIND_MIN:                                        
    CMP [DI],BX   ;BX POINTS min, DI th elem is checked for min
    JNL MIN_UNCHANGED 
    
    MOV BX,[DI] ;BX has new MIN 
    MOV MIN_IDX,DX 
    
    MIN_UNCHANGED:
    INC DX
    ADD DI,2
     
    CMP DX,ARR_SIZE
    JNG INNER_LOOP_FIND_MIN 
    
    LEA DI,W    
    DEC MIN_IDX
    SHL MIN_IDX,1  
    ADD DI,MIN_IDX
    
    MOV DX,[DI]  ;using DX as a temp register
    XCHG [SI],DX ;not ax, but axx in array
    MOV [DI],DX
      
    ;CALL SWAP ;SWAP AX,[SI]
    ADD SI,2
    INC CX
    CMP CX,ARR_SIZE
    JL OUTER_LOOP  
    
    POP DX
    POP CX
    POP BX
    POP AX
    
    RET
    SELECTION_SORT ENDP
    
    

END MAIN 

;SWAP PROC
   ; XCHG AX,[SI] ;swap AX , [SI] 
    ;RET
    ;SWAP ENDP