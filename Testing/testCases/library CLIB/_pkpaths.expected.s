 psect _pkpaths,$0,$0,1,0,_pkpaths
_pkpaths: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 moveq SS_Lock,d1
 os9 I$SetStt
 bcs.w _os9err
 movea.l (sp),a0
 move.l d0,(a0)
 movea.l 8(a5),a0
 move.l d1,(a0)
 bra.w _sysret

 ends 

