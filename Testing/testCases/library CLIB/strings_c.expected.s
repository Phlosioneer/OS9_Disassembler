 psect strings_c,0,0,0,0,strcmp

strcmp: move.l a0,-(sp)
 movea.l d0,a0
 eor.b d1,d0
 btst.l #0,d0
 bne.s L0005e
 btst.l #0,d1
 exg d1,a1
 beq.s L0002c
 cmpm.b (a1)+,(a0)+
 bcs.s L00048
 bhi.s L0003a
 tst.b -1(a0)
 bne.s L0002c
 bra.s L00056
L00022 tst.b d0
 beq.s L00056
 cmpi.w #255,d0
 bls.s L00056
L0002c move.w (a0)+,d0
 cmp.w (a1)+,d0
 beq.s L00022
 bcs.s L00042
 cmpi.w #255,d0
 bls.s L00050
L0003a moveq #1,d0
 movea.l (sp)+,a0
 exg d1,a1
 rts 
L00042 cmpi.w #255,d0
 bls.s L00050
L00048 moveq #255,d0
 movea.l (sp)+,a0
 exg d1,a1
 rts 
L00050 tst.b -2(a1)
 bne.s L00048
L00056 moveq #0,d0
 movea.l (sp)+,a0
 exg d1,a1
 rts 
L0005e exg d1,a1
 moveq #0,d0
L00062 move.b (a0)+,d0
 cmp.b (a1)+,d0
 dbne d0,L00062
 bcs.s L00048
 addq.w #1,d0
 movea.l (sp)+,a0
 exg d1,a1
 rts 
strlen: move.l a0,-(sp)
 movea.l d0,a0
L00078 tst.b (a0)+
 beq.s L00088
 tst.b (a0)+
 beq.s L00088
 tst.b (a0)+
 beq.s L00088
 tst.b (a0)+
 bne.s L00078
L00088 suba.l d0,a0
 move.l a0,d0
 subq.l #1,d0
 movea.l (sp)+,a0
 rts 
strcpy: move.l a0,-(sp)
 movea.l d0,a0
 exg d1,a1
L00098 move.b (a1)+,(a0)+
 beq.s L000a8
 move.b (a1)+,(a0)+
 beq.s L000a8
 move.b (a1)+,(a0)+
 beq.s L000a8
 move.b (a1)+,(a0)+
 bne.s L00098
L000a8 movea.l (sp)+,a0
 exg d1,a1
 rts 
strcat: move.l a0,-(sp)
 movea.l d0,a0
 exg d1,a1
L000b4 tst.b (a0)+
 beq.s L000c4
 tst.b (a0)+
 beq.s L000c4
 tst.b (a0)+
 beq.s L000c4
 tst.b (a0)+
 bne.s L000b4
L000c4 move.b (a1)+,-1(a0)
 bne.s L00098
 bra.s L000a8
strhcpy: move.l a0,-(sp)
 movea.l d0,a0
 exg d1,a1
L000d2 move.b (a1)+,(a0)+
 bpl.s L000d2
 clr.b (a0)
 andi.b #$7f,-(a0)
 movea.l (sp)+,a0
 exg d1,a1
 rts 

 ends 

