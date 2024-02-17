 psect os9exec_c,0,0,0,0,L00000


* D
 vsect 
D00000 ds.b 4


 ends 

L00000 link.w a5,#0
 movem.l a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 movea.l d1,a3
L0000c move.b (a3)+,(a2)+
 bne.s L0000c
 move.b #32,-1(a2)
 move.l a2,d0
 movem.l -8(a5),a2-a3
 unlk a5
 rts 
L00022 movem.l a0/a2,-(sp)
 os9 F$SRqMem
 bcs.s L00038
 movea.l d1,a0
 move.l d0,(a0)
 move.l a2,d0
L00032 movem.l (sp)+,a0/a2
 rts 
L00038 moveq #-1,d0
 move.l d1,errno(a6)
 bra.s L00032
L00040 move.l a2,-(sp)
 movea.l d1,a2
 os9 F$SRtMem
 movea.l (sp)+,a2
 rts 
L0004c link.w a5,#0
 movem.l a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l 28(sp),d4
 bra.s L00060
L0005e move.b (a3)+,(a2)+
L00060 subq.w #1,d4
 bge.s L0005e
 move.l a2,d0
 movem.l -12(a5),a2-a3/d4
 unlk a5
 rts 
os9exec: link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d7,-(sp)
 lea -12(sp),sp
 moveq #0,d0
 move.w d0,10(sp)
 move.w d0,4(sp)
 move.w d0,6(sp)
 moveq #0,d1
 move.w d0,d1
 move.l d1,d5
 move.l d1,d4
 move.l d1,d6
 movea.l 60(sp),a0
 move.l (a0),d0
 bsr.w strlen
 addq.l #1,d0
 move.l d0,d7
 moveq #1,d0
 and.w d7,d0
 move.w d0,8(sp)
 move.l 60(sp),d0
 addq.l #4,d0
 movea.l d0,a3
 bra.s L000c2
L000b4 move.l (a3),d0
 bsr.w strlen
 add.l d0,d4
 addq.l #4,a3
 addq.w #1,6(sp)
L000c2 tst.l (a3)
 bne.s L000b4
 movea.l 64(sp),a3
 bra.s L000da
L000cc move.l (a3),d0
 bsr.w strlen
 add.l d0,d5
 addq.l #4,a3
 addq.w #1,4(sp)
L000da tst.l (a3)
 bne.s L000cc
 moveq #0,d0
 move.w 6(sp),d0
 addq.l #1,d0
 add.l d0,d4
 moveq #0,d0
 move.w 4(sp),d0
 add.l d0,d5
 addq.w #1,6(sp)
 move.l d4,d0
 add.l d5,d0
 btst.l #0,d0
 beq.s L00102
 addq.w #1,10(sp)
L00102 move.l d4,d0
 add.l d5,d0
 moveq #0,d1
 move.w 10(sp),d1
 add.l d1,d0
 addq.l #6,d0
 add.l d7,d0
 moveq #0,d1
 move.w 8(sp),d1
 add.l d1,d0
 addq.l #2,d0
 moveq #0,d1
 move.w 6(sp),d1
 lsl.l #2,d1
 add.l d1,d0
 moveq #0,d1
 move.w 4(sp),d1
 lsl.l #2,d1
 add.l d1,d0
 addq.l #8,d0
 move.l d0,d6
 lea D00000(a6),a0
 move.l a0,d1
 move.l d6,d0
 bsr.w L00022
 movea.l d0,a4
 movea.l d0,a2
 moveq #-1,d1
 cmp.l d0,d1
 bne.s L00150
 moveq #-1,d0
 bra.w L0031a
L00150 move.l 60(sp),d0
 addq.l #4,d0
 movea.l d0,a3
 bra.s L00166
L0015a move.l (a3),d1
 move.l a2,d0
 bsr.w L00000
 movea.l d0,a2
 addq.l #4,a3
L00166 tst.l (a3)
 bne.s L0015a
 cmpi.w #1,6(sp)
 bls.s L00176
 clr.b -1(a2)
