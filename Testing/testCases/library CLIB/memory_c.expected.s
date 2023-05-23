 psect memory_c,0,0,0,0,L00000


* D
 vsect 
D00000 ds.b 4
D00004 ds.b 4


 ends 


* _
 vsect 
_00000 dc.l _00000
 dc.l $00000000
_00008 dc.l $00000000
 dc.l $00000000
_00010 dc.l $00000000
_00014 dc.l $00000200


 ends 

L00000 link.w a5,#0
 movem.l a2-a4/d0-d1,-(sp)
 movea.l d0,a2
 lea _00008(a6),a4
 movea.l _00008(a6),a3
 bra.s L0007c
L00014 move.l 4(a2),d0
 lsl.l #3,d0
 add.l a2,d0
 cmp.l a3,d0
 bne.s L00050
 move.l a2,(a4)
 move.l (a3),(a2)
 move.l 4(a3),d0
 add.l d0,4(a2)
 moveq #8,d1
 move.l a3,d0
 bsr.w L004bc
 move.l 4(a4),d0
 lsl.l #3,d0
 add.l a4,d0
 cmp.l a2,d0
 bne.s L00084
 move.l 4(a2),d0
 add.l d0,4(a4)
 move.l (a2),(a4)
 moveq #8,d1
 move.l a3,d0
 bra.s L00068
L00050 move.l 4(a3),d0
 lsl.l #3,d0
 add.l a3,d0
 cmp.l a2,d0
 bne.s L0006e
 move.l 4(a2),d0
 add.l d0,4(a3)
 moveq #8,d1
 move.l a2,d0
L00068 bsr.w L004bc
 bra.s L00084
L0006e cmpa.l a2,a3
 bcc.s L00078
 move.l a2,(a4)
 move.l a3,(a2)
 bra.s L00084
L00078 movea.l a3,a4
 movea.l (a3),a3
L0007c move.l a3,d0
 bne.s L00014
 move.l a2,(a4)
 clr.l (a2)
L00084 movem.l -16(a5),a2-a4/d1
 unlk a5
 rts 
L0008e link.w a5,#0
 movem.l a2/d0-d1/d4,-(sp)
 move.l d0,d4
 addq.l #1,d4
 cmp.l D00000(a6),d4
 bcc.s L000a4
 move.l D00000(a6),d4
L000a4 move.l d4,d0
 lsl.l #3,d0
 bsr.w _srqmem
 movea.l d0,a2
 moveq #255,d1
 cmp.l d0,d1
 bne.s L000b8
 moveq #0,d0
 bra.s L000dc
L000b8 move.l _srqsiz(a6),d0
 lsr.l #3,d0
 move.l d0,4(a2)
 move.l a2,d0
 bsr.w L00000
 move.l _srqsiz(a6),d0
 subq.l #8,d0
 move.l d0,d1
 move.l a2,d0
 addq.l #8,d0
 bsr.w L004bc
 move.l _00010(a6),d0
L000dc movem.l -12(a5),a2/d1/d4
 unlk a5
 rts 
_lmalloc: link.w a5,#0
 movem.l a2-a3/d0/d4-d5,-(sp)
 move.l d0,d4
 move.l d4,d0
 addq.l #7,d0
 lsr.l #3,d0
 move.l d0,d5
 tst.l _00010(a6)
 bne.s L00100
 bsr.s L0014c
L00100 movea.l _00010(a6),a3
 bra.s L0011e
L00106 cmpa.l _00010(a6),a2
 bne.s L0011c
 move.l d5,d0
 bsr.w L0008e
 movea.l d0,a2
 tst.l d0
 bne.s L0011c
 moveq #0,d0
 bra.s L00142
L0011c movea.l a2,a3
L0011e movea.l (a3),a2
 cmp.l 4(a2),d5
 bhi.s L00106
 cmp.l 4(a2),d5
 bne.s L00130
 move.l (a2),(a3)
 bra.s L0013c
L00130 sub.l d5,4(a2)
 move.l 4(a2),d0
 lsl.l #3,d0
 adda.l d0,a2
L0013c move.l a3,_00010(a6)
 move.l a2,d0
L00142 movem.l -16(a5),a2-a3/d4-d5
 unlk a5
 rts 
L0014c link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 subq.l #4,sp
 lea _00000(a6),a0
 move.l a0,_00010(a6)
 moveq #4,d1
 moveq #124,d0
 bsr.w _getsys
 bge.s L0016a
 addq.l #7,d0
L0016a asr.l #3,d0
 move.l d0,(sp)
 cmp.l _00014(a6),d0
 bls.s L00178
 move.l (sp),_00014(a6)
