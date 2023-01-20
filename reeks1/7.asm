; Schrijf een programma dat bij het indrukken van de drukknop, aangesloten op P3.7, het looplicht in tegengestelde zin doet lopen.
;De knop aangesloten op P3.7 moet losgelaten worden om van looprichting te wisselen

org 0000H

jmp main

org 0080H
	
main:mov A, #10000000b
	cpl A
	mov P1, A
start:mov R3, #255
	
	
lus:djnz R3, lus2
	jb P3.3, left_rotate
	jnb P3.3, right_rotate
verder:
	mov P1, A
	jmp start
lus2:mov R4, #50
	djnz R4, $
	jmp lus
	
left_rotate:rl A
	jmp verder
right_rotate:rr A
	jmp verder
