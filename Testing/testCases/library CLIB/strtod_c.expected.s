 psect strtod_c,0,0,0,0,strtod

strtod: link.w a5,#0
 movem.l a0/a2/d0-d1/d4-d5,-(sp)
 movea.l d1,a2
 lea -16(sp),sp
 moveq #0,d4
 clr.l 12(sp)
 clr.l 8(sp)
 moveq #1,d5
L0001a movea.l 16(sp),a0
 addq.l #1,16(sp)
 move.b (a0),d0
 ext.w d0
 ext.l d0
 lea _chcodes(a6),a0
 move.b (a0,d0.l),d0
 ext.w d0
 btst.l #4,d0
 bne.s L0001a
 bra.s L00060
L0003a addq.l #1,d4
L0003c addq.l #1,16(sp)
 bra.s L00084
L00042 movea.l 16(sp),a0
 move.b (a0),d0
 ext.w d0
 ext.l d0
 lea _chcodes(a6),a0
 move.b (a0,d0.l),d0
 ext.w d0
 btst.l #3,d0
 bne.s L00084
 subq.l #1,d5
 bra.s L00084
L00060 subq.l #1,16(sp)
 movea.l 16(sp),a0
 move.b (a0),d0
 ext.w d0
 cmpi.w #255,d0
 bhi.s L00042
 cmpi.b #43,d0
 beq.s L0003c
 cmpi.b #45,d0
 beq.s L0003a
 cmpi.b #46,d0
 bne.s L00042
L00084 tst.l d5
 beq.s L000c0
 bra.s L000a4
L0008a move.l 4(sp),12(sp)
 move.l (sp),8(sp)
 bra.s L000c0
L00096 move.l (sp),d0
 tcall T$Math1,T$UtoD
 movem.l d0-d1,8(sp)
 bra.s L000c0
L000a4 lea (sp),a0
 move.l a0,d1
 lea 16(sp),a0
 move.l a0,d0
 bsr.s L000ee
 cmpi.l #1,d0
 beq.s L00096
 cmpi.l #2,d0
 beq.s L0008a
L000c0 move.l a2,d0
 beq.s L000c8
 move.l 16(sp),(a2)
L000c8 tst.l d4
 beq.s L000dc
 movem.l 8(sp),d0-d1
 tcall T$Math1,T$DNeg
 movem.l d0-d1,8(sp)
L000dc movem.l 8(sp),d0-d1
 lea 16(sp),sp
 movem.l -16(a5),a0/a2/d4-d5
 bra.s L00112
L000ee link.w a5,#0
 movem.l a0-a2,-(sp)
 movea.l d0,a2
 movea.l (a2),a0
 movea.l d1,a1
 tcall T$Math1,T$AtoN
 movem.l d0-d1,(a1)
 bvc.s L0010a
 moveq #2,d0
 bra.s L0010c
L0010a moveq #1,d0
L0010c move.l a0,(a2)
 movem.l (sp)+,a0-a2
L00112 unlk a5
 rts 

 ends 

