 psect memcpy_c,$0,$0,0,0,memmove
memmove: link.w a5,#0
 movem.l a0-a2/d0-d2,-(sp)
 movea.l d0,a0
 movea.l d1,a2
 move.l 8(a5),d2
 beq.s L00014
 bsr.s L0001e
L00014 movem.l -24(a5),a0-a2/d0-d2
 unlk a5
 rts 
L0001e tst.l d2
 beq.s L0006c
 cmpa.l a2,a0
 bhi.s L0006e
 beq.s L0006c
 move.w a2,d0
 btst.l #0,d0
 beq.s L00034
 move.b (a2)+,(a0)+
 subq.l #1,d2
L00034 move.w a0,d0
 btst.l #0,d0
 bne.s L00060
 lsr.l #1,d2
 bcc.s L00046
 bsr.s L00046
 move.b (a2)+,(a0)+
 rts 
L00046 lsr.l #1,d2
 bcc.s L00050
 move.w (a2)+,(a0)+
 bra.s L00050
L0004e move.l (a2)+,(a0)+
L00050 dbra d2,L0004e
 addq.w #1,d2
 subq.l #1,d2
 bcc.s L0004e
 moveq #0,d2
 rts 
L0005e move.b (a2)+,(a0)+
L00060 dbra d2,L0005e
 addq.w #1,d2
 subq.l #1,d2
 bcc.s L0005e
 moveq #0,d2
L0006c rts 
L0006e adda.l d2,a2
 adda.l d2,a0
 move.w a2,d0
 btst.l #0,d0
 beq.s L0007e
 move.b -(a2),-(a0)
 subq.l #1,d2
L0007e move.w a0,d0
 btst.l #0,d0
 bne.s L000aa
 lsr.l #1,d2
 bcc.s L00090
 bsr.s L00090
 move.b -(a2),-(a0)
 rts 
L00090 lsr.l #1,d2
 bcc.s L0009a
 move.w -(a2),-(a0)
 bra.s L0009a
L00098 move.l -(a2),-(a0)
L0009a dbra d2,L00098
 addq.w #1,d2
 subq.l #1,d2
 bcc.s L00098
 moveq #0,d2
 rts 
L000a8 move.b -(a2),-(a0)
L000aa dbra d2,L000a8
 addq.w #1,d2
 subq.l #1,d2
 bcc.s L000a8
 moveq #0,d2
 rts 

 ends 

