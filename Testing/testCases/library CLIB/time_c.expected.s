 psect time_c,$0,$0,0,0,time

* D
 vsect 
D00000 ds.b 4
D00004 ds.b 4
D00008 ds.b 4
D0000c ds.b 4
D00010 ds.b 4
D00014 ds.b 4
D00018 ds.b 4
D0001c ds.b 4
D00020 ds.b 4
D00024 ds.b 4
D00028 ds.b 4
D0002c ds.b 4
D00030 ds.b 4


 ends 


* _
 vsect 
_00000 dc.l $0000001f
_00004 dc.l $0000001c
 dc.l $0000001f
 dc.l $0000001e
 dc.l $0000001f
 dc.l $0000001e
 dc.l $0000001f
 dc.l $0000001f
 dc.l $0000001e
 dc.l $0000001f
 dc.l $0000001e
 dc.l $0000001f
 dc.l $000003e7
_00034 dc.l L00944
 dc.l $000001e0
 dc.l L00744
 dc.l L00948
 dc.l $000001e0
 dc.l L00744
 dc.l L0094c
 dc.l $000001a4
 dc.l L00744
 dc.l L00950
 dc.l $000001a4
 dc.l L00744
_00064 dc.l L00954
 dc.l $00000168
 dc.l L00744
 dc.l L00958
 dc.l $00000168
 dc.l L00744
 dc.l L0095c
 dc.l $0000012c
 dc.l L00744
 dc.l L00960
 dc.l $0000012c
 dc.l L00744
 dc.l L00964
 dc.l $000001e0
 dc.l L00744
 dc.l L00968
 dc.l $00000258
 dc.l L00724
 dc.l L0096c
 dc.l $00000000
 dc.l L00848
 dc.l L00970
 dc.l $ffffffc4
 dc.l L00848
 dc.l L00974
 dc.l $ffffff88
 dc.l L00848
 dc.l L00978
 dc.l $00000000
 dc.l L00724
 dc.l L0097c
 dc.l $00000000
 dc.l L00724
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
_000f4 dc.l _00064
_000f8 dc.l $00000000
 dc.l $00000001
 dc.l $00000001
 dc.l $00000000


 ends 

time: link.w A5,#0
 movem.l a0-a1/d0-d1,-(sp)
 lea.l -26(sp),a7
 pea 8(sp)
 pea 16(sp)
 pea 22(sp)
 lea.l 30(sp),a0
 move.l a0,d1
 moveq #0,d0
 bsr.w _sysdate
 lea.l 12(sp),a7
 moveq #255,d1
 cmp.l d0,d1
 beq.s L0004c
 move.l 18(sp),4(sp)
 move.l 14(sp),(sp)
 lea.l (sp),a0
 move.l a0,d1
 lea.l 4(sp),a0
 move.l a0,d0
 bsr.w _julian
 moveq #255,d1
 cmp.l d0,d1
 bne.s L00052
L0004c moveq #255,d0
 bra.w L000da
L00052 tst.l D00000(a6)
 bne.s L00060
 bsr.w L00568
 move.l d0,D00000(a6)
L00060 movea.l D00000(a6),a0
 move.l 4(a0),d0
 moveq #60,d1
 bsr.w _T$UMul
 add.l d0,4(sp)
 movea.w 18(sp),a1
 move.l a1,-(sp)
 movea.w 16(sp),a1
 move.l a1,-(sp)
 moveq #0,d0
 move.b 25(sp),d0
 move.l d0,-(sp)
 moveq #0,d0
 move.b 28(sp),d0
 subq.w #1,d0
 ext.l d0
 move.l d0,d1
 movea.w 26(sp),a1
 move.l a1,d0
 movea.l 8(a0),a1
 jsr (a1)
 lea.l 12(sp),a7
 tst.l d0
 beq.s L000ae
 subi.l #3600,4(sp)
