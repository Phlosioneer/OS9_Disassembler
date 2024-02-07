 psect fopen_c,0,0,0,0,L00000

L00000 link.w a5,#0
L00002 equ *-2
 movem.l a0/a2/d0,-(sp)
 lea _iob(a6),a2
 bra.s L00020
L0000e moveq #3,d0
 and.w 12(a2),d0
 bne.s L0001a
 move.l a2,d0
 bra.s L00032
L0001a adda.l #28,a2
L00020 lea $380+_iob(a6),a0
 cmpa.l a2,a0
 bhi.s L0000e
 move.l #200,errno(a6)
 moveq #0,d0
L00032 movem.l -8(a5),a0/a2
 unlk a5
 rts 
L0003c link.w a5,#0
 movem.l a2-a3/d0-d1,-(sp)
 movea.l d1,a2
 movea.l 24(sp),a3
 move.l a3,d0
 bne.s L00052
 bsr.s L00000
 movea.l d0,a3
L00052 move.l a3,d0
 beq.s L000a0
 move.w 2(sp),14(a3)
 cmpi.b #43,1(a2)
 beq.s L0006c
 cmpi.b #43,2(a2)
 bne.s L00074
L0006c ori.w #$0003,12(a3)
 bra.s L0008a
L00074 cmpi.b #114,(a2)
 beq.s L00080
 cmpi.b #100,(a2)
 bne.s L00084
L00080 moveq #1,d0
 bra.s L00086
L00084 moveq #2,d0
L00086 or.w d0,12(a3)
L0008a move.l 4(a3),d0
 move.w 18(a3),d1
 ext.l d1
 add.l d1,d0
 move.l d0,8(a3)
 move.l d0,(a3)
 move.l a3,d0
 bra.s L000a2
L000a0 moveq #0,d0
L000a2 movem.l -8(a5),a2-a3
 unlk a5
 rts 
L000ac link.w a5,#0
 movem.l a2-a3/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 moveq #0,d5
 bra.s L000d6
L000bc cmpi.b #43,2(a3)
 bne.s L000c8
 moveq #7,d0
 bra.s L000ca
L000c8 moveq #4,d0
L000ca move.l d0,d5
 bra.w L00158
L000d0 moveq #3,d5
 bra.w L00158
L000d6 move.b 1(a3),d0
 ext.w d0
 cmpi.w #255,d0
 bhi.s L00148
 tst.b d0
 beq.w L00158
 cmpi.b #43,d0
 beq.s L000d0
 cmpi.b #120,d0
 beq.s L000bc
 bra.s L00148
L000f6 move.l d5,d0
 bset.l #0,d0
 bra.s L0013c
L000fe move.l d5,d0
 bset.l #1,d0
 move.l d0,d1
 move.l a2,d0
 bsr.w open
 move.l d0,d4
 moveq #255,d1
 cmp.l d0,d1
 beq.s L00124
 pea (L00002).w
 moveq #0,d1
 move.l d4,d0
 bsr.w lseek
 addq.l #4,sp
 bra.s L0017e
L00124 move.l d5,d0
 bset.l #1,d0
 move.l d0,d1
 move.l a2,d0
 bsr.w creat
 bra.s L00144
L00134 move.l #129,d0
 or.l d5,d0
L0013c move.l d0,d1
 move.l a2,d0
 bsr.w open
L00144 move.l d0,d4
 bra.s L0017e
L00148 lea -24(a5),sp
 move.l #203,errno(a6)
 moveq #255,d0
 bra.s L00180
L00158 move.b (a3),d0
 ext.w d0
 cmpi.w #114,d0
 beq.s L000f6
 bhi.s L00176
 cmpi.b #100,d0
 beq.s L00134
 bhi.s L00148
 cmpi.b #97,d0
 beq.w L000fe
 bra.s L00148
L00176 cmpi.w #119,d0
 beq.s L00124
 bra.s L00148
L0017e move.l d4,d0
L00180 movem.l -16(a5),a2-a3/d4-d5
 unlk a5
 rts 
fdopen: link.w a5,#0
 movem.l d0-d1,-(sp)
 clr.l -(sp)
 move.l 8(sp),d1
 move.l 4(sp),d0
 bsr.w L0003c
 addq.l #4,sp
 unlk a5
 rts 
fopen: link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l a3,d1
 move.l a2,d0
 bsr.w L000ac
 move.l d0,d4
 moveq #255,d1
 cmp.l d0,d1
 bne.s L001c6
 suba.l a0,a0
 bra.s L001d4
L001c6 clr.l -(sp)
 move.l a3,d1
 move.l d4,d0
 bsr.w L0003c
 addq.l #4,sp
 movea.l d0,a0
L001d4 move.l a0,d0
 movem.l -16(a5),a0/a2-a3/d4
 unlk a5
 rts 
freopen: link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 movea.l 36(sp),a4
 move.l a4,d0
 bsr.w fclose
 move.l a3,d1
 move.l a2,d0
 bsr.w L000ac
 move.l d0,d4
 bge.s L00206
 suba.l a0,a0
 bra.s L00214
L00206 pea (a4)
 move.l a3,d1
 move.l d4,d0
 bsr.w L0003c
 addq.l #4,sp
 movea.l d0,a0
L00214 move.l a0,d0
 movem.l -20(a5),a0/a2-a4/d4
 unlk a5
 rts 

 ends 

