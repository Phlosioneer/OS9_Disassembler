 psect fflush_c,0,0,0,0,fflush

fflush: link.w a5,#0
L00001 equ *-3
 movem.l a2/d0,-(sp)
 movea.l d0,a2
 move.l a2,d0
 beq.s L0001a
 moveq #34,d0
 and.w 12(a2),d0
 cmpi.w #2,d0
 beq.s L0001e
L0001a moveq #-1,d0
 bra.s L00034
L0001e move.w 12(a2),d0
 ext.l d0
 btst.l #15,d0
 bne.s L00030
 move.l a2,d0
 bsr.w _setbase
L00030 move.l a2,d0
 bsr.s _flsbuf
L00034 movem.l -4(a5),a2
 unlk a5
 rts 
_flsbuf: link.w a5,#0
 movem.l a0/a2/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 move.w 12(a2),d0
 ext.l d0
 btst.l #8,d0
 bne.s L00072
 move.l (a2),d0
 cmp.l 8(a2),d0
 beq.s L00072
 clr.l -(sp)
 move.l a2,d0
 bsr.w ftell
 move.l d0,d1
 movea.w 14(a2),a0
 move.l a0,d0
 bsr.w lseek
 addq.l #4,sp
L00072 move.l (a2),d0
 sub.l 4(a2),d0
 move.l d0,d4
 tst.l d4
 beq.s L000c0
 move.w 12(a2),d0
 ext.l d0
 btst.l #8,d0
 beq.s L000c0
 move.l 4(a2),(a2)
 bra.s L000bc
L00090 move.l d4,-(sp)
 move.l (a2),d1
 movea.w 14(a2),a0
 move.l a0,d0
 movea.l 24(a2),a0
 jsr (a0)
 addq.l #4,sp
 move.l d0,d5
 moveq #-1,d1
 cmp.l d0,d1
 bne.s L000b8
 bset.b #5,13(a2)
 move.l 4(a2),(a2)
 moveq #-1,d0
 bra.s L000da
L000b8 sub.l d5,d4
 add.l d5,(a2)
L000bc tst.l d4
 bgt.s L00090
L000c0 bset.b #0,12(a2)
 move.l 4(a2),d0
 move.l d0,(a2)
 move.w 18(a2),d1
 ext.l d1
 add.l d1,d0
 move.l d0,8(a2)
 moveq #0,d0
L000da movem.l -20(a5),a0/a2/d1/d4-d5
 unlk a5
 rts 
_setbase: link.w a5,#0
 movem.l a0/a2/d0-d1,-(sp)
 movea.l d0,a2
 move.w #192,d0
 and.w 12(a2),d0
 bne.s L00130
 lea -128(sp),sp
 lea (sp),a0
 move.l a0,d1
 movea.w 14(a2),a0
 move.l a0,d0
 bsr.w _gs_opt
 bra.s L0011c
L0010c bset.b #6,13(a2)
 bra.s L0012c
L00114 bset.b #7,13(a2)
 bra.s L0012c
L0011c move.b (sp),d0
 ext.w d0
 tst.w d0
 beq.s L0010c
 cmpi.w #2,d0
 beq.s L0010c
 bra.s L00114
L0012c lea 128(sp),sp
L00130 bset.b #7,12(a2)
 btst.b #7,13(a2)
 beq.s L0014c
 lea read(pc),a0
 move.l a0,20(a2)
 lea write(pc),a0
 bra.s L00158
L0014c lea readln(pc),a0
 move.l a0,20(a2)
 lea writeln(pc),a0
L00158 move.l a0,24(a2)
 tst.w 18(a2)
 bne.s L00178
 btst.b #7,13(a2)
 beq.s L00172
 move.w #512,18(a2)
 bra.s L00178
L00172 move.w #256,18(a2)
L00178 tst.l 4(a2)
 bne.s L001a8
 btst.b #2,13(a2)
 beq.s L0018a
 moveq #0,d0
 bra.s L00194
L0018a movea.w 18(a2),a0
 move.l a0,d0
 bsr.w malloc
L00194 move.l d0,d1
 move.l a2,d0
 bsr.s setbuf
 btst.b #3,13(a2)
 beq.s L001a8
 bset.b #1,12(a2)
L001a8 movem.l -12(a5),a0/a2/d1
 unlk a5
 rts 
setbuf: link.w a5,#0
 movem.l a2/d0-d1,-(sp)
 movea.l d0,a2
 move.w 12(a2),d0
 ext.l d0
 btst.l #8,d0
 beq.s L001ce
 move.l a2,d0
 bsr.w fflush
L001ce move.w 12(a2),d0
 ext.l d0
 btst.l #9,d0
 beq.s L001e8
 move.l 4(a2),d0
 bsr.w free
 andi.w #$fdff,12(a2)
L001e8 andi.w #$fef3,12(a2)
 move.l 4(sp),4(a2)
 beq.s L0020a
 bset.b #3,13(a2)
 tst.w 18(a2)
 bne.s L0021e
 move.w #512,18(a2)
 bra.s L0021e
L0020a moveq #16,d0
 add.l a2,d0
 move.l d0,4(a2)
 bset.b #2,13(a2)
 move.w #1,18(a2)
L0021e move.l 4(a2),d0
 move.w 18(a2),d1
 ext.l d1
 add.l d1,d0
 move.l d0,8(a2)
 move.l d0,(a2)
 movem.l -4(a5),a2
 unlk a5
 rts 
ftell: link.w a5,#0
 movem.l a0/a2/d0-d2,-(sp)
 movea.l d0,a2
 move.l a2,d0
 beq.s L00250
 moveq #3,d0
 and.w 12(a2),d0
 bne.s L00254
L00250 moveq #-1,d0
 bra.s L00298
L00254 move.w 12(a2),d0
 ext.l d0
 btst.l #15,d0
 bne.s L00266
 move.l a2,d0
 bsr.w _setbase
L00266 pea (L00001).w
 moveq #0,d1
 movea.w 14(a2),a0
 move.l a0,d0
 bsr.w lseek
 addq.l #4,sp
 move.l d0,d1
 move.w 12(a2),d0
 ext.l d0
 btst.l #8,d0
 beq.s L0028c
 move.l 4(a2),d0
 bra.s L00290
L0028c move.l 8(a2),d0
L00290 move.l (a2),d2
 sub.l d0,d2
 add.l d2,d1
 move.l d1,d0
L00298 movem.l -16(a5),a0/a2/d1-d2
 unlk a5
 rts 

 ends 

