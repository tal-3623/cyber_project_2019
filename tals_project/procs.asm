

macro PrintBmpPicture FILE_NAME
	push offset FILE_NAME
	call PrintBmpPictureProc
endm

file_name equ [word ptr bp+4]
proc PrintBmpPictureProc
	StartProc 0 
	StartFunction
	push file_name
	call OpenFile
	call ReadHeader
	call ReadPalette
	call CopyPal
	HideMouseM
	call CopyBitmap
	ShowMouseM
	call CloseFile 
	EndFunction
	EndProc 0
	ret 2
endp PrintBmpPictureProc
;============ Bmp Proc ========
OpenFileName equ [word ptr bp + 4]
proc OpenFile
	; Open file
	StartProc 0
	mov ah, 3Dh
	xor al, al
	mov dx, OpenFileName
	int 21h
	jc openerror
	mov [filehandle], ax 
	EndProc 0
	ret 2
	openerror:
	mov dx, offset ErrorMsg
	mov ah, 9h
	int 21h
	MOV AX, 4C00H
	INT 21H
		
	EndProc 0
	ret 2
endp OpenFile







proc ReadHeader
; Read BMP file header, 54 bytes
mov ah,3fh
mov bx, [filehandle]
mov cx,54
mov dx,offset Header
int 21h
ret
endp ReadHeader
proc ReadPalette
; Read BMP file color palette, 256 colors * 4 bytes (400h)
mov ah,3fh
mov cx,400h
mov dx,offset Palette
int 21h
ret
endp ReadPalette 

proc CopyPal
; Copy the colors palette to the video memory
; The number of the first color should be sent to port 3C8h
; The palette is sent to port 3C9h
mov si,offset Palette
mov cx,256
mov dx,3C8h
mov al,0
; Copy starting color to port 3C8h
out dx,al
; Copy palette itself to port 3C9h 
inc dx
PalLoop:
; Note: Colors in a BMP file are saved as BGR values rather than RGB.
mov al,[si+2] ; Get red value.
shr al,2 ; Max. is 255, but video palette maximal
 ; value is 63. Therefore dividing by 4.
out dx,al ; Send it.
mov al,[si+1] ; Get green value.
shr al,2
out dx,al ; Send it.
mov al,[si] ; Get blue value
shr al,2
out dx,al ; Send it.
add si,4 ; Point to next color.
 ; (There is a null chr. after every color.)
 loop PalLoop
ret
endp CopyPal

proc CopyBitmap
; BMP graphics are saved upside-down.
; Read the graphic line by line (200 lines in VGA format),
; displaying the lines from bottom to top.
mov ax, 0A000h
mov es, ax
mov cx,200
PrintBMPLoop:
push cx 
; di = cx*320, point to the correct screen line
mov di,cx
shl cx,6
shl di,8
add di,cx
; Read one line
mov ah,3fh
mov cx,320
mov dx,offset ScrLine
int 21h
cld ; Clear direction flag, for movsb
mov cx,320
mov si,offset ScrLine 
; Copy one line into video memory
rep movsb ; Copy line to the screen
 ;rep movsb is same as the following code:
 ;mov es:di, ds:si
 ;inc si
 ;inc di
 ;dec cx
 ;loop until cx=0
pop cx
loop PrintBMPLoop
ret
endp CopyBitmap 
 


proc GetLocationM
	push bp
	mov bp,sp
	push ax
	mov ax,1	
	int 33h
	mov ax,3  
	int 33h	;  מקבל נתונים העכבר
	;in bx :if first bit is 1,left kilk is pressed
	;if secount bit is 1,right kilk is pressed
	;in cx:ציר הx you need to shr cx,1 to adjust to amount of pixeles in screen
	;in dx: ציר y leave dx as ve is 
	shr cx,1
	pop ax
	pop bp
	ret
	;
	;
	;you need to reset mouse be for the proc :mov ax,0  and then int 33h
	;
	;
endp GetLocationM

proc Exit
mov ax,3
	int 10h
	mov ax, 4c00h
	int 21h
	ret 
endp Exit

