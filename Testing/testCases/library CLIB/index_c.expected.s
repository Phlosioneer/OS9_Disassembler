 psect index_c,$0,$0,0,0,index
index: link.w a5,#0
 movem.l a2/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
L0000c cmp.b (a2),d4
 bne.s L00014
 move.l a2,d0
 bra.s L0001a
L00014 tst.b (a2)+
 bne.s L0000c
 moveq #0,d0
L0001a movem.l -8(a5),a2/d4
 unlk a5
 rts 
rindex: link.w a5,#0
 movem.l a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
 suba.l a3,a3
L00032 cmp.b (a2),d4
 bne.s L00038
 movea.l a2,a3
L00038 tst.b (a2)+
 bne.s L00032
 move.l a3,d0
 movem.l -12(a5),a2-a3/d4
 unlk a5
 rts 

 ends 

