; Schrijf een functie geef_kleinste(a, b, c) die het kleinste element bepaalt en dit teruggeeft.
; De paramaters worden opnieuw doorgegeven via de stack. De returnwaarde bevindt zich
; ook zoals steeds in de accumulator.

; zie 4.c hoe we dit zouden uitvoeren als C code...

org 0000H

jmp main

org 0080H
	
main:mov R0, #7FH
loop:mov @R0, #0
	djnz R0, loop
start: mov A, #10
	mov R0, #20
	mov R1, #40
	
	push Acc
	push 00H
	push 01H
	
	;----------
	; 40
	;----------
	; 20
	;----------
	; 10
	;----------
	call kleinste
	
	dec SP
	dec SP
	dec SP
	
	jmp $
kleinste:
	;----------
	; MSB PC < --SP
	;----------
	; LSB PC
	;----------
	; 40
	;----------
	; 20
	;----------
	; 10
	;----------
	push 00H
	mov R0, SP
	push 01H
	push 02H
	push 03H
	push 04H
	dec R0
	dec R0
	dec R0
	;----------
	; oude R4       < --SP
	;----------
	; oude R3
	;----------
	; oude R2
	;----------
	; oude R1
	;----------
	; oude R0
	;----------
	; MSB PC
	;----------
	; LSB PC
	;----------
	; 40            < --R0
	;----------
	; 20
	;----------
	; 10
	;----------
	
	mov 02H, @R0                 ; R2=40 (param a)
	dec R0
	mov 03H, @R0                 ; R3=20 (param b)
	dec R0
	mov 04H, @R0                 ; R4=10 (param c)
	
	mov A, R3                    ; A = param b
	cjne A, 02H, next
	; b < a => C=1, b>=a => C=0
	
next: jc recursie
	mov A, R2
	cjne A, 04H, next2
	; a < c => C=1, a>=c => C=0
next2: jnc returnc
returna: mov A, R2
	pop 04H
	pop 03H
	pop 02H
	pop 01H
	pop 00H
	ret
returnc: mov A, R4
	pop 04H
	pop 03H
	pop 02H
	pop 01H
	pop 00H
	ret
	
recursie:
	push 04H
	push 02H
	push 03H
	
	call kleinste

	dec SP
	dec SP
	dec SP

	pop 04H
	pop 03H
	pop 02H
	pop 01H
	pop 00H
	ret
