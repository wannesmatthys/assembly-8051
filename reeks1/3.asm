; Schrijf een programma dat bij het indrukken van de schakelaar, 
; aangesloten op P3.7, het LED op P1.6 aan - of uitschakelt.

org 0000H

jmp main

org 0080H
	
main:jb P3.3, $
	cpl P1.6
	mov R0, #255
	jnb P3.3, $
	cpl P1.6
	jmp main
