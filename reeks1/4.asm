; Schrijf een programma dat wanneer de gebruiker op de drukknop op P3.7 drukt, 
; het LED op P1.6 eenmaal doet knipperen.
;Wanneer er een tweede maal gedrukt wordt, knippert het LED 2 maal.
;Enz.
;Knipperen betekent aan én uit.
;Dus tweemaal knipperen betekent dus in het totaal 4 keer cpl uitvoeren.

org 000H

jmp main

org 0080H
	
main:mov R2, #3
start:jnb P3.3, $
	jb P3.3, $
	mov A, R2
pressed:mov R3, #255
	djnz R2, lus
	mov R2, A
	inc R2
	inc R2
	jmp start
lus: djnz R3, lus2
	cpl P1.6
	jmp pressed
lus2:mov R4, #100
	djnz R4, $
	jmp lus