L00178 move.l _00014(a6),d0
 move.l d0,D00004(a6)
 move.l d0,D00000(a6)
 addq.l #4,sp
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
malloc: link.w a5,#0
 movem.l a2/d0/d4,-(sp)
 move.l d0,d4
 tst.l d4
 bne.s L001a2
 moveq #0,d0
 bra.s L001c4
L001a2 addq.l #8,d4
 move.l d4,d0
 bsr.w _lmalloc
 movea.l d0,a2
 tst.l d0
 beq.s L001c2
 move.l d4,d0
 addq.l #7,d0
 lsr.l #3,d0
 move.l d0,4(a2)
 move.l #-2023380019,(a2)
 addq.l #8,a2
L001c2 move.l a2,d0
L001c4 movem.l -8(a5),a2/d4
 unlk a5
 rts 
_lrealloc: link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l 48(sp),d5
 lea -12(sp),sp
 move.l a2,d0
 bne.s L001f0
 move.l d4,d0
 bsr.w _lmalloc
 bra.w L00328
L001f0 tst.l d4
 bne.s L001fe
 move.l d5,d1
 move.l a2,d0
 bsr.w _lfree
 bra.s L0020a
L001fe move.l d5,d1
 move.l a2,d0
 bsr.w L0054c
 tst.l d0
 bne.s L00210
L0020a moveq #0,d0
 bra.w L00328
L00210 movea.l a2,a3
 move.l d5,d0
 addq.l #7,d0
 lsr.l #3,d0
 move.l d0,d7
 move.l d4,d0
 addq.l #7,d0
 lsr.l #3,d0
 move.l d0,8(sp)
 cmp.l 8(sp),d7
 bcs.s L0024c
 cmp.l 8(sp),d7
 bls.w L002c4
 move.l d7,d0
 sub.l 8(sp),d0
 lsl.l #3,d0
 move.l d0,d1
 move.l 8(sp),d0
 lsl.l #3,d0
 add.l a3,d0
 bsr.w _lfree
 bra.w L002c4
L0024c movea.l _00010(a6),a4
 bra.s L00254
L00252 movea.l (a4),a4
L00254 cmpa.l a4,a3
 bls.s L0025e
 cmpa.l (a4),a3
 bcs.s L00266
 bra.s L00262
L0025e cmpa.l (a4),a3
 bcc.s L00252
L00262 cmpa.l (a4),a4
 bcs.s L00252
L00266 move.l (a4),d6
 move.l d7,d0
 lsl.l #3,d0
 add.l a3,d0
 cmp.l d6,d0
 bne.s L002c8
 movea.l d6,a0
 move.l 4(a0),d0
 add.l d7,d0
 cmp.l 8(sp),d0
 bcs.s L002c8
 movea.l d6,a0
 move.l 4(a0),d0
 add.l d7,d0
 cmp.l 8(sp),d0
 bls.s L002bc
 movea.l d6,a0
 move.l 8(sp),d0
 lsl.l #3,d0
 move.l (a0),(a3,d0.l)
 movea.l d6,a0
 move.l 4(a0),d0
 add.l d7,d0
 sub.l 8(sp),d0
 move.l 8(sp),d1
 lsl.l #3,d1
 move.l d0,4(a3,d1.l)
 move.l 8(sp),d0
 lsl.l #3,d0
 add.l a3,d0
 move.l d0,(a4)
 bra.s L002c0
L002bc movea.l d6,a0
 move.l (a0),(a4)
L002c0 move.l a4,_00010(a6)
L002c4 move.l a3,d0
 bra.s L00328
L002c8 move.l (a3),(sp)
 move.l 4(a3),4(sp)
 move.l d5,d1
 move.l a3,d0
 bsr.w L004bc
 movea.l d0,a4
 move.l d4,d0
 bsr.w _lmalloc
 move.l d0,d6
 beq.s L0031c
 movea.l d6,a0
 move.l (sp),(a0)
 move.l 4(sp),4(a0)
 move.l d7,d0
 subq.l #1,d0
 lsl.l #3,d0
 move.l d0,-(sp)
 move.l a3,d0
 addq.l #8,d0
 move.l d0,d1
 move.l d6,d0
 addq.l #8,d0
 bsr.w memcpy
 addq.l #4,sp
 move.l a4,d0
 beq.s L00326
 cmpa.l d6,a4
 bcs.s L00320
 move.l 8(sp),d0
 lsl.l #3,d0
 add.l d6,d0
 cmp.l a4,d0
 bhi.s L00326
 bra.s L00320
L0031c move.l a4,d0
 beq.s L00326
