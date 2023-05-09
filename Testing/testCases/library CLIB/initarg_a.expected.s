 psect initarg_a,$0,$0,0,0,$0200
_initarg: movea.l (sp)+,a5
L00002 subq.l #1,d5
 bcs.s L00068
 move.b (a0)+,d0
 beq.s L00002
 cmpi.b #13,d0
 beq.s L00068
 cmpi.b #32,d0
 beq.s L00002
 cmpi.b #9,d0
 beq.s L00002
 cmpi.b #44,d0
 beq.s L00002
 addq.l #1,d2
 cmpi.b #34,d0
 beq.s L0005a
 cmpi.b #39,d0
 beq.s L0005a
 pea -1(a0)
L00034 subq.l #1,d5
 bcs.s L00068
 move.b (a0)+,d0
 beq.s L00002
 cmpi.b #13,d0
 beq.s L00054
 cmpi.b #32,d0
 beq.s L00054
 cmpi.b #9,d0
 beq.s L00054
 cmpi.b #44,d0
 bne.s L00034
L00054 clr.b -1(a0)
 bra.s L00002
L0005a pea (a0)
L0005c subq.l #1,d5
 bcs.s L00068
 move.b (a0)+,d1
 cmp.b d1,d0
 bne.s L0005c
 bra.s L00054
L00068 movea.l sp,a0
 pea (sp)
 move.l d2,-(sp)
 subq.l #1,d2
 beq.s L00082
 asl.l #2,d2
L00074 move.l (a0,d2.l),d0
 move.l (a0),(a0,d2.l)
 move.l d0,(a0)+
 subq.l #8,d2
 bhi.s L00074
L00082 jmp (a5)

 ends 

