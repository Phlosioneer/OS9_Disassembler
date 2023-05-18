 psect memchr_c,$0,$0,0,0,memchr
memchr: link.w a5,#0
 movem.l a2/d0-d1/d4-d6,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l 32(sp),d5
 moveq #0,d0
 move.b d4,d0
 move.l d0,d6
 bra.s L00026
L00018 moveq #0,d0
 move.b (a2),d0
 cmp.l d6,d0
 bne.s L00024
 move.l a2,d0
 bra.s L00030
L00024 addq.l #1,a2
L00026 move.l d5,d0
 subq.l #1,d5
 tst.l d0
 bne.s L00018
 moveq #0,d0
L00030 movem.l -16(a5),a2/d4-d6
 unlk a5
 rts 

 ends 

