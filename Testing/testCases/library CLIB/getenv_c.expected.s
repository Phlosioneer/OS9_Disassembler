 psect getenv_c,$0,$0,0,0,L00000
L00000 link.w a5,#0
 movem.l a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 bra.s L00014
L0000e cmpi.b #61,(a2)+
 beq.s L00026
L00014 move.b (a2),d0
 cmp.b (a3)+,d0
 beq.s L0000e
 tst.b (a2)
 bne.s L0002a
 cmpi.b #61,-1(a3)
 bne.s L0002a
L00026 move.l a3,d0
 bra.s L0002c
L0002a moveq #0,d0
L0002c movem.l -8(a5),a2-a3
 unlk a5
 rts 
getenv: link.w a5,#0
 movem.l a2-a4/d0-d1,-(sp)
 movea.l d0,a2
 movea.l environ(a6),a3
 bra.s L00056
L00046 move.l (a3)+,d1
 move.l a2,d0
 bsr.s L00000
 movea.l d0,a4
 tst.l d0
 beq.s L00056
 move.l a4,d0
 bra.s L0005c
L00056 tst.l (a3)
 bne.s L00046
 moveq #0,d0
L0005c movem.l -16(a5),a2-a4/d1
 unlk a5
 rts 

 ends 

