; De bedoeling is nu om het zoeken van een getal in een subroutine te gaan
; onderbrengen. We krijgen nu de volgende code:

; Zie 6.c


org 0000H

jmp main

org 0080H
	
main:mov R0, #7FH
loop:mov @R0, #0
	djnz R0, loop
	
	mov 70H, #1
	mov 71H, #2
	mov 72H, #3
	mov 73H, #7
	mov 74H, #15
	mov 75H, #23H
	
	mov R0, #7
	mov R1, #6
	mov R2, #70H
	
	push 00H
	push 01H
	push 02H
	
	call zoek
	
	;-------------
	; 70H
	;-------------
	; 6
	;-------------
	; 7
	;-------------
	
	dec SP
	dec SP
	dec SP
	
	cjne A, #1, uit
	clr P1.6
	jmp $
	
uit:
	setb P1.6
	jmp $
	
zoek:push 00H
	mov R0, SP
	push 02H
	push 03H
	push 04H
	push 05H
	
	dec R0
	dec R0
	dec R0
	;-------------
    ; oude R5       <-- SP        
	;-------------
	; oude R4
	;-------------
	; oude R3
	;-------------
	; oude R2
	;-------------
	; oude R0
	;-------------
	; MSB PC
	;-------------
	; LSB PC
	;-------------
	; 70H           < --R0
	;-------------
	; 6
	;-------------
	; 7
	;-------------
	
	mov A, @R0                   ; A= startadres
	dec R0
	mov 02H, @R0                 ; R2=aantal elementen
	dec R0
	mov 03H, @R0                 ; R3=getal
	mov R4, #00H                 ; R4=teller
	mov R5, A                    ; hulpregister
	
check: mov A, R4
	cjne A, 02H, doorgaan
	mov A, #0H
	pop 05H
	pop 04H
	pop 03H
	pop 02H
	pop 00H
	ret
doorgaan:
	mov A, R5
	add A, R4
	mov R0, A
	mov A, @R0
	cjne A, 03H, increment
	mov A, #1
	pop 05H
	pop 04H
	pop 03H
	pop 02H
	pop 00H
	ret
increment:
	inc R4
	jmp check
