 psect printf_c,0,0,0,0,printf


* D
 vsect 
D00000 ds.b 512
D00200 ds.b 1
D00201 ds.b 1
D00202 ds.b 1
D00203 ds.b 1
D00204 ds.b 1
D00205 ds.b 1
D00206 ds.b 1
D00207 ds.b 1
D00208 ds.b 4
D0020c ds.b 4
D00210 ds.b 4
D00214 ds.b 4
D00218 ds.b 10
D00222 ds.b 8


 ends 


* _
 vsect 
_00000 dc.l $00000000
 dc.l $00000000
 dc.l L00524
 dc.l L00614
 dc.l L00836
 dc.l L00896
 dc.l L008ec
 dc.l $00000000
 dc.l L00614
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
 dc.l L00614
 dc.l L005be
 dc.l L00662
 dc.l $00000000
 dc.l $00000000
 dc.l L004ec
 dc.l $00000000
 dc.l L00662
 dc.l $00000000
 dc.l $00000000
 dc.l L0054a
 dc.l $00000000
 dc.l $00000000


 ends 

printf: link.w a5,#0
L00001 equ *-3
 movem.l a0/d0-d1/d4,-(sp)
 move.l #-76,d0
 bsr.w _stkcheck
L0000f equ *-3
 lea $1c+_iob(a6),a0
 move.l a0,D00214(a6)
 pea 24(sp)
 pea 8(sp)
 move.l 8(sp),d1
 lea L003d4(pc),a0
 move.l a0,d0
 bsr.w L000d0
 addq.l #8,sp
 move.l d0,d4
 btst.b #5,$29+_iob(a6)
 beq.s L00040
 moveq #-1,d0
 bra.s L00042
L00040 move.l d4,d0
L00042 movem.l -8(a5),a0/d4
 unlk a5
 rts 
fprintf: link.w a5,#0
 movem.l a0/d0-d1/d4,-(sp)
 move.l #-76,d0
 bsr.w _stkcheck
 move.l (sp),D00214(a6)
 pea 24(sp)
 clr.l -(sp)
 move.l 12(sp),d1
 lea L003d4(pc),a0
 move.l a0,d0
 bsr.s L000d0
 addq.l #8,sp
 move.l d0,d4
 movea.l (sp),a0
 btst.b #5,13(a0)
 beq.s L00086
 moveq #-1,d0
 bra.s L00088
L00086 move.l d4,d0
L00088 movem.l -8(a5),a0/d4
 unlk a5
 rts 
sprintf: link.w a5,#0
 movem.l a0/d0-d1/d4,-(sp)
 move.l #-76,d0
 bsr.w _stkcheck
 move.l (sp),D00214(a6)
 pea 24(sp)
 clr.l -(sp)
 move.l 12(sp),d1
 lea L00474(pc),a0
 move.l a0,d0
 bsr.s L000d0
 addq.l #8,sp
 move.l d0,d4
 movea.l D00214(a6),a0
 clr.b (a0)
 move.l d4,d0
 movem.l -8(a5),a0/d4
 unlk a5
 rts 
L000d0 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l #-78,d0
 bsr.w _stkcheck
 lea -10(sp),sp
 tst.l 58(sp)
 beq.s L000f4
 moveq #1,d0
 bra.s L000f6
L000f4 moveq #0,d0
L000f6 move.b d0,1(sp)
 beq.s L00102
 movea.l 58(sp),a0
 bra.s L00106
L00102 movea.l 62(sp),a0
L00106 movea.l a0,a4
 moveq #0,d0
 move.l d0,d4
 move.l d0,6(sp)
 bra.w L0039a
L00114 moveq #37,d0
 cmp.l d5,d0
 beq.s L0012a
 tst.l d4
 bne.s L00124
 move.l a3,d0
 subq.l #1,d0
 move.l d0,d7
L00124 addq.l #1,d4
 bra.w L0039a
