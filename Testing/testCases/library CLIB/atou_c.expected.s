 psect atou_c,$0,$0,0,0,_atou
_atou: link.w a5,#0
 movem.l a2/d0-d1,-(sp)
 movea.l d0,a2
L0000a pea (L0000a).w
 moveq #0,d1
 move.l a2,d0
 bsr.w strtoul
 addq.l #4,sp
 movem.l -8(a5),a2/d1
 unlk a5
 rts 

 ends 

