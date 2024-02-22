 psect scanf_c,0,0,0,0,scanf


* D
 vsect 
D00000 ds.b 9
D00009 ds.b 4
D0000d ds.b 19
D00020 ds.b 96
D00080 ds.b 4
D00084 ds.b 4


 ends 

scanf: link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l #-80,d0
 bsr.w _stkcheck
 lea _iob(a6),a0
 move.l a0,D00084(a6)
 pea 20(sp)
 pea 8(sp)
 move.l 8(sp),-(sp)
 lea L0082a(pc),a0
 move.l a0,d1
 lea L0080c(pc),a0
 move.l a0,d0
 bsr.w L000c0
 lea 12(sp),sp
 movem.l -4(a5),a0
 unlk a5
 rts 
fscanf: link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l #-80,d0
 bsr.w _stkcheck
 move.l (sp),D00084(a6)
 pea 24(sp)
 pea 24(sp)
 move.l 12(sp),-(sp)
 lea L0082a(pc),a0
 move.l a0,d1
 lea L0080c(pc),a0
 move.l a0,d0
 bsr.s L000c0
 lea 12(sp),sp
 movem.l -4(a5),a0
 unlk a5
 rts 
sscanf: link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l #-80,d0
 bsr.w _stkcheck
 move.l (sp),D00080(a6)
 pea 24(sp)
 pea 24(sp)
 move.l 12(sp),-(sp)
 lea L00886(pc),a0
 move.l a0,d1
 lea L00850(pc),a0
 move.l a0,d0
 bsr.s L000c0
 lea 12(sp),sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L000c0 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 movea.l 48(sp),a4
 move.l #-104,d0
 bsr.w _stkcheck
 lea -16(sp),sp
 moveq #1,d0
 move.b d0,D00020(a6)
 move.b d0,D0000d(a6)
 move.b d0,D00009(a6)
 moveq #0,d0
 move.l d0,4(sp)
 move.l d0,8(sp)
 move.l d0,d5
 bra.w L00342
L000fc move.b (a4)+,d4
 cmpi.b #37,d4
 beq.w L0031e
 cmpi.b #42,d4
 bne.s L00114
 clr.l 12(sp)
 move.b (a4)+,d4
 bra.s L00132
L00114 tst.l 4(sp)
 bne.s L00128
 moveq #1,d0
 move.l d0,4(sp)
 move.l 68(sp),12(sp)
 bra.s L00132
L00128 move.l 72(sp),12(sp)
 addq.l #4,72(sp)
L00132 moveq #0,d6
 moveq #1,d0
 move.l d0,(sp)
 bra.s L00152
L0013a move.l d6,d0
 moveq #10,d1
 bsr.w _T$UMul
 move.b d4,d1
 ext.w d1
 ext.l d1
 add.l d1,d0
 moveq #48,d1
 sub.l d1,d0
 move.l d0,d6
 move.b (a4)+,d4
L00152 move.b d4,d0
 ext.w d0
 ext.l d0
 lea _chcodes(a6),a0
 move.b (a0,d0.l),d0
 ext.w d0
 btst.l #3,d0
 bne.s L0013a
 tst.l d6
 bne.w L0026c
 move.l #2147483647,d6
 bra.w L0026c
L00178 moveq #2,d0
 bra.w L001fa
 move.b (a4)+,d4
 move.b d4,d0
 ext.w d0
 cmpi.w #102,d0
 beq.s L00178
 bhi.s L0019c
 cmpi.w #101,d0
 beq.s L00178
 bhi.w L00336
 cmpi.w #100,d0
 bra.s L001aa
L0019c cmpi.w #120,d0
 beq.s L00178
 bhi.w L00336
 cmpi.b #111,d0
L001aa beq.s L00178
 bra.w L00336
L001b0 clr.l (sp)
 bra.s L001fc
 move.b (a4)+,d4
 move.b d4,d0
 ext.w d0
 cmpi.w #102,d0
 beq.s L001b0
 bhi.s L001d2
 cmpi.w #101,d0
 beq.s L001b0
 bhi.w L00336
 cmpi.w #100,d0
 bra.s L001e0
L001d2 cmpi.w #120,d0
 beq.s L001b0
 bhi.w L00336
 cmpi.b #111,d0
