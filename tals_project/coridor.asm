IDEAL
MODEL small
STACK 200h ;סתם כי ה100 לא הסתדר לי בעין
DATASEG
;כול הקבצים שקשורים למשתנים{
include "DataSeg.asm"
include "goaty.asm"
include "DSG.asm"
include "temp.asm"
;}
CODESEG 
;כול הקבצים של כוללים פרוצדורות ומקרואים{
include "mouse.asm"
include "zitan.asm"
include "macros.asm"
include "procs.asm"
include "procsG.asm"
include "moveP.asm"
include "PMT.asm"
include"RSAS.asm"
include "WCPW.asm"
include "PWH.asm"
include "PWA.asm"
include "IBequs.asm";
include "IPBR.asm"
include "IPTR.asm"
include "UDTBR.asm"
include "gameproc.asm"
;}
coridor:
	mov ax, @data
	mov ds, ax
TalIzkovich@gmail:
	call OpenScreen
	call startGame
	jmp TalIzkovich@gmail
END coridor


