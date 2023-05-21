 psect id_a,$0,$0,0,0,getpid
getpid: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 os9 F$ID
 bra.w _sysret
getuid: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 os9 F$ID
 bcs.w _os9err
 move.l d1,d0
 bra.w _sysret
setuid: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.l d0,d1
 os9 F$SUser
 bra.w _sysret

 ends 

