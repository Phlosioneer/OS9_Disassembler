 psect putc_c,$0,$0,0,0,putc
putc: link.w A5,#0
L00001 equ *-3
 movem.l a0/a2/d0-d1,-(sp)
 movea.l d1,a2
 move.w 12(a2),d0
 ext.l d0
 andi.l #32802,d0
 cmpi.l #32770,d0
 beq.s L00032
 moveq #34,d0
 and.w 12(a2),d0
 cmpi.w #2,d0
 bne.w L0009a
 move.l a2,d0
 bsr.w _setbase
L00032 btst.b #2,13(a2)
 beq.s L00060
 pea (L00001).w
 lea.l 7(sp),a0
 move.l a0,d1
 movea.w 14(a2),a0
 move.l a0,d0
 movea.l 24(a2),a0
 jsr (a0)
 addq.l #4,sp
 moveq #255,d1
 cmp.l d0,d1
 bne.s L0009e
 bset.b #5,13(a2)
 bra.s L0009a
L00060 move.w 12(a2),d0
 ext.l d0
 btst.l #8,d0
 bne.s L00072
 move.l a2,d0
 bsr.w _flsbuf
L00072 movea.l (a2),a0
 addq.l #1,(a2)
 move.b 3(sp),(a0)
 move.l (a2),d0
 cmp.l 8(a2),d0
 bcc.s L00090
 btst.b #7,13(a2)
 bne.s L0009e
 moveq #13,d0
 cmp.l (sp),d0
 bne.s L0009e
L00090 move.l a2,d0
 bsr.w _flsbuf
 tst.l d0
 beq.s L0009e
L0009a moveq #255,d0
 bra.s L000a0
L0009e move.l (sp),d0
L000a0 movem.l -8(a5),a0/a2
 unlk A5
 rts 
putw: link.w A5,#0
 movem.l a2/d0-d1/d4,-(sp)
 move.l d0,d4
 movea.l d1,a2
 move.l a2,d1
 move.l d4,d0
 lsr.l #8,d0
 bsr.w putc
 move.l a2,d1
 move.l d4,d0
 bsr.w putc
 movem.l -8(a5),a2/d4
 unlk A5
 rts 
_tidyup: link.w A5,#0
 movem.l a0/a2/d0,-(sp)
 lea.l _iob(a6),a2
 bra.s L000ea
L000e0 move.l a2,d0
 bsr.s fclose
 adda.l #28,a2
L000ea lea.l _iob+896(a6),a0
 cmpa.l a2,a0
 bhi.s L000e0
 movem.l -8(a5),a0/a2
 unlk A5
 rts 
fclose: link.w A5,#0
 movem.l a0/a2/d0/d4,-(sp)
 movea.l d0,a2
 moveq #0,d4
 move.l a2,d0
 beq.s L0016e
 move.w 12(a2),d0
 ext.l d0
 btst.l #15,d0
 beq.s L0012a
 btst.b #1,13(a2)
 beq.s L00130
 move.l a2,d0
 bsr.w fflush
 move.l d0,d4
 bra.s L00130
L0012a tst.w 12(a2)
 beq.s L0013a
L00130 movea.w 14(a2),a0
 move.l a0,d0
 bsr.w close
L0013a move.w 12(a2),d0
 ext.l d0
 btst.l #9,d0
 beq.s L0014e
 move.l 4(a2),d0
 bsr.w free
L0014e moveq #0,d0
 move.l d0,8(a2)
 move.l d0,(a2)
 move.l d0,4(a2)
 move.w d0,12(a2)
 move.w d0,18(a2)
 move.l d0,24(a2)
 move.l d0,20(a2)
 move.l d4,d0
 bra.s L00170
L0016e moveq #255,d0
L00170 movem.l -12(a5),a0/a2/d4
 unlk A5
 rts 

 ends 

