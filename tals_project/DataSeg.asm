
filehandle dw ?
Header db 54 dup (0)
Palette db 256*4 dup (0)
ScrLine db 320 dup (0)
ErrorMsg db 'Error', 13, 10,'$' 
;---
;---
;---
;---
;---
;---
;---
;---
; משתמים על חומ ות מחולקות לאנך ואופקי והם כ1ך כול מקום במערך מייצג חומה אם המשתנה אחד משמע יש חומה אם המשתנה הוא 0משמע אין חומה
;אנכים :
wallsA dw 36 dup (0)
;הספירה מתחילה מצד שמאל למטה וממשיכה עד לימין למטנ ואז עולה שורה לשמאל שורה 2 וכך ממשיך
wallsO dw 35 dup (0)
;הספירה מתחילה משמאל למטה וממשיכה ימינה וא עולה שורה וכך זה ממשיך
n35 dw 35
n25 dw 25



;כול שמות התמונות{
 picinfomain db 'Infoma.bmp',0	
 picinfoexit db 'InfoEx.bmp',0
 picopenexit db 'openEx.bmp',0
 picopeninfo db 'openif.bmp',0
 picopenmain db 'openma.bmp',0
 picopenplay db 'plopen.bmp',0
picopenrules db 'openru.bmp',0
picpanelexit db 'PanelE.bmp',0
picpanelgame db 'Panelg.bmp',0
picrulesexit db 'RulesE.bmp',0
picrulesmain db 'Rulesg.bmp',0	
;}