C R E A T E   T A B L E   [ d b o ] . [ t b l C o u r s e L i n k e d ]   (  
 	 [ c a m p u s ]   [ v a r c h a r ]   ( 1 0 )   C O L L A T E   S Q L _ L a t i n 1 _ G e n e r a l _ C P 1 _ C I _ A S   N U L L   ,  
 	 [ h i s t o r y i d ]   [ v a r c h a r ]   ( 1 8 )   C O L L A T E   S Q L _ L a t i n 1 _ G e n e r a l _ C P 1 _ C I _ A S   N U L L   ,  
 	 [ s r c ]   [ c h a r ]   ( 3 )   C O L L A T E   S Q L _ L a t i n 1 _ G e n e r a l _ C P 1 _ C I _ A S   N U L L   ,  
 	 [ s e q ]   [ i n t ]   N U L L   ,  
 	 [ d s t ]   [ v a r c h a r ]   ( 2 0 )   C O L L A T E   S Q L _ L a t i n 1 _ G e n e r a l _ C P 1 _ C I _ A S   N U L L   ,  
 	 [ i d ]   [ i n t ]   I D E N T I T Y   ( 1 ,   1 )   N O T   N U L L   ,  
 	 [ c o u r s e t y p e ]   [ c h a r ]   ( 3 )   C O L L A T E   S Q L _ L a t i n 1 _ G e n e r a l _ C P 1 _ C I _ A S   N U L L   ,  
 	 [ a u d i t d a t e ]   [ d a t e t i m e ]   N U L L   ,  
 	 [ a u d i t b y ]   [ v a r c h a r ]   ( 2 0 )   C O L L A T E   S Q L _ L a t i n 1 _ G e n e r a l _ C P 1 _ C I _ A S   N U L L   ,  
 	 [ r e f ]   [ i n t ]   N U L L    
 )   O N   [ P R I M A R Y ]  
 G O  
  
 C R E A T E   T A B L E   [ d b o ] . [ t b l C o u r s e L i n k e d 2 ]   (  
 	 [ h i s t o r y i d ]   [ v a r c h a r ]   ( 1 8 )   C O L L A T E   S Q L _ L a t i n 1 _ G e n e r a l _ C P 1 _ C I _ A S   N U L L   ,  
 	 [ i d ]   [ i n t ]   N U L L   ,  
 	 [ i t e m ]   [ i n t ]   N U L L   ,  
 	 [ c o u r s e t y p e ]   [ c h a r ]   ( 3 )   C O L L A T E   S Q L _ L a t i n 1 _ G e n e r a l _ C P 1 _ C I _ A S   N U L L   ,  
 	 [ a u d i t d a t e ]   [ d a t e t i m e ]   N U L L   ,  
 	 [ a u d i t b y ]   [ v a r c h a r ]   ( 2 0 )   C O L L A T E   S Q L _ L a t i n 1 _ G e n e r a l _ C P 1 _ C I _ A S   N U L L   ,  
 	 [ i t e m 2 ]   [ i n t ]   N U L L    
 )   O N   [ P R I M A R Y ]  
 G O  
  
  
 C R E A T E   T A B L E   [ d b o ] . [ t b l V a l u e s ]   (  
 	 [ i d ]   [ n u m e r i c ] ( 1 8 ,   0 )   I D E N T I T Y   ( 1 ,   1 )   N O T   N U L L   ,  
 	 [ c a m p u s ]   [ v a r c h a r ]   ( 1 0 )   C O L L A T E   S Q L _ L a t i n 1 _ G e n e r a l _ C P 1 _ C I _ A S   N U L L   ,  
 	 [ t o p i c ]   [ v a r c h a r ]   ( 5 0 )   C O L L A T E   S Q L _ L a t i n 1 _ G e n e r a l _ C P 1 _ C I _ A S   N U L L   ,  
 	 [ s u b t o p i c ]   [ v a r c h a r ]   ( 5 0 )   C O L L A T E   S Q L _ L a t i n 1 _ G e n e r a l _ C P 1 _ C I _ A S   N U L L   ,  
 	 [ s h o r t d e s c r ]   [ v a r c h a r ]   ( 5 0 )   C O L L A T E   S Q L _ L a t i n 1 _ G e n e r a l _ C P 1 _ C I _ A S   N U L L   ,  
 	 [ l o n g d e s c r ]   [ t e x t ]   C O L L A T E   S Q L _ L a t i n 1 _ G e n e r a l _ C P 1 _ C I _ A S   N U L L   ,  
 	 [ a u d i t b y ]   [ v a r c h a r ]   ( 5 0 )   C O L L A T E   S Q L _ L a t i n 1 _ G e n e r a l _ C P 1 _ C I _ A S   N U L L   ,  
 	 [ a u d i t d a t e ]   [ s m a l l d a t e t i m e ]   N U L L    
 )   O N   [ P R I M A R Y ]   T E X T I M A G E _ O N   [ P R I M A R Y ]  
 G O  
  
 C R E A T E   T A B L E   [ d b o ] . [ t b l V a l u e s d a t a ]   (  
 	 [ c o u r s e a l p h a ]   [ v a r c h a r ]   ( 1 0 )   C O L L A T E   S Q L _ L a t i n 1 _ G e n e r a l _ C P 1 _ C I _ A S   N U L L   ,  
 	 [ c o u r s e n u m ]   [ v a r c h a r ]   ( 1 0 )   C O L L A T E   S Q L _ L a t i n 1 _ G e n e r a l _ C P 1 _ C I _ A S   N U L L   ,  
 