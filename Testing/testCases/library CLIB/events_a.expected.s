 psect events_a,$0,$0,0,0,_ev_creat
_ev_creat: link.w A5,#0
 movem.l a0/d2-d3,-(sp)
 move.l d1,d2
 move.l 20(sp),d3
 movea.l 24(sp),a0
 moveq #Ev$Creat,d1
L00014 os9 F$Event
 bcc.s L00020
 move.l d1,errno(a6)
 moveq #255,d0
L00020 movem.l -12(a5),a0/d2-d3
 unlk A5
 rts 
_ev_link: link.w A5,#0
 movem.l a0/d1-d3,-(sp)
 movea.l d0,a0
 moveq #Ev$Link,d1
L00036 os9 F$Event
 bcc.s L00042
 move.l d1,errno(a6)
 moveq #255,d0
L00042 movem.l -16(a5),a0/d1-d3
 unlk A5
 rts 
_ev_unlink: link.w A5,#0
 movem.l a0/d1-d3,-(sp)
 moveq #Ev$UnLnk,d1
 bra.s L00036
_ev_delete: link.w A5,#0
 movem.l a0/d1-d3,-(sp)
 movea.l d0,a0
 moveq #Ev$Delet,d1
 bra.s L00036
_ev_info: link.w A5,#0
 movem.l a0/d2-d3,-(sp)
 movea.l d1,a0
 moveq #Ev$Info,d1
 bra.s L00014
_ev_signal: link.w A5,#0
 or.w #Ev$Signl,d1
 os9 F$Event
 bcc.s L00088
 move.l d1,errno(a6)
 moveq #255,d1
L00088 move.l d1,d0
 unlk A5
 rts 
_ev_read: link.w A5,#0
 move.l d1,-(sp)
 moveq #Ev$Read,d1
 os9 F$Event
 bcc.s L000a2
 move.l d1,errno(a6)
 moveq #255,d1
L000a2 move.l d1,d0
 move.l -4(a5),d1
 unlk A5
 rts 
_ev_pulse: link.w A5,#0
 move.l d2,-(sp)
 moveq #Ev$Pulse,d2
 bra.s L000c8
_ev_set: link.w A5,#0
 move.l d2,-(sp)
 moveq #Ev$Set,d2
 bra.s L000c8
_ev_setr: link.w A5,#0
 move.l d2,-(sp)
 moveq #Ev$Incr,d2
L000c8 exg d1,d2
 or.w 14(sp),d1
 os9 F$Event
 bcc.s L000da
 move.l d1,errno(a6)
 moveq #255,d1
L000da move.l d1,d0
 move.l -4(a5),d2
 unlk A5
 rts 
_ev_wait: link.w A5,#0
 movem.l d2-d3,-(sp)
 moveq #Ev$Wait,d2
L000ee exg d1,d2
 move.l 16(sp),d3
 os9 F$Event
 bcc.s L00100
 move.l d1,errno(a6)
 moveq #255,d1
L00100 move.l d1,d0
 movem.l -8(a5),d2-d3
 unlk A5
 rts 
_ev_waitr: link.w A5,#0
 movem.l d2-d3,-(sp)
 moveq #Ev$WaitR,d2
 bra.s L000ee

 ends 

