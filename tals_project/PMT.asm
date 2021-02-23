

currentX equ [word ptr bp+10]
currentY equ [word ptr bp+8]
wantedX equ [word ptr bp+6]
wantedY equ [word ptr bp+4]
;מקבל מיפה השחקן זז ולאן ומעדכן {
proc  playerMovedThere
push bp
mov bp,sp
StartFunction
mov bx,offset dataAboutSqures
xCheckingFaze1:
mov ax,[word ptr bx]
 cmp currentX,ax
 je yChexkingFaze1
 add bx,10
 jmp xCheckingFaze1
yChexkingFaze1:
	add bx,2
	mov ax,[word ptr bx]
	cmp currentY,ax
	je EresePlayerData
	jmp PxCheckingFaze1
EresePlayerData:
	add bx,2
	mov [word ptr bx],false
	mov bx,offset dataAboutSqures
	jmp faze2
PxCheckingFaze1:
sub bx,2
add bx,10
jmp xCheckingFaze1
faze2:
xCheckingFaze2:
mov ax,[word ptr bx]
 cmp wantedX,ax
 je yChexkingFaze2
 add bx,10
 jmp xCheckingFaze2
yChexkingFaze2:
	add bx,2
	mov ax,[word ptr bx]
	cmp wantedY,ax
	je MovePlayerData
	jmp PxCheckingFaze2
MovePlayerData:
	add bx,2
	mov [word ptr bx],true
	jmp EndPplayerMovedThere
PxCheckingFaze2:
sub bx,2
add bx,10
jmp xCheckingFaze2
EndPplayerMovedThere:
EndFunction
pop bp
ret 8
endp
;}