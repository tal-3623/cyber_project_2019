
xsqure equ [word ptr bp+6]
ysqure equ [word ptr bp+4]


proc  whereCanPlaceWall
push bp
mov bp,sp
StartFunction
;{
;תנאי ראשון האם אתה בצד ימין או בהכי למטה אתה לא יכול לשים חומה שם
cmpRightestSqure:
cmp xsqure,283
je mainCantPlaceHorazion
cmpLowestSqure:
	cmp ysqure,170
	je mainCantPlaceAnach
	jmp RegularWallsCheckThisSqure
mainCantPlaceHorazion:
mov [canPlaceWallhorzantcly],false
jmp cmpLowestSqure
mainCantPlaceAnach:
mov [canPlaceWallAnch],false
RegularWallsCheckThisSqure:
	mov bx,offset dataAboutSqures
xChecking1WallCheckThisSqure:
mov ax,[word ptr bx]
 cmp xsqure,ax
 je yChexking1WallCheckThisSqure
 add bx,10
 jmp xChecking1WallCheckThisSqure
yChexking1WallCheckThisSqure:
	add bx,2
	mov ax,[word ptr bx]
	cmp ysqure,ax
	je UpWallThisSqure
	jmp pxChecking1WallCheckThisSqure
pxChecking1WallCheckThisSqure:
	sub bx,2
	add bx,10
	jmp xChecking1WallCheckThisSqure
UpWallThisSqure:
	add bx,4
	mov ax,[word ptr bx]
	cmp ax,true
	je notHoarzionThisSqure
	jmp LeftWallThisSqure
notHoarzionThisSqure:
	mov [canPlaceWallhorzantcly],false
LeftWallThisSqure:
	add bx,2
	mov ax,[word ptr bx]
	cmp ax,true
	je notAnachThisSqure
	jmp RegularWallsCheckRightSqure
notAnachThisSqure:
	mov [canPlaceWallAnch],false
	;------------------------------------
RegularWallsCheckRightSqure:
	cmp [canPlaceWallhorzantcly],false
	je RegularWallsCheckDownSqure
	add xsqure,35
	mov bx,offset dataAboutSqures
xChecking1WallCheckRightSqure:
mov ax,[word ptr bx]
 cmp xsqure,ax
 je yChexking1WallCheckRightSqure
 add bx,10
 jmp xChecking1WallCheckRightSqure
yChexking1WallCheckRightSqure:
	add bx,2
	mov ax,[word ptr bx]
	cmp ysqure,ax
	je UpWallRightSqure
	jmp pxChecking1WallCheckRightSqure
pxChecking1WallCheckRightSqure:
	sub bx,2
	add bx,10
	jmp xChecking1WallCheckRightSqure
UpWallRightSqure:
	add bx,4
	mov ax,[word ptr bx]
	cmp ax,true
	je notHoarzionRightSqure
	sub xsqure,35
	jmp RegularWallsCheckDownSqure
notHoarzionRightSqure:
	mov [canPlaceWallhorzantcly],false
	sub xsqure,35
	;-------------------------------
RegularWallsCheckDownSqure:
	cmp [canPlaceWallAnch],false
	je RegularWallsCheckDownSqure1
	add ysqure,25
	mov bx,offset dataAboutSqures
xChecking1WallCheckDownSqure:
mov ax,[word ptr bx]
 cmp xsqure,ax
 je yChexking1WallCheckDownSqure
 add bx,10
 jmp xChecking1WallCheckDownSqure
yChexking1WallCheckDownSqure:
	add bx,2
	mov ax,[word ptr bx]
	cmp ysqure,ax
	je LeftWallDownSqure
	jmp pxChecking1WallCheckDownSqure
pxChecking1WallCheckDownSqure:
	sub bx,2
	add bx,10
	jmp xChecking1WallCheckDownSqure
LeftWallDownSqure:
	add bx,6
	mov ax,[word ptr bx]
	cmp ax,true
	je notAnachDownSqure
	sub ysqure,25
	jmp RegularWallsCheckDownSqure1
notAnachDownSqure:
	mov [canPlaceWallAnch],false
	sub ysqure,25
;------------------------------
;בדיקה את החומות למעלה של שני השמבצות הנמכות שאחת מהם יותר שמאלה
RegularWallsCheckDownSqure1:
	cmp [canPlaceWallAnch],false
	je PRegularWallsCheckRightSqure2
	add ysqure,25
	mov bx,offset dataAboutSqures
xChecking1WallCheckDownSqure1:
mov ax,[word ptr bx]
 cmp xsqure,ax
 je yChexking1WallCheckDownSqure1
 add bx,10
 jmp xChecking1WallCheckDownSqure1
yChexking1WallCheckDownSqure1:
	add bx,2
	mov ax,[word ptr bx]
	cmp ysqure,ax
	je LeftWallDownSqure1
	jmp pxChecking1WallCheckDownSqure1
;סתם לייבל מגשר
;{
PRegularWallsCheckRightSqure2:
jmp RegularWallsCheckRightSqure2
;}
pxChecking1WallCheckDownSqure1:
	sub bx,2
	add bx,10
	jmp xChecking1WallCheckDownSqure1
LeftWallDownSqure1:
	add bx,4
	mov ax,[word ptr bx]
	sub ysqure,25
	cmp ax,true
	je RegularWallsCheckDownSqure1Left
	jmp RegularWallsCheckRightSqure2 
RegularWallsCheckDownSqure1Left:
	add ysqure,25
	sub xsqure,35
	mov bx,offset dataAboutSqures
xChecking1WallCheckDownSqure1Left:
mov ax,[word ptr bx]
 cmp xsqure,ax
 je yChexking1WallCheckDownSqure1Left
 add bx,10
 jmp xChecking1WallCheckDownSqure1Left
yChexking1WallCheckDownSqure1Left:
	add bx,2
	mov ax,[word ptr bx]
	cmp ysqure,ax
	je LeftWallDownSqure1Left
	jmp pxChecking1WallCheckDownSqure1Left
pxChecking1WallCheckDownSqure1Left:
	sub bx,2
	add bx,10
	jmp xChecking1WallCheckDownSqure1Left
LeftWallDownSqure1Left:
	add bx,4
	mov ax,[word ptr bx]
	sub ysqure,25
	add xsqure,35
	cmp ax,true
	je notAnachDownSqureLeft
	sub ysqure,25
	add xsqure,35
	jmp RegularWallsCheckRightSqure2
notAnachDownSqureLeft:
	mov [canPlaceWallAnch],false
;-------------------------------
;------------------------
RegularWallsCheckRightSqure2:
	cmp [canPlaceWallhorzantcly],false
	je Pfinala
	add xsqure,35
	mov bx,offset dataAboutSqures
xChecking1WallCheckRightSqure2:
mov ax,[word ptr bx]
 cmp xsqure,ax
 je yChexking1WallCheckRightSqure2
 add bx,10
 jmp xChecking1WallCheckRightSqure2
yChexking1WallCheckRightSqure2:
	add bx,2
	mov ax,[word ptr bx]
	cmp ysqure,ax
	je UpWallRightSqure2
	jmp pxChecking1WallCheckRightSqure2
pxChecking1WallCheckRightSqure2:
	sub bx,2
	add bx,10
	jmp xChecking1WallCheckRightSqure2
UpWallRightSqure2:
	add bx,6
	mov ax,[word ptr bx]
	sub xsqure,35
	cmp ax,true
	je RegularWallsCheckRightSqure2Up
	sub xsqure,35
	jmp finala
RegularWallsCheckRightSqure2Up:
	add xsqure,35
	sub ysqure,25
	cmp ysqure,0fffbh
	je Intiysqure
	jmp NotIntiysqure
Intiysqure:
	mov ysqure,0
	jmp NotIntiysqure
Pfinala:
	jmp finala
NotIntiysqure:
mov bx,offset dataAboutSqures
xChecking1WallCheckRightSqure2Up:
mov ax,[word ptr bx]
 cmp xsqure,ax
 je yChexking1WallCheckRightSqure2Up
 add bx,10
 jmp xChecking1WallCheckRightSqure2Up
yChexking1WallCheckRightSqure2Up:
	add bx,2
	mov ax,[word ptr bx]
	cmp ysqure,ax
	je UpWallRightSqure2Up
	jmp pxChecking1WallCheckRightSqure2Up
pxChecking1WallCheckRightSqure2Up:
	sub bx,2
	add bx,10
	jmp xChecking1WallCheckRightSqure2Up
UpWallRightSqure2Up:
	add bx,6
	mov ax,[word ptr bx]
	sub xsqure,35
	cmp ax,true
	je NotcanPlaceWallhorzantclyUp
	sub xsqure,35
	jmp finala
NotcanPlaceWallhorzantclyUp:
	mov [canPlaceWallhorzantcly],false
	
	

finala:
;}
EndFunction
pop bp
ret 4
endp


