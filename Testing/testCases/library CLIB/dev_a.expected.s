 psect dev_a,0,0,0,0,attach

attach: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 move.l d1,d0
 move.l a2,-(sp)
 os9 I$Attach
 movea.l a2,a0
 movea.l (sp)+,a2
 bcs.w _os9err
 move.l a0,d0
 bra.w _sysret
detach: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l a2,a0
 movea.l d0,a2
 os9 I$Detach
 movea.l a0,a2
 bra.w _sysret

 ends 

