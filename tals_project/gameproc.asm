proc startGame
push bp
mov bp,sp
AllNeesedPushES ;מבצע לכול משתנה פניני פוש
AllEqus ;עושה את האיקיויום
;מעביר לתור כחול כי הוא מתחיל{
mov dx,offset playerPrintNum1RegularSqure
mov [PPTTRS],dx
mov dx,offset playerPrintNum1HigeRow
mov [PPTTHR],dx
;}

 PrintBmpPicture picpanelgame ;מדפיס את המשחק
 
;מדפיס את שני השחקנים{
	StartGamePlayerP
	StartGamePlayerP2
;}
	
;תתבצע בדיקה האם העכבר נלחץ באזור של המשחק
;אם לא תתבצע בדיקה האם לחץ על יציאה 
	checkingForspeialLOcation:
	resetVars ;מאפס משתנים מתור לתור
	
;מקבל קלט לעכבר ושם אותו במשתנים {
call GetLocationM
mov xP,cx
mov yp,dx
sub xP,38
;}

;בדוק האם ביקום של המשחק חוץ {
isInBoundariesAndP_GameBoard
pop ax
cmp ax,true
je gameL1
;}

;בודק האם לחץ על יציאה {
isInBoundariesAndP_GameExit
pop isExitP
cmp isExitP,true
je exitL
jmp checkingForspeialLOcation
;}

;תוית חזרה למסך הראשי{
exitL:
AllNeesedPops ; מבצעת את כול הפופים למשתנים הפנינים
	ret		
;}

gameL1:
	
;בודק האם לחץ על הורה אחת פלני הכי גבוהה{
	isInBoundariesAndP_BeforeTopRow
	pop ax 
	cmp ax,true
	je HigeRowP
;}

;בודק האם לחץ על השורה הכי גבוהה {
isInBoundariesAndP_TopRow
pop ax
cmp ax,true
je PreTopRow
jmp PreJumpRgular
PreTopRow:
	jmp TopRow
;}

;לייבל מגשר {
PreJumpRgular:
	jmp Rgular
;}
	
;מחשב את הנקודה שמאל למעלה של הרוביה הנלחצה ובודק האם לחץ במטרה להזיז שחקן או לשים חומה{
HigeRowP:
	cmp bx,2
	je PreJumpRgular
	TopLeftCornerXY
	cmp bx,01
	je playerPHigeRow
	jmp wallP
;}
		
playerPHigeRow:
;בודק האם יש שחקן איפה שנלחץ אם כן תלך לטפל בזה אם לא תתעלם ולך לקבל נתונים חדשים לתחילת התור{
	push xP
	push yp
	call isPlayerThere
	pop ax 
	cmp ax,true
	je checkForMoveOptionsHigeRow
	jmp checkingForspeialLOcation
;}
	
	
checkForMoveOptionsHigeRow:
;מעדכן משתנים לגביי אפשקויות התנועה {
	push xP
	push yp
	call whereCanMove
;}
	
;בודק האם יכול לזוז ל__ אז תדפיס ריבוע אפור שמה {	
checkRHigeRow:
	cmp [CanMoveR],true
	je RightSqureHigeRow
checkLHigeRow:
	cmp [CanMoveL],true
	je LeftSqureHigeRow
checkUHigeRow:
	cmp [CanMoveU],true
	je UpSqureHigeRow
checkDHigeRow:
	cmp [CanMoveD],true
	je DownSqureHigeRow
	jmp LookingForSecoundPressHigeRow
;}
	
;מדפיס את האפשריות תנועה  [ריבועים אפורים]{
	RightSqureHigeRow:
	mov ax, xP
	add ax,35
	mov RightX,ax
	mov ax,yp
	mov RightY,ax
	push RightX
	push RightY
	push offset FakeplayerPrintNumRegularSqure
	call PrintPieceProcRegularSqure
	jmp checkLHigeRow
LeftSqureHigeRow:
	mov ax,xP
	sub ax,35
	mov LeftX,ax
	mov ax,yp
	mov LeftY,ax
	push LeftX
	push LeftY
	push offset FakeplayerPrintNumRegularSqure
	call PrintPieceProcRegularSqure
	jmp checkUHigeRow
UpSqureHigeRow:
	mov ax,yp
	sub ax,20
	mov UpY,ax
	mov ax,xP
	mov UpX,ax
	push UpX
	push UpY
	push offset fake1HigeRow
	call PrintPieceProcHigeRow
	jmp checkDHigeRow\
	
;לייבל מגשר {	
PPPcheckingForspeialLOcation:
	jmp checkingForspeialLOcation
;}

DownSqureHigeRow:
	mov ax,yp
	add ax,25
	mov DownY,ax
	mov ax,xP
	mov DownX,ax
	push DownX
	push DownY
	push offset FakeplayerPrintNumRegularSqure
	call PrintPieceProcRegularSqure
;}
	
