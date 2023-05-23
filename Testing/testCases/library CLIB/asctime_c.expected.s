 psect asctime_c,0,0,0,0,asctime


* D
 vsect 
D00000 ds.b 26


 ends 


* _
 vsect 
_00000 dc.l L00064
 dc.l L00068
 dc.l L0006c
 dc.l L00070
 dc.l L00074
 dc.l L00078
 dc.l L0007c
_0001c dc.l L00080
 dc.l L00084
 dc.l L00088
 dc.l L0008c
 dc.l L00090
 dc.l L00094
 dc.l L00098
 dc.l L0009c
 dc.l L000a0
 dc.l L000a4
 dc.l L000a8
 dc.l L000ac


 ends 

asctime: link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 movea.l (sp),a0
 move.l #1900,d0
 add.l 20(a0),d0
 move.l d0,-(sp)
 move.l (a0),-(sp)
 move.l 4(a0),-(sp)
 move.l 8(a0),-(sp)
 move.l 12(a0),-(sp)
 move.l 16(a0),d0
 lsl.l #2,d0
 lea _0001c(a6),a1
 move.l (a1,d0.l),-(sp)
 move.l 24(a0),d0
 lsl.l #2,d0
 lea _00000(a6),a1
 move.l (a1,d0.l),-(sp)
 lea L000b0(pc),a1
 move.l a1,d1
 lea D00000(a6),a1
 move.l a1,d0
 bsr.w sprintf
 lea 28(sp),sp
 lea D00000(a6),a0
 move.l a0,d0
 movem.l -12(a5),a0-a1/d1
 unlk a5
 rts 
L00064 dc.b $53,$75,$6e,$00
L00068 dc.b $4d,$6f,$6e,$00
L0006c dc.b $54,$75,$65,$00
L00070 dc.b $57,$65,$64,$00
L00074 dc.b $54,$68,$75,$00
L00078 dc.b $46,$72,$69,$00
L0007c dc.b $53,$61,$74,$00
L00080 dc.b $4a,$61,$6e,$00
L00084 dc.b $46,$65,$62,$00
L00088 dc.b $4d,$61,$72,$00
L0008c dc.b $41,$70,$72,$00
L00090 dc.b $4d,$61,$79,$00
L00094 dc.b $4a,$75,$6e,$00
L00098 dc.b $4a,$75,$6c,$00
L0009c dc.b $41,$75,$67,$00
L000a0 dc.b $53,$65,$70,$00
L000a4 dc.b $4f,$63,$74,$00
L000a8 dc.b $4e,$6f,$76,$00
L000ac dc.b $44,$65,$63,$00
L000b0 dc.b $25,$33,$73,$20,$25,$33
 dc.b $73,$20,$25,$32,$64,$20
 dc.b $25,$30,$32,$64,$3a,$25
 dc.b $30,$32,$64,$3a,$25,$30
 dc.b $32,$64,$20,$25,$34,$64
 dc.b $0d,$00,$00

 ends 