L00320 move.l a4,d0
 bsr.w L0061e
L00326 move.l d6,d0
L00328 lea 12(sp),sp
 movem.l -32(a5),a0/a2-a4/d4-d7
 unlk a5
 rts 
realloc: link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l a2,d0
 bne.s L0034e
 move.l d4,d0
 bsr.w malloc
 bra.s L00392
L0034e move.l a2,d0
 btst.l #0,d0
 bne.s L00366
 move.l a2,d0
 subq.l #8,d0
 movea.l d0,a3
 movea.l d0,a0
 cmpi.l #-2023380019,(a0)
 beq.s L0036a
L00366 moveq #0,d0
 bra.s L00392
L0036a move.l 4(a3),d0
 lsl.l #3,d0
 move.l d0,-(sp)
 addq.l #8,d4
 move.l d4,d1
 move.l a3,d0
 bsr.w _lrealloc
 addq.l #4,sp
 movea.l d0,a3
 tst.l d0
 beq.s L00390
 move.l d4,d0
 addq.l #7,d0
 lsr.l #3,d0
 move.l d0,4(a3)
 addq.l #8,a3
L00390 move.l a3,d0
L00392 movem.l -16(a5),a0/a2-a3/d4
 unlk a5
 rts 
_lfree: link.w a5,#0
 movem.l a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l d4,d1
 move.l a2,d0
 bsr.w L0054c
 tst.l d0
 beq.s L003c8
 move.l d4,d1
 move.l a2,d0
 bsr.w L004bc
 movea.l d0,a3
 tst.l d0
 beq.s L003c8
 move.l a3,d0
 bsr.w L0061e
L003c8 movem.l -12(a5),a2-a3/d4
 unlk a5
 rts 
free: link.w a5,#0
 movem.l a0/a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 move.l a2,d0
 beq.s L00404
 move.l a2,d0
 btst.l #0,d0
 bne.s L00404
 move.l a2,d0
 subq.l #8,d0
 movea.l d0,a3
 movea.l d0,a0
 cmpi.l #-2023380019,(a0)
 bne.s L00404
 move.l 4(a3),d0
 lsl.l #3,d0
 move.l d0,d1
 move.l a3,d0
 bsr.s _lfree
L00404 movem.l -16(a5),a0/a2-a3/d1
 unlk a5
 rts 
_freemin: link.w a5,#0
 movem.l d0-d1/d4,-(sp)
 move.l d0,d4
 tst.l _00010(a6)
 bne.s L00422
 bsr.w L0014c
L00422 tst.l d4
 bge.s L00430
 move.l #-2147483648,D00004(a6)
 bra.s L00462
L00430 tst.l d4
 bge.s L00436
 addq.l #7,d4
L00436 asr.l #3,d4
 cmp.l _00014(a6),d4
 bcs.s L00462
 move.l d4,d0
 add.l _00014(a6),d0
 subq.l #1,d0
 move.l _00014(a6),d1
 bsr.w _T$UDiv
 move.l d0,D00004(a6)
 move.l _00014(a6),d0
 move.l D00004(a6),d1
 bsr.w _T$UMul
 move.l d0,D00004(a6)
L00462 movem.l -8(a5),d1/d4
 unlk a5
 rts 
_mallocmin: link.w a5,#0
 movem.l d0-d1/d4,-(sp)
 move.l d0,d4
 tst.l _00010(a6)
 bne.s L00480
 bsr.w L0014c
L00480 tst.l d4
 bge.s L00486
 addq.l #7,d4
L00486 asr.l #3,d4
 cmp.l _00014(a6),d4
 bcs.s L004b2
 move.l d4,d0
 add.l _00014(a6),d0
 subq.l #1,d0
 move.l _00014(a6),d1
 bsr.w _T$UDiv
 move.l d0,D00000(a6)
 move.l _00014(a6),d0
 move.l D00000(a6),d1
 bsr.w _T$UMul
 move.l d0,D00000(a6)
L004b2 movem.l -8(a5),d1/d4
 unlk a5
 rts 
L004bc link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
 movea.l a2,a4
 move.l d4,d0
 addq.l #7,d0
 lsr.l #3,d0
 move.l d0,d4
 movea.l _00010(a6),a3
 bra.s L004da
L004d8 movea.l (a3),a3
L004da cmpa.l a3,a2
 bls.s L004e4
 cmpa.l (a3),a2
 bcs.s L004ec
 bra.s L004e8
L004e4 cmpa.l (a3),a2
 bcc.s L004d8
L004e8 cmpa.l (a3),a3
 bcs.s L004d8