L0012a tst.l d4
 ble.s L00148
 clr.b D00201(a6)
 moveq #0,d0
 move.l d0,D0020c(a6)
 move.l d0,D00208(a6)
 move.l d4,d1
 move.l d7,d0
 jsr (a2)
 add.l d0,6(sp)
 moveq #0,d4
L00148 moveq #0,d0
 move.b d0,D00204(a6)
 move.b d0,D00201(a6)
 move.b d0,D00200(a6)
 move.b d0,D00205(a6)
 move.b d0,D00202(a6)
 move.b d0,D00203(a6)
 moveq #32,d1
 move.b d1,D00207(a6)
 move.b d1,D00206(a6)
 move.l d0,D0020c(a6)
 move.l d0,D00208(a6)
 bra.s L0019c
 move.b #1,D00203(a6)
 bra.s L0019c
 move.b #1,D00201(a6)
 bra.s L0019c
 move.b #1,D00202(a6)
 bra.s L0019c
 move.b #48,D00207(a6)
 bra.s L0019c
 move.b #1,D00204(a6)
L0019c move.b (a3)+,d0
 ext.w d0
 ext.l d0
 move.l d0,d5
 subi.l #32,d0
 cmpi.l #16,d0
 bhi.s L001de
 add.w d0,d0
 move.w L001bc(pc,d0.w),d0
 jmp L001bc(pc,d0.w)
L001bc dc.w $ffba
 ori.b #$22,-(a2)
 dc.w $ffda
 ori.b #$22,-(a2)
 ori.b #$22,-(a2)
 ori.b #$22,-(a2)
 ori.b #$ca,-(a2)
 ori.b #$c2,-(a2)
 ori.b #$22,-(a2)
 dc.w $ffd2
L001de moveq #42,d0
 cmp.l d5,d0
 bne.s L0021c
 move.l (a4)+,D00208(a6)
 tst.b 1(sp)
 beq.s L001f6
 movea.l 62(sp),a4
 clr.b 1(sp)
L001f6 move.b (a3)+,d0
 ext.w d0
 ext.l d0
 move.l d0,d5
 bra.s L0022c
L00200 move.l D00208(a6),d0
 moveq #10,d1
 bsr.w _T$UMul
 moveq #-48,d1
 add.l d5,d1
 add.l d1,d0
 move.l d0,D00208(a6)
 move.b (a3)+,d0
 ext.w d0
 ext.l d0
 move.l d0,d5
L0021c lea _chcodes(a6),a0
 move.b (a0,d5.l),d0
 ext.w d0
 btst.l #3,d0
 bne.s L00200
L0022c moveq #46,d0
 cmp.l d5,d0
 bne.s L0029e
 move.b #1,D00205(a6)
 move.b (a3)+,d0
 ext.w d0
 ext.l d0
 move.l d0,d5
 moveq #42,d1
 cmp.l d0,d1
 bne.s L0027e
 move.l (a4)+,D0020c(a6)
 tst.b 1(sp)
 beq.s L00258
 movea.l 62(sp),a4
 clr.b 1(sp)
L00258 move.b (a3)+,d0
 ext.w d0
 ext.l d0
 move.l d0,d5
 bra.s L0029e
L00262 move.l D0020c(a6),d0
 moveq #10,d1
 bsr.w _T$UMul
 moveq #-48,d1
 add.l d5,d1
 add.l d1,d0
 move.l d0,D0020c(a6)
 move.b (a3)+,d0
 ext.w d0
 ext.l d0
 move.l d0,d5
L0027e lea _chcodes(a6),a0
 move.b (a0,d5.l),d0
 ext.w d0
 btst.l #3,d0
 bne.s L00262
 bra.s L0029e
L00290 move.b d5,D00206(a6)
 move.b (a3)+,d0
 ext.w d0
 ext.l d0
 move.l d0,d5
 bra.s L002b8
L0029e cmpi.l #255,d5
 bhi.s L002b8
 cmpi.b #76,d5
 beq.s L00290
 cmpi.b #104,d5
 beq.s L00290
 cmpi.b #108,d5
 beq.s L00290
