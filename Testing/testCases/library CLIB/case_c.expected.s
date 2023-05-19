 psect case_c,$0,$0,0,0,toupper
toupper: link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l (sp),d0
 lea _chcodes(a6),a0
 move.b (a0,d0.l),d1
 ext.w d1
 btst.l #2,d1
 beq.s L00022
 andi.l #223,d0
 bra.s L00024
L00022 move.l (sp),d0
L00024 movem.l -8(a5),a0/d1
 unlk a5
 rts 
tolower: link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l (sp),d0
 lea _chcodes(a6),a0
 move.b (a0,d0.l),d1
 ext.w d1
 btst.l #1,d1
 beq.s L0004e
 bset.l #5,d0
 bra.s L00050
L0004e move.l (sp),d0
L00050 movem.l -8(a5),a0/d1
 unlk a5
 rts 

 ends 