L00176 move.b #13,(a2)+
 tst.w 10(sp)
 beq.s L00182
 clr.b (a2)+
L00182 movea.l 64(sp),a3
 bra.s L00194
L00188 move.l (a3),d1
 move.l a2,d0
 bsr.w L00000
 movea.l d0,a2
 addq.l #4,a3
L00194 tst.l (a3)
 bne.s L00188
 clr.b -1(a2)
 move.l #64513,(sp)
 pea (2).w
 lea 6(sp),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L0004c
 addq.l #4,sp
 movea.l d0,a2
 move.l d4,d0
 add.l d5,d0
 moveq #0,d1
 move.w 10(sp),d1
 add.l d1,d0
 addq.l #6,d0
 move.l d0,(sp)
 pea (4).w
 lea 4(sp),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L0004c
 addq.l #4,sp
 movea.l d0,a2
 movea.l 60(sp),a0
 move.l (a0),d1
 move.l a2,d0
 bsr.w L00000
 movea.l d0,a2
 clr.b -1(a2)
 tst.w 8(sp)
 beq.s L001f4
 clr.b (a2)+
L001f4 clr.b (a2)+
 move.b #13,(a2)+
 clr.l (sp)
 pea (4).w
 lea 4(sp),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L0004c
 addq.l #4,sp
 movea.l d0,a2
 move.l 60(sp),d0
 addq.l #4,d0
 movea.l d0,a3
 bra.s L0023a
L0021a pea (4).w
 lea 4(sp),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L0004c
 addq.l #4,sp
 movea.l d0,a2
 move.l (a3),d0
 bsr.w strlen
 addq.l #1,d0
 add.l d0,(sp)
 addq.l #4,a3
L0023a tst.l (a3)
 bne.s L0021a
 clr.l (sp)
 pea (4).w
 lea 4(sp),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L0004c
 addq.l #4,sp
 movea.l d0,a2
 moveq #0,d0
 move.w 10(sp),d0
 add.l d4,d0
 move.l d0,(sp)
 movea.l 64(sp),a3
 bra.s L00284
L00264 pea (4).w
 lea 4(sp),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L0004c
 addq.l #4,sp
 movea.l d0,a2
 move.l (a3),d0
 bsr.w strlen
 addq.l #1,d0
 add.l d0,(sp)
 addq.l #4,a3
L00284 tst.l (a3)
 bne.s L00264
 clr.l (sp)
 pea (4).w
 lea 4(sp),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L0004c
 addq.l #4,sp
 movea.l d0,a2
 suba.l a2,a2
 clr.w 10(sp)
L002a4 lea -52(a5),sp
 movea.w 78(sp),a0
 move.l a0,-(sp)
 movea.w 78(sp),a0
 move.l a0,-(sp)
 move.l 76(sp),-(sp)
 clr.l -(sp)
 clr.l -(sp)
 pea (a4)
 move.l d6,d1
 move.l 40(sp),d0
 movea.l 36(sp),a0
 jsr (a0)
 lea 24(sp),sp
 move.l d0,(sp)
 moveq #-1,d1
 cmp.l d0,d1
 bne.s L00304
 cmpi.l #216,errno(a6)
 bne.s L00304
 move.w 10(sp),d0
 addq.w #1,10(sp)
 tst.w d0
 bne.s L00304
 clr.l -(sp)
 moveq #0,d1
 move.l 20(sp),d0
 bsr.w modloadp
 addq.l #4,sp
 movea.l d0,a2
 moveq #-1,d1
 cmp.l d0,d1
 bne.s L002a4
 suba.l a2,a2
L00304 move.l a2,d0
 beq.s L0030e
 move.l a2,d0
 bsr.w munlink
L0030e move.l a4,d1
 move.l D00000(a6),d0
 bsr.w L00040
 move.l (sp),d0
L0031a lea 12(sp),sp
 movem.l -32(a5),a0/a2-a4/d4-d7
 unlk a5
 rts 

 ends 

