 psect fread_c,0,0,0,0,fread

fread: link.w a5,#0
 movem.l a2-a3/d0-d1/d4-d6,-(sp)
 movea.l d0,a2
 movea.l 40(sp),a3
 moveq #0,d5
 bra.s L0002e
L00012 move.l 4(sp),d4
 bra.s L00028
L00018 move.l a3,d0
 bsr.w getc
 move.l d0,d6
 moveq #255,d1
 cmp.l d0,d1
 beq.s L00034
 move.b d6,(a2)+
L00028 subq.l #1,d4
 bge.s L00018
 addq.l #1,d5
L0002e cmp.l 36(sp),d5
 blt.s L00012
L00034 move.l d5,d0
 movem.l -20(a5),a2-a3/d4-d6
 unlk a5
 rts 

 ends 

