; Schrijf een programma dat een looplicht verwezenlijkt. 
; Sluit hiervoor de LED-bar aan op poort 1.

org 0000H

jmp main

org 0080H

main:mov A,#10000000b
		cpl A
		mov P1,A
start:mov R2,#255
lus:djnz R2,lus2
	  rr A
	  mov P1,A
	  jmp start
lus2:mov R3,#30
		djnz R3,$
		jmp lus