L000ae move.l #-2440587,d0
 add.l (sp),d0
 move.l #86400,d1
 bsr.w _T$UMul
 add.l 4(sp),d0
 move.l d0,22(sp)
 tst.l 26(sp)
 beq.s L000d6
 movea.l 26(sp),a0
 move.l 22(sp),(a0)
L000d6 move.l 22(sp),d0
L000da lea.l 26(sp),a7
 movem.l -12(a5),a0-a1/d1
 unlk A5
 rts 
mktime: link.w A5,#0
 movem.l a0-a2/d0-d2/d4,-(sp)
 movea.l d0,a2
 subq.l #8,sp
 move.l a2,d0
 bsr.w L001fa
 moveq #3,d0
 cmp.l 20(a2),d0
 bgt.s L00166
 cmpi.l #137,20(a2)
 bgt.s L00166
 move.l 12(a2),-(sp)
 move.l 16(a2),d1
 move.l 20(a2),d0
 bsr.w L00368
 addq.l #4,sp
 move.l d0,28(a2)
 move.l 8(a2),d0
 moveq #16,d1
 lsl.l d1,d0
 move.l 4(a2),d2
 lsl.l #8,d2
 or.l d2,d0
 or.l (a2),d0
 move.l d0,4(sp)
 move.l #1900,d0
 add.l 20(a2),d0
 lsl.l d1,d0
 move.l 16(a2),d2
 addq.l #1,d2
 lsl.l #8,d2
 or.l d2,d0
 or.l 12(a2),d0
 move.l d0,(sp)
 lea.l (sp),a0
 move.l a0,d1
 lea.l 4(sp),a0
 move.l a0,d0
 bsr.w _julian
 tst.l d0
 bge.s L0016c
L00166 moveq #255,d0
 bra.w L001ee
L0016c move.l (sp),d0
 addq.l #2,d0
 moveq #7,d1
 bsr.w _T$LMod
 move.l d0,24(a2)
 tst.l D00000(a6)
 bne.s L00188
 bsr.w L00568
 move.l d0,D00000(a6)
L00188 movea.l D00000(a6),a0
 move.l 4(a0),d0
 moveq #60,d1
 bsr.w _T$UMul
 add.l d0,4(sp)
 move.l 8(a2),-(sp)
 move.l 24(a2),-(sp)
 move.l 12(a2),-(sp)
 move.l 16(a2),d1
 move.l #1900,d0
 add.l 20(a2),d0
 movea.l 8(a0),a1
 jsr (a1)
 lea.l 12(sp),a7
 tst.l d0
 beq.s L001d4
 subi.l #3600,4(sp)
 move.l #1,32(a2)
 bra.s L001d8
L001d4 clr.l 32(a2)
L001d8 move.l #-2440587,d0
 add.l (sp),d0
 move.l #86400,d1
 bsr.w _T$UMul
 add.l 4(sp),d0
L001ee addq.l #8,sp
 movem.l -24(a5),a0-a2/d1-d2/d4
 unlk A5
 rts 
L001fa link.w A5,#0
 movem.l a0/a2/d0-d1/d4-d6,-(sp)
 movea.l d0,a2
 moveq #60,d1
 move.l a2,d0
 bsr.w L0032a
 add.l d0,4(a2)
 moveq #60,d1
 move.l a2,d0
 addq.l #4,d0
 bsr.w L0032a
 add.l d0,8(a2)
 moveq #24,d1
 move.l a2,d0
 addq.l #8,d0
 bsr.w L0032a
 move.l d0,d5
 add.l d0,28(a2)
 add.l d5,12(a2)
 tst.l d5
 bge.s L00246
 move.l d5,d0
 neg.l d0
 moveq #7,d1
 bsr.w _T$LMod
 moveq #7,d1
 sub.l d0,d1
 move.l d1,d5
