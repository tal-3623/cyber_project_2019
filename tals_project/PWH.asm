
thisX equ [word ptr bp+6]
thisY equ [word ptr bp+4]




proc PlaceWallHorazion
push bp
mov bp,sp
StartFunction
RegularWallsDataTransformation:
	mov bx,offset dataAboutSqures
xCheckingPWH:
mov ax,[word ptr bx]
 cmp thisX,ax
 je yCheckingPWH
 add bx,10
 jmp xCheckingPWH
yCheckingPWH:
	add bx,2
	mov ax,[word ptr bx]
	cmp thisY,ax
	je UpWallThisSqure1
	jmp pxCheckingPWH
pxCheckingPWH:
	sub bx,2
	add bx,10
	jmp xCheckingPWH
UpWallThisSqure1:
	add bx,4
	mov [word ptr bx],true
	add thisX,35
	mov bx,offset dataAboutSqures
xCheckingPWH2:
mov ax,[word ptr bx]
 cmp thisX,ax
 je yCheckingPWH2
 add bx,10
 jmp xCheckingPWH2
yCheckingPWH2:
	add bx,2
	mov ax,[word ptr bx]
	cmp thisY,ax
	je UpWallThisSqure2
	jmp pxCheckingPWH2
pxCheckingPWH2:
	sub bx,2
	add bx,10
	jmp xCheckingPWH2
UpWallThisSqure2:
	add bx,4
	mov [word ptr bx],true
EndFunction
pop bp
ret 4
endp 