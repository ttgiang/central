A L T E R   T A B L E   [ d b o ] . [ C C C M 6 1 0 0 ]   A D D    
 	 C O N S T R A I N T   [ D F _ _ C C C M 6 1 0 0 _ _ Q u e s t i _ _ 7 2 7 B F 3 8 7 ]   D E F A U L T   ( 0 )   F O R   [ Q u e s t i o n _ L e n ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ j d b c l o g ]   A D D    
 	 C O N S T R A I N T   [ D F _ j d b c l o g _ d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ d a t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l A p p r o v a l ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l A p p r o v a l _ a p p r o v a l _ d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a p p r o v a l _ d a t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l A p p r o v a l H i s t ]   A D D    
 	 C O N S T R A I N T   [ D F _ _ t b l A p p r o v _ _ a p p r o _ _ 2 7 7 9 C B A B ]   D E F A U L T   ( 0 )   F O R   [ a p p r o v e r _ s e q ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l A p p r o v _ _ v o t e s _ _ 7 E 4 2 A B E E ]   D E F A U L T   ( 0 )   F O R   [ v o t e s f o r ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l A p p r o v _ _ v o t e s _ _ 7 F 3 6 D 0 2 7 ]   D E F A U L T   ( 0 )   F O R   [ v o t e s a g a i n s t ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l A p p r o v _ _ v o t e s _ _ 0 0 2 A F 4 6 0 ]   D E F A U L T   ( 0 )   F O R   [ v o t e s a b s t a i n ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l A p p r o v a l H i s t 2 ]   A D D    
 	 C O N S T R A I N T   [ D F _ _ t b l A p p r o v _ _ a p p r o _ _ 2 8 6 D E F E 4 ]   D E F A U L T   ( 0 )   F O R   [ a p p r o v e r _ s e q ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l A p p r o v _ _ v o t e s _ _ 0 1 1 F 1 8 9 9 ]   D E F A U L T   ( 0 )   F O R   [ v o t e s f o r ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l A p p r o v _ _ v o t e s _ _ 0 2 1 3 3 C D 2 ]   D E F A U L T   ( 0 )   F O R   [ v o t e s a g a i n s t ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l A p p r o v _ _ v o t e s _ _ 0 3 0 7 6 1 0 B ]   D E F A U L T   ( 0 )   F O R   [ v o t e s a b s t a i n ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l A p p r o v e r ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l A p p r o v e r _ e x p e r i m e n t a l ]   D E F A U L T   ( 0 )   F O R   [ e x p e r i m e n t a l ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l A p p r o v _ _ r o u t e _ _ 1 E E 4 8 5 A A ]   D E F A U L T   ( 1 )   F O R   [ r o u t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l A r c h i v e d P r o g r a m ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l A r c h i v e d P r o g r a m _ c a m p u s ]   D E F A U L T   ( ' L C C ' )   F O R   [ c a m p u s ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l A s s e s s e d D a t a ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l A s s e s s e d D a t a _ C o u r s e T y p e ]   D E F A U L T   ( ' P R E ' )   F O R   [ C o u r s e T y p e ] ,  
 	 C O N S T R A I N T   [ D F _ t b l A s s e s s e d D a t a _ a c c j c i d ]   D E F A U L T   ( 0 )   F O R   [ a c c j c i d ] ,  
 	 C O N S T R A I N T   [ D F _ t b l A s s e s s e d D a t a _ q i d ]   D E F A U L T   ( 0 )   F O R   [ q i d ] ,  
 	 C O N S T R A I N T   [ D F _ t b l A s s e s s e d D a t a _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l A s s e s s e d Q u e s t i o n s ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l A s s e s s e d Q u e s t i o n s _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l A t t a c h ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l A t t a c h _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l C a m p u s D a t a ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l C a m p u s D a t a _ i d ]   D E F A U L T   ( 0 )   F O R   [ i d ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C a m p u s D a t a _ C o u r s e T y p e ]   D E F A U L T   ( ' P R E ' )   F O R   [ C o u r s e T y p e ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C a m p u s D a t a _ e d i t 1 ]   D E F A U L T   ( 1 )   F O R   [ e d i t 1 ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C a m p u s D a t a _ e d i t 2 ]   D E F A U L T   ( 1 )   F O R   [ e d i t 2 ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C a m p u s D a t a _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l C a m p u s D a t a M A U ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l C a m p u s D a t a M A U _ i d ]   D E F A U L T   ( 0 )   F O R   [ i d ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C a m p u s D a t a M A U _ C o u r s e T y p e ]   D E F A U L T   ( ' P R E ' )   F O R   [ C o u r s e T y p e ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C a m p u s D a t a M A U _ e d i t 1 ]   D E F A U L T   ( 1 )   F O R   [ e d i t 1 ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C a m p u s D a t a M A U _ e d i t 2 ]   D E F A U L T   ( 1 )   F O R   [ e d i t 2 ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C a m p u s D a t a M A U _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l C a m p u s Q u e s t i o n s ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l C a m p u s Q u e s t i o n s _ i n c l u d e ]   D E F A U L T   ( ' N ' )   F O R   [ i n c l u d e ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C a m p u s Q u e s t i o n s _ c h a n g e ]   D E F A U L T   ( ' N ' )   F O R   [ c h a n g e ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C a m p u s Q u e s t i o n s _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l C a m p u s _ _ r e q u i _ _ 0 A D D 8 C F D ]   D E F A U L T   ( ' N ' )   F O R   [ r e q u i r e d ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l C o R e q ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l C o R e q _ i d ]   D E F A U L T   ( 0 )   F O R   [ i d ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C o R e q _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l C o R e q _ _ r d r _ _ 7 B 9 B 4 9 6 D ]   D E F A U L T   ( 0 )   F O R   [ r d r ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l C o R e q _ _ c o n s e n _ _ 5 8 A 7 1 2 E B ]   D E F A U L T   ( 0 )   F O R   [ c o n s e n t ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l C o R e q _ _ p e n d i n _ _ 5 C 7 7 A 3 C F ]   D E F A U L T   ( 0 )   F O R   [ p e n d i n g ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l C o u r s e ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e _ C o u r s e T y p e _ 1 ]   D E F A U L T   ( ' P R E ' )   F O R   [ C o u r s e T y p e ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e _ e d i t _ 1 ]   D E F A U L T   ( 1 )   F O R   [ e d i t ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e _ P r o g r e s s _ 1 ]   D E F A U L T   ( ' M O D I F Y ' )   F O R   [ P r o g r e s s ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e _ e d i t 1 _ 1 ]   D E F A U L T   ( 1 )   F O R   [ e d i t 1 ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e _ e d i t 2 _ 1 ]   D E F A U L T   ( 1 )   F O R   [ e d i t 2 ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l C o u r s e A C C J C ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e A C C J C _ A u d i t D a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ A u d i t D a t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l C o u r s e A R C ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e A r c _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e A R C _ e x c l u e f r o m c a t a l o g ]   D E F A U L T   ( 0 )   F O R   [ e x c l u e f r o m c a t a l o g ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e A R C _ v o t e s f o r ]   D E F A U L T   ( 0 )   F O R   [ v o t e s f o r ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e A R C _ v o t e s a g a i n s t ]   D E F A U L T   ( 0 )   F O R   [ v o t e s a g a i n s t ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e A R C _ v o t e s a b s t a i n ]   D E F A U L T   ( 0 )   F O R   [ v o t e s a b s t a i n ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l C o u r s e _ _ r o u t e _ _ 3 9 9 8 7 B E 6 ]   D E F A U L T   ( 1 )   F O R   [ r o u t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l C o u r s e A s s e s s ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e A s s e s s _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l C o u r s e C A N ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e C a n _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e C A N _ e x c l u e f r o m c a t a l o g ]   D E F A U L T   ( 0 )   F O R   [ e x c l u e f r o m c a t a l o g ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e C A N _ v o t e s f o r ]   D E F A U L T   ( 0 )   F O R   [ v o t e s f o r ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e C A N _ v o t e s a g a i n s t ]   D E F A U L T   ( 0 )   F O R   [ v o t e s a g a i n s t ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e C A N _ v o t e s a b s t a i n ]   D E F A U L T   ( 0 )   F O R   [ v o t e s a b s t a i n ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l C o u r s e _ _ r o u t e _ _ 3 A 8 C A 0 1 F ]   D E F A U L T   ( 1 )   F O R   [ r o u t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l C o u r s e C o m p ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e C o m p _ C o m p I D ]   D E F A U L T   ( 0 )   F O R   [ C o m p I D ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e C o m p _ A u d i t D a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ A u d i t D a t e ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l C o u r s e C o _ _ r d r _ _ 0 0 5 F F E 8 A ]   D E F A U L T   ( 0 )   F O R   [ r d r ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l C o u r s e C o m p A s s ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e C o m p A s s _ c o m p i d ]   D E F A U L T   ( 0 )   F O R   [ c o m p i d ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e C o m p A s s _ a s s e s s m e n t i d ]   D E F A U L T   ( 0 )   F O R   [ a s s e s s m e n t i d ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e C o m p A s s _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l C o u r s e C o m p e t e n c y ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e C o m p e t e n c y _ A u d i t D a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l C o u r s e C o _ _ r d r _ _ 0 2 4 8 4 6 F C ]   D E F A U L T   ( 0 )   F O R   [ r d r ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l C o u r s e C o n t e n t ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e C o n t e n t _ C o n t e n t I D ]   D E F A U L T   ( 0 )   F O R   [ C o n t e n t I D ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e C o n t e n t _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l C o u r s e C o _ _ r d r _ _ 7 E 7 7 B 6 1 8 ]   D E F A U L T   ( 0 )   F O R   [ r d r ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l C o u r s e L i n k e d ]   A D D    
 	 C O N S T R A I N T   [ D F _ _ t b l C o u r s e L i _ _ r e f _ _ 5 F B E 2 4 C E ]   D E F A U L T   ( 0 )   F O R   [ r e f ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l C o u r s e L i n k e d 2 ]   A D D    
 	 C O N S T R A I N T   [ D F _ _ t b l C o u r s e _ _ c o u r s _ _ 5 B E D 9 3 E A ]   D E F A U L T   ( ' P R E ' )   F O R   [ c o u r s e t y p e ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l C o u r s e _ _ a u d i t _ _ 5 C E 1 B 8 2 3 ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l C o u r s e _ _ i t e m 2 _ _ 1 A D E E A 9 C ]   D E F A U L T   ( 0 )   F O R   [ i t e m 2 ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l C o u r s e M A U ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e M A U _ C o u r s e T y p e _ 1 ]   D E F A U L T   ( ' P R E ' )   F O R   [ C o u r s e T y p e ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e M A U _ e d i t _ 1 ]   D E F A U L T   ( 1 )   F O R   [ e d i t ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e M A U _ P r o g r e s s _ 1 ]   D E F A U L T   ( ' M O D I F Y ' )   F O R   [ P r o g r e s s ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e M A U _ e d i t 1 _ 1 ]   D E F A U L T   ( 1 )   F O R   [ e d i t 1 ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e M A U _ e d i t 2 _ 1 ]   D E F A U L T   ( 1 )   F O R   [ e d i t 2 ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l C o u r s e Q u e s t i o n s ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e Q u e s t i o n s _ i n c l u d e ]   D E F A U L T   ( ' N ' )   F O R   [ i n c l u d e ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e Q u e s t i o n s _ c h a n g e ]   D E F A U L T   ( ' N ' )   F O R   [ c h a n g e ] ,  
 	 C O N S T R A I N T   [ D F _ t b l C o u r s e Q u e s t i o n s _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l C o u r s e _ _ r e q u i _ _ 0 B D 1 B 1 3 6 ]   D E F A U L T   ( ' N ' )   F O R   [ r e q u i r e d ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l C u r r e n t P r o g r a m ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l C u r r e n t P r o g r a m _ c a m p u s ]   D E F A U L T   ( ' L C C ' )   F O R   [ c a m p u s ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l D e b u g ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l D e b u g _ d e b u g ]   D E F A U L T   ( 0 )   F O R   [ d e b u g ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l D i s t r i b u t i o n ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l D i s t r i b u t i o n _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l D o c s ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l D o c s _ t y p e ]   D E F A U L T   ( ' C ' )   F O R   [ t y p e ] ,  
 	 C O N S T R A I N T   [ D F _ t b l D o c s _ s h o w ]   D E F A U L T   ( ' Y ' )   F O R   [ s h o w ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l E m a i l L i s t ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l E m a i l L i s t _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l E x t r a ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l E x t r a _ i d ]   D E F A U L T   ( 0 )   F O R   [ i d ] ,  
 	 C O N S T R A I N T   [ D F _ t b l E x t r a _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l E x t r a _ _ r d r _ _ 7 B 9 B 4 9 6 D ]   D E F A U L T   ( 0 )   F O R   [ r d r ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l E x t r a _ _ p e n d i n _ _ 0 D 1 A D B 2 A ]   D E F A U L T   ( 0 )   F O R   [ p e n d i n g ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l F o r m s ]   A D D    
 	 C O N S T R A I N T   [ D F _ _ t b l F o r m s _ _ a u d i t d _ _ 2 4 1 3 4 F 1 B ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l G E S L O ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l G E S L O _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l G e n e r i c C o n t e n t ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l G e n e r i c C o n t e n t _ i d ]   D E F A U L T   ( 0 )   F O R   [ i d ] ,  
 	 C O N S T R A I N T   [ D F _ t b l G e n e r i c C o n t e n t _ A u d i t D a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ A u d i t D a t e ] ,  
 	 C O N S T R A I N T   [ D F _ t b l G e n e r i c C o n t e n t _ r d r ]   D E F A U L T   ( 0 )   F O R   [ r d r ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l H e l p i d x ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l H e l p i d x _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l I N I ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l I N I _ s e q ]   D E F A U L T   ( 0 )   F O R   [ s e q ] ,  
 	 C O N S T R A I N T   [ D F _ t b l I N I _ k d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ k d a t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l I n f o ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l I n f o _ D a t e P o s t e d ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ D a t e P o s t e d ] ,  
 	 C O N S T R A I N T   [ D F _ t b l I n f o _ f l a g ]   D E F A U L T   ( 0 )   F O R   [ f l a g ] ,  
 	 C O N S T R A I N T   [ D F _ t b l I n f o _ b l i n k ]   D E F A U L T   ( 0 )   F O R   [ b l i n k ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l M a i l ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l M a i l _ d t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ d t e ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l M a i l _ _ p r o c e s s _ _ 6 C E 3 1 5 C 2 ]   D E F A U L T   ( 0 )   F O R   [ p r o c e s s e d ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l M o d e ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l M o d e _ o v e r r i d e ]   D E F A U L T   ( 0 )   F O R   [ o v e r r i d e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l P D F ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l P D F _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l P r e R e q ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l P r e R e q _ i d ]   D E F A U L T   ( 0 )   F O R   [ i d ] ,  
 	 C O N S T R A I N T   [ D F _ t b l P r e R e q _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l P r e R e q _ _ r d r _ _ 7 A A 7 2 5 3 4 ]   D E F A U L T   ( 0 )   F O R   [ r d r ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l P r e R e q _ _ c o n s e _ _ 5 6 B E C A 7 9 ]   D E F A U L T   ( 0 )   F O R   [ c o n s e n t ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l P r e R e q _ _ p e n d i _ _ 5 E 5 F E C 4 1 ]   D E F A U L T   ( 0 )   F O R   [ p e n d i n g ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l P r o g r a m Q u e s t i o n s ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l P r o g r a m Q u e s t i o n s _ i n c l u d e ]   D E F A U L T   ( ' N ' )   F O R   [ i n c l u d e ] ,  
 	 C O N S T R A I N T   [ D F _ t b l P r o g r a m Q u e s t i o n s _ c h a n g e ]   D E F A U L T   ( ' N ' )   F O R   [ c h a n g e ] ,  
 	 C O N S T R A I N T   [ D F _ t b l P r o g r a m Q u e s t i o n s _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l P r o g r a m s ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l P r o g r a m s _ s e q ]   D E F A U L T   ( 0 )   F O R   [ s e q ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l P r o p o s e d P r o g r a m ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l P r o p o s e d P r o g r a m _ p r o p o s e d _ e d i t ]   D E F A U L T   ( 1 )   F O R   [ p r o p o s e d _ e d i t ] ,  
 	 C O N S T R A I N T   [ D F _ t b l P r o p o s e d P r o g r a m _ r a t i o n a l e _ e d i t ]   D E F A U L T   ( 1 )   F O R   [ r a t i o n a l e _ e d i t ] ,  
 	 C O N S T R A I N T   [ D F _ t b l P r o p o s e d P r o g r a m _ s u b s t a n t i v e _ e d i t ]   D E F A U L T   ( 1 )   F O R   [ s u b s t a n t i v e _ e d i t ] ,  
 	 C O N S T R A I N T   [ D F _ t b l P r o p o s e d P r o g r a m _ a r t i c u l a t e d _ e d i t ]   D E F A U L T   ( 1 )   F O R   [ a r t i c u l a t e d _ e d i t ] ,  
 	 C O N S T R A I N T   [ D F _ t b l P r o p o s e d P r o g r a m _ a d d i t i o n a l s t a f f _ e d i t ]   D E F A U L T   ( 1 )   F O R   [ a d d i t i o n a l s t a f f _ e d i t ] ,  
 	 C O N S T R A I N T   [ D F _ t b l P r o p o s e d P r o g r a m _ c a m p u s ]   D E F A U L T   ( ' L C C ' )   F O R   [ c a m p u s ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l P r o p s ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l P r o p s _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l R e v i e w H i s t ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l R e v i e w H i s t _ d t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ d t e ] ,  
 	 C O N S T R A I N T   [ D F _ t b l R e v i e w H i s t _ s o u r c e ]   D E F A U L T   ( 1 )   F O R   [ s o u r c e ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l R e v i e w _ _ a c k t i _ _ 7 3 9 0 1 3 5 1 ]   D E F A U L T   ( 3 )   F O R   [ a c k t i o n ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l R e v i e w _ _ e n a b l _ _ 4 A 5 8 F 3 9 4 ]   D E F A U L T   ( 0 )   F O R   [ e n a b l e d ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l R e v i e w H i s t 2 ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l R e v i e w H i s t 2 _ d t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ d t e ] ,  
 	 C O N S T R A I N T   [ D F _ t b l R e v i e w H i s t 2 _ s o u r c e ]   D E F A U L T   ( 1 )   F O R   [ s o u r c e ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l R e v i e w _ _ a c k t i _ _ 7 4 8 4 3 7 8 A ]   D E F A U L T   ( 3 )   F O R   [ a c k t i o n ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l R e v i e w _ _ e n a b l _ _ 4 B 4 D 1 7 C D ]   D E F A U L T   ( 0 )   F O R   [ e n a b l e d ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l R p t ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l R p t _ c a m p u s ]   D E F A U L T   ( ' A L L ' )   F O R   [ c a m p u s ] ,  
 	 C O N S T R A I N T   [ D F _ t b l R p t _ r p t f o r m a t ]   D E F A U L T   ( ' P D F ' )   F O R   [ r p t f o r m a t ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l S L O ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l S L O _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l S t a t e m e n t ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l S t a t e m e n t _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l T a s k s ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l T a s k s _ d t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ d t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l T e m p A t t a c h ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l T e m p A t t a c h _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l T e m p C a m p u s D a t a ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l T e m p C a m p u s D a t a _ i d ]   D E F A U L T   ( 0 )   F O R   [ i d ] ,  
 	 C O N S T R A I N T   [ D F _ t b l T e m p C a m p u s D a t a _ e d i t 1 ]   D E F A U L T   ( 1 )   F O R   [ e d i t 1 ] ,  
 	 C O N S T R A I N T   [ D F _ t b l T e m p C a m p u s D a t a _ e d i t 2 ]   D E F A U L T   ( 1 )   F O R   [ e d i t 2 ] ,  
 	 C O N S T R A I N T   [ D F _ t b l T e m p C a m p u s D a t a _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l T e m p C o R e q ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l T e m p C o R e q _ i d ]   D E F A U L T   ( 0 )   F O R   [ i d ] ,  
 	 C O N S T R A I N T   [ D F _ t b l T e m p C o R e q _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l T e m p C o R e _ _ r d r _ _ 7 D 8 3 9 1 D F ]   D E F A U L T   ( 0 )   F O R   [ r d r ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l T e m p C o _ _ c o n s e _ _ 5 9 9 B 3 7 2 4 ]   D E F A U L T   ( 0 )   F O R   [ c o n s e n t ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l T e m p C o _ _ p e n d i _ _ 5 D 6 B C 8 0 8 ]   D E F A U L T   ( 0 )   F O R   [ p e n d i n g ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l T e m p C o u r s e ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l T e m p C o u r s e _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ] ,  
 	 C O N S T R A I N T   [ D F _ t b l T e m p C o u r s e _ e x c l u e f r o m c a t a l o g ]   D E F A U L T   ( 0 )   F O R   [ e x c l u e f r o m c a t a l o g ] ,  
 	 C O N S T R A I N T   [ D F _ t b l T e m p C o u r s e _ v o t e s f o r ]   D E F A U L T   ( 0 )   F O R   [ v o t e s f o r ] ,  
 	 C O N S T R A I N T   [ D F _ t b l T e m p C o u r s e _ v o t e s a g a i n s t ]   D E F A U L T   ( 0 )   F O R   [ v o t e s a g a i n s t ] ,  
 	 C O N S T R A I N T   [ D F _ t b l T e m p C o u r s e _ v o t e s a b s t a i n ]   D E F A U L T   ( 0 )   F O R   [ v o t e s a b s t a i n ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l t e m p C o _ _ r o u t e _ _ 3 8 A 4 5 7 A D ]   D E F A U L T   ( 1 )   F O R   [ r o u t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l T e m p C o u r s e A C C J C ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l T e m p C o u r s e A C C J C _ A u d i t D a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ A u d i t D a t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l T e m p C o u r s e A s s e s s ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l T e m p C o u r s e A s s e s s _ a s s e s s m e n t i d ]   D E F A U L T   ( 0 )   F O R   [ a s s e s s m e n t i d ] ,  
 	 C O N S T R A I N T   [ D F _ t b l T e m p C o u r s e A s s e s s _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l T e m p C o u r s e C o m p ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l T e m p C o u r s e C o m p _ C o m p I D ]   D E F A U L T   ( 0 )   F O R   [ C o m p I D ] ,  
 	 C O N S T R A I N T   [ D F _ t b l T e m p C o u r s e C o m p _ A u d i t D a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ A u d i t D a t e ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l T e m p C o u r _ _ r d r _ _ 0 1 5 4 2 2 C 3 ]   D E F A U L T   ( 0 )   F O R   [ r d r ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l T e m p C o u r s e C o m p A s s ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l T e m p C o u r s e C o m p A s s _ c o m p i d ]   D E F A U L T   ( 0 )   F O R   [ c o m p i d ] ,  
 	 C O N S T R A I N T   [ D F _ t b l T e m p C o u r s e C o m p A s s _ a s s e s s m e n t i d ]   D E F A U L T   ( 0 )   F O R   [ a s s e s s m e n t i d ] ,  
 	 C O N S T R A I N T   [ D F _ t b l T e m p C o u r s e C o m p A s s _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l T e m p C o u r s e C o n t e n t ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l T e m p C o u r s e C o n t e n t _ C o n t e n t I D ]   D E F A U L T   ( 0 )   F O R   [ C o n t e n t I D ] ,  
 	 C O N S T R A I N T   [ D F _ t b l T e m p C o u r s e C o n t e n t _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l T e m p C o u r _ _ r d r _ _ 7 F 6 B D A 5 1 ]   D E F A U L T   ( 0 )   F O R   [ r d r ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l T e m p C o u r s e L i n k e d ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l T e m p C o u r s e L i n k e d _ r e f ]   D E F A U L T   ( 0 )   F O R   [ r e f ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l T e m p C o u r s e L i n k e d 2 ]   A D D    
 	 C O N S T R A I N T   [ D F _ _ t b l T e m p C o _ _ c o u r s _ _ 4 A 8 D F D B E ]   D E F A U L T   ( ' P R E ' )   F O R   [ c o u r s e t y p e ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l T e m p C o _ _ a u d i t _ _ 4 B 8 2 2 1 F 7 ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l T e m p C o _ _ i t e m 2 _ _ 1 B D 3 0 E D 5 ]   D E F A U L T   ( 0 )   F O R   [ i t e m 2 ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l T e m p E x t r a ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l T e m p E x t r a _ i d ]   D E F A U L T   ( 0 )   F O R   [ i d ] ,  
 	 C O N S T R A I N T   [ D F _ t b l T e m p E x t r a _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l T e m p E x t r a _ _ r d r _ _ 7 B 9 B 4 9 6 D ]   D E F A U L T   ( 0 )   F O R   [ r d r ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l T e m p E x _ _ p e n d i _ _ 0 E 0 E F F 6 3 ]   D E F A U L T   ( 0 )   F O R   [ p e n d i n g ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l T e m p G E S L O ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l T e m p G E S L O _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l T e m p G e n e r i c C o n t e n t ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l T e m p G e n e r i c C o n t e n t _ i d ]   D E F A U L T   ( 0 )   F O R   [ i d ] ,  
 	 C O N S T R A I N T   [ D F _ t b l T e m p G e n e r i c C o n t e n t _ A u d i t D a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ A u d i t D a t e ] ,  
 	 C O N S T R A I N T   [ D F _ t b l T e m p G e n e r i c C o n t e n t _ r d r ]   D E F A U L T   ( 0 )   F O R   [ r d r ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l T e m p P r e R e q ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l T e m p P r e R e q _ i d ]   D E F A U L T   ( 0 )   F O R   [ i d ] ,  
 	 C O N S T R A I N T   [ D F _ t b l T e m p P r e R e q _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l T e m p P r e R _ _ r d r _ _ 7 C 8 F 6 D A 6 ]   D E F A U L T   ( 0 )   F O R   [ r d r ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l T e m p P r _ _ c o n s e _ _ 5 7 B 2 E E B 2 ]   D E F A U L T   ( 0 )   F O R   [ c o n s e n t ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l T e m p P r _ _ p e n d i _ _ 5 F 5 4 1 0 7 A ]   D E F A U L T   ( 0 )   F O R   [ p e n d i n g ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l T e m p X R e f ]   A D D    
 	 C O N S T R A I N T   [ D F _ _ t b l T e m p X R _ _ p e n d i _ _ 5 B 8 3 7 F 9 6 ]   D E F A U L T   ( 0 )   F O R   [ p e n d i n g ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l T e m p l a t e ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l T e m p l a t e _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l T e s t ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l T e s t _ i d ]   D E F A U L T   ( 0 )   F O R   [ i d ] ,  
 	 C O N S T R A I N T   [ D F _ t b l T e s t _ d t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ d t e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l U s e r L o g ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l U s e r L o g _ d a t e t i m e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ d a t e t i m e ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l U s e r s ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l U s e r s _ p a s s w o r d ]   D E F A U L T   ( ' c 0 m p 1 e x ' )   F O R   [ p a s s w o r d ] ,  
 	 C O N S T R A I N T   [ D F _ t b l U s e r s _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l u s e r s _ _ s e n d n o _ _ 3 4 6 9 B 2 7 5 ]   D E F A U L T   ( 1 )   F O R   [ s e n d n o w ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l X R e f ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l X R e f _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ] ,  
 	 C O N S T R A I N T   [ D F _ _ t b l X R e f _ _ p e n d i n g _ _ 5 A 8 F 5 B 5 D ]   D E F A U L T   ( 0 )   F O R   [ p e n d i n g ]  
 G O  
  
 A L T E R   T A B L E   [ d b o ] . [ t b l s y l l a b u s ]   A D D    
 	 C O N S T R A I N T   [ D F _ t b l s y l l a b u s _ a u d i t d a t e ]   D E F A U L T   ( g e t d a t e ( ) )   F O R   [ a u d i t d a t e ]  
 G O  
  
 