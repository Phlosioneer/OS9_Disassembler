 psect access_a,$0,$0,0,0,access
access: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 move.w d1,d0
 os9 I$Open
 dc.w $6500
 dc.w $0
 os9 I$Close
 bra.w _sysret0
open: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 move.w d1,d0
 moveq #0,d2
 os9 I$Open
 bra.w _sysret
close: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 os9 I$Close
 bra.w _sysret
mknod: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 moveq #Write_,d0
 moveq #0,d2
L00050 os9 I$MakDir
 bra.w _sysret0
makdir: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 move.l d1,d0
 move.l 20(sp),d1
 move.l 24(sp),d2
 bra.s L00050
create: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 move.w d1,d0
 move.l 20(sp),d1
 move.l 24(sp),d2
 os9 I$Create
 bra.w _sysret
creat: link.w A5,#0
 movem.l a0/d0-d2,-(sp)
 movea.l d0,a0
 move.w d1,d0
 andi.w #PExec_,d1
 ori.w #Write_,d1
 moveq #0,d2
 os9 I$Create
 movea.l (sp)+,a0
 dc.w $6400
 dc.w $0
 cmpi.b #E$CEF,d1
 dc.w $6600
 dc.w $0
 move.w 2(sp),d0
 dc.w $6b00
 dc.w $0
 andi.w #Write_,d0
 os9 I$Open
 dc.w $6500
 dc.w $0
 moveq #0,d2
 moveq #SS_Size,d1
 os9 I$SetStt
 dc.w $6400
 dc.w $0
 move.w d1,d2
 os9 I$Close
 move.w d2,d1
 bra.w _os9err
unlinkx: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 move.w d1,d0
 os9 I$Delete
 bra.w _sysret0
unlink: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 moveq #Write_,d0
 os9 I$Delete
 bra.w _sysret0
dup: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 os9 I$Dup
 bra.w _sysret

 ends 

