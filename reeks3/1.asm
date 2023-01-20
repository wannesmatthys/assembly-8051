;Gebruik timer 0 om op P1.1 een blokgolf te genereren van 5Hz en timer 1 om een
;blokgolf van 7Hz te genereren op P1.2. Gebruik gerust de lampjes om dit uit te testen.
;(voor de C8051F120 gebruik je P5.1 en P5.2)

; Als je een vraag krijgt in Hz betekent dit dat het 1 / x seconden duurt vooraleer het signaal zich herhaalt. Dus doe dit / 2!
; Bij frequenties deel je extra door 2...
; => Dus 5Hz: 1 / 5 seconden, 7Hz: 1 / 7 seconden.

; klokfreq op 7 MHz!

; 5Hz: (1÷10)×((10⁶×7)÷12) = 58333
; 0 - 58333 = 1C23

; 7Hz: (1 / 14) * ((10⁶ * 7) / 12) = 41666
; 0 - 41666 = 5D3E

org 0000H

jmp main

org 0080H

org 000BH
jmp timer0

org 001BH
jmp timer1
	
main:
	setb EA
	setb ET0
	setb ET1
	mov TMOD, #11H
	mov TH0, #1CH
	mov TL0, #23H
	
	mov TH1, #5DH
	mov TL1, 3EH
	
	
	setb TR0
	setb TR1
	
	jmp $
	
timer0:clr TF0
	mov TH0, #1CH
	mov TL0, #23H
	cpl P1.1
	reti
timer1:clr TF1
	mov TH1, #5DH
	mov TL1, 3EH
	cpl P1.2
	reti
