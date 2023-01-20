;Sluit op digitale I / O - poort 1 de andere LED’s aan en schrijf een programma dat de cijfers
;0 tot 9 in binaire vorm op de LED’s toont. Tussen iedere getoonde waarde bevindt zich 2s
;vooraleer het volgende getal wordt getoond.

; plaats klok op 0.25MHz!

; #ticks = tijd * klokfreq (250000 / 12) = 41667
; #ticks = 5D3D
; THx = 5DH
; TLx = 3DH

org 0000H

jmp main

org 0080H
	
main:mov TMOD, #01H
	mov TH0, #5DH
	mov TL0, #3DH
	setb TR0
start:jnb TF0, $
	clr TF0
	mov TH0, #5DH
	mov TL0, #3DH
	cpl P1.6
	inc R2
	cjne R2, #10, uit
	mov R2, #0
	jmp start
uit: mov A, R2
	cpl A
	mov P1, A
	jmp start
