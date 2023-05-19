 psect direct_c,$0,$0,0,0,opendir
opendir: link.w a5,#0
L00001 equ *-3
 movem.l a0/a2/d0-d1,-(sp)
 lea -132(sp),sp
 move.l #129,d1
 move.l 132(sp),d0
 bsr.w open
 move.l d0,(sp)
 moveq #255,d1
 cmp.l d0,d1
L00020 beq.s L00038
L00021 equ *-1
 move.l #268,d0
 bsr.w malloc
 movea.l d0,a2
 tst.l d0
 bne.s L0003c
 move.l (sp),d0
 bsr.w close
L00038 moveq #0,d0
 bra.s L00058
L0003c move.l (sp),(a2)
 lea 4(sp),a0
 move.l a0,d1
 move.l (a2),d0
 bsr.w _gs_opt
 move.b 4(sp),d0
 ext.w d0
 ext.l d0
 move.l d0,4(a2)
 move.l a2,d0
L00058 lea 132(sp),sp
 movem.l -12(a5),a0/a2/d1
 unlk a5
 rts 
readdir: link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 lea -66(sp),sp
 moveq #5,d0
 cmp.l 4(a2),d0
 bne.w L00114
 pea (L00021).w
 lea 36(sp),a0
 move.l a0,d1
 move.l (a2),d0
 bsr.w read
 addq.l #4,sp
 tst.l d0
 ble.w L00136
 moveq #12,d0
 add.l a2,d0
 movea.l d0,a3
 move.l 38(sp),(a3)
 moveq #0,d0
 move.b 64(sp),d0
 move.l d0,-(sp)
 move.l a3,d0
 addq.l #8,d0
 move.l d0,d1
 move.l (a2),d0
 bsr.w read
 addq.l #4,sp
 tst.l d0
 bgt.s L000e0
 bra.w L00136
L000be moveq #46,d0
 move.b d0,9(a3)
 move.b d0,8(a3)
 clr.b 10(a3)
 bra.s L000f2
L000ce move.b #46,8(a3)
L000d4 moveq #0,d0
 move.b 64(sp),d0
 clr.b 8(a3,d0.l)
 bra.s L000f2
L000e0 move.b 8(a3),d0
 ext.w d0
 tst.w d0
 beq.s L000ce
 cmpi.w #1,d0
 beq.s L000be
 bra.s L000d4
L000f2 pea (L00001).w
 moveq #0,d0
 move.b 68(sp),d0
 moveq #0,d1
 move.b 36(sp),d1
 sub.w d0,d1
 ext.l d1
 moveq #33,d0
 sub.l d0,d1
 move.l (a2),d0
 bsr.w lseek
 addq.l #4,sp
 bra.s L0017c
L00114 pea (L00020).w
 lea 4(sp),a0
 move.l a0,d1
 move.l (a2),d0
 bsr.w read
 addq.l #4,sp
 move.l d0,d4
 moveq #32,d1
 cmp.l d0,d1
 bne.s L00132
 tst.b (sp)
 beq.s L00114
L00132 tst.l d4
 bgt.s L0013a
L00136 moveq #0,d0
 bra.s L0017e
L0013a moveq #12,d0
 add.l a2,d0
 movea.l d0,a3
 move.b 29(sp),d0
 ext.w d0
 andi.w #255,d0
 ext.l d0
 moveq #16,d1
 lsl.l d1,d0
 move.b 30(sp),d1
 ext.w d1
 andi.w #255,d1
 ext.l d1
 lsl.l #8,d1
 or.l d1,d0
 move.b 31(sp),d1
 ext.w d1
 andi.w #255,d1
 ext.l d1
 or.l d1,d0
 move.l d0,(a3)
 lea (sp),a0
 move.l a0,d1
 move.l a3,d0
 addq.l #8,d0
 bsr.w L0020a
L0017c move.l a3,d0
L0017e lea 66(sp),sp
 movem.l -20(a5),a0/a2-a3/d1/d4
 unlk a5
 rts 
telldir: link.w a5,#0
 movem.l a2/d0-d1,-(sp)
 movea.l d0,a2
 pea (L00001).w
 moveq #0,d1
 move.l (a2),d0
 bsr.w lseek
 addq.l #4,sp
 movem.l -8(a5),a2/d1
 unlk a5
 rts 
seekdir: link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 clr.l -(sp)
 move.l 8(sp),d1
 movea.l 4(sp),a0
 move.l (a0),d0
 bsr.w lseek
 addq.l #4,sp
 movem.l -4(a5),a0
 unlk a5
 rts 
rewinddir: link.w a5,#0
 movem.l d0-d1,-(sp)
 moveq #0,d1
 move.l (sp),d0
 bsr.s seekdir
 movem.l -4(a5),d1
 unlk a5
 rts 
closedir: link.w a5,#0
 movem.l a2/d0,-(sp)
 movea.l d0,a2
 move.l (a2),d0
 bsr.w close
 move.l a2,d0
 bsr.w free
 movem.l -4(a5),a2
 unlk a5
 rts 
L0020a link.w a5,#0
 movem.l a2-a4/d0-d1,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 movea.l a2,a4
L00218 move.b (a3)+,d0
 move.b d0,(a4)+
 bgt.s L00218
 andi.b #127,-1(a4)
 clr.b (a4)
 move.l a2,d0
 movem.l -12(a5),a2-a4
 unlk a5
 rts 

 ends 