LookingForSecoundPressHigeRow:
;לשמור על ערך {
	push xP
	push yp
;}
untilPHigeRow:
	;לתת זמן הסדל מהלחיצה הראשונה לשניה{
	push 1
	call DoDealy
;}
	call GetLocationM ; רבלת נתונים על העכבר
	;אם לא לחץ תקבל נתונים חדשים על העכבר {
	cmp bx,01
	jne untilPHigeRow
	;}
;האם  לחץ על ריטריי{
	push 200
	push 160
	push 38
	push 0
	call isInBoundariesAndP
;}
	pop ax
	cmp ax,true
	je PPPcheckingForspeialLOcation
;
;משנה ושם את הנתונים ללמלעה צד שמאל של הקוביה{
	mov xP,cx
	mov yp,dx
	pop dx
	pop cx
	sub xP,38
	TopLeftCornerXY
	cmp yp,0fffbh ;למקרה שלחץ לזוז לשורה העליונה 
	je add10
	jmp notadd10
add10:
	mov yp,0
notadd10:
;}

;בודק האם יכול לזוז ל__ ואם יכול תבדוק האם עשה אם לא יכול לזוז בכלל תחזור כאילו לא לחץ על השחקן בכלל{
GoTODidPressOnleftHigeRow:
	cmp [CanMoveL],true
	je DidPressOnleftHigeRow
GoTODidPressOnUPHigeRow:
	cmp [CanMoveU],true
	je DidPressOnUPHigeRow
GoTODidPressOnRightHigeRow:
	cmp [CanMoveR],true
	je DidPressOnRightHigeRow
GoTODidPressOnDownHigeRow:
	cmp [CanMoveD],true
	je DidPressOnDownHigeRow
	jmp checkingForspeialLOcation
;}
;בודק האם לחץ על__ והולך לפי איפה שלחץ לטפל בתזוזה {
DidPressOnleftHigeRow:
	mov ax,cx
	sub ax,35
	cmp ax,xP
	jne GoTODidPressOnUPHigeRow
	cmp dx,yp
	jne GoTODidPressOnUPHigeRow
	jmp MoveGoodHigeRow
DidPressOnUPHigeRow:
	mov ax,dx
	sub ax,20 
	cmp ax,yp
	jne GoTODidPressOnRightHigeRow
	cmp cx,xP
	jne GoTODidPressOnRightHigeRow
	jmp MoveGoodUp
DidPressOnRightHigeRow:
	mov ax,cx
	add ax,35
	cmp ax,xP
	jne GoTODidPressOnDownHigeRow
	cmp dx,yp
	jne GoTODidPressOnDownHigeRow
	jmp MoveGoodHigeRow
DidPressOnDownHigeRow:
	mov ax,dx
	add ax,25
	cmp ax,yp
	jne PPPPcheckingForspeialLOcation
	cmp cx,xP
	jne PPPPcheckingForspeialLOcation
	jmp MoveGoodHigeRow
;}

	
;זלייבל מגשר לא קשור{
PPPPcheckingForspeialLOcation:
jmp PPcheckingForspeialLOcation
;}


;מבצע את התזוזה לכול המשבצות חוץ מהשורה העליונה {
MoveGoodHigeRow:
;מחוק את השחקן הריבועים האפורים {	
	ReStartSqure ; ףעל עצמו
	call ReStartAllSqureHigeRow ;מסביב
;}
	
;מדפיס את השחקן במיקום החדש שלו {
	push xP
	push yp
	push  [PPTTRS]
	call PrintPieceProcRegularSqure
;}

;מעדכן משתנים: מאתחל את המיקום הישן של השחקן ומדליק את המיקום החדש שלו {
	push cx
	push dx
	push xP
	push yp
	call playerMovedThere
;}
	jmp ChangeTurn
;}


