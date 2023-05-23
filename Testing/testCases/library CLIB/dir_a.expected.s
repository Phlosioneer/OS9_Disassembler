 psect dir_a,0,0,0,0,chdir

chdir: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 moveq Updat_,d1
L0000a movea.l d0,a0
 exg d0,d1
 os9 I$ChgDir
 bra.w _sysret0
chxdir: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 moveq Exec_,d1
 bra.s L0000a

 ends 

