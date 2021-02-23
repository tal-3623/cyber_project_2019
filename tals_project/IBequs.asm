macro isInBoundariesAndP_GameBoard
push 200
push 0
push 320
push 38
call isInBoundariesAndP
endm
macro isInBoundariesAndP_GameExit
push 32
push 15
push 37
push 0
call isInBoundariesAndP
endm
macro isInBoundariesAndP_BeforeTopRow
push 45
	push 20
	push 320
	push 38
	call isInBoundariesAndP
endm
macro isInBoundariesAndP_TopRow
push 20
push 0
push 320
push 38
call isInBoundariesAndP
endm
macro	isInBoundariesAndP_ReTry
push 200
	push 160
	push 38
	push 0
	call isInBoundariesAndP
endm

macro StartGamePlayerP
	push 143
	push 170
	push offset playerPrintNum1RegularSqure
	call PrintPieceProcRegularSqure
endm
macro StartGamePlayerP2
	push 178
	push 0
	push offset playerPrintNum2HigeRow
call PrintPieceProcHigeRow
endm