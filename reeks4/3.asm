;Schrijf een kleine functie vermenigvuldig(a, b) die twee parameters a en b neemt (die
;worden bij het aanroepen via de stapel doorgegeven). De functie geeft de LSB van het
;product terug. (De teruggeefwaarde bevindt zich steeds in de accumulator).

org 0000H

jmp main

org 0080H
	
main:mov R0, #7FH
loop:mov @R0, #0
	djnz R0, loop
start: mov R0, #70H
	mov A, #3H
	
	push 00H
	push Acc
	
	call verm
	; - - - - - - - 
	; 3
	; - - - - - - - 
	; 70
	; - - - - - - - 
	dec SP
	dec SP
	
	jmp $
	
verm:
	; - - - - - - - - - 
	; MSB PC < - - SP
	; - - - - - - - - - 
	; LSB PC
	; - - - - - - - - - 
	; 3
	; - - - - - - - - - 
	; 70
	; - - - - - - - - - 
	push 00H
	mov R0, SP
	push B
	; - - - - - - - - - 
	; oude B                < - - SP
	; - - - - - - - - - 
	; oude R0               < - - R0
	; - - - - - - - - - 
	; MSB PC
	; - - - - - - - - - 
	; LSB PC
	; - - - - - - - - - 
	; 3
	; - - - - - - - - - 
	; 70
	; - - - - - - - - - 
	dec R0
	dec R0
	dec R0
	; - - - - - - - - - 
	; oude B                < - - SP
	; - - - - - - - - - 
	; oude R0
	; - - - - - - - - - 
	; MSB PC
	; - - - - - - - - - 
	; LSB PC
	; - - - - - - - - - 
	; 3                     < - - R0
	; - - - - - - - - - 
	; 70
	; - - - - - - - - - 
	mov A, @R0
	dec R0
	; - - - - - - - - - 
	; oude B                < - - SP
	; - - - - - - - - - 
	; oude R0
	; - - - - - - - - - 
	; MSB PC
	; - - - - - - - - - 
	; LSB PC
	; - - - - - - - - - 
	; 3
	; - - - - - - - - - 
	; 70                    < - - R0
	; - - - - - - - - - 
	mov B, @R0
	
	mul AB
	; LSB product - > A
	; MSB product - > B
	pop B
	pop 00H
	ret
