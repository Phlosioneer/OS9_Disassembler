 psect frexp_c,$0,$0,0,0,frexp
frexp: link.w A5,#0
 movem.l a2/d0-d1,-(sp)
 movea.l 20(sp),a2
 tst.l (sp)
 bne.s L00014
 clr.l (a2)
 bra.s L00030
L00014 move.w (sp),d0
 lsr.w #4,d0
 andi.w #2047,d0
 moveq #0,d1
 move.w d0,d1
 subi.l #1022,d1
 move.l d1,(a2)
 andi.w #-32753,(sp)
 ori.w #16352,(sp)
L00030 movem.l (sp),d0-d1
 movem.l -4(a5),a2
 unlk A5
 rts 

 ends 

