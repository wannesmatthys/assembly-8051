;Schrijf een ASM - programma dat alle cijfers tussen [0 - 15] in hexadecimale vorm op een 7 - 
;segmentdisplay toont. Iedere 10 seconden wordt het volgende cijfer getoond. Gebruik
;gerust een omzettabel waar index 0 zich op adres 40H bevindt. Gebruik ook interrupts.
;Bij het indrukken van de knop die verbonden is met INT0 wordt er onmiddellijk gestopt.

; klokfreq = 0.05MHz!

; 10 * (50000 / 12) = 41667
; 0 - 41667 = 5D3D


org 0000H

jmp main


org 0003H
jmp extern0

org 000BH
jmp timer0

org 0080H
	
main:mov R0, #7FH
loop:mov @R0, #00
	djnz R0, loop
	setb P0.7
	clr P3.4
	clr P3.3
	mov 40H, #3FH
	mov 41H, #06H
	mov 42H, #5BH
	mov 43H, #4FH
	mov 44H, #66H
	mov 45H, #6DH
	mov 46H, #7DH
	mov 47H, #47H
	mov 48H, #7FH
	mov 49H, #6FH
	mov 4AH, #77H
	mov 4BH, #7CH
	mov 4CH, #39H
	mov 4DH, #5EH
	mov 4EH, #79H
	mov 4FH, #71H
	
	setb EA
	setb ET0
	setb EX0
	mov TMOD, #01H
	mov TH0, #5DH
	mov TL0, #3DH
	setb TR0
	
	mov R2, #0
	jmp $
timer0: clr TF0
	mov TH0, #5DH
	mov TL0, #3DH
	cpl P1.6
	cjne R2, #16, uit
	mov R2, #0
uit:
	mov A, #40H
	add A, R2
	mov R0, A
	mov A, @R0
	cpl A
	mov P1, A
	inc R2
	reti
	
extern0:
	clr TR0
	jmp $
