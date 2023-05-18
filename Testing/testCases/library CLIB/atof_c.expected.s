 psect atof_c,$0,$0,0,0,atof
atof: link.w a5,#0
 movem.l a2/d0-d1/d4,-(sp)
 movea.l d0,a2
 subq.l #8,sp
 move.l errno(a6),d4
 moveq #0,d1
 move.l a2,d0
 bsr.w strtod
 movem.l d0-d1,(sp)
 move.l d4,errno(a6)
 movem.l (sp),d0-d1
 addq.l #8,sp
 movem.l -8(a5),a2/d4
 unlk a5
 rts 

 ends 

