 psect memset_a,$0,$0,0,0,memset
memset: link.w a5,#0
 movem.l a0/d0/d2,-(sp)
 movea.l d0,a0
 move.l 8(a5),d2
 cmpi.l #12,d2
 bcc.s L00026
 subq.w #1,d2
 bcs.w L000ac
L0001c move.b d1,(a0)+
 dbra d2,L0001c
 bra.w L000ac
L00026 move.l d1,-(sp)
 asl.w #8,d1
 move.b 3(sp),d1
 addq.l #4,sp
 btst.l #0,d0
 beq.s L0003c
 move.b d1,(a0)+
 subq.l #1,d2
 move.l a0,d0
L0003c btst.l #1,d0
 beq.s L00046
 move.w d1,(a0)+
 subq.l #2,d2
L00046 move.w d1,d0
 swap.w d1
 move.w d0,d1
 moveq #96,d0
 cmp.l d0,d2
 bcs.s L00090
 move.l d2,d0
 and.w #31,d2
 eor.w d2,d0
 lea.l (a0,d0.l),a0
 movem.l a0-a2/d3-d7,-(sp)
 move.l d1,d3
 move.l d1,d4
 move.l d1,d5
 move.l d1,d6
 move.l d1,d7
 movea.l d1,a1
 movea.l d1,a2
 lsr.l #5,d0
 subq.l #1,d0
L00074 movem.l a1-a2/d1/d3-d7,-(a0)
 dbra d0,L00074
 addq.w #1,d0
 subq.l #1,d0
 bcc.s L00074
 movem.l (sp)+,a0-a2/d3-d7
 move.w d2,d0
 beq.s L000ac
 lsr.w #2,d0
 bne.s L00094
 bra.s L0009c
L00090 move.w d2,d0
 lsr.w #2,d0
L00094 subq.w #1,d0
L00096 move.l d1,(a0)+
 dbra d0,L00096
L0009c btst.l #1,d2
 beq.s L000a4
 move.w d1,(a0)+
L000a4 btst.l #0,d2
 beq.s L000ac
 move.b d1,(a0)
L000ac movem.l -12(a5),a0/d0/d2
 unlk a5
 rts 

 ends 

