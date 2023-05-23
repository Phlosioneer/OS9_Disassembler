 psect stat_a,0,0,0,0,getstat

getstat: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 exg d0,d1
 tst.l d1
 beq.s L00050
 cmpi.b #1,d1
 beq.s L00042
 cmpi.b #6,d1
 beq.s L00054
 cmpi.b #2,d1
 beq.s L00030
 cmpi.b #5,d1
 beq.s L00030
L00026 moveq E$UnkSvc,d1
 ori #1,ccr
 bra.w _os9err
L00030 os9 I$GetStt
 bcs.w _os9err
 movea.l 8(a5),a0
 move.l d2,(a0)
 bra.w _sysret0
L00042 os9 I$GetStt
 bcs.w _os9err
 move.l d1,d0
 bra.w _sysret
L00050 movea.l 8(a5),a0
L00054 os9 I$GetStt
 bra.w _sysret
setstat: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 exg d0,d1
 tst.l d1
 bne.s L00072
 movea.l 8(a5),a0
 moveq SS_Opt,d1
 bra.s L0007e
L00072 cmpi.b #2,d1
 bne.s L00026
 move.l 8(a5),d2
 moveq SS_Size,d1
L0007e os9 I$SetStt
 bra.w _sysret

 ends 

