; Zet onderstaande code letterlijk om naar assembleertaal. Zie 2.c voor omzetting naar code die we makkelijker kunnen omzetten naar assembleertaal.

; int main(){
; int tab[]={1, 2, 3, 7, 15, 0x23};
; int i=0;
; while (i<6 && tab[i]!=7) i + + ;
; P1.6=(i==6?1:0);
; while(1);
; }

org 0000H

jmp main

org 0080H
	
main:mov R0, #7FH
loop:mov @R0, #00
	djnz R0, loop
	mov 70H, #1
	mov 71H, #2
	mov 72H, #3
	mov 73H, #7
	mov 74H, #15
	mov 75H, #23H
	
	mov R2, #00
start: cjne R2, #6, doorgaan
	setb P1.6
	jmp $
doorgaan:
	mov A, #70H
	add A, R2
	mov R0, A
	cjne @R0, #7, increment
	clr P1.6
	jmp $
increment:inc R2
	jmp start
