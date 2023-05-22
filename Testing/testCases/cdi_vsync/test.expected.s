
* Class equate external label equates

F$Exit equ $06
F$TLink equ $21
I$WritLn equ $8c

Prgrm set $1
Objct set $1
ReEnt set $80

 psect test.os9_a,(Prgrm<<8)|Objct,(ReEnt<<8)|1,7,0,L00052,L001bc


* OS9 data area definitions

 vsect 
D00000 ds.b 4
D00004 ds.b 4
D00008 ds.b 4
D0000c ds.b 8
D00014 ds.b 4
D00018 ds.b 2
D0001a ds.b 16
D0002a ds.b 2
D0002c ds.b 26
D00046 ds.b 2
D00048 ds.b 26
D00062 ds.b 2
D00064 ds.b 826

* Initialized Data Definitions

 dc.l $0000001e
_003a2 dc.l $00000242
 ends 

 bls.s L000ae
 dc.w $695f
 moveq #115,d3
 dc.w $796e
 bls.w L02d98
L00052 equ *-2
 or.b (a0),d0
 move.l d6,D00014(a6)
 move.w d3,D00018(a6)
 btst.b #5,20(a3)
 beq.s L00074
 move.l a4,D0001a(a6)
 bne.s L00074
 move.l (L00000).l,D0001a(a6)
L00074 tst.l d5
 beq.s L00096
 btst.l #0,d5
 bne.s L00092
 lea (a5,d5.l),a0
 tst.w -2(a0)
 bne.s L00092
 subq.l #4,a0
 lea -4(a0),a4
 moveq #1,d0
 bra.s L000b8
L00092 clr.b -1(a5,d5.l)
L00096 movea.l a5,a0
 adda.l 12(a3),a3
 clr.l -(sp)
 move.l a3,-(sp)
 moveq #1,d2
 move.l #664,d0
 jsr (pc,d0.l)
 bra.s L00124
L000ae lea 4(a0),a1
 move.l a1,_003a2(a6)
 moveq #0,d2
L000b8 movea.l -(a0),a1
 move.l a1,d7
 beq.s L000ca
 adda.l a5,a1
 clr.b -1(a1)
 move.l a1,(a0)
 addq.l #1,d2
 bra.s L000b8
L000ca subq.l #1,d0
 beq.s L000ae
 tst.l d2
 bne.s L000e2
 tst.w -2(a0)
 beq.s L000e2
 clr.b -1(a0)
 movea.l a0,a2
 addq.l #4,a0
 bra.s L000e8
L000e2 move.l a5,(a0)
 movea.l a0,a2
 addq.l #1,d2
L000e8 addq.l #1,d2
 tst.l (a4)
 beq.s L00106
 movea.l (a4),a4
L000f0 tst.b (a4)+
 bne.s L000f0
 cmpa.l a4,a2
 bls.s L00116
 cmpi.b #252,(a4)+
 bne.s L00116
 addq.l #1,a4
 movea.l (a4),a3
 adda.l a5,a3
 bra.s L0011a
L00106 cmpi.b #252,2(a5)
 bne.s L00116
 movea.l 4(a5),a3
 adda.l a5,a3
 bra.s L0011a
L00116 adda.l 12(a3),a3
L0011a move.l a3,-(a0)
 move.l a0,-(sp)
 clr.b -1(a0)
 move.l d2,-(sp)
L00124 movea.l #488,a0
 jsr (pc,a0.l)
 bcs.w L0024c
 bsr.s L00154
 movem.l (sp)+,d0-d1
 suba.l a5,a5
 move.l _003a2(a6),-(sp)
 movea.l #332,a0
 jsr (pc,a0.l)
 moveq #0,d0
 movea.l #628,a0
 jsr (pc,a0.l)
L00154 movea.l #-31834,a0
 adda.l a6,a0
 move.l a0,D00004(a6)
 move.l sp,D00000(a6)
 move.l sp,D00008(a6)
 move.l #-252,d0
 add.l sp,d0
 cmp.l D00008(a6),d0
 bcs.s L00178
 rts 
L00178 cmp.l D00004(a6),d0
 bcs.s L00184
 move.l d0,D00008(a6)
 rts 
L00184 lea L001f6(pc),a0
 bsr.s L0019a
 move.l #257,-(sp)
 movea.l #580,a0
 jsr (pc,a0.l)
L0019a move.w d1,-(sp)
 moveq #100,d1
 moveq #2,d0
 os9 I$WritLn
 move.w (sp)+,d1
 rts 
 move.l D00000(a6),d0
 sub.l D00008(a6),d0
 rts 
 move.l D00008(a6),d0
 sub.l D00004(a6),d0
 rts 
L001bc movem.l a0-a3/d0-d1,-(sp)
 move.w 30(sp),d0
 subi.w #128,d0
 asr.w #2,d0
 cmpi.w #15,d0
 bne.s L001dc
 lea L0023d(pc),a0
 moveq #0,d1
 os9 F$TLink
 bcc.s L001e8
L001dc movea.l #514,a1
 jsr (pc,a1.l)
 bcs.s L0024c
