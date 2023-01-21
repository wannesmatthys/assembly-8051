;Zet onderstaande code letterlijk om naar assembleertaal:

;void wissel (int * a, int * b){
;int hulp= * a;
;* a= * b;
;* b=hulp;
;return;
;}
;int main(){
;int x=17;
;int y=15;
;wissel(&x, &y);
;while(1);
;}

org 0000H

jmp main

org 0080
	
main:mov R0, #7FH
loop:mov @R0, #0
	djnz R0, loop
	
	mov 60H, #5
	mov 70H, #8
	
	mov R0, #60H
	mov R1, #70H
	
	push 00H
	push 01H
	
	;----------
	;70H
	;----------
	;60H
	;----------
	
	call wissel
	
	dec SP
	dec SP
	
	jmp $
	
wissel: push 00H
	mov R0, SP
	dec R0
	dec R0
	dec R0
	push 01H
	push B
	;----------
	;oude B         < --SP
	;----------
	;oude R1
	;----------
	;oude R0
	;----------
	;MSB PC
	;----------
	;LSB PC
	;----------
	;70H            < --R0
	;----------
	;60H
	;----------
	
	mov A, @R0
	mov R1, A
	;mov @R1, #4
	
	mov B, @R1
	dec R0
	
	mov A, @R0
	mov R0, A
	mov A, @R0
	
	mov @R1, A
	mov @R0, B
	
	pop B
	pop 01H
	pop 00H
	ret
