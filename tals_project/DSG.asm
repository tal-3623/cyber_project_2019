dataAboutSqures dw 38,0,false,true,true,73,0,false,true,false,108,0,false,true,false,143,0,false,true,false,178,0,true,true,false,213,0,false,true,false,248,0,false,true,false,283,0,false,true,false
			    dw 38,20,false,false,true,73,20,false,false,false,108,20,false,false,false,143,20,false,false,false,178,20,false,false,false,213,20,false,false,false,248,20,false,false,false,283,20,false,false,false 
				dw 38,45,false,false,true,73,45,false,false,false,108,45,false,false,false,143,45,false,false,false,178,45,false,false,false,213,45,false,false,false,248,45,false,false,false,283,45,false,false,false 
				dw 38,70,false,false,true,73,70,false,false,false,108,70,false,false,false,143,70,false,false,false,178,70,false,false,false,213,70,false,false,false,248,70,false,false,false,283,70,false,false,false
				dw 38,95,false,false,true,73,95,false,false,false,108,95,false,false,false,143,95,false,false,false,178,95,false,false,false,213,95,false,false,false,248,95,false,false,false,283,95,false,false,false
				dw 38,120,false,false,true,73,120,false,false,false,108,120,false,false,false,143,120,false,false,false,178,120,false,false,false,213,120,false,false,false,248,120,false,false,false,283,120,false,false,false
				dw 38,145,false,false,true,73,145,false,false,false,108,145,false,false,false,143,145,false,false,false,178,145,false,false,false,213,145,false,false,false,248,145,false,false,false,283,145,false,false,false				
				dw 38,170,false,false,true,73,170,false,false,false,108,170,false,false,false,143,170,true,false,false,178,170,false,false,false,213,170,false,false,false,248,170,false,false,false,283,170,false,false,false
;זה מוסודר כך לכול קוביה 5 נתונים ראשון ציר איקס שני וואי שלישי האם יש שחקן, רביעיהאם יש חומה למעלה ,חמישי האים יש חומה בצד שמאל 
				
				
				
				
CanMoveR dw 1690
CanMoveL dw 1690
CanMoveU dw 1690
CanMoveD dw 1690
canPlaceWallhorzantcly dw true
canPlaceWallAnch dw true


amountOfwallsP1 dw 6
amountOfwallsP2 dw 6

;
isPlayerTopRow dw ?
isPlayerButtonRow dw ?

PPTTRS dw ?
PPTTHR dw ? 		
				
				
IPTR dw true ; האם יש שחקן בשורה העליונה 
IPBR dw true ;האם יש שחקן בשורה התחתונה

IPTR_LastTurn dw ? ; האם יש שחקן בשורה העליונה בתור הקודם
IPBR_LastTurn dw ? ;האם יש שחקן בשורה התחתונה בתור הקודם


				
				
				
				
		
