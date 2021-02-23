
;בודק האם יש שחקן ב בשורה העליונה ומעביר למשתנה כלל אמת או שקרש
proc IPTR_Proc ;is GG top row
push bp 
mov bp,sp
StartFunction
mov cx,38
mov bx,0
lIPTR:
cmp cx,318
je IPTR_RetAndMoveF
push cx
push bx
call isPlayerThere
POPAXCMPTRUE
je IPTR_RetL
add cx,35
jmp lIPTR
IPTR_RetAndMoveF:
mov [IPTR],false
EndFunction
pop bp
ret
IPTR_RetL:
mov [IPTR],true
EndFunction
pop bp
ret 
endp