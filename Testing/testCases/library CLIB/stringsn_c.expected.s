 psect stringsn_c,$0,$0,0,0,strncpy
strncpy: link.w A5,#0
 movem.l a2-a4/d0-d1/d4,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l 32(sp),d4
 movea.l a2,a4
L00012 subq.l #1,d4
 blt.s L0001e
 move.b (a3)+,(a4)+
 bne.s L00012
 bra.s L0001e
L0001c clr.b (a4)+
L0001e subq.l #1,d4
 bge.s L0001c
 move.l a2,d0
 movem.l -16(a5),a2-a4/d4
 unlk A5
 rts 
strncmp: link.w A5,#0
 movem.l a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l 28(sp),d4
 bra.s L00046
L00040 tst.b (a3)+
 beq.s L00054
 addq.l #1,a2
L00046 subq.l #1,d4
 blt.s L00050
 move.b (a2),d0
 cmp.b (a3),d0
 beq.s L00040
L00050 tst.l d4
 bge.s L00058
L00054 moveq #0,d0
 bra.s L00066
L00058 move.b (a3),d0
 ext.w d0
 move.b (a2),d1
 ext.w d1
 sub.w d0,d1
 ext.l d1
 move.l d1,d0
L00066 movem.l -12(a5),a2-a3/d4
 unlk A5
 rts 
strncat: link.w A5,#0
 movem.l a2-a4/d0-d1/d4,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l 32(sp),d4
 movea.l a2,a4
L00082 tst.b (a4)+
 bne.s L00082
 subq.l #1,a4
L00088 subq.l #1,d4
 blt.s L00090
 move.b (a3)+,(a4)+
 bne.s L00088
L00090 tst.l d4
 bge.s L00096
 clr.b (a4)
L00096 move.l a2,d0
 movem.l -16(a5),a2-a4/d4
 unlk A5
 rts 

 ends 