L00246 move.l 24(a2),d0
 add.l d5,d0
 moveq #7,d1
 bsr.w _T$LMod
 move.l d0,24(a2)
 moveq #12,d1
 moveq #16,d0
 add.l a2,d0
 bsr.w L0032a
 add.l d0,20(a2)
 moveq #0,d6
 moveq #3,d0
 and.l 20(a2),d0
 bne.s L002ac
 moveq #29,d0
 bra.s L002a8
L00272 move.l 16(a2),d0
 lsl.l #2,d0
 lea.l _00000(a6),a0
 move.l (a0,d0.l),d0
 dc.w $91aa
 dc.w $c
 addq.l #1,16(a2)
 moveq #11,d0
 cmp.l 16(a2),d0
 bge.s L002ac
 moveq #1,d6
 clr.l 16(a2)
 addq.l #1,20(a2)
 moveq #3,d0
 and.l 20(a2),d0
 bne.s L002a6
 moveq #29,d0
 bra.s L002a8
L002a6 moveq #28,d0
L002a8 move.l d0,_00004(a6)
L002ac move.l 16(a2),d0
 lsl.l #2,d0
 lea.l _00000(a6),a0
 move.l 12(a2),d1
 cmp.l (a0,d0.l),d1
 bgt.s L00272
 bra.s L002fa
L002c2 subq.l #1,16(a2)
 bge.s L002e8
 moveq #1,d6
 move.l #11,16(a2)
 subq.l #1,20(a2)
 moveq #3,d0
 and.l 20(a2),d0
 bne.s L002e2
 moveq #29,d0
 bra.s L002e4
L002e2 moveq #28,d0
L002e4 move.l d0,_00004(a6)
L002e8 move.l 16(a2),d0
 lsl.l #2,d0
 lea.l _00000(a6),a0
 move.l (a0,d0.l),d0
 add.l d0,12(a2)
L002fa moveq #1,d0
 cmp.l 12(a2),d0
 bgt.s L002c2
 tst.l d6
 beq.s L0031a
 move.l 12(a2),-(sp)
 move.l 16(a2),d1
 move.l 20(a2),d0
 bsr.s L00368
 addq.l #4,sp
 move.l d0,28(a2)
L0031a moveq #28,d0
 move.l d0,_00004(a6)
 movem.l -24(a5),a0/a2/d1/d4-d6
 unlk A5
 rts 
L0032a link.w A5,#0
 movem.l a0/d0-d1/d4,-(sp)
 moveq #0,d4
 bra.s L00340
L00336 addq.l #1,d4
 move.l 4(sp),d0
 movea.l (sp),a0
 dc.w $9190
L00340 movea.l (sp),a0
 move.l 4(sp),d0
 cmp.l (a0),d0
 ble.s L00336
 bra.s L00356
L0034c subq.l #1,d4
 move.l 4(sp),d0
 movea.l (sp),a0
 add.l d0,(a0)
L00356 movea.l (sp),a0
 tst.l (a0)
 blt.s L0034c
 move.l d4,d0
 movem.l -8(a5),a0/d4
 unlk A5
 rts 
L00368 link.w A5,#0
 movem.l a0/d0-d1/d4-d7,-(sp)
 move.l d0,d4
 move.l d1,d5
 move.l 36(sp),d6
 moveq #3,d0
 and.l d4,d0
 bne.s L00384
 moveq #29,d0
 move.l d0,_00004(a6)
L00384 move.l d6,d0
 subq.l #1,d0
 move.l d0,d7
 bra.s L00398
L0038c move.l d5,d0
 lsl.l #2,d0
 lea.l _00000(a6),a0
 add.l (a0,d0.l),d7
L00398 subq.l #1,d5
 bgt.s L0038c
 moveq #28,d0
 move.l d0,_00004(a6)
 move.l d7,d0
 movem.l -20(a5),a0/d4-d7
 unlk A5
 rts 
localtime: link.w A5,#0
 movem.l a0/a2/d0-d1,-(sp)
 tst.l (sp)
 bne.s L003be
 moveq #0,d0
 bra.s L00424
