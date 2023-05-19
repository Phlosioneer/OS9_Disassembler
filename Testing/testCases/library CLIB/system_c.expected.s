 psect system_c,$0,$0,0,0,system
system: link.w a5,#0
 movem.l a0/a2/d0-d2/d4-d5,-(sp)
 movea.l d0,a2
 lea -20(sp),sp
 clr.l (sp)
 lea L000b6(pc),a0
 move.l a0,d0
 bsr.w getenv
 move.l d0,4(sp)
 bne.s L00028
 lea L000bc(pc),a0
 move.l a0,4(sp)
L00028 move.l a2,d0
 bne.s L0005e
 moveq #0,d1
 move.l 4(sp),d0
 bsr.w modlink
 moveq #255,d1
 cmp.l d0,d1
 bne.s L00050
 move.l d1,d2
 clr.l -(sp)
 moveq #0,d1
 move.l 8(sp),d0
 bsr.w modloadp
 addq.l #4,sp
 cmp.l d0,d2
 beq.s L000a6
L00050 moveq #0,d1
 move.l 4(sp),d0
 bsr.w munload
 addq.l #1,(sp)
 bra.s L000a6
L0005e move.l 4(sp),8(sp)
 move.l a2,12(sp)
 clr.l 16(sp)
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 move.l environ(a6),-(sp)
 pea 24(sp)
 move.l 28(sp),d1
 lea os9fork(pc),a0
 move.l a0,d0
 bsr.w os9exec
 lea 20(sp),sp
 move.l d0,d4
 moveq #255,d0
 cmp.l d4,d0
 bne.s L0009a
 move.l errno(a6),d0
 bra.s L000a8
L0009a lea (sp),a0
 move.l a0,d0
 bsr.w wait
 cmp.l d4,d0
 bne.s L0009a
L000a6 move.l (sp),d0
L000a8 lea 20(sp),sp
 movem.l -24(a5),a0/a2/d1-d2/d4-d5
 unlk a5
 rts 
L000b6 subq.w #1,a0
 dc.w $454c
 dc.w $4c00
L000bc dc.w $7368
 bcs.s L0012c
 dc.w $6c00

 ends 

