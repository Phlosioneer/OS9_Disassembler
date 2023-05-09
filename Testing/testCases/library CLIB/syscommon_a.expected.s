 psect syscommon_a,$0,$0,0,0,_sysret
_sysret: bcc.s L0000e
_os9err: move.l d1,errno(a6)
 moveq #255,d0
 bra.s L0000e
_sysret0: bcs.s _os9err
 moveq #0,d0
L0000e movem.l -12(a5),a0/d1-d2
 unlk A5
 rts 

 ends 