L003be move.l (sp),d0
 bsr.s gmtime
 movea.l d0,a2
 tst.l D00000(a6)
 bne.s L003d2
 bsr.w L00568
 move.l d0,D00000(a6)
L003d2 movea.l D00000(a6),a0
 move.l 4(a0),d0
 dc.w $91aa
 dc.w $4
 move.l a2,d0
 bsr.w L001fa
 move.l 8(a2),-(sp)
 move.l 24(a2),-(sp)
 move.l 12(a2),-(sp)
 move.l 16(a2),d1
 move.l #1900,d0
 add.l 20(a2),d0
 movea.l D00000(a6),a0
 movea.l 8(a0),a0
 jsr (a0)
 lea.l 12(sp),a7
 tst.l d0
 beq.s L00422
 addq.l #1,8(a2)
 move.l a2,d0
 bsr.w L001fa
 move.l #1,32(a2)
L00422 move.l a2,d0
L00424 movem.l -12(a5),a0/a2/d1
 unlk A5
 rts 
gmtime: link.w A5,#0
 movem.l a0/d0-d1/d4-d7,-(sp)
 subq.l #4,sp
 tst.l 4(sp)
 bne.s L00444
 moveq #0,d0
 bra.w L0055c
L00444 movea.l 4(sp),a0
 move.l (a0),d4
 move.l d4,d0
 move.l #86400,d1
 bsr.w _T$LDiv
 addi.l #2440587,d0
 move.l d0,(sp)
 move.l (sp),d0
 addq.l #2,d0
 moveq #7,d1
 bsr.w _T$LMod
 move.l d0,D0001c(a6)
 move.l #1970,d5
 bra.s L00478
L00474 sub.l d6,d4
 addq.l #1,d5
L00478 moveq #3,d0
 and.l d5,d0
 bne.s L00486
 move.l #31622400,d0
 bra.s L0048c
L00486 move.l #31536000,d0
L0048c move.l d0,d6
 cmp.l d4,d0
 ble.s L00474
 bra.s L004ac
L00494 subq.l #1,d5
 moveq #3,d0
 and.l d5,d0
 bne.s L004a4
 move.l #31622400,d0
 bra.s L004aa
L004a4 move.l #31536000,d0
L004aa add.l d0,d4
L004ac tst.l d4
 blt.s L00494
 move.l #-1900,d0
 add.l d5,d0
 move.l d0,D00018(a6)
 move.l d4,d0
 move.l #86400,d1
 bsr.w _T$LDiv
 move.l d0,D00020(a6)
 move.l #86400,d1
 move.l d4,d0
 bsr.w _T$LMod
 move.l d0,d4
 move.l d4,d0
 move.l #3600,d1
 bsr.w _T$LDiv
 move.l d0,D0000c(a6)
 move.l #3600,d1
 move.l d4,d0
 bsr.w _T$LMod
 move.l d0,d4
 move.l d4,d0
 moveq #60,d1
 bsr.w _T$LDiv
 move.l d0,D00008(a6)
 move.l d4,d0
 moveq #60,d1
 bsr.w _T$LMod
 move.l d0,D00004(a6)
 clr.l D00024(a6)
 moveq #3,d0
 and.l d5,d0
 bne.s L00520
 moveq #29,d0
 move.l d0,_00004(a6)
L00520 move.l D00020(a6),d4
 moveq #0,d7
 bra.s L00536
L00528 move.l d7,d0
 lsl.l #2,d0
 lea.l _00000(a6),a0
 sub.l (a0,d0.l),d4
 addq.l #1,d7
L00536 move.l d7,d0
 lsl.l #2,d0
 lea.l _00000(a6),a0
 cmp.l (a0,d0.l),d4
 bge.s L00528
 move.l d7,D00014(a6)
 move.l d4,d0
 addq.l #1,d0
 move.l d0,D00010(a6)
 moveq #28,d0
 move.l d0,_00004(a6)
 lea.l D00004(a6),a0
 move.l a0,d0
