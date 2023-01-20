# Summary Computerhardware

## Start of every program
TODO: Leeg het geheugen bij de start van ieder programma.
```asm
org 0000H

jmp main

org 0080H

main:
    ; do stuff
```

## Basic commands
* ```cpl```: eentjes en nulletjes draaien, ```cpl P1``` kan niet! Waarde in acuumulator steken.
* ```mov src, dest```: waarde van src in dest steken (kopieren!!)
* ```setb P1.6```: zet bit op 1
* ```cpl P1.6```: wissel bits
* ```clr A```: zet bits op 0
* ```clr P1.6```: zet bit op 0
* ```djnz R0,label```: decrement and jump
* ```djnz R0,$```: blijven incrementen tot 0, eens 0 naar volgende regel
* ```jb,label```: jump als bit op 1 staat
* ```jnb, label```: jump als bit op 0 staat
* ```rl```: rotate left -> alle bits 1 naar links, 1e naar laatste
* ```rr```: rotate right -> alle bits 1 naar rechts, laatste naar eerste
* ```cjne R2,#3,label```: compare and jump if not equal
* ```orl A,R2```: OR logical
* ```anl A,R2```: AND logical
* ```swap A```: 4 times rl
* ``` 
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
De simulator bevat slechts twee timers en de klokfrequentie bedraagt 12 MHz (intern gedeeld door 12). Beide zijn 16-bit timers. Van FFFF naar 0000 zal overflow veroorzaken. Als het hexadecimaal getal begint met een letter, voegen we een 0 toe!

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