L001e0 beq.s L001b0
 bra.w L00336
 moveq #2,d0
 move.l d0,(sp)
 move.b d4,d0
 ext.w d0
 ext.l d0
 bsr.w tolower
 move.b d0,d4
 bra.s L001fc
 moveq #1,d0
L001fa move.l d0,(sp)
L001fc lea -56(a5),sp
 pea 8(sp)
 move.l 4(sp),-(sp)
 move.l d6,-(sp)
 move.b d4,d0
 ext.w d0
 ext.l d0
 move.l d0,-(sp)
 move.l 28(sp),-(sp)
 move.l a3,d1
 move.l a2,d0
 bsr.w L00380
 lea 20(sp),sp
 bra.s L00258
 move.l a4,d0
 bsr.w L0077a
 movea.l d0,a4
 pea 8(sp)
 move.l d6,-(sp)
 move.b d4,d0
 ext.w d0
 ext.l d0
 move.l d0,-(sp)
 tst.l 24(sp)
 beq.s L00248
 movea.l 24(sp),a0
 movea.l (a0),a0
 bra.s L0024a
L00248 suba.l a0,a0
L0024a pea (a0)
 move.l a3,d1
 move.l a2,d0
 bsr.w L00682
 lea 16(sp),sp
L00258 tst.l d0
 beq.w L002f0
 tst.l 12(sp)
 beq.w L002f0
 addq.l #1,d5
 bra.w L002f0
L0026c move.b d4,d0
 ext.w d0
 subi.w #68,d0
 cmpi.w #52,d0
 bhi.w L00336
 add.w d0,d0
 move.w L00286(pc,d0.w),d0
 jmp L00286(pc,d0.w)
L00286 dc.w $ff60
 dc.w $ff60
 dc.w $ff60
 ori.l #$00b000b0,-80(a0,d0.w)
 ori.l #$00b000b0,-80(a0,d0.w)
 dc.w $ff60
 ori.l #$00b000b0,-80(a0,d0.w)
 ori.l #$00b000b0,-80(a0,d0.w)
 dc.w $ff60
 ori.l #$00b0ff9e,-80(a0,d0.w)
 ori.l #$00b000b0,-80(a0,d0.w)
 dc.w $00b0
 dc.w $00b0
 dc.w $ffa6
 dc.w $ff72
 dc.w $ff72
 dc.w $ff72
 ori.l #$ff2e00b0,-80(a0,d0.w)
 ori.l #$fef800b0,-80(a0,d0.w)
 dc.w $ff72
 dc.w $00b0
 ori.l #$00b0ffa6,-80(a0,d0.w)
 dc.w $00b0
 dc.w $00b0
 ori.l #$ff724aaf,8(a0,d0.w)
L002f0 equ *-4
 beq.s L002fc
 tst.l d5
 beq.s L00336
 bra.s L0033e
L002fc bra.s L00342
L002fe jsr (a2)
 move.l d0,d7
 lea _chcodes(a6),a0
 move.b (a0,d0.l),d0
 ext.w d0
 btst.l #4,d0
 bne.s L002fe
 moveq #-1,d0
 cmp.l d7,d0
 beq.s L0031c
 move.l d7,d0
 jsr (a3)
L0031c bra.s L00342
L0031e lea -56(a5),sp
 jsr (a2)
 move.l d0,d7
 move.b d4,d0
 ext.w d0
 ext.l d0
 cmp.l d0,d7
 beq.s L00342
 moveq #-1,d0
 cmp.l d7,d0
 bne.s L0033a
L00336 moveq #-1,d0
 bra.s L00372
L0033a move.l d7,d0
 jsr (a3)
L0033e move.l d5,d0
 bra.s L00372
L00342 move.b (a4)+,d4
 move.b d4,d0
 ext.w d0
 cmpi.w #13,d0
 beq.s L002fe
 bhi.s L0035e
 cmpi.b #9,d0
 beq.s L002fe
 bhi.s L0031e
 tst.b d0
 beq.s L0033e
 bra.s L0031e
L0035e cmpi.w #37,d0
 beq.w L000fc
 bhi.s L0031e
 cmpi.b #32,d0
 beq.w L002fe
 bra.s L0031e
L00372 lea 16(sp),sp
 movem.l -32(a5),a0/a2-a4/d4-d7
 unlk a5
 rts 
