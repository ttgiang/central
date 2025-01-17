U S E   [ c c v 2 ]  
 G O  
 / * * * * * *   O b j e c t :     T a b l e   [ d b o ] . [ t b l f n d ]         S c r i p t   D a t e :   0 9 / 1 3 / 2 0 1 3   0 7 : 5 2 : 1 4   * * * * * * /  
 S E T   A N S I _ N U L L S   O N  
 G O  
 S E T   Q U O T E D _ I D E N T I F I E R   O N  
 G O  
 S E T   A N S I _ P A D D I N G   O N  
 G O  
 C R E A T E   T A B L E   [ d b o ] . [ t b l f n d ] (  
 	 [ i d ]   [ i n t ]   I D E N T I T Y ( 1 , 1 )   N O T   N U L L ,  
 	 [ c a m p u s ]   [ v a r c h a r ] ( 1 0 )   N U L L ,  
 	 [ h i s t o r y i d ]   [ v a r c h a r ] ( 1 8 )   N U L L ,  
 	 [ f n d t y p e ]   [ c h a r ] ( 2 )   N U L L ,  
 	 [ c r e a t e d ]   [ s m a l l d a t e t i m e ]   N U L L ,  
 	 [ c o u r s e a l p h a ]   [ v a r c h a r ] ( 1 0 )   N U L L ,  
 	 [ c o u r s e n u m ]   [ v a r c h a r ] ( 1 0 )   N U L L ,  
 	 [ c o u r s e d a t e ]   [ s m a l l d a t e t i m e ]   N U L L ,  
 	 [ c o u r s e t i t l e ]   [ v a r c h a r ] ( 1 0 0 )   N U L L ,  
 	 [ c o u r s e d e s c r ]   [ t e x t ]   N U L L ,  
 	 [ p r o p o s e r ]   [ v a r c h a r ] ( 5 0 )   N U L L ,  
 	 [ c o p r o p o s e r ]   [ v a r c h a r ] ( 5 0 0 )   N U L L ,  
 	 [ t y p e ]   [ c h a r ] ( 3 )   N U L L ,  
 	 [ p r o g r e s s ]   [ v a r c h a r ] ( 5 0 )   N U L L ,  
 	 [ s u b p r o g r e s s ]   [ v a r c h a r ] ( 5 0 )   N U L L ,  
 	 [ e d i t ]   [ b i t ]   N U L L ,  
 	 [ e d i t 0 ]   [ v a r c h a r ] ( 5 0 )   N U L L ,  
 	 [ e d i t 1 ]   [ v a r c h a r ] ( 5 0 0 )   N U L L ,  
 	 [ e d i t 2 ]   [ v a r c h a r ] ( 5 0 0 )   N U L L ,  
 	 [ a s s e s s m e n t ]   [ t e x t ]   N U L L ,  
 	 [ r e v i e w d a t e ]   [ s m a l l d a t e t i m e ]   N U L L ,  
 	 [ c o m m e n t s ]   [ t e x t ]   N U L L ,  
 	 [ d a t e a p p r o v e d ]   [ s m a l l d a t e t i m e ]   N U L L ,  
 	 [ a u d i t b y ]   [ v a r c h a r ] ( 5 0 )   N U L L ,  
 	 [ a u d i t d a t e ]   [ s m a l l d a t e t i m e ]   N U L L ,  
 	 [ r o u t e ]   [ i n t ] ,  
   C O N S T R A I N T   [ P K _ t b l f n d ]   P R I M A R Y   K E Y   C L U S T E R E D    
 (  
 	 [ i d ]   A S C  
 ) W I T H   ( P A D _ I N D E X     =   O F F ,   S T A T I S T I C S _ N O R E C O M P U T E     =   O F F ,   I G N O R E _ D U P _ K E Y   =   O F F ,   A L L O W _ R O W _ L O C K S     =   O N ,   A L L O W _ P A G E _ L O C K S     =   O N )   O N   [ P R I M A R Y ]  
 )   O N   [ P R I M A R Y ]   T E X T I M A G E _ O N   [ P R I M A R Y ]  
  
 G O  
 S E T   A N S I _ P A D D I N G   O F F  
  
 / * * * * * *   O b j e c t :     T a b l e   [ d b o ] . [ t b l f n d d a t a ]         S c r i p t   D a t e :   0 9 / 0 9 / 2 0 1 3   0 7 : 3 8 : 4 8   * * * * * * /  
 S E T   A N S I _ N U L L S   O N  
 G O  
 S E T   Q U O T E D _ I D E N T I F I E R   O N  
 G O  
 S E T   A N S I _ P A D D I N G   O N  
 G O  
 C R E A T E   T A B L E   [ d b o ] . [ t b l f n d d a t a ] (  
 	 [ i d ]   [ i n t ]   N O T   N U L L ,  
 	 [ s e q ]   [ i n t ]   I D E N T I T Y ( 1 , 1 )   N O T   N U L L ,  
 	 [ f l d ]   [ c h a r ] ( 1 0 )   N O T   N U L L ,  
 	 [ d a t a ]   [ t e x t ]   N U L L ,  
 	 [ a u d i t b y ]   [ v a r c h a r ] ( 5 0 )   N U L L ,  
 	 [ a u d i t d a t e ]   [ s m a l l d a t e t i m e ]   N U L L ,  
 	 [ t s ]   [ t i m e s t a m p ]   N O T   N U L L ,  
   C O N S T R A I N T   [ P K _ t b l f n d d a t a ]   P R I M A R Y   K E Y   C L U S T E R E D    
 (  
 	 [ s e q ]   A S C  
 ) W I T H   ( P A D _ I N D E X     =   O F F ,   S T A T I S T I C S _ N O R E C O M P U T E     =   O F F ,   I G N O R E _ D U P _ K E Y   =   O F F ,   A L L O W _ R O W _ L O C K S     =   O N ,   A L L O W _ P A G E _ L O C K S     =   O N )   O N   [ P R I M A R Y ]  
 )   O N   [ P R I M A R Y ]   T E X T I M A G E _ O N   [ P R I M A R Y ]  
  
 G O  
 S E T   A N S I _ P A D D I N G   O F F  
  
 / * * * * * *   O b j e c t :     T a b l e   [ d b o ] . [ t b l f n d f i l e s ]         S c r i p t   D a t e :   0 9 / 0 9 / 2 0 1 3   0 7 : 1 0 : 2 6   * * * * * * /  
 S E T   A N S I _ N U L L S   O N  
 G O  
 S E T   Q U O T E D _ I D E N T I F I E R   O N  
 G O  
 S E T   A N S I _ P A D D I N G   O N  
 G O  
 C R E A T E   T A B L E   [ d b o ] . [ t b l f n d f i l e s ] (  
 	 [ i d ]   [ i n t ]   N O T   N U L L ,  
 	 [ s e q ]   [ i n t ]   I D E N T I T Y ( 1 , 1 )   N O T   N U L L ,  
 	 [ c a m p u s ]   [ v a r c h a r ] ( 1 0 )   N U L L ,  
 	 [ k i x ]   [ v a r c h a r ] ( 1 8 )   N U L L ,  
 	 [ o r i g i n a l n a m e ]   [ v a r c h a r ] ( 1 0 0 )   N U L L ,  
 	 [ f i l e n a m e ]   [ v a r c h a r ] ( 1 0 0 )   N U L L ,  
 	 [ e n ]   [ i n t ]   N U L L ,  
 	 [ s q ]   [ i n t ]   N U L L ,  
 	 [ q n ]   [ i n t ]   N U L L ,  
 	 [ a u d i t b y ]   [ v a r c h a r ] ( 5 0 )   N U L L ,  
 	 [ a u d i t d a t e ]   [ s m a l l d a t e t i m e ]   N U L L ,  
   C O N S T R A I N T   [ P K _ t b l f n d f i l e s ]   P R I M A R Y   K E Y   C L U S T E R E D    
 (  
 	 [ i d ]   A S C ,  
 	 [ s e q ]   A S C  
 ) W I T H   ( P A D _ I N D E X     =   O F F ,   S T A T I S T I C S _ N O R E C O M P U T E     =   O F F ,   I G N O R E _ D U P _ K E Y   =   O F F ,   A L L O W _ R O W _ L O C K S     =   O N ,   A L L O W _ P A G E _ L O C K S     =   O N )   O N   [ P R I M A R Y ]  
 )   O N   [ P R I M A R Y ]  
  
 G O  
 S E T   A N S I _ P A D D I N G   O F F  
 G O  
 / * * * * * *   O b j e c t :     T a b l e   [ d b o ] . [ t b l f n d i t e m s ]         S c r i p t   D a t e :   0 9 / 0 9 / 2 0 1 3   0 7 : 1 0 : 2 6   * * * * * * /  
 S E T   A N S I _ N U L L S   O N  
 G O  
 S E T   Q U O T E D _ I D E N T I F I E R   O N  
 G O  
 S E T   A N S I _ P A D D I N G   O N  
 G O  
 C R E A T E   T A B L E   [ d b o ] . [ t b l f n d i t e m s ] (  
 	 [ i d ]   [ n u m e r i c ] ( 1 0 ,   0 )   N O T   N U L L ,  
 	 [ t y p e ]   [ v a r c h a r ] ( 5 0 )   N U L L ,  
 	 [ f l d ]   [ c h a r ] ( 1 0 )   N O T   N U L L ,  
 	 [ s e q ]   [ i n t ]   N O T   N U L L ,  
 	 [ e n ]   [ i n t ]   N O T   N U L L ,  
 	 [ q n ]   [ i n t ]   N O T   N U L L ,  
 	 [ h a l l m a r k ]   [ t e x t ]   N U L L ,  
 	 [ e x p l a n a t o r y ]   [ t e x t ]   N U L L ,  
 	 [ q u e s t i o n ]   [ t e x t ]   N U L L ,  
 	 [ c a m p u s ]   [ v a r c h a r ] ( 1 0 )   N U L L ,  
 	 [ a u d i t b y ]   [ v a r c h a r ] ( 2 0 )   N U L L ,  
 	 [ a u d i t d a t e ]   [ s m a l l d a t e t i m e ]   N U L L ,  
   C O N S T R A I N T   [ P K _ t b l f n d i t e m s ]   P R I M A R Y   K E Y   C L U S T E R E D    
 (  
 	 [ f l d ]   A S C ,  
 	 [ s e q ]   A S C ,  
 	 [ e n ]   A S C ,  
 	 [ q n ]   A S C  
 ) W I T H   ( P A D _ I N D E X     =   O F F ,   S T A T I S T I C S _ N O R E C O M P U T E     =   O F F ,   I G N O R E _ D U P _ K E Y   =   O F F ,   A L L O W _ R O W _ L O C K S     =   O N ,   A L L O W _ P A G E _ L O C K S     =   O N )   O N   [ P R I M A R Y ]  
 )   O N   [ P R I M A R Y ]   T E X T I M A G E _ O N   [ P R I M A R Y ]  
  
 G O  
 S E T   A N S I _ P A D D I N G   O F F  
 G O  
 / * * * * * *   O b j e c t :     T a b l e   [ d b o ] . [ t b l f n d l i n k e d ]         S c r i p t   D a t e :   0 9 / 0 9 / 2 0 1 3   0 7 : 1 0 : 2 6   * * * * * * /  
 S E T   A N S I _ N U L L S   O N  
 G O  
 S E T   Q U O T E D _ I D E N T I F I E R   O N  
 G O  
 S E T   A N S I _ P A D D I N G   O N  
 G O  
 C R E A T E   T A B L E   [ d b o ] . [ t b l f n d l i n k e d ] (  
 	 [ c a m p u s ]   [ v a r c h a r ] ( 1 0 )   N U L L ,  
 	 [ i d ]   [ i n t ]   N O T   N U L L ,  
 	 [ h i s t o r y i d ]   [ v a r c h a r ] ( 1 8 )   N U L L ,  
 	 [ s r c ]   [ c h a r ] ( 3 )   N O T   N U L L ,  
 	 [ s r c i d ]   [ i n t ]   N O T   N U L L ,  
 	 [ f n d i d ]   [ i n t ]   N O T   N U L L ,  
 	 [ a u d i t d a t e ]   [ d a t e t i m e ]   N U L L ,  
 	 [ a u d i t b y ]   [ v a r c h a r ] ( 2 0 )   N U L L ,  
   C O N S T R A I N T   [ P K _ t b l f n d l i n k e d ]   P R I M A R Y   K E Y   C L U S T E R E D    
 (  
 	 [ i d ]   A S C ,  
 	 [ s r c ]   A S C ,  
 	 [ s r c i d ]   A S C ,  
 	 [ f n d i d ]   A S C  
 ) W I T H   ( P A D _ I N D E X     =   O F F ,   S T A T I S T I C S _ N O R E C O M P U T E     =   O F F ,   I G N O R E _ D U P _ K E Y   =   O F F ,   A L L O W _ R O W _ L O C K S     =   O N ,   A L L O W _ P A G E _ L O C K S     =   O N )   O N   [ P R I M A R Y ]  
 )   O N   [ P R I M A R Y ]  
  
 G O  
 S E T   A N S I _ P A D D I N G   O F F  
 G O  
 / * * * * * *   O b j e c t :     T a b l e   [ d b o ] . [ t b l f n d o u t l i n e s ]         S c r i p t   D a t e :   0 9 / 0 9 / 2 0 1 3   0 7 : 1 0 : 2 6   * * * * * * /  
 S E T   A N S I _ N U L L S   O N  
 G O  
 S E T   Q U O T E D _ I D E N T I F I E R   O N  
 G O  
 S E T   A N S I _ P A D D I N G   O N  
 G O  
 C R E A T E   T A B L E   [ d b o ] . [ t b l f n d o u t l i n e s ] (  
 	 [ i d ]   [ n u m e r i c ] ( 1 8 ,   0 )   I D E N T I T Y ( 1 , 1 )   N O T   N U L L ,  
 	 [ c a t e g o r y ]   [ v a r c h a r ] ( 3 0 )   N U L L ,  
 	 [ c o u r s e a l p h a ]   [ v a r c h a r ] ( 1 0 )   N U L L ,  
 	 [ c o u r s e n u m ]   [ v a r c h a r ] ( 1 0 )   N U L L ,  
 	 [ c o u r s e t y p e ]   [ v a r c h a r ] ( 1 0 )   N U L L ,  
 	 [ c o u r s e t i t l e ]   [ v a r c h a r ] ( 1 0 0 )   N U L L ,  
 	 [ H A W ]   [ v a r c h a r ] ( 1 8 )   N U L L ,  
 	 [ H I L ]   [ v a r c h a r ] ( 1 8 )   N U L L ,  
 	 [ H O N ]   [ v a r c h a r ] ( 1 8 )   N U L L ,  
 	 [ K A P ]   [ v a r c h a r ] ( 1 8 )   N U L L ,  
 	 [ K A U ]   [ v a r c h a r ] ( 1 8 )   N U L L ,  
 	 [ L E E ]   [ v a r c h a r ] ( 1 8 )   N U L L ,  
 	 [ M A N ]   [ v a r c h a r ] ( 1 8 )   N U L L ,  
 	 [ U H M C ]   [ v a r c h a r ] ( 1 8 )   N U L L ,  
 	 [ W I N ]   [ v a r c h a r ] ( 1 8 )   N U L L ,  
 	 [ W O A ]   [ v a r c h a r ] ( 1 8 )   N U L L ,  
 	 [ H A W _ 2 ]   [ v a r c h a r ] ( 1 0 0 )   N U L L ,  
 	 [ H I L _ 2 ]   [ v a r c h a r ] ( 1 0 0 )   N U L L ,  
 	 [ H O N _ 2 ]   [ v a r c h a r ] ( 1 0 0 )   N U L L ,  
 	 [ K A P _ 2 ]   [ v a r c h a r ] ( 1 0 0 )   N U L L ,  
 	 [ K A U _ 2 ]   [ v a r c h a r ] ( 1 0 0 )   N U L L ,  
 	 [ L E E _ 2 ]   [ v a r c h a r ] ( 1 0 0 )   N U L L ,  
 	 [ M A N _ 2 ]   [ v a r c h a r ] ( 1 0 0 )   N U L L ,  
 	 [ U H M C _ 2 ]   [ v a r c h a r ] ( 1 0 0 )   N U L L ,  
 	 [ W I N _ 2 ]   [ v a r c h a r ] ( 1 0 0 )   N U L L ,  
 	 [ W O A _ 2 ]   [ v a r c h a r ] ( 1 0 0 )   N U L L ,  
   C O N S T R A I N T   [ P K _ t b l f n d o u t l i n e s ]   P R I M A R Y   K E Y   C L U S T E R E D    
 (  
 	 [ i d ]   A S C  
 ) W I T H   ( P A D _ I N D E X     =   O F F ,   S T A T I S T I C S _ N O R E C O M P U T E     =   O F F ,   I G N O R E _ D U P _ K E Y   =   O F F ,   A L L O W _ R O W _ L O C K S     =   O N ,   A L L O W _ P A G E _ L O C K S     =   O N )   O N   [ P R I M A R Y ]  
 )   O N   [ P R I M A R Y ]  
  
 G O  
 S E T   A N S I _ P A D D I N G   O F F  
  
 