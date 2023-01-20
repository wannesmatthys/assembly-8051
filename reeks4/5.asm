; Schrijf nu een functie geef_laatste_element (array, n) die het element op de laatste index
; van een array teruggeeft.

org 0000H

jmp main

org 0080H
	
main:mov R0, #7FH
loop:mov @R0, #0
	djnz R0, loop
	
	
	mov 70H, #5
	mov 71H, #15
	mov 72H, #'a'
	
	mov R2, #3
	push 02H
	mov R0, #70H
	push 00H
	;-----
	;70H        < --SP
	;-----
	;3
	;-----
	call gle
	;-----
	;70H        < --SP
	;-----
	;3
	;-----
	dec SP
	dec SP
	;-----
	;70H
	;-----
	;3
	;-----
	; < --SP
	jmp $
	
gle:
	;---------
	; MSB PC        < --SP
	;---------
	; LSB PC
	;---------
	; 70H
	;---------
	; 6
	;---------
	push 00H
	mov R0, SP
	push 02H
	dec R0
	dec R0
	dec R0
	;---------
	; oude R2       < --SP
	;---------
	; oude R0
	;---------
	; MSB PC
	;---------
	; LSB PC
	;---------
	; 70H           < --R0
	;---------
	; 6
	;---------
	
	mov A, @R0
	dec R0
	
	
	mov 02H, @R0
    add A, R2       ; lengte toevoegen = 1 te ver
	dec A
	mov R0, A
	mov A, @R0
	
	
	pop 02H
	pop 00H
	ret
