 psect iobinit_c,$0,$0,0,0,_iobinit

* D
 vsect 
_iob: ds.b 12
D0000c ds.b 2
D0000e ds.b 26
D00028 ds.b 2
D0002a ds.b 26
D00044 ds.b 2
D00046 ds.b 826


 ends 

_iobinit: link.w a5,#0
 movem.l d0,-(sp)
 move.w #65,D0000c(a6)
 clr.w D0000e(a6)
 move.w #2,D00028(a6)
 move.w #1,D0002a(a6)
 move.w #2,D00044(a6)
 move.w #2,D00046(a6)
 unlk a5
 rts 

 ends 

