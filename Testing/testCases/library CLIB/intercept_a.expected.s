 psect intercept_a,$0,$0,0,0,intercept

* D
 vsect 
D00000 ds.b 4


 ends 

intercept: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 lea L0001c(pc),a0
 move.l d0,D00000(a6)
 bne.s L00014
 movea.l d0,a0
L00014 os9 F$Icpt
 bra.w _sysret
L0001c move.l d1,d0
 movea.l D00000(a6),a0
 jsr (a0)
 os9 F$RTE

 ends 