;מבצע את התזוזה לשורה העילונה {
MoveGoodUp:
;מחוק את השחקן הריבועים האפורים {	
	ReStartSqure ; ףעל עצמו
	call ReStartAllSqure ;מסביב
;}

;מדפיס את השחקן לפי המיקום החדש שלו  {
	push xP
	push yp
	push  [PPTTHR]
	call PrintPieceProcHigeRow
;}

;מעדכן משתני: מאפס את המיקום הישן של החדש ומדליק את המיקום החדש של השחקן{
	push cx
	push dx
	push xP
	push yp
	call playerMovedThere
	jmp ChangeTurn
;}
;}
	;-----------------------------------
	;-----------------------------------
	;-----------------------------------
TopRow:
	; מחשב את ה איקס והוואי של הנקודה למעלה שמאל של הקוביה הנלחצה ובודק האם נחלץ למטרה של הזזת שחקן או האם נחלץ למטרה של לשים חומה {
	TopLeftCornerXYHR
	cmp bx,01
	je playerPTopRow
	jmp wallPTopRow
	wallPTopRow:
	jmp checkingForspeialLOcation
	;}
playerPTopRow:
	;שואל האם נמצא שחקן איפה שלחץ אם כן תבדוק אפשרויות לתזוזה אם לא תחזור לקבל קלט חדש לגבי העכבר {
	push xP
	push yp
	call isPlayerThere
	;}
	pop ax 
	cmp ax,true
	je checkForMoveOptionsTopRow
	jmp checkingForspeialLOcation