L00380 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 movea.l 48(sp),a3
 movea.l 64(sp),a4
 move.l #-148,d0
 bsr.w _stkcheck
 lea -80(sp),sp
 moveq #0,d7
 moveq #0,d0
 move.l d0,4(sp)
 move.l d0,8(sp)
 move.l d0,12(sp)
 bra.s L003c2
L003b2 moveq #8,d6
 bra.s L003ec
L003b6 moveq #16,d6
 bra.s L003ec
L003ba moveq #0,d6
 bra.s L003ec
L003be moveq #10,d6
 bra.s L003ec
L003c2 move.l 132(sp),d0
 cmpi.l #111,d0
 beq.s L003b2
 bhi.s L003e2
 cmpi.b #102,d0
 beq.s L003ba
 bhi.s L003be
 cmpi.l #101,d0
 beq.s L003ba
 bra.s L003be
L003e2 cmpi.l #120,d0
 beq.s L003b6
 bra.s L003be
L003ec jsr (a2)
 move.b d0,d5
 ext.w d0
 ext.l d0
 lea _chcodes(a6),a0
 move.b (a0,d0.l),d0
 ext.w d0
 btst.l #4,d0
 bne.s L003ec
 tst.l d6
 bne.w L004d2
 lea 16(sp),a0
 move.l a0,d4
 clr.l (sp)
 moveq #63,d0
 cmp.l 136(sp),d0
 bge.s L00420
 moveq #63,d0
 move.l d0,136(sp)
L00420 cmpi.b #45,d5
 bne.s L0042e
 movea.l d4,a0
 addq.l #1,d4
 move.b d5,(a0)
 bra.s L00436
L0042e cmpi.b #43,d5
 bne.w L004c6
L00436 subq.l #1,136(sp)
 bra.w L004c2
L0043e move.b d5,d0
 ext.w d0
 ext.l d0
 lea _chcodes(a6),a0
 move.b (a0,d0.l),d0
 ext.w d0
 btst.l #3,d0
 beq.s L00458
 addq.l #1,(sp)
 bra.s L004bc
L00458 cmpi.b #46,d5
 bne.s L0046c
 tst.l 4(sp)
 bne.s L0046c
 moveq #1,d0
 move.l d0,4(sp)
 bra.s L004bc
L0046c cmpi.b #101,d5
 beq.s L0047a
 cmpi.b #69,d5
 bne.w L005ce
L0047a tst.l 12(sp)
 bne.w L005ce
 tst.l (sp)
 beq.w L005ce
 moveq #1,d0
 move.l d0,12(sp)
 movea.l d4,a0
 addq.l #1,d4
 move.b d5,(a0)
 jsr (a2)
 move.b d0,d5
 cmpi.b #45,d5
 beq.s L004bc
 cmpi.b #43,d5
 beq.s L004bc
 move.b d5,d0
 ext.w d0
 ext.l d0
 lea _chcodes(a6),a0
 move.b (a0,d0.l),d0
 ext.w d0
 btst.l #3,d0
 beq.w L005ce
L004bc movea.l d4,a0
 addq.l #1,d4
 move.b d5,(a0)
L004c2 jsr (a2)
 move.b d0,d5
L004c6 subq.l #1,136(sp)
 bge.w L0043e
 bra.w L005ce
L004d2 cmpi.b #45,d5
 bne.s L004e0
 moveq #1,d0
 move.l d0,8(sp)
 bra.s L004e6
L004e0 cmpi.b #43,d5
 bne.s L004ea
L004e6 jsr (a2)
 move.b d0,d5
L004ea lea 16(sp),a0
 move.l a0,d4
 bra.w L005bc
L004f4 move.b d5,d0
 ext.w d0
 ext.l d0
 lea _chcodes(a6),a0
 move.b (a0,d0.l),d0
 ext.w d0
 btst.l #3,d0
 beq.w L005c2
 cmpi.b #56,d5
 bge.w L005c2
 move.l d7,d0
 lsl.l #3,d0
 bra.s L00586
L0051a move.b d5,d0
 ext.w d0
 ext.l d0
 lea _chcodes(a6),a0
 move.b (a0,d0.l),d0
 ext.w d0
 btst.l #6,d0
 beq.w L005c2
 lsl.l #4,d7
 move.b d5,d0
 ext.w d0
 ext.l d0
 lea _chcodes(a6),a0
 move.b (a0,d0.l),d0
 ext.w d0
 btst.l #3,d0
 beq.s L00556
 move.b d5,d0
 ext.w d0
 subi.w #48,d0
 ext.l d0
 bra.s L00564
