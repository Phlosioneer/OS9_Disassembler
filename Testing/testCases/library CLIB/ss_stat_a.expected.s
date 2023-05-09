 psect ss_stat_a,$0,$0,0,0,_gs_opt
_gs_opt: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d1,a0
 move.w #SS_Opt,d1
L0000e os9 I$GetStt
 bra.w _sysret
_gs_rdy: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 move.w #SS_Ready,d1
 os9 I$GetStt
 dc.w $6500
 dc.w $0
 move.l d1,d0
 bra.w _sysret
_gs_eof: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 move.w #SS_EOF,d1
 os9 I$GetStt
 dc.w $6400
 dc.w $0
 cmpi.w #E$EOF,d1
 dc.w $6600
 dc.w $0
 moveq #1,d0
 bra.w _sysret
_gs_gfd: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d1,a0
 move.w #SS_FD,d1
 move.l 8(a5),d2
 bra.s L0000e
_gs_devn: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d1,a0
 move.w #SS_DevNm,d1
 bra.s L0000e
_gs_size: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 move.w #SS_Size,d1
L00082 os9 I$GetStt
 dc.w $6500
 dc.w $0
 move.l d2,d0
 bra.w _sysret
_gs_pos: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 move.w #SS_Pos,d1
 bra.s L00082
_ss_opt: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d1,a0
 move.w #SS_Opt,d1
L000ac os9 I$SetStt
 bra.w _sysret
_ss_rest: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 move.w #SS_Reset,d1
 bra.s L000ac
_ss_size: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 move.l d1,d2
 move.w #SS_Size,d1
 bra.s L000ac
_ss_pfd: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d1,a0
 move.w #SS_FD,d1
 bra.s L000ac
_ss_tiks: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 move.l d1,d2
 move.w #SS_Ticks,d1
 bra.s L000ac
_ss_lock: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 move.l d1,d2
 move.w #SS_Lock,d1
 bra.s L000ac
_ss_ssig: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 move.l d1,d2
 move.w #SS_SSig,d1
L00110 bra.s L000ac
_ss_rel: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 move.w #SS_Relea,d1
 bra.s L00110
_ss_wtrk: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 movem.l a1/d3-d4,-(sp)
 move.l d1,d2
 moveq #SS_WTrk,d1
 movem.l 8(a5),a0-a1/d3-d4
 os9 I$SetStt
 movem.l (sp)+,a1/d3-d4
 bra.w _sysret
_ss_attr: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 move.l d1,d2
 move.w #SS_Attr,d1
 bra.s L00110
_ss_enrts: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 move.w #SS_EnRTS,d1
 bra.s L00110
_ss_dsrts: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 move.w #SS_DsRTS,d1
 bra.s L00110
_ss_dcon: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 move.w d1,d2
 move.w #SS_DCOn,d1
 bra.s L00110
_ss_dcoff: link.w A5,#0
 movem.l a0/d1-d2,-(sp)
 move.w d1,d2
 move.w #SS_DCOff,d1
 bra.s L00110

 ends 

