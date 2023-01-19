# Summary Computerhardware

## Start of every program
```asm
org 0000H

jmp main

org 0080H

main:
    ; do stuff
```

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

## Basic commands
* ```cpl``` = eentjes en nulletjes draaien, ```cpl P1``` kan niet! Waarde in acuumulator steken.
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