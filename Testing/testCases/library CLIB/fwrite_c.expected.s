 psect fwrite_c,$0,$0,0,0,fwrite
fwrite: link.w A5,#0
 movem.l a2-a3/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 movea.l 36(sp),a3
 moveq #0,d4
 bra.s L00036
L00012 moveq #0,d5
 bra.s L0002a
L00016 move.l a3,d1
 move.b (a2)+,d0
 ext.w d0
 ext.l d0
 bsr.w putc
 btst.b #5,13(a3)
 bne.s L0003c
L0002a move.l d5,d0
 addq.l #1,d5
 cmp.l 4(sp),d0
 blt.s L00016
 addq.l #1,d4
L00036 cmp.l 32(sp),d4
 blt.s L00012
L0003c move.l d4,d0
 movem.l -16(a5),a2-a3/d4-d5
 unlk A5
 rts 

 ends 

