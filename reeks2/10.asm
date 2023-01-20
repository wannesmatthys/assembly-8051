;Configureer nu timer 3 om het lampje op P1.6 te doen knipperen met een frequentie van 5Hz.

; Als je een vraag krijgt in Hz betekent dit dat het 1/x seconden duurt vooraleer het signaal zich herhaalt. Dus doe dit /2!
; Bij frequenties deel je extra door 2...
; => Dus 5Hz: 1/5 seconden, 7Hz: 1/7 seconden.

; klokfreq op 7 MHz!

; 5Hz: (1÷10)×((10⁶×7)÷12) = 58333
; 0 - 58333 = 1C23


org 0000H

jmp main

org 0080H

main:
	mov TMOD,#01H
	mov TH0,#1CH
	mov TL0,#23H
	setb TR0
start:	jnb TF0,$
		 	clr TF0
			mov TH0,#1CH
			mov TL0,#23H
		 	cpl P1.6
		 	jmp start