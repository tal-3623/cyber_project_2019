


thisx2 equ [word ptr bp+6]
thisY2 equ [word ptr bp+4]





proc PlaceWallAnach
push bp
mov bp,sp
StartFunction
RegularWallsDataTransformation2:
	mov bx,offset dataAboutSqures
xCheckingPWA:
mov ax,[word ptr bx]
 cmp thisx2,ax
 je yCheckingPWA
 add bx,10
 jmp xCheckingPWA
yCheckingPWA:
	add bx,2
	mov ax,[word ptr bx]
	cmp thisY2,ax
	je LeftWallThisSqure1
	jmp pxCheckingPWA
pxCheckingPWA:
	sub bx,2
	add bx,10
	jmp xCheckingPWA
LeftWallThisSqure1:
	add bx,6
	mov [word ptr bx],true
	add thisY2,25
	mov bx,offset dataAboutSqures
xCheckingPWA2:
mov ax,[word ptr bx]
 cmp thisx2,ax
 je yCheckingPWA2
 add bx,10
 jmp xCheckingPWA2
yCheckingPWA2:
	add bx,2
	mov ax,[word ptr bx]
	cmp thisY2,ax
	je LeftWallThisSqure2
	jmp pxCheckingPWA2
pxCheckingPWA2:
	sub bx,2
	add bx,10
	jmp xCheckingPWA2
LeftWallThisSqure2:
	add bx,6
	mov [word ptr bx],true
EndFunction
pop bp
ret 4
endp 