L002b8 lea _chcodes(a6),a0
 move.b (a0,d5.l),d0
 ext.w d0
 btst.l #1,d0
 beq.s L002d6
 move.b #1,D00200(a6)
 move.l d5,d0
 bsr.w tolower
 move.l d0,d5
L002d6 moveq #97,d0
 cmp.l d5,d0
 bgt.s L002f4
 moveq #122,d1
 cmp.l d5,d1
 blt.s L002f4
 moveq #-97,d0
 add.l d5,d0
 lsl.l #2,d0
 lea _00000(a6),a0
 move.l (a0,d0.l),2(sp)
 bne.s L00342
L002f4 move.l d5,D00210(a6)
 bne.s L002fc
 subq.l #1,a3
L002fc lea L00524(pc),a0
 move.l a0,2(sp)
 lea D00210(a6),a0
L00308 move.l a0,d6
 bra.s L0037a
 tst.b 1(sp)
 beq.s L0031a
 movea.l 62(sp),a4
 clr.b 1(sp)
L0031a move.l a4,d6
 move.l a4,d0
 addq.l #8,d0
 movea.l d0,a4
 bra.s L0037a
 lea 6(sp),a0
 bra.s L00308
 move.l (a4)+,d6
 bra.s L00332
L0032e move.l a4,d6
 addq.l #4,a4
L00332 tst.b 1(sp)
 beq.s L0037a
 clr.b 1(sp)
 movea.l 62(sp),a4
 bra.s L0037a
L00342 move.l d5,d0
 subi.l #101,d0
 cmpi.l #14,d0
 bhi.s L0032e
 add.w d0,d0
 move.w L0035c(pc,d0.w),d0
 jmp L0035c(pc,d0.w)
L0035c dc.w $ffb0
 dc.w $ffb0
 dc.w $ffb0
 dc.w $ffd2
 dc.w $ffd2
 dc.w $ffd2
 dc.w $ffd2
 dc.w $ffd2
 dc.w $ffd2
 dc.w $ffc8
 dc.w $ffd2
 dc.w $ffd2
 dc.w $ffd2
 dc.w $ffd2
 dc.w $ffce
L0037a move.l d6,d0
 movea.l 2(sp),a0
 jsr (a0)
 move.l d0,d1
 moveq #115,d0
 cmp.l d5,d0
 bne.s L0038e
 movea.l d6,a0
 bra.s L00392
L0038e lea D00000(a6),a0
L00392 move.l a0,d0
 jsr (a2)
 add.l d0,6(sp)
L0039a move.b (a3)+,d0
 ext.w d0
 ext.l d0
 move.l d0,d5
 bne.w L00114
 tst.l d4
 ble.s L003c2
 clr.b D00201(a6)
 moveq #0,d0
 move.l d0,D0020c(a6)
 move.l d0,D00208(a6)
 move.l d4,d1
 move.l d7,d0
 jsr (a2)
 add.l d0,6(sp)
L003c2 move.l 6(sp),d0
 lea 10(sp),sp
 movem.l -32(a5),a0/a2-a4/d4-d7
 unlk a5
 rts 
L003d4 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l #-76,d0
 bsr.w _stkcheck
 move.l D00208(a6),d0
 sub.l d4,d0
 move.l d0,d6
 bgt.s L003f8
 move.l d4,d7
 bra.s L0041e
L003f8 lea D00000(a6),a0
 cmpa.l a2,a0
 bne.s L00406
 lea (a2,d4.l),a0
 bra.s L0040a
L00406 lea D00000(a6),a0
L0040a movea.l a0,a4
 movea.l a0,a3
 move.l d6,d5
 bra.s L00416
L00412 move.b D00207(a6),(a3)+
L00416 subq.l #1,d5
 bge.s L00412
 move.l D00208(a6),d7
L0041e tst.b D00201(a6)
 bne.s L0043a
 tst.l d6
 ble.s L0043a
 move.l D00214(a6),-(sp)
 pea (L00001).w
 move.l d6,d1
 move.l a4,d0
 bsr.w fwrite
 addq.l #8,sp
