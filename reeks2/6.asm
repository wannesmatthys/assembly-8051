;BCD-code betekent dat je 4 bits gebuikt voor het voorstellen van een decimaal cijfer. Dus
;met 8 bits kan je twee decimale cijfers voorstellen. Op die manier kan je met de LED’s
;decimale getallen afbeelden van 0 tot 99 (met diezelfde byte kan je getallen voorstellen
;tussen 0 en 255 maar omdat we hier per 4 bits slechts 10 toestanden gebruiken, lukt dit
;maar tot 99). Schrijf een programma dat alle BCD-getallen te beginnen bij 00H en te
;eindigen bij 99H sequentieel en cyclisch naar de LED’s stuurt. De tijd tussen ieder getal
;dat het getoond wordt en zijn opvolger bedraagt 0.32s.



; klokfreq op 1MHz!
; #ticks = 10⁶/12 * 0.32= 26667
; 0 - 26667 = 97D5

org 000H

jmp main

org 0080H

main:mov TMOD,#01H
		mov TH0,#97H
		mov TL0,#0D5H
		setb TR0
		mov R2,#0
		mov R3,#0
start:jnb TF0,$
		 clr TF0
		 mov TH0,#97H
		 mov TL0,#0D5H
		
		 inc R2
		 cjne R2,#10,uit
		 mov R2,#0
		 cjne R3,#10,uit
		 mov R3,#0
		 
		 jmp start
uit:mov A,R3
	 swap A
	 orl A,R2
	 mov P1,A
	 jmp start