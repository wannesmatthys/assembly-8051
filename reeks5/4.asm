; Zet onderstaande code letterlijk om naar assembleertaal:

; void plaats_pointer_op_getal(int * * p, int n, int getal){
; int i=0;
; while(i<n && * * p!=getal){
; ( * p) + + ; i + + ;
; }
; if (i==n) * p=NULL;
; }
; void main(void){
; int tab[]={1, 2, 3, 7, 15, 0x23};
; int * h=tab;
; plaats_pointer_op_getal(&h, 6, 7);
; P1.6=(h==NULL?1:0);
; while(1);
; }

org 0000H
jmp main
org 0040H
main: mov R0, #7FH
loop:mov @R0, #00
	djnz R0, loop
	mov A, #20
	push Acc
	mov A, #10
	push Acc
	mov A, #10
	push Acc
	call kleinste
	dec SP
	dec SP
	dec SP
	jmp $
	
kleinste:
	; - - - - - - - - - - 
	;MSB PC < - - - SP
	; - - - - - - - - - - 
	;LSB PC
	; - - - - - - - - - - 
	;3
	; - - - - - - - - - - 
	;2
	; - - - - - - - - - - 
	;1
	; - - - - - - - - - - 
	push 00H
	mov R0, SP
	push 01H
	push 02H
	push 03H
	;oude R3 < - - - SP
	; - - - - - - - - - - 
	;oude R2
	; - - - - - - - - - - 
	;oude R1
	; - - - - - - - - - - 
	;oude R0 < - - - R0
	; - - - - - - - - - - 
	;MSB PC
	; - - - - - - - - - - 
	;LSB PC
	; - - - - - - - - - - 
	;3
	; - - - - - - - - - - 
	;2
	; - - - - - - - - - - 
	;1
	; - - - - - - - - - - 
	dec R0
	dec R0
	dec R0
	mov 01H, @R0                 ; R1=a
	dec R0
	mov 02H, @R0                 ; R2=b
	dec R0
	mov 03H, @R0                 ; R3=c
	mov A, R1
	cjne A, 02H, next
	setb C
next:                         ;rechteroperand < linkeroperand
	;C=1
	jnc verder
	;ik weet zeker dat a<b
	
	cjne A, 03H, next2
	setb C
next2:                        ;C==1 => a<c
	jnc verder2
	;ik weet zeker dat a<b && a<c
	mov A, R1
	jmp stop
verder:                       ; ik weet zeker dat b<a
	push 03H
	push 01H
	push 02H
	call kleinste
	dec Sp
	dec SP
	dec SP
	jmp stop
	
verder2:
	;ik weet zeker dat a<b && a>=c
	mov A, R3
	
	
stop:pop 03H
	pop 02H
	pop 01H
	pop 00H
	ret