proc OpenScreen	
push bp
mov bp,sp
push ax
dosound equ [word ptr bp-2]
mov ax,13h
int 10h    ;
xor ax,ax
int 33h
jmp firstpicPS
firstpicP: 
	PrintBmpPicture picopenmain
	jmp firstpicCheckX1
firstpicPS:
	PrintBmpPicture picopenmain
	StartSound
	push 1
	call doDealy
	EndSound
firstpicCheckX1:
	call GetLocationM
	cmp cx,140
	jna firstpicCheckX2
	cmp cx,176
	jb firstpicCheckY1
	jmp firstpicCheckX1
firstpicCheckX2:
	cmp cx,6
	jb firstpicCheckX1
	cmp cx,34
	jb firstpicCheckY2
	jmp firstpicCheckX1
firstpicCheckY1:
	cmp dx,75
	jb firstpicCheckX1
	cmp dx,91
	jb secoundpicP
	cmp dx,109
	jb firstpicCheckX1
	cmp dx,124
	jb prethirdpicP
	cmp dx,141
	jb firstpicCheckX1
	cmp dx,159
	jb prefourthpicP2
	jmp firstpicCheckX1
firstpicCheckY2:
	cmp dx,9
	jb firstpicCheckX1
	cmp dx,25
	jb prefifthpicP2
	jmp firstpicCheckX1
prefourthpicP2:
jmp prefourthpicP
prefifthpicP2:
jmp prefifthpicP
prethirdpicP:
jmp thirdpicP
secoundpicP:
	PrintBmpPicture picopenplay
	jmp secoundpicCheckAll
secoundpicPS:
	PrintBmpPicture picopenplay
	StartSound
	push 1
	call doDealy
	EndSound
secoundpicCheckAll:
	call GetLocationM 
	cmp dx,75
	jb prefirstpicP
	cmp dx,95
	ja prefirstpicP
	cmp cx,140
	jb prefirstpicP
	cmp cx,174
	ja prefirstpicP
	cmp bx,01
	jne secoundpicCheckAll
	jmp retLaybleOpenScreen
prefirstpicP:
jmp firstpicP
prefifthpicP:
jmp fifthpicP
prefourthpicP:
	jmp fourthpicP
thirdpicP:
	PrintBmpPicture picopenrules
	jmp thirdpicCheckAll
thirdpicPS:
	PrintBmpPicture picopenrules
	StartSound
	push 1
	call DoDealy
	EndSound
thirdpicCheckAll:
	call GetLocationM
	cmp cx,140
	jb prefirstpicP
	cmp cx,174
	ja prefirstpicP
	cmp dx,109
	jb prefirstpicP
	cmp dx,124
	ja prefirstpicP
	cmp bx,01
	jne thirdpicCheckAll
	jmp sixthpicPS
prefirstpicP2:
jmp prefirstpicP
fourthpicP:
	PrintBmpPicture picopeninfo
	jmp fourthpicCheckAll
fourthpicPS:
	PrintBmpPicture picopeninfo
	StartSound
	push 1
	call DoDealy
	EndSound
fourthpicCheckAll:
	call GetLocationM
	cmp cx,140
	jb prefirstpicP2
	cmp cx,174
	ja prefirstpicP2
	cmp dx,141
	jb prefirstpicP2
	cmp dx,159
	ja prefirstpicP2
	cmp bx,01
	jne fourthpicCheckAll
	jmp seventhpicPS
prefirstpicP3:
	jmp prefirstpicP2
prefirstpicPS:
JMP firstpicPS	
fifthpicP:
	PrintBmpPicture picopenexit
	push 3
	call doDealy
	jmp fifthpicCheckAll
fifthpicPS:
	PrintBmpPicture picopenexit
	StartSound
	push 1
	call DoDealy
	EndSound
fifthpicCheckAll:
	call GetLocationM
	cmp cx,6
	jb prefirstpicP3
	cmp cx,33
	ja prefirstpicP3
	cmp dx,9
	jb prefirstpicP3
	cmp dx,25
	ja prefirstpicP3
	cmp bx,01
	jne fifthpicCheckAll
	call Exit
