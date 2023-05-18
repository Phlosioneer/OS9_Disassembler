 psect io_a,$0,$0,0,0,read
read: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d1,a0
 move.l 8(a5),d1
 os9 I$Read
 bcc.s L00034
L00014 cmpi.w #E$EOF,d1
 dc.w $6600
 dc.w $0
 bra.w _sysret0
readln: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d1,a0
 move.l 8(a5),d1
 os9 I$ReadLn
 bcs.s L00014
L00034 move.l d1,d0
 bra.w _sysret
write: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d1,a0
 move.l 8(a5),d1
 os9 I$Write
 bcc.s L00034
 bra.w _os9err
writeln: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d1,a0
 move.l 8(a5),d1
 os9 I$WritLn
 bcc.s L00034
 bra.w _os9err
lseek: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.b 11(a5),d1
 beq.s L0009e
 cmpi.b #1,d1
 beq.s L00094
 cmpi.b #2,d1
 beq.s L0008a
 moveq #E$BMode,d1
L00086 bra.w _os9err
L0008a moveq #SS_Size,d1
 os9 I$GetStt
 bcc.s L000a0
 bra.s L00086
L00094 moveq #SS_Pos,d1
 os9 I$GetStt
 bcc.s L000a0
 bra.s L00086
L0009e moveq #0,d2
L000a0 add.l (sp),d2
 move.l d2,d1
 os9 I$Seek
 bcs.s L00086
 move.l d1,d0
 bra.w _sysret

 ends 

