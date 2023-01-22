; Maak een programma waar het eerste en het laatste element gewisseld worden

org 0000H

jmp main

org 0080H
	
main:mov R0, #7FH
loop:mov @R0, #0
	djnz R0, loop
	
	mov 70H, #1
	mov 71H, #2
	mov 72H, #3
	mov 73H, #4
	mov 74H, #5
	
	mov R0, #70H
	push 00H
	
	mov R2, #5
	push 02H
	
	
	
	; - - - - - - - - - 
	; 5
	; - - - - - - - - - 
	; 70H
	; - - - - - - - - - 
	
	call draai
	
	dec SP
	dec SP
	
	jmp $
	
draai: push 00H
	mov R0, SP
	push 01H
	push 02H
	push B
	dec R0
	dec R0
	dec R0
	; - - - - - - - - - 
	; B < - - SP
	; - - - - - - - - - 
	; oude R2
	; - - - - - - - - - 
	; oude R1
	; - - - - - - - - - 
	; oude R0
	; - - - - - - - - - 
	; MSB PC
	; - - - - - - - - - 
	; LSB PC
	; - - - - - - - - - 
	; 5 < - - R0
	; - - - - - - - - - 
	; 70H
	; - - - - - - - - - 
	
	mov 02H, @R0                 ; R2=5 (lengte)
	dec R0
	
	mov A, @R0
	mov R1, A
	
	mov @R1, #3
	mov B, @R1
	
	add A, R2
	dec A
	mov R0, A
	
	mov A, @R0
	mov @R1, A
	mov @R0, B
	
	pop B
	pop 02H
	pop 01H
	pop 00H
	ret
