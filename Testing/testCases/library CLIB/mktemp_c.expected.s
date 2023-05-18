 psect mktemp_c,$0,$0,0,0,mktemp
mktemp: link.w a5,#0
 movem.l a2-a3/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 bsr.w getpid
 move.l d0,d5
 movea.l a2,a3
L00012 tst.b (a2)+
 bne.s L00012
 subq.l #1,a2
 bra.s L00032
L0001a move.l d5,d0
 moveq #10,d1
 bsr.w _T$LMod
 addi.b #48,d0
 move.b d0,(a2)
 moveq #10,d1
 move.l d5,d0
 bsr.w _T$LDiv
 move.l d0,d5
L00032 cmpi.b #88,-(a2)
 beq.s L0001a
 addq.l #1,a2
 moveq #97,d4
 bra.s L0004c
L0003e moveq #122,d0
 cmp.l d4,d0
 bne.s L00048
 moveq #0,d0
 bra.s L0005c
L00048 move.b d4,(a2)
 addq.l #1,d4
L0004c moveq #0,d1
 move.l a3,d0
 bsr.w access
 moveq #255,d1
 cmp.l d0,d1
 bne.s L0003e
 move.l a3,d0
L0005c movem.l -20(a5),a2-a3/d1/d4-d5
 unlk a5
 rts 

 ends 

