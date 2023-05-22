 psect globals_a,$0,$0,0,0,_os9glob
_os9glob: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 move.l d1,d0
 os9 F$Global
 bra.w _sysret

 ends 

