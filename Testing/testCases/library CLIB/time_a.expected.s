 psect time_a,0,0,0,0,setime

setime: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 moveq #0,d1
 move.b (a0),d1
 add.w #1900,d1
 swap d1
 move.b 1(a0),d1
 asl.w #8,d1
 move.b 2(a0),d1
 moveq #0,d0
 move.b 3(a0),d0
 swap d0
 move.b 4(a0),d0
 asl.w #8,d0
 move.b 5(a0),d0
 os9 F$STime
 bcs.w _os9err
 move.l a0,d0
 bra.w _sysret
getime: link.w a5,#0
 movem.l a0/d1-d3,-(sp)
 movea.l d0,a0
 moveq #0,d0
 os9 F$Time
 bcs.s L0007c
 move.l a0,d2
 swap d1
 sub.w #1900,d1
 move.b d1,(a0)+
 swap d1
 rol.w #8,d1
 move.b d1,(a0)+
 rol.w #8,d1
 move.b d1,(a0)+
 swap d0
 move.b d0,(a0)+
 swap d0
 rol.w #8,d0
 move.b d0,(a0)+
 rol.w #8,d0
 move.b d0,(a0)+
 move.l d2,d0
L00074 movem.l (sp)+,a0/d1-d3
 unlk a5
 rts 
L0007c moveq #255,d0
 move.l d1,errno(a6)
 bra.s L00074
_sysdate: link.w a5,#0
 movem.l a0-a1/d1-d3,-(sp)
 moveq #0,d2
 os9 F$Time
 bcs.s L000b4
 movea.l -20(a5),a0
 move.l d0,(a0)
 lea 8(a5),a0
 movea.l (a0)+,a1
 move.l d1,(a1)
 movea.l (a0)+,a1
 move.w d2,(a1)
 movea.l (a0),a1
 move.l d3,(a1)
L000aa moveq #0,d0
 movem.l (sp)+,a0-a1/d1-d3
 unlk a5
 rts 
L000b4 moveq #255,d0
 move.l d1,errno(a6)
 bra.s L000aa
_julian: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.l a1,-(sp)
 movea.l d0,a0
 movea.l d1,a1
 move.l (a0),d0
 move.l (a1),d1
 os9 F$Julian
 bcs.w L000da
 move.l d0,(a0)
 move.l d1,(a1)
L000da movea.l (sp)+,a1
 bra.w _sysret

 ends 

