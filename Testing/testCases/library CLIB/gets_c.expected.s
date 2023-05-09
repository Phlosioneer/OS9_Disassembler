 psect gets_c,$0,$0,0,0,gets
gets: link.w A5,#0
 movem.l a0/a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 movea.l a2,a3
 bra.s L00010
L0000e move.b d4,(a3)+
L00010 lea.l _iob(a6),a0
 move.l a0,d0
 bsr.w getc
 move.l d0,d4
 moveq #13,d1
 cmp.l d0,d1
 beq.s L00028
 moveq #255,d0
 cmp.l d4,d0
 bne.s L0000e
L00028 moveq #255,d0
 cmp.l d4,d0
 bne.s L00032
 moveq #0,d0
 bra.s L00036
L00032 clr.b (a3)
 move.l a2,d0
L00036 movem.l -20(a5),a0/a2-a3/d1/d4
 unlk A5
 rts 
fgets: link.w A5,#0
 movem.l a2-a4/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 move.l d1,d4
 movea.l 36(sp),a3
 movea.l a2,a4
 bra.s L0005c
L00054 move.b d5,(a4)+
 cmpi.b #13,d5
 beq.s L0006e
L0005c subq.l #1,d4
 ble.s L0006e
 move.l a3,d0
 bsr.w getc
 move.l d0,d5
 moveq #255,d1
 cmp.l d0,d1
 bne.s L00054
L0006e clr.b (a4)
 moveq #255,d0
 cmp.l d5,d0
 bne.s L0007e
 cmpa.l a2,a4
 bne.s L0007e
 moveq #0,d0
 bra.s L00080
L0007e move.l a2,d0
L00080 movem.l -20(a5),a2-a4/d4-d5
 unlk A5
 rts 

 ends 

