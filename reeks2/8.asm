;Om alle cijfers van 0 tot 9 af te beelden op zo’n display is het handig wanneer je de
;bitpatronen kan bijhouden in een array. Index 0 bevat dan het bitpatroon om een 0 af te
;beelden, ..., index 9 bevat dan het patroon om een 9 af te beelden. Schrijf een
;programma dat deze elementen in een array bijhoudt te beginnen bij adres 20H van het
;interne datageheugen.

; klokfreq 0.5MHz!
; #ticks = 500.000/12*1 = 41667
; 0 - 41667 = 5D3D

org 0000H

jmp main

org 0080H

main:
		setb P0.7
     clr P3.3
     clr P3.4
		
		mov 20H,#3FH
     mov 21H,#06H
     mov 22H,#5BH
     mov 23H,#4FH
     mov 24H,#66H
     mov 25H,#6DH
     mov 26H,#7DH
     mov 27H,#47H
     mov 28H,#7FH
     mov 29H,#6FH

		mov R2,#0

		mov TMOD,#01H
		mov TH0,#5DH
		mov TL0,#3DH
		setb TR0
start:jnb TF0,$
		 clr TF0
		 mov TH0,#5DH
		 mov TL0,#3DH
		 inc R2
		 cjne R2,#10,uit
		 mov R2,#0
uit: mov A,#20H
		add A,R2
		mov R0,A
	 	mov A,@R0
		cpl A
		mov P1,A
		jmp start