 psect puts_c,$0,$0,0,0,puts
puts: link.w A5,#0
 movem.l a0/a2/d0-d1,-(sp)
 movea.l d0,a2
 lea.l _iob+28(a6),a0
 move.l a0,d1
 move.l a2,d0
 bsr.s fputs
 moveq #255,d1
 cmp.l d0,d1
 bne.s L0001e
 moveq #255,d0
 bra.s L0002a
L0001e lea.l _iob+28(a6),a0
 move.l a0,d1
 moveq #13,d0
 bsr.w putc
L0002a movem.l -12(a5),a0/a2/d1
 unlk A5
 rts 
fputs: link.w A5,#0
 movem.l a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 bra.s L0004e
L00042 move.l a3,d1
 move.b d4,d0
 ext.w d0
 ext.l d0
 bsr.w putc
L0004e move.b (a2)+,d4
 bne.s L00042
 btst.b #5,13(a3)
 beq.s L0005e
 moveq #255,d0
 bra.s L00060
L0005e moveq #0,d0
L00060 movem.l -12(a5),a2-a3/d4
 unlk A5
 rts 

 ends 

