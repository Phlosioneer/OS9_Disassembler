 psect ldexp_c,$0,$0,0,0,ldexp
ldexp: link.w a5,#0
 movem.l d0-d1/d4,-(sp)
 move.l 20(sp),d4
 tst.l (sp)
 beq.s L00054
 move.w (sp),d0
 lsr.w #4,d0
 andi.w #2047,d0
 moveq #0,d1
 move.w d0,d1
 add.l d1,d4
 tst.l d4
 bgt.s L00032
 clr.l 4(sp)
 clr.l (sp)
L00028 move.l #256,errno(a6)
 bra.s L00054
L00032 cmpi.l #2047,d4
 ble.s L0004a
 move.l #1017934900,4(sp)
 move.l #2142010143,(sp)
 bra.s L00028
L0004a andi.w #-32753,(sp)
 move.w d4,d0
 lsl.w #4,d0
 or.w d0,(sp)
L00054 movem.l (sp),d0-d1
 movem.l -4(a5),d4
 unlk a5
 rts 

 ends 

