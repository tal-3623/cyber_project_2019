x2 equ [word ptr bp+6]
y2 equ [word ptr bp+4]

proc whereCanMove
push bp 
mov bp, sp
StartFunction
checkForBotton:
	cmp y2,170
	je cantMoveDMain
checkForRight:
	cmp x2,283
	je cantMoveRMain
	jmp regularCheck
cantMoveDMain:
	mov [CanMoveD],false
	jmp checkForRight
cantMoveRMain:
	mov [CanMoveR],false
	jmp regularCheck
regularCheck:
	mov bx,offset dataAboutSqures
xChecking1:
mov ax,[word ptr bx]
 cmp x2,ax
 je yChexking1
 add bx,10
 jmp xChecking1
yChexking1:
	add bx,2
	mov ax,[word ptr bx]
	cmp y2,ax
	je wallCheckU
	jmp pxChecking1
pxChecking1:
	sub bx,2
	add bx,10
	jmp xChecking1
wallCheckU:
	add bx,4
	mov ax,[word ptr bx]
	cmp ax,true
	je cantMoveU
	mov [CanMoveU],true
	jmp wallCheckL
cantMoveU:
	mov [CanMoveU],false
wallCheckL:
	add bx, 2
	mov ax,[word ptr bx]
	cmp ax,true
	je cantMoveL
	mov [CanMoveL],true
	jmp wallCheckR
cantMoveL:
	mov [CanMoveL],false
wallCheckR:
	cmp [CanMoveR],false
	je checkDownSqureUpWall
	add x2,35
	mov bx,offset dataAboutSqures
xChecking2: 
	mov ax,[word ptr bx]
	cmp x2,ax
	je yChexking2
	add bx,10
	jmp xChecking2
yChexking2:
	add bx,2
	mov ax,[word ptr bx]
	cmp y2,ax
	je checkRightSqureLeftWall
	jmp pxChecking2
pxChecking2:
	sub bx,2
	add bx,10
	jmp xChecking2
checkRightSqureLeftWall:
	add bx,2
	mov ax,[word ptr bx]
	cmp ax,true
	je cantMoveR
	add bx,4
	mov ax,[word ptr bx]
	cmp ax,true
	je cantMoveR
	mov [CanMoveR],true
	jmp checkDownSqureUpWall
cantMoveR:
	mov [CanMoveR],false
	
;------
checkDownSqureUpWall:
	mov ax, [CanMoveD]
	cmp [CanMoveD],false
	je close
	sub x2,35
	add y2,25
	mov bx,offset dataAboutSqures
xChecking3:
	mov ax,[word ptr bx]
	cmp x2,ax
	je yChexking3
	add bx,10
	jmp xChecking3
yChexking3:
	add bx,2
	mov ax,[word ptr bx]
	cmp y2,ax
	je checkWall
	jmp pxChecking3
pxChecking3:
	sub bx,2
	add bx,10
	jmp xChecking3
checkWall:
	add bx,2
	mov ax,[word ptr bx]
	cmp ax,true
	je cantMoveD
	add bx,2
	mov ax,[word ptr bx]
	cmp ax,true
	je cantMoveD
	mov [CanMoveD],true
	jmp close
cantMoveD:
	mov  [CanMoveD],false
close:
	
EndFunction
pop bp
ret 4
endp whereCanMove













;[CanMoveR] dw ?
;[CanMoveL] dw ?
;[CanMoveU] dw ?
;[CanMoveD] dw ?
x2 equ [word ptr bp+6]
y2 equ [word ptr bp+4]

proc whereCanMoveHigeRow
push bp 
mov bp, sp
StartFunction
checkForRight43:
	cmp x2,283
	je cantMoveRMain43
	jmp regularCheck43
cantMoveRMain43:
	mov [CanMoveR],false
	jmp regularCheck43
regularCheck43:
	mov bx,offset dataAboutSqures
xChecking143:
mov ax,[word ptr bx]
 cmp x2,ax
 je yChexking143
 add bx,10
 jmp xChecking143
yChexking143:
	add bx,2
	mov ax,[word ptr bx]
	cmp y2,ax
	je wallCheckU43
	jmp pxChecking143
pxChecking143:
	sub bx,2
	add bx,10
	jmp xChecking143
wallCheckU43:
	add bx,4
	mov ax,[word ptr bx]
	cmp ax,true
	je cantMoveU43
	mov [CanMoveU],true
	jmp wallCheckL43
cantMoveU43:
	mov [CanMoveU],false
wallCheckL43:
	add bx, 2
	mov ax,[word ptr bx]
	cmp ax,true
	je cantMoveL43
	mov [CanMoveL],true
	jmp wallCheckR43
cantMoveL43:
	mov [CanMoveL],false
wallCheckR43:
	cmp [CanMoveR],false
	je checkDownSqureUpWall43
	add x2,35
	mov bx,offset dataAboutSqures
xChecking243: 
	mov ax,[word ptr bx]
	cmp x2,ax
	je yChexking243
	add bx,10
	jmp xChecking243
yChexking243:
	add bx,2
	mov ax,[word ptr bx]
	cmp y2,ax
	je checkRightSqureLeftWall43
	jmp pxChecking243
pxChecking243:
	sub bx,2
	add bx,10
	jmp xChecking243
checkRightSqureLeftWall43:
	add bx,6
	mov ax,[word ptr bx]
	cmp ax,true
	je cantMoveR43
	mov [CanMoveR],true
	jmp checkDownSqureUpWall43
cantMoveR43:
	mov [CanMoveR],false
	
;------
checkDownSqureUpWall43:
	cmp [CanMoveD],false
	je close43
	sub x2,35
	add y2,20
	mov bx,offset dataAboutSqures
xChecking343:
	mov ax,[word ptr bx]
	cmp x2,ax
	je yChexking343
	add bx,10
	jmp xChecking343
yChexking343:
	add bx,2
	mov ax,[word ptr bx]
	cmp y2,ax
	je checkWall43
	jmp pxChecking343
pxChecking343:
	sub bx,2
	add bx,10
	jmp xChecking343
checkWall43:
	add bx,4
	mov ax,[word ptr bx]
	cmp ax,true
	je cantMoveD43
	mov [CanMoveD],true
	jmp close43
cantMoveD43:
	mov  [CanMoveD],false
close43:
	
EndFunction
pop bp
ret 4
endp 



;[CanMoveR] dw ?
;[CanMoveL] dw ?
;[CanMoveU] dw ?
;[CanMoveD] dw ?