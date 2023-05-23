 psect defdrive_c,0,0,0,0,defdrive

defdrive: link.w a5,#0
 movem.l a0/d0,-(sp)
 lea L00018(pc),a0
 move.l a0,d0
 movem.l -4(a5),a0
 unlk a5
 rts 
L00018 move.l -(a4),25600(sp)

 ends 

