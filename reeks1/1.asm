; Schrijf een programma dat het LED op P1.6 aanzet.
	
org 0000H

jmp main

org 0080H
	
main:mov A, #01000000b
	cpl A
	mov P1, A
	jmp $
