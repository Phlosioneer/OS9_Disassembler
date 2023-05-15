 psect modloadp_c,$0,$0,0,0,modloadp
modloadp: link.w A5,#0
 movem.l a0/a2-a4/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 movea.l 48(sp),a3
 lea.l -256(sp),a7
 moveq #0,d7
 move.l a3,d0
 bne.s L0001a
 lea.l (sp),a3
L0001a movea.w 262(sp),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w modload
 move.l d0,d5
 moveq #255,d1
 cmp.l d0,d1
 bne.w L000ce
 cmpi.l #216,errno(a6)
 bne.w L000ca
 cmpi.b #47,(a2)
 beq.w L000ca
 lea.l L000e6(pc),a0
 move.l a0,d0
 bsr.w getenv
 movea.l d0,a4
 tst.l d0
 beq.w L000ca
L00056 moveq #58,d1
 move.l a4,d0
 bsr.w index
 move.l d0,d4
 beq.s L0006a
 move.l d4,d0
 addq.l #1,d4
 sub.l a4,d0
 bra.s L00070
L0006a move.l a4,d0
 bsr.w strlen
L00070 move.l d0,d6
 move.l d6,-(sp)
 move.l a4,d1
 move.l a3,d0
 bsr.w strncpy
 addq.l #4,sp
 move.l d6,d0
 addq.l #1,d6
 move.b #47,(a3,d0.l)
 clr.b (a3,d6.l)
 move.l a2,d1
 move.l a3,d0
 bsr.w strcat
 movea.w 262(sp),a0
 move.l a0,d1
 move.l a3,d0
 bsr.w modload
 move.l d0,d5
 moveq #255,d1
 cmp.l d0,d1
 beq.s L000ac
 addq.l #1,d7
 bra.s L000c2
L000ac cmpi.l #216,errno(a6)
 beq.s L000b8
 moveq #0,d4
L000b8 movea.l d4,a4
 move.l a4,d0
 beq.s L000c2
 tst.l d7
 beq.s L00056
L000c2 move.l a4,d0
 bne.s L000d6
 tst.l d7
 bne.s L000d6
L000ca clr.b (a3)
 bra.s L000d6
L000ce move.l a2,d1
 move.l a3,d0
 bsr.w strcpy
L000d6 move.l d5,d0
 lea.l 256(sp),a7
 movem.l -32(a5),a0/a2-a4/d4-d7
 unlk A5
 rts 
L000e6 addq.w #8,d1
 addq.w #2,a0
 dc.w $0

 ends 

