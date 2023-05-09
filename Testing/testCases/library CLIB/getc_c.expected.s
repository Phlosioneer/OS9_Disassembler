 psect getc_c,$0,$0,0,0,getc
getc: link.w A5,#0
L00001 equ *-3
 movem.l a0/a2/d0,-(sp)
 movea.l d0,a2
 move.l a2,d0
 beq.s L0001a
 move.w 12(a2),d0
 ext.l d0
 btst.l #8,d0
 beq.s L0001e
L0001a moveq #255,d0
 bra.s L0003c
L0001e move.l (a2),d0
 cmp.l 8(a2),d0
 bcc.s L00036
 movea.l (a2),a0
 addq.l #1,(a2)
 move.b (a0),d0
 ext.w d0
 andi.w #255,d0
 ext.l d0
 bra.s L0003c
L00036 move.l a2,d0
 bsr.w L000ba
L0003c movem.l -8(a5),a0/a2
 unlk A5
 rts 
ungetc: link.w A5,#0
 movem.l a0/a2/d0-d1,-(sp)
 movea.l d1,a2
 move.l a2,d0
 beq.s L0006a
 btst.b #0,13(a2)
 beq.s L0006a
 moveq #255,d0
 cmp.l (sp),d0
 beq.s L0006a
 move.l (a2),d0
 cmp.l 4(a2),d0
 bhi.s L0006e
L0006a moveq #255,d0
 bra.s L00078
L0006e subq.l #1,(a2)
 movea.l (a2),a0
 move.b 3(sp),(a0)
 move.l (sp),d0
L00078 movem.l -8(a5),a0/a2
 unlk A5
 rts 
getw: link.w A5,#0
 movem.l a2/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 move.l a2,d0
 bsr.w getc
 move.l d0,d4
 moveq #255,d1
 cmp.l d0,d1
 beq.s L000a6
 move.l a2,d0
 bsr.w getc
 move.l d0,d5
 cmp.l d0,d1
 bne.s L000aa
L000a6 moveq #255,d0
 bra.s L000b0
L000aa move.l d4,d0
 lsl.l #8,d0
 add.l d5,d0
L000b0 movem.l -16(a5),a2/d1/d4-d5
 unlk A5
 rts 
L000ba link.w A5,#0
 movem.l a0/a2/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.w 12(a2),d0
 ext.l d0
 andi.l #32817,d0
 cmpi.l #32769,d0
 beq.s L000ec
 moveq #49,d0
 and.w 12(a2),d0
 cmpi.w #1,d0
 bne.w L00164
 move.l a2,d0
 bsr.w _setbase
L000ec lea.l _iob(a6),a0
 cmpa.l a2,a0
 bne.s L00112
 move.w _iob+40(a6),d0
 ext.l d0
 btst.l #15,d0
 beq.s L00112
 btst.b #7,13(a2)
 bne.s L00112
 lea.l _iob+28(a6),a0
 move.l a0,d0
 bsr.w fflush
L00112 btst.b #3,13(a2)
 beq.s L00132
 movea.w 18(a2),a0
 move.l a0,-(sp)
 move.l 4(a2),d1
 movea.w 14(a2),a0
 move.l a0,d0
 movea.l 20(a2),a0
 jsr (a0)
 bra.s L0014a
L00132 pea (L00001).w
 moveq #16,d0
 add.l a2,d0
 move.l d0,4(a2)
 move.l d0,d1
 movea.w 14(a2),a0
 move.l a0,d0
 bsr.w read
L0014a addq.l #4,sp
 move.l d0,d4
 tst.l d4
 bne.s L0015a
 bset.b #4,13(a2)
 bra.s L00164
L0015a tst.l d4
 bge.s L00168
 bset.b #5,13(a2)
L00164 moveq #255,d0
 bra.s L00188
L00168 move.l 4(a2),d0
 addq.l #1,d0
 move.l d0,(a2)
 move.l 4(a2),d0
 add.l d4,d0
 move.l d0,8(a2)
 movea.l 4(a2),a0
 move.b (a0),d0
 ext.w d0
 andi.w #255,d0
 ext.l d0
L00188 movem.l -16(a5),a0/a2/d1/d4
 unlk A5
 rts 

 ends 