L0055c addq.l #4,sp
 movem.l -24(a5),a0/d1/d4-d7
 unlk A5
 rts 
L00568 link.w A5,#0
 movem.l a0-a1/d0-d1,-(sp)
 lea.l -28(sp),a7
 lea.l L00980(pc),a0
 move.l a0,d0
 bsr.w getenv
 move.l d0,24(sp)
 tst.l 24(sp)
 beq.w L006e6
 lea.l 4(sp),a0
 move.l a0,20(sp)
 bra.s L005a6
L00594 movea.l 24(sp),a0
 addq.l #1,24(sp)
 movea.l 20(sp),a1
 addq.l #1,20(sp)
 move.b (a0),(a1)
L005a6 movea.l 24(sp),a0
 move.b (a0),d0
 ext.w d0
 cmpi.w #45,d0
 beq.s L005c8
 bhi.s L005c2
 cmpi.b #43,d0
 beq.s L005c8
 bhi.s L00594
 tst.b d0
 bra.s L005c6
L005c2 cmpi.w #58,d0
L005c6 bne.s L00594
L005c8 movea.l 20(sp),a0
 clr.b (a0)
 lea.l _00034(a6),a0
 move.l a0,(sp)
 bra.s L005ee
L005d6 movea.l (sp),a0
 move.l (a0),d1
 lea.l 4(sp),a0
 move.l a0,d0
 bsr.w strcmp
 tst.l d0
 beq.s L005f4
 addi.l #12,(sp)
L005ee movea.l (sp),a0
 tst.l (a0)
 bne.s L005d6
L005f4 movea.l (sp),a0
 tst.l (a0)
 beq.w L006e6
 clr.l 12(sp)
 clr.l 16(sp)
 bra.s L00660
L00606 move.l (sp),d0
 bra.w L00716
L0060c moveq #1,d0
 move.l d0,12(sp)
 bra.s L00632
L00614 move.l 16(sp),d0
 moveq #10,d1
 bsr.w _T$UMul
 movea.l 24(sp),a0
 move.b (a0),d1
 ext.w d1
 subi.w #48,d1
 ext.l d1
 add.l d1,d0
 move.l d0,16(sp)
L00632 addq.l #1,24(sp)
 movea.l 24(sp),a0
 cmpi.b #48,(a0)
 blt.s L0064a
 movea.l 24(sp),a0
 cmpi.b #57,(a0)
 ble.s L00614
L0064a tst.l 12(sp)
 bne.w L006ec
 move.l 16(sp),d0
 neg.l d0
 move.l d0,16(sp)
 bra.w L006ec
L00660 movea.l 24(sp),a0
 move.b (a0),d0
 ext.w d0
 cmpi.w #255,d0
 bhi.w L006ec
 tst.b d0
 beq.s L00606
 cmpi.b #43,d0
 beq.s L00632
 cmpi.b #45,d0
 beq.s L0060c
 bra.s L006ec
L00682 movea.l (sp),a0
 move.l 8(a0),D00030(a6)
 bra.w L00702
L0068e addq.l #1,24(sp)
 lea.l L00983(pc),a0
 move.l a0,d1
 move.l 24(sp),d0
 bsr.w strcmp
 tst.l d0
 bne.s L006ae
 lea.l L00744(pc),a0
 move.l a0,D00030(a6)
 bra.s L00702
L006ae lea.l L00987(pc),a0
 move.l a0,d1
 move.l 24(sp),d0
 bsr.w strcmp
 tst.l d0
 bne.s L006ca
 lea.l L00848(pc),a0
 move.l a0,D00030(a6)
 bra.s L00702
L006ca lea.l L0098b(pc),a0
 move.l a0,d1
 move.l 24(sp),d0
 bsr.w strcmp
 tst.l d0
 bne.s L006e6
 lea.l L00724(pc),a0
 move.l a0,D00030(a6)
 bra.s L00702