sixthpicP:
	PrintBmpPicture picrulesmain
	jmp sixthpicCheckAll
sixthpicPS:
	PrintBmpPicture picrulesmain
	StartSound
	push 1
	call DoDealy
	EndSound
sixthpicCheckAll:
	call GetLocationM
	cmp cx,14
	jb sixthpicCheckAll
	cmp cx,40
	ja sixthpicCheckAll
	cmp dx,8
	jb sixthpicCheckAll
	cmp dx,26
	ja sixthpicCheckAll
	jmp eighthpicP
presixthpicP:
	jmp sixthpicP
eighthpicP:
	PrintBmpPicture picrulesexit
eighthpicCheckAll:
	call GetLocationM
	cmp cx,14
	jb presixthpicP
	cmp cx,40
	ja presixthpicP
	cmp dx,8
	jb presixthpicP
	cmp dx,26
	ja presixthpicP
	cmp bx,01
	jne eighthpicCheckAll
	jmp prefirstpicPS
seventhpicP:
	PrintBmpPicture picinfomain
	jmp seventhpicCheckAll
seventhpicPS:
	PrintBmpPicture picinfomain
	StartSound 
	push 1
	call DoDealy
	EndSound
seventhpicCheckAll:
	call GetLocationM
	cmp cx,6
	jb seventhpicCheckAll
	cmp cx,33
	ja seventhpicCheckAll
	cmp dx,9
	jb seventhpicCheckAll
	cmp dx,25
	ja seventhpicCheckAll
	jmp ninthpicP
preseventhpicP:
	jmp seventhpicP
ninthpicP:
	PrintBmpPicture picinfoexit
ninthpicCheckAll:
	call GetLocationM
	cmp cx,6
	jb preseventhpicP
	cmp cx,33
	ja preseventhpicP
	cmp dx,9
	jb preseventhpicP
	cmp dx,25
	ja preseventhpicP
	cmp bx,01
	jne ninthpicCheckAll
	jmp prefirstpicPS
retLaybleOpenScreen:
	pop ax
	pop bp
	ret 
endp OpenScreen
	;----------------------------------------------------------------------------------------------------------------------------
	proc DoDealy
push bp 
mov bp,sp
push ax
push cx
AmountDealy equ [bp+4]
Clock equ es:6Ch
mov ax, 40h
mov es, ax
mov ax, [Clock]       ;הפרוצדורה מקבלת דרך המחסנית ערך של כמות שניות ועוצרת לכמות השניות שניתנה
FirstTick:
cmp ax, [Clock]
je FirstTick
; count 10 sec
mov cx, AmountDealy ; AmountDealyx0.055sec =? 
DelayLoop:
mov ax, [Clock]
Tick:
cmp ax, [Clock]
je Tick 
loop DelayLoop
pop cx
pop ax
pop bp
ret 2
endp DoDealy
;-------------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------
;-------------------------------------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------
macro endSound
	in al,61h
	and  al,11111100b  ;stops speaker
	out 61h,al

endm endSound

proc isInBoundariesAndP
leftX equ [word ptr bp + 4]
rightX equ [word ptr bp + 6]    
topY equ [word ptr bp + 8]    
bottomY equ [word ptr bp + 10]  

	push bp
	mov bp, sp 

check:
	;check if it's on x zone
	cmp cx, leftX
	jb notInBoundaries

	cmp cx, rightX
	ja notInBoundaries
	
	;check if it's on y zone
	cmp dx, topY
	jb notInBoundaries
	cmp dx, bottomY
	ja notInBoundaries
	jmp InBoundaries
notInBoundaries:
	mov bottomY, false
	jmp final
InBoundaries:
	cmp bx,01
	je InBoundariesAndP
	cmp bx ,10b
	je InBoundariesAndP
	mov bottomY, false
	jmp final
InBoundariesAndP:
	mov bottomY,true
final:
	pop bp
	ret 6
	
endp isInBoundariesAndP

proc CloseFile
	MOV AH,3Eh
	MOV BX, [FILEHANDLE]
	INT 21h 
	ret
endp CloseFile

	
