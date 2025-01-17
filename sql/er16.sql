U S E   [ c c v 2 ]  
 G O  
 / * * * * * *   O b j e c t :     V i e w   [ d b o ] . [ v w _ A R C ]         S c r i p t   D a t e :   0 7 / 2 5 / 2 0 1 2   1 2 : 5 9 : 5 4   * * * * * * /  
 S E T   A N S I _ N U L L S   O N  
 G O  
 S E T   Q U O T E D _ I D E N T I F I E R   O N  
 G O  
 C R E A T E   V I E W   [ d b o ] . [ v w _ A R C ]  
 A S  
 S E L E C T           T O P   ( 1 0 0 )   P E R C E N T   L T R I M ( c a m p u s )   +   L T R I M ( C o u r s e A l p h a )   +   L T R I M ( C o u r s e N u m )   A S   k e e ,   c a m p u s ,   C o u r s e A l p h a ,   C o u r s e N u m ,   c o u r s e t i t l e ,   p r o p o s e r ,   c o u r s e d a t e ,    
                                             a u d i t d a t e ,   h i s t o r y i d ,   C o u r s e T y p e ,   P r o g r e s s  
 F R O M                   d b o . t b l C o u r s e A R C  
 W H E R E           ( C o u r s e A l p h a   < >   ' ' )   A N D   ( N O T   ( C o u r s e A l p h a   I S   N U L L ) )   A N D   ( C o u r s e N u m   < >   ' ' )   A N D   ( N O T   ( C o u r s e N u m   I S   N U L L ) )   A N D   ( p r o p o s e r   < >   ' ' )   A N D   ( N O T   ( p r o p o s e r   I S   N U L L ) )  
 O R D E R   B Y   c a m p u s ,   C o u r s e A l p h a ,   C o u r s e N u m  
  
 G O  
  
 / * * * * * *   O b j e c t :     V i e w   [ d b o ] . [ v w _ A R C p ]         S c r i p t   D a t e :   0 7 / 2 5 / 2 0 1 2   1 2 : 5 9 : 5 4   * * * * * * /  
 S E T   A N S I _ N U L L S   O N  
 G O  
 S E T   Q U O T E D _ I D E N T I F I E R   O N  
 G O  
 C R E A T E   V I E W   [ d b o ] . [ v w _ A R C p ]  
 A S  
 S E L E C T           R T R I M ( t i t l e )   +   ' _ '   +   C A S T ( d e g r e e i d   A S   v a r c h a r )   +   ' _ '   +   C A S T ( d i v i s i o n i d   A S   v a r c h a r )   A S   k e e ,   c a m p u s ,   h i s t o r y i d ,   t y p e ,   p r o g r e s s ,   d e g r e e i d ,   d i v i s i o n i d ,   e f f e c t i v e d a t e ,   t i t l e ,    
                                             p r o p o s e r ,   a u d i t d a t e ,   d a t e d e l e t e d ,   d a t e a p p r o v e d  
 F R O M                   d b o . t b l P r o g r a m s  
 W H E R E           ( t y p e   =   ' A R C ' )   A N D   ( p r o g r e s s   =   ' A R C H I V E D ' )  
  
 G O  
  
 / * * * * * *   O b j e c t :     V i e w   [ d b o ] . [ v w _ C U R ]         S c r i p t   D a t e :   0 7 / 2 5 / 2 0 1 2   1 2 : 5 9 : 5 4   * * * * * * /  
 S E T   A N S I _ N U L L S   O N  
 G O  
 S E T   Q U O T E D _ I D E N T I F I E R   O N  
 G O  
 C R E A T E   V I E W   [ d b o ] . [ v w _ C U R ]  
 A S  
 S E L E C T           T O P   ( 1 0 0 )   P E R C E N T   L T R I M ( c a m p u s )   +   L T R I M ( C o u r s e A l p h a )   +   L T R I M ( C o u r s e N u m )   A S   k e e ,   c a m p u s ,   C o u r s e A l p h a ,   C o u r s e N u m ,   c o u r s e t i t l e ,   p r o p o s e r ,   c o u r s e d a t e ,    
                                             a u d i t d a t e ,   h i s t o r y i d ,   C o u r s e T y p e ,   P r o g r e s s  
 F R O M                   d b o . t b l C o u r s e  
 W H E R E           ( C o u r s e T y p e   =   ' C U R ' )   A N D   ( C o u r s e A l p h a   < >   ' ' )   A N D   ( N O T   ( C o u r s e A l p h a   I S   N U L L ) )   A N D   ( C o u r s e N u m   < >   ' ' )   A N D   ( N O T   ( C o u r s e N u m   I S   N U L L ) )   A N D   ( p r o p o s e r   < >   ' ' )   A N D    
                                             ( N O T   ( p r o p o s e r   I S   N U L L ) )   A N D   ( P r o g r e s s   =   ' A P P R O V E D ' )  
 O R D E R   B Y   c a m p u s ,   C o u r s e A l p h a ,   C o u r s e N u m  
  
 G O  
 / * * * * * *   O b j e c t :     V i e w   [ d b o ] . [ v w _ C U R p ]         S c r i p t   D a t e :   0 7 / 2 5 / 2 0 1 2   1 2 : 5 9 : 5 4   * * * * * * /  
 S E T   A N S I _ N U L L S   O N  
 G O  
 S E T   Q U O T E D _ I D E N T I F I E R   O N  
 G O  
 C R E A T E   V I E W   [ d b o ] . [ v w _ C U R p ]  
 A S  
 S E L E C T           R T R I M ( t i t l e )   +   ' _ '   +   C A S T ( d e g r e e i d   A S   v a r c h a r )   +   ' _ '   +   C A S T ( d i v i s i o n i d   A S   v a r c h a r )   A S   k e e ,   c a m p u s ,   h i s t o r y i d ,   t y p e ,   p r o g r e s s ,   d e g r e e i d ,   d i v i s i o n i d ,   e f f e c t i v e d a t e ,   t i t l e ,    
                                             p r o p o s e r ,   a u d i t d a t e ,   d a t e d e l e t e d ,   d a t e a p p r o v e d  
 F R O M                   d b o . t b l P r o g r a m s  
 W H E R E           ( t y p e   =   ' C U R ' )   A N D   ( p r o g r e s s   =   ' A P P R O V E D ' )  
  
 G O  
  
 / * * * * * *   O b j e c t :     V i e w   [ d b o ] . [ v w _ P R E ]         S c r i p t   D a t e :   0 7 / 2 5 / 2 0 1 2   1 2 : 5 9 : 5 4   * * * * * * /  
 S E T   A N S I _ N U L L S   O N  
 G O  
 S E T   Q U O T E D _ I D E N T I F I E R   O N  
 G O  
 C R E A T E   V I E W   [ d b o ] . [ v w _ P R E ]  
 A S  
 S E L E C T           T O P   ( 1 0 0 )   P E R C E N T   L T R I M ( c a m p u s )   +   L T R I M ( C o u r s e A l p h a )   +   L T R I M ( C o u r s e N u m )   A S   k e e ,   c a m p u s ,   C o u r s e A l p h a ,   C o u r s e N u m ,   c o u r s e t i t l e ,   p r o p o s e r ,   c o u r s e d a t e ,    
                                             a u d i t d a t e ,   h i s t o r y i d ,   C o u r s e T y p e ,   P r o g r e s s  
 F R O M                   d b o . t b l C o u r s e  
 W H E R E           ( C o u r s e T y p e   =   ' P R E ' )   A N D   ( C o u r s e A l p h a   < >   ' ' )   A N D   ( N O T   ( C o u r s e A l p h a   I S   N U L L ) )   A N D   ( C o u r s e N u m   < >   ' ' )   A N D   ( N O T   ( C o u r s e N u m   I S   N U L L ) )   A N D   ( p r o p o s e r   < >   ' ' )   A N D    
                                             ( N O T   ( p r o p o s e r   I S   N U L L ) )   A N D   ( P r o g r e s s   < >   ' A P P R O V E D ' )  
 O R D E R   B Y   c a m p u s ,   C o u r s e A l p h a ,   C o u r s e N u m  
  
 G O  
  
 / * * * * * *   O b j e c t :     V i e w   [ d b o ] . [ v w _ P R E p ]         S c r i p t   D a t e :   0 7 / 2 5 / 2 0 1 2   1 2 : 5 9 : 5 4   * * * * * * /  
 S E T   A N S I _ N U L L S   O N  
 G O  
 S E T   Q U O T E D _ I D E N T I F I E R   O N  
 G O  
 C R E A T E   V I E W   [ d b o ] . [ v w _ P R E p ]  
 A S  
 S E L E C T           R T R I M ( t i t l e )   +   ' _ '   +   C A S T ( d e g r e e i d   A S   v a r c h a r )   +   ' _ '   +   C A S T ( d i v i s i o n i d   A S   v a r c h a r )   A S   k e e ,   c a m p u s ,   h i s t o r y i d ,   t y p e ,   p r o g r e s s ,   d e g r e e i d ,   d i v i s i o n i d ,   e f f e c t i v e d a t e ,   t i t l e ,    
                                             p r o p o s e r ,   a u d i t d a t e ,   d a t e d e l e t e d ,   d a t e a p p r o v e d  
 F R O M                   d b o . t b l P r o g r a m s  
 W H E R E           ( t y p e   =   ' P R E ' )  
  
 G O  
 