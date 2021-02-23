macro UpdateDataTBRows
StartFunction
; IPTR =is player top row
; IPBR =is player boutton row
mov ax,[IPBR]
mov bx,[IPTR]
mov [IPTR_LastTurn],bx
mov [IPBR_LastTurn],ax
call IPTR_Proc
call IPBR_Proc
EndFunction
endm
;---------------------------------
;-------------------------
;הפרוצדורה בודקת האם כחול ניצח ומחזירה אמת או שקר
;{
return_DidBlueTookTheW equ [word ptr bp+4]
proc DidBlueTookTheW
push bp
mov bp,sp
StartFunction
cmp [IPTR],true
jne DidBlueTookTheW_RetL_False
cmp [IPTR_LastTurn],true
je DidBlueTookTheW_RetL_False
jmp DidBlueTookTheW_RetL_True
;{
DidBlueTookTheW_RetL_True:
mov return_DidBlueTookTheW,true
EndFunction
pop bp
ret
DidBlueTookTheW_RetL_False:
mov return_DidBlueTookTheW,false
EndFunction
pop bp
ret
;}
endp
; מקרו של הפרוצודורה
macro DidBlueTookTheWMcro
push 0
call DidBlueTookTheW
endm
;}
;-------------------------------------
;--------------------------------------
;-----------------------------------------
;הפרוצדורה בודקת האם סגול ניצח ומחזירה אמת או שקר
;{
return_DidPurpleTookTheW equ [word ptr bp+4]
proc DidPurpleTookTheW
push bp
mov bp,sp
StartFunction
cmp [IPBR],true
jne DidPurpleTookTheW_RetL_False
cmp [IPBR_LastTurn],true
je DidPurpleTookTheW_RetL_False
jmp DidPurpleTookTheW_RetL_True
;{
DidPurpleTookTheW_RetL_True:
mov return_DidPurpleTookTheW,true
EndFunction
pop bp
ret
DidPurpleTookTheW_RetL_False:
mov return_DidPurpleTookTheW,false
EndFunction
pop bp
ret
;}
endp
; מקרו של הפרוצודורה
macro DidPurpleTookTheWMcro
push 0
call DidPurpleTookTheW
endm
;}