L006e6 move.l _000f4(a6),d0
 bra.s L00716
L006ec movea.l 24(sp),a0
 move.b (a0),d0
 ext.w d0
 tst.w d0
 beq.w L00682
 cmpi.w #58,d0
 beq.s L0068e
 bra.s L006e6
L00702 movea.l (sp),a0
 move.l 4(a0),d0
 add.l 16(sp),d0
 move.l d0,D0002c(a6)
 lea.l D00028(a6),a0
 move.l a0,d0
L00716 lea.l 28(sp),a7
 movem.l -12(a5),a0-a1/d1
 unlk A5
 rts 
L00724 link.w A5,#0
 movem.l d0-d1/d4-d7,-(sp)
 move.l d0,d4
 move.l d1,d5
 move.l 32(sp),d6
 move.l 36(sp),d7
 moveq #0,d0
 movem.l -16(a5),d4-d7
 unlk A5
 rts 
L00744 link.w A5,#0
 movem.l a0/d0-d1/d4-d7,-(sp)
 move.l d0,d4
 move.l d1,d5
 move.l 36(sp),d6
 move.l 40(sp),d7
 lea.l -20(sp),a7
 cmpi.l #1967,d4
 blt.w L00834
 cmpi.l #1974,d4
 beq.s L00776
 cmpi.l #1975,d4
 bne.s L007a0
L00776 move.l #-1974,d0
 add.l d4,d0
 lsl.l #3,d0
 lea.l _000f8(a6),a0
 move.l 4(a0,d0.l),12(sp)
 move.l #-1974,d0
 add.l d4,d0
 lsl.l #3,d0
 lea.l _000f8(a6),a0
 move.l (a0,d0.l),16(sp)
 bra.s L007ba
L007a0 cmpi.l #1987,d4
 bge.s L007ae
 clr.l 12(sp)
 bra.s L007b4
L007ae moveq #1,d0
 move.l d0,12(sp)
L007b4 moveq #3,d0
 move.l d0,16(sp)
L007ba clr.l 4(sp)
 moveq #9,d0
 move.l d0,8(sp)
 cmp.l 16(sp),d5
 blt.w L00834
 cmp.l 8(sp),d5
 bgt.s L00834
 cmp.l 16(sp),d5
 bne.s L00804
 move.l d7,-(sp)
 move.l d6,-(sp)
 move.l d4,-(sp)
 move.l 28(sp),d1
 move.l 24(sp),d0
 bsr.w L008d2
 lea.l 12(sp),a7
 move.l d0,(sp)
 cmp.l (sp),d6
 bne.s L007fe
 moveq #2,d0
 cmp.l 64(sp),d0
 bgt.s L00834
 bra.s L00838
L007fe cmp.l (sp),d6
 ble.s L00834
 bra.s L00838
L00804 cmp.l 8(sp),d5
 bne.s L00838
 move.l d7,-(sp)
 move.l d6,-(sp)
 move.l d4,-(sp)
 move.l 20(sp),d1
 move.l 16(sp),d0
 bsr.w L008d2
 lea.l 12(sp),a7
 move.l d0,(sp)
 cmp.l (sp),d6
 bne.s L00830
 moveq #2,d0
 cmp.l 64(sp),d0
 ble.s L00834
 bra.s L00838
L00830 cmp.l (sp),d6
 blt.s L00838
L00834 moveq #0,d0
 bra.s L0083a
L00838 moveq #1,d0
L0083a lea.l 20(sp),a7
 movem.l -20(a5),a0/d4-d7
 unlk A5
 rts 