L004ec move.l d4,d0
 lsl.l #3,d0
 add.l a2,d0
 cmp.l (a3),d0
 bne.s L00508
 movea.l (a3),a0
 move.l 4(a0),d0
 add.l d4,d0
 move.l d0,4(a2)
 movea.l (a3),a0
 move.l (a0),(a2)
 bra.s L0050e
L00508 move.l d4,4(a2)
 move.l (a3),(a2)
L0050e move.l 4(a3),d0
 lsl.l #3,d0
 add.l a3,d0
 cmp.l a2,d0
 bne.s L00528
 move.l 4(a2),d0
 add.l d0,4(a3)
 move.l (a2),(a3)
 movea.l a3,a4
 bra.s L0052a
L00528 move.l a2,(a3)
L0052a move.l a3,_00010(a6)
 move.l D00004(a6),d0
 subq.l #1,d0
 cmp.l 4(a4),d0
 bhi.s L0053e
 movea.l a4,a0
 bra.s L00540
L0053e suba.l a0,a0
L00540 move.l a0,d0
 movem.l -20(a5),a0/a2-a4/d4
 unlk a5
 rts 
L0054c link.w a5,#0
 movem.l a2-a4/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
 tst.l _00010(a6)
 beq.s L00596
 move.l a2,d0
 beq.s L00596
 move.l a2,d0
 btst.l #0,d0
 bne.s L00596
 move.l d4,d0
 addq.l #7,d0
 lsr.l #3,d0
 lsl.l #3,d0
 add.l a2,d0
 movea.l d0,a4
 movea.l _00008(a6),a3
 bra.s L00592
L0057c cmpa.l a3,a2
 bls.s L00590
 move.l 4(a3),d0
 lsl.l #3,d0
 add.l a3,d0
 cmp.l a4,d0
 bcs.s L00590
 moveq #1,d0
 bra.s L00598
L00590 movea.l (a3),a3
L00592 move.l a3,d0
 bne.s L0057c
L00596 moveq #0,d0
L00598 movem.l -16(a5),a2-a4/d4
 unlk a5
 rts 
calloc: link.w a5,#0
 movem.l a2/d0-d2/d4-d6,-(sp)
 move.l d0,d4
 move.l d1,d5
 moveq #1,d1
 move.l d1,d2
 move.l d4,d0
 move.l d5,d1
 bsr.w _T$UMul
 addq.l #8,d0
 move.l d0,d6
 move.l d2,d1
 bsr.s _lcalloc
 movea.l d0,a2
 tst.l d0
 beq.s L005da
 move.l d6,d0
 addq.l #7,d0
 lsr.l #3,d0
 move.l d0,4(a2)
 move.l #-2023380019,(a2)
 addq.l #8,a2
L005da move.l a2,d0
 movem.l -20(a5),a2/d2/d4-d6
 unlk a5
 rts 
_lcalloc: link.w a5,#0
 movem.l a2/d0-d1/d4-d6,-(sp)
 move.l d0,d4
 move.l d1,d5
 move.l d4,d0
 move.l d5,d1
 bsr.w _T$UMul
 move.l d0,d6
 bsr.w _lmalloc
 movea.l d0,a2
 tst.l d0
 beq.s L00612
 move.l d6,-(sp)
 moveq #0,d1
 move.l a2,d0
 bsr.w memset
 addq.l #4,sp
L00612 move.l a2,d0
 movem.l -16(a5),a2/d4-d6
 unlk a5
 rts 
L0061e link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l 4(a2),d0
 addq.l #1,d0
 cmp.l -4(a2),d0
 bne.s L00684
 move.l a2,d0
 subq.l #8,d0
 movea.l d0,a4
 lea _00008(a6),a0
 move.l a0,d4
 movea.l _00008(a6),a3
 bra.s L0064e
L00646 cmpa.l a4,a3
 beq.s L00652
 move.l a3,d4
 movea.l (a3),a3
L0064e move.l a3,d0
 bne.s L00646
L00652 move.l a3,d0
 beq.s L00684
 movea.l d4,a0
 move.l (a3),(a0)
 move.l _00010(a6),d4
 bra.s L00664
L00660 movea.l d4,a0
 move.l (a0),d4
L00664 movea.l d4,a0
 cmpa.l (a0),a2
 bne.s L00660
 cmpa.l _00010(a6),a2
 bne.s L00674
 move.l d4,_00010(a6)
L00674 movea.l d4,a0
 move.l (a2),(a0)
 move.l a3,d1
 move.l 4(a3),d0
 lsl.l #3,d0
 bsr.w _srtmem
L00684 movem.l -24(a5),a0/a2-a4/d1/d4
 unlk a5
 rts 

 ends 

