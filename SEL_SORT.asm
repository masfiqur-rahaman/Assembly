;INPUT: A NUMBER N
; OUTUT: PRINT N-1 TO 1

.MODEL SMALL
.DATA 
MSG DB 'abcde'
W DW 60,50,40,30,20,10
GAMMA DW 100 DUP(10) 
DELTA DW 100 DUP(?)  
MIN_IDX DW ? 
ARR_SIZE DW ?
.CODE

MAIN PROC
 
    MOV AX, @DATA
    MOV DS, AX  
    CALL SELECTION_SORT
MAIN ENDP   
    SELECTION_SORT PROC
    MOV ARR_SIZE,6  
    
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
 
    SELECTION_SORT ENDP
    
    

END MAIN 

;SWAP PROC
   ; XCHG AX,[SI] ;swap AX , [SI] 
    ;RET
    ;SWAP ENDP