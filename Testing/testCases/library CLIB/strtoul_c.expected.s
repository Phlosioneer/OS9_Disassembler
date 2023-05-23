 psect strtoul_c,0,0,0,0,strtoul

strtoul: link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l 44(sp),d4
 moveq #0,d5
 moveq #0,d6
L00014 move.b (a2)+,d0
 ext.w d0
 ext.l d0
 lea _chcodes(a6),a0
 move.b (a0,d0.l),d0
 ext.w d0
 btst.l #4,d0
 bne.s L00014
 subq.l #1,a2
 move.l a3,d0
 beq.s L00032
 move.l a2,(a3)
L00032 moveq #2,d0
 cmp.l d4,d0
 bls.s L0003c
 tst.l d4
 bne.s L00066
L0003c moveq #35,d0
 cmp.l d4,d0
 bcs.s L00066
 bra.s L0007a
L00044 addq.l #1,d5
L00046 addq.l #1,a2
L00048 cmpi.b #120,1(a2)
 beq.s L00058
 cmpi.b #88,1(a2)
 bne.s L00070
L00058 tst.l d4
 bne.s L00060
 moveq #16,d4
 bra.s L0006c
L00060 moveq #16,d0
 cmp.l d4,d0
 beq.s L0006c
L00066 moveq #0,d0
 bra.w L00182
L0006c addq.l #2,a2
 bra.s L00096
L00070 tst.l d4
 bne.s L00096
 moveq #8,d4
 addq.l #1,a2
 bra.s L00096
L0007a move.b (a2),d0
 ext.w d0
 cmpi.w #255,d0
 bhi.s L00096
 cmpi.b #43,d0
 beq.s L00046
 cmpi.b #45,d0
 beq.s L00044
 cmpi.b #48,d0
 beq.s L00048
L00096 tst.l d4
 bne.s L0009c
 moveq #10,d4
L0009c moveq #10,d0
 cmp.l d4,d0
 bcs.w L00122
 bra.s L000ce
L000a6 moveq #255,d0
 sub.l d7,d0
 move.l d4,d1
 bsr.w _T$UDiv
 cmp.l d6,d0
 bcs.s L000c2
 move.l d6,d0
 move.l d4,d1
 bsr.w _T$UMul
 add.l d7,d0
 move.l d0,d6
 bra.s L000cc
L000c2 move.l #256,errno(a6)
 moveq #255,d6
L000cc addq.l #1,a2
L000ce move.b (a2),d0
 ext.w d0
 ext.l d0
 lea _chcodes(a6),a0
 move.b (a0,d0.l),d0
 ext.w d0
 btst.l #3,d0
 beq.w L00170
 move.b (a2),d0
 ext.w d0
 subi.w #48,d0
 ext.l d0
 move.l d0,d7
 cmp.l d4,d0
 bcs.s L000a6
 bra.w L00170
L000fa moveq #255,d0
 sub.l d7,d0
 move.l d4,d1
 bsr.w _T$UDiv
 cmp.l d6,d0
 bcs.s L00116
 move.l d6,d0
 move.l d4,d1
 bsr.w _T$UMul
 add.l d7,d0
 move.l d0,d6
 bra.s L00120
L00116 move.l #256,errno(a6)
 moveq #255,d6
L00120 addq.l #1,a2
L00122 move.b (a2),d0
 ext.w d0
 ext.l d0
 lea _chcodes(a6),a0
 move.b (a0,d0.l),d0
 ext.w d0
 btst.l #3,d0
 beq.s L00146
 move.b (a2),d0
 ext.w d0
 subi.w #48,d0
 ext.l d0
 move.l d0,d7
 bra.s L000fa
L00146 move.b (a2),d0
 ext.w d0
 ext.l d0
 lea _chcodes(a6),a0
 move.b (a0,d0.l),d0
 ext.w d0
 andi.w #$0006,d0
 beq.s L00170
 move.b (a2),d0
 ext.w d0
 andi.w #$00df,d0
 ext.l d0
 moveq #55,d1
 sub.l d1,d0
 move.l d0,d7
 cmp.l d4,d0
 bcs.s L000fa
L00170 move.l a3,d0
 beq.s L00176
 move.l a2,(a3)
L00176 tst.l d5
 beq.s L00180
 move.l d6,d0
 neg.l d0
 move.l d0,d6
L00180 move.l d6,d0
L00182 movem.l -28(a5),a0/a2-a3/d4-d7
 unlk a5
 rts 

 ends 

