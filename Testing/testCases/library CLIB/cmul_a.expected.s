 psect cmul_a,0,0,1,0,_T$UMul

_T$UMul: movem.l d2-d4,-(sp)
 move.l d0,d2
 move.l d0,d3
 swap d3
 move.l d1,d4
 swap d4
 mulu.w d1,d0
 mulu.w d3,d1
 mulu.w d4,d2
 mulu.w d4,d3
 swap d0
 add.w d1,d0
 moveq #0,d4
 addx.l d4,d3
 add.w d2,d0
 addx.l d4,d3
 swap d0
 clr.w d1
 swap d1
 clr.w d2
 swap d2
 add.l d2,d1
 add.l d3,d1
 tst.l d0
 movem.l (sp)+,d2-d4
 rts 
_T$LDiv: move.l d2,-(sp)
 moveq #0,d2
 tst.l d0
 bpl.s L00044
 neg.l d0
 moveq #3,d2
L00044 tst.l d1
 bpl.s L0004e
 neg.l d1
 eori.b #$01,d2
L0004e bsr.s _T$UDiv
 lsr.b #1,d2
 bcc.s L00056
 neg.l d0
L00056 lsr.b #1,d2
 bcc.s L0005c
 neg.l d1
L0005c move.l (sp)+,d2
 tst.l d0
 rts 
_T$LMod: bsr.s _T$LDiv
 exg d0,d1
 tst.l d0
 rts 
_T$UMod: bsr.s _T$UDiv
 exg d0,d1
 tst.l d0
 rts 
_T$UDiv: movem.l d2-d4,-(sp)
 move.l d1,d2
 bne.s L00080
 divs.w #0,d0
 bra.s L000ee
L00080 subq.l #1,d1
 beq.s L000ee
 move.l d1,d4
 move.l d0,d1
 cmp.l d1,d2
 bcs.s L00098
 beq.s L00092
 moveq #0,d0
 bra.s L000ee
L00092 moveq #1,d0
 sub.l d2,d1
 bra.s L000ee
L00098 move.l d2,d3
 bmi.s L00092
 and.l d4,d3
 bne.s L000b2
 lsr.l #1,d2
 moveq #255,d3
L000a4 lsr.l #1,d2
 dbcs d3,L000a4
 neg.l d3
 lsr.l d3,d0
 and.l d4,d1
 bra.s L000ee
L000b2 moveq #0,d0
 moveq #255,d3
L000b6 asl.l #1,d2
 bpl.s L000c0
 cmp.l d1,d2
 bhi.s L000c8
 bra.s L000cc
L000c0 cmp.l d1,d2
 dbcc d3,L000b6
 beq.s L000cc
L000c8 addq.l #1,d3
 lsr.l #1,d2
L000cc neg.l d3
 bra.s L000d4
L000d0 asl.l #1,d0
 lsr.l #1,d2
L000d4 sub.l d2,d1
 bcs.s L000e8
L000d8 addq.l #1,d0
 dbf d3,L000d0
 bra.s L000ee
L000e0 asl.l #1,d0
 lsr.l #1,d2
 add.l d2,d1
 bcs.s L000d8
L000e8 dbf d3,L000e0
 add.l d2,d1
L000ee movem.l (sp)+,d2-d4
 tst.l d0
 rts 

 ends 

