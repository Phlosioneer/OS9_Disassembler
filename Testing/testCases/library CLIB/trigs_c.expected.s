 psect trigs_c,$0,$0,0,0,L00000
L00000 move.w d6,-(a6)
 or.l (a3)+,d2
 or.l -(a1),d3
 dc.w $2b9c
 dc.w $3fe0
 ori.b #0,d0
 dc.w $0
sin: movem.l d2-d3,-(sp)
 movem.l L00000(pc),d2-d3
 dc.w $4e40
 dc.w $0
 movem.l (sp)+,d2-d3
 rts 
cos: movem.l d2-d3,-(sp)
 movem.l L00000(pc),d2-d3
 dc.w $4e40
 dc.w $0
 movem.l (sp)+,d2-d3
 rts 
tan: movem.l d2-d3,-(sp)
 movem.l L00000(pc),d2-d3
 dc.w $4e40
 dc.w $0
 movem.l (sp)+,d2-d3
 rts 
asin: movem.l d2-d3,-(sp)
 movem.l L00000(pc),d2-d3
 dc.w $4e40
 dc.w $0
 movem.l (sp)+,d2-d3
 rts 
acos: movem.l d2-d3,-(sp)
 movem.l L00000(pc),d2-d3
 dc.w $4e40
 dc.w $0
 movem.l (sp)+,d2-d3
 rts 
atan: movem.l d2-d3,-(sp)
 movem.l L00000(pc),d2-d3
 dc.w $4e40
 dc.w $0
 movem.l (sp)+,d2-d3
 rts 
exp: movem.l d2-d3,-(sp)
 movem.l L00000(pc),d2-d3
 dc.w $4e40
 dc.w $0
 movem.l (sp)+,d2-d3
 rts 
log: movem.l d2-d3,-(sp)
 movem.l L00000(pc),d2-d3
 dc.w $4e40
 dc.w $0
 movem.l (sp)+,d2-d3
 rts 
log10: movem.l d2-d3,-(sp)
 movem.l L00000(pc),d2-d3
 dc.w $4e40
 dc.w $0
 movem.l (sp)+,d2-d3
 rts 
pow: movem.l d2-d5,-(sp)
 movem.l 20(sp),d2-d3
 movem.l L00000(pc),d4-d5
 dc.w $4e40
 dc.w $0
 movem.l (sp)+,d2-d5
 rts 
sqrt: movem.l d2-d3,-(sp)
 movem.l L00000(pc),d2-d3
 dc.w $4e40
 dc.w $0
 movem.l (sp)+,d2-d3
 rts 
floor: movem.l d2-d3,-(sp)
 tst.l d0
 bge.s L00108
 dc.w $4e40
 dc.w $0
 tst.l d2
 beq.s L0010c
 dc.w $4e40
 dc.w $0
 bra.s L0010c
L00108 dc.w $4e40
 dc.w $0
L0010c movem.l (sp)+,d2-d3
 rts 
ceil: movem.l d2-d3,-(sp)
 tst.l d0
 beq.s L00128
 bchg.l #31,d0
 bsr.s floor
 tst.l d0
 beq.s L00128
 bchg.l #31,d0
L00128 movem.l (sp)+,d2-d3
 rts 
fabs: bclr.l #31,d0
 rts 
modf: movem.l a0/d2-d3,-(sp)
 dc.w $4e40
 dc.w $0
 movea.l 16(sp),a0
 movem.l d0-d1,(a0)
 move.l d2,d0
 move.l d3,d1
 movem.l (sp)+,a0/d2-d3
 rts 
hypot: movem.l d2-d5,-(sp)
 movem.l 20(sp),d2-d3
 bclr.l #31,d0
 bclr.l #31,d2
 dc.w $4e40
 dc.w $0
 bmi.s L0016a
 exg d0,d2
 exg d1,d3
L0016a movem.l d2-d3,20(sp)
 tst.l d2
 bne.s L0017a
 move.l d2,d0
 move.l d3,d1
 bra.s L0019e
L0017a dc.w $4e40
 dc.w $0
 move.l d0,d2
 move.l d1,d3
 dc.w $4e40
 dc.w $0
 dc.w $4e40
 dc.w $0
 movem.l L00000(pc),d2-d3
 dc.w $4e40
 dc.w $0
 movem.l 20(sp),d2-d3
 dc.w $4e40
 dc.w $0
L0019e movem.l (sp)+,d2-d5
 rts 

 ends 

