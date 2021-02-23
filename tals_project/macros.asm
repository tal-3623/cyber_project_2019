





macro EndSound
	in al,61h
	and  al,11111100b  ;stops speaker
	out 61h,al

endm endSound
proc startSoun
	push bp
	mov bp,sp
	push ax               ;הפרןצדורה מקבלת את הקול ןמ]עילה אותו
	sound equ 2500
	in al,61h             ;
	or al,00000011b       ;
	out 61h,al
	;מפעיל ספיר
	;משהו
	mov ax,sound
	out 42h,al
	mov al,ah
	out 42h,al
	pop ax
	pop bp
	ret 
endp startSoun
macro StartSound
call startSoun
endm 
macro TopLeftCornerXY
	push dx
	xor dx,dx
	mov ax,xP
	div [n35]
	mov xP,ax
	xor dx,dx
	mov ax,yp
	div [n25]
	mov yp,ax
	mov ax,35
	mul xp
	mov xP,ax
	mov ax,25
	mul yp
	mov yp,ax
	add xP,38
	sub yp,5
	pop dx
endm
macro TopLeftCornerXYHR
xor dx,dx
	mov ax,xP
	div [n35]
	mov xP,ax
	xor dx,dx
	mov ax,yp
	div [n25]
	mov yp,ax
	mov ax,35
	mul xp
	mov xP,ax
	mov ax,25
	mul yp
	mov yp,ax
	add xP,38
	mov yp,0
endm
macro ReStartSqure
	push cx
	push dx
	push cx
	push dx
	push offset cleenSqure
	call PrintPieceProcRegularSqure
pop dx
pop cx	
endm  
macro ReStartSqureHigerow
	push cx
	push dx
	push cx
	push dx
	push offset cleenSqureHigerow
	call PrintPieceProcHigeRow
pop dx
pop cx	
endm 


macro resetVars
mov [canPlaceWallhorzantcly],true 
mov [canPlaceWallAnch] ,true
mov LeftX,148 
mov  LeftY,148  
mov  RightX,148 
mov  RightY,148 
mov  UpX,148
mov  UpY,148 
mov  DownX,148 
mov  DownY,148
mov  isPanelP,148
mov isExitP,148
mov  xP,148
mov yp ,148
 mov  [CanMoveR],true
mov [CanMoveL],true
mov [CanMoveU] ,true
mov [CanMoveD],true
endm

macro AllNeesedPushES
push 0
push 0
push 0
push 0
push 0
push 0
push 0
push 0
push 0
push 0
push 0
push 0
push 0
push 0
push 0
push 0
endm

macro AllNeesedPops
	pop ax
	pop ax
	pop ax
	pop ax
	pop ax
	pop ax
	pop ax
	pop ax
	pop ax
	pop ax
	pop ax
	pop ax
	pop ax
	pop ax
	pop ax
	pop ax
	pop bp
endm

macro AllEqus
isPanelP equ [word ptr bp-2]
isExitP  equ [word ptr bp-4]
xP equ [word ptr bp-6]
yp equ [word ptr bp-8]
LeftX equ [word ptr bp-18]
LeftY  equ [word ptr bp-20]
RightX equ [word ptr bp-22]
RightY equ [word ptr bp-24]
UpX equ [word ptr bp-26]
UpY equ [word ptr bp-28]
DownX equ [word ptr bp-30]
DownY equ [word ptr bp-32]
endm

macro POPAXCMPTRUE
pop ax
cmp ax,true
endm