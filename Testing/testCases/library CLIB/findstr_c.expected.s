 psect findstr_c,$0,$0,0,0,findstr
findstr: link.w A5,#0
 movem.l a2-a3/d0-d1/d4,-(sp)
 move.l d0,d4
 movea.l d1,a2
 movea.l 28(sp),a3
 move.l d4,d0
 subq.l #1,d0
 adda.l d0,a2
 bra.s L0002a
L00018 move.l a3,d1
 move.l a2,d0
 addq.l #1,a2
 bsr.s L00076
 tst.l d0
 beq.s L00028
 move.l d4,d0
 bra.s L00030
L00028 addq.l #1,d4
L0002a tst.b (a2)
 bne.s L00018
 moveq #0,d0
L00030 movem.l -12(a5),a2-a3/d4
 unlk A5
 rts 
findnstr: link.w A5,#0
 movem.l a2-a3/d0-d1/d4,-(sp)
 move.l d0,d4
 movea.l d1,a2
 movea.l 28(sp),a3
 move.l d4,d0
 subq.l #1,d0
 adda.l d0,a2
 bra.s L00064
L00052 move.l a3,d1
 move.l a2,d0
 addq.l #1,a2
 bsr.s L00076
 tst.l d0
 beq.s L00062
 move.l d4,d0
 bra.s L0006c
L00062 addq.l #1,d4
L00064 cmp.l 32(sp),d4
 ble.s L00052
 moveq #0,d0
L0006c movem.l -12(a5),a2-a3/d4
 unlk A5
 rts 
L00076 link.w A5,#0
 movem.l a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 bra.s L0008c
L00084 cmpm.b (a3)+,(a2)+
 beq.s L0008c
 moveq #0,d0
 bra.s L00092
L0008c tst.b (a3)
 bne.s L00084
 moveq #1,d0
L00092 movem.l -8(a5),a2-a3
 unlk A5
 rts 

 ends 

