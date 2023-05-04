 psect functions,$0,$0,0,0,function_table
function_table: dc.w set_gc_args,$0000,$0000
 dc.w $0180,$0228,$0306,$0000
 dc.w $0000,$007e,$0088
driver_set_stat_dc: movem.l a0-a2/a4-a6,-(sp)
 movem.l drawControlArgs(pc),a1-a2/a4-a6/d0
 movea.l 70(a2),a0
L00022 jsr (a0)
 movem.l (sp)+,a0-a2/a4-a6
 rts 
driver_get_stat_dc: movem.w a0-a2/a4-a6,-(sp)
 movem.l drawControlArgs(pc),a1-a2/a4-a6/d0
 movea.l 74(a2),a0
 bra.s L00022
driver_set_stat_pt: movem.l a1-a6,-(sp)
 movem.l pointerArgs(pc),a1-a2/a4-a6/d0
pt_gc_common_set_call: movea.l 70(a2),a3
pt_gc_common_call: jsr (a3)
 movem.l (sp)+,a1-a6
 rts 
driver_get_stat_pt: movem.l a1-a6,-(sp)
 movem.l pointerArgs(pc),a1-a2/a4-a6/d0
 movea.l 74(a2),a3
 bra.s pt_gc_common_call
driver_set_stat_gc: movem.l a1-a6,-(sp)
 movem.l graphicsCursorArgs(pc),a1-a2/a4-a6/d0
 bra.w pt_gc_common_set_call
driver_get_stat_GC: movem.l a1-a6,-(sp)
 movem.l graphicsCursorArgs(pc),a1-a2/a4-a6/d0
 movea.l 74(a2),a3
 bra.s pt_gc_common_call
get_credits: lea.l L00080(pc),a0
L00080 equ *-2
 move.l a0,0(a5)
 rts 
get_init_confirm: move.w 4(a3),0(a5)
 rts 
drawControlArgs: dc.w $0000,$0000,$0000,$0000
 dc.w $0000,$0000,$0000,$0000
 dc.w $0000,$0000,$0000,$0000
 dc.w $0000,$0000,$0000,$0000
 dc.w $0000,$0000,$0000,$0000
 dc.w $0000,$0000,$0000,$0000
 dc.w $0000,$0000,$0000,$0000
 dc.w $0000,$0000,$0000,$0000
 dc.w $0000,$0000,$0000
pointerArgs: dc.w $0000,$0000,$0000,$0000
 dc.w $0000,$0000,$0000,$0000
 dc.w $0000,$0000,$0000,$0000
 dc.w $0000,$0000,$0000,$0000
 dc.w $0000,$0000,$0000,$0000
 dc.w $0000,$0000,$0000,$0000
 dc.w $0000,$0000,$0000,$0000
 dc.w $0000,$0000,$0000,$0000
 dc.w $0000,$0000,$0000
graphicsCursorArgs: dc.w $0000,$0000,$0000,$0000
 dc.w $0000,$0000,$0000,$0000
 dc.w $0000,$0000,$0000,$0000
 dc.w $0000,$0000,$0000,$0000
 dc.w $0000,$0000,$0000,$0000
 dc.w $0000,$0000,$0000,$0000
 dc.w $0000,$0000,$0000,$0000
 dc.w $0000,$0000,$0000,$0000
 dc.w $0000,$0000,$0000
state: dc.w $0000,$0000,$0000,$0000
 dc.w $0000,$0000,$0000,$0000
 dc.w $0000,$0000,$0000,$0000
 dc.w $0000,$0000,$0000
activate_program: movem.l a0-a1/d2-d4,-(sp)
 movea.l 32(a5),a1
 cmpa.l 14(a3),a1
 bne.w L0021e
 move.w 8(a1),d4
 move.w d4,d0
 move.w (function_table).l,d1
 move.w (function_table).l,d2
 moveq #4,d3
 and.w 0(a1),d3
 lsr.l #2,d3
 bsr.w driverSetStat_DC
 bcs.s L00222
 move.w d4,d0
 move.w #86,d1
 move.w #19,d2
 moveq #2,d3
 and.w 0(a1),d3
 lsr.l #1,d3
 bsr.w driverSetStat_DC
 bcs.s L00222
 move.l d0,d3
 add.w 6(a1),d3
 tst.l 38(a1)
 beq.s L001fc
 move.w d4,d0
 move.w (function_table).l,d1
 move.w (function_table).l,d2
 bsr.w driverSetStat_PT
 bcs.s L00222
 move.w d4,d0
 move.w (function_table).l,d1
 move.w (function_table).l,d2
 bsr.w driverSetStat_GC
 bcs.s L00222
L001fc move.w d4,d0
 move.w (function_table).l,d1
 move.w (function_table).l,d2
 move.w 2(a1),d3
 move.w 4(a1),d4
 bsr.w driverSetStat_DC
 bcs.s L00222
 bsr.w install_frame_tick_handler
 bcs.s L00222
L0021e andi #0,ccr
L00222 movem.l (sp)+,a0-a1/d2-d4
 rts 
