 psect mem_a,0,0,0,0,ebrk


* D
 vsect 
D00000 ds.b 4
D00004 ds.b 4
_srqsiz: ds.b 4


 ends 


* _
 vsect 
_memmins: dc.l $00002000


 ends 

ebrk: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.l d0,d1
 bne.s L00012
 moveq E$BMode,d1
 bra.w _os9err
L00012 addq.l #1,d1
 and.b #254,d1
 move.l D00004(a6),d2
 sub.l d1,d2
 bcs.s L00030
 move.l D00000(a6),d0
 add.l d1,D00000(a6)
 sub.l d1,D00004(a6)
 bra.w L000b0
L00030 move.l _memmins(a6),d0
 cmp.l d1,d0
 bhi.s L0003a
 move.l d1,d0
L0003a movea.l a2,a0
 os9 F$SRqMem
 exg a2,a0
 bcs.w _os9err
 move.l a0,D00000(a6)
 move.l d0,D00004(a6)
 add.l d0,_totmem(a6)
 bra.s L00012
ibrk: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.l d0,d1
 addq.l #1,d1
 and.b #254,d1
 move.l d1,d2
 add.l _mtop(a6),d1
 bcs.s L0007e
 cmp.l _stbot(a6),d1
 bcc.s L0007e
 move.l _mtop(a6),d0
 move.l d1,_mtop(a6)
 move.l d2,d1
 bra.s L000b0
L0007e moveq E$MemFul,d1
 bra.w _os9err
sbrk: link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 addq.l #1,d0
 and.b #254,d0
 move.l d0,d1
 add.l _sbsize(a6),d0
 movea.l a1,a0
 os9 F$Mem
 exg a1,a0
 bcs.w _os9err
 move.l d0,_sbsize(a6)
 add.l d1,_totmem(a6)
 move.l a0,d0
 sub.l d1,d0
L000b0 movea.l d0,a0
 moveq #0,d2
 lsr.l #2,d1
 bcc.s L000be
 move.w d2,(a0)+
 bra.s L000be
L000bc move.l d2,(a0)+
L000be dbf d1,L000bc
 addq.w #1,d1
 subq.l #1,d1
 bcc.s L000bc
 move.l d0,d0
 bra.w _sysret
_srqmem: link.w a5,#-4
 move.l a2,(sp)
 os9 F$SRqMem
 bcs.s L000f6
 move.l d0,_srqsiz(a6)
 move.l a2,d0
L000e0 movea.l -4(a5),a2
 unlk a5
 rts 
_srtmem: link.w a5,#-4
 move.l a2,(sp)
 movea.l d1,a2
 os9 F$SRtMem
 bcc.s L000e0
L000f6 moveq #255,d0
 move.l d1,errno(a6)
 bra.s L000e0

 ends 

