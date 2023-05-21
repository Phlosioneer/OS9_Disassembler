 psect change_a,$0,$0,0,0,chmod
chmod: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.l d1,d2
 movea.l d0,a0
 moveq #0,d0
 os9 I$Open
 bcs.w _os9err
 moveq SS_Attr,d1
 os9 I$SetStt
 bcc.s L0005c
L0001e move.l d1,d2
 os9 I$Close
 move.l d2,d1
 bra.w _os9err
chown: link.w a5,#-28
 movem.l a0/d1-d2,-12(a5)
 movea.l d0,a0
 moveq #2,d0
 os9 I$Open
 bcs.s L0001e
 moveq SS_FD,d1
 moveq #16,d2
 lea (sp),a0
 os9 I$GetStt
 bcs.s L0001e
 move.b 17(sp),FD_OWN(sp)
 move.b 19(sp),FD_OWN+1(sp)
 os9 I$SetStt
 bcs.s L0001e
L0005c os9 I$Close
 bra.w _sysret0

 ends 

