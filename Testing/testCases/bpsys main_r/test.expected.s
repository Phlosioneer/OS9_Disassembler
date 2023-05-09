 psect cdi_bpsys,$2,$1,0,0,$0050

* D
 vsect 


 ends 

credits: dc.w $4d2e
 dc.w $4172
 dc.w $6d65
 bgt.s L0006c
 bsr.s L0007c
 bvs.s L00086
 movea.l a4,a6
 movea.l d2,sp
 bsr.s L00084
 dc.w $6e65
 dc.w $732c
 tst.b D04b65(a6)
 dc.w $7373
 bcs.s L0008a
 dc.w $6d61
 bgt.s L0004e
 subq.b #1,D04d63(a6)
 dc.w $436c
 bcs.s L00096
 dc.w $6c61
 bgt.s L0005a
 addq.b #1,D04d6f(a6)
 ble.s L000a6
 bcs.s L00062
 addq.b #2,D04e75(a6)
 moveq #116,d2
 movea.l a2,a6
 movea.l (a0),sp
 dc.w $6965
 dc.w $7369
 dc.w $6e67
 movea.l a2,a6
 movea.l (a2),sp
 ble.s L000c0
 moveq #101,d2
L0004e moveq #0,d1
 dc.w $8
 ori.b #98,104(a2,d0.w)
init: lea.l state(pc),a3
L0005a equ *-2
 cmpi.w #-16657,2(a3)
L00062 beq.w L00080
 moveq #0,d0
 move.w #-16657,2(a3)
L0006c equ *-2
 move.w d0,0(a3)
 move.w d0,6(a3)
 move.l d0,14(a3)
 move.w #4641,4(a3)
L0007c equ *-4
L00080 rts 
set_stat: move.l 8(a5),d1
L00084 equ *-2
L00086 cmpi.w #16896,d1
L0008a bcs.s L000ac
 cmpi.w #16916,d1
 bcc.s L000ac
 lea.l drawControlArgs(pc),a0
L00096 movem.l a1-a2/a4-a6/d0,(a0)
 lea.l function_table(pc),a3
 sub.l #16896,d1
 movea.w function_table(pc,d1.l),a0
L000a6 equ *-2
 jmp function_table(pc,a0.l)
L000ac movea.l 70(a2),a0
 jmp (a0)
get_stat: movea.l 74(a2),a0
 jmp (a0)
close: bsr.w handle_close
 rts 

 ends 

