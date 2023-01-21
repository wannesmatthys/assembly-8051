; Schrijf een functie verm(a, b) die twee parameters neemt en het product teruggeeft. Bij
; het uitwerken van de functie mag je geen MUL - instructie gebruiken. Een oplossing
; waarbij je a aantal keer b optelt wordt als onjuist beschouwd. Het kan voor bytes in
; maximum 8 iteraties en voor 32 - bit getallen in maximum 32 iteraties.

; zie 2.c

org 0000H

mov R0, #70H
mov R1, #75H

push 00H
push 01H
call verm
dec SP
dec SP
jmp $
	
verm: push 00H
	mov R0, SP
	; - - - - - - - - - 
	;oude R0 < - - SP < - - R0
	; - - - - - - - - - 
	;MSB ret addr
	; - - - - - - - - - 
	;LSB ret addr
	; - - - - - - - - - 
	;75H
	; - - - - - - - - - 
	;70H
	; - - - - - - - - - 
	push 02H
	push 03H
	push 04H
	push 05H
	push 06H
	dec R0
	dec R0
	dec R0
	; R2 - > multiplicator
	; R3 R4 - > MSB LSB multiplicand
	; R5 R6 - > MSB LSB resultaat
	mov 02H, @R0                 ; R2 bevat 75H
	dec R0
	mov 04H, @R0                 ; R4 bevat 70H
	mov R3, #00
	mov R5, #00
	mov R6, #00
start: mov A, R2
	clr C
	rrc A
	mov R2, A                    ; R2>>=1
	jnc verder
	;C=1 - > optellen
	mov A, R6
	add A, R4
	mov R6, A
	mov A, R5
	addc A, R3
	mov R5, A
verder:
	clr C
	mov A, R4
	rlc A
	mov R4, A
	mov A, R3
	rlc A
	mov R3, A
	cjne R2, #00, start
	mov A, R6
	mov B, R5
	pop 06H
	pop 05H
	pop 04H
	pop 03H
	pop 02H
	pop 00H
	ret
