


proc ReStartAllSqure
push bp
mov bp,sp
StartFunction
RightSqure28:
add cx,35
cmp [CanMoveR],false
je LeftSqure28
cmp cx,38
jb LeftSqure28
cmp cx,283
ja LeftSqure28
ReStartSqure
LeftSqure28:
sub cx,70
cmp [CanMoveL],false
je UPSqure28
cmp cx,38
jb UPSqure28
cmp cx,283
ja UPSqure28
ReStartSqure
UPSqure28:
add cx,35
sub dx,25
cmp [CanMoveU],false
je DownSqure28
cmp dx,0
jb DownSqure28
cmp dx,170
ja DownSqure28
ReStartSqure
DownSqure28:
add dx,50
cmp [CanMoveD],false
je endpReStartAllSqure
cmp dx,0
jb endpReStartAllSqure
cmp dx,170
ja endpReStartAllSqure
ReStartSqure
endpReStartAllSqure:
EndFunction
pop bp
ret 
endp 


proc ReStartAllSqureTopRow
push bp
mov bp,sp
StartFunction
RightSqure31:
add cx,35
cmp [CanMoveR],false
je LeftSqure31
cmp cx,38
jb LeftSqure31
cmp cx,313
ja LeftSqure31
ReStartSqureHigerow
LeftSqure31:
sub cx,70
cmp [CanMoveL],false
je UPSqure31
cmp cx,38
jb UPSqure31
cmp cx,313
ja UPSqure31
ReStartSqureHigerow
UPSqure31:
add cx,35
sub dx,25
cmp [CanMoveU],false
je DownSqure31
cmp dx,0
jb DownSqure31
cmp dx,170
ja DownSqure31
DownSqure31:
add dx,45
cmp [CanMoveD],false
je endpReStartAllSqureTopRow
;cmp dx,0
;jb endpReStartAllSqureTopRow
cmp dx,170
ja endpReStartAllSqureTopRow
ReStartSqure
endpReStartAllSqureTopRow:
EndFunction
pop bp
ret 
endp 


proc ReStartAllSqureHigeRow
push bp
mov bp,sp
StartFunction
RightSqure28HigeRow:
add cx,35
cmp [CanMoveR],false
je LeftSqure28HigeRow
cmp cx,38
jb LeftSqure28HigeRow
cmp cx,283
ja LeftSqure28HigeRow
ReStartSqure
LeftSqure28HigeRow:
sub cx,70
cmp [CanMoveL],false
je UPSqure28HigeRow
cmp cx,38
jb UPSqure28HigeRow
cmp cx,283
ja UPSqure28HigeRow
ReStartSqure
UPSqure28HigeRow:
add cx,35
xor dx,dx
cmp [CanMoveU],false
je DownSqure28HigeRow
;cmp dx,0
;jb DownSqure28HigeRow
cmp dx,170
ja DownSqure28HigeRow
ReStartSqureHigerow
DownSqure28HigeRow:
add dx,45
cmp [CanMoveD],false
je endpReStartAllSqureHigeRow
cmp dx,0
jb endpReStartAllSqureHigeRow
cmp dx,170
ja endpReStartAllSqureHigeRow
ReStartSqure
endpReStartAllSqureHigeRow:
EndFunction
pop bp
ret 
endp 



;cleenSqure 