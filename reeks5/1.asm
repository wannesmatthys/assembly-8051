;Schrijf een recursieve functie faculteit die van een getal dat als enige parameter
;meegegeven wordt de faculteit te berekenen.

;zie 1.c voor de C code

org 0000H

jmp main

org 0080H
	
main:mov R0, #7FH
loop:mov @R0, #0
	djnz R0, loop
	
	mov R2, #5
	push 02H
	
	;-------
	;5
	;-------
	
	call fac
	
	dec SP
	
	jmp $
	
fac: push 00H
	mov R0, SP
	push 02H
	push B
	dec R0
	dec R0
	dec R0
	;-------
	;oude B     < --SP
	;-------
	;oude R2
	;-------
	;oude R0
	;-------
	;MSB PC
	;-------
	;LSB PC
	;-------
	;5          < --R0
	;-------
	mov 02H, @R0
check: cjne R2, #0, recursie
	mov A, #1
	pop B
	pop 02H
	pop 00H
	ret
recursie:
	dec R2
	push 02H
	
	call fac
	
	dec SP
	
	inc R2
	mov B, R2
	mul AB
	
	pop B
	pop 02H
	pop 00H
	ret
