# Summary Computerhardware

## Start van ieder programma
Leeg het geheugen bij de start van ieder programma.

```asm
org 0000H

jmp main

org 0080H

main:mov R0,#7FH
loop:mov @R0,#00     
     djnz R0, loop
      ; do stuff
      jmp $
```

## Basic commands
* ```cpl```: eentjes en nulletjes draaien, ```cpl P1``` kan niet! Waarde in accumulator steken.
* ```mov src, dest```: waarde van src in dest steken (kopieren!!)
* ```setb P1.6```: zet bit op 1
* ```cpl P1.6```: wissel bits
* ```clr A```: zet bits op 0
* ```clr P1.6```: zet bit op 0
* ```djnz R0,label```: decrement and jump
* ```djnz R0,$```: blijven decrementeren tot 0, eens 0 naar volgende regel
* ```jb,label```: jump als bit op 1 staat
* ```jnb, label```: jump als bit op 0 staat
* ```rl```: rotate left -> alle bits 1 naar links, 1e naar laatste
* ```rrl```: zelfde als rl, maar minst beduidende bit wordt opgeslagen in carry
* ```rr```: rotate right -> alle bits 1 naar rechts, laatste naar eerste
* ```rrc```: zelfde als rotate right, maar meest beduidende bit wordt opgeslagen in carry
* ```cjne R2,#3,label```: compare and jump if not equal
* ```orl A,R2```: OR logical
* ```anl A,R2```: AND logical
* ```swap A```: 4 times rl
* ```add A,R2```: R2 bij A optellen
* ```jnc label```: jump als carry = 0
* ```jc label```: jump als carry = 1

## Vertragingslussen
```asm
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
```

## Rekenen met adressen
Een adres als "nummer" in A steken. X toevoegen aan A, vb. 21 --> waarde = 21H.
Waarde van A in R0 steken. De waarde van het adres dat R0 bijhoudt in A steken.
Dit werkt enkel met R0 of R1!!

```asm
mov A,#20H
add A,R2
mov R0,A
mov A,@R0
```

## Timers
De simulator bevat slechts twee timers en de klokfrequentie bedraagt 12 MHz (intern gedeeld door 12). Beide zijn 16-bit timers. Van FFFF naar 0000 zal overflow veroorzaken. Als het hexadecimaal getal begint met een letter, voegen we een 0 toe! Indien je interval gevraagd wordt in Hz doen we een extra deling door 2. Vb (5Hz -> 1/5 /2 -> 1/10).

```asm
mov TMOD,#01H
mov TH0,#0BE
mov TL0,#0E5
setb TR0
start:jnb TF0,$
      clr TF0
      mov TH0,#0BE
      mov TL0,#0E5
      ; do stuff
      jmp start
```


### Berekenen van overflow waarde
Dus om de hoeveel seconden we willen dat de timer een interrupt veroorzaakt.

```
#ticks / klokfreq = tijd
#ticks = tijd * klokfreq
```

Grootste waarde nemen van de uitkomst, maar deze mag maximaal 2¹⁶ (65.536) zijn, minimaal 2⁸ (256).


### Voorbeeld
Bereken een interval om de 0.8 seconden, indien je weet dat de klokfrequentie 24.5MHz is en intern nog eens gedeeld wordt door 8.

$$

tijdsinterval = 0.8s\\

klok = \frac{(24.5 * 10⁶)}{8} = 3062500\\

ticks = (tijdsinterval * klok) / (1|4|12|48) =  \\

ticks = \frac{(24.5 * 10⁶)}{8} * 0.8 = 2450000\\
tickets = 2450000 / (1|4|12|48) = 51042
$$

Vervolgens 0 - 51042, dan omzetten naar hexadecimaal.

```
= FFFF FFFF FFFF 389E
THx = 38
TLx = 9E
```

## Interrupts
Interrupts kan zowel met timers als knoppen. Indien je gebruik maakt van knoppen, open logical diagram, kijk waar INT0/INT1 naar wijzen en zet een knop op die waarde in de dynamical interface.

Vanboven adressen declareren met labels.
```asm
org 0003H
jmp extern0 ; interrupt 0

org 0013H
jmp extern 1 ; interrupt 1

org 000BH
jmp timer0

org 001BH
jmp timer1
```

In het main programma, activeren we de interruptlijnen.
```asm
main:
    ; timers
    setb EA
    setb TR0
    setb TR1

    ; interrupt lijnen (knoppen)
    setb EX0
    setb EX1
    setb IT0
    setb IT1
```

De functies zelf eindigen we altijd met reti!
```asm
timer0:
    clr TF0
    mov TH0,#1CH
    mov TL0,#23H
    ; do stuff
    reti

extern0:
    clr EX0 ; als je de knop wil uitschakelen na gebruik...
    setb EX1 ; de andere knop inschakelen (soort toggling infeite...)
    ; do stuff
    reti
```

## Operations

### Kleiner en groter dan
```asm
CJNE
PC = PC + 3
IF A <> immediate
  PC = PC + offset
IF A < immediate
  C = 1
ELSE
  C = 0
```
Aan de hand van de cjne instructie en de carrybit kunnen we dus checken of iets groter of kleiner is. De carry = 1, het linkse is kleiner dan het rechtste. De carry = 0, het rechste is groter of gelijk aan het linkse.

## C naar assembleertaal
Bij het omzetten van C naar assembleertaal is het belangrijk om te weten of je eenprogramma moet schrijven dan wel een subroutine. Bij een subroutine moet voor de aanroep de volledige CPU-context (i.e. alle werkregisters dus) naar de stack worden gekopieerd en op het einde van de subroutine terug worden gehaald. Het kan ook
eenvoudiger door bv. enkel de registers die binnen de subroutine gebruikt worden te bewaren en later terug te zetten. Het kan nooit de bedoeling zijn dat een subroutine een werkregister van inhoud wijzigt. Zowel voor het schrijven van een programma als voor het schrijven van een subroutine moet je ook weten dat lokale variabelen zich op de stapel bevinden.