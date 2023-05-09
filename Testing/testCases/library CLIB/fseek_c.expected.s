 psect fseek_c,$0,$0,0,0,fseek
fseek: link.w A5,#0
 movem.l a0/a2-a3/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l a2,d0
 beq.w L000e8
 moveq #3,d0
 and.w 12(a2),d0
 beq.w L000e8
 move.w 12(a2),d0
 ext.l d0
 btst.l #15,d0
 bne.s L00032
 move.l a2,d0
 bsr.w _setbase
 bra.w L000ca
L00032 move.w 12(a2),d0
 ext.l d0
 btst.l #8,d0
 beq.s L00060
 move.l a2,d0
 bsr.w fflush
 andi.w #-257,12(a2)
 move.l 4(a2),d0
 move.w 18(a2),d1
 ext.l d1
 add.l d1,d0
 move.l d0,8(a2)
 move.l d0,(a2)
 bra.w L000ca
L00060 move.l (a2),d0
 cmp.l 8(a2),d0
 bcc.s L000ca
 move.l d4,d5
 bra.s L000a6
L0006c move.l a2,d0
 bsr.w ftell
 sub.l d0,d5
L00074 tst.l d5
 bge.s L0007e
 move.l d5,d0
 neg.l d0
 bra.s L00080
L0007e move.l d5,d0
L00080 move.w 18(a2),d1
 ext.l d1
 cmp.l d1,d0
 bgt.s L000b6
 move.l (a2),d0
 add.l d5,d0
 movea.l d0,a3
 cmpa.l 4(a2),a3
 bcs.s L000b6
 cmpa.l 8(a2),a3
 bcc.s L000b6
 move.l a3,(a2)
 andi.w #-17,12(a2)
 bra.s L000ec
L000a6 move.l 36(sp),d0
 tst.l d0
 beq.s L0006c
 cmpi.l #1,d0
 beq.s L00074
L000b6 moveq #1,d0
 cmp.l 36(sp),d0
 bne.s L000c6
 move.l 8(a2),d0
 sub.l (a2),d0
 sub.l d0,d4
L000c6 move.l 8(a2),(a2)
L000ca andi.w #-17,12(a2)
 move.l 36(sp),-(sp)
 move.l d4,d1
 movea.w 14(a2),a0
 move.l a0,d0
 bsr.w lseek
 addq.l #4,sp
 moveq #255,d1
 cmp.l d0,d1
 bne.s L000ec
L000e8 moveq #255,d0
 bra.s L000ee
L000ec moveq #0,d0
L000ee movem.l -20(a5),a0/a2-a3/d4-d5
 unlk A5
 rts 
rewind: link.w A5,#0
 movem.l d0-d1,-(sp)
 clr.l -(sp)
 moveq #0,d1
 move.l 4(sp),d0
 bsr.w fseek
 addq.l #4,sp
 movem.l -4(a5),d1
 unlk A5
 rts 

 ends 

