proc showMouse
	push ax
	mov  AX,0001H                ; SHOW MOUSE CURSOR
	int  33H
	pop ax
	ret
endp showMouse
 true equ 1
 false equ 0
	proc hideMouse
	push ax
	mov  ax,0002h                ; hide mouse cursor
	int  33h
	pop ax
	ret
endp hideMouse
macro ShowMouseM
call showMouse
endm
macro HideMouseM
call hideMouse
endm 