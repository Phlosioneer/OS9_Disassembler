 psect errmsg_c,$0,$0,0,0,_errmsg

* _
 vsect 
_00000 dc.l btext


 ends 

_errmsg: link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 lea.l _iob+28(a6),a0
 move.l a0,d0
 bsr.w fflush
 bsr.s _prgname
 move.l d0,-(sp)
 lea.l L0006c(pc),a0
 move.l a0,d1
 lea.l _iob+56(a6),a0
 move.l a0,d0
 bsr.w fprintf
 addq.l #4,sp
 move.l 28(sp),-(sp)
 move.l 28(sp),-(sp)
 move.l 28(sp),-(sp)
 move.l 16(sp),d1
 lea.l _iob+56(a6),a0
 move.l a0,d0
 bsr.w fprintf
 lea.l 12(sp),a7
 lea.l _iob+56(a6),a0
 move.l a0,d0
 bsr.w fflush
 move.l (sp),d0
 movem.l -4(a5),a0
 unlk a5
 rts 
_prgname: move.l a0,-(sp)
 movea.l _00000(a6),a0
 adda.l M$Name(a0),a0
 move.l a0,d0
 movea.l (sp)+,a0
 rts 
L0006c dc.w $2573
 move.w -(a0),d5
 dc.w $0

 ends 

