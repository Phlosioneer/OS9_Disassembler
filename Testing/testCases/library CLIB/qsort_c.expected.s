 psect qsort_c,$0,$0,0,0,qsort

* D
 vsect 
D00000 ds.b 4
D00004 ds.b 4


 ends 

qsort: link.w A5,#0
 movem.l a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 movea.l 28(sp),a3
 move.l #-68,d0
 bsr.w _stkcheck
 move.l 24(sp),D00000(a6)
 move.l a3,D00004(a6)
 move.l 4(sp),d0
 subq.l #1,d0
 move.l D00000(a6),d1
 bsr.w _T$UMul
 add.l a2,d0
 move.l d0,d1
 move.l a2,d0
 bsr.s L00042
 movem.l -8(a5),a2-a3
 unlk A5
 rts 
L00042 link.w A5,#0
 movem.l a0/a2-a4/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l #-68,d0
 bsr.w _stkcheck
 bra.w L000ee
L0005c movea.l a2,a4
 move.l a3,d4
 move.l a3,d0
 sub.l a2,d0
 move.l D00000(a6),d1
 lsl.l #1,d1
 bsr.w _T$LDiv
 move.l D00000(a6),d1
 bsr.w _T$UMul
 add.l a2,d0
 move.l d0,d5
 bra.s L00082
L0007c move.l D00000(a6),d0
 adda.l d0,a4
L00082 move.l d5,d1
 move.l a4,d0
 movea.l D00004(a6),a0
 jsr (a0)
 tst.l d0
 blt.s L0007c
 bra.s L00096
L00092 sub.l D00000(a6),d4
L00096 move.l d4,d1
 move.l d5,d0
 movea.l D00004(a6),a0
 jsr (a0)
 tst.l d0
 blt.s L00092
 cmpa.l d4,a4
 bhi.s L000c8
 cmpa.l d4,a4
 bcc.s L000c0
 move.l d4,d1
 move.l a4,d0
 bsr.s L000fe
 cmp.l a4,d5
 bne.s L000ba
 move.l d4,d5
 bra.s L000c0
L000ba cmp.l d4,d5
 bne.s L000c0
 move.l a4,d5
L000c0 move.l D00000(a6),d0
 adda.l d0,a4
 sub.l d0,d4
L000c8 cmpa.l d4,a4
 bls.s L00082
 move.l a3,d0
 sub.l a4,d0
 move.l d4,d1
 sub.l a2,d1
 cmp.l d1,d0
 bge.s L000e4
 move.l a3,d1
 move.l a4,d0
 bsr.w L00042
 movea.l d4,a3
 bra.s L000ee
L000e4 move.l d4,d1
 move.l a2,d0
 bsr.w L00042
 movea.l a4,a2
L000ee cmpa.l a3,a2
 bcs.w L0005c
 movem.l -24(a5),a0/a2-a4/d4-d5
 unlk A5
 rts 
L000fe link.w A5,#0
 movem.l a2-a3/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l #-64,d0
 bsr.w _stkcheck
 move.l D00000(a6),d4
 bra.s L00120
L0011a move.b (a2),d5
 move.b (a3),(a2)+
 move.b d5,(a3)+
L00120 move.l d4,d0
 subq.l #1,d4
 tst.l d0
 bne.s L0011a
 movem.l -16(a5),a2-a3/d4-d5
 unlk A5
 rts 

 ends 

