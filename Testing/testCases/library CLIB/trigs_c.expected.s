 psect trigs_c,0,0,0,0,L00000

L00000 move.w d6,-(a6)
 or.l (a3)+,d2
 or.l -(a1),d3
 dc.w $2b9c
 dc.w $3fe0
 ori.b #$00,d0
 dc.w $0000
sin: movem.l d2-d3,-(sp)
 movem.l L00000(pc),d2-d3
 tcall #T$Math,#T$Sin
 movem.l (sp)+,d2-d3
 rts 
cos: movem.l d2-d3,-(sp)
 movem.l L00000(pc),d2-d3
 tcall #T$Math,#T$Cos
 movem.l (sp)+,d2-d3
 rts 
tan: movem.l d2-d3,-(sp)
 movem.l L00000(pc),d2-d3
 tcall #T$Math,#T$Tan
 movem.l (sp)+,d2-d3
 rts 
asin: movem.l d2-d3,-(sp)
 movem.l L00000(pc),d2-d3
 tcall #T$Math,#T$Asn
 movem.l (sp)+,d2-d3
 rts 
acos: movem.l d2-d3,-(sp)
 movem.l L00000(pc),d2-d3
 tcall #T$Math,#T$Acs
 movem.l (sp)+,d2-d3
 rts 
atan: movem.l d2-d3,-(sp)
 movem.l L00000(pc),d2-d3
 tcall #T$Math,#T$Atn
 movem.l (sp)+,d2-d3
 rts 
exp: movem.l d2-d3,-(sp)
 movem.l L00000(pc),d2-d3
 tcall #T$Math,#T$Exp
 movem.l (sp)+,d2-d3
 rts 
log: movem.l d2-d3,-(sp)
 movem.l L00000(pc),d2-d3
 tcall #T$Math,#T$Log
 movem.l (sp)+,d2-d3
 rts 
log10: movem.l d2-d3,-(sp)
 movem.l L00000(pc),d2-d3
 tcall #T$Math,#T$Log10
 movem.l (sp)+,d2-d3
 rts 
pow: movem.l d2-d5,-(sp)
 movem.l 20(sp),d2-d3
 movem.l L00000(pc),d4-d5
 tcall #T$Math,#T$Power
 movem.l (sp)+,d2-d5
 rts 
sqrt: movem.l d2-d3,-(sp)
 movem.l L00000(pc),d2-d3
 tcall #T$Math,#T$Sqrt
 movem.l (sp)+,d2-d3
 rts 
floor: movem.l d2-d3,-(sp)
 tst.l d0
 bge.s L00108
 tcall #T$Math,#T$DTrn
 tst.l d2
 beq.s L0010c
 tcall #T$Math,#T$DDec
 bra.s L0010c
L00108 tcall #T$Math,#T$DTrn
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
 tcall #T$Math,#T$DTrn
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
 tcall #T$Math,#T$DCmp
 bmi.s L0016a
 exg d0,d2
 exg d1,d3
L0016a movem.l d2-d3,20(sp)
 tst.l d2
 bne.s L0017a
 move.l d2,d0
 move.l d3,d1
 bra.s L0019e
L0017a tcall #T$Math,#T$DDiv
 move.l d0,d2
 move.l d1,d3
 tcall #T$Math,#T$DMul
 tcall #T$Math,#T$DInc
 movem.l L00000(pc),d2-d3
 tcall #T$Math,#T$Sqrt
 movem.l 20(sp),d2-d3
 tcall #T$Math,#T$DMul
L0019e movem.l (sp)+,d2-d5
 rts 

 ends 

