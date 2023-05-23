 psect mod_a,0,0,0,0,modlink

modlink: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 move.w d1,d0
 movem.l a1-a2,-(sp)
 os9 F$Link
L00014 bcs.s L00018
 move.l a2,d0
L00018 movem.l (sp)+,a1-a2
 bra.w _sysret
modload: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 move.w d1,d0
 movem.l a1-a2,-(sp)
 os9 F$Load
 bra.s L00014
munlink: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.l a2,-(sp)
 movea.l d0,a2
 os9 F$UnLink
 movea.l (sp)+,a2
 bra.w _sysret
munload: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 move.w d1,d0
 os9 F$UnLoad
 bra.w _sysret

 ends 

