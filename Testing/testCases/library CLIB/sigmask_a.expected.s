 psect sigmask_a,0,0,0,0,sigmask

sigmask: link.w a5,#0
 move.l d1,-(sp)
 move.l d0,d1
 moveq #0,d0
 os9 F$SigMask
 bcs.s L00018
 moveq #0,d0
L00012 move.l (sp)+,d1
 unlk a5
 rts 
L00018 move.l d1,errno(a6)
 moveq #-1,d0
 bra.s L00012

 ends 

