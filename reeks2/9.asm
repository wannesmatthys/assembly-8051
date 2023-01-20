;Herneem nu vraag 8 maar breid de oplossing uit naar vier 7 - segmentdisplays die je
;verbindt met poorten P0, P1, P2 en P4 (dus niet P3!). De getallen worden om de 0.77s
;getoond te beginnen bij 0000 en te eindigen bij 9999.


; deze klopt niet

org 0000H

jmp main

org 0080H
	
main:
	clr P3.3
	setb P3.4
	
	mov 20H, #3FH
	mov 21H, #06H
	mov 22H, #5BH
	mov 23H, #4FH
	mov 24H, #66H
	mov 25H, #6DH
	mov 26H, #7DH
	mov 27H, #47H
	mov 28H, #7FH
	mov 29H, #6FH
	
	mov R2, #0
	mov R3, #0
	mov R4, #0
	mov R5, #0
	
	mov TMOD, #01H
	mov TH0, #5DH
	mov TL0, #3DH
	setb TR0
start:jnb TF0, $
	clr TF0
	mov TH0, #5DH
	mov TL0, #3DH
	
	clr P3.3
	clr P3.4
	inc R2
	mov A, R2
	mov R6, A
	cjne R2, #10, uit
	dec R2
	
	setb P3.3
	clr P3.4
	inc R3
	mov A, R3
	mov R6, A
	cjne R3, #10, uit
	dec R3
	
	clr P3.3
	setb P3.4
	inc R4
	mov A, R4
	mov R6, A
	cjne R4, #10, uit
	dec R4
	
	setb P3.3
	setb P3.4
	inc R5
	mov A, R5
	mov R6, A
	cjne R5, #10, uit
	mov R5, #0
	mov R4, #0
	mov R3, #0
	mov R2, #0
uit: mov A, #20H
	add A, R6
	mov R0, A
	mov A, @R0
	cpl A
	mov P1, A
	jmp start