add_program: movem.l a1-a3/d2-d3,-(sp)
 move.l a1,d3
 move.l 32(a5),d2
 cmp.l 14(a3),d2
 beq.s L00288
 movea.l d2,a2
 tst.l 14(a3)
 beq.w L0025a
 bsr.w remove_program
 tst.l 14(a3)
 beq.w L0025a
 movea.l 14(a3),a1
 move.l d2,18(a1)
 move.l a1,14(a2)
L0025a move.l d2,14(a3)
 moveq #1,d2
 and.w d2,0(a2)
 move.l d3,10(a2)
 tst.l 14(a2)
 beq.w L0027a
 movea.l 14(a2),a0
 bsr.w notify_on_deactivate
 bcs.s L0028c
L0027a movea.l a2,a0
 bsr.w notify_on_activate
 bcs.s L0028c
 bsr.w activate_program
 bcs.s L0028c
L00288 andi #0,ccr
L0028c movem.l (sp)+,a1-a3/d2-d3
 rts 
notify_on_activate: move.l 22(a0),d1
 beq.w L002e6
 bsr.w wait_for_event_lock
 move.l #-33488896,d0
 move.l a6,-(sp)
 move.l 26(a0),-(sp)
 bra.w L002c6
functions__notifyOnDeactivate: move.l 30(a0),d1
 beq.w L002e6
 bsr.w wait_for_event_lock
 move.l #-33423360,d0
 move.l a6,-(sp)
 move.l 34(a0),-(sp)
L002c6 movea.l 56(a5),a6
 movea.l 18(a0),a0
 jsr (a0)
 addq.l #4,sp
 movea.l (sp)+,a6
 tst.l d0
 beq.w L002e2
 move.l d0,d1
 ori #1,ccr
 rts 
L002e2 andi #0,ccr
L002e6 rts 
wait_for_event_lock: movem.l a0/d1,-(sp)
 movea.l 46(a0),a0
L002f0 tst.w (a0)
 beq.w L00300
 moveq #1,d0
 os9 F$Sleep
 bra.w L002f0
L00300 movem.l (sp)+,a0/d1
 rts 
return_error: movem.l a1-a3/d2,-(sp)
 moveq #1,d1
 ori #1,ccr
 movem.l (sp)+,a1-a3/d2
 rts 
remove_program: movem.l a1-a3/d2-d4,-(sp)
 tst.l 14(a3)
 beq.s LAB_000003e2
 movea.l 32(a5),a2
 cmpa.l 14(a3),a2
 bne.s LAB_000003d4
 movea.l a2,a0
 bsr.w notify_on_deactivate
 bcs.s LAB_000003e6
 bsr.w remove_program_from_list
 move.l 14(a3),32(a5)
 beq.s LAB_000003b4
 bsr.w activate_program
 bcs.s LAB_000003e6
 move.l a2,32(a5)
 movea.l 14(a3),a0
 bsr.w notify_on_activate
 bcs.s LAB_000003e6
 bra.w LAB_000003d8
LAB_000003b4: bsr.w install_frame_tick_handler
 bcs.s LAB_000003e6
 move.w 8(a2),d0
 move.w #86,d1
 move.w #14,d2
 clr.w d3
 clr.w d4
 bsr.w synthetic__executeDisplayProgram_DC
 bcs.s LAB_000003e6
 bra.w LAB_000003d8
LAB_000003d4: bsr.w remove_program_from_list
LAB_000003d8: moveq #254,d2
 and.w d2,0(a2)
 clr.l 10(a2)
LAB_000003e2: andi #0,ccr
LAB_000003e6: movem.l (sp)+,a1-a3/d2-d4
 rts 
remove_program_from_list: tst.l 18(a2)
 bne.s LAB_00000400
 cmpa.l 14(a3),a2
 bne.s LAB_0000040a
 move.l 14(a2),14(a3)
 bra.s LAB_0000040a
LAB_00000400: movea.l 18(a2),a1
 move.l 14(a2),14(a1)
LAB_0000040a: tst.l 14(a2)
 beq.s LAB_0000041a
 movea.l 14(a2),a1
 move.l 18(a2),18(a1)
LAB_0000041a: clr.l 18(a2)
 clr.l 14(a2)
 rts 
handle_close: movem.l a1-a2/d2-d3,-(sp)
 move.l a1,d2
 move.l 14(a3),d3
 move.l d3,d0
LAB_00000430: beq.s LAB_00000444
 movea.l d0,a2
 cmp.l 10(a2),d2
 bne.s LAB_0000043e
 bsr.w remove_program_from_list
LAB_0000043e: move.l 14(a2),d0
 bra.s LAB_00000430
LAB_00000444: move.l 14(a3),d2
 beq.w LAB_0000046c
 cmp.l d2,d3
 beq.s LAB_0000046c
 movea.l d2,a0
 bsr.w notify_on_activate
 bcs.s LAB_00000470
 move.l 32(a5),d2
 move.l 14(a3),32(a5)
 bsr.w activate_program
 bcs.s LAB_00000470
 move.l d2,32(a5)
LAB_0000046c: andi #0,ccr
LAB_00000470: movem.l (sp)+,a1-a2/d2-d3
 rts 
set_ucm_path_desc: movea.l 32(a5),a0
 move.l a1,10(a0)
 rts 

 ends 

