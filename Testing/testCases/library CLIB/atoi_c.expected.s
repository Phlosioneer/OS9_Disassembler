 psect atoi_c,$0,$0,0,0,atoi
atoi: link.w A5,#0
 movem.l a2/d0-d1,-(sp)
 movea.l d0,a2
L0000a pea (L0000a).w
 moveq #0,d1
 move.l a2,d0
 bsr.w strtol
 addq.l #4,sp
 movem.l -8(a5),a2/d1
 unlk A5
 rts 

 ends 

