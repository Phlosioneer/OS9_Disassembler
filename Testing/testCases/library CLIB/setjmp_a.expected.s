 psect setjmp_a,$0,$0,1,0,setjmp
setjmp: link.w a5,#0
 movea.l d0,a0
 move.l 4(sp),(a0)
 movem.l a1-sp/d1-d7,4(a0)
 move.l (sp),48(a0)
 moveq #0,d0
 unlk a5
 rts 
longjmp: link.w a5,#0
 movea.l d0,a0
 move.l d1,d0
 bne.s L00026
 moveq #1,d0
L00026 movem.l 4(a0),a1-sp/d1-d7
 movea.l (a0),a0
 addq.l #8,sp
 jmp (a0)

 ends 

