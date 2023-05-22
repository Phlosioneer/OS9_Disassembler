 psect strass_c,$0,$0,0,0,_strass
_strass: movem.l a0-a1,-(sp)
 movea.l d0,a0
 movea.l d1,a1
 move.l 12(sp),d0
 bra.s L00010
L0000e move.b (a1)+,(a0)+
L00010 dbf d0,L0000e
 movem.l (sp)+,a0-a1
 rts 

 ends 

