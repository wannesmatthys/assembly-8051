; Schrijf een programma dat het LED op P1.6 doet knipperen. 
; Doe dit m.b.v. vertragingslussen.

org 0000H

jmp main

org 0080H

main:mov A,#01000000b
		cpl A
		mov P1,A
		setb P1.6
start:cpl P1.6
		 mov R2,#255
lus:djnz R2,lus2
	  jmp start
lus2:mov R3,#255
		djnz R3,$
		jmp lus
		