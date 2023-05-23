 psect misc_a,0,0,0,0,pause

pause: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 moveq #0,d0
 os9 F$Sleep
 bra.w _sysret
crc: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l 8(a5),a0
 move.l (a0),d1
 movea.l d0,a0
 move.l (sp),d0
 os9 F$CRC
 bcs.w _os9err
 movea.l 8(a5),a0
 move.l d1,(a0)
 bra.w _sysret0
prerr: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 os9 F$PErr
 bra.w _sysret
sleep: lsl.l #8,d0
 bset.l #31,d0
tsleep: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 os9 F$Sleep
 bra.w _sysret
_cmpnam: link.w a5,#0
 movem.l a0-a1,-(sp)
 movea.l d1,a0
 movea.l d0,a1
 move.l 8(a5),d1
 os9 F$CmpNam
 bcs.s L000d2
 moveq #0,d0
 bra.s L000de
_prsnam: link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 movea.l d0,a0
 os9 F$PrsNam
 bcc.s L000da
 bra.s L000d2
_parsepath: link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 movea.l d0,a0
 movea.l a0,a1
L00094 move.b (a1)+,d0
 cmpi.b #47,d0
 beq.s L000b6
 cmpi.b #46,d0
 bne.s L000c4
L000a2 cmpi.b #46,(a1)+
 beq.s L000a2
 move.b -(a1),d0
 beq.s L000da
 cmpi.b #47,d0
 bne.s L000c4
 movea.l a1,a0
 bra.s L00094
L000b6 move.b (a1)+,d0
 cmpi.b #47,d0
 beq.s L000c4
 cmpi.b #46,d0
 beq.s L000a2
L000c4 os9 F$PrsNam
 bcs.s L000d2
 tst.b d0
 beq.s L000da
 movea.l a1,a0
 bra.s L00094
L000d2 move.l d1,errno(a6)
 moveq #255,d0
 bra.s L000de
L000da move.l a1,d0
 sub.l (sp),d0
L000de movem.l -12(a5),a0-a1/d1
 unlk a5
 rts 
_mkdata_module: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movem.l a1-a2/d3-d4,-(sp)
 move.l 12(a5),d2
 btst.l #15,d2
 beq.s L00106
 move.l 16(a5),d3
 move.l 20(a5),d4
L00106 movea.l d0,a0
 move.l d1,d0
 move.l 8(a5),d1
 os9 F$DatMod
 bcs.s L00116
 move.l a2,d0
L00116 movem.l (sp)+,a1-a2/d3-d4
 bra.w _sysret
_get_module_dir: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 os9 F$GModDr
 bcs.w _os9err
 move.l d1,d0
 bra.w _sysret
_get_process_table: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 os9 F$GPrDBT
 bcs.w _os9err
 move.l d1,d0
 bra.w _sysret
_get_process_desc: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l 8(a5),a0
 os9 F$GPrDsc
 bra.w _sysret
_setcrc: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 os9 F$SetCRC
 bra.w _sysret
_getsys: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 bset.l #31,d1
 bra.s L0018e
_setsys: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.l 8(a5),d2
L0018e os9 F$SetSys
 bcs.w _os9err
 move.l d2,d0
 bra.w _sysret
_suspend: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 os9 F$SSpd
 bra.w _sysret
_sysdbg: link.w a5,#0
 os9 F$SysDbg
 unlk a5
 rts 
_cpymem: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.l a1,-(sp)
 movea.l 8(a5),a0
 movea.l 12(a5),a1
 os9 F$CpyMem
 movea.l (sp)+,a1
 bra.w _sysret

 ends 