L0043a move.l D00214(a6),-(sp)
 pea (L00001).w
 move.l d4,d1
 move.l a2,d0
 bsr.w fwrite
 addq.l #8,sp
 tst.b D00201(a6)
 beq.s L00468
 tst.l d6
 ble.s L00468
 move.l D00214(a6),-(sp)
 pea (L00001).w
 move.l d6,d1
 move.l a4,d0
 bsr.w fwrite
 addq.l #8,sp
L00468 move.l d7,d0
 movem.l -32(a5),a0/a2-a4/d4-d7
 unlk a5
 rts 
L00474 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l #-68,d0
 bsr.w _stkcheck
 subq.l #4,sp
 move.l D00214(a6),d5
 move.l D00208(a6),d0
 sub.l d4,d0
 move.l d0,d7
 bgt.s L0049e
 move.l d4,d0
 bra.s L004a2
L0049e move.l D00208(a6),d0
L004a2 move.l d0,(sp)
 tst.b D00201(a6)
 bne.s L004b8
 bra.s L004b4
L004ac movea.l d5,a0
 addq.l #1,d5
 move.b D00207(a6),(a0)
L004b4 subq.l #1,d7
 bge.s L004ac
L004b8 move.l d4,d6
 bra.s L004c2
L004bc movea.l d5,a0
 addq.l #1,d5
 move.b (a2)+,(a0)
L004c2 subq.l #1,d6
 bge.s L004bc
 tst.b D00201(a6)
 beq.s L004da
 bra.s L004d6
L004ce movea.l d5,a0
 addq.l #1,d5
 move.b D00207(a6),(a0)
L004d6 subq.l #1,d7
 bge.s L004ce
L004da move.l d5,D00214(a6)
 move.l (sp),d0
 addq.l #4,sp
 movem.l -32(a5),a0/a2-a4/d4-d7
 unlk a5
 rts 
L004ec link.w a5,#0
 movem.l a2/d0/d4,-(sp)
 movea.l d0,a2
 move.l #-68,d0
 bsr.w _stkcheck
 move.l a2,d0
 bsr.w strlen
 move.l d0,d4
 tst.b D00205(a6)
 beq.s L00518
 cmp.l D0020c(a6),d4
 ble.s L00518
 move.l D0020c(a6),d4
L00518 move.l d4,d0
 movem.l -8(a5),a2/d4
 unlk a5
 rts 
L00524 link.w a5,#0
 movem.l a2/d0,-(sp)
 movea.l d0,a2
 move.l #-64,d0
 bsr.w _stkcheck
 move.b 3(a2),D00000(a6)
 moveq #1,d0
 movem.l -4(a5),a2
 unlk a5
 rts 
L0054a link.w a5,#0
 movem.l a0/a2-a4/d0/d4,-(sp)
 move.l #-64,d0
 bsr.w _stkcheck
 lea D00000(a6),a4
 movea.l (sp),a0
 move.l (a0),d4
 beq.s L0057e
 tst.b D00204(a6)
 beq.s L0057e
 move.b #48,(a4)+
 tst.b D00200(a6)
 beq.s L0057a
 moveq #88,d0
 bra.s L0057c
L0057a moveq #120,d0
L0057c move.b d0,(a4)+
L0057e tst.b D00200(a6)
 beq.s L0058a
 lea L00a5a(pc),a0
 bra.s L0058e
L0058a lea L00a6b(pc),a0
L0058e movea.l a0,a2
 lea D00218(a6),a3
L00594 moveq #15,d0
 and.l d4,d0
 move.b (a2,d0.l),(a3)+
 lsr.l #4,d4
 bne.s L00594
 bra.s L005a4
L005a2 move.b -(a3),(a4)+
L005a4 lea D00218(a6),a0
 cmpa.l a3,a0
 bcs.s L005a2
 lea D00000(a6),a0
 move.l a4,d0
 sub.l a0,d0
 movem.l -20(a5),a0/a2-a4/d4
 unlk a5
 rts 
