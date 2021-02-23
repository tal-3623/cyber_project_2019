
; בודק האם יש שחקן בשורה התחתונה ומעביר למשתנה כללי אמת או שקר
proc IPBR_Proc ;is player butoon row
push bp
mov bp,sp
StartFunction
mov cx,38
mov bx,170
lIPBR:
cmp cx,318
je IGGBR_RetLAndMoveF
push cx
push bx
call isPlayerThere
POPAXCMPTRUE
je IGGBR_RetL
add cx,35
jmp lIPBR
IGGBR_RetLAndMoveF:
mov [IPBR],false
EndFunction
pop bp
ret 
IGGBR_RetL:
mov [IPBR],true
EndFunction
pop bp
ret 
endp