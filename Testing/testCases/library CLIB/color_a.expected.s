 psect color_a,0,0,0,0,srqcmem


* D
 vsect 
_srqcsiz: ds.b 4


 ends 

srqcmem: link.w a5,#0
 movem.l a2/d1,-(sp)
 os9 F$SRqCMem
 bcs.s L0001c
 move.l a2,d0
 move.l d0,_srqcsiz(a6)
L00014 movem.l (sp)+,a2/d1
 unlk a5
 rts 
L0001c moveq #255,d0
 move.l d1,errno(a6)
 bra.s L00014
modcload: link.w a5,#0
 movem.l a0-a2/d1,-(sp)
 movea.l d0,a0
 move.b d1,d0
 bset.l #7,d0
 move.l 24(sp),d1
 os9 F$Load
 bcs.s L00048
 move.l a2,d0
L00040 movem.l (sp)+,a0-a2/d1
 unlk a5
 rts 
L00048 moveq #255,d0
 move.l d1,errno(a6)
 bra.s L00040
make_module: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movem.l a1-a2/d3-d4,-(sp)
 movea.l d0,a0
 move.l d1,d0
 move.l 8(a5),d1
 move.l 12(a5),d2
 bset.l #15,d2
 move.l 16(a5),d3
 move.l 20(a5),d4
 os9 F$DatMod
 bcs.s L0007c
 move.l a2,d0
L0007c movem.l (sp)+,a1-a2/d3-d4
 bra.w _sysret

 ends 

