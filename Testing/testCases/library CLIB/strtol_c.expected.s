 psect strtol_c,$0,$0,0,0,strtol
strtol: link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4-d6,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l 40(sp),d4
 moveq #0,d5
 moveq #0,d6
L00014 move.b (a2)+,d0
 ext.w d0
 ext.l d0
 lea _chcodes(a6),a0
 move.b (a0,d0.l),d0
 ext.w d0
 btst.l #4,d0
 bne.s L00014
 bra.s L00032
L0002c addq.l #1,d5
L0002e addq.l #1,a2
 bra.s L00042
L00032 move.b -(a2),d0
 ext.w d0
 cmpi.w #43,d0
 beq.s L0002e
 cmpi.w #45,d0
 beq.s L0002c
L00042 clr.l errno(a6)
 move.l d4,-(sp)
 move.l a3,d1
 move.l a2,d0
 bsr.w strtoul
 addq.l #4,sp
 move.l d0,d6
 cmpi.l #256,errno(a6)
 beq.s L00072
 tst.l d5
 beq.s L0006a
 cmpi.l #-2147483648,d6
 bhi.s L00072
L0006a cmpi.l #2147483647,d6
 bls.s L00090
L00072 tst.l d5
 beq.s L0007e
 move.l #-2147483648,d0
 bra.s L00084
L0007e move.l #2147483647,d0
L00084 move.l d0,d6
 move.l #256,errno(a6)
 bra.s L0009a
L00090 tst.l d5
 beq.s L0009a
 move.l d6,d0
 neg.l d0
 move.l d0,d6
L0009a move.l d6,d0
 movem.l -24(a5),a0/a2-a3/d4-d6
 unlk a5
 rts 

 ends 