L00848 link.w A5,#0
 movem.l d0-d1/d4-d7,-(sp)
 move.l d0,d4
 move.l d1,d5
 move.l 32(sp),d6
 move.l 36(sp),d7
 subq.l #4,sp
 moveq #2,d0
 cmp.l d5,d0
 bgt.s L008c0
 moveq #8,d0
 cmp.l d5,d0
 blt.s L008c0
 moveq #2,d0
 cmp.l d5,d0
 bne.s L00896
 move.l d7,-(sp)
 move.l d6,-(sp)
 move.l d4,-(sp)
 moveq #2,d1
 moveq #0,d0
 bsr.s L008d2
 lea.l 12(sp),a7
 move.l d0,(sp)
 cmp.l (sp),d6
 bne.s L00890
 moveq #2,d0
 cmp.l 44(sp),d0
 bgt.s L008c0
 bra.s L008c4
L00890 cmp.l (sp),d6
 ble.s L008c0
 bra.s L008c4
L00896 moveq #8,d0
 cmp.l d5,d0
 bne.s L008c4
 move.l d7,-(sp)
 move.l d6,-(sp)
 move.l d4,-(sp)
 moveq #8,d1
 moveq #0,d0
 bsr.s L008d2
 lea.l 12(sp),a7
 move.l d0,(sp)
 cmp.l (sp),d6
 bne.s L008bc
 moveq #2,d0
 cmp.l 44(sp),d0
 ble.s L008c0
 bra.s L008c4
L008bc cmp.l (sp),d6
 blt.s L008c4
L008c0 moveq #0,d0
 bra.s L008c6
L008c4 moveq #1,d0
L008c6 addq.l #4,sp
 movem.l -16(a5),d4-d7
 unlk A5
 rts 
L008d2 link.w A5,#0
 movem.l a0/d0-d1/d4-d7,-(sp)
 moveq #3,d0
 and.l 36(sp),d0
 bne.s L008e8
 moveq #29,d0
 move.l d0,_00004(a6)
L008e8 move.l 40(sp),d0
 sub.l 44(sp),d0
 move.l d0,d5
 moveq #1,d0
 cmp.l d5,d0
 ble.s L008fa
 addq.l #7,d5
L008fa move.l d5,d0
 subq.l #1,d0
 moveq #7,d1
 bsr.w _T$LDiv
 addq.l #1,d0
 move.l d0,d6
 tst.l (sp)
 bne.s L00926
 move.l 4(sp),d0
 lsl.l #2,d0
 lea.l _00000(a6),a0
 move.l (a0,d0.l),d7
 bra.s L0091e
L0091c addq.l #7,d5
L0091e cmp.l d7,d5
 ble.s L0091c
 subq.l #7,d5
 bra.s L00932
L00926 move.l (sp),d0
 sub.l d6,d0
 moveq #7,d1
 bsr.w _T$UMul
 add.l d0,d5
L00932 moveq #28,d0
 move.l d0,_00004(a6)
 move.l d5,d0
 movem.l -20(a5),a0/d4-d7
 unlk A5
 rts 
L00944 addq.w #8,(a3)
 addq.b #2,d0
L00948 addq.w #8,d4
 addq.b #2,d0
L0094c dc.w $4d53
 addq.b #2,d0
L00950 dc.w $4d44
 addq.b #2,d0
L00954 dc.w $4353
 addq.b #2,d0
L00958 dc.w $4344
 addq.b #2,d0
L0095c dc.w $4553
 addq.b #2,d0
L00960 dc.w $4544
 addq.b #2,d0
L00964 subq.w #4,(a3)
 addq.b #2,d0
L00968 dc.w $4153
 addq.b #2,d0
L0096c subq.w #3,d5
 addq.b #2,d0
L00970 dc.w $4345
 addq.b #2,d0
L00974 dc.w $4545
 addq.b #2,d0
L00978 dc.w $474d
 addq.b #2,d0
L0097c subq.w #2,(a4)
 dc.w $4300
L00980 addq.w #2,(a2)+
 ori.w #29537,101(a5,d0.w)
L00983 equ *-5
L00987 equ *-1
 dc.w $7572
 dc.w $6e
L0098b equ *-1
 dc.w $6f00

 ends 

