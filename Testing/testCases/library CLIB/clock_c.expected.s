 psect clock_c,$0,$0,0,0,clock
clock: link.w a5,#0
 movem.l d0-d1,-(sp)
 lea.l -2048(sp),a7
 pea (sp)
 move.l #2048,d1
 bsr.w getpid
 bsr.w _get_process_desc
 addq.l #4,sp
 moveq #255,d1
 cmp.l d0,d1
 bne.s L00028
 moveq #255,d0
 bra.s L00030
L00028 move.l 692(sp),d0
 add.l 696(sp),d0
L00030 lea.l 2048(sp),a7
 movem.l -4(a5),d1
 unlk a5
 rts 

 ends 