checkForMoveOptionsTopRow:
	;מעדכן משתנים לגבי לאין יכול לזוז{
	push xP
	push yp
	call whereCanMoveHigeRow
	;}
	;בודק האם יכול לזוז ל__ ומדפיס שמה ריבוע אפור{
	checkRTopRow:
	cmp [CanMoveR],true
	je RightSqureTopRow
checkLTopRow:
	cmp [CanMoveL],true
	je LeftSqureTopRow
checkUTopRow:
	cmp [CanMoveU],true
	je UpSqureTopRow
checkDTopRow:
	cmp [CanMoveD],true
	je DownSqureTopRow
	jmp LookingForSecoundPressTopRow
	;}
	; מטפל בתצוגת האפשרוית תנועה של השחקן [הריבועים האפורים {
	RightSqureTopRow:
	mov ax, xP
	add ax,35
	mov RightX,ax
	mov ax,yp
	mov RightY,ax
	push RightX
	push RightY
	push offset fake1HigeRow
	call PrintPieceProcHigeRow
	
	jmp checkLTopRow
LeftSqureTopRow:
	mov ax,xP
	sub ax,35
	mov LeftX,ax
	mov ax,yp
	mov LeftY,ax
	push LeftX
	push LeftY
	push offset fake1HigeRow
	call PrintPieceProcHigeRow
	jmp checkUTopRow

UpSqureTopRow:
	mov ax,yp
	sub ax,20
	mov UpY,ax
	mov ax,xP
	mov UpX,ax
	push UpX
	push UpY
	push offset fake1HigeRow
	call PrintPieceProcHigeRow
	jmp checkDTopRow
	
	;לייבל מקשר לא קשור{
PrePcheckingForspeialLOcation:
	jmp PcheckingForspeialLOcation
	;}
DownSqureTopRow:
	mov ax,yp
	add ax,20
	mov DownY,ax
	mov ax,xP
	mov DownX,ax
	push DownX
	push DownY
	push offset FakeplayerPrintNumRegularSqure
	call PrintPieceProcRegularSqure
	;}
	
	
LookingForSecoundPressTopRow:
	push xP ;כדאי לשמור על ערך
	push yp ;כדאי לשמור על ערך
;רבלת מיקןם לחיצה שני אחרי לחיצה על שחקן {
untilPTopRow:
	push 1
	call DoDealy
	call GetLocationM
	cmp bx,01
	jne untilPTopRow
	push 200
	push 160
	push 38 ;reTRY |NF =not functionl
	push 0
	call isInBoundariesAndP
	pop ax
	cmp ax,true
	je PrePcheckingForspeialLOcation
;}
;משנה ושם את הנתונים ללמלעה צד שמאל של הקוביה {
	mov xP,cx
	mov yp,dx
	pop dx
	pop cx
	sub xP,38
	TopLeftCornerXY
	cmp yp,0fffbh ;אם לחצתה על הקוביה העילונה אז תעביר לוואי 0
	je movyp0
	jmp notmovyp0
movyp0:
	mov yp,0
notmovyp0:
;}
;הסבר: אם אתה יכול לזוז לאינשהו והשחקן לחץ למקום הזה תקפוץ לליבל של ביצוע ההעברה 
;גם נתונים גם אתחול משבצת לפני התוזה וגם הדפסת שחקן במישום חדש
GoTODidPressOnleftTopRow:
	cmp [CanMoveL],true
	je DidPressOnleftTopRow
GoTODidPressOnUPTopRow:
	cmp [CanMoveU],true
	je DidPressOnUPTopRow
GoTODidPressOnRightTopRow:
	cmp [CanMoveR],true
	je DidPressOnRightTopRow
GoTODidPressOnDownTopRow:
	cmp [CanMoveD],true
	je DidPressOnDownTopRow
	jmp checkingForspeialLOcation
	
;אם לחץ על __ אז תלך לליבל של העברת שחקן בשורה העליונה כלומר לק כולל תזוזה למטה {
	DidPressOnleftTopRow:
	mov ax,cx
	sub ax,35
	cmp ax,xP
	jne GoTODidPressOnUPTopRow
	cmp dx,yp
	jne GoTODidPressOnUPTopRow
	jmp MoveGoodTopRow
PPcheckingForspeialLOcation:
	call ReStartAllSqure
	jmp PcheckingForspeialLOcation
DidPressOnUPTopRow:
	mov ax,dx
	sub ax,25 
	cmp ax,yp
	jne GoTODidPressOnRightTopRow
	cmp cx,xP
	jne GoTODidPressOnRightTopRow
	jmp MoveGoodTopRow
DidPressOnRightTopRow:
	mov ax,cx
	add ax,35
	cmp ax,xP
	jne GoTODidPressOnDownTopRow
	cmp dx,yp
	jne GoTODidPressOnDownTopRow
	jmp MoveGoodTopRow
	;}
	
DidPressOnDownTopRow:
	;אם לחץ על למטה תלך לליבל של לחץ למטה אם לא אז לא לחץ על כלום תחזור להתחלה הצור{
	mov ax,dx
	add ax,20
	cmp ax,yp
	jne PPcheckingForspeialLOcation
	cmp cx,xP
	jne PPcheckingForspeialLOcation
	jmp MoveGood321
	;}
MoveGood321:
	;ניקוי שחקני דמוי ואת השחן עצמו{
	ReStartSqureHigerow ; ףעל עצמו
	call ReStartAllSqureTopRow ;מסביב
	;}
	;הדפסת השחקן{
	push xP
	push yp
	push  [PPTTRS]
	call PrintPieceProcRegularSqure ;הדפסת השחקן
	;}
	;העברת נתונים{
	push cx
	push dx
	push xP
	push yp
	call playerMovedThere
	;}
	jmp ChangeTurn
MoveGoodTopRow:
	ReStartSqureHigerow ;יל עצמו
	call ReStartAllSqureTopRow ;מסביב לו
	;ףהדפסת השחקן{
	push xP
	push yp
	push  [PPTTHR]
	call PrintPieceProcHigeRow
	;}
	;העברת נתונים {
	push cx
	push dx
	push xP
	push yp
	call playerMovedThere
	;}
	jmp ChangeTurn

	;-----------------
	;-----------------------------
	;--------------------------
	
	Rgular:
	;יחישוב נקודת שמאל למעלה של הקוביה הנלחצה וחילוק ללחיצה למטרת הזזת שחקן למטרת השמה של חומה{
	TopLeftCornerXY
	cmp bx,01
	je playerP
	jmp wallP
;}


playerP: ;
	
;שןאל האם נצא שחקן איפה שלחץ אם כן לך לבדוק את אשרויות תנועה שלו אם לא תחזור לקבל מידע חדש על העכבר כאילו לא לחץ {
	push xP
	push yp
	call isPlayerThere
	pop ax 
	cmp ax,true
	je checkForMoveOptions
	jmp checkingForspeialLOcation
;}

;מעדכן משתנים לגבי האפשוריות של התנועה שלו {
checkForMoveOptions:
	push xP
	push yp
	call whereCanMove
;}

;בודק אם יכול לזוז ל__ אז תדפיס שם ריבוע אפור {
checkR:
	cmp [CanMoveR],true
	je RightSqure
checkL:
	cmp [CanMoveL],true
	je LeftSqure
checkU:
	cmp [CanMoveU],true
	je UpSqure
checkD:
	cmp [CanMoveD],true
	je DownSqure
	jmp LookingForSecoundPress
;}

;מבצע את ההדפסות של האפשרויות תנועה של השחקן : ריבועים אפורים{
RightSqure:
	mov ax, xP
	add ax,35
	mov RightX,ax
	mov ax,yp
	mov RightY,ax
	push RightX
	push RightY
	push offset FakeplayerPrintNumRegularSqure
	call PrintPieceProcRegularSqure
	
	jmp checkL
LeftSqure:
	mov ax,xP
	sub ax,35
	mov LeftX,ax
	mov ax,yp
	mov LeftY,ax
	push LeftX
	push LeftY
	push offset FakeplayerPrintNumRegularSqure
	call PrintPieceProcRegularSqure
	jmp checkU
UpSqure:
	mov ax,yp
	sub ax,25
	mov UpY,ax
	mov ax,xP
	mov UpX,ax
	push UpX
	push UpY
	push offset FakeplayerPrintNumRegularSqure
	call PrintPieceProcRegularSqure
	jmp checkD
;זה סתם לייבל מגשר לא קשור {
PcheckingForspeialLOcation:
	jmp checkingForspeialLOcation
;}
DownSqure:
	mov ax,yp
	add ax,25
	mov DownY,ax
	mov ax,xP
	mov DownX,ax
	push DownX
	push DownY
	push offset FakeplayerPrintNumRegularSqure
	call PrintPieceProcRegularSqure
;}
	
	
LookingForSecoundPress:
;משנה את הערך שהקוביה שנחצה  ולדיאיקס וסיאיקס כדאי לפנות מקום במשתני איקספי ווואיפי
;כדאי לשמור ערך משום םהערכים של איקס ווואי מועבריםפ לדי איקב וסיאיקס והערכים הידשים ל איקספי ווואיפי {
	push xP
	push yp
;}
untilP:
;{
	push 1
	call DoDealy
;}

;מקבל נתונים חדשים על העכבר אם לא לחץ תחזור לקבל נתונים חדשים על העכבר {
	call GetLocationM
	cmp bx,01
	jne untilP
;}
	
;האם  לחץ על ריטריי{
	isInBoundariesAndP_ReTry
	pop ax
	cmp ax,true
	je PcheckingForspeialLOcation
;}

;משנה ושם את הנתונים ללמלעה צד שמאל של הקוביה {
	mov xP,cx
	mov yp,dx
	pop dx
	pop cx
	sub xP,38
	TopLeftCornerXY
;}

;הסבר: אם אתה יכול לזוז לאינשהו והשחקן לחץ למקום הזה תקפוץ לליבל של ביצוע ההעברה 
;גם נתונים גם אתחול משבצת לפני התוזה וגם הדפסת שחקן במישום חדש
; בודק אם יכול לזוז ל__ אז לך תבדוק אם לחץ שמה{
GoTODidPressOnleft:
	cmp [CanMoveL],true
	je DidPressOnleft
GoTODidPressOnUP:
	cmp [CanMoveU],true
	je DidPressOnUP
GoTODidPressOnRight:
	cmp [CanMoveR],true
	je DidPressOnRight
GoTODidPressOnDown:
	cmp [CanMoveD],true
	je DidPressOnDown
	jmp checkingForspeialLOcation
;}

;  בודק איפה לחץ מועביר לליבל של הביצוע התנועה{
DidPressOnleft:
	mov ax,cx
	sub ax,35
	cmp ax,xP
	jne GoTODidPressOnUP
	cmp dx,yp
	jne GoTODidPressOnUP
	jmp MoveGood
	
;לייבל מגשר {
PPcheckingForspeialLOcation98:
	call ReStartAllSqure
	jmp PcheckingForspeialLOcation
;}

DidPressOnUP:
	mov ax,dx
	sub ax,25 
	cmp ax,yp
	jne GoTODidPressOnRight
	cmp cx,xP
	jne GoTODidPressOnRight
	jmp MoveGood
DidPressOnRight:
	mov ax,cx
	add ax,35
	cmp ax,xP
	jne GoTODidPressOnDown
	cmp dx,yp
	jne GoTODidPressOnDown
	jmp MoveGood
DidPressOnDown:
	mov ax,dx
	add ax,25
	cmp ax,yp
	jne PPcheckingForspeialLOcation98
	cmp cx,xP
	jne PPcheckingForspeialLOcation98
	jmp MoveGood
;}

;ביצוע כול התזוזות{
MoveGood:
	
; מוחק את השחקן ואת הריבועים האפורים{
	ReStartSqure ; ףעל עצמו
	call ReStartAllSqure ;מסביב
;}

;מדפיס את השחקן במיקום החדש{
	push xP
	push yp
	push  [PPTTRS]
	call PrintPieceProcRegularSqure
;}

;מעדכן נתונים:מאפס את המיקום הישן של השחקן ומדליק את הישן{
	push cx
	push dx
	push xP
	push yp
	call playerMovedThere
	jmp ChangeTurn
;}
;}

; לייבל של מגיעים אליו אחקי כול תור {
ChangeTurn:

UpdateDataTBRows;מעדכן משתנים שמשמשים לקביעת ניצחון

;בודק מי עכשיו ביצע את התור ומחליף{
mov dx,[PPTTRS]
cmp dx,offset playerPrintNum1RegularSqure
je ChangeToPurple
jmp ChangeToBlue
;}

ChangeToPurple:
;בודק האם בתור של הכחול ניצח{
	DidBlueTookTheWMcro
	POPAXCMPTRUE
	je BlueWon
;}

;מעביר את ההדפסה לסגול{
	mov dx,offset playerPrintNum2RegularSqure
	mov [PPTTRS],dx
	mov dx,offset playerPrintNum2HigeRow
	mov [PPTTHR],dx
	jmp CT
;}


ChangeToBlue:
;בודק האם סגול ניצח{
	DidPurpleTookTheWMcro
	POPAXCMPTRUE
	je PrePurpleWon
;}

;מעביר את ההדפסה לכחול{
	mov dx,offset playerPrintNum1RegularSqure
mov [PPTTRS],dx
mov dx,offset playerPrintNum1HigeRow
mov [PPTTHR],dx
;}

;עושה הבדל זמן קצר מתור לתור והולך לביצוע תור{
CT:
push 5
call DoDealy
jmp checkingForspeialLOcation
;}

;לייבל מגשר
JumpTocheckingForspeialLOcationWithOutCT:
	jmp checkingForspeialLOcation
;}

;לייבל מגשר{
PrePurpleWon:
jmp PurpleWon
;}

;ביצוע של מסך ניצחון למשך זמן קצר וללכת לתווית החזרה {
BlueWon:
;ScreenBlueWon
PrintBmpPicture picopenrules
push 20
call DoDealy
jmp exitL
PurpleWon:
;ScreenPurpleWon
PrintBmpPicture picinfoexit
push 20
call DoDealy
jmp exitL
;}
;-----------------------
;--------------------

wallP:
	
	
;בודק תור של מי ואז לפי זה מייןאת הבדיקת חומות{
	push dx ;
	mov dx,[PPTTRS]
	cmp dx,offset playerPrintNum1RegularSqure
	pop dx ;
	je CheckAmountOfWallsB
jmp CheckAmountOfWallsP
;}

;בודק האם לשחקן יש חומות לשים {
CheckAmountOfWallsB:
	cmp [amountOfwallsP1],0
	je JumpTocheckingForspeialLOcationWithOutCT
	jmp FineAmountOfWalls
CheckAmountOfWallsP:
	cmp [amountOfwallsP2],0
	je JumpTocheckingForspeialLOcationWithOutCT
	jmp FineAmountOfWalls
;}
;מגיע לליבל הזה רק אם יש לו כמות מספיקה של חומת {
FineAmountOfWalls:
	
;מעדכן משתנים לגביי איפה יכול לשים חומה {
	push xP
	push yp
	call whereCanPlaceWall
;}
	
;אם יכול לשים חומה אנכית תעבור לליבל של טיפול במצב זה {
	cmp [canPlaceWallAnch],true
	je wallAnach
;}

;}
	
;בודק אם יכול לשים חומה אופרית ועובר לליבל של טיפול במצב זה {
checkWallHorazion:
	cmp [canPlaceWallhorzantcly],true
	je PrewallHorazion
	jmp PcheckingForspeialLOcation
;}
	
	
;לייבלים מגשרים{	
PrewallHorazion:
	jmp ChangeToWallHorazion
PcheckingForspeialLOcationMidele:
	jmp PcheckingForspeialLOcation
;}
	
;החומה האנכית מורכבת מומה בצד שמאל של הקוביה הנלחצה וחומה בצד שמאל של הקוביה למטה
wallAnach:
	
	;{ כדאי לשמור את הערך של וואי פי משום אני עהושה לו שינו קטן רק בשביל ההדפסה
	push yp
	;}
	
	;אחראי על ההדפסה של צד שמאל של הקוביה שנלחצה {
	add yp,1
	push xP
	push yp
	push offset fakewallsPMAnachRegularSqure
	call PrintPieceProcRegularSqure
	pop yp
	;}
	

	;אחראי על ההדפסה של צד שמאל של הקוביה למטה{
	;עוד 27 ולא 25 משום שככה הסטייה של הגרפיקה יורדת
	push yp;כדאי לשמור את הערך של וואי פי משום אני עהושה לו שינו קטן רק בשביל ההדפסה
	add yp,26
	push xP
	push yp
	push offset fakewallsPMAnachRegularSqure
	call PrintPieceProcRegularSqure
	pop yp;כדאי לשמור את הערך של וואי פי משום אני עהושה לו שינו קטן רק בשביל ההדפסה
	;}
	
;יוצר הדבל של זמן מיבן קלט של הכבר לקלט הבא{
	push 4
	call DoDealy
;}

getsMData:
	call GetLocationM
	;בודק האם לחצתה על הקוביה שלחצתה מקודם לא משנה באיזה קליק{
	mov ax,yp
	add ax,25
	push ax
	push yp
	mov ax,xP
	add ax,35
	push ax
	push xP
	call isInBoundariesAndP
	pop ax
	cmp ax, true
	jne getsMData
	cmp bx,2;לחצן ימני
	je ChangeToWallHorazion
	jmp goodwallAnach
	;}
	
;לייבל מגשר{
MlybeleChangeToWallAnach:
jmp ChangeToWallAnach
;}

;מחיליף למצב של חומה אופקית אם יכול {
ChangeToWallHorazion:
	cmp [canPlaceWallhorzantcly],true
	jne MlybeleChangeToWallAnach
;}
	
	;אחראי על ההדפסה של צד שמאל של הקוביה שנלחצה {
	cmp [canPlaceWallAnch],false
	je PrintFakeWall
resetSqure1:
	push yp
	push xP
	add yp,1
	push yp
	push offset cleenwallsPMAnachRegularSqure
	call PrintPieceProcRegularSqure
	pop yp
	;}
	;אחראי על ההדפסה של צד שמאל של הקוביה למטה{
	;עוד 27 ולא 25 משום שככה הסטייה של הגרפיקה יורדת
	push yp;כדאי לשמור את הערך של וואי פי משום אני עהושה לו שינו קטן רק בשביל ההדפסה
	add yp,26
	push xP
	push yp
	push offset cleenwallsPMAnachRegularSqure
	call PrintPieceProcRegularSqure
	pop yp;כדאי לשמור את הערך של וואי פי משום אני עהושה לו שינו קטן רק בשביל ההדפסה
;}
PrintFakeWall:
	
	;לבטל הדפסה של החומה השמאלית 

;להדפיס את החומה המאוזנת המזוייפת{
;הדפסה של החומה למעלה של הקוביה הנלחצה{
push xP
push yp
push offset fakewallsPMveticalRegularSqure
call PrintPieceProcRegularSqure
;}

;הדפסה של חומה למעלה של הקוביה מצד ימן לקוביה הנלחצה{
push xP
add xP,35
push xP
push yp
push offset fakewallsPMveticalRegularSqure
call PrintPieceProcRegularSqure
pop xP
push 3
call DoDealy
jmp WallHorazion
;}
;}	
WallHorazion:

;
getsMouseData:
	call GetLocationM ;מקבל נתונים חדשים לגביי העכבר
;בודק האם לחצתה באותה הקוביה שלחצתה לפני אם לא תחזור לקבל קלט של העכבר עד שתלחץ עליה{
	mov ax,yp
	add ax,25
	push ax
	push yp
	mov ax,xP
	add ax,35
	push ax
	push xP
	call isInBoundariesAndP
	pop ax
	cmp ax, true
	jne getsMouseData
;}

;אם לחצתה על קליק ימני תעבור למצב שלחומה אנכית אם לא תאשר את החומה האופקית{
	cmp bx,2;לחצן ימני
	je ChangeToWallAnach
	jmp goodwallHorazion
;}
	
;{
MlybelejneChangeToWallHorazion:
jmp ChangeToWallHorazion
;}

ChangeToWallAnach:
;מבטל את החומה למעלה של הקוביה שנלחצה{
cmp [canPlaceWallAnch],true
jne MlybelejneChangeToWallHorazion
resetSqure2:
cmp [canPlaceWallhorzantcly],false
je PrintFakeWall2
push xP
push yp
push offset cleenwallsPMveticalRegularSqure
call PrintPieceProcRegularSqure
;}

;מבטל את החומה שלמעלה בצד ימין של הקוביה הנחצה{
push xP
add xP,35
push xP
push yp
push offset cleenwallsPMveticalRegularSqure
call PrintPieceProcRegularSqure
pop xP
;}

PrintFakeWall2:
;הדפסה של חומה בצד שמאל של הקוביה שנלחצה{
	push yp
	push xP
	add yp,1
	push yp
	push offset fakewallsPMAnachRegularSqure
	call PrintPieceProcRegularSqure
	pop yp
;}

;הדפסה של החומה בצד שמאל של הקוביה מתחת לזאת שנחלחצה{
push yp;כדאי לשמור את הערך של וואי פי משום אני עהושה לו שינו קטן רק בשביל ההדפסה
	add yp,26
	push xP
	push yp
	push offset fakewallsPMAnachRegularSqure
	call PrintPieceProcRegularSqure
	pop yp;כדאי לשמור את הערך של וואי פי משום אני עהושה לו שינו קטן רק בשביל ההדפסה
;}


push 3
call DoDealy
jmp getsMData


goodwallAnach:
;הדפסה של החומה האמיתית{
;הדפסה של החומה בצד שמאל של הקוביה הנלחצה{
push yp
push xP
add yp,1
push yp
push offset wallsPMAnachRegularSqure
call PrintPieceProcRegularSqure
pop yp
;}

;הדפסה של החומה בצד שמאל של הקוביה מתחת[{
push yp ;לשמור ערך
push xP
add yp,26
push yp
push offset wallsPMAnachRegularSqure
call PrintPieceProcRegularSqure
pop yp;לשמור ערך
;}

;להעביר נתונים לגבי החומה שנבנתה{
push xP
push yp
call PlaceWallAnach
mov dx,[PPTTRS]
cmp dx,offset playerPrintNum1RegularSqure
je subToBlue

sub [amountOfwallsP2],1
jmp Pre_ChangeTurn
subToBlue:
	sub [amountOfwallsP1],1
Pre_ChangeTurn:
jmp ChangeTurn
;}
;}	
goodwallHorazion:
	;הדפסה של החומה האמיתית{
;הדפסה של החומה למעלה של הקוביה שנלחצה{
push xP
push yp
push offset wallsPMveticalRegularSqure
call PrintPieceProcRegularSqure
;}

;הדפסה של החומה למעלה של הקוביה בצד ימין{
push xP ;לשמור ערך
add xp,35
push xP
push yp
push offset wallsPMveticalRegularSqure
call PrintPieceProcRegularSqure
pop xP;לשמור ערך
;}

;להעביר נתונים לגבי החומה שנבנתה{
push xP 
push yp
call PlaceWallHorazion
;}

;בושק של מי התור הזה ולפי זה מוריד לו חומה {
mov dx,[PPTTRS]
cmp dx,offset playerPrintNum1RegularSqure
je subToBlue1
;}

;הורדת מס חומה אחרי ההשמה שלה {
sub [amountOfwallsP2],1
jmp Pre_ChangeTurn1
subToBlue1:
	sub [amountOfwallsP1],1
;}

Pre_ChangeTurn1:
;}
jmp ChangeTurn ;החלפת תור
	endp startGame