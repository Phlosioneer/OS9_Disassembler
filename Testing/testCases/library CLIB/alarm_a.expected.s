 psect alarm_a,$0,$0,0,0,alm_delete
alm_delete: link.w A5,#0
 move.l d1,-(sp)
 moveq #A$Delete,d1
 os9 F$Alarm
 bcs.s L00016
 moveq #0,d0
L00010 move.l (sp)+,d1
 unlk A5
 rts 
L00016 move.l d1,errno(a6)
 moveq #255,d0
 bra.s L00010
alm_set: link.w A5,#0
 movem.l d1-d4,-(sp)
 move.l d1,d3
 moveq #A$Set,d1
L0002a move.w d0,d2
 moveq #0,d0
 os9 F$Alarm
 bcc.s L0003a
 move.l d1,errno(a6)
 moveq #255,d0
L0003a movem.l (sp)+,d1-d4
 unlk A5
 rts 
alm_cycle: link.w A5,#0
 movem.l d1-d4,-(sp)
 move.l d1,d3
 moveq #A$Cycle,d1
 bra.s L0002a
alm_atdate: link.w A5,#0
 movem.l d1-d4,-(sp)
 move.l d1,d3
 move.w #A$AtDate,d1
L0005e move.l 24(sp),d4
 bra.s L0002a
alm_atjul: link.w A5,#0
 movem.l d1-d4,-(sp)
 move.l d1,d3
 move.w #A$AtJul,d1
 bra.s L0005e

 ends 

