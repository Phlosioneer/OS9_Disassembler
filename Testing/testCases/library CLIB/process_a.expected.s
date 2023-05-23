 psect process_a,0,0,0,0,kill

kill: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 os9 F$Send
 bra.w _sysret
wait: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 moveq #0,d0
 os9 F$Wait
 bcs.w _os9err
 move.l a0,d2
 beq.w _sysret
 clr.w (a0)+
 move.w d1,(a0)
 bra.w _sysret
setpr: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 os9 F$SPrior
 bra.w _sysret
chainc: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movem.l a1/d3-d5,-(sp)
 moveq #3,d5
 bra.s L00080
chain: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movem.l a1/d3-d5,-(sp)
 moveq #1,d5
 bra.s L00080
os9forkc: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movem.l a1/d3-d5,-(sp)
 moveq #2,d5
 bra.s L00080
os9fork: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movem.l a1/d3-d5,-(sp)
 moveq #0,d5
L00080 movea.l d0,a0
 move.l d1,d2
 movea.l 8(a5),a1
 move.w 18(a5),d0
 swap d0
 move.w 14(a5),d0
 move.l 20(a5),d1
 moveq #3,d3
 btst.l #1,d5
 beq.s L000a2
 move.l 28(a5),d3
L000a2 move.l 24(a5),d4
 btst.l #0,d5
 bne.s L000b2
 os9 F$Fork
 bra.s L000b6
L000b2 os9 F$Chain
L000b6 movem.l (sp)+,a1/d3-d5
 bra.w _sysret

 ends 