L00556 move.b d5,d0
 ext.w d0
 ext.l d0
 bsr.w toupper
 moveq #55,d1
 sub.l d1,d0
L00564 add.l d0,d7
 bra.s L00594
L00568 move.b d5,d0
 ext.w d0
 ext.l d0
 lea _chcodes(a6),a0
 move.b (a0,d0.l),d0
 ext.w d0
 btst.l #3,d0
 beq.s L005c2
 move.l d7,d0
 moveq #10,d1
 bsr.w _T$UMul
L00586 move.b d5,d1
 ext.w d1
 ext.l d1
 add.l d1,d0
 moveq #48,d1
 sub.l d1,d0
 move.l d0,d7
L00594 moveq #0,d4
 bra.s L005b8
L00598 cmpi.l #255,d6
 bhi.s L005c2
 cmpi.b #8,d6
 beq.w L004f4
 cmpi.b #10,d6
 beq.s L00568
 cmpi.b #16,d6
 beq.w L0051a
 bra.s L005c2
L005b8 jsr (a2)
 move.b d0,d5
L005bc subq.l #1,136(sp)
 bge.s L00598
L005c2 tst.l 8(sp)
 beq.s L005ce
 move.l d7,d0
 neg.l d0
 move.l d0,d7
L005ce cmpi.b #-1,d5
 beq.s L005e4
 move.b d5,d0
 ext.w d0
 ext.l d0
 movea.l 84(sp),a0
 jsr (a0)
 clr.l (a4)
 bra.s L005ea
L005e4 move.l #1,(a4)
L005ea move.l a3,d0
 beq.s L005f6
 lea 16(sp),a0
 cmpa.l d4,a0
 bne.s L005fc
L005f6 moveq #0,d0
 bra.w L00674
L005fc tst.l d6
 bne.s L00656
 movea.l d4,a0
 clr.b (a0)
 bra.s L0062c
L00606 lea 16(sp),a0
 move.l a0,d0
 bsr.w atof
 tcall #T$Math1,#T$DtoF
 movea.l (a3),a0
 move.l d0,(a0)
 bra.s L00672
L0061a lea 16(sp),a0
 move.l a0,d0
 bsr.w atof
 movea.l (a3),a0
 movem.l d0-d1,(a0)
 bra.s L00672
L0062c move.l 140(sp),d0
 cmpi.l #255,d0
 bhi.s L00672
 tst.b d0
 beq.s L00606
 cmpi.b #1,d0
 beq.s L00606
 cmpi.b #2,d0
 beq.s L0061a
 bra.s L00672
L0064a movea.l (a3),a0
 move.w d7,(a0)
 bra.s L00672
L00650 movea.l (a3),a0
 move.l d7,(a0)
 bra.s L00672
L00656 move.l 140(sp),d0
 cmpi.l #255,d0
 bhi.s L00672
 tst.b d0
 beq.s L0064a
 cmpi.b #1,d0
 beq.s L00650
 cmpi.b #2,d0
 beq.s L00650
L00672 moveq #1,d0
L00674 lea 80(sp),sp
 movem.l -32(a5),a0/a2-a4/d4-d7
 unlk a5
 rts 
L00682 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d6,-(sp)
 movea.l d0,a2
 movea.l 44(sp),a3
 movea.l 56(sp),a4
 move.l #-68,d0
 bsr.w _stkcheck
 clr.l (a4)
 move.l a3,d5
 moveq #99,d0
 cmp.l 48(sp),d0
 bne.s L006ba
 cmpi.l #2147483647,52(sp)
 bne.s L006ba
 moveq #1,d0
 move.l d0,52(sp)
L006ba moveq #0,d6
 moveq #115,d0
 cmp.l 48(sp),d0
 bne.s L006ce
 moveq #1,d6
 bra.s L006ce
L006c8 cmpi.b #-1,d4
 beq.s L006f4
L006ce jsr (a2)
 move.b d0,d4
 ext.w d0
 ext.l d0
 lea D00000(a6),a0
 move.b (a0,d0.l),d0
 ext.w d0
 ext.l d0
 and.l d6,d0
 bne.s L006c8
 bra.s L006f4
L006e8 moveq #0,d6
 bra.s L0071a