L001e8 movem.l (sp)+,a0-a3/d0-d1
 addq.l #8,sp
 subq.l #4,(sp)
 rts 
 dc.w $4afb
 ori.w #$2a2a,(a0)
L001f6 equ *-2
 move.l 8275(a2),d5
 moveq #97,d2
 dc.w $636b
 movea.l sp,a0
 moveq #101,d3
 moveq #102,d1
 dc.w $6c6f
 dc.w $7720
 move.l 10794(a2),d5
 btst.l d6,d0
L00210 move.l 10794(a2),d5
 movea.l d3,a0
 bsr.s L00286
 move.l 105(a4,d2.w),28275(a3)
 moveq #97,d2
 bge.s L0028e
 dc.w $2074
 moveq #97,d1
 moveq #32,d0
 dc.w $6861
 bgt.s L00290
 dc.w $6c65
 moveq #32,d1
 move.l 10794(a2),d5
 btst.l d6,d0
L00236 move.l 10794(a2),d0
 move.l -(a0),d5
 ori.w #$6174,26624(a5)
L0023d equ *-5
 ori.b #$00,d0
 move.l #64,d1
L0024c move.l a0,-(sp)
 lea L00210(pc),a0
 bsr.w L0019a
 movea.l #-32738,a1
 adda.l a6,a1
 lea L00236(pc),a0
 bsr.s L0028c
 movea.l (sp)+,a0
 subq.l #1,a1
 bsr.s L0028c
 lea L00236(pc),a0
 subq.l #1,a1
 bsr.s L0028c
 move.b #13,-1(a1)
 movea.l #-32738,a0
 adda.l a6,a0
 bsr.w L0019a
 os9 F$Exit
L00286 equ *-2
 os9 F$Exit
L0028c move.b (a0)+,(a1)+
L0028e bne.s L0028c
L00290 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 lea L00304(pc),a0
 move.l a0,d0
 bsr.s L002bc
 moveq #255,d1
 cmp.l d0,d1
 bne.s L002ae
 moveq #255,d0
 bsr.w L003c6
L002ae bsr.s L002e4
 bsr.s L002fa
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
L002bc movem.l a0-a2,-(sp)
 movea.l d0,a0
 move.l #5,d0
 moveq #0,d1
 os9 F$TLink
 bcs.s L002d8
 moveq #0,d0
L002d2 movem.l (sp)+,a0-a2
 rts 
L002d8 move.l d1,D0000c(a6)
 move.l #-1,d0
 bra.s L002d2
L002e4 tcall #5,#2
 bcs.s L002ee
 moveq #0,d0
 rts 
L002ee move.l d1,D0000c(a6)
 move.l #-1,d0
 rts 
L002fa tcall #5,#4
 bcs.s L002ee
 moveq #0,d0
 rts 
L00304 bls.s L0036a
 dc.w $695f
 moveq #115,d3
 dc.w $796e
 dc.w $635f
 moveq #114,d2
 bsr.s L00382
 dc.w $0
 link.w a5,#0
 movem.l d0,-(sp)
 move.w #65,D0002a(a6)
 clr.w D0002c(a6)
 move.w #2,D00046(a6)
 move.w #1,D00048(a6)
 move.w #2,D00062(a6)
 move.w #2,D00064(a6)
 unlk a5
 rts 
 movea.l (sp)+,a5
L00344 subq.l #1,d5
 bcs.s L003aa
 move.b (a0)+,d0
 beq.s L00344
 cmpi.b #13,d0
 beq.s L003aa
 cmpi.b #32,d0
 beq.s L00344
 cmpi.b #9,d0
 beq.s L00344
 cmpi.b #44,d0
 beq.s L00344
 addq.l #1,d2
 cmpi.b #34,d0
L0036a beq.s L0039c
 cmpi.b #39,d0
 beq.s L0039c
 pea -1(a0)
L00376 subq.l #1,d5
 bcs.s L003aa
 move.b (a0)+,d0
 beq.s L00344
 cmpi.b #13,d0
L00382 beq.s L00396
 cmpi.b #32,d0
 beq.s L00396
 cmpi.b #9,d0
 beq.s L00396
 cmpi.b #44,d0
 bne.s L00376
L00396 clr.b -1(a0)
 bra.s L00344
L0039c pea (a0)
L0039e subq.l #1,d5
 bcs.s L003aa
 move.b (a0)+,d1
 cmp.b d1,d0
 bne.s L0039e
 bra.s L00396
L003aa movea.l sp,a0
 pea (sp)
 move.l d2,-(sp)
 subq.l #1,d2
 beq.s L003c4
 asl.l #2,d2
L003b6 move.l (a0,d2.l),d0
 move.l (a0),(a0,d2.l)
 move.l d0,(a0)+
 subq.l #8,d2
 bhi.s L003b6
L003c4 jmp (a5)
L003c6 link.w a5,#0
 move.l d0,d1
 bsr.w L003ec
 bsr.w L003ee
 bra.s L003de
 link.w a5,#0
 illegal 
 move.l d0,d1
L003de os9 F$Exit
 add.l -8531(a5),d7
 ori #1,ccr
 rts 
L003ec rts 
L003ee rts 

 ends 

