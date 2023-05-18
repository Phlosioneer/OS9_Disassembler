 psect memcmp_c,$0,$0,0,0,memcmp
memcmp: link.w a5,#0
 movem.l a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l 28(sp),d4
 bra.s L0002c
L00012 move.b (a2),d0
 cmp.b (a3),d0
 beq.s L00028
 move.b (a3),d0
 ext.w d0
 move.b (a2),d1
 ext.w d1
 sub.w d0,d1
 ext.l d1
 move.l d1,d0
 bra.s L00036
L00028 addq.l #1,a2
 addq.l #1,a3
L0002c move.l d4,d0
 subq.l #1,d4
 tst.l d0
 bne.s L00012
 moveq #0,d0
L00036 movem.l -12(a5),a2-a3/d4
 unlk a5
 rts 

 ends 

