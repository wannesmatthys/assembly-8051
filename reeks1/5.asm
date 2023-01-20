; Sluit de LED - bar aan op digitale I / O - poort 1 en schrijf een programma dat alle LED’s doet knipperen

org 0000H

jmp main

org 0080H
	
main:mov A, #11111111b
start:cpl A
	mov P1, A
	mov R3, #255
lus:djnz R3, lus2
	mov P1, A
	jmp start
lus2:mov R4, #255
	djnz R4, $
	jmp lus