L006ec moveq #2,d6
 bra.s L0071a
L006f0 moveq #1,d6
 bra.s L0071a
L006f4 move.l 48(sp),d0
 cmpi.l #91,d0
 beq.s L006ec
 cmpi.l #99,d0
 beq.s L006e8
 bra.s L006f0
L0070a move.l a3,d0
 beq.s L00710
 move.b d4,(a3)+
L00710 subq.l #1,52(sp)
 ble.s L00736
 jsr (a2)
 move.b d0,d4
L0071a cmpi.b #-1,d4
 beq.s L00736
 move.b d4,d0
 ext.w d0
 ext.l d0
 lea D00000(a6),a0
 move.b (a0,d0.l),d0
 ext.w d0
 ext.l d0
 and.l d6,d0
 beq.s L0070a
L00736 cmpi.b #-1,d4
 beq.s L00752
 tst.l 52(sp)
 ble.s L0074e
 move.b d4,d0
 ext.w d0
 ext.l d0
 movea.l 4(sp),a0
 jsr (a0)
L0074e clr.l (a4)
 bra.s L00758
L00752 move.l #1,(a4)
L00758 move.l a3,d0
 beq.s L0076e
 cmpa.l d5,a3
 beq.s L0076e
 moveq #99,d0
 cmp.l 48(sp),d0
 beq.s L0076a
 clr.b (a3)+
L0076a moveq #1,d0
 bra.s L00770
L0076e moveq #0,d0
L00770 movem.l -28(a5),a0/a2-a4/d4-d6
 unlk a5
 rts 
L0077a link.w a5,#0
 movem.l a0/a2/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 move.l #-64,d0
 bsr.w _stkcheck
 moveq #0,d5
 cmpi.b #94,(a2)
 bne.s L0079a
 moveq #1,d5
 addq.l #1,a2
L0079a moveq #0,d4
 bra.s L007ba
L0079e tst.l d5
 beq.s L007ae
 lea D00000(a6),a0
 andi.b #$fd,(a0,d4.l)
 bra.s L007b8
L007ae lea D00000(a6),a0
 bset.b #1,(a0,d4.l)
L007b8 addq.l #1,d4
L007ba cmpi.l #128,d4
 blt.s L0079e
 bra.s L007ee
L007c4 tst.l d5
 beq.s L007d8
 move.l d4,d0
 addq.l #1,d4
 lea D00000(a6),a0
 bset.b #1,(a0,d0.l)
 bra.s L007e6
L007d8 move.l d4,d0
 addq.l #1,d4
 lea D00000(a6),a0
 andi.b #$fd,(a0,d0.l)
L007e6 tst.l d4
 bne.s L007ee
 subq.l #1,a2
 bra.s L00800
L007ee move.b (a2)+,d0
 ext.w d0
 ext.l d0
 move.l d0,d4
 moveq #127,d1
 and.l d1,d0
 moveq #93,d1
 cmp.l d0,d1
 bne.s L007c4
L00800 move.l a2,d0
 movem.l -20(a5),a0/a2/d1/d4-d5
 unlk a5
 rts 
L0080c link.w a5,#0
 movem.l d0,-(sp)
 move.l #-68,d0
 bsr.w _stkcheck
 move.l D00084(a6),d0
 bsr.w getc
 unlk a5
 rts 
L0082a link.w a5,#0
 movem.l d0-d1,-(sp)
 move.l #-68,d0
 bsr.w _stkcheck
 move.l D00084(a6),d1
 move.l (sp),d0
 bsr.w ungetc
 movem.l -4(a5),d1
 unlk a5
 rts 
L00850 link.w a5,#0
 movem.l a0/d0,-(sp)
 move.l #-64,d0
 bsr.w _stkcheck
 movea.l D00080(a6),a0
 tst.b (a0)
 beq.s L0087a
 movea.l D00080(a6),a0
 addq.l #1,D00080(a6)
 move.b (a0),d0
 ext.w d0
 ext.l d0
 bra.s L0087c
L0087a moveq #-1,d0
L0087c movem.l -4(a5),a0
 unlk a5
 rts 
L00886 link.w a5,#0
 movem.l d0,-(sp)
 move.l #-64,d0
 bsr.w _stkcheck
 subq.l #1,D00080(a6)
 unlk a5
 rts 

 ends 

