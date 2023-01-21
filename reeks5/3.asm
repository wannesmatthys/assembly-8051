; Schrijf in assembleertaal een recursieve versie van strcpy. De code ziet er als volgt uit:
; void strcpy(char *dest,const char *src){
;     if (*src==0){
;         *dest=0;
;     } else {
;         *dest++=*src++
;         strcpy(dest,src);
;     }
; }

org 0000H

jmp main

org 0080H
	
main:mov R0, #7FH
loop:mov @R0, #0
	djnz R0, loop
	
	mov 70H, #'h'
	mov 71H, #'a'
	mov 72H, #'l'
	mov 73H, #'l'
	mov 74H, #'o'
	mov 75H, #0
	
	mov R1, #60H
	push 01H
	
	mov R0, #70H
	push 00H
	
	;-----------
	;70H
	;-----------
	;60H
	;-----------
	
	call strcpy
	
	dec SP
	dec SP
	
	jmp $
	
strcpy: push 00H
	mov R0, SP
	push 01H
	dec R0
	dec R0
	dec R0
	;-----------
	;oude R1        < --SP
	;-----------
	;oude R0
	;-----------
	;MSB PC
	;-----------
	;LSB PC
	;-----------
	;70H            < --R0
	;-----------
	;60H
	;-----------
	
	mov A, @R0
	mov R1, A                    ;@R1=waarde 70H
	
	dec R0
	
	mov A, @R0
	mov R0, A                    ;@R0 = waarde 60
	
	mov A, @R1
check: cjne A, #0, recursie
	mov @R0, #0
	pop 01H
	pop 00H
	ret
recursie:
	mov @R0, A
	
	inc R0
	inc R1
	
	push 00H
	push 01H
	
	call strcpy
	
	dec SP
	dec SP
	
	pop 01H
	pop 00H
	
	ret