L005be link.w a5,#0
 movem.l a0/a2-a3/d0/d4,-(sp)
 move.l #-64,d0
 bsr.w _stkcheck
 lea D00000(a6),a3
 movea.l (sp),a0
 move.l (a0),d4
 beq.s L005e4
 tst.b D00204(a6)
 beq.s L005e4
 move.b #48,(a3)+
L005e4 lea D00218(a6),a2
L005e8 moveq #7,d0
 and.b d4,d0
 addi.b #$30,d0
 move.b d0,(a2)+
 lsr.l #3,d4
 bne.s L005e8
 bra.s L005fa
L005f8 move.b -(a2),(a3)+
L005fa lea D00218(a6),a0
 cmpa.l a2,a0
 bcs.s L005f8
 lea D00000(a6),a0
 move.l a3,d0
 sub.l a0,d0
 movem.l -16(a5),a0/a2-a3/d4
 unlk a5
 rts 
L00614 link.w a5,#0
 movem.l a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l #-68,d0
 bsr.w _stkcheck
 lea D00000(a6),a3
 move.l (a2),d4
 bge.s L0063c
 move.l d4,d0
 neg.l d0
 move.l d0,d4
 move.b #45,(a3)+
 bra.s L00652
L0063c tst.b D00202(a6)
 beq.s L00648
 move.b #43,(a3)+
 bra.s L00652
L00648 tst.b D00203(a6)
 beq.s L00652
 move.b #32,(a3)+
L00652 move.l d4,d1
 move.l a3,d0
 bsr.s L006a2
 movem.l -16(a5),a2-a3/d1/d4
 unlk a5
 rts 
L00662 link.w a5,#0
 movem.l a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l #-68,d0
 bsr.w _stkcheck
 lea D00000(a6),a3
 move.l (a2),d4
 tst.b D00202(a6)
 beq.s L00688
 move.b #43,(a3)+
 bra.s L00692
L00688 tst.b D00203(a6)
 beq.s L00692
 move.b #32,(a3)+
L00692 move.l d4,d1
 move.l a3,d0
 bsr.s L006a2
 movem.l -16(a5),a2-a3/d1/d4
 unlk a5
 rts 
L006a2 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l #-64,d0
 bsr.w _stkcheck
 lea D00218(a6),a3
L006bc move.l d4,d0
 moveq #10,d1
 bsr.w _T$UMod
 addi.b #$30,d0
 move.b d0,(a3)+
 moveq #10,d1
 move.l d4,d0
 bsr.w _T$UDiv
 move.l d0,d4
 bne.s L006bc
 bra.s L006da
L006d8 move.b -(a3),(a2)+
L006da lea D00218(a6),a0
 cmpa.l a3,a0
 bcs.s L006d8
 lea D00000(a6),a0
 move.l a2,d0
 sub.l a0,d0
 movem.l -16(a5),a0/a2-a3/d4
 unlk a5
 rts 
L006f4 link.w a5,#0
 movem.l a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 move.l #-64,d0
 bsr.w _stkcheck
 lea D00000(a6),a3
 movem.l (a2),d0-d1
 movem.l d0-d1,D00222(a6)
 tst.l d0
 bge.s L00730
 move.b #45,(a3)+
 movem.l D00222(a6),d0-d1
 tcall T$Math1,T$DNeg
 movem.l d0-d1,D00222(a6)
 bra.s L00746
L00730 tst.b D00202(a6)
 beq.s L0073c
 move.b #43,(a3)+
 bra.s L00746
L0073c tst.b D00203(a6)
 beq.s L00746
 move.b #32,(a3)+
L00746 tst.b D00205(a6)
 bne.s L00752
 moveq #6,d0
 move.l d0,D0020c(a6)
L00752 move.l a3,d0
 movem.l -12(a5),a2-a3/d1
 unlk a5
 rts 
