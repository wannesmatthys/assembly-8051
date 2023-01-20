;Schrijf een programma dat het lampje aangesloten op de P1.6 doet knipperen met een
;interval van 0.8s. Dus 0.8s aan en 0.8s uit.

; klokfreq op 0.5MHz!

; #ticks = tijd * klokfreq
; #ticks = 0.8 * (500.000 / 12) = 33333
; 0 - 33333 = 7DCB
; THx = 7D
; TLx = CB

org 0000H

jmp main

org 0080H
	
main:
	mov TMOD, #01H               ; timer 0 mode 1
	mov TH0, #07DH
	mov TL0, #0CBH
	setb TR0
start:jnb TF0, $
	clr TF0
	mov TH0, #07DH
	mov TL0, #0CBH
	cpl P1.6
	jmp start
