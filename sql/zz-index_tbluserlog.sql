/ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -  
 / *   v w _ u s e r l o g  
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - * /  
 C R E A T E   V I E W   [ d b o ] . [ v w _ u s e r l o g ]  
 A S  
 S E L E C T           i d ,   u s e r i d ,   s c r i p t ,   a c t i o n ,   a l p h a ,   n u m ,   d a t e t i m e ,   c a m p u s ,   h i s t o r y i d  
 F R O M                   t b l U s e r L o g  
 U N I O N  
 S E L E C T           i d ,   u s e r i d ,   s c r i p t ,   a c t i o n ,   a l p h a ,   n u m ,   d a t e t i m e ,   c a m p u s ,   h i s t o r y i d  
 F R O M                   t b l U s e r L o g 2  
  
  
 I F   E X I S T S   ( S E L E C T   n a m e   F R O M   s y s . i n d e x e s  
                         W H E R E   n a m e   =   N ' P K _ t b l U s e r L o g _ C A N ' )  
         D R O P   I N D E X   P K _ t b l U s e r L o g _ C A N   O N   t b l u s e r l o g   ;  
 G O  
 C R E A T E   N O N C L U S T E R E D   I N D E X   P K _ t b l U s e r L o g _ C A N  
         O N   t b l u s e r l o g   ( c a m p u s ,   a l p h a ,   n u m ,   [ d a t e t i m e ] ) ;  
 G O  
  
 I F   E X I S T S   ( S E L E C T   n a m e   F R O M   s y s . i n d e x e s  
                         W H E R E   n a m e   =   N ' P K _ t b l U s e r L o g _ c a m p u s _ k i x ' )  
         D R O P   I N D E X   P K _ t b l U s e r L o g _ c a m p u s _ k i x   O N   t b l u s e r l o g   ;  
 G O  
 C R E A T E   N O N C L U S T E R E D   I N D E X   P K _ t b l U s e r L o g _ c a m p u s _ k i x  
         O N   t b l u s e r l o g   ( c a m p u s ,   h i s t o r y i d ,   [ d a t e t i m e ] ) ;  
 G O  
  
 I F   E X I S T S   ( S E L E C T   n a m e   F R O M   s y s . i n d e x e s  
                         W H E R E   n a m e   =   N ' P K _ t b l U s e r L o g 2 _ C A N ' )  
         D R O P   I N D E X   P K _ t b l U s e r L o g 2 _ C A N   O N   t b l u s e r l o g 2   ;  
 G O  
 C R E A T E   N O N C L U S T E R E D   I N D E X   P K _ t b l U s e r L o g 2 _ C A N  
         O N   t b l u s e r l o g 2   ( c a m p u s ,   a l p h a ,   n u m ,   [ d a t e t i m e ] ) ;  
 G O  
  
 I F   E X I S T S   ( S E L E C T   n a m e   F R O M   s y s . i n d e x e s  
                         W H E R E   n a m e   =   N ' P K _ t b l U s e r L o g 2 _ c a m p u s _ k i x ' )  
         D R O P   I N D E X   P K _ t b l U s e r L o g 2 _ c a m p u s _ k i x   O N   t b l u s e r l o g 2   ;  
 G O  
 C R E A T E   N O N C L U S T E R E D   I N D E X   P K _ t b l U s e r L o g 2 _ c a m p u s _ k i x  
         O N   t b l u s e r l o g 2   ( c a m p u s ,   h i s t o r y i d ,   [ d a t e t i m e ] ) ;  
 