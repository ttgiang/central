U S E   [ c c v 2 ]  
 G O  
  
 S E T   A N S I _ N U L L S   O N  
 G O  
 S E T   Q U O T E D _ I D E N T I F I E R   O N  
 G O  
 A L T E R   V I E W   [ d b o ] . [ v w _ A C C J C D e s c r i p t i o n ]  
 A S  
 S E L E C T           h i s t o r y i d ,   s o u r c e ,   s e q ,   i t e m ,   a c k t i o n ,   d t e ,   r e v i e w e r ,   c a m p u s ,   c o u r s e a l p h a ,   c o u r s e n u m ,   c o m m e n t s ,   q u e s t i o n  
 F R O M                   ( S E L E C T           r . h i s t o r y i d ,   r . s o u r c e ,   r . i t e m ,   q . q u e s t i o n s e q   A S   s e q ,   r . a c k t i o n ,   r . d t e ,   r . r e v i e w e r ,   r . c a m p u s ,   r . c o u r s e a l p h a ,   r . c o u r s e n u m ,   C A S T ( r . c o m m e n t s   A S   v a r c h a r ( 1 0 0 0 ) )    
                                                                                             A S   c o m m e n t s ,   C A S T ( q . q u e s t i o n   A S   v a r c h a r ( 5 0 0 ) )   A S   q u e s t i o n  
                                               F R O M                     t b l R e v i e w H i s t   r   I N N E R   J O I N  
                                                                                             t b l C o u r s e Q u e s t i o n s   q   O N   r . c a m p u s   =   q . c a m p u s   A N D   r . i t e m   =   q . q u e s t i o n n u m b e r  
                                               W H E R E             ( r . s o u r c e   =   ' 1 ' )  
                                               U N I O N  
                                               S E L E C T           r . h i s t o r y i d ,   r . s o u r c e ,   r . i t e m ,   q . q u e s t i o n s e q   A S   s e q ,   r . a c k t i o n ,   r . d t e ,   r . r e v i e w e r ,   r . c a m p u s ,   r . c o u r s e a l p h a ,   r . c o u r s e n u m ,   C A S T ( r . c o m m e n t s   A S   v a r c h a r ( 1 0 0 0 ) )    
                                                                                           A S   c o m m e n t s ,   C A S T ( q . q u e s t i o n   A S   v a r c h a r ( 5 0 0 ) )   A S   q u e s t i o n  
                                               F R O M                   t b l R e v i e w H i s t   r   I N N E R   J O I N  
                                                                                           t b l C a m p u s Q u e s t i o n s   q   O N   r . c a m p u s   =   q . c a m p u s   A N D   r . i t e m   =   q . q u e s t i o n n u m b e r  
                                               W H E R E           ( r . s o u r c e   =   ' 2 ' )  
                                               U N I O N  
                                               S E L E C T           r . h i s t o r y i d ,   r . s o u r c e ,   r . i t e m ,   q . q u e s t i o n s e q   A S   s e q ,   r . a c k t i o n ,   r . d t e ,   r . r e v i e w e r ,   r . c a m p u s ,   r . c o u r s e a l p h a ,   r . c o u r s e n u m ,   C A S T ( r . c o m m e n t s   A S   v a r c h a r ( 1 0 0 0 ) )    
                                                                                           A S   c o m m e n t s ,   C A S T ( q . q u e s t i o n   A S   v a r c h a r ( 5 0 0 ) )   A S   q u e s t i o n  
                                               F R O M                   t b l R e v i e w H i s t   r   I N N E R   J O I N  
                                                                                           t b l P r o g r a m Q u e s t i o n s   q   O N   r . c a m p u s   =   q . c a m p u s   A N D   r . i t e m   =   q . q u e s t i o n n u m b e r  
                                               W H E R E           ( r . s o u r c e   =   ' - 1 ' ) )   R e v i e w H i s t o r y  
 U N I O N  
 S E L E C T           h i s t o r y i d ,   s o u r c e ,   s e q ,   i t e m ,   a c k t i o n ,   d t e ,   r e v i e w e r ,   c a m p u s ,   c o u r s e a l p h a ,   c o u r s e n u m ,   c o m m e n t s ,   q u e s t i o n  
 F R O M                   ( S E L E C T           r . h i s t o r y i d ,   r . s o u r c e ,   r . i t e m ,   q . q u e s t i o n s e q   A S   s e q ,   r . a c k t i o n ,   r . d t e ,   r . r e v i e w e r ,   r . c a m p u s ,   r . c o u r s e a l p h a ,   r . c o u r s e n u m ,   C A S T ( r . c o m m e n t s   A S   v a r c h a r ( 1 0 0 0 ) )    
                                                                                             A S   c o m m e n t s ,   C A S T ( q . q u e s t i o n   A S   v a r c h a r ( 5 0 0 ) )   A S   q u e s t i o n  
                                               F R O M                     t b l R e v i e w H i s t 2   r   I N N E R   J O I N  
                                                                                             t b l C o u r s e Q u e s t i o n s   q   O N   r . c a m p u s   =   q . c a m p u s   A N D   r . i t e m   =   q . q u e s t i o n n u m b e r  
                                               W H E R E             ( r . s o u r c e   =   ' 1 ' )  
                                               U N I O N  
                                               S E L E C T           r . h i s t o r y i d ,   r . s o u r c e ,   r . i t e m ,   q . q u e s t i o n s e q   A S   s e q ,   r . a c k t i o n ,   r . d t e ,   r . r e v i e w e r ,   r . c a m p u s ,   r . c o u r s e a l p h a ,   r . c o u r s e n u m ,   C A S T ( r . c o m m e n t s   A S   v a r c h a r ( 1 0 0 0 ) )    
                                                                                           A S   c o m m e n t s ,   C A S T ( q . q u e s t i o n   A S   v a r c h a r ( 5 0 0 ) )   A S   q u e s t i o n  
                                               F R O M                   t b l R e v i e w H i s t 2   r   I N N E R   J O I N  
                                                                                           t b l C a m p u s Q u e s t i o n s   q   O N   r . c a m p u s   =   q . c a m p u s   A N D   r . i t e m   =   q . q u e s t i o n n u m b e r  
                                               W H E R E           ( r . s o u r c e   =   ' 2 ' )  
                                               U N I O N  
                                               S E L E C T           r . h i s t o r y i d ,   r . s o u r c e ,   r . i t e m ,   q . q u e s t i o n s e q   A S   s e q ,   r . a c k t i o n ,   r . d t e ,   r . r e v i e w e r ,   r . c a m p u s ,   r . c o u r s e a l p h a ,   r . c o u r s e n u m ,   C A S T ( r . c o m m e n t s   A S   v a r c h a r ( 1 0 0 0 ) )    
                                                                                           A S   c o m m e n t s ,   C A S T ( q . q u e s t i o n   A S   v a r c h a r ( 5 0 0 ) )   A S   q u e s t i o n  
                                               F R O M                   t b l R e v i e w H i s t 2   r   I N N E R   J O I N  
                                                                                           t b l P r o g r a m Q u e s t i o n s   q   O N   r . c a m p u s   =   q . c a m p u s   A N D   r . i t e m   =   q . q u e s t i o n n u m b e r  
                                               W H E R E           ( r . s o u r c e   =   ' - 1 ' ) )   R e v i e w H i s t o r y 2  
  
 G O  
 