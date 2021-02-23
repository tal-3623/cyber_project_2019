X equ [word ptr bp+6]
Y equ [word ptr bp+4]

;מחזירה אמת או שקר האם השחרן נמצא? {
proc isPlayerThere
push bp
mov bp,sp 
StartFunction
mov bx,offset dataAboutSqures
xChecking:
mov ax,[word ptr bx]
 cmp X,ax
 je yChexking
 add bx,10
 jmp xChecking
yChexking:
	add bx,2
	mov ax,[word ptr bx]
	cmp Y,ax
	je playerCheck
	jmp PxChecking
playerCheck:
	add bx,2
	mov ax,[word ptr bx]
	mov X,ax
	EndFunction
	pop bp
	ret 2

PxChecking:
sub bx,2
add bx,10
jmp xChecking
;}

endp isPlayerThere