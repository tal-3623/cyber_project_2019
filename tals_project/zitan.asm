

macro StartFunction
	push si
	push di
	push dx 
	push cx
	push bx
	push ax

endm
macro EndFunction
; Saves the value of the registers

	pop ax
	pop bx
	pop cx
	pop dx
	pop di
	pop si
endm
macro StartProc NUM_OF_LOCAL_PARAMS
	push bp
	mov bp, sp
	sub sp, NUM_OF_LOCAL_PARAMS
endm
;--------------------------------------
macro EndProc RETURN_SP
;	Standard procedure ending
	add sp, RETURN_SP
	pop bp
endm
Xcoordinate equ [bp + 8]
Ycoordinate equ [bp + 6]
pixelColor equ [bp + 4]
proc PrintPixelProc
	StartProc 0
	mov bh,0h 
	mov cx,Xcoordinate
	mov dx,Ycoordinate
	mov al,pixelColor 
	mov ah,0ch 
	int 10h
	EndProc 0
	ret 6
endp PrintPixelProc

macro PrintPixel X, Y, COLOR
	StartFunction
	push X
	push Y
	push COLOR
	call PrintPixelProc
	EndFunction
endm

PieceXPlace equ [word ptr bp + 8]
PieceYPlace equ [word ptr bp + 6]
PieceType equ [word ptr bp + 4]
proc PrintPieceProcRegularSqure
	HideMouseM
	StartProc 2d
	StartFunction
	mov dx, PieceXPlace
	mov bx, PieceXPlace
	add bx, 35d
	mov ax, PieceYPlace
	add ax, 25d
	mov si, PieceType
	mov cl, [byte ptr si]
	CheckColorValue:
		cmp cl, 1d
		je DontPrint
	
		PrintPixel PieceXPlace PieceYPlace cx
	dontPrint:
		inc PieceXPlace
		inc si
		mov cl, [byte ptr si]
		cmp PieceXPlace, bx
		jne CheckColorValue
		inc PieceYPlace
		mov PieceXPlace, dx
		cmp PieceYPlace, ax
		jne CheckColorValue
		EndFunction
		EndProc 2d
		ShowMouseM
		ret 6
		endp PrintPieceProcRegularSqure
		; Saves the value of the registers 

;--------------------------------------

;--------------------------------------

; Prints a pixel (procedure)

;--------------------------------------

; Prints a pixel

;--------------------------------------

;	Standard procedure opening

;--------------------------------------


;שינוים של לפרוצדורה של זיתן
;כדאי שתתאים לגודל של השורה העליונה{
proc PrintPieceProcHigeRow
	HideMouseM
	StartProc 2d
	StartFunction
	mov dx, PieceXPlace
	mov bx, PieceXPlace
	add bx, 35d
	mov ax, PieceYPlace
	add ax, 20d
	mov si, PieceType
	mov cl, [byte ptr si]
	CheckColorValue2:
		cmp cl, 1d
		je DontPrint2
	
		PrintPixel PieceXPlace PieceYPlace cx
	dontPrint2:
		inc PieceXPlace
		inc si
		mov cl, [byte ptr si]
		cmp PieceXPlace, bx
		jne CheckColorValue2
		inc PieceYPlace
		mov PieceXPlace, dx
		cmp PieceYPlace, ax
		jne CheckColorValue2
		EndFunction
		EndProc 2d
		ShowMouseM
		ret 6
		endp PrintPieceProcHigeRow
;}