L0075e link.w a5,#0
 movem.l a2/d0/d4-d5,-(sp)
 movea.l d0,a2
 move.l #-64,d0
 bsr.w _stkcheck
 moveq #46,d5
L00774 move.b (a2),d4
 move.b d5,(a2)+
 move.b d4,d5
 bne.s L00774
 move.l a2,d0
 movem.l -12(a5),a2/d4-d5
 unlk a5
 rts 
L00788 link.w a5,#0
 movem.l a2/d0/d4,-(sp)
 movea.l d0,a2
 move.l #-64,d0
 bsr.w _stkcheck
L0079c move.b -(a2),d4
 cmpi.b #48,d4
 beq.s L0079c
 cmpi.b #46,d4
 beq.s L007ac
 addq.l #1,a2
L007ac move.l a2,d0
 movem.l -8(a5),a2/d4
 unlk a5
 rts 
L007b8 link.w a5,#0
 movem.l a2/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l #-64,d0
 bsr.w _stkcheck
 tst.b D00200(a6)
 beq.s L007d8
 moveq #69,d0
 bra.s L007da
L007d8 moveq #101,d0
L007da move.b d0,(a2)+
 tst.l d4
 blt.s L007e6
 move.b #43,(a2)+
 bra.s L007f0
L007e6 move.l d4,d0
 neg.l d0
 move.l d0,d4
 move.b #45,(a2)+
L007f0 moveq #99,d0
 cmp.l d4,d0
 bge.s L0080e
 move.l d4,d0
 moveq #100,d1
 bsr.w _T$LDiv
 addi.b #$30,d0
 move.b d0,(a2)+
 moveq #100,d1
 move.l d4,d0
 bsr.w _T$LMod
 move.l d0,d4
L0080e move.l d4,d0
 moveq #10,d1
 bsr.w _T$LDiv
 addi.b #$30,d0
 move.b d0,(a2)+
 move.l d4,d0
 moveq #10,d1
 bsr.w _T$LMod
 addi.b #$30,d0
 move.b d0,(a2)+
 move.l a2,d0
 movem.l -8(a5),a2/d4
 unlk a5
 rts 
L00836 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l #-88,d0
 bsr.w _stkcheck
 subq.l #4,sp
 move.l a2,d0
 bsr.w L006f4
 movea.l d0,a3
 pea (sp)
 pea (L07fff).w
 move.l D0020c(a6),d0
 addq.l #1,d0
 move.l d0,-(sp)
 pea (a3)
 movem.l D00222(a6),d0-d1
 bsr.w L00a36
 lea 16(sp),sp
 subq.l #1,d0
 move.l d0,d4
 move.l d4,d1
 move.l a3,d0
 addq.l #1,d0
 bsr.w L0075e
 bsr.w L007b8
 lea D00000(a6),a0
 sub.l a0,d0
 addq.l #4,sp
 movem.l -20(a5),a0/a2-a3/d1/d4
 unlk a5
 rts 
L00896 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l #-88,d0
 bsr.w _stkcheck
 subq.l #4,sp
 move.l a2,d0
 bsr.w L006f4
 movea.l d0,a3
 pea (sp)
 move.l D0020c(a6),-(sp)
 pea (L0000f).w
 pea (a3)
 movem.l D00222(a6),d0-d1
 bsr.w L00a36
 lea 16(sp),sp
 subq.l #1,d0
 move.l d0,d4
 move.l d4,d1
 move.l a3,d0
 bsr.w L00998
 lea D00000(a6),a0
 sub.l a0,d0
 addq.l #4,sp
 movem.l -20(a5),a0/a2-a3/d1/d4
 unlk a5
 rts 
L008ec link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l #-88,d0
 bsr.w _stkcheck
 subq.l #4,sp
 move.l a2,d0
 bsr.w L006f4
 movea.l d0,a3
 tst.l D0020c(a6)
 bne.s L00916
 moveq #1,d0
 move.l d0,D0020c(a6)
