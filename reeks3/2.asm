;De C8051F120 en ook de simulator kent twee externe interruptlijnen (INT0 en INT1) die
;laag actief zijn (ttz. een 0 triggert de interrupt). Op de simulator kan je de interruptlijnen
;met knopjes verbinden en eens nagaan of je op die manier je reactiesnelheid kan meten.
;Dus de knop op INT0 start een timer, de knop INT1 stopt de timer en de tijd in tienden
;van secondes toon je op de LED’s in BCD - notatie (15 betekent 15 * 0.1s of 1.5s). Op de
;C8051F120 vergt dat meer werk omdat je eerst die interruptlijnen via de crossbar naar
;buiten moet brengen. Vervolgens kan je ook externe knoppen aansluiten om externe
;interrupts te veroorzaken.

; klokfreq = 7MHz!
; 0.1×((10⁶×7)÷12) = 58333
; 0 - 58333 = 1C23


; open logical diagram en verbindt de interupt lijnen met de knoppen!
; in dynamic interface
org 0000H

jmp main

org 0003H
jmp extern0

org 000BH
jmp timer0

org 0013H
jmp extern1

org 0080H
	
main:
	setb EA
	setb EX0
	setb ET0
	setb IT0
	setb IT1
	mov TMOD, #01H
	mov R2, #0
	jmp $
extern0: mov TH0, #1CH
	mov TL1, #23H
	setb TR0
	clr EX0
	setb EX1
	mov R2, #0
	reti
extern1:clr TR0
	clr EX1
	setb EX0
	reti
	
timer0: clr TF0
	mov TH0, #1CH
	mov TL1, #23H
	inc R2
	mov A, R2
	mov B, #10
	div AB
	swap A
	orl A, B
	cpl A
	mov P1, A
	reti