L00916 pea (sp)
 pea (L07fff).w
 move.l D0020c(a6),-(sp)
 pea (a3)
 movem.l D00222(a6),d0-d1
 bsr.w L00a36
 lea 16(sp),sp
 subq.l #1,d0
 move.l d0,d4
 moveq #-4,d0
 cmp.l d4,d0
 bgt.s L00940
 cmp.l D0020c(a6),d4
 blt.s L00968
L00940 move.l a3,d0
 addq.l #1,d0
 bsr.w L0075e
 movea.l d0,a3
 tst.l D0020c(a6)
 beq.s L0095e
 tst.b D00204(a6)
 bne.s L0095e
 move.l a3,d0
 bsr.w L00788
 movea.l d0,a3
L0095e move.l d4,d1
 move.l a3,d0
 bsr.w L007b8
 bra.s L00982
L00968 move.l d4,d1
 move.l a3,d0
 bsr.s L00998
 movea.l d0,a3
 tst.l D0020c(a6)
 beq.s L00984
 tst.b D00204(a6)
 bne.s L00984
 move.l a3,d0
 bsr.w L00788
L00982 movea.l d0,a3
L00984 lea D00000(a6),a0
 move.l a3,d0
 sub.l a0,d0
 addq.l #4,sp
 movem.l -20(a5),a0/a2-a3/d1/d4
 unlk a5
 rts 
L00998 link.w a5,#0
 movem.l a2-a4/d0-d1/d4-d6,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l #-72,d0
 bsr.w _stkcheck
 movea.l a2,a3
 bra.s L009b4
L009b2 addq.l #1,a3
L009b4 tst.b (a3)
 bne.s L009b2
 tst.l d4
 bge.s L009f6
 move.l a3,d0
 sub.l a2,d0
 move.l d0,-(sp)
 move.l a2,d1
 move.l a2,d0
 sub.l d4,d0
 bsr.w memcpy
 addq.l #4,sp
 suba.l d4,a3
 movea.l a2,a4
 move.l D0020c(a6),d0
 addq.l #1,d0
 move.l d4,d1
 neg.l d1
 move.l d1,d5
 cmp.l d1,d0
 bge.s L009f0
 move.l D0020c(a6),d0
 addq.l #1,d0
 move.l d0,d5
 bra.s L009f0
L009ec move.b #48,(a4)+
L009f0 subq.l #1,d5
 bge.s L009ec
 moveq #0,d4
L009f6 move.l a3,d0
 sub.l a2,d0
 move.l d0,d6
 move.l D0020c(a6),d0
 add.l d4,d0
 addq.l #1,d0
 sub.l d6,d0
 move.l d0,d5
 bra.s L00a0e
L00a0a move.b #48,(a3)+
L00a0e subq.l #1,d5
 bge.s L00a0a
 tst.l D0020c(a6)
 bne.s L00a1e
 tst.b D00204(a6)
 beq.s L00a2c
L00a1e clr.b (a3)
 move.l a2,d0
 add.l d4,d0
 addq.l #1,d0
 bsr.w L0075e
 bra.s L00a2e
L00a2c move.l a3,d0
L00a2e movem.l -24(a5),a2-a4/d4-d6
 bra.s L00a56
L00a36 link.w a5,#0
 movem.l a0/d2,-(sp)
 movea.l 8(a5),a0
 move.l 16(a5),d2
 lsl.l #8,d2
 lsl.l #8,d2
 or.l 12(a5),d2
 tcall T$Math1,T$DtoA
 movem.l (sp)+,a0/d2
L00a56 unlk a5
 rts 
L00a5a dc.w $3031
 dc.w $3233
 dc.w $3435
 move.w 57(sp,d3.l),d3
 dc.w $4142
 dc.w $4344
 dc.w $4546
 dc.w $0030
 dc.w $3132
 dc.w $3334
 dc.w $3536
 move.w (L03961).w,-(a3)
 dc.w $6263
 dc.w $6465
 dc.w $6600

 ends 

