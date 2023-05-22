
* Class equate external label equates

F$Link equ $00
F$Load equ $01
F$UnLink equ $02
F$Fork equ $03
F$Wait equ $04
F$Chain equ $05
F$Exit equ $06
F$Mem equ $07
F$Send equ $08
F$Icpt equ $09
F$Sleep equ $0a
F$SSpd equ $0b
F$ID equ $0c
F$SPrior equ $0d
F$PErr equ $0f
F$PrsNam equ $10
F$CmpNam equ $11
F$Time equ $15
F$STime equ $16
F$CRC equ $17
F$GPrDsc equ $18
F$GModDr equ $1a
F$CpyMem equ $1b
F$SUser equ $1c
F$UnLoad equ $1d
F$RTE equ $1e
F$GPrDBT equ $1f
F$Julian equ $20
F$TLink equ $21
F$DatMod equ $25
F$SetCRC equ $26
F$SetSys equ $27
F$SRqMem equ $28
F$SRtMem equ $29
F$SysDbg equ $52
F$Event equ $53
F$Alarm equ $56
F$SigMask equ $57
F$SRqCMem equ $5c
I$Dup equ $82
I$Create equ $83
I$Open equ $84
I$MakDir equ $85
I$Delete equ $87
I$Seek equ $88
I$Read equ $89
I$Write equ $8a
I$ReadLn equ $8b
I$WritLn equ $8c
I$GetStt equ $8d
I$SetStt equ $8e
I$Close equ $8f

Prgrm set $1
Objct set $1
ReEnt set $80

 psect cdi_zelda.os9module_a,(Prgrm<<8)|Objct,(ReEnt<<8)|1,7,0,L00052,L001bc


* OS9 data area definitions

 vsect 
D00000 ds.b 4
D00004 ds.b 4
D00008 ds.b 4
D0000c ds.b 4
D00010 ds.b 4
D00014 ds.b 4
D00018 ds.b 2
D0001a ds.b 4
D0001e ds.b 4
D00022 ds.b 2
D00024 ds.b 2
D00026 ds.b 2
D00028 ds.b 4
D0002c ds.b 4
D00030 ds.b 4
D00034 ds.b 4
D00038 ds.b 4
D0003c ds.b 4
D00040 ds.b 4
D00044 ds.b 4
D00048 ds.b 4
D0004c ds.b 4
D00050 ds.b 4
D00054 ds.b 2
D00056 ds.b 2
D00058 ds.b 4
D0005c ds.b 4
D00060 ds.b 28
D0007c ds.b 14
D0008a ds.b 4
D0008e ds.b 4
D00092 ds.b 4
D00096 ds.b 124
D00112 ds.b 64
D00152 ds.b 4
D00156 ds.b 124
D001d2 ds.b 2
D001d4 ds.b 2
D001d6 ds.b 1192
D0067e ds.b 4
D00682 ds.b 4
D00686 ds.b 4
D0068a ds.b 4
D0068e ds.b 4
D00692 ds.b 4
D00696 ds.b 4
D0069a ds.b 4
D0069e ds.b 8
D006a6 ds.b 28
D006c2 ds.b 4
D006c6 ds.b 256
D007c6 ds.b 16
D007d6 ds.b 2
D007d8 ds.b 26
D007f2 ds.b 2
D007f4 ds.b 26
D0080e ds.b 2
D00810 ds.b 826
D00b4a ds.b 4
D00b4e ds.b 4
D00b52 ds.b 4
D00b56 ds.b 4
D00b5a ds.b 4
D00b5e ds.b 4
D00b62 ds.b 4

* Initialized Data Definitions

 dc.l $000007ca
_00b6a dc.l $00000242
_00b6e dc.l $00000000
_00b72 dc.l $000000a5
 dc.l $000000a8
 dc.l $000000ab
 dc.l $000000ae
_00b82 dc.l $0000259c
 dc.l $000025a3
 dc.l $000025aa
 dc.l $000025b1
 dc.l $000025b8
 dc.l $000025bf
 dc.l $000025c6
_00b9e dc.l $000025cd
 dc.l $000025d1
 dc.l $000025d4
 dc.l $000025d7
 dc.l $000025da
 dc.l $000025de
 dc.l $000025e3
_00bba dc.l $0000fcc6
 dc.l $0000fd94
 dc.l $0000fd2c
 dc.l $0000fdfc
 dc.l $0000fe64
_00bce dc.w $fffa
 dc.w $fffc
 dc.w $fffe
 dc.w $0002
 dc.w $0004
 dc.w $0006
 dc.w $fffc
 dc.w $fffc
 dc.w $fffe
 dc.w $0002
 dc.w $0004
 dc.w $0004
 dc.w $fffc
 dc.w $fffe
 dc.w $0002
 dc.w $0004
 dc.w $fffe
 dc.w $0002
 dc.w $ffff
 dc.w $0001
 dc.w $0000
_00bf8 dc.l $00040000
 dc.l $0002ffff
 dc.l $0000ffff
 dc.l $00000000
 dc.l $00000000
 dc.l $fffe0004
 dc.l $fffc0003
 dc.l $fffcffff
 dc.l $fffeffff
 dc.l $0000ffff
 dc.l $00000000
 dc.l $00000000
 dc.l $00020004
 dc.l $00040003
 dc.l $0004ffff
 dc.l $0002ffff
 dc.l $0000ffff
 dc.l $00000000
 dc.l $00000000
 dc.l $fffe0004
 dc.l $fffe0002
 dc.l $fffe0002
 dc.l $00630063
_00c54 dc.w $0000
_00c56 dc.l $000000ef
 dc.l $efefc8c8
 dc.l $c80000c8
 dc.l $0000ef00
_00c66 dc.l $00000000
_00c6a dc.l $0000598a
 dc.l $0000598b
 dc.l $00005990
 dc.l $00005995
 dc.l $0000599a
 dc.l $0000599f
 dc.l $000059a4
 dc.l $000059a9
_00c8a dc.w $0000
 dc.w $59ae
 dc.w $0000
 dc.w $59b2
 dc.w $0000
 dc.w $59b7
 dc.w $0000
 dc.w $59bc
 dc.w $0000
 dc.w $59c1
 dc.w $0000
 dc.w $59c6
 dc.w $0000
 dc.w $59cb
 dc.w $0000
 dc.w $59d0
 dc.w $0000
 dc.w $59d5
 dc.w $0063
 dc.w $fffc
 dc.w $fffc
 dc.w $fffe
 dc.w $fffe
 dc.w $fffe
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0002
 dc.w $0002
 dc.w $0002
 dc.w $0004
 dc.w $0004
 dc.w $0063
_00cd0 dc.w $0000
 dc.w $0cc0
 dc.w $0000
 dc.w $0000
 dc.w $0000
_00cda dc.w $0001
_00cdc dc.w $0001
_00cde dc.w $0002
 dc.w $0103
 dc.w $0002
 dc.w $0102
 dc.w $0002
_00ce8 dc.l $00000000
_00cec dc.w $0000
_00cee dc.l $00000000
_00cf2 dc.l $00000000
_00cf6 dc.w $00ff
_00cf7 equ *-1
_00cf8 dc.w $0000
_00cfa dc.w $0000
_00cfc dc.l $00000000
_00d00 dc.l $00000000
_00d04 dc.l $000066b6
 dc.l $00000000
 dc.l $00006398
 dc.l $00000000
 dc.l $00006446
 dc.l $00000041
 dc.l $00006446
 dc.l $00000042
 dc.l $00006446
 dc.l $00000043
 dc.l $00006446
 dc.l $00000044
 dc.l $00006446
 dc.l $00000045
 dc.l $00006446
 dc.l $00000046
 dc.l $00006446
 dc.l $00000047
 dc.l $00006446
 dc.l $00000048
 dc.l $00006446
 dc.l $00000049
 dc.l $00006446
 dc.l $0000004a
 dc.l $00006446
 dc.l $0000004b
 dc.l $00006446
 dc.l $0000004c
 dc.l $00006446
 dc.l $0000004d
 dc.l $00006446
 dc.l $0000004e
 dc.l $00006446
 dc.l $0000004f
 dc.l $00006446
 dc.l $00000050
 dc.l $00006446
 dc.l $00000051
 dc.l $00006446
 dc.l $00000052
 dc.l $00006446
 dc.l $00000053
 dc.l $00006446
 dc.l $00000054
 dc.l $00006446
 dc.l $00000055
 dc.l $00006446
 dc.l $00000056
 dc.l $00006446
 dc.l $00000057
 dc.l $00006446
 dc.l $00000058
 dc.l $00006446
 dc.l $00000059
 dc.l $00006446
 dc.l $0000005a
_00de4 dc.w $0000
_00de6 dc.l $00008c68
 dc.l $00008c6c
 dc.l $00008c70
 dc.l $00008c74
 dc.l $00008c78
 dc.l $00008c7c
 dc.l $00008c80
 dc.l $00008c84
 dc.l $00008c88
 dc.l $00008c8c
 dc.l $00008c8f
 dc.l $00008c92
 dc.l $00008c96
 dc.l $00008c9b
 dc.l $00008ca0
 dc.l $00008ca5
_00e26 dc.w $e000
 dc.w $f000
 dc.w $f800
 dc.w $7c00
 dc.w $3e00
 dc.w $1f00
 dc.w $0f80
 dc.w $07cc
 dc.w $03fc
 dc.w $01f8
 dc.w $00f0
 dc.w $00f8
 dc.w $01dc
 dc.w $018e
 dc.w $0007
 dc.w $0003
 dc.w $0000
_00e48 dc.w $0000
 dc.w $0000
 dc.w $1434
 dc.w $0000
 dc.w $0000
 dc.w $0300
 dc.w $01e0
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
_00e66 dc.l $0000add8
 dc.l $0000b6ac
 dc.l $0000add8
 dc.l $0000ada0
 dc.l $0000a006
 dc.l $00000000
 dc.l $0000a0b2
 dc.l $00000000
 dc.l $0000a172
 dc.l $00000000
 dc.l $0000a214
 dc.l $00000000
_00e96 dc.l $0000a5d0
 dc.l $00000000
 dc.l $0000a5d0
 dc.l $00000000
 dc.l $0000a5d0
 dc.l $00000000
 dc.l $0000a5d0
 dc.l $00000000
 dc.l $0000a5d0
 dc.l $00000000
 dc.l $0000a5d0
 dc.l $00000000
_00ec6 dc.l $00009f7c
 dc.l $00000000
 dc.l $00009f7c
 dc.l $00000000
 dc.l $00009f7c
 dc.l $00000000
 dc.l $00009f7c
 dc.l $00000000
 dc.l $00009f7c
 dc.l $00000000
 dc.l $00009f7c
 dc.l $00000000
_00ef6 dc.l $00080000
 dc.l $a5d00000
 dc.l $00000100
 dc.l $00009f7c
 dc.l $00000000
 dc.l $40040000
 dc.l $9ce80000
 dc.l $00000100
 dc.l $00009f7c
 dc.l $00000000
 dc.l $00080000
 dc.l $a5d00000
 dc.l $00004004
 dc.l $00009ce8
 dc.l $00000001
_00f32 dc.l $01000000
 dc.l $9f7c0000
 dc.l $00004008
 dc.l $0000a5d0
 dc.l $00000000
_00f46 dc.b $00
 dc.b $00
 dc.b $00
_00f49 dc.b $01
 dc.b $40
 dc.b $0c
 dc.b $00
 dc.b $00
 dc.b $b3
 dc.b $40
 dc.b $00
 dc.b $00
 dc.b $00
 dc.b $00
_00f54 dc.l $0000bca8
 dc.l $00000000
 dc.l $0000ba98
 dc.l $00000000
 dc.l $0000ba58
 dc.l $00000000
_00f6c dc.l $0000cf04
 dc.l $00000000
 dc.l $0000ccd0
 dc.l $00000000
 dc.l $0000ce3a
 dc.l $00000000
 dc.l $0000cfd6
 dc.l $00000000
 dc.l $0000cebe
 dc.l $00000000
_00f94 dc.l $0000cb58
 dc.l $00000000
 dc.l $0000cb58
 dc.l $00000000
 dc.l $0000cb58
 dc.l $00000000
 dc.l $0000cb58
 dc.l $00000000
 dc.l $0000cb58
 dc.l $00000000
_00fbc dc.w $400c
 dc.w $0000
 dc.w $ccf4
 dc.w $0000
 dc.w $0000
 dc.w $400c
 dc.w $0000
 dc.w $ccf4
 dc.w $0000
 dc.w $0001
 dc.w $400c
 dc.w $0000
 dc.w $ccf4
 dc.w $0000
 dc.w $0002
_00fda dc.w $4100
 dc.w $0000
 dc.w $cb58
 dc.w $0000
 dc.w $0000
_00fe4 dc.w $0034
 dc.w $004a
 dc.w $0060
_00fea dc.w $0000
_00fec dc.w $0000
_00fee dc.w $ffff
_00ff0 dc.w $400c
 dc.w $0000
 dc.w $dd58
 dc.w $0000
 dc.w $0000
_00ffa dc.l $000000f0
_00ffe dc.l $00000000
_01002 dc.l $00010409
 dc.l $101b2c4f
 dc.l $80b1d4e5
 dc.l $f0f7fcff
_01012 dc.w $0000
_01014 dc.w $0170
_01016 dc.l $00012ce8
 dc.l $00012cec
 dc.l $00012cef
 dc.l $00012cf2
 dc.l $00012cf5
 dc.l $00012cf9
 dc.l $00012cfe
_01032 dc.l $0000fffc
 dc.l $00040000
 dc.l $00000004
 dc.l $fffc0000
_01042 dc.l $fffcfffc
 dc.l $0004fffc
 dc.l $00040004
 dc.l $fffc0004
_01052 dc.l $000a0000
 dc.l $fff60000
_0105a dc.l $00000008
 dc.l $0000fff8
_01062 dc.l $00000002
 dc.l $0000fffe
_0106a dc.l $fffe0000
 dc.l $00020000
 dc.l $000a000a
 dc.l $00000000
 dc.l $000c000c
 dc.l $00000000
 dc.l $00110011
 dc.l $00000000
 dc.l $00140014
 dc.l $00000000
_01092 dc.l $00001072
 dc.l $00001082
_0109a dc.w $ffff
 dc.w $0000
 dc.w $0000
 dc.w $ffff
 dc.w $ffff
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0001
 dc.w $0001
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0001
 dc.w $0000
 dc.w $0001
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $ffff
 dc.w $0063
_010c4 dc.l $80808080
 dc.l $18181818
_010cc dc.l $00010001
_010d0 dc.l $00010001
 dc.l $ffff0001
 dc.l $ffffffff
 dc.l $0001ffff
 dc.l $40282329
 dc.l $6364666d
 dc.l $2e680931
 dc.l $2e310933
 dc.l $2f31342f
 dc.l $39300000
 dc.l $40282329
 dc.l $6364666d
 dc.l $2e680931
 dc.l $2e310933
 dc.l $2f31342f
 dc.l $39300000
 dc.l $40282329
 dc.l $6364666d
 dc.l $2e680931
 dc.l $2e310933
 dc.l $2f31342f
 dc.l $39300000
 dc.l $40282329
 dc.l $6364666d
 dc.l $2e680931
 dc.l $2e310933
 dc.l $2f31342f
 dc.l $39300000
 dc.l $40282329
 dc.l $6364666d
 dc.l $2e680931
 dc.l $2e310933
 dc.l $2f31342f
 dc.l $39300000
 dc.l $40282329
 dc.l $6364666d
 dc.l $2e680931
 dc.l $2e310933
 dc.l $2f31342f
 dc.l $39300000
 dc.l $40282329
 dc.l $6364666d
 dc.l $2e680931
 dc.l $2e310933
 dc.l $2f31342f
 dc.l $39300000
 dc.l $40282329
 dc.l $6364666d
 dc.l $2e680931
 dc.l $2e310933
 dc.l $2f31342f
 dc.l $39300000
_011a0 dc.w $0000
_011a2 dc.w $0000
_011a4 dc.l $00000000
_011a8 dc.w $0000
_011aa dc.w $0000
_011ac dc.w $0000
 dc.w $0000
 dc.w $0092
 dc.w $0000
 dc.w $0112
 dc.w $0000
 dc.w $0152
_011ba dc.w $0000
_011bb equ *-1
_011bc dc.w $ffff
_011be dc.w $ffff
_011c0 dc.w $ffff
_011c2 dc.w $ffff
_011c4 dc.w $ffff
_011c6 dc.w $ffff
_011c8 dc.l $ffffffff
_011cc dc.l $ffffffff
_011d0 dc.l $00000000
_011d4 dc.l $00000000
_011d8 dc.l $00000000
_011dc dc.l $00000000
 dc.l $40282329
 dc.l $75636d2e
 dc.l $6809312e
 dc.l $3109332f
 dc.l $31342f39
 dc.l $30004028
 dc.l $23297563
 dc.l $6d2e6809
 dc.l $312e3109
 dc.l $332f3134
 dc.l $2f393000
 dc.l $40282329
 dc.l $75636d2e
 dc.l $6809312e
 dc.l $3109332f
 dc.l $31342f39
 dc.l $30004028
 dc.l $23297563
 dc.l $6d2e6809
 dc.l $312e3109
 dc.l $332f3134
 dc.l $2f393000
_01238 dc.w $0001
 dc.w $0001
 dc.w $6460
 dc.w $0000
 dc.w $0000
 dc.w $0004
 dc.w $0001
 dc.w $64b4
 dc.w $0000
 dc.w $0001
 dc.w $0008
 dc.w $0001
 dc.w $64b4
 dc.w $0000
 dc.w $0002
 dc.w $0010
 dc.w $0001
 dc.w $6460
 dc.w $0000
 dc.w $0003
 dc.w $0020
 dc.w $0001
 dc.w $6460
 dc.w $0000
 dc.w $0004
 dc.w $0100
 dc.w $0001
 dc.w $6664
 dc.w $0000
 dc.w $0005
 dc.w $4200
 dc.w $0001
 dc.w $67ae
 dc.w $0000
 dc.w $0006
 dc.w $0001
 dc.w $0001
 dc.w $6460
 dc.w $0000
 dc.w $0000
 dc.w $0004
 dc.w $0001
 dc.w $68d4
 dc.w $0000
 dc.w $0001
 dc.w $0008
 dc.w $0001
 dc.w $68d4
 dc.w $0000
 dc.w $0002
 dc.w $0010
 dc.w $0001
 dc.w $6460
 dc.w $0000
 dc.w $0003
 dc.w $0020
 dc.w $0001
 dc.w $6460
 dc.w $0000
 dc.w $0004
 dc.w $0100
 dc.w $0001
 dc.w $6460
 dc.w $0000
 dc.w $0005
 dc.w $4200
 dc.w $0001
 dc.w $6460
 dc.w $0000
 dc.w $0006
 dc.w $4028
 dc.w $2329
 dc.w $7563
 dc.w $6d2e
 dc.w $6809
 dc.w $312e
 dc.w $3109
 dc.w $332f
 dc.w $3134
 dc.w $2f39
 dc.w $3000
_012da dc.l $00017eae
 dc.l $40282329
 dc.l $75636d2e
 dc.l $6809312e
 dc.l $3109332f
 dc.l $31342f39
 dc.l $30004028
 dc.l $23297563
 dc.l $6d2e6809
 dc.l $312e3109
 dc.l $332f3134
 dc.l $2f393000
_0130a dc.w $2065
 dc.w $6169
 dc.w $6f75
 dc.w $7473
 dc.w $7264
 dc.w $6668
 dc.w $6c6e
 dc.w $7045
 dc.w $4149
 dc.w $4f55
 dc.w $5453
 dc.w $5244
 dc.w $4648
 dc.w $4c4e
 dc.w $5000
 dc.w $0102
 dc.w $0304
 dc.w $3031
 dc.w $3233
 dc.w $3435
 dc.w $3637
 dc.w $3839
 dc.w $6263
 dc.w $6467
 dc.w $6a6d
 dc.w $7176
 dc.w $7778
 dc.w $797a
 dc.w $4243
 dc.w $4447
 dc.w $4a00
_01348 dc.l $00000000
_0134c dc.l $00019426
 dc.l $00000000
_01354 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
_01360 dc.l $00000000
_01364 dc.l $00000000
_01368 dc.l $00000000
_0136c dc.l $00000000
_01370 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0080
 dc.w $0000
 dc.w $0081
 dc.w $0000
 dc.w $0001
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
_013ae dc.l $00001388
_013b2 dc.w $0000
 dc.w $ffff
 dc.w $ffff
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0001
 dc.w $a8aa
 dc.w $0001
 dc.w $a91e
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $8000
 dc.w $c000
 dc.w $e000
 dc.w $f000
 dc.w $f800
 dc.w $fc00
 dc.w $fe00
 dc.w $ff00
 dc.w $f800
 dc.w $d800
 dc.w $8c00
 dc.w $0c00
 dc.w $0600
 dc.w $0600
 dc.w $0300
 dc.w $0300
 dc.w $0000
 dc.w $1400
 dc.w $ffff
 dc.w $ffff
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0000
_01434 dc.w $2080
 dc.w $0000
 dc.w $1420
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $1420
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.w $0010
 dc.w $0010
 dc.w $0010
_0144e dc.l $80000000
 dc.l $1434ffff
 dc.l $00000000
 dc.l $00000000
 dc.l $0000ffff
 dc.l $ffff0180
 dc.l $00f00000
 dc.l $00000000
 dc.l $00000000
 dc.l $00000300
 dc.l $00000208
 dc.l $00000000
 dc.l $00000000
 dc.l $00019ae8
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
 dc.l $00000003
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
 dc.l $0000000a
 dc.l $00000001
 dc.l $a1300000
 dc.l $14d40100
 dc.l $0001a130
 dc.l $000014d4
 dc.l $01000001
 dc.l $a1300000
 dc.l $14d40100
 dc.l $0001a146
 dc.l $00000000
 dc.l $01000001
 dc.l $a1460000
 dc.l $00000100
 dc.l $0001a130
 dc.l $000014d4
 dc.l $01000001
 dc.l $a1300000
 dc.l $14d40100
 dc.l $0001a130
 dc.l $000014d4
 dc.l $01000001
 dc.l $a1300000
 dc.l $14d40100
 dc.l $0001a130
 dc.l $000014d4
 dc.l $01000001
 dc.l $a1300000
 dc.l $14d40100
_0154a dc.l $00000000
_0154e dc.w $0000
_01550 dc.l $000014d4
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
 dc.l $00000000
_01590 dc.w $0000
_01592 dc.l $00000000
_01596 dc.w $0019
_01598 dc.w $0000
_0159a dc.l $00000000
_0159e dc.l $00000000
_015a2 dc.l $00000000
_015a6 dc.w $0017
_015a8 dc.l $0001a750
_015ac dc.l $00000000
_015b0 dc.l $00000000
_015b4 dc.l $00000000
_015b8 dc.w $0000
_015ba dc.l $4473705f
_015be dc.w $0000
 dc.w $0000
 dc.w $0000
_015c4 dc.l $00001221
_015c8 dc.l $0001b120
_015cc dc.l $000015cc
 dc.l $00000000
_015d4 dc.l $00000000
 dc.l $00000000
_015dc dc.l $00000000
_015e0 dc.b $00
 dc.b $00
 dc.b $02
 dc.b $00
 dc.b $00
_015e5 dc.b $01
 dc.b $01
 dc.b $01
 dc.b $01
 dc.b $01
 dc.b $01
 dc.b $01
 dc.b $01
 dc.b $01
 dc.b $11
 dc.b $11
 dc.b $01
 dc.b $11
 dc.b $11
 dc.b $01
 dc.b $01
 dc.b $01
 dc.b $01
 dc.b $01
 dc.b $01
 dc.b $01
 dc.b $01
 dc.b $01
 dc.b $01
 dc.b $01
 dc.b $01
 dc.b $01
 dc.b $01
 dc.b $01
 dc.b $01
 dc.b $01
 dc.b $01
 dc.b $30
 dc.b $20
 dc.b $20
 dc.b $20
 dc.b $20
 dc.b $20
 dc.b $20
 dc.b $20
 dc.b $20
 dc.b $20
 dc.b $20
 dc.b $20
 dc.b $20
 dc.b $20
 dc.b $20
 dc.b $20
 dc.b $48
 dc.b $48
 dc.b $48
 dc.b $48
 dc.b $48
 dc.b $48
 dc.b $48
 dc.b $48
 dc.b $48
 dc.b $48
 dc.b $20
 dc.b $20
 dc.b $20
 dc.b $20
 dc.b $20
 dc.b $20
 dc.b $20
 dc.b $42
 dc.b $42
 dc.b $42
 dc.b $42
 dc.b $42
 dc.b $42
 dc.b $02
 dc.b $02
 dc.b $02
 dc.b $02
 dc.b $02
 dc.b $02
 dc.b $02
 dc.b $02
 dc.b $02
 dc.b $02
 dc.b $02
 dc.b $02
 dc.b $02
 dc.b $02
 dc.b $02
 dc.b $02
 dc.b $02
 dc.b $02
 dc.b $02
 dc.b $02
 dc.b $20
 dc.b $20
 dc.b $20
 dc.b $20
 dc.b $20
 dc.b $20
 dc.b $44
 dc.b $44
 dc.b $44
 dc.b $44
 dc.b $44
 dc.b $44
 dc.b $04
 dc.b $04
 dc.b $04
 dc.b $04
 dc.b $04
 dc.b $04
 dc.b $04
 dc.b $04
 dc.b $04
 dc.b $04
 dc.b $04
 dc.b $04
 dc.b $04
 dc.b $04
 dc.b $04
 dc.b $04
 dc.b $04
 dc.b $04
 dc.b $04
 dc.b $04
 dc.b $20
 dc.b $20
 dc.b $20
 dc.b $20
 dc.b $01
 dc.b $00
_01666 dc.w $0000
 dc.w $2000
 dc.w $4ef9
_0166c dc.l $000110cc
_01670 dc.w $4ef9
 dc.w $0001
 dc.w $1d68
_01676 dc.w $4ef9
 dc.w $0001
 dc.w $290e
_0167c dc.w $4ef9
 dc.w $0001
 dc.w $29f6
_01682 dc.w $4ef9
 dc.w $0001
 dc.w $2cae
_01688 dc.w $4ef9
 dc.w $0001
 dc.w $2756
_0168e dc.w $4ef9
 dc.w $0001
 dc.w $2a86
_01694 dc.w $4ef9
 dc.w $0001
 dc.w $2ad4
_0169a dc.w $4ef9
 dc.w $0001
 dc.w $0d92
_016a0 dc.w $4ef9
 dc.w $0001
 dc.w $ca40
_016a6 dc.w $4ef9
 dc.w $0001
 dc.w $a7bc
_016ac dc.w $4ef9
 dc.w $0001
 dc.w $c98a
_016b2 dc.l $4ef90001
 dc.l $6d804ef9
_016ba dc.l $0000e580
_016be dc.w $4ef9
 dc.w $0001
 dc.w $4194
_016c4 dc.w $4ef9
 dc.w $0001
 dc.w $401a
_016ca dc.w $4ef9
 dc.w $0001
 dc.w $3f56
_016d0 dc.w $4ef9
 dc.w $0001
 dc.w $398c
_016d6 dc.w $4ef9
 dc.w $0001
 dc.w $3aa2
_016dc dc.w $4ef9
 dc.w $0001
 dc.w $39e4
_016e2 dc.w $4ef9
 dc.w $0001
 dc.w $3e0c
_016e8 dc.w $4ef9
 dc.w $0001
 dc.w $3d72
_016ee dc.w $4ef9
 dc.w $0001
 dc.w $40a6
_016f4 dc.w $4ef9
 dc.w $0001
 dc.w $d1c6
_016fa dc.w $4ef9
 dc.w $0001
 dc.w $4bea
_01700 dc.w $4ef9
 dc.w $0001
 dc.w $4c64
_01706 dc.w $4ef9
 dc.w $0001
 dc.w $4aa8
_0170c dc.w $4ef9
 dc.w $0001
 dc.w $5c48
_01712 dc.w $4ef9
 dc.w $0001
 dc.w $cf5a
_01718 dc.w $4ef9
 dc.w $0001
 dc.w $9cdc
_0171e dc.w $4ef9
 dc.w $0001
 dc.w $9f9e
_01724 dc.w $4ef9
 dc.w $0000
 dc.w $9536
_0172a dc.w $4ef9
 dc.w $0000
 dc.w $97d4
_01730 dc.w $4ef9
 dc.w $0000
 dc.w $9648
_01736 dc.w $4ef9
 dc.w $0000
 dc.w $9684
_0173c dc.w $4ef9
 dc.w $0000
 dc.w $9828
_01742 dc.w $4ef9
 dc.w $0000
 dc.w $936a
_01748 dc.l $4ef90000
 dc.l $94684ef9
_01750 dc.l $0000c9cc
_01754 dc.w $4ef9
 dc.w $0001
 dc.w $347e
_0175a dc.w $4ef9
 dc.w $0001
 dc.w $4b64
_01760 dc.w $4ef9
 dc.w $0000
 dc.w $c834
_01766 dc.l $4ef90000
 dc.l $c6c64ef9
_0176e dc.w $0000
 dc.w $f842
 dc.w $4ef9
_01774 dc.w $0000
 dc.w $f426
 dc.w $4ef9
_0177a dc.w $0000
 dc.w $fc50
 dc.w $4ef9
_01780 dc.w $0000
 dc.w $fb9c
 dc.w $4ef9
_01786 dc.l $0000f9ac
_0178a dc.w $4ef9
 dc.w $0001
 dc.w $0482
_01790 dc.w $4ef9
 dc.w $0001
 dc.w $1c98
_01796 dc.w $4ef9
 dc.w $0001
 dc.w $190e
_0179c dc.w $4ef9
 dc.w $0001
 dc.w $28ca
_017a2 dc.w $4ef9
 dc.w $0001
 dc.w $2834
_017a8 dc.w $4ef9
 dc.w $0001
 dc.w $4140
_017ae dc.w $4ef9
 dc.w $0001
 dc.w $caa2
_017b4 dc.w $4ef9
 dc.w $0001
 dc.w $ab14
_017ba dc.w $4ef9
 dc.w $0001
 dc.w $b47a
_017c0 dc.w $4ef9
 dc.w $0001
 dc.w $a816
_017c6 dc.w $4ef9
 dc.w $0001
 dc.w $c870
_017cc dc.w $4ef9
 dc.w $0001
 dc.w $5752
_017d2 dc.w $4ef9
 dc.w $0001
 dc.w $b54e
_017d8 dc.w $4ef9
 dc.w $0001
 dc.w $6062
_017de dc.w $4ef9
 dc.w $0001
 dc.w $6034
_017e4 dc.w $4ef9
 dc.w $0001
 dc.w $5e04
_017ea dc.w $4ef9
 dc.w $0001
 dc.w $b390
_017f0 dc.w $4ef9
 dc.w $0001
 dc.w $b330
_017f6 dc.w $4ef9
 dc.w $0001
 dc.w $be26
_017fc dc.w $4ef9
 dc.w $0001
 dc.w $7982
_01802 dc.w $4ef9
 dc.w $0001
 dc.w $733a
_01808 dc.w $4ef9
 dc.w $0001
 dc.w $72da
_0180e dc.w $4ef9
 dc.w $0001
 dc.w $7264
_01814 dc.w $4ef9
 dc.w $0001
 dc.w $97f4
_0181a dc.l $4ef90001
 dc.l $b4f84ef9
_01822 dc.w $0001
 dc.w $1768
 dc.w $4ef9
_01828 dc.l $000111ae
_0182c dc.w $4ef9
 dc.w $0001
 dc.w $1b8a
_01832 dc.w $4ef9
 dc.w $0001
 dc.w $24c4
_01838 dc.w $4ef9
 dc.w $0001
 dc.w $6f38
_0183e dc.w $4ef9
 dc.w $0001
 dc.w $6e04
_01844 dc.w $4ef9
 dc.w $0001
 dc.w $78ec
_0184a dc.w $4ef9
 dc.w $0001
 dc.w $9814
_01850 dc.w $4ef9
 dc.w $0001
 dc.w $be08
_01856 dc.w $4ef9
 dc.w $0001
 dc.w $7454
_0185c dc.w $4ef9
 dc.w $0001
 dc.w $7802
_01862 dc.w $4ef9
 dc.w $0001
 dc.w $78ae
_01868 dc.w $4ef9
 dc.w $0001
 dc.w $7482
_0186e dc.w $4ef9
 dc.w $0001
 dc.w $736c
_01874 dc.w $4ef9
 dc.w $0001
 dc.w $3af4
_0187a dc.w $4ef9
 dc.w $0001
 dc.w $a6ba
_01880 dc.l $4ef90001
 dc.l $b50e4ef9
_01888 dc.w $0001
 dc.w $117a
 dc.w $4ef9
_0188e dc.l $00011008
_01892 dc.w $4ef9
 dc.w $0001
 dc.w $0e14
_01898 dc.w $4ef9
 dc.w $0001
 dc.w $0dbc
_0189e dc.w $4ef9
 dc.w $0001
 dc.w $1896
_018a4 dc.w $4ef9
 dc.w $0001
 dc.w $16de
_018aa dc.l $4ef90001
 dc.l $14444ef9
_018b2 dc.l $0001219e
_018b6 dc.w $4ef9
 dc.w $0001
 dc.w $1216
_018bc dc.w $4ef9
 dc.w $0001
 dc.w $2b1a
_018c2 dc.w $4ef9
 dc.w $0001
 dc.w $4448
_018c8 dc.w $4ef9
 dc.w $0001
 dc.w $4a66
_018ce dc.w $4ef9
 dc.w $0001
 dc.w $6cd2
_018d4 dc.l $4ef90001
 dc.l $6e8a4ef9
_018dc dc.l $00011db2
_018e0 dc.l $4ef90001
 dc.l $12784ef9
_018e8 dc.l $00011e88
_018ec dc.w $4ef9
_018ee dc.w $0001
 dc.w $0f0c
 dc.w $4ef9
_018f4 dc.w $0001
 dc.w $2e32
 dc.w $4ef9
_018fa dc.w $0001
 dc.w $435a
 dc.w $4ef9
_01900 dc.l $000142aa
_01904 dc.w $4ef9
 dc.w $0001
 dc.w $ca78
_0190a dc.w $4ef9
 dc.w $0001
 dc.w $7d44
_01910 dc.w $4ef9
 dc.w $0000
 dc.w $f0ea
_01916 dc.w $4ef9
 dc.w $0000
 dc.w $ebb4
_0191c dc.w $4ef9
 dc.w $0001
 dc.w $d574
_01922 dc.w $4ef9
 dc.w $0001
 dc.w $6a70
_01928 dc.w $4ef9
 dc.w $0001
 dc.w $63ce
_0192e dc.w $4ef9
 dc.w $0001
 dc.w $61d6
_01934 dc.w $4ef9
 dc.w $0001
 dc.w $6b8c
_0193a dc.w $4ef9
 dc.w $0001
 dc.w $a29a
_01940 dc.l $4ef90001
 dc.l $9e5c4ef9
_01948 dc.l $0001709a
_0194c dc.w $4ef9
 dc.w $0001
 dc.w $0b50
_01952 dc.w $4ef9
 dc.w $0001
 dc.w $4106
_01958 dc.w $4ef9
 dc.w $0001
 dc.w $d686
_0195e dc.w $4ef9
 dc.w $0001
 dc.w $ace2
_01964 dc.w $4ef9
 dc.w $0001
 dc.w $cc4a
_0196a dc.w $4ef9
 dc.w $0001
 dc.w $c982
_01970 dc.w $4ef9
 dc.w $0001
 dc.w $cec8
_01976 dc.w $4ef9
 dc.w $0001
 dc.w $5ae4
_0197c dc.w $4ef9
 dc.w $0001
 dc.w $5b20
_01982 dc.w $4ef9
 dc.w $0001
 dc.w $5d82
_01988 dc.w $4ef9
 dc.w $0001
 dc.w $b2d8
_0198e dc.w $4ef9
 dc.w $0001
 dc.w $b30a
_01994 dc.w $4ef9
 dc.w $0001
 dc.w $1bc2
_0199a dc.w $4ef9
 dc.w $0001
 dc.w $d3dc
_019a0 dc.w $4ef9
 dc.w $0001
 dc.w $6bca
_019a6 dc.w $4ef9
 dc.w $0001
 dc.w $9bec
_019ac dc.w $4ef9
 dc.w $0001
 dc.w $9c1a
_019b2 dc.w $4ef9
 dc.w $0001
 dc.w $9e0a
_019b8 dc.w $4ef9
 dc.w $0001
 dc.w $9f68
_019be dc.w $4ef9
 dc.w $0001
 dc.w $7e40
_019c4 dc.w $4ef9
 dc.w $0001
 dc.w $d342
_019ca dc.w $4ef9
 dc.w $0001
 dc.w $aa4e
_019d0 dc.w $4ef9
 dc.w $0001
 dc.w $cd7a
_019d6 dc.w $4ef9
 dc.w $0001
 dc.w $afe6
_019dc dc.w $4ef9
 dc.w $0001
 dc.w $a61a
_019e2 dc.w $4ef9
 dc.w $0001
 dc.w $a75c
_019e8 dc.w $4ef9
 dc.w $0001
 dc.w $a554
_019ee dc.w $4ef9
 dc.w $0001
 dc.w $c5b4
_019f4 dc.w $4ef9
 dc.w $0001
 dc.w $853e
_019fa dc.w $4ef9
 dc.w $0001
 dc.w $84a0
_01a00 dc.w $4ef9
 dc.w $0001
 dc.w $8366
_01a06 dc.w $4ef9
 dc.w $0001
 dc.w $cd64
_01a0c dc.w $4ef9
 dc.w $0001
 dc.w $54ae
_01a12 dc.w $4ef9
 dc.w $0001
 dc.w $5606
_01a18 dc.w $4ef9
 dc.w $0001
 dc.w $56fc
_01a1e dc.w $4ef9
 dc.w $0001
 dc.w $ce5e
_01a24 dc.w $4ef9
 dc.w $0001
 dc.w $a0ae
_01a2a dc.w $4ef9
 dc.w $0001
 dc.w $b2e0
_01a30 dc.w $4ef9
 dc.w $0001
 dc.w $b34c
_01a36 dc.w $4ef9
 dc.w $0001
 dc.w $984e
_01a3c dc.w $4ef9
 dc.w $0001
 dc.w $9c50
_01a42 dc.w $4ef9
 dc.w $0001
 dc.w $9f1e
_01a48 dc.w $4ef9
 dc.w $0001
 dc.w $6f9c
_01a4e dc.w $4ef9
 dc.w $0001
 dc.w $977e
_01a54 dc.w $4ef9
 dc.w $0000
 dc.w $1198
_01a5a dc.w $4ef9
 dc.w $0001
 dc.w $47d6
_01a60 dc.w $4ef9
 dc.w $0001
 dc.w $d556
_01a66 dc.w $4ef9
 dc.w $0000
 dc.w $2672
_01a6c dc.w $4ef9
 dc.w $0001
 dc.w $6292
_01a72 dc.w $4ef9
 dc.w $0001
 dc.w $be42
_01a78 dc.w $4ef9
 dc.w $0001
 dc.w $464a
_01a7e dc.w $4ef9
 dc.w $0001
 dc.w $8a08
_01a84 dc.w $4ef9
 dc.w $0001
 dc.w $8582
_01a8a dc.w $4ef9
 dc.w $0001
 dc.w $cdb6
_01a90 dc.l $4ef90001
 dc.l $ce984ef9
_01a98 dc.l $00000918
_01a9c dc.w $4ef9
 dc.w $0000
 dc.w $3746
_01aa2 dc.w $4ef9
 dc.w $0001
 dc.w $4ae2
_01aa8 dc.w $4ef9
 dc.w $0001
 dc.w $4ba6
_01aae dc.w $4ef9
 dc.w $0001
 dc.w $bd94
_01ab4 dc.w $4ef9
 dc.w $0001
 dc.w $8300
_01aba dc.w $4ef9
 dc.w $0001
 dc.w $82c0
_01ac0 dc.l $4ef90001
 dc.l $82604ef9
_01ac8 dc.l $00002120
_01acc dc.w $4ef9
 dc.w $0001
 dc.w $b444
_01ad2 dc.w $4ef9
 dc.w $0001
 dc.w $b4e4
_01ad8 dc.l $4ef90000
 dc.l $178e4ef9
_01ae0 dc.l $000022c0
_01ae4 dc.w $4ef9
 dc.w $0000
 dc.w $307a
_01aea dc.w $4ef9
 dc.w $0000
 dc.w $336a
_01af0 dc.w $4ef9
 dc.w $0000
 dc.w $5412
_01af6 dc.w $4ef9
 dc.w $0000
 dc.w $4070
_01afc dc.w $4ef9
 dc.w $0000
 dc.w $4876
_01b02 dc.w $4ef9
_01b04 dc.w $0000
 dc.w $437e
 dc.w $4ef9
_01b0a dc.l $00005fb0
_01b0e dc.w $4ef9
 dc.w $0000
 dc.w $5ce8
_01b14 dc.w $4ef9
 dc.w $0000
 dc.w $5a6a
_01b1a dc.w $4ef9
 dc.w $0000
 dc.w $613e
_01b20 dc.w $4ef9
 dc.w $0000
 dc.w $0856
_01b26 dc.w $4ef9
 dc.w $0000
 dc.w $77fe
_01b2c dc.w $4ef9
 dc.w $0000
 dc.w $8ba2
_01b32 dc.l $4ef90000
 dc.l $293c4ef9
_01b3a dc.l $00004b84
_01b3e dc.w $4ef9
 dc.w $0001
 dc.w $d10c
_01b44 dc.w $4ef9
 dc.w $0001
 dc.w $b3b2
_01b4a dc.w $4ef9
 dc.w $0001
 dc.w $b42c
_01b50 dc.w $4ef9
 dc.w $0001
 dc.w $b486
_01b56 dc.w $4ef9
 dc.w $0001
 dc.w $bea4
_01b5c dc.w $4ef9
 dc.w $0000
 dc.w $27b4
_01b62 dc.w $4ef9
 dc.w $0000
 dc.w $5688
_01b68 dc.w $4ef9
 dc.w $0001
 dc.w $d198
_01b6e dc.w $4ef9
 dc.w $0001
 dc.w $d64e
_01b74 dc.w $4ef9
 dc.w $0000
 dc.w $016e
 dc.w $4ef9
 dc.w $0000
 dc.w $0000
 dc.w $4ef9
 dc.w $0000
 dc.w $0000
 dc.w $4ef9
 dc.w $0000
 dc.w $0000
 dc.w $4ef9
 dc.w $0000
 dc.w $0000
 dc.w $4ef9
 dc.w $0000
 dc.w $0000
 dc.w $4ef9
 dc.w $0000
 dc.w $0000
 dc.w $4ef9
 dc.w $0000
 dc.w $0000
 dc.w $4ef9
 dc.w $0000
 dc.w $0000
 dc.w $4ef9
 dc.w $0000
 dc.w $0000
 dc.w $4ef9
 dc.w $0000
 dc.w $0000
 dc.w $4ef9
 dc.w $0000
 dc.w $0000
 dc.w $4ef9
 dc.w $0000
 dc.w $0000
 dc.w $4ef9
 dc.w $0000
 dc.w $0000
 dc.w $4ef9
 dc.w $0000
 dc.w $0000
 ends 

L00048 bls.s L000ae
L0004a dc.w $695f
L0004c moveq #101,d5
 bge.s L000b4
 bsr.w L02d98
L00052 equ *-2
 or.b (a0),d0
 move.l d6,D00014(a6)
L00058 equ *-2
L00059 equ *-1
L0005a move.w d3,D00018(a6)
L0005b equ *-3
 btst.b #5,20(a3)
L00060 equ *-4
 beq.s L00074
 move.l a4,D0001a(a6)
 bne.s L00074
 move.l (L00000).l,D0001a(a6)
L00074 tst.l d5
 beq.s L00096
 btst.l #0,d5
L0007a equ *-2
 bne.s L00092
L0007d equ *-1
 lea (a5,d5.l),a0
L00080 equ *-2
 tst.w -2(a0)
 bne.s L00092
 subq.l #4,a0
 lea -4(a0),a4
L0008e moveq #1,d0
 bra.s L000b8
L00091 equ *-1
L00092 clr.b -1(a5,d5.l)
L00094 equ *-2
L00096 movea.l a5,a0
 adda.l 12(a3),a3
 clr.l -(sp)
 move.l a3,-(sp)
 moveq #1,d2
 move.l #117388,d0
 jsr (pc,d0.l)
 bra.s L00124
L000ae lea 4(a0),a1
 move.l a1,_00b6a(a6)
L000b4 equ *-2
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
L000d2 tst.w -2(a0)
 beq.s L000e2
 clr.b -1(a0)
 movea.l a0,a2
 addq.l #4,a0
 bra.s L000e8
L000e2 move.l a5,(a0)
L000e4 movea.l a0,a2
L000e6 addq.l #1,d2
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
L000ff equ *-1
L00100 movea.l (a4),a3
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
L00124 movea.l #114824,a0
 jsr (pc,a0.l)
 bcs.w L0024c
 bsr.s L00154
 movem.l (sp)+,d0-d1
 suba.l a5,a5
 move.l _00b6a(a6),-(sp)
 movea.l #35826,a0
 jsr (pc,a0.l)
 moveq #0,d0
 movea.l #120116,a0
 jsr (pc,a0.l)
L00154 movea.l #-25650,a0
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
L00180 equ *-2
 rts 
L00184 lea L001f6(pc),a0
 bsr.s L0019a
 move.l #257,-(sp)
 movea.l #120068,a0
 jsr (pc,a0.l)
L0019a move.w d1,-(sp)
 moveq #100,d1
 moveq #2,d0
 os9 I$WritLn
 move.w (sp)+,d1
 rts 
 move.l D00000(a6),d0
 sub.l D00008(a6),d0
L001ae equ *-2
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
L001d6 os9 F$TLink
 bcc.s L001e8
L001dc movea.l #120002,a1
L001e0 equ *-2
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
L00208 dc.w $7720
L0020a move.l 10794(a2),d5
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
 movea.l #-30774,a1
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
 movea.l #-30774,a0
 adda.l a6,a0
 bsr.w L0019a
 os9 F$Exit
L00286 equ *-2
 os9 F$Exit
L0028c move.b (a0)+,(a1)+
L0028e bne.s L0028c
L00290 rts 
L00292 link.w a5,#0
 movem.l a0/a2/d0-d1/d4,-(sp)
 movea.l D00028(a6),a0
 move.l #272,d0
 add.l 6908(a0),d0
 movea.l d0,a2
 moveq #36,d4
L002ac move.l d4,-(sp)
 moveq #0,d1
 move.l a2,d0
 jsr _016ac(a6)
 addq.l #4,sp
 movem.l -16(a5),a0/a2/d1/d4
L002bc equ *-2
 unlk a5
 rts 
L002c2 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l a2,d0
L002d0 addq.l #5,d0
 movea.l d0,a3
 tst.b (a2)
 bne.s L002da
 addq.l #1,a2
L002da tst.b (a2)
 bne.s L002e2
 moveq #0,d0
 bra.s L0030a
L002e2 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 move.w d4,312(a0)
 cmpi.b #115,(a3)
 beq.s L002f6
 moveq #4,d4
L002f6 clr.b (a3)
 pea (a2)
 lea L022c0(pc),a0
 move.l a0,d1
L00300 move.l d4,d0
 jsr _016a6(a6)
 addq.l #4,sp
 moveq #1,d0
L0030a movem.l -16(a5),a0/a2-a3/d4
 unlk a5
 rts 
L00314 link.w a5,#0
 movem.l a0/d0-d1/d4-d6,-(sp)
 move.l #-67108864,d0
 and.l (sp),d0
 moveq #26,d1
 asr.l d1,d0
 move.l d0,d4
 move.l #67043328,d0
 and.l (sp),d0
 moveq #16,d1
 asr.l d1,d0
 move.l d0,d5
 move.l #65535,d0
 and.l (sp),d0
 move.l d0,d6
 bra.s L003a8
 move.l d5,d0
 lsl.l #1,d0
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 move.w (a0,d0.l),d0
 ext.l d0
 cmp.l d6,d0
 ble.s L003a4
L0035a moveq #1,d0
 bra.s L003ca
 move.l d5,d0
 lsl.l #1,d0
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 move.w (a0,d0.l),d0
 ext.l d0
 cmp.l d6,d0
 bge.s L003a4
 bra.s L0035a
 move.l d5,d0
 lsl.l #1,d0
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 move.w (a0,d0.l),d0
 ext.l d0
 cmp.l d6,d0
 bne.s L003a4
 bra.s L0035a
L0038e move.l d5,d0
 lsl.l #1,d0
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 move.w (a0,d0.l),d0
 ext.l d0
 cmp.l d6,d0
 bne.s L0035a
L003a4 moveq #0,d0
 bra.s L003ca
L003a8 move.l d4,d0
 cmpi.l #6,d0
 bhi.s L003ca
 add.w d0,d0
 move.w L003ba(pc,d0.w),d0
 jmp L003ba(pc,d0.w)
L003ba equ *-2
 dc.w $ff9e
 dc.w $ff88
 dc.w $ffa2
 dc.w $ffba
 dc.w $ffd2
 dc.w $e
 dc.w $e
L003ca movem.l -16(a5),a0/d4-d6
 unlk a5
 rts 
L003d4 link.w a5,#0
 movem.l a0-a1/d0-d2/d4-d6,-(sp)
 move.l #-67108864,d0
 and.l (sp),d0
 moveq #26,d1
 asr.l d1,d0
 move.l d0,d4
 move.l #67043328,d0
 and.l (sp),d0
 moveq #16,d1
 asr.l d1,d0
 move.l d0,d5
 move.l #65535,d0
 and.l (sp),d0
 move.l d0,d6
 bra.w L0073a
 move.l d5,d0
 lsl.l #1,d0
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 move.w d6,(a0,d0.l)
 bra.w L00788
 move.w d6,d0
 move.l d5,d1
 lsl.l #1,d1
L00420 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 add.w d0,(a0,d1.l)
 bra.w L00788
 move.w d6,d0
 move.l d5,d1
 lsl.l #1,d1
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 sub.w d0,(a0,d1.l)
 bra.w L00788
 move.l 4(sp),d0
 bsr.w L027b4
 movea.l 4(sp),a0
 movea.l 12(a0),a0
 bra.w L005c8
 move.l d6,d1
 movea.l D00028(a6),a0
 move.l 6908(a0),d0
 move.l d5,d2
 lsl.l #1,d2
 add.l d2,d0
 bsr.w L002c2
 tst.l d0
 beq.w L00788
 move.l d6,d1
 movea.l D00028(a6),a0
 movea.l 5096(a0),a0
 movea.l 16(a0),a0
 movea.l 12(a0),a0
 move.l 4(a0),d0
 bsr.w L00792
 moveq #4,d0
 bsr.w L04876
 bra.w L00788
 move.l d6,_00b6e(a6)
 tst.l d5
 beq.w L00788
 clr.l -(sp)
 moveq #2,d1
 moveq #0,d0
 bsr.w L077fe
 bra.w L005de
 moveq #1,d0
 cmp.l d5,d0
 bne.s L004ce
 move.l d6,d0
 moveq #54,d1
 jsr _016a0(a6)
 movea.l D00028(a6),a0
 add.l 6788(a0),d0
 bsr.w L02cd0
 bra.w L00788
L004ce move.l d6,d0
 moveq #54,d1
 jsr _016a0(a6)
 movea.l D00028(a6),a0
 add.l 6788(a0),d0
 bra.w L00710
 tst.l d5
 beq.s L004fe
 moveq #246,d0
 add.l d5,d0
 moveq #54,d1
 jsr _016a0(a6)
 movea.l D00028(a6),a0
 movea.l 6788(a0),a0
 pea (a0,d0.l)
 bra.s L00502
L004fe move.l 4(sp),-(sp)
L00502 lea L07df4(pc),a0
 move.l a0,d1
 move.l d6,d0
 bra.w L005da
 move.l d6,d1
 move.l 4(sp),d0
 jsr _01670(a6)
 bra.w L00788
 move.l 4(sp),d0
 jsr _0167c(a6)
 bra.w L00788
 movea.l 4(sp),a0
 movea.l (a0),a0
 movea.w 18(a0),a0
 move.l a0,d1
 move.l 4(sp),d0
 jsr _0168e(a6)
 bra.w L00788
 move.l d6,d1
 move.l d5,d0
 jsr _01694(a6)
 bra.w L00788
 move.l d6,d0
 moveq #54,d1
 jsr _016a0(a6)
 movea.l D00028(a6),a0
 add.l 6788(a0),d0
 jsr _01682(a6)
 bra.w L00788
 moveq #3,d1
 moveq #0,d0
 bsr.w L077fe
 bra.w L00788
 tst.l d5
 beq.s L00598
 move.l d6,d0
 moveq #54,d1
 jsr _016a0(a6)
 movea.l D00028(a6),a0
 movea.l 6788(a0),a0
 move.l 12(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _016b2(a6)
 bra.w L00788
L00598 move.l d6,d0
 moveq #54,d1
 jsr _016a0(a6)
 movea.l D00028(a6),a0
 movea.l 6788(a0),a0
 movea.l 12(a0,d0.l),a0
 lea L06002(pc),a1
 move.l a1,30(a0)
 move.l d6,d0
 moveq #54,d1
 jsr _016a0(a6)
 movea.l D00028(a6),a0
 movea.l 6788(a0),a0
 movea.l 12(a0,d0.l),a0
L005c8 move.w #2,(a0)
 bra.w L00788
 move.l d6,-(sp)
 lea L02570(pc),a0
 move.l a0,d1
 moveq #0,d0
L005da jsr _016a6(a6)
L005de addq.l #4,sp
 bra.w L00788
 movea.l D00028(a6),a0
 move.w #4,5576(a0)
 bra.w L00788
 bsr.w L05966
 bra.w L00788
 tst.l d5
 bne.s L0063a
 movea.l D00028(a6),a0
 move.b #1,5579(a0)
 movea.l D00028(a6),a0
 clr.w 5570(a0)
 tst.l d6
 beq.s L00628
 move.l d6,d0
 moveq #20,d1
 jsr _016a0(a6)
 movea.l D00028(a6),a0
 move.w d0,5580(a0)
 bra.w L00788
L00628 movea.l D00028(a6),a0
 movea.l D00028(a6),a1
 move.w 5106(a0),5580(a1)
 bra.w L00788
L0063a movea.l D00028(a6),a0
 addi.w #$0014,5106(a0)
 movea.l D00028(a6),a0
 movea.l D00028(a6),a1
 movea.l 5018(a1),a1
 move.w 5106(a0),34(a1)
 bsr.w L02fec
 bsr.w L0307a
 bra.w L00788
 tst.l d6
 bne.s L00682
 movea.l D00028(a6),a0
 movea.l 5018(a0),a0
 movea.l 12(a0),a0
 clr.l 14(a0)
 movea.l D00028(a6),a0
 clr.w 5570(a0)
 bra.w L00788
L00682 movea.l _0166c(a6),a0
 movea.l D00028(a6),a1
 movea.l 5018(a1),a1
 movea.l 12(a1),a1
 move.l a0,14(a1)
 bra.w L00788
 movea.l D00028(a6),a0
 movea.l 5018(a0),a0
 move.w d6,44(a0)
 bra.s L006b4
 movea.l D00028(a6),a0
 movea.l 5018(a0),a0
 move.w d6,46(a0)
L006b4 movea.l D00028(a6),a0
 movea.l 5018(a0),a0
 move.l 12(a0),d1
 movea.l D00028(a6),a0
 move.l 5018(a0),d0
 jsr _0169a(a6)
 bra.w L00788
 move.l d6,d1
 move.l 4(sp),d0
 jsr _01676(a6)
 bra.w L00788
 movea.l D00028(a6),a0
 move.w d6,5570(a0)
 bra.w L00788
 movea.l D00028(a6),a0
 move.w #1,5608(a0)
 bra.w L00788
 movea.l D00028(a6),a0
 move.w d5,4844(a0)
 movea.l D00028(a6),a0
 move.w d6,4846(a0)
 bra.w L00788
 move.l 4(sp),d0
L00710 jsr _01688(a6)
 bra.s L00788
 move.l d6,d0
 bsr.w L016dc
 tst.l d0
 bne.s L00788
 movea.l D00028(a6),a0
 move.w 5000(a0),d0
 ext.l d0
 lsl.l #2,d0
 movea.l D00028(a6),a0
 adda.l d0,a0
 move.w #-1,4872(a0)
 bra.s L00788
L0073a move.l d4,d0
 cmpi.l #28,d0
 bhi.s L00788
 add.w d0,d0
 move.w L0074c(pc,d0.w),d0
 jmp L0074c(pc,d0.w)
L0074c equ *-2
 dc.w $3a
 dc.w $fcb8
 dc.w $fccc
 dc.w $fce2
 dc.w $fea4
 dc.w $feac
 dc.w $ffbe
 dc.w $fcf8
 dc.w $fd0c
 dc.w $ff4c
 dc.w $ff5a
 dc.w $fd4a
 dc.w $fd62
 dc.w $fd94
 dc.w $fdc0
 dc.w $ff82
 dc.w $ff90
 dc.w $fdce
 dc.w $fdda
 dc.w $fdf2
 dc.w $fe96
 dc.w $fdfe
 dc.w $fe82
 dc.w $ff14
 dc.w $ff9c
 dc.w $ffaa
 dc.w $fe16
 dc.w $fe22
 dc.w $ffc8
L00788 movem.l -24(a5),a0-a1/d2/d4-d6
 unlk a5
 rts 
L00792 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4-d6,-(sp)
 moveq #0,d4
 bra.w L00842
L007a0 move.l d4,d0
 lsl.l #2,d0
 movea.l (sp),a0
 movea.l 16(a0),a0
 movea.l 12(a0),a0
 movea.l (a0,d0.l),a3
 moveq #1,d6
 moveq #0,d5
 movea.l 16(a3),a2
 bra.s L007d2
L007bc move.l 4(sp),d1
 move.l (a2),d0
 bsr.w L00314
 tst.l d0
 bne.s L007ce
 moveq #0,d6
 bra.s L007d8
L007ce addq.l #1,d5
 addq.l #4,a2
L007d2 cmp.l 8(a3),d5
 bcs.s L007bc
L007d8 tst.l d6
 beq.s L00810
 addq.l #1,d4
 move.l d4,d0
 lsl.l #2,d0
 movea.l (sp),a0
 movea.l 16(a0),a0
 movea.l 12(a0),a0
 movea.l (a0,d0.l),a3
 moveq #0,d5
 movea.l 16(a3),a2
 bra.s L00806
L007f8 move.l 4(sp),d1
 move.l (a2),d0
 bsr.w L003d4
L00800 equ *-2
 addq.l #1,d5
 addq.l #4,a2
L00806 cmp.l 8(a3),d5
 bcs.s L007f8
 addq.l #2,d4
 bra.s L00842
L00810 addq.l #2,d4
 move.l d4,d0
 lsl.l #2,d0
 movea.l (sp),a0
 movea.l 16(a0),a0
 movea.l 12(a0),a0
 movea.l (a0,d0.l),a3
 moveq #0,d5
 movea.l 16(a3),a2
 bra.s L0083a
L0082c move.l 4(sp),d1
 move.l (a2),d0
 bsr.w L003d4
 addq.l #1,d5
 addq.l #4,a2
L0083a cmp.l 8(a3),d5
 bcs.s L0082c
 addq.l #1,d4
L00842 movea.l (sp),a0
 cmp.l 8(a0),d4
 bcs.w L007a0
 movem.l -24(a5),a0/a2-a3/d4-d6
 unlk a5
 rts 
L00856 link.w a5,#0
 movem.l a0/a2/d0-d1/d4,-(sp)
 move.l d0,d4
 movea.l d1,a2
 move.l a2,d1
 move.l d4,d0
 lsl.l #2,d0
 movea.l (a2),a0
 movea.l 10(a0),a0
 movea.l 16(a0),a0
 movea.l 12(a0),a0
 move.l (a0,d0.l),d0
 bsr.w L00792
 move.l _00b6e(a6),d0
 movem.l -12(a5),a0/a2/d4
 unlk a5
 rts 
L0088c link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D00028(a6),a0
 move.l 5018(a0),d1
 move.l (sp),d0
 lsl.l #2,d0
 movea.l D00028(a6),a0
 movea.l 5096(a0),a0
 movea.l 16(a0),a0
 movea.l 12(a0),a0
 move.l (a0,d0.l),d0
 bsr.w L00792
 move.l _00b6e(a6),d0
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
L008c6 link.w a5,#0
 movem.l a0/d0-d1/d4-d5,-(sp)
 move.l d0,d4
 move.l d4,d1
 move.l d4,d0
 lsl.l #2,d0
 lea _00b72(a6),a0
 move.l (a0,d0.l),d0
 lsl.l #1,d0
 movea.l D00028(a6),a0
 add.l 6908(a0),d0
 bsr.w L002c2
 move.l d0,d5
 tst.l d5
 beq.s L0090c
 move.l d4,d1
 movea.l D00028(a6),a0
 movea.l 5096(a0),a0
 movea.l 16(a0),a0
L00900 movea.l 12(a0),a0
 move.l 4(a0),d0
 bsr.w L00792
L0090c move.l d5,d0
 movem.l -16(a5),a0/d1/d4-d5
 unlk a5
 rts 
L00918 link.w a5,#0
 movem.l a0/a2/d0-d1/d4,-(sp)
 move.l d0,d4
 movea.l d1,a2
 movea.l D00028(a6),a0
 tst.w 9824(a0)
 bne.s L00966
 pea (L00002).w
L00930 equ *-2
 pea (L00002).w
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 moveq #63,d1
 move.l (a2),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 pea (L00002).w
 pea (L00002).w
 clr.l -(sp)
 move.l 40(a2),-(sp)
 clr.l -(sp)
 moveq #63,d1
 move.l 4(a2),d0
 jsr _016ca(a6)
L00960 equ *-2
 lea 20(sp),sp
L00966 movem.l -12(a5),a0/a2/d4
 unlk a5
 rts 
L00970 link.w a5,#0
 movem.l a0/a2/d0-d1/d4,-(sp)
 move.l d0,d4
 movea.l d1,a2
L0097c pea (L00001).w
 moveq #1,d1
 movea.l D00028(a6),a0
 move.l 182(a0),d0
 jsr _016f4(a6)
 addq.l #4,sp
 moveq #1,d1
 cmp.l d0,d1
 bne.s L0097c
 movea.l (a2),a0
 move.l 32(a2),4(a0)
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 move.l (a2),d1
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 jsr _016dc(a6)
 addq.l #8,sp
 clr.l -(sp)
 clr.l -(sp)
 pea (L00001).w
 move.l (a2),d1
 move.l 4(a2),d0
 jsr _016c4(a6)
 lea 12(sp),sp
 movem.l -12(a5),a0/a2/d4
 unlk a5
 rts 
L009e0 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
L009e8 pea (L00001).w
 moveq #1,d1
 movea.l D00028(a6),a0
 move.l 182(a0),d0
 jsr _016f4(a6)
 addq.l #4,sp
 moveq #1,d1
 cmp.l d0,d1
 bne.s L009e8
 movea.l 4(sp),a0
 movea.l 4(sp),a1
 movea.l 4(a1),a1
 move.l 28(a0),4(a1)
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 movea.l 12(sp),a0
 move.l 4(a0),d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016dc(a6)
 addq.l #8,sp
 move.l 4(sp),-(sp)
 pea L00970(pc)
 pea (L00001).w
 movea.l 16(sp),a0
 move.l 4(a0),d1
 movea.l 16(sp),a0
 move.l (a0),d0
 jsr _016c4(a6)
 lea 12(sp),sp
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L00a68 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
L00a70 pea (L00001).w
 moveq #1,d1
 movea.l D00028(a6),a0
 move.l 182(a0),d0
 jsr _016f4(a6)
 addq.l #4,sp
 moveq #1,d1
 cmp.l d0,d1
 bne.s L00a70
 movea.l 4(sp),a0
 movea.l 4(sp),a1
 movea.l (a1),a1
 move.l 24(a0),4(a1)
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 movea.l 12(sp),a0
 move.l (a0),d1
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 jsr _016dc(a6)
 addq.l #8,sp
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 move.l D00028(a6),d0
 jsr _016e8(a6)
 addq.l #4,sp
 pea (L00005).w
 pea (L00005).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 move.l D00028(a6),d0
 jsr _016d6(a6)
 addq.l #8,sp
 move.l 4(sp),-(sp)
 lea L009e0(pc),a0
 move.l a0,d1
 move.l 4(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L00b24 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 pea (L00003).w
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 pea (L0003f).w
 moveq #0,d1
 movea.l 24(sp),a0
 move.l 4(a0),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 lea L00a68(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6404(a1)
 movea.l D00028(a6),a0
 move.l 4(sp),6408(a0)
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L00b6c link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 movea.l 4(sp),a0
 movea.l 36(a0),a0
 pea 4(a0)
 pea (L00080).w
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 bsr.w L02672
 lea 16(sp),sp
 movea.l 4(sp),a0
 move.l 12(a0),-(sp)
 move.l _016ba(a6),-(sp)
 move.l #94080,-(sp)
 movea.l 16(sp),a0
 move.l 12(a0),-(sp)
 move.l #5670,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5648,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 movea.l 4(sp),a0
 move.l 16(a0),-(sp)
 move.l _016ba(a6),-(sp)
 move.l #94080,-(sp)
 movea.l 16(sp),a0
 move.l 16(a0),-(sp)
 move.l #5692,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5670,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 movea.l 4(sp),a0
 move.l 8(a0),-(sp)
 move.l _016ba(a6),-(sp)
 move.l #94080,-(sp)
 movea.l 16(sp),a0
 move.l 8(a0),-(sp)
 move.l #5648,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5692,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #5648,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01700(a6)
 addq.l #8,sp
 lea L00918(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6396(a1)
 movea.l D00028(a6),a0
 move.l 4(sp),6400(a0)
 lea L00b24(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6404(a1)
 movea.l D00028(a6),a0
 move.l 4(sp),6408(a0)
 lea L08908(pc),a0
 movea.l 4(sp),a1
 move.l a0,40(a1)
 lea L010d2(pc),a0
 move.l a0,d1
 move.l #6222,d0
 add.l D00028(a6),d0
 jsr _0170c(a6)
 moveq #1,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01706(a6)
 moveq #0,d0
 jsr _01712(a6)
 moveq #1,d0
 jsr _01712(a6)
 pea (L00002).w
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 pea (L0003f).w
 moveq #0,d1
 moveq #82,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 movea.l D00028(a6),a0
 clr.w 9824(a0)
 movea.l D00028(a6),a0
 move.w #1,9826(a0)
 lea L088b8(pc),a0
 movea.l D00028(a6),a1
 move.l a0,9828(a1)
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.l 6780(a0),d1
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _01718(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _0171e(a6)
 lea _00ff0(a6),a0
 movea.l D00028(a6),a1
 movea.l 6780(a1),a1
 move.l a0,26(a1)
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L00d68 link.w a5,#0
 movem.l a0-a4/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 movea.l 52(sp),a4
 move.l 56(sp),d4
 move.l 60(sp),d5
 move.l 64(sp),d6
 move.l 68(sp),d7
 pea (L0002c).w
 moveq #0,d1
 move.l 80(sp),d0
 jsr _016ac(a6)
 addq.l #4,sp
 moveq #82,d0
 add.l D00028(a6),d0
 movea.l 76(sp),a0
 move.l d0,(a0)
 moveq #122,d0
 add.l D00028(a6),d0
 movea.l 76(sp),a0
 move.l d0,4(a0)
 movea.l 76(sp),a0
 move.l a2,20(a0)
 movea.l 76(sp),a0
 move.l a3,24(a0)
 movea.l 76(sp),a0
 move.l a4,28(a0)
 movea.l 76(sp),a0
 move.l d4,32(a0)
 movea.l 76(sp),a0
 move.l d5,8(a0)
 movea.l 76(sp),a0
 move.l d6,12(a0)
 movea.l 76(sp),a0
 move.l d7,16(a0)
 movea.l 76(sp),a0
 move.l 72(sp),36(a0)
 lea L088b8(pc),a0
 movea.l 76(sp),a1
 move.l a0,40(a1)
 movea.l 76(sp),a0
 movea.l (a0),a0
 clr.l 8(a0)
 movea.l 76(sp),a0
 movea.l (a0),a0
 move.l d5,4(a0)
 movea.l 76(sp),a0
 movea.l 4(a0),a0
 move.l a2,4(a0)
 movea.l 76(sp),a0
 movea.l (a0),a0
 clr.w 18(a0)
 movea.l 76(sp),a0
 movea.l 4(a0),a0
 clr.w 18(a0)
 jsr _016be(a6)
 movea.l D00028(a6),a0
 move.w #2,80(a0)
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016ee(a6)
 moveq #1,d1
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L00e6e
 moveq #1,d0
 bra.s L00e70
L00e6e moveq #0,d0
L00e70 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016ee(a6)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 moveq #0,d0
 jsr _016e2(a6)
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #0,d1
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 jsr _016d0(a6)
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016d0(a6)
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 movea.l 84(sp),a0
 move.l (a0),d1
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 jsr _016dc(a6)
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 movea.l 84(sp),a0
 move.l 4(a0),d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016dc(a6)
 addq.l #8,sp
 pea (L00005).w
 pea (L00003).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 move.l D00028(a6),d0
 jsr _016d6(a6)
 addq.l #8,sp
 pea (L00001).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 move.l D00028(a6),d0
 jsr _016e8(a6)
 addq.l #4,sp
 clr.l -(sp)
 clr.l -(sp)
 pea (L00800).w
 move.l 84(sp),-(sp)
 moveq #0,d1
 move.l #5956,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 move.l d5,-(sp)
 move.l _016ba(a6),-(sp)
 move.l #94080,-(sp)
 move.l d5,-(sp)
 move.l #5670,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5648,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 pea (a2)
 move.l #5692,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5670,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 pea (a3)
 move.l #5714,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5692,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 pea (a4)
 move.l #5736,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5714,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 move.l d4,-(sp)
 moveq #0,d1
 move.l #5736,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 movea.l D00028(a6),a0
 pea 5956(a0)
 clr.l -(sp)
 move.l #5648,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01700(a6)
 addq.l #8,sp
 lea L00b6c(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6396(a1)
 movea.l D00028(a6),a0
 move.l 76(sp),6400(a0)
 lea L010d6(pc),a0
 move.l a0,d1
 move.l #6222,d0
 add.l D00028(a6),d0
 jsr _0170c(a6)
 moveq #1,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01706(a6)
 moveq #0,d0
 jsr _01712(a6)
 moveq #1,d0
 jsr _01712(a6)
 movem.l -36(a5),a0-a4/d4-d7
 unlk a5
 rts 
L010d2 moveq #98,d3
 move.w d0,d1
L010d6 moveq #98,d3
 move.w d0,-(a0)
L010da link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 lea L0113e(pc),a0
 move.l a0,d0
 jsr _0175a(a6)
 jsr _01730(a6)
 move.l D00028(a6),d0
 jsr _01754(a6)
 jsr _01724(a6)
 bsr.w L08d74
 jsr _01748(a6)
 jsr _01736(a6)
 bsr.w L0842a
 jsr _01742(a6)
 jsr _0172a(a6)
 tst.l d0
 bne.s L01124
 lea L087f2(pc),a0
 move.l a0,d0
 jsr _0173c(a6)
 bra.s L01134
L01124 clr.l -(sp)
 movea.l _01750(a6),a0
 move.l a0,d1
 moveq #0,d0
 jsr _016a6(a6)
 addq.l #4,sp
L01134 movem.l -4(a5),a0
 unlk a5
 rts 
L0113e dc.w $6865
 bge.s L011ae
 dc.w $6f0d
 dc.w $0
L01146 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D00028(a6),a0
 move.l 4868(a0),d0
 jsr _017e4(a6)
 lea L025e7(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 4868(a0),d0
 jsr _017de(a6)
 movea.l D00028(a6),a0
 move.l d0,5090(a0)
 lea L025ed(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 4868(a0),d0
 jsr _017de(a6)
 movea.l D00028(a6),a0
 move.l d0,6998(a0)
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
L01198 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D00028(a6),a0
 movea.l 4830(a0),a0
 pea 4(a0)
 pea (L00100).w
L011ae equ *-2
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 bsr.w L02672
 lea 16(sp),sp
 movea.l D00028(a6),a0
 movea.l 5090(a0),a0
 pea 4(a0)
 pea (L00030).w
 pea (L00018).w
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 bsr.w L02672
 lea 16(sp),sp
 movea.l D00028(a6),a0
 move.l 4834(a0),-(sp)
 pea (L00008).w
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
L01260 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 bsr.w L02672
 lea 16(sp),sp
 movea.l D00028(a6),a0
 movea.l 6998(a0),a0
 pea 4(a0)
 pea (L00010).w
 pea (L00008).w
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 bsr.w L02672
 lea 16(sp),sp
 movea.l D00028(a6),a0
 movea.l 5556(a0),a0
 pea 4(a0)
 pea (L00010).w
 pea (L00048).w
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 bsr.w L02672
 lea 16(sp),sp
 movea.l D00028(a6),a0
 move.l 4834(a0),-(sp)
 pea (L00001).w
 pea (L00080).w
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 bsr.w L02672
 lea 16(sp),sp
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
L01366 link.w a5,#0
 movem.l a0-a3/d0-d1,-(sp)
 movea.l D00028(a6),a0
 move.l 4806(a0),d0
 jsr _017e4(a6)
 lea L025f5(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 4806(a0),d0
 jsr _017de(a6)
 movea.l D00028(a6),a0
 move.l d0,4822(a0)
 lea L025fa(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 4806(a0),d0
 jsr _017de(a6)
 movea.l D00028(a6),a0
 move.l d0,4826(a0)
 lea L025ff(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 4806(a0),d0
 jsr _017de(a6)
 movea.l D00028(a6),a0
 move.l d0,4838(a0)
 lea L02605(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 4806(a0),d0
 jsr _017de(a6)
 movea.l D00028(a6),a0
 move.l d0,4852(a0)
 lea L0260b(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 4806(a0),d0
 jsr _017d8(a6)
 movea.l d0,a3
 move.l a3,d0
 beq.s L01406
 movea.l 12(a3),a2
 movea.l D00028(a6),a0
 move.l (a2),4848(a0)
L01406 bsr.w L01198
 movea.l D00028(a6),a0
 move.l 4818(a0),d0
 jsr _017e4(a6)
 jsr _01796(a6)
 movea.l D00028(a6),a0
 move.w #1,4842(a0)
 movea.l _0166c(a6),a0
 movea.l D00028(a6),a1
 movea.l 5018(a1),a1
 movea.l 12(a1),a1
 move.l a0,14(a1)
 movem.l -20(a5),a0-a3/d1
 unlk a5
 rts 
L01442 link.w a5,#0
 movem.l a0-a2/d0-d1/d4-d5,-(sp)
 move.l d0,d4
 move.l d1,d5
 movea.l D00028(a6),a0
 movea.l 5018(a0),a2
 pea L040aa(pc)
 pea L083a2(pc)
 clr.l -(sp)
 moveq #6,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _0180e(a6)
 lea 12(sp),sp
 movea.l D00028(a6),a0
 tst.b 5008(a0)
 beq.s L01486
 movea.l D00028(a6),a0
 tst.w 5646(a0)
 beq.s L01496
L01486 moveq #0,d1
 movea.l D00028(a6),a0
 move.l 4848(a0),d0
 bsr.w L07b7c
 bra.s L014ac
L01496 movea.l D00028(a6),a0
 move.l 6986(a0),d1
 movea.l D00028(a6),a0
 movea.w 5010(a0),a0
 move.l a0,d0
 bsr.w L07df4
L014ac movea.l D00028(a6),a0
 movea.l 6780(a0),a0
 clr.l 26(a0)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 movea.l D00028(a6),a1
 movea.l 178(a1),a1
 move.l 20(a0,d0.l),12(a1)
 movea.l D00028(a6),a0
 clr.b 5009(a0)
 clr.l _00b6e(a6)
 movea.l D00028(a6),a0
 clr.l 5572(a0)
 movea.l D00028(a6),a0
 clr.w 5614(a0)
 movea.l D00028(a6),a0
 clr.w 5636(a0)
 movea.l D00028(a6),a0
 clr.w 5638(a0)
 clr.l -(sp)
 lea L04b84(pc),a0
 move.l a0,d1
 move.l 12(a2),d0
 jsr _017fc(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 tst.w 5630(a0)
 beq.s L01528
 clr.w 34(a2)
 bsr.w L0307a
 bra.s L0154e
L01528 movea.l D00028(a6),a0
 tst.w 5646(a0)
 beq.s L0154e
 clr.l -(sp)
 lea L04758(pc),a0
 move.l a0,d1
 move.l 12(a2),d0
 jsr _017fc(a6)
 addq.l #4,sp
 clr.w 42(a2)
 move.b #1,48(a2)
L0154e pea (L0001e).w
 moveq #30,d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _017d2(a6)
 addq.l #4,sp
 movem.l -20(a5),a0-a2/d4-d5
 unlk a5
 rts 
L0156c link.w a5,#0
 movem.l a0-a1/d0-d1/d4-d5,-(sp)
 move.l d0,d4
 move.l d1,d5
 pea (L0001e).w
 moveq #30,d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _017d2(a6)
 addq.l #4,sp
 moveq #0,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016ee(a6)
 moveq #0,d1
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L015b6
 moveq #1,d0
 bra.s L015b8
L015b6 moveq #0,d0
L015b8 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016ee(a6)
 movea.l D00028(a6),a0
 move.w #478,80(a0)
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016ee(a6)
 moveq #1,d1
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L015fa
 moveq #1,d0
 bra.s L015fc
L015fa moveq #0,d0
L015fc lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016ee(a6)
 moveq #4,d0
 cmp.l d5,d0
 bne.s L0166a
 movea.l D00028(a6),a0
 movea.l 5018(a0),a0
 movea.l 12(a0),a0
 clr.l 26(a0)
 clr.l -(sp)
 pea L083a2(pc)
 moveq #0,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _01808(a6)
 addq.l #8,sp
 lea L04b84(pc),a0
 movea.l D00028(a6),a1
 movea.l 5018(a1),a1
 movea.l 12(a1),a1
 move.l a0,26(a1)
 lea L01442(pc),a0
 movea.l D00028(a6),a1
 move.l a0,4768(a1)
 movea.l D00028(a6),a0
 move.l d5,4772(a0)
 clr.l -(sp)
 movea.l _01774(a6),a0
 move.l a0,d1
 moveq #0,d0
 bra.s L01674
L0166a move.l d5,-(sp)
 lea L01442(pc),a0
 move.l a0,d1
 move.l d4,d0
L01674 jsr _016a6(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 clr.l 5582(a0)
 movea.l D00028(a6),a0
 clr.w 5634(a0)
 movem.l -16(a5),a0-a1/d4-d5
 unlk a5
 rts 
L01694 link.w a5,#0
 movem.l a0/d0-d1/d4,-(sp)
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 tst.w 316(a0)
 bne.s L016c4
 movea.l D00028(a6),a0
 move.w 4844(a0),d0
 movea.l D00028(a6),a0
 move.w 4846(a0),d1
 ext.l d1
 lsl.l #5,d1
 add.w d1,d0
 move.w d0,d4
 bra.s L016d0
L016c4 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 move.w 320(a0),d4
L016d0 move.w d4,d0
 movem.l -12(a5),a0/d1/d4
 unlk a5
 rts 
L016dc link.w a5,#0
 movem.l a0/a2/d0/d4-d5,-(sp)
 move.l d0,d4
 move.l #4872,d0
 add.l D00028(a6),d0
 movea.l d0,a2
 moveq #0,d5
 bra.s L0170e
L016f6 move.w (a2),d0
 ext.l d0
 cmp.l d4,d0
 bne.s L0170a
 movea.l D00028(a6),a0
 move.w d5,5000(a0)
 moveq #0,d0
 bra.s L01720
L0170a addq.l #1,d5
 addq.l #4,a2
L0170e moveq #32,d0
 cmp.l d5,d0
 bgt.s L016f6
 movea.l D00028(a6),a0
 move.w #-1,5000(a0)
 moveq #1,d0
L01720 movem.l -16(a5),a0/a2/d4-d5
 unlk a5
 rts 
L0172a link.w a5,#0
 movem.l a0-a2/d0-d1/d4,-(sp)
 move.l d0,d4
 movea.l D00028(a6),a0
 movea.l D00028(a6),a1
 move.w 5004(a0),5000(a1)
 move.l #4872,d0
 add.l D00028(a6),d0
 movea.l D00028(a6),a0
 move.w 5000(a0),d1
 ext.l d1
 lsl.l #2,d1
 add.l d1,d0
 movea.l d0,a2
 move.w d4,(a2)
 movea.l D00028(a6),a0
 move.w 5002(a0),2(a2)
 movea.l D00028(a6),a0
 addq.w #1,5004(a0)
 movea.l D00028(a6),a0
 cmpi.w #31,5004(a0)
 ble.s L01784
 movea.l D00028(a6),a0
 clr.w 5004(a0)
L01784 movem.l -20(a5),a0-a2/d1/d4
 unlk a5
 rts 
L0178e link.w a5,#0
 movem.l a0/a2/d0/d4,-(sp)
 move.l #4872,d0
 add.l D00028(a6),d0
 movea.l d0,a2
 moveq #0,d4
 bra.s L017b2
L017a6 move.w #-1,(a2)
 clr.w 2(a2)
 addq.l #1,d4
 addq.l #4,a2
L017b2 moveq #32,d0
 cmp.l d4,d0
 bgt.s L017a6
 movea.l D00028(a6),a0
 clr.w 5004(a0)
 movem.l -12(a5),a0/a2/d4
 unlk a5
 rts 
L017ca link.w a5,#0
 movem.l a0-a4/d0-d1/d4-d7,-(sp)
 move.l d0,d4
 move.l d1,d5
 subq.l #4,sp
 movea.l D00028(a6),a0
 movea.l 162(a0),a2
 move.l #23520,d0
 add.l a2,d0
 movea.l d0,a3
 move.l #28224,d0
 add.l a2,d0
 movea.l d0,a4
 moveq #1,d7
 movea.l D00028(a6),a0
 move.l 5018(a0),(sp)
 move.l #92160,-(sp)
L01800 equ *-4
 moveq #4,d1
 movea.l D00028(a6),a0
 move.l 4792(a0),d0
 jsr _017b4(a6)
 addq.l #4,sp
 moveq #1,d0
 cmp.l d5,d0
 bne.s L01834
 pea (L04800).w
 movea.l D00028(a6),a0
 move.l 162(a0),d1
 movea.l D00028(a6),a0
 move.l 4776(a0),d0
 jsr _017c6(a6)
 addq.l #4,sp
L01834 pea (L00800).w
 move.l a3,d1
 movea.l D00028(a6),a0
 move.l 6966(a0),d0
 jsr _017c6(a6)
 addq.l #4,sp
 pea (L06800).w
 move.l a4,d1
 movea.l D00028(a6),a0
 move.l 6958(a0),d0
 jsr _017c6(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 move.l 6966(a0),d0
 jsr _017e4(a6)
 lea L02611(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 6966(a0),d0
 jsr _017de(a6)
 movea.l D00028(a6),a0
 move.l d0,6942(a0)
 bsr.w L06d5e
 movea.l D00028(a6),a0
 clr.l 5582(a0)
 movea.l D00028(a6),a0
 clr.w 5016(a0)
 movea.l D00028(a6),a0
 move.w #1,5570(a0)
 movea.l (sp),a0
 movea.w 24(a0),a0
 move.l a0,d1
 move.l (sp),d0
 jsr _01670(a6)
 movea.l D00028(a6),a0
 movea.l 4822(a0),a0
 tst.w 2(a0)
 beq.s L018c0
 jsr _0179c(a6)
L018c0 move.l #92160,-(sp)
 movea.l D00028(a6),a0
 move.l 162(a0),d1
 movea.l D00028(a6),a0
 move.l 166(a0),d0
 jsr _017c6(a6)
 addq.l #4,sp
 move.l #92160,-(sp)
 movea.l D00028(a6),a0
 move.l 162(a0),d1
 movea.l D00028(a6),a0
 move.l 4792(a0),d0
 jsr _017c6(a6)
 addq.l #4,sp
L018f8 pea (L00001).w
 moveq #1,d1
 movea.l D00028(a6),a0
 move.l 182(a0),d0
 jsr _016f4(a6)
 addq.l #4,sp
 moveq #1,d1
 cmp.l d0,d1
 bne.s L018f8
 pea (L00008).w
 pea (L00001).w
 pea (L00001).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 move.l D00028(a6),d0
 jsr _017a8(a6)
 lea 12(sp),sp
 bsr.w L0307a
 movea.l D00028(a6),a0
 move.w #63,5576(a0)
 movea.l D00028(a6),a0
 clr.w 6984(a0)
 movea.l D00028(a6),a0
 move.b #1,5009(a0)
 movea.l D00028(a6),a0
 clr.b 5008(a0)
 movea.l D00028(a6),a0
 clr.w 5608(a0)
 movea.l D00028(a6),a0
 move.l _00cd0(a6),5594(a0)
 movea.l D00028(a6),a0
 move.l _00cd0(a6),5598(a0)
 movea.l D00028(a6),a0
 clr.w 5604(a0)
 movea.l D00028(a6),a0
 clr.w 5606(a0)
 movea.l D00028(a6),a0
 clr.b 5602(a0)
 movea.l D00028(a6),a0
 clr.b 5603(a0)
 movea.l D00028(a6),a0
 clr.w 5100(a0)
 movea.l D00028(a6),a0
 clr.w 5646(a0)
 moveq #0,d0
 bsr.w L0088c
 bsr.w L04714
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 tst.w 316(a0)
 bne.s L019f2
 movea.l D00028(a6),a0
 move.w 4844(a0),d0
 ext.l d0
 movea.l D00028(a6),a0
 move.w 4846(a0),d1
 ext.l d1
 lsl.l #5,d1
 add.l d1,d0
 movea.l D00028(a6),a0
 movea.l 8092(a0),a0
 move.b #1,(a0,d0.l)
 bra.s L01a1e
L019f2 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 move.w 316(a0),d0
 ext.l d0
 lsl.l #5,d0
 movea.l D00028(a6),a0
 adda.l d0,a0
 movea.l D00028(a6),a1
 movea.l 6908(a1),a1
 move.w 320(a1),d0
 ext.l d0
 adda.l d0,a0
 move.b #1,9568(a0)
L01a1e bsr.w L01694
 move.w d0,d6
 ext.l d6
 move.l d6,d0
 bsr.w L016dc
 move.w d0,d7
 tst.w d7
 bne.s L01a36
 jsr _017a2(a6)
L01a36 tst.w d7
 beq.s L01a42
 ext.l d6
 move.l d6,d0
 bsr.w L0172a
L01a42 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 tst.w 316(a0)
 beq.s L01a62
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 movea.l D00028(a6),a1
 move.w 316(a0),5616(a1)
L01a62 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 movea.l D00028(a6),a1
 move.w 5006(a1),d0
 cmp.w 316(a0),d0
 beq.w L01af4
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 tst.w 316(a0)
 beq.s L01ab4
 move.l d5,-(sp)
 pea L0156c(pc)
 movea.l D00028(a6),a0
 pea 6358(a0)
 lea L02619(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 6436(a0),d0
 jsr _01766(a6)
 lea 12(sp),sp
 move.l #6358,d0
 bra.s L01ade
L01ab4 move.l d5,-(sp)
 pea L0156c(pc)
 movea.l D00028(a6),a0
 pea 6324(a0)
 lea L0261e(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 6436(a0),d0
 jsr _01766(a6)
 lea 12(sp),sp
 move.l #6324,d0
L01ade add.l D00028(a6),d0
 movea.l D00028(a6),a0
 move.l d0,6392(a0)
 bsr.w L00292
 bsr.w L0178e
 bra.s L01b04
L01af4 move.l d5,-(sp)
 lea L0156c(pc),a0
 move.l a0,d1
 move.l d4,d0
 jsr _016a6(a6)
 addq.l #4,sp
L01b04 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 movea.l D00028(a6),a1
 move.w 316(a0),5006(a1)
 addq.l #4,sp
 movem.l -36(a5),a0-a4/d4-d7
 unlk a5
 rts 
L01b22 link.w a5,#0
 movem.l a0-a1/d0-d1/d4-d5,-(sp)
 move.l d0,d4
 move.l d1,d5
 bsr.w L01366
 bsr.w L07916
 movea.l D00028(a6),a0
 move.w #478,80(a0)
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016ee(a6)
 moveq #1,d1
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L01b6a
 moveq #1,d0
 bra.s L01b6c
L01b6a moveq #0,d0
L01b6c lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016ee(a6)
 movea.l D00028(a6),a0
 movea.w 14(a0),a0
 movea.l D00028(a6),a1
 move.l a0,4800(a1)
 bra.s L01bbe
 move.l d5,-(sp)
 lea L017ca(pc),a0
L01b90 equ *-2
 bra.s L01bb2
 move.l d5,-(sp)
 movea.l _0176e(a6),a0
 bra.s L01bb2
 move.l d5,-(sp)
 movea.l _01786(a6),a0
 bra.s L01bb2
 move.l d5,-(sp)
 movea.l _01780(a6),a0
 bra.s L01bb2
 move.l d5,-(sp)
 movea.l _0177a(a6),a0
L01bb2 move.l a0,d1
 move.l d4,d0
 jsr _016a6(a6)
 addq.l #4,sp
 bra.s L01bdc
L01bbe move.l d5,d0
 cmpi.l #4,d0
 bhi.s L01bdc
 add.w d0,d0
 move.w L01bd0(pc,d0.w),d0
 jmp L01bd0(pc,d0.w)
L01bd0 equ *-2
 dc.w $ffda
 dc.w $ffc2
 dc.w $ffd2
 dc.w $ffca
 dc.w $ffba
L01bdc lea L017ca(pc),a0
 movea.l D00028(a6),a1
 move.l a0,4768(a1)
 movea.l D00028(a6),a0
 move.l d5,4772(a0)
 moveq #0,d1
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _017ea(a6)
 movem.l -16(a5),a0-a1/d4-d5
 unlk a5
 rts 
L01c08 link.w a5,#0
 movem.l a2-a4/d0-d1/d4,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 movea.l 32(sp),a4
 move.l 36(sp),d4
 clr.b (a2)
 clr.b 3(a2)
 clr.w 4(a2)
 move.l a3,6(a2)
 move.l a4,10(a2)
 move.l d4,14(a2)
 clr.l 18(a2)
 clr.l 24(a2)
 movem.l -16(a5),a2-a4/d4
 unlk a5
 rts 
L01c44 link.w a5,#0
 movem.l a0-a4/d0-d1/d4-d6,-(sp)
 movea.l d0,a2
 move.l d1,d4
 lea -20(sp),sp
 movea.l D00028(a6),a0
 movea.l 4776(a0),a3
 movea.l D00028(a6),a0
 movea.l 162(a0),a4
 move.l #23520,d0
 add.l a4,d0
 move.l d0,d5
 move.l #28224,d0
 add.l a4,d0
 move.l d0,d6
 movea.l D00028(a6),a0
 move.l 6392(a0),8(sp)
 clr.l 4(sp)
 clr.l (sp)
 moveq #1,d0
 cmp.l d4,d0
 bne.s L01c90
 movea.l a4,a3
L01c90 andi.w #$feff,_011ba(a6)
 move.l a2,d1
 movea.l D00028(a6),a0
 move.l 6392(a0),d0
 jsr _017cc(a6)
 move.l d0,12(sp)
 tst.l 12(sp)
 movea.l 12(sp),a0
 movea.w 6(a0),a0
 move.l a0,4(sp)
 movea.l 12(sp),a0
 movea.w 10(a0),a0
 move.l a0,(sp)
 move.l 4(sp),d0
 addq.l #1,4(sp)
 movea.l 8(sp),a0
 movea.l 12(a0),a0
 moveq #0,d1
 move.b (a0,d0.l),d1
 move.l d1,-(sp)
 movea.l D00028(a6),a0
 move.l 170(a0),-(sp)
 move.l #6468,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6440,d0
 add.l D00028(a6),d0
 bsr.w L01c08
 addq.l #8,sp
 move.l 4(sp),d0
 addq.l #1,4(sp)
 movea.l 8(sp),a0
 movea.l 12(a0),a0
 moveq #0,d1
 move.b (a0,d0.l),d1
 move.l d1,-(sp)
 movea.l D00028(a6),a0
 move.l 166(a0),-(sp)
 moveq #0,d1
 move.l #6468,d0
 add.l D00028(a6),d0
 bsr.w L01c08
 addq.l #8,sp
 move.l (sp),d0
 addq.l #1,(sp)
 movea.l 8(sp),a0
 movea.l 20(a0),a0
 moveq #0,d1
 move.b (a0,d0.l),d1
 move.l d1,-(sp)
 movea.l D00028(a6),a0
 move.l 4026(a0),-(sp)
 move.l #6524,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6496,d0
 add.l D00028(a6),d0
 bsr.w L01c08
 addq.l #8,sp
 move.l (sp),d0
 addq.l #1,(sp)
 movea.l 8(sp),a0
 movea.l 20(a0),a0
 moveq #0,d1
 move.b (a0,d0.l),d1
 move.l d1,-(sp)
 pea (a3)
 move.l #6552,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6524,d0
 add.l D00028(a6),d0
 bsr.w L01c08
 addq.l #8,sp
 move.l (sp),d0
 addq.l #1,(sp)
 movea.l 8(sp),a0
 movea.l 20(a0),a0
 moveq #0,d1
 move.b (a0,d0.l),d1
 move.l d1,-(sp)
 movea.l D00028(a6),a0
 move.l 4806(a0),-(sp)
 move.l #6580,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6552,d0
 add.l D00028(a6),d0
 bsr.w L01c08
 addq.l #8,sp
 move.l (sp),d0
 addq.l #1,(sp)
 movea.l 8(sp),a0
 movea.l 20(a0),a0
 moveq #0,d1
 move.b (a0,d0.l),d1
 move.l d1,-(sp)
 movea.l D00028(a6),a0
 move.l 6974(a0),-(sp)
 move.l #6608,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6580,d0
 add.l D00028(a6),d0
 bsr.w L01c08
 addq.l #8,sp
 move.l (sp),d0
 addq.l #1,(sp)
 movea.l 8(sp),a0
 movea.l 20(a0),a0
 moveq #0,d1
 move.b (a0,d0.l),d1
 move.l d1,-(sp)
 movea.l D00028(a6),a0
 move.l 4814(a0),-(sp)
 move.l #6636,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6608,d0
 add.l D00028(a6),d0
 bsr.w L01c08
 addq.l #8,sp
 move.l (sp),d0
 addq.l #1,(sp)
 movea.l 8(sp),a0
 movea.l 20(a0),a0
 moveq #0,d1
 move.b (a0,d0.l),d1
 move.l d1,-(sp)
 movea.l D00028(a6),a0
 move.l 6798(a0),-(sp)
 move.l #6664,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6636,d0
 add.l D00028(a6),d0
 bsr.w L01c08
 addq.l #8,sp
 move.l (sp),d0
 addq.l #1,(sp)
 movea.l 8(sp),a0
 movea.l 20(a0),a0
 moveq #0,d1
 move.b (a0,d0.l),d1
 move.l d1,-(sp)
 movea.l D00028(a6),a0
 move.l 4818(a0),-(sp)
 move.l #6692,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6664,d0
 add.l D00028(a6),d0
 bsr.w L01c08
 addq.l #8,sp
 move.l (sp),d0
 addq.l #1,(sp)
 movea.l 8(sp),a0
 movea.l 20(a0),a0
 moveq #0,d1
 move.b (a0,d0.l),d1
 move.l d1,-(sp)
 movea.l D00028(a6),a0
 move.l 4830(a0),-(sp)
 move.l #6720,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6692,d0
 add.l D00028(a6),d0
 bsr.w L01c08
 addq.l #8,sp
 move.l (sp),d0
 addq.l #1,(sp)
 movea.l 8(sp),a0
 movea.l 20(a0),a0
 moveq #0,d1
 move.b (a0,d0.l),d1
 move.l d1,-(sp)
 move.l d5,-(sp)
 move.l #6748,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6720,d0
 add.l D00028(a6),d0
 bsr.w L01c08
 addq.l #8,sp
 move.l (sp),d0
 addq.l #1,(sp)
 movea.l 8(sp),a0
 movea.l 20(a0),a0
 moveq #0,d1
 move.b (a0,d0.l),d1
 move.l d1,-(sp)
 move.l d6,-(sp)
 moveq #0,d1
 move.l #6748,d0
 add.l D00028(a6),d0
 bsr.w L01c08
 addq.l #8,sp
 jsr _01760(a6)
 clr.l -(sp)
 moveq #0,d1
 moveq #255,d0
 jsr _017c0(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 pea 5956(a0)
 clr.l -(sp)
 move.l #5648,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01700(a6)
 addq.l #8,sp
 lea L01b22(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6396(a1)
 movea.l D00028(a6),a0
 move.l d4,6400(a0)
 move.l a2,d1
 movea.l D00028(a6),a0
 move.l 6392(a0),d0
 jsr _0170c(a6)
 move.l d0,16(sp)
 move.l #6440,d0
 add.l D00028(a6),d0
 move.l d0,D00096(a6)
 move.l #6496,d0
 add.l D00028(a6),d0
 move.l d0,D00156(a6)
 moveq #255,d0
 cmp.l 16(sp),d0
 bne.s L01fc8
 moveq #255,d0
 bra.s L0201c
L01fc8 lea L02623(pc),a0
 move.l a0,d0
 jsr _0175a(a6)
 move.l a2,d1
 lea L0263f(pc),a0
 move.l a0,d0
 jsr _0175a(a6)
 lea L02651(pc),a0
 move.l a0,d0
 jsr _0175a(a6)
 move.l #-2004318072,d1
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _017ea(a6)
 moveq #1,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01706(a6)
 moveq #255,d1
 cmp.l d0,d1
 beq.s L0201c
 movea.l D00028(a6),a0
 move.l #1,6412(a0)
L0201c lea 20(sp),sp
 movem.l -32(a5),a0-a4/d4-d6
 unlk a5
 rts 
L0202a link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l #92160,-(sp)
 moveq #4,d1
 movea.l D00028(a6),a0
 move.l 162(a0),d0
 jsr _017b4(a6)
 addq.l #4,sp
 move.l #92160,-(sp)
 moveq #4,d1
 movea.l D00028(a6),a0
 move.l 166(a0),d0
 jsr _017b4(a6)
 addq.l #4,sp
 clr.l -(sp)
 moveq #0,d1
 moveq #255,d0
 jsr _017c0(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 clr.l 6978(a0)
L02072 pea (L00001).w
 moveq #1,d1
 movea.l D00028(a6),a0
 move.l 182(a0),d0
 jsr _016f4(a6)
 addq.l #4,sp
 moveq #1,d1
 cmp.l d0,d1
 bne.s L02072
 pea (L00008).w
 clr.l -(sp)
 pea (L00001).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 move.l D00028(a6),d0
 jsr _017a8(a6)
 lea 12(sp),sp
 movea.l D00028(a6),a0
 move.l #16777215,d0
 and.l 162(a0),d0
 bset.l #30,d0
 move.l d0,-(sp)
 clr.l -(sp)
 movea.l D00028(a6),a0
 movea.w 66(a0),a0
 move.l a0,-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01814(a6)
 jsr _017ba(a6)
 lea 12(sp),sp
 movea.l D00028(a6),a0
 movea.l 178(a0),a0
 clr.w 20(a0)
 jsr _01790(a6)
 movea.l D00028(a6),a0
 clr.b 5094(a0)
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
L02120 link.w a5,#0
 movem.l a0-a4/d0-d1/d4,-(sp)
 movea.l D00028(a6),a0
 movea.l 5018(a0),a2
 movea.l 12(a2),a3
 movea.l (a2),a4
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 move.w 316(a0),d4
 movea.l D00028(a6),a0
 tst.w 60(a0)
 beq.s L02164
 move.l 4(sp),-(sp)
 lea L02120(pc),a0
 move.l a0,d1
 move.l 4(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
 bra.w L022b6
L02164 movea.l D00028(a6),a0
 cmpi.w #4,4804(a0)
 bne.s L02174
 bsr.w L0202a
L02174 movea.l D00028(a6),a0
 tst.w 5646(a0)
 bne.s L021b0
 movea.l D00028(a6),a0
 move.w 5612(a0),d0
 ext.l d0
 addq.l #2,d0
 moveq #4,d1
 jsr _017ae(a6)
 movea.l D00028(a6),a0
 move.w d0,5644(a0)
 movea.l D00028(a6),a0
 move.w 44(a2),5640(a0)
 movea.l D00028(a6),a0
 move.w 46(a2),5642(a0)
 bra.w L02220
L021b0 movea.l D00028(a6),a0
 movea.l D00028(a6),a1
 move.w 5644(a0),5612(a1)
 bra.s L02220
 move.w #240,d0
 sub.w (a4),d0
 subq.w #5,d0
 move.w d0,46(a2)
 tst.w d4
 bne.w L02240
 movea.l D00028(a6),a0
 subq.w #1,4846(a0)
 bra.s L02240
 move.w #5,46(a2)
 tst.w d4
 bne.s L02240
 movea.l D00028(a6),a0
 addq.w #1,4846(a0)
 bra.s L02240
 move.w #6,44(a2)
 tst.w d4
 bne.s L02240
 movea.l D00028(a6),a0
 addq.w #1,4844(a0)
 bra.s L02240
 move.w #384,d0
 sub.w 2(a4),d0
 subq.w #6,d0
 move.w d0,44(a2)
 tst.w d4
 bne.s L02240
 movea.l D00028(a6),a0
 subq.w #1,4844(a0)
 bra.s L02240
L02220 movea.l D00028(a6),a0
 move.w 5612(a0),d0
 cmpi.w #3,d0
 bhi.s L02240
 add.w d0,d0
 move.w L02236(pc,d0.w),d0
 jmp L02236(pc,d0.w)
L02236 equ *-2
 dc.w $ff88
 dc.w $ffb8
 dc.w $ffa4
 dc.w $ffcc
L02240 movea.l D00028(a6),a0
 tst.w 5646(a0)
 beq.s L0225e
 movea.l D00028(a6),a0
 move.w 5640(a0),44(a2)
 movea.l D00028(a6),a0
 move.w 5642(a0),46(a2)
L0225e move.l a3,d1
 move.l a2,d0
 jsr _0169a(a6)
 moveq #0,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016ee(a6)
 moveq #0,d1
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L02290
 moveq #1,d0
 bra.s L02292
L02290 moveq #0,d0
L02292 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016ee(a6)
 movea.l D00028(a6),a0
 move.l 6400(a0),d1
 move.l #4780,d0
 add.l D00028(a6),d0
 bsr.w L01c44
L022b6 movem.l -24(a5),a0-a4/d4
 unlk a5
 rts 
L022c0 link.w a5,#0
 movem.l a0/a2/d0-d1/d4-d5,-(sp)
 move.l d0,d4
 movea.l d1,a2
 moveq #0,d5
 movea.l D00028(a6),a0
 move.w d4,4804(a0)
 movea.l D00028(a6),a0
 movea.l 178(a0),a0
 cmpi.w #8,(a0)
 beq.s L022f8
 pea (a2)
 lea L022c0(pc),a0
 move.l a0,d1
 move.l d4,d0
 jsr _016a6(a6)
 addq.l #4,sp
 bra.w L023d4
L022f8 movea.l D00028(a6),a0
 clr.l 6396(a0)
 movea.l D00028(a6),a0
 move.l d4,6400(a0)
 moveq #4,d0
 cmp.l d4,d0
 beq.s L02314
 bsr.w L0202a
 bra.s L02320
L02314 clr.l -(sp)
 moveq #0,d1
 moveq #255,d0
 jsr _017c0(a6)
 addq.l #4,sp
L02320 move.l a2,d1
 move.l #4780,d0
 add.l D00028(a6),d0
 jsr _017f6(a6)
 jsr _01760(a6)
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _017f0(a6)
 clr.l -(sp)
 move.l d4,d0
 lsl.l #2,d0
 lea _00bba(a6),a0
 move.l (a0,d0.l),d1
 move.l d5,d0
 jsr _016a6(a6)
 addq.l #4,sp
 moveq #0,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016ee(a6)
 moveq #0,d1
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L02380
 moveq #1,d0
 bra.s L02382
L02380 moveq #0,d0
L02382 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016ee(a6)
 movea.l D00028(a6),a0
 move.w #2,80(a0)
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016ee(a6)
 moveq #1,d1
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L023c4
 moveq #1,d0
 bra.s L023c6
L023c4 moveq #0,d0
L023c6 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016ee(a6)
L023d4 movem.l -16(a5),a0/a2/d4-d5
 unlk a5
 rts 
L023de link.w a5,#0
 movem.l a0/d0-d1/d4-d5,-(sp)
 move.l d0,d4
 move.l d1,d5
 moveq #8,d0
 cmp.l d5,d0
 ble.s L02452
 clr.l -(sp)
 pea L089d4(pc)
 movea.l D00028(a6),a0
 movea.l 6798(a0),a0
 pea 2048(a0)
 movea.l D00028(a6),a0
 move.l 6802(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 6798(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 4830(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 162(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 4792(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 4796(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 4038(a0),d1
 move.l d5,d0
 subq.l #1,d0
 lsl.l #2,d0
 lea _00b82(a6),a0
 move.l (a0,d0.l),d0
 jsr _0178a(a6)
 lea 36(sp),sp
 bra.s L02462
L02452 clr.l -(sp)
 lea L08782(pc),a0
 move.l a0,d1
 move.l d4,d0
 jsr _016a6(a6)
 addq.l #4,sp
L02462 movem.l -12(a5),a0/d4-d5
 unlk a5
 rts 
L0246c link.w a5,#0
 movem.l a0/d0-d1/d4-d5,-(sp)
 move.l d0,d4
 move.l d1,d5
 bsr.w L0202a
L0247c pea (L00001).w
 moveq #1,d1
 movea.l D00028(a6),a0
 move.l 182(a0),d0
 jsr _016f4(a6)
 addq.l #4,sp
 moveq #1,d1
 cmp.l d0,d1
 bne.s L0247c
 pea (L00008).w
 pea (L00001).w
 pea (L00001).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 move.l D00028(a6),d0
 jsr _017a8(a6)
 lea 12(sp),sp
 move.l d5,-(sp)
 pea L023de(pc)
 movea.l D00028(a6),a0
 pea 6222(a0)
 lea L0266d(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 6432(a0),d0
 jsr _01766(a6)
 lea 12(sp),sp
 movem.l -12(a5),a0/d4-d5
 unlk a5
 rts 
L024f0 link.w a5,#0
 movem.l a0/d0-d1/d4-d5,-(sp)
 move.l d0,d4
 move.l d1,d5
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _017f0(a6)
 jsr _01760(a6)
 move.l d5,d0
 subq.l #1,d0
 lsl.l #2,d0
 lea _00b9e(a6),a0
 move.l (a0,d0.l),d1
 move.l #4856,d0
 add.l D00028(a6),d0
 jsr _017f6(a6)
 pea (L00002).w
 pea (L00002).w
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 moveq #63,d1
 moveq #82,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 pea (L00002).w
 pea (L00002).w
 move.l d5,-(sp)
 pea L0246c(pc)
 clr.l -(sp)
 moveq #63,d1
 moveq #122,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 movem.l -12(a5),a0/d4-d5
 unlk a5
 rts 
L02570 link.w a5,#0
 movem.l a0/d0-d1/d4-d5,-(sp)
 move.l d0,d4
 move.l d1,d5
 move.l d5,-(sp)
 lea L024f0(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _01802(a6)
 addq.l #4,sp
 movem.l -12(a5),a0/d4-d5
 unlk a5
 rts 
 bcs.s L0260c
 dc.w $6473
 dc.w $6831
 ori.w #$6e64,-(a5)
 dc.w $7368
 move.w d0,d1
 bcs.s L0261a
 dc.w $6473
 dc.w $6833
 ori.w #$6e64,-(a5)
 dc.w $7368
 move.w d0,d2
 bcs.s L02628
 dc.w $6473
 dc.w $6835
 ori.w #$6e64,-(a5)
 dc.w $7368
 move.w d0,d3
 bcs.s L02636
 dc.w $6473
 dc.w $6837
 ori.w #$3332,-(sp)
 ori.w #$3800,31285(a4)
 dc.w $73
 move.w d0,-(a2)
 moveq #50,d1
 move.w d0,-(a4)
 bsr.s L02642
 move.w 103(sp,d0.w),-(a0)
 dc.w $6c31
 dc.w $7a
L025e7 equ *-1
 bcs.s L02656
 dc.w $6461
 ori.w #$6973,-(a4)
L025ed equ *-3
 moveq #108,d0
 dc.w $6179
 ori.w #$6e66,28416(a1)
L025f5 equ *-5
L025fa moveq #114,d2
 dc.w $6565
 ori.w #$7963,-(a3)
L025ff equ *-3
 dc.w $6c65
 dc.w $76
L02605 equ *-1
 dc.w $6f69
 dc.w $6365
 dc.w $70
L0260b equ *-1
L0260c dc.w $6c61
 dc.w $793b
 ori.w #$6666,29541(sp)
L02611 equ *-5
 moveq #115,d2
 ori.w #$6d61,(a5,d7.w)
L02619 equ *-5
L0261a equ *-4
L0261e dc.w $6f6d
 bsr.s L02692
 dc.w $2a
L02623 equ *-1
 move.l 10794(a2),d5
L02628 move.l 10794(a2),d5
 move.l 10794(a2),d5
 move.l 10794(a2),d5
 move.l 10794(a2),d5
L02636 equ *-2
 move.l 10794(a2),d5
 move.l a5,d5
 ori.w #$6e74,d5
L0263f equ *-3
L02642 bcs.s L026b6
 bvs.s L026b4
 beq.s L02668
 dc.w $4365
 bge.s L026b8
 move.l -(a5),d0
 dc.w $730d
 dc.w $2a
L02651 equ *-1
 move.l 10794(a2),d5
L02656 move.l 10794(a2),d5
 move.l 10794(a2),d5
 move.l 10794(a2),d5
 move.l 10794(a2),d5
 move.l 10794(a2),d5
L02668 equ *-2
 move.l a5,d5
 ori.w #$6d61,(a2,d7.w)
L0266d equ *-5
L02672 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4-d7,-(sp)
 move.l 48(sp),d4
 move.l 52(sp),d5
 movea.l 56(sp),a2
 lea -288(sp),sp
 move.l d4,d0
 add.l d5,d0
 cmpi.l #256,d0
L02692 equ *-2
 bgt.w L027a4
 tst.l d4
 blt.w L027a4
 tst.l d5
 blt.w L027a4
 move.l 292(sp),d0
 move.l d0,20(sp)
 move.l d0,16(sp)
 move.l 332(sp),d0
L026b4 move.l d0,28(sp)
L026b6 equ *-2
L026b8 move.l d0,24(sp)
 moveq #11,d0
 move.l d0,8(sp)
 move.l d0,(sp)
 moveq #77,d0
 move.l d0,12(sp)
 move.l d0,4(sp)
 moveq #0,d7
 bra.w L0279c
L026d4 lea 32(sp),a3
 move.l d4,d6
 subq.l #4,sp
 move.l d4,d0
 add.l d5,d0
 move.l d0,(sp)
 bra.s L026f4
L026e4 move.b d6,d0
 addq.l #1,d6
 bset.l #7,d0
 move.b d0,(a3)+
 move.b (a2)+,(a3)+
 move.b (a2)+,(a3)+
 move.b (a2)+,(a3)+
L026f4 cmp.l (sp),d6
 bge.s L026fe
 moveq #64,d0
 cmp.l d6,d0
 bgt.s L026e4
L026fe addq.l #4,sp
 move.l d4,d0
 add.l d5,d0
 moveq #64,d1
 cmp.l d0,d1
L02708 ble.s L02742
 pea 32(sp)
 move.l d5,-(sp)
L02710 move.l d7,d0
 lsl.l #2,d0
 lea 8(sp),a0
 move.l (a0,d0.l),d0
 add.l d4,d0
 move.l d0,-(sp)
 move.l d7,d0
 lsl.l #2,d0
 lea 28(sp),a0
 move.l (a0,d0.l),d1
 move.l 300(sp),d0
 jsr _0181a(a6)
 lea 12(sp),sp
 moveq #255,d1
 cmp.l d0,d1
 beq.s L027a4
 moveq #0,d0
 bra.s L027a6
L02742 moveq #64,d0
 cmp.l d4,d0
 ble.s L02796
 subq.l #4,sp
 moveq #64,d0
 sub.l d4,d0
 move.l d0,(sp)
 pea 36(sp)
 move.l 4(sp),-(sp)
 move.l d7,d0
 lsl.l #2,d0
 lea 12(sp),a0
 move.l (a0,d0.l),d0
 add.l d4,d0
 move.l d0,-(sp)
 move.l d7,d0
 lsl.l #2,d0
 lea 32(sp),a0
 move.l (a0,d0.l),d1
 move.l 304(sp),d0
 jsr _0181a(a6)
 lea 12(sp),sp
 moveq #255,d1
 cmp.l d0,d1
 bne.s L0278e
 moveq #255,d0
 lea 292(sp),sp
 bra.s L027aa
L0278e sub.l (sp),d5
 moveq #0,d4
 addq.l #4,sp
 bra.s L0279a
L02796 moveq #64,d0
 sub.l d0,d4
L0279a addq.l #1,d7
L0279c moveq #4,d0
 cmp.l d7,d0
 bgt.w L026d4
L027a4 moveq #255,d0
L027a6 lea 288(sp),sp
L027aa movem.l -28(a5),a0/a2-a3/d4-d7
 unlk a5
 rts 
L027b4 link.w a5,#0
 movem.l a0/a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 subq.l #4,sp
 pea (L00006).w
 movea.l D00028(a6),a0
 move.l 5624(a0),-(sp)
 clr.l -(sp)
 pea L060cc(pc)
 pea L060a0(pc)
 pea L05e96(pc)
 clr.l -(sp)
 lea L05e50(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _0183e(a6)
 lea 28(sp),sp
 movea.l d0,a3
 move.l a3,d0
 beq.s L02840
 move.l a3,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
L02800 equ *-2
 jsr _01838(a6)
 move.w 44(a2),d0
 movea.l (a2),a0
 move.w 2(a0),d1
 asr.w #1,d1
 add.w d1,d0
 subi.w #16,d0
 move.w d0,(sp)
 move.w 46(a2),d0
 movea.l (a2),a0
 move.w (a0),d1
 asr.w #1,d1
 add.w d1,d0
 subi.w #16,d0
 move.w d0,2(sp)
 move.w #384,d0
 muls.w 2(sp),d0
 move.w (sp),d1
 ext.l d1
 add.l d1,d0
 move.l d0,2(a3)
L02840 addq.l #4,sp
 movem.l -16(a5),a0/a2-a3/d1
 unlk a5
 rts 
L0284c link.w a5,#0
 movem.l a0-a2/d0-d1/d4,-(sp)
 move.l #8104,d0
 add.l D00028(a6),d0
 movea.l d0,a2
 lea L02d34(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 4868(a0),d0
 jsr _017de(a6)
 movea.l D00028(a6),a0
 move.l d0,8100(a0)
 lea L02d3d(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 4868(a0),d0
 jsr _017de(a6)
 movea.l D00028(a6),a0
 movea.l 8100(a0),a0
 move.l d0,6(a0)
 movea.l D00028(a6),a0
 movea.l D00028(a6),a1
 movea.l 8100(a1),a1
 movea.l 6(a1),a1
 move.l 7842(a0),68(a1)
 movea.l D00028(a6),a0
 movea.l 8100(a0),a0
 clr.w 44(a0)
 moveq #0,d4
 bra.s L028fc
L028be movea.l D00028(a6),a0
 move.l 8100(a0),(a2)
 movea.l D00028(a6),a0
 movea.l 8100(a0),a0
 move.l 6(a0),16(a2)
 movea.l D00028(a6),a0
 movea.l 8100(a0),a0
 move.l 6(a0),20(a2)
 movea.l D00028(a6),a0
 movea.l 8100(a0),a0
 move.l 6(a0),4(a2)
 clr.w 38(a2)
 addq.l #1,d4
 adda.l #54,a2
L028fc moveq #8,d0
 cmp.l d4,d0
 bgt.s L028be
 movem.l -20(a5),a0-a2/d1/d4
 unlk a5
 rts 
L0290c link.w a5,#0
 movem.l a0/a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 movea.l 46(a2),a3
 clr.w 38(a3)
 move.l a2,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _01844(a6)
 move.l a3,d0
 bsr.w L027b4
 movem.l -16(a5),a0/a2-a3/d1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0-a3/d0-d1,-(sp)
 movea.l d0,a2
 movea.l 12(a2),a3
 move.w #2,(a3)
 cmpi.w #2,26(a2)
 bne.s L0299c
 movea.l D00028(a6),a0
 tst.w 5630(a0)
 bne.s L0299c
 movea.l D00028(a6),a0
 movea.l 5018(a0),a0
 addi.w #$0014,34(a0)
 movea.l D00028(a6),a0
 movea.l D00028(a6),a1
 movea.l 5018(a1),a1
 move.w 34(a1),d0
 cmp.w 5106(a0),d0
 ble.s L02996
 movea.l D00028(a6),a0
 movea.l D00028(a6),a1
 movea.l 5018(a1),a1
 move.w 5106(a0),34(a1)
L02996 bsr.w L0307a
 bra.s L029ba
L0299c tst.w 26(a2)
 bne.s L029ac
 movea.l D00028(a6),a0
 addq.w #5,5610(a0)
 bra.s L029b6
L029ac movea.l D00028(a6),a0
 addi.w #$000a,5610(a0)
L029b6 bsr.w L0336a
L029ba pea (a2)
 moveq #3,d1
 moveq #0,d0
 bsr.w L077fe
 addq.l #4,sp
 movem.l -20(a5),a0-a3/d1
 unlk a5
 rts 
L029d0 link.w a5,#0
 movem.l a2/d0-d1,-(sp)
 movea.l d0,a2
 bra.s L029f2
 moveq #0,d0
 bra.s L02a10
 moveq #1,d0
 bra.s L02a10
 moveq #2,d0
 bra.s L02a10
 bsr.w L08ba2
 moveq #14,d1
 asr.l d1,d0
 bra.s L02a10
L029f2 move.w 36(a2),d0
 cmpi.w #4,d0
 bhi.s L02a10
 add.w d0,d0
 move.w L02a04(pc,d0.w),d0
 jmp L02a04(pc,d0.w)
L02a04 equ *-2
 dc.w $ffd6
 dc.w $ffd6
 dc.w $ffda
 dc.w $ffde
 dc.w $ffe2
L02a10 movem.l -8(a5),a2/d1
 unlk a5
 rts 
L02a1a link.w a5,#0
 movem.l a0/a2/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
 subq.l #1,d4
 tst.l d4
 bge.s L02a32
 move.w #2,(a2)
 bra.s L02a5c
L02a32 moveq #15,d0
 cmp.l d4,d0
 ble.s L02a4c
 tst.l 14(a2)
 beq.s L02a44
 clr.l 14(a2)
 bra.s L02a4c
L02a44 movea.l _0166c(a6),a0
 move.l a0,14(a2)
L02a4c move.l d4,-(sp)
 lea L02a1a(pc),a0
 move.l a0,d1
 move.l a2,d0
 jsr _017fc(a6)
 addq.l #4,sp
L02a5c movem.l -12(a5),a0/a2/d4
 unlk a5
 rts 
L02a66 link.w a5,#0
 movem.l a0/a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.w 50(a3),d0
 ext.l d0
 lsl.l #1,d0
 lea _00bce(a6),a0
 move.w (a0,d0.l),d0
 add.w d0,46(a3)
 move.l a2,d1
 move.l a3,d0
 jsr _0169a(a6)
 addq.w #1,50(a3)
 move.w 50(a3),d0
 ext.l d0
 lsl.l #1,d0
 lea _00bce(a6),a0
 tst.w (a0,d0.l)
 bne.s L02abe
 pea (L0005a).w
 lea L02a1a(pc),a0
 move.l a0,d1
 move.l a2,d0
 jsr _017fc(a6)
 addq.l #4,sp
 movea.l _01822(a6),a0
 move.l a0,18(a2)
L02abe movem.l -12(a5),a0/a2-a3
 unlk a5
 rts 
L02ac8 link.w a5,#0
 movem.l a0/a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.w 50(a3),d0
 ext.l d0
 lsl.l #2,d0
 lea _00bf8(a6),a0
 move.w (a0,d0.l),d0
 add.w d0,44(a3)
 move.w 50(a3),d0
 ext.l d0
 lsl.l #2,d0
 lea _00bf8(a6),a0
 move.w 2(a0,d0.l),d0
 add.w d0,46(a3)
 move.l a2,d1
 move.l a3,d0
 jsr _0169a(a6)
 addq.w #1,50(a3)
 move.w 50(a3),d0
 ext.l d0
 lsl.l #2,d0
 lea _00bf8(a6),a0
 cmpi.w #99,(a0,d0.l)
 bne.s L02b36
 pea (L0005a).w
 lea L02a1a(pc),a0
 move.l a0,d1
 move.l a2,d0
 jsr _017fc(a6)
 addq.l #4,sp
 movea.l _01822(a6),a0
 move.l a0,18(a2)
L02b36 movem.l -12(a5),a0/a2-a3
 unlk a5
 rts 
L02b40 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l (a2),d4
 movea.l d4,a0
 tst.w 36(a0)
 beq.w L02c60
 moveq #8,d1
 move.l #8104,d0
 add.l D00028(a6),d0
 jsr _0182c(a6)
 movea.l d0,a4
 move.l a4,d0
 beq.w L02c60
 move.l d4,d0
 bsr.w L029d0
 move.w d0,26(a4)
 cmpi.w #2,26(a4)
 ble.s L02b88
 clr.w 38(a4)
 bra.w L02c60
L02b88 move.w 44(a2),d0
 movea.l d4,a0
 move.w 2(a0),d1
 asr.w #1,d1
 add.w d1,d0
 subq.w #6,d0
 move.w d0,44(a4)
 move.w 46(a2),d0
 movea.l d4,a0
 move.w (a0),d1
 asr.w #1,d1
 add.w d1,d0
 subq.w #6,d0
 move.w d0,46(a4)
 cmpi.w #20,44(a4)
 bge.s L02bbe
 move.w #20,44(a4)
 bra.s L02bcc
L02bbe cmpi.w #363,44(a4)
 ble.s L02bcc
 move.w #363,44(a4)
L02bcc cmpi.w #20,46(a4)
 bge.s L02bdc
 move.w #20,46(a4)
 bra.s L02bea
L02bdc cmpi.w #219,46(a4)
 ble.s L02bea
 move.w #219,46(a4)
L02bea clr.w 50(a4)
 pea (L00001).w
 pea (a4)
 clr.l -(sp)
 pea L0290c(pc)
 pea L02a66(pc)
 move.l _01828(a6),-(sp)
 clr.l -(sp)
 movea.l _0166c(a6),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _0183e(a6)
 lea 28(sp),sp
 movea.l d0,a3
 move.l d0,12(a4)
 move.l a3,d0
 beq.s L02c60
 move.l a4,34(a3)
 cmpi.w #2,26(a4)
 bne.s L02c40
 pea (a4)
 lea L02ac8(pc),a0
 move.l a0,d1
 move.l a3,d0
 jsr _017fc(a6)
 addq.l #4,sp
L02c40 move.l a3,d1
 move.l a4,d0
 jsr _0169a(a6)
 move.w 26(a4),d0
 addq.w #3,d0
 move.w d0,38(a3)
 move.l a3,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _016b2(a6)
L02c60 movem.l -24(a5),a0/a2-a4/d1/d4
 unlk a5
 rts 
L02c6a link.w a5,#0
 movem.l a0/a2-a4/d0-d1,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 movea.l 46(a2),a4
 move.w 50(a4),d0
 ext.l d0
 lsl.l #1,d0
 lea _00bce(a6),a0
 move.w (a0,d0.l),d0
 add.w d0,46(a4)
 move.w #384,d0
 muls.w 46(a4),d0
 move.w 44(a4),d1
 ext.l d1
 add.l d1,d0
 move.l d0,2(a2)
 addq.w #1,50(a4)
 move.w 50(a4),d0
 ext.l d0
 lsl.l #1,d0
 lea _00bce(a6),a0
 tst.w (a0,d0.l)
 bne.s L02cc6
 movea.l _01822(a6),a0
 move.l a0,18(a2)
 move.l a4,d0
 jsr _01832(a6)
L02cc6 movem.l -16(a5),a0/a2-a4
 unlk a5
 rts 
L02cd0 link.w a5,#0
 movem.l a0/a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 move.l a2,d0
 jsr _01688(a6)
 movea.l 12(a2),a3
 clr.w 50(a2)
 move.l a3,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _016b2(a6)
 clr.l 18(a3)
 move.w 30(a2),44(a2)
L02d00 move.w 32(a2),46(a2)
 move.w #384,d0
 muls.w 46(a2),d0
 move.w 44(a2),d1
 ext.l d1
 add.l d1,d0
 move.l d0,2(a3)
 clr.l -(sp)
 lea L02c6a(pc),a0
 move.l a0,d1
 move.l a3,d0
 jsr _017fc(a6)
 addq.l #4,sp
 movem.l -16(a5),a0/a2-a3/d1
 unlk a5
 rts 
L02d34 dc.w $6373
 moveq #95,d0
 dc.w $6465
 dc.w $7363
 ori.w #$7370,-(a3)
L02d3d equ *-3
 subq.w #7,-(sp)
 moveq #111,d1
 dc.w $7570
 dc.w $7300
L02d48 link.w a5,#0
 movem.l a0/a2-a3/d0-d2/d4-d6,-(sp)
 lea -160(sp),sp
 movea.l D00028(a6),a0
 move.l #268,d0
 add.l 4830(a0),d0
 movea.l d0,a2
 moveq #24,d5
 moveq #77,d0
 add.l d5,d0
 move.l d0,d6
 lea (sp),a3
 moveq #0,d4
 bra.s L02db2
L02d72 move.l d5,d0
 add.l d4,d0
 moveq #63,d1
 and.l d1,d0
 moveq #24,d1
 lsl.l d1,d0
 addi.l #$80000000,d0
 move.b #255,d1
 and.b (a2)+,d1
 moveq #0,d2
 move.b d1,d2
 moveq #16,d1
 lsl.l d1,d2
 or.l d2,d0
 move.b #255,d1
L02d98 and.b (a2)+,d1
 moveq #0,d2
 move.b d1,d2
 lsl.l #8,d2
 or.l d2,d0
 move.b #255,d1
 and.b (a2)+,d1
 moveq #0,d2
 move.b d1,d2
 or.l d2,d0
 move.l d0,(a3)+
 addq.l #1,d4
L02db2 moveq #40,d0
 cmp.l d4,d0
 bgt.s L02d72
 pea (sp)
 pea (L00028).w
 move.l d6,-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01814(a6)
 jsr _0181a(a6)
 lea 12(sp),sp
 jsr _0184a(a6)
 lea 160(sp),sp
 movem.l -32(a5),a0/a2-a3/d1-d2/d4-d6
 unlk a5
 rts 
L02dfa link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d5,-(sp)
 move.l d0,d4
 movea.l d1,a2
 subq.l #4,sp
 movea.l D00028(a6),a0
 move.l 4830(a0),d0
 addq.l #4,d0
 movea.l d0,a4
 moveq #1,d0
 cmp.l d4,d0
 bne.w L02ea8
 move.w (a2),d0
 ext.l d0
 move.w 2(a2),d1
 ext.l d1
 add.l d1,d0
 subq.l #1,d0
 moveq #3,d1
 jsr _016a0(a6)
 add.l a4,d0
 movea.l d0,a3
 pea (L00003).w
 move.l a3,d1
 lea 5(sp),a0
 move.l a0,d0
 jsr _017c6(a6)
 addq.l #4,sp
 moveq #0,d5
 bra.s L02e60
L02e4a pea (L00003).w
 move.l a3,d0
 subq.l #3,d0
 move.l d0,d1
 move.l a3,d0
 jsr _017c6(a6)
 addq.l #4,sp
 subq.l #3,a3
 addq.l #1,d5
L02e60 move.w 2(a2),d0
 ext.l d0
 cmp.l d5,d0
 bgt.s L02e4a
 moveq #3,d0
 muls.w (a2),d0
 add.l a4,d0
 movea.l d0,a3
 pea (L00003).w
 lea 5(sp),a0
 move.l a0,d1
 move.l a3,d0
 jsr _017c6(a6)
 addq.l #4,sp
 addq.w #1,8(a2)
 move.w 8(a2),d0
 cmp.w 2(a2),d0
 blt.w L02f16
 clr.w 8(a2)
 cmpi.w #1,4(a2)
 bne.s L02f16
 move.w #1,18(a2)
 bra.s L02f16
L02ea8 moveq #3,d0
 muls.w (a2),d0
 add.l a4,d0
 movea.l d0,a3
 pea (L00003).w
 move.l a3,d1
 lea 5(sp),a0
 move.l a0,d0
 jsr _017c6(a6)
 addq.l #4,sp
 moveq #3,d0
 muls.w 2(a2),d0
 move.l d0,-(sp)
 move.l a3,d0
 addq.l #3,d0
 move.l d0,d1
 move.l a3,d0
 jsr _017c6(a6)
 addq.l #4,sp
 move.w (a2),d0
 ext.l d0
 move.w 2(a2),d1
 ext.l d1
 add.l d1,d0
 subq.l #1,d0
 moveq #3,d1
 jsr _016a0(a6)
 add.l a4,d0
 movea.l d0,a3
 pea (L00003).w
 lea 5(sp),a0
 move.l a0,d1
 move.l a3,d0
 jsr _017c6(a6)
 addq.l #4,sp
 subq.w #1,8(a2)
 tst.w 8(a2)
 bge.s L02f16
 move.w 2(a2),d0
 subq.w #1,d0
 move.w d0,8(a2)
L02f16 addq.l #4,sp
 movem.l -24(a5),a0/a2-a4/d4-d5
 unlk a5
 rts 
L02f22 link.w a5,#0
 movem.l a0/a2/d0-d1/d4-d5,-(sp)
 movea.l D00028(a6),a0
 movea.l 4838(a0),a2
 moveq #0,d4
 bra.w L02fda
L02f38 cmpi.w #1,12(a2)
 bne.s L02f9e
 tst.w 14(a2)
 bne.s L02f9e
 cmpi.w #1,4(a2)
 bne.s L02f58
 move.l a2,d1
 moveq #1,d0
 bsr.w L02dfa
 bra.s L02f9e
L02f58 cmpi.w #2,4(a2)
 bne.s L02f9e
 tst.w 8(a2)
 bne.s L02f6e
 move.w #1,10(a2)
 bra.s L02f86
L02f6e move.w 2(a2),d0
 ext.l d0
 subq.l #1,d0
 move.w 8(a2),d1
 ext.l d1
 cmp.l d1,d0
 bne.s L02f86
 move.w #2,10(a2)
L02f86 move.l a2,d1
 movea.w 10(a2),a0
 move.l a0,d0
 bsr.w L02dfa
 tst.w 8(a2)
 bne.s L02f9e
 move.w #1,18(a2)
L02f9e addq.w #1,14(a2)
 move.w 14(a2),d0
 cmp.w 6(a2),d0
 blt.s L02fd2
 clr.w 14(a2)
 cmpi.w #1,18(a2)
 bne.s L02fd2
 clr.w 18(a2)
 cmpi.w #3,16(a2)
 bne.s L02fd2
 bsr.w L08ba2
 move.w d0,d5
 moveq #9,d0
 lsr.w d0,d5
 sub.w d5,14(a2)
L02fd2 addq.l #1,d4
 adda.l #20,a2
L02fda moveq #4,d0
 cmp.l d4,d0
 bgt.w L02f38
 movem.l -16(a5),a0/a2/d4-d5
 unlk a5
 rts 
L02fec link.w a5,#0
 movem.l a0/a2/d0-d1/d4,-(sp)
 move.l #7002,d0
 add.l D00028(a6),d0
 movea.l d0,a2
 moveq #0,d4
 bra.s L03020
L03004 cmpi.w #1,(a2)
 bne.s L03018
 move.l a2,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _0186e(a6)
L03018 addq.l #1,d4
 adda.l #60,a2
L03020 moveq #14,d0
 cmp.l d4,d0
 bgt.s L03004
 movea.l D00028(a6),a0
 move.w 5106(a0),d0
 ext.l d0
 divs.w #20,d0
 movea.l D00028(a6),a0
 move.w d0,7850(a0)
 move.l #7002,d0
 add.l D00028(a6),d0
 movea.l d0,a2
 moveq #0,d4
 bra.s L03062
L0304c move.l a2,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _01838(a6)
 adda.l #60,a2
 addq.l #1,d4
L03062 movea.l D00028(a6),a0
 move.w 7850(a0),d0
 ext.l d0
 cmp.l d4,d0
 bgt.s L0304c
 movem.l -16(a5),a0/a2/d1/d4
 unlk a5
 rts 
L0307a link.w a5,#0
 movem.l a0/a2/d0/d4-d6,-(sp)
 move.l #7002,d0
 add.l D00028(a6),d0
 movea.l d0,a2
 moveq #0,d5
 movea.l D00028(a6),a0
 movea.l 5018(a0),a0
 move.w 34(a0),d6
 moveq #0,d4
 bra.s L030ac
L030a0 clr.w 38(a2)
 adda.l #60,a2
 addq.l #1,d4
L030ac movea.l D00028(a6),a0
 move.w 7850(a0),d0
 ext.l d0
 cmp.l d4,d0
 bgt.s L030a0
 move.l #7002,d0
 add.l D00028(a6),d0
 movea.l d0,a2
 bra.s L030f4
L030c8 addq.w #1,38(a2)
 cmpi.w #2,38(a2)
 ble.s L030f0
 move.w #2,38(a2)
 adda.l #60,a2
 addq.w #1,38(a2)
 addq.w #1,d5
 movea.l D00028(a6),a0
 cmp.w 7850(a0),d5
 bgt.s L030fa
L030f0 subi.w #10,d6
L030f4 cmpi.w #10,d6
 bge.s L030c8
L030fa movea.l D00028(a6),a0
 movea.l 5018(a0),a0
 tst.w 34(a0)
 ble.s L0311c
 movea.l D00028(a6),a0
 movea.l 5018(a0),a0
 cmpi.w #10,34(a0)
 bge.s L0311c
 addq.w #1,38(a2)
L0311c movem.l -20(a5),a0/a2/d4-d6
 unlk a5
 rts 
L03126 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l 36(sp),d5
 movea.l 40(sp),a3
 lea -22(sp),sp
 adda.l d4,a3
 move.l a3,4(sp)
 move.w d5,d0
 ext.l d0
 lsl.l #2,d0
 movea.l D00028(a6),a0
 movea.l 7842(a0),a0
 movea.l 4(a0),a0
 move.l (a0,d0.l),(sp)
 lea (sp),a0
 move.l a0,d0
 jsr _01856(a6)
 lea 22(sp),sp
 movem.l -20(a5),a0/a2-a3/d4-d5
 unlk a5
 rts 
L03170 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l 36(sp),d5
 movea.l 40(sp),a3
 lea -22(sp),sp
 adda.l d4,a3
 move.l a3,4(sp)
 move.w d5,d0
 ext.l d0
 lsl.l #2,d0
 movea.l D00028(a6),a0
 movea.l 7846(a0),a0
 movea.l 4(a0),a0
 move.l (a0,d0.l),(sp)
 clr.l 8(sp)
 lea (sp),a0
 move.l a0,d0
 jsr _01868(a6)
 lea 22(sp),sp
 movem.l -20(a5),a0/a2-a3/d4-d5
 unlk a5
 rts 
L031be link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l 36(sp),d5
 movea.l 40(sp),a3
 lea -22(sp),sp
 adda.l d4,a3
 move.l a3,4(sp)
 move.w d5,d0
 ext.l d0
 lsl.l #2,d0
 movea.l D00028(a6),a0
 movea.l 7846(a0),a0
 movea.l 4(a0),a0
 move.l (a0,d0.l),(sp)
 lea (sp),a0
 move.l a0,d0
 jsr _01856(a6)
 lea 22(sp),sp
 movem.l -20(a5),a0/a2-a3/d4-d5
 unlk a5
 rts 
L03208 link.w a5,#0
 movem.l a0/a2/d0-d2/d4-d7,-(sp)
 moveq #24,d5
 move.l #236,d6
 moveq #0,d7
 movea.l D00028(a6),a0
 move.l 7842(a0),d0
 jsr _01862(a6)
 movea.l D00028(a6),a0
 move.l 7846(a0),d0
 jsr _01862(a6)
 movea.l D00028(a6),a0
 move.l 5110(a0),d0
 jsr _01862(a6)
 movea.l D00028(a6),a0
 move.l 5624(a0),d0
 jsr _01862(a6)
 move.l #7002,d0
 add.l D00028(a6),d0
 movea.l d0,a2
 moveq #0,d4
 bra.s L032ae
L0325a pea (a2)
 pea (L00003).w
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 moveq #0,d1
 lea L03126(pc),a0
 move.l a0,d0
 jsr _0185c(a6)
 lea 28(sp),sp
 moveq #6,d0
 cmp.l d4,d0
 bge.s L03290
 tst.l d7
 bne.s L03290
 moveq #14,d0
 add.l d0,d5
 move.l #236,d6
 moveq #1,d7
L03290 move.l d5,d0
 move.l #384,d1
 jsr _016a0(a6)
 add.l d6,d0
 move.l d0,2(a2)
 addq.l #1,d4
 moveq #16,d0
 add.l d0,d6
 adda.l #60,a2
L032ae moveq #14,d0
 cmp.l d4,d0
 bgt.s L0325a
 moveq #0,d4
 bra.s L0331e
L032b8 move.l d4,d0
 moveq #60,d1
 jsr _016a0(a6)
 movea.l D00028(a6),a0
 adda.l d0,a0
 pea 7912(a0)
 pea (L00003).w
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 moveq #0,d1
 lea L031be(pc),a0
 move.l a0,d0
 jsr _0185c(a6)
 lea 28(sp),sp
 move.l d4,d0
 moveq #12,d1
 jsr _016a0(a6)
 addi.l #$00002430,d0
 move.l d0,d2
 move.l d4,d0
 moveq #60,d1
 jsr _016a0(a6)
 movea.l D00028(a6),a0
 adda.l d0,a0
 move.l d2,7914(a0)
 move.l d4,d0
 moveq #60,d1
 jsr _016a0(a6)
 movea.l D00028(a6),a0
 adda.l d0,a0
 clr.w 7950(a0)
 addq.l #1,d4
L0331e moveq #3,d0
 cmp.l d4,d0
 bgt.s L032b8
 movea.l D00028(a6),a0
 pea 7852(a0)
 pea (L00003).w
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 moveq #0,d1
 lea L03126(pc),a0
 move.l a0,d0
 jsr _0185c(a6)
 lea 28(sp),sp
 movea.l D00028(a6),a0
 move.l #10020,7854(a0)
 movea.l D00028(a6),a0
 move.w #3,7890(a0)
 movem.l -32(a5),a0/a2/d1-d2/d4-d7
 unlk a5
 rts 
L0336a link.w a5,#0
 movem.l a0-a2/d0-d1/d4-d5,-(sp)
 subq.l #6,sp
 move.l #7912,d0
 add.l D00028(a6),d0
 movea.l d0,a2
 moveq #0,d5
 movea.l D00028(a6),a0
 cmpi.w #999,5108(a0)
 ble.s L03398
 movea.l D00028(a6),a0
 move.w #999,5108(a0)
L03398 movea.l D00028(a6),a0
 tst.w 5108(a0)
 bge.s L033aa
 movea.l D00028(a6),a0
 clr.w 5108(a0)
L033aa pea (L00005).w
 pea (L0000a).w
 lea 9(sp),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 movea.w 5108(a0),a0
 move.l a0,d0
 bsr.w L0aed4
 addq.l #8,sp
 moveq #0,d4
 bra.s L033e0
L033cc clr.w 38(a2)
 lea L03170(pc),a0
 move.l a0,22(a2)
 addq.l #1,d4
 adda.l #60,a2
L033e0 lea 1(sp),a0
 move.l a0,d0
 jsr _01850(a6)
 moveq #3,d1
 sub.l d0,d1
 cmp.l d4,d1
 bgt.s L033cc
 lea 1(sp),a0
 move.l a0,d0
 jsr _01850(a6)
 moveq #3,d1
 sub.l d0,d1
 move.l d1,d4
 bra.s L03428
L03404 lea 1(sp),a0
 move.b (a0,d5.l),d0
 ext.w d0
 subi.w #48,d0
 move.w d0,38(a2)
 lea L03170(pc),a0
 move.l a0,22(a2)
 addq.l #1,d4
 addq.l #1,d5
 adda.l #60,a2
L03428 moveq #3,d0
 cmp.l d4,d0
 bgt.s L03404
 movea.l D00028(a6),a0
 tst.w 5108(a0)
 beq.s L03448
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 move.w #1,144(a0)
 bra.s L03454
L03448 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 clr.w 144(a0)
L03454 movea.l D00028(a6),a0
 movea.l D00028(a6),a1
 movea.l 6908(a1),a1
 move.w 5108(a0),268(a1)
 addq.l #6,sp
 movem.l -24(a5),a0-a2/d1/d4-d5
 unlk a5
 rts 
L03472 link.w a5,#0
 movem.l a0/a2/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 bsr.w L08ba2
 moveq #11,d1
 asr.l d1,d0
 move.l d0,d5
 addq.l #6,d5
 clr.w 8(a2)
 clr.w 10(a2)
 bsr.w L08ba2
 moveq #10,d1
 asr.l d1,d0
 subi.w #32,d0
 move.w d0,8(a2)
 bsr.w L08ba2
 moveq #10,d1
 asr.l d1,d0
 subi.w #32,d0
 move.w d0,10(a2)
 tst.w 8(a2)
 bne.s L034ba
 addq.w #1,8(a2)
L034ba move.w #1536,(a2)
 move.w #960,2(a2)
 movea.l D00028(a6),a0
 move.l 4038(a0),4(a2)
 moveq #0,d4
 bra.s L034e2
L034d2 move.w 8(a2),d0
 add.w d0,(a2)
 move.w 10(a2),d0
 add.w d0,2(a2)
 addq.l #1,d4
L034e2 cmp.l d5,d4
 blt.s L034d2
 bsr.w L08ba2
 moveq #14,d1
 asr.l d1,d0
 addq.w #1,d0
 move.w d0,12(a2)
 clr.w 16(a2)
 bsr.w L08ba2
 moveq #10,d1
 asr.l d1,d0
 move.w d0,14(a2)
 movem.l -20(a5),a0/a2/d1/d4-d5
 unlk a5
 rts 
L0350e link.w a5,#0
 movem.l a0/a2/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 movea.l 4(a2),a0
 clr.b (a0)
 addq.w #1,16(a2)
 move.w 16(a2),d0
 cmp.w 14(a2),d0
 blt.s L0354a
 clr.w 16(a2)
 move.w 8(a2),d0
 add.w d0,8(a2)
 move.w 10(a2),d0
 add.w d0,10(a2)
 move.w 14(a2),d0
 asr.w #1,d0
 move.w d0,14(a2)
L0354a move.w 8(a2),d0
 add.w d0,(a2)
 move.w 10(a2),d0
 add.w d0,2(a2)
 move.w (a2),d0
 asr.w #3,d0
 move.w d0,d4
 move.w 2(a2),d0
 asr.w #3,d0
 move.w d0,d5
 cmpi.w #4,d4
 blt.s L0357e
 cmpi.w #380,d4
 bge.s L0357e
 cmpi.w #4,d5
 blt.s L0357e
 cmpi.w #236,d5
 blt.s L03586
L0357e move.l a2,d0
 bsr.w L03472
 bra.s L035a8
L03586 movea.l D00028(a6),a0
 move.l 4038(a0),d0
 move.w d4,d1
 ext.l d1
 add.l d1,d0
 move.w #384,d1
 muls.w d5,d1
 add.l d1,d0
 move.l d0,4(a2)
 movea.l 4(a2),a0
 move.b 13(a2),(a0)
L035a8 movem.l -20(a5),a0/a2/d1/d4-d5
 unlk a5
 rts 
L035b2 link.w a5,#0
 movem.l a0/a2/d0/d4,-(sp)
 movea.l D00028(a6),a0
 movea.l 9964(a0),a2
 moveq #0,d4
 bra.s L035d4
L035c6 move.l a2,d0
 bsr.w L0350e
 addq.l #1,d4
 adda.l #18,a2
L035d4 moveq #75,d0
 cmp.l d4,d0
 bgt.s L035c6
 movem.l -12(a5),a0/a2/d4
 unlk a5
 rts 
L035e4 link.w a5,#0
 movem.l a0/a2/d0/d4,-(sp)
 movea.l D00028(a6),a0
 movea.l 9964(a0),a2
 moveq #0,d4
 bra.s L03606
L035f8 move.l a2,d0
 bsr.w L03472
 addq.l #1,d4
 adda.l #18,a2
L03606 moveq #75,d0
 cmp.l d4,d0
 bgt.s L035f8
 movem.l -12(a5),a0/a2/d4
 unlk a5
 rts 
L03616 link.w a5,#0
 movem.l a2/d0-d1/d4,-(sp)
 movea.l D0001e(a6),a2
 moveq #14,d4
 bra.s L03646
L03626 move.l d4,d0
 moveq #15,d1
 jsr _016a0(a6)
 move.b d0,(a2)
 move.l d4,d0
 moveq #15,d1
 jsr _016a0(a6)
 move.b d0,1(a2)
 move.b #239,2(a2)
 subq.l #1,d4
 addq.l #3,a2
L03646 tst.l d4
 bgt.s L03626
 moveq #0,d4
 bra.s L0366e
L0364e move.l d4,d0
 moveq #15,d1
 jsr _016a0(a6)
 move.b d0,(a2)
 move.l d4,d0
 moveq #15,d1
 jsr _016a0(a6)
 move.b d0,1(a2)
 move.b #239,2(a2)
 addq.l #1,d4
 addq.l #3,a2
L0366e moveq #15,d0
 cmp.l d4,d0
 bgt.s L0364e
 movem.l -12(a5),a2/d1/d4
 unlk a5
 rts 
L0367e link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 addq.w #1,_00c54(a6)
 cmpi.w #29,_00c54(a6)
 ble.s L03696
 clr.w _00c54(a6)
L03696 move.w _00c54(a6),d0
 ext.l d0
 moveq #29,d1
 sub.l d0,d1
 moveq #3,d0
 jsr _016a0(a6)
 movea.l D0001e(a6),a0
 pea (a0,d0.l)
 movea.w _00c54(a6),a0
 move.l a0,-(sp)
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 bsr.w L02672
 lea 16(sp),sp
 move.l D0001e(a6),-(sp)
 move.w _00c54(a6),d0
 ext.l d0
 moveq #29,d1
 sub.l d0,d1
 move.l d1,-(sp)
 movea.w _00c54(a6),a0
 move.l a0,-(sp)
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 bsr.w L02672
 lea 16(sp),sp
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 lea -12(sp),sp
 bsr.w L08238
 movea.l D00028(a6),a0
 movea.l D00028(a6),a1
 move.l 9836(a0),86(a1)
 movea.l D00028(a6),a0
 movea.l D00028(a6),a1
 move.l 4038(a0),126(a1)
 move.l #92160,-(sp)
 moveq #0,d1
 movea.l D00028(a6),a0
 move.l 4038(a0),d0
 jsr _016ac(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 move.l 5084(a0),D0001e(a6)
 pea (L00060).w
 moveq #0,d1
 move.l D0001e(a6),d0
 jsr _016ac(a6)
 addq.l #4,sp
 bsr.w L03616
 movea.l D00028(a6),a0
 clr.l 90(a0)
 movea.l D00028(a6),a0
 clr.l 130(a0)
 jsr _016be(a6)
 moveq #1,d1
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L037ca
 moveq #1,d0
 bra.s L037cc
L037ca moveq #0,d0
L037cc lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016ee(a6)
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #82,d0
 add.l D00028(a6),d0
 move.l d0,d1
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L037f6
 moveq #1,d0
 bra.s L037f8
L037f6 moveq #0,d0
L037f8 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 jsr _016dc(a6)
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #122,d0
 add.l D00028(a6),d0
 move.l d0,d1
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L03824
 moveq #1,d0
 bra.s L03826
L03824 moveq #0,d0
L03826 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016dc(a6)
 addq.l #8,sp
 pea (L00003).w
 pea (L00003).w
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L0384c
 moveq #1,d0
 bra.s L0384e
L0384c moveq #0,d0
L0384e lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 move.l D00028(a6),d0
 jsr _016d6(a6)
 addq.l #8,sp
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L03870
 moveq #1,d0
 bra.s L03872
L03870 moveq #0,d0
L03872 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 moveq #0,d0
 jsr _016e2(a6)
 pea (L00001).w
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L03894
 moveq #1,d0
 bra.s L03896
L03894 moveq #0,d0
L03896 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 move.l D00028(a6),d0
 jsr _016e8(a6)
 addq.l #4,sp
 move.l D00028(a6),-(sp)
 pea (L0003f).w
 moveq #0,d1
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L038c2
 moveq #1,d0
 bra.s L038c4
L038c2 moveq #0,d0
L038c4 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 jsr _016d0(a6)
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 pea (L0003f).w
 moveq #1,d1
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L038ec
 moveq #1,d0
 bra.s L038ee
L038ec moveq #0,d0
L038ee lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016d0(a6)
 addq.l #8,sp
 pea (L00008).w
 pea (L00001).w
 pea (L00001).w
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L03918
 moveq #1,d0
 bra.s L0391a
L03918 moveq #0,d0
L0391a lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 move.l D00028(a6),d0
 jsr _017a8(a6)
 lea 12(sp),sp
 move.l D0001e(a6),-(sp)
 pea (L00020).w
 clr.l -(sp)
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L03948
 moveq #1,d0
 bra.s L0394a
L03948 moveq #0,d0
L0394a lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L03962
 moveq #1,d0
 bra.s L03964
L03962 moveq #0,d0
L03964 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 bsr.w L02672
 lea 16(sp),sp
 pea _00c56(a6)
 pea (L00005).w
 pea (L00080).w
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L03998
 moveq #1,d0
 bra.s L0399a
L03998 moveq #0,d0
L0399a lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L039b2
 moveq #1,d0
 bra.s L039b4
L039b2 moveq #0,d0
L039b4 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 bsr.w L02672
 lea 16(sp),sp
 move.l D00028(a6),d0
 jsr _01874(a6)
 bsr.w L035e4
L039da pea (L00001).w
 moveq #1,d1
 movea.l D00028(a6),a0
 move.l 182(a0),d0
 jsr _016f4(a6)
 addq.l #4,sp
 moveq #1,d1
 cmp.l d0,d1
 bne.s L039da
 bsr.w L035b2
 tst.l _00c66(a6)
 bne.s L03a02
 bsr.w L0367e
L03a02 tst.l _00c66(a6)
 bne.s L03a0c
 moveq #1,d0
 bra.s L03a0e
L03a0c moveq #0,d0
L03a0e move.l d0,_00c66(a6)
 pea (sp)
 pea 8(sp)
 lea 16(sp),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01880(a6)
 addq.l #8,sp
 moveq #3,d0
 and.l 8(sp),d0
 beq.s L039da
 jsr _0187a(a6)
 lea 12(sp),sp
 movem.l -12(a5),a0-a1/d1
 unlk a5
 rts 
L03a46 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d5,-(sp)
 lea -12(sp),sp
 moveq #100,d0
 add.l D00028(a6),d0
 movea.l d0,a2
 move.l #140,d0
 add.l D00028(a6),d0
 movea.l d0,a3
 move.l #9988,d0
 add.l D00028(a6),d0
 movea.l d0,a4
 move.l #9980,d0
 add.l D00028(a6),d0
 move.l d0,d4
 move.l #9984,d0
 add.l D00028(a6),d0
 move.l d0,d5
 pea (sp)
 pea 8(sp)
 lea 16(sp),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01880(a6)
 addq.l #8,sp
 moveq #3,d0
 and.l 8(sp),d0
 beq.s L03af4
 pea (L00003).w
 pea (L00002).w
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 movea.w (a2),a0
 move.l a0,d1
 moveq #122,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 pea (L00003).w
 pea (L00002).w
 pea (L00001).w
 pea L08952(pc)
 clr.l -(sp)
 movea.w (a3),a0
 move.l a0,d1
 moveq #82,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 bra.w L03bc2
L03af4 movea.l d5,a0
 tst.l (a0)
 beq.s L03afe
 addq.w #1,(a2)
 addq.w #1,(a3)
L03afe movea.l d4,a0
 tst.l (a0)
 beq.s L03b08
 subq.w #1,(a2)
 subq.w #1,(a3)
L03b08 pea (L00001).w
 moveq #1,d1
 movea.l D00028(a6),a0
 move.l 182(a0),d0
 jsr _016f4(a6)
 addq.l #4,sp
 moveq #1,d1
 cmp.l d0,d1
 bne.s L03b08
 movea.l d5,a0
 tst.l (a0)
 bne.s L03b2e
 movea.l d4,a0
 tst.l (a0)
 beq.s L03b96
L03b2e move.l D00028(a6),-(sp)
 movea.w (a2),a0
 move.l a0,-(sp)
 moveq #0,d1
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 jsr _016d0(a6)
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 movea.w (a3),a0
 move.l a0,-(sp)
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016d0(a6)
 addq.l #8,sp
 cmpi.w #63,(a2)
 bne.s L03b86
 cmpi.w #63,(a3)
 bne.s L03b86
 movea.l d5,a0
 clr.l (a0)
L03b86 tst.w (a2)
 bne.s L03b96
 tst.w (a3)
 bne.s L03b96
 clr.l -(sp)
 lea L089d4(pc),a0
 bra.s L03bb6
L03b96 bsr.w L035b2
 move.l (a4),d0
 addq.l #1,d0
 move.l d0,(a4)
 cmpi.l #450,(a4)
 ble.s L03bb0
 movea.l d4,a0
 move.l #1,(a0)
L03bb0 clr.l -(sp)
 lea L03a46(pc),a0
L03bb6 move.l a0,d1
 move.l 16(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
L03bc2 lea 12(sp),sp
 movem.l -24(a5),a0/a2-a4/d4-d5
 unlk a5
 rts 
L03bd0 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 movea.l D00028(a6),a0
 movea.l D00028(a6),a1
 move.l 162(a0),86(a1)
 movea.l D00028(a6),a0
 movea.l D00028(a6),a1
 move.l 4038(a0),126(a1)
 move.l #92160,-(sp)
 moveq #0,d1
 movea.l D00028(a6),a0
 move.l 4038(a0),d0
 jsr _016ac(a6)
 addq.l #4,sp
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016ee(a6)
 movea.l D00028(a6),a0
 clr.l 90(a0)
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #82,d0
 add.l D00028(a6),d0
 move.l d0,d1
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 jsr _016dc(a6)
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #122,d0
 add.l D00028(a6),d0
 move.l d0,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016dc(a6)
 addq.l #8,sp
 pea (L00003).w
 pea (L00003).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 move.l D00028(a6),d0
 jsr _016d6(a6)
 addq.l #8,sp
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 moveq #0,d0
 jsr _016e2(a6)
 pea (L00008).w
 pea (L00001).w
 pea (L00001).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 move.l D00028(a6),d0
 jsr _017a8(a6)
 lea 12(sp),sp
 movea.l D00028(a6),a0
 movea.l 4830(a0),a0
 pea 4(a0)
 pea (L00080).w
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 bsr.w L02672
 lea 16(sp),sp
 pea _00c56(a6)
 pea (L00005).w
 pea (L00080).w
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 bsr.w L02672
 lea 16(sp),sp
 bsr.w L035e4
 movea.l D00028(a6),a0
 move.l #1,9984(a0)
 movea.l D00028(a6),a0
 clr.l 9980(a0)
 movea.l D00028(a6),a0
 clr.l 9988(a0)
 clr.l -(sp)
 lea L03a46(pc),a0
 move.l a0,d1
 move.l 4(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L03db2 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 jsr _016be(a6)
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 movea.l D00028(a6),a0
 move.l 162(a0),-(sp)
 moveq #0,d1
 move.l #5648,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 pea (L00800).w
 movea.l D00028(a6),a0
 move.l 4830(a0),-(sp)
 moveq #0,d1
 move.l #5956,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 movea.l D00028(a6),a0
 pea 5956(a0)
 clr.l -(sp)
 move.l #5648,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01700(a6)
 addq.l #8,sp
 jsr _01760(a6)
 clr.l -(sp)
 moveq #0,d1
 moveq #255,d0
 jsr _017c0(a6)
 addq.l #4,sp
 lea L03bd0(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6396(a1)
 movea.l D00028(a6),a0
 clr.l 6400(a0)
 andi.w #$febf,_011ba(a6)
 lea L03eda(pc),a0
 move.l a0,d1
 move.l #6188,d0
 add.l D00028(a6),d0
 jsr _0170c(a6)
 moveq #1,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01706(a6)
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016d0(a6)
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #0,d1
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 jsr _016d0(a6)
 addq.l #8,sp
 movea.l D00028(a6),a0
 clr.w 100(a0)
 movea.l D00028(a6),a0
 clr.w 140(a0)
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L03eda bcc.s L03f50
 dc.w $6300
L03ede link.w a5,#0
 movem.l a0-a2/d0-d1,-(sp)
 movea.l D00028(a6),a0
 movea.l 178(a0),a0
 movea.l 24(a0),a2
 bra.s L03f06
L03ef4 tst.w 50(a2)
 bne.s L03f02
 clr.l 26(a2)
 clr.l 18(a2)
L03f02 movea.l 56(a2),a2
L03f06 move.l a2,d0
 bne.s L03ef4
 movea.l _0166c(a6),a0
 movea.l D00028(a6),a1
 movea.l 5018(a1),a1
 movea.l 12(a1),a1
 move.l a0,14(a1)
 movea.l D00028(a6),a0
 clr.w 5634(a0)
 pea (L0000f).w
 lea L0584e(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 movea.l 5018(a0),a0
 move.l 12(a0),d0
 jsr _017fc(a6)
 addq.l #4,sp
 jsr _01760(a6)
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _017f0(a6)
L03f50 equ *-2
 andi.w #$feff,_011ba(a6)
 lea L059d9(pc),a0
 move.l a0,d1
 move.l #6188,d0
 add.l D00028(a6),d0
 jsr _0170c(a6)
 moveq #1,d0
 jsr _018c8(a6)
 movea.l D00028(a6),a0
 move.l #1,6412(a0)
 movem.l -16(a5),a0-a2/d1
 unlk a5
 rts 
L03f88 link.w a5,#0
 movem.l a0/a2/d0-d1/d4,-(sp)
 movea.l d0,a2
 movea.l D00028(a6),a0
 move.w 5610(a0),d4
 cmpi.w #5,d4
 ble.s L03fa2
 moveq #5,d4
L03fa2 movea.l D00028(a6),a0
 add.w d4,5108(a0)
 movea.l D00028(a6),a0
 sub.w d4,5610(a0)
 bsr.w L0336a
 addq.l #1,_00ce8(a6)
 movea.l D00028(a6),a0
 tst.w 5610(a0)
 bne.s L03fc8
 clr.l _00ce8(a6)
L03fc8 moveq #1,d0
 cmp.l _00ce8(a6),d0
 bge.s L03fe0
 pea (a2)
 moveq #3,d1
 moveq #0,d0
 bsr.w L077fe
 addq.l #4,sp
 clr.l _00ce8(a6)
L03fe0 movem.l -16(a5),a0/a2/d1/d4
 unlk a5
 rts 
L03fea link.w a5,#0
 movem.l a0/d0-d1/d4-d5,-(sp)
 move.l d0,d4
 move.l d1,d5
 subq.l #4,sp
 lea L03db2(pc),a0
 move.l a0,(sp)
 tst.l d5
 beq.s L04008
 lea L08952(pc),a0
 move.l a0,(sp)
L04008 movea.l D00028(a6),a0
 tst.w 100(a0)
 bne.s L04024
 pea (L00001).w
 move.l 4(sp),d1
 move.l d4,d0
 jsr _016a6(a6)
 addq.l #4,sp
 bra.s L04064
L04024 pea (L00003).w
 pea (L00002).w
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 moveq #63,d1
 moveq #122,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 pea (L00003).w
 pea (L00002).w
 pea (L00001).w
 move.l 12(sp),-(sp)
 clr.l -(sp)
 moveq #63,d1
 moveq #82,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
L04064 addq.l #4,sp
 movem.l -12(a5),a0/d4-d5
 unlk a5
 rts 
L04070 link.w a5,#0
 movem.l a0/d0-d1/d4,-(sp)
 move.l d0,d4
 jsr _01760(a6)
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _017f0(a6)
 move.l d4,-(sp)
 lea L03fea(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _01802(a6)
 addq.l #4,sp
 movem.l -12(a5),a0/d1/d4
 unlk a5
 rts 
L040aa link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 lea -12(sp),sp
 movea.l D00028(a6),a0
 movea.l 4822(a0),a0
 tst.w 4(a0)
 beq.s L040cc
 moveq #0,d1
 moveq #0,d0
 bsr.w L02f22
L040cc movea.l D00028(a6),a0
 movea.l 5018(a0),a0
 tst.w 34(a0)
 bgt.s L04100
 movea.l D00028(a6),a0
 tst.w 5620(a0)
 bne.s L04100
 bsr.w L03ede
 movea.l D00028(a6),a0
 movea.l 5018(a0),a0
 move.w #1,34(a0)
 movea.l D00028(a6),a0
 move.w #1,5630(a0)
L04100 movea.l D00028(a6),a0
 tst.w 5610(a0)
 beq.s L04116
 movea.l D00028(a6),a0
 move.l 5018(a0),d0
 bsr.w L03f88
L04116 movea.l D00028(a6),a0
 tst.w 5634(a0)
 beq.s L04170
 movea.l D00028(a6),a0
 addq.w #2,5576(a0)
 movea.l D00028(a6),a0
 cmpi.w #63,5576(a0)
 blt.s L04146
 movea.l D00028(a6),a0
 move.w #63,5576(a0)
 movea.l D00028(a6),a0
 clr.w 5634(a0)
L04146 move.l D00028(a6),-(sp)
 movea.l D00028(a6),a0
 movea.w 5576(a0),a0
 move.l a0,-(sp)
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016d0(a6)
 addq.l #8,sp
L04170 movea.l D00028(a6),a0
 tst.w 5012(a0)
 beq.s L041c4
 movea.l D00028(a6),a0
 addq.w #1,5014(a0)
 movea.l D00028(a6),a0
 cmpi.w #840,5014(a0)
 ble.s L04192
 moveq #0,d0
 bra.s L041c0
L04192 pea 4(sp)
 pea 12(sp)
 lea 8(sp),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01880(a6)
 addq.l #8,sp
 moveq #3,d0
 and.l (sp),d0
 beq.s L041c4
 movea.l D00028(a6),a0
 tst.w 5630(a0)
 bne.s L041c4
 moveq #1,d0
L041c0 bsr.w L04070
L041c4 lea 12(sp),sp
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
L041d2 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d6,-(sp)
 movea.l d0,a2
 lea -12(sp),sp
 movea.l D00028(a6),a0
 movea.l 6788(a0),a3
 moveq #22,d0
 add.l (a2),d0
 move.l d0,d4
 moveq #44,d0
 add.l a2,d0
 move.l d0,d6
 movea.l D00028(a6),a0
 tst.w 5016(a0)
 beq.w L042b6
 clr.l 4(sp)
 bra.w L042a4
L04208 movea.l 12(a3),a4
 move.l a4,d0
 beq.w L0429a
 cmpi.w #1,(a4)
 bne.w L0429a
 moveq #22,d0
 add.l (a2),d0
 move.l d0,d4
 move.l (a3),d5
 cmpi.w #4,26(a3)
 bne.s L0429a
 clr.l (sp)
 bra.s L04294
L0422e movea.l d6,a0
 move.w (a0),d0
 movea.l d4,a0
 add.w (a0),d0
 move.w d0,8(sp)
 movea.l d6,a0
 move.w 2(a0),d0
 movea.l d4,a0
 add.w 2(a0),d0
 move.w d0,10(sp)
 move.l d5,-(sp)
 pea 44(a3)
 movea.w 18(sp),a0
 move.l a0,d1
 movea.w 16(sp),a0
 move.l a0,d0
 jsr _018aa(a6)
 addq.l #8,sp
 tst.l d0
 beq.s L04290
 tst.b 48(a3)
 bne.s L0427c
 movea.l D00028(a6),a0
 tst.w 5632(a0)
 bne.s L0427c
 move.l a3,d0
 jsr _018a4(a6)
L0427c move.w 18(sp),d0
 sub.w d0,44(a2)
 move.w 58(sp),d0
 sub.w d0,46(a2)
 moveq #1,d0
 bra.s L042b8
L04290 addq.l #1,(sp)
 addq.l #4,d4
L04294 moveq #2,d0
 cmp.l (sp),d0
 bgt.s L0422e
L0429a addq.l #1,4(sp)
 adda.l #54,a3
L042a4 movea.l D00028(a6),a0
 move.w 6796(a0),d0
 ext.l d0
 cmp.l 4(sp),d0
 bgt.w L04208
L042b6 moveq #0,d0
L042b8 lea 12(sp),sp
 movem.l -28(a5),a0/a2-a4/d4-d6
 unlk a5
 rts 
L042c6 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 subq.l #8,sp
 moveq #22,d0
 add.l (a3),d0
 move.l d0,d5
 moveq #44,d0
 add.l a3,d0
 move.l d0,d7
 movea.l D00028(a6),a0
 move.l 6788(a0),(sp)
 movea.l d7,a0
 move.w 2(a0),d0
 movea.l d5,a0
 add.w 2(a0),d0
 move.w d0,6(sp)
 movea.l D00028(a6),a0
 pea 7852(a0)
 move.l a2,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _018ce(a6)
 addq.l #4,sp
 moveq #0,d4
 bra.s L04364
L04314 movea.l (sp),a0
 movea.l 12(a0),a4
 move.l a4,d0
 beq.s L0435c
 cmpi.w #1,(a4)
 bne.s L0435c
 movea.l (sp),a0
 moveq #22,d0
 add.l (a0),d0
 move.l d0,d6
 movea.l (sp),a0
 move.w 46(a0),d0
 ext.l d0
 movea.l d6,a0
 move.w 2(a0),d1
 ext.l d1
 add.l d1,d0
 move.w 6(sp),d1
 ext.l d1
 cmp.l d1,d0
 ble.s L0435c
 move.l 12(a3),-(sp)
 move.l a4,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _018d4(a6)
 addq.l #4,sp
L0435c addq.l #1,d4
 addi.l #$00000036,(sp)
L04364 movea.l D00028(a6),a0
 move.w 6796(a0),d0
 ext.l d0
 cmp.l d4,d0
 bgt.s L04314
 addq.l #8,sp
 movem.l -32(a5),a0/a2-a4/d4-d7
 unlk a5
 rts 
L0437e link.w a5,#0
 movem.l a0/a2-a4/d0-d2/d4-d7,-(sp)
 movea.l d0,a2
 lea -18(sp),sp
 movea.l 12(a2),a3
 moveq #22,d0
 add.l (a2),d0
 movea.l d0,a4
 movea.l D00028(a6),a0
 move.l 5582(a0),14(sp)
 clr.l 4(sp)
 moveq #1,d0
 move.l d0,(sp)
 movea.l D00028(a6),a0
 tst.w 5618(a0)
 bne.w L0454a
 move.l a3,d1
 move.l a2,d0
 jsr _0169a(a6)
 moveq #0,d4
 bra.w L04542
L043c2 tst.l 14(sp)
 beq.w L044a8
 movea.w 72(sp),a0
 move.l a0,-(sp)
 movea.w 28(sp),a0
 move.l a0,-(sp)
 move.l (a2),d1
 moveq #44,d0
 add.l a2,d0
 jsr _018b6(a6)
 addq.l #8,sp
 movea.l 14(sp),a0
 move.l (a0),d7
 bra.w L04484
L043ec clr.l (sp)
 movea.l 14(sp),a0
 move.w 44(a0),d0
 ext.l d0
 moveq #16,d1
 add.l d1,d0
 move.w 10(sp),d1
 ext.l d1
 cmp.l d1,d0
 ble.s L0440c
 addq.w #4,44(a2)
 bra.s L04432
L0440c movea.l 14(sp),a0
 move.w 44(a0),d0
 ext.l d0
 movea.l d7,a0
 move.w 2(a0),d1
 ext.l d1
 moveq #16,d2
 sub.l d2,d1
 add.l d1,d0
 move.w 10(sp),d1
 ext.l d1
 cmp.l d1,d0
 bge.s L0443c
 subq.w #4,44(a2)
L04432 moveq #1,d0
 move.l d0,(sp)
 moveq #1,d0
 move.l d0,4(sp)
L0443c movea.l 14(sp),a0
 move.w 46(a0),d0
 ext.l d0
 addq.l #2,d0
 move.w 12(sp),d1
 ext.l d1
 cmp.l d1,d0
 ble.s L04458
 addq.w #4,46(a2)
 bra.s L0447a
L04458 movea.l 14(sp),a0
 move.w 46(a0),d0
 ext.l d0
 movea.l d7,a0
 move.w (a0),d1
 ext.l d1
 subq.l #2,d1
 add.l d1,d0
 move.w 12(sp),d1
 ext.l d1
 cmp.l d1,d0
 bge.s L04484
 subq.w #4,46(a2)
L0447a moveq #1,d0
 move.l d0,(sp)
 moveq #1,d0
 move.l d0,4(sp)
L04484 move.w (a4),d0
 add.w 44(a2),d0
 move.w d0,10(sp)
 move.w 2(a4),d0
 add.w 46(a2),d0
 move.w d0,12(sp)
 tst.l (sp)
 bne.w L043ec
 move.l 4(sp),d0
 bra.w L0455e
L044a8 movea.l D00028(a6),a0
 move.l 4792(a0),d0
 add.l 2(a3),d0
 move.w (a4),d1
 ext.l d1
 add.l d1,d0
 move.w #384,d1
 muls.w 2(a4),d1
 add.l d1,d0
 move.l d0,d5
 movea.l d5,a0
 move.w (a0),d0
 lsr.w #8,d0
 move.b d0,9(sp)
 cmpi.b #5,9(sp)
 beq.s L0452a
 cmpi.b #7,9(sp)
 beq.s L0452a
 cmpi.b #6,9(sp)
 bne.s L0453e
 movea.l D00028(a6),a0
 tst.w 5628(a0)
 bne.s L0452a
 moveq #2,d0
 bsr.w L0088c
 move.l d0,d6
 moveq #4,d0
 cmp.l d6,d0
 bne.s L04526
 move.w 24(sp),d0
 ext.l d0
 divs.w #3,d0
 sub.w d0,44(a2)
 move.w 72(sp),d0
 bge.s L04516
 addq.w #1,d0
L04516 asr.w #1,d0
 sub.w d0,46(a2)
 andi.w #$fffe,44(a2)
 moveq #0,d0
 bra.s L0455e
L04526 tst.l d6
 bne.s L0453e
L0452a move.w 24(sp),d0
 sub.w d0,44(a2)
 move.w 72(sp),d0
 sub.w d0,46(a2)
 moveq #2,d0
 bra.s L0455e
L0453e addq.l #1,d4
 addq.l #4,a4
L04542 moveq #2,d0
 cmp.l d4,d0
 bgt.w L043c2
L0454a movea.w 72(sp),a0
 move.l a0,-(sp)
 movea.w 28(sp),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L041d2
 addq.l #4,sp
L0455e lea 18(sp),sp
 movem.l -36(a5),a0/a2-a4/d2/d4-d7
 unlk a5
 rts 
L0456c link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l 44(sp),d4
 move.l 48(sp),d5
 move.l 52(sp),d6
 move.l 56(sp),d7
 subq.l #4,sp
 clr.w (sp)
 clr.w 2(sp)
 bra.s L045f0
L04592 pea (sp)
 pea (a3)
 ext.l d4
 move.l d4,-(sp)
 movea.w 82(sp),a0
 move.l a0,-(sp)
 movea.w 82(sp),a0
 move.l a0,d1
 ext.l d7
 move.l d7,d0
 bsr.w L048a4
 lea 16(sp),sp
 ext.l d6
 move.l d6,-(sp)
 ext.l d5
 move.l d5,d1
 move.l a2,d0
 bsr.w L0437e
 addq.l #4,sp
 tst.l d0
 bne.s L045ca
 moveq #1,d0
 bra.s L045fc
L045ca pea (sp)
 pea (a3)
 ext.l d4
 move.l d4,-(sp)
 movea.w 82(sp),a0
 move.l a0,-(sp)
 movea.w 82(sp),a0
 move.l a0,d1
 ext.l d7
 move.l d7,d0
 bsr.w L048a4
 lea 16(sp),sp
 clr.w (sp)
 addq.w #1,2(sp)
L045f0 move.w 2(sp),d0
 cmp.w 74(sp),d0
 blt.s L04592
 moveq #0,d0
L045fc addq.l #4,sp
 movem.l -28(a5),a0/a2-a3/d4-d7
 unlk a5
 rts 
L04608 link.w a5,#0
 movem.l a0/a2/d0-d1/d4-d6,-(sp)
 movea.l d0,a2
 move.w 44(a2),d4
 move.w 46(a2),d5
 moveq #0,d6
 bra.w L046f8
L04620 move.l d6,-(sp)
 clr.l -(sp)
 clr.l -(sp)
 movea.l D00028(a6),a0
 movea.w 5588(a0),a0
 move.l a0,-(sp)
 pea (Lfffffffffffffffe).w
 clr.l -(sp)
 pea (Lfffffffffffffffe).w
 moveq #46,d0
 add.l a2,d0
 move.l d0,d1
 move.l a2,d0
 bsr.w L0456c
 lea 28(sp),sp
 tst.l d0
 bne.w L0470a
 move.w d5,46(a2)
 move.l d6,-(sp)
 pea (L00002).w
 pea (L00001).w
 movea.l D00028(a6),a0
 movea.w 5592(a0),a0
 move.l a0,-(sp)
 pea (L00002).w
 clr.l -(sp)
 pea (L00002).w
 moveq #46,d0
 add.l a2,d0
 move.l d0,d1
 move.l a2,d0
 bsr.w L0456c
 lea 28(sp),sp
 tst.l d0
 bne.w L0470a
 move.w d5,46(a2)
 move.l d6,-(sp)
 pea (L00001).w
 pea (L00001).w
 movea.l D00028(a6),a0
 movea.w 5590(a0),a0
 move.l a0,-(sp)
 clr.l -(sp)
 pea (L00002).w
 pea (L00002).w
 moveq #44,d0
 add.l a2,d0
 move.l d0,d1
 move.l a2,d0
 bsr.w L0456c
 lea 28(sp),sp
 tst.l d0
 bne.s L0470a
 move.w d4,44(a2)
 move.l d6,-(sp)
 pea (L00003).w
 clr.l -(sp)
 movea.l D00028(a6),a0
 movea.w 5586(a0),a0
 move.l a0,-(sp)
 clr.l -(sp)
 pea (Lfffffffffffffffe).w
 pea (Lfffffffffffffffe).w
 moveq #44,d0
 add.l a2,d0
 move.l d0,d1
 move.l a2,d0
 bsr.w L0456c
 lea 28(sp),sp
 tst.l d0
 bne.s L0470a
 move.w d4,44(a2)
 addq.l #1,d6
L046f8 moveq #16,d0
 cmp.l d6,d0
 bgt.w L04620
 movea.l D00028(a6),a0
 move.w #1,5646(a0)
L0470a movem.l -24(a5),a0/a2/d1/d4-d6
 unlk a5
 rts 
L04714 link.w a5,#0
 movem.l a0/a2/d0-d1,-(sp)
 movea.l D00028(a6),a0
 movea.l 5018(a0),a2
 movea.l D00028(a6),a0
 move.w #1,5628(a0)
 clr.l -(sp)
 moveq #0,d1
 move.l a2,d0
 bsr.w L0437e
 addq.l #4,sp
 moveq #2,d1
 cmp.l d0,d1
 bne.s L04746
 move.l a2,d0
 bsr.w L04608
L04746 movea.l D00028(a6),a0
 clr.w 5628(a0)
 movem.l -12(a5),a0/a2/d1
 unlk a5
 rts 
L04758 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
 movea.l 46(a2),a3
 addq.w #1,42(a3)
 addq.l #1,d4
 moveq #5,d0
 cmp.l d4,d0
 bgt.s L047b0
 movea.l _0166c(a6),a0
 cmpa.l 14(a2),a0
 bne.s L04784
 movea.l _01888(a6),a0
 bra.s L04788
L04784 movea.l _0166c(a6),a0
L04788 move.l a0,14(a2)
 tst.w _00cec(a6)
 bne.s L0479e
 clr.l -(sp)
 moveq #2,d1
 moveq #0,d0
 bsr.w L077fe
 addq.l #4,sp
L0479e tst.w _00cec(a6)
 bne.s L047a8
 moveq #1,d0
 bra.s L047aa
L047a8 moveq #0,d0
L047aa move.w d0,_00cec(a6)
 moveq #0,d4
L047b0 cmpi.w #30,42(a3)
 bls.s L047e2
 movea.l _0166c(a6),a0
 move.l a0,14(a2)
 movea.l D00028(a6),a0
 movea.w 5644(a0),a0
 move.l a0,d0
 bsr.w L008c6
 moveq #1,d1
 cmp.l d0,d1
 bne.s L047e2
 movea.l D00028(a6),a0
 movea.w 5644(a0),a0
 move.l a0,d0
 bsr.w L04876
L047e2 move.l d4,-(sp)
 lea L04758(pc),a0
 move.l a0,d1
 move.l 12(a3),d0
 jsr _017fc(a6)
 addq.l #4,sp
 movem.l -16(a5),a0/a2-a3/d4
 unlk a5
 rts 
L047fe link.w a5,#0
L04800 equ *-2
 movem.l a0/a2-a4/d0-d1,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 movea.l 46(a2),a4
 addq.w #1,42(a4)
 movea.l _0166c(a6),a0
 cmpa.l 14(a2),a0
 bne.s L04822
 movea.l _01888(a6),a0
 bra.s L04826
L04822 movea.l _0166c(a6),a0
L04826 move.l a0,14(a2)
 cmpi.w #10,42(a4)
 bls.s L0486c
 movea.l _0166c(a6),a0
 move.l a0,14(a2)
 movea.l D00028(a6),a0
 clr.b 5094(a0)
 movea.l D00028(a6),a0
 tst.w 5646(a0)
 beq.s L0486c
 movea.l D00028(a6),a0
 movea.w 5644(a0),a0
 move.l a0,d0
 bsr.w L008c6
 moveq #1,d1
 cmp.l d0,d1
 bne.s L0486c
 movea.l D00028(a6),a0
 movea.w 5644(a0),a0
 move.l a0,d0
 bsr.s L04876
L0486c movem.l -16(a5),a0/a2-a4
 unlk a5
 rts 
L04876 link.w a5,#0
 movem.l a0/d0-d1/d4,-(sp)
 move.l d0,d4
 clr.l -(sp)
 moveq #0,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _01802(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 move.w d4,5612(a0)
 movem.l -12(a5),a0/d1/d4
 unlk a5
 rts 
L048a4 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4-d7,-(sp)
 move.l d0,d4
 move.l d1,d5
 move.l 44(sp),d6
 move.l 48(sp),d7
 movea.l 52(sp),a2
 movea.l 56(sp),a3
 subq.l #4,sp
 clr.l (sp)
 move.w d7,d0
 add.w d0,(a2)
 movea.l D00028(a6),a0
 move.w #1,5088(a0)
 bra.s L048ec
L048d4 move.w (a2),d0
 ext.l d0
 cmp.l d4,d0
 bge.s L048f8
 bra.s L048e6
L048de move.w (a2),d0
 ext.l d0
 cmp.l d4,d0
 ble.s L048f8
L048e6 moveq #1,d0
 move.l d0,(sp)
 bra.s L048f8
L048ec tst.l d5
 beq.s L048d4
 cmpi.l #1,d5
 beq.s L048de
L048f8 tst.l (sp)
 beq.s L04938
 move.w d7,d0
 sub.w d0,(a2)
 move.w (a3),d0
 addq.w #1,d0
 move.w d0,(a3)
 cmpi.w #4,(a3)
 ble.s L04938
 movea.l D00028(a6),a0
 tst.w 5630(a0)
 bne.s L04938
 movea.l D00028(a6),a0
 tst.l 5582(a0)
 bne.s L04938
 clr.w (a3)
 move.l d6,d0
 bsr.w L008c6
 moveq #1,d1
 cmp.l d0,d1
 bne.s L04938
 move.l d6,d0
 bsr.w L04876
 moveq #1,d0
 bra.s L0493a
L04938 moveq #0,d0
L0493a addq.l #4,sp
 movem.l -28(a5),a0/a2-a3/d4-d7
 unlk a5
 rts 
L04946 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
 movea.l 32(sp),a3
 movea.l D00028(a6),a0
 btst.b #0,5623(a0)
 beq.s L049b4
 movea.l D00028(a6),a0
 tst.w 5620(a0)
 bne.s L049b4
 move.b (a3),d0
 ext.w d0
 ext.l d0
 cmp.l d4,d0
 beq.s L049b4
 move.b (a2),d0
 ext.w d0
 ext.l d0
 lea _00cde(a6),a0
 move.b (a0,d0.l),d0
 ext.w d0
 ext.l d0
 cmp.l d4,d0
 bne.s L049b0
 move.b (a2),d0
 addq.b #1,d0
 move.b d0,(a2)
 cmpi.b #10,(a2)
 blt.s L049b2
 movea.l D00028(a6),a0
 move.w #1,5620(a0)
 clr.l -(sp)
 moveq #2,d1
 moveq #0,d0
 bsr.w L077fe
 addq.l #4,sp
 bra.s L049b2
L049b0 clr.b (a2)
L049b2 move.b d4,(a3)
L049b4 movem.l -16(a5),a0/a2-a3/d4
 unlk a5
 rts 
L049be link.w a5,#0
 movem.l a0/a2/d0-d1,-(sp)
 movea.l d0,a2
 tst.l _00cee(a6)
 bne.s L049d2
 moveq #1,d0
 bra.s L049d4
L049d2 moveq #0,d0
L049d4 move.l d0,_00cee(a6)
 tst.l _00cee(a6)
 beq.s L04a42
 addi.w #$000a,34(a2)
 movea.l D00028(a6),a0
 move.w 34(a2),d0
 cmp.w 5106(a0),d0
 ble.s L049fc
 movea.l D00028(a6),a0
 move.w 5106(a0),34(a2)
L049fc bsr.w L0307a
 tst.l _00cf2(a6)
 bne.s L04a12
 clr.l -(sp)
 moveq #2,d1
 moveq #0,d0
 bsr.w L077fe
 addq.l #4,sp
L04a12 tst.l _00cf2(a6)
 bne.s L04a1c
 moveq #1,d0
 bra.s L04a1e
L04a1c moveq #0,d0
L04a1e move.l d0,_00cf2(a6)
 movea.l D00028(a6),a0
 move.w 34(a2),d0
 cmp.w 5106(a0),d0
 bne.s L04a42
 movea.l D00028(a6),a0
 clr.b 5579(a0)
 movea.l D00028(a6),a0
 move.w #1,5570(a0)
L04a42 movem.l -12(a5),a0/a2/d1
 unlk a5
 rts 
L04a4c link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 movea.l 48(sp),a4
 move.l 52(sp),d4
 move.l 56(sp),d5
 move.l 60(sp),d6
 subq.l #2,sp
 move.l _00cd0(a6),d7
 clr.w (sp)
 movea.l d4,a0
 clr.w (a0)
 clr.b (a4)
 cmp.l (a2),d7
 beq.s L04ac8
 cmp.l (a2),d7
 bcc.s L04a82
 subq.l #2,(a2)
 bra.s L04a84
L04a82 addq.l #2,(a2)
L04a84 pea (sp)
 pea (a3)
 movea.l (a2),a0
 movea.w (a0),a0
 move.l a0,-(sp)
 movea.w 88(sp),a0
 move.l a0,-(sp)
 movea.w 88(sp),a0
 move.l a0,d1
 movea.w 84(sp),a0
 move.l a0,d0
 bsr.w L048a4
 lea 16(sp),sp
 cmpi.w #1,d5
 bne.s L04ab8
 movea.l (a2),a0
 movea.w (a0),a0
 move.l a0,-(sp)
 moveq #0,d1
 bra.s L04ac0
L04ab8 clr.l -(sp)
 movea.l (a2),a0
 movea.w (a0),a0
 move.l a0,d1
L04ac0 move.l d6,d0
 bsr.w L0437e
 addq.l #4,sp
L04ac8 addq.l #2,sp
 movem.l -32(a5),a0/a2-a4/d4-d7
 unlk a5
 rts 
L04ad4 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l 48(sp),d4
 movea.l 52(sp),a4
 move.l 56(sp),d5
 move.l 60(sp),d6
 move.l 64(sp),d7
 subq.l #2,sp
 clr.w (sp)
 movea.l D00028(a6),a0
 tst.w 5608(a0)
 beq.s L04b24
 cmp.b (a4),d4
 bne.s L04b0a
 tst.b (a3)
 bne.s L04b24
L04b0a move.b d4,d0
 ext.w d0
 ext.l d0
 lsl.l #1,d0
 add.l d0,(a2)
 move.b d4,(a4)
 clr.b (a3)
 movea.l (a2),a0
 cmpi.w #99,(a0)
 bne.s L04b28
 move.b #1,(a3)
L04b24 moveq #0,d0
 bra.s L04b78
L04b28 pea (sp)
 move.l d5,-(sp)
 movea.l (a2),a0
 movea.w (a0),a0
 move.l a0,-(sp)
 movea.w 92(sp),a0
 move.l a0,-(sp)
 movea.w 92(sp),a0
 move.l a0,d1
 movea.w 88(sp),a0
 move.l a0,d0
 bsr.w L048a4
 lea 16(sp),sp
 cmpi.w #1,d6
 bne.s L04b5c
 movea.l (a2),a0
 movea.w (a0),a0
 move.l a0,-(sp)
 moveq #0,d1
 bra.s L04b64
L04b5c clr.l -(sp)
 movea.l (a2),a0
 movea.w (a0),a0
 move.l a0,d1
L04b64 move.l d7,d0
 bsr.w L0437e
 addq.l #4,sp
 movea.l D00028(a6),a0
 move.w #1,5088(a0)
 moveq #1,d0
L04b78 addq.l #2,sp
 movem.l -32(a5),a0/a2-a4/d4-d7
 unlk a5
 rts 
L04b84 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d6,-(sp)
 movea.l d0,a2
 move.l d1,d4
 lea -12(sp),sp
 movea.l D00028(a6),a0
 movea.l 5018(a0),a3
 movea.l (a3),a4
 move.l 4(a3),d5
 movea.l D00028(a6),a0
 move.w 5608(a0),d6
 pea (sp)
 pea 8(sp)
 lea 16(sp),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01880(a6)
 addq.l #8,sp
 clr.w _00cf8(a6)
 clr.w _00cfa(a6)
 movea.l D00028(a6),a0
 clr.w 5088(a0)
 move.l a3,d1
 move.l a2,d0
 bsr.w L042c6
 movea.l D00028(a6),a0
 tst.b 5094(a0)
 beq.s L04bee
 moveq #0,d1
 move.l a2,d0
 bsr.w L047fe
L04bee movea.l D00028(a6),a0
 tst.w 5100(a0)
 beq.s L04c04
 move.l d4,d1
 move.l a2,d0
 bsr.w L053b0
 bra.w L04cae
L04c04 movea.l D00028(a6),a0
 tst.w 5012(a0)
 beq.s L04c2e
 movea.l D00028(a6),a0
 tst.b 5094(a0)
 bne.w L04cae
 pea (L00001).w
 movea.l _018b2(a6),a0
 move.l a0,d1
 move.l a2,d0
 jsr _017fc(a6)
 bra.w L04cac
L04c2e movea.l D00028(a6),a0
 tst.b 5579(a0)
 beq.s L04c3e
 move.l a3,d0
 bsr.w L049be
L04c3e movea.l D00028(a6),a0
 tst.w 5570(a0)
 beq.s L04cae
 movea.l D00028(a6),a0
 tst.b 5095(a0)
 beq.s L04c5c
 movea.l D00028(a6),a0
 clr.b 5095(a0)
 bra.s L04c8c
L04c5c btst.b #0,11(sp)
 beq.s L04c8c
 bsr.w L05412
 movea.l D00028(a6),a0
 clr.w 5638(a0)
 movea.l D00028(a6),a0
 tst.w 5636(a0)
 beq.s L04cae
 moveq #0,d1
 moveq #0,d0
 bsr.w L080b8
 movea.l D00028(a6),a0
 clr.w 5636(a0)
 bra.s L04cae
L04c8c btst.b #1,11(sp)
 beq.s L04cb6
 btst.b #0,11(sp)
 bne.s L04cb6
 pea L0a876(pc)
 lea L0ad44(pc),a0
 move.l a0,d1
 moveq #0,d0
 jsr _016a6(a6)
L04cac addq.l #4,sp
L04cae lea 12(sp),sp
 bra.w L0514e
L04cb6 move.w _00cda(a6),d0
 ext.l d0
 moveq #30,d1
 sub.l d0,d1
 cmp.l (sp),d1
 bge.s L04cd2
 move.w _00cda(a6),d0
 ext.l d0
 moveq #30,d1
 add.l d1,d0
 cmp.l (sp),d0
 bgt.s L04cfe
L04cd2 move.w _00cdc(a6),d0
 ext.l d0
 moveq #30,d1
 sub.l d0,d1
 cmp.l 4(sp),d1
 bge.s L04cf2
 move.w _00cdc(a6),d0
 ext.l d0
 moveq #30,d1
 add.l d1,d0
 cmp.l 4(sp),d0
 bgt.s L04cfe
L04cf2 movea.l D00028(a6),a0
 move.w #1,5632(a0)
 bra.s L04d06
L04cfe movea.l D00028(a6),a0
 clr.w 5632(a0)
L04d06 move.w _00cda(a6),d0
 ext.l d0
 moveq #30,d1
 sub.l d0,d1
 cmp.l (sp),d1
 blt.w L04db0
 clr.l -(sp)
 clr.l -(sp)
 movea.l D00028(a6),a0
 movea.w 5588(a0),a0
 move.l a0,-(sp)
 pea (a3)
 pea (L00001).w
 pea 46(a3)
 movea.l D00028(a6),a0
 pea 5604(a0)
 pea (Lffffffffffffffff).w
 move.l #5602,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5594,d0
 add.l D00028(a6),d0
 bsr.w L04ad4
 lea 32(sp),sp
 tst.l d0
 bne.s L04d8c
 pea D00022(a6)
 pea 46(a3)
 pea (Lfffffffffffffffb).w
 clr.l -(sp)
 moveq #0,d1
 movea.l D00028(a6),a0
 movea.w 5588(a0),a0
 move.l a0,d0
 bsr.w L048a4
 lea 16(sp),sp
 pea (Lfffffffffffffffb).w
 moveq #0,d1
 move.l a3,d0
 bsr.w L0437e
 addq.l #4,sp
L04d8c move.w #1,_00cf8(a6)
 move.l 6(a4),d5
 clr.w 24(a3)
 clr.w D00024(a6)
 pea _00cf7(a6)
 moveq #0,d1
 lea _00cf6(a6),a0
 move.l a0,d0
 bsr.w L04946
 addq.l #4,sp
L04db0 move.w _00cda(a6),d0
 ext.l d0
 moveq #30,d1
 add.l d1,d0
 cmp.l (sp),d0
 bgt.w L04e6c
 pea (L00002).w
 pea (L00001).w
 movea.l D00028(a6),a0
 movea.w 5592(a0),a0
 move.l a0,-(sp)
 pea (a3)
 pea (L00001).w
 pea 46(a3)
 movea.l D00028(a6),a0
 pea 5604(a0)
 pea (L00001).w
 move.l #5602,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5594,d0
 add.l D00028(a6),d0
 bsr.w L04ad4
 lea 32(sp),sp
 tst.l d0
 bne.s L04e2e
 pea D00022(a6)
 pea 46(a3)
 pea (L00005).w
 pea (L00002).w
 moveq #1,d1
 movea.l D00028(a6),a0
 movea.w 5592(a0),a0
 move.l a0,d0
 bsr.w L048a4
 lea 16(sp),sp
L04e2e pea (L00005).w
 moveq #0,d1
 move.l a3,d0
 bsr.w L0437e
 addq.l #4,sp
 move.w #1,_00cf8(a6)
 move.w #2,D00024(a6)
 move.l #144,d0
 add.l 6(a4),d0
 move.l d0,d5
 move.w #2,24(a3)
 pea _00cf7(a6)
 moveq #2,d1
 lea _00cf6(a6),a0
 move.l a0,d0
 bsr.w L04946
 addq.l #4,sp
L04e6c move.w _00cdc(a6),d0
 ext.l d0
 moveq #30,d1
 sub.l d0,d1
 cmp.l 4(sp),d1
 blt.w L04f24
 pea (L00003).w
 clr.l -(sp)
 movea.l D00028(a6),a0
 movea.w 5586(a0),a0
 move.l a0,-(sp)
 pea (a3)
 clr.l -(sp)
 pea 44(a3)
 movea.l D00028(a6),a0
 pea 5606(a0)
 pea (Lffffffffffffffff).w
 move.l #5603,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5598,d0
 add.l D00028(a6),d0
 bsr.w L04ad4
 lea 32(sp),sp
 tst.l d0
 bne.s L04ee8
 pea D00022(a6)
 pea 44(a3)
 pea (Lfffffffffffffffa).w
 pea (L00003).w
 moveq #0,d1
 movea.l D00028(a6),a0
 movea.w 5586(a0),a0
 move.l a0,d0
 bsr.w L048a4
 lea 16(sp),sp
L04ee8 clr.l -(sp)
 moveq #250,d1
 move.l a3,d0
 bsr.w L0437e
 addq.l #4,sp
 move.w #1,_00cfa(a6)
 move.w #3,D00026(a6)
 move.l #216,d0
 add.l 6(a4),d0
 move.l d0,d5
 move.w #3,24(a3)
 pea _00cf7(a6)
 moveq #3,d1
 lea _00cf6(a6),a0
 move.l a0,d0
 bsr.w L04946
 addq.l #4,sp
L04f24 move.w _00cdc(a6),d0
 ext.l d0
 moveq #30,d1
 add.l d1,d0
 cmp.l 4(sp),d0
 bgt.w L04fda
 pea (L00001).w
 pea (L00001).w
 movea.l D00028(a6),a0
 movea.w 5590(a0),a0
 move.l a0,-(sp)
 pea (a3)
 clr.l -(sp)
 pea 44(a3)
 movea.l D00028(a6),a0
 pea 5606(a0)
 pea (L00001).w
 move.l #5603,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5598,d0
 add.l D00028(a6),d0
 bsr.w L04ad4
 lea 32(sp),sp
 tst.l d0
 bne.s L04fa2
 pea D00022(a6)
 pea 44(a3)
 pea (L00006).w
 pea (L00001).w
 moveq #1,d1
 movea.l D00028(a6),a0
 movea.w 5590(a0),a0
 move.l a0,d0
 bsr.w L048a4
 lea 16(sp),sp
L04fa2 clr.l -(sp)
 moveq #6,d1
 move.l a3,d0
 bsr.w L0437e
 addq.l #4,sp
 move.w #1,_00cfa(a6)
 move.w #1,D00026(a6)
 moveq #72,d0
 add.l 6(a4),d0
 move.l d0,d5
 move.w #1,24(a3)
 pea _00cf7(a6)
 moveq #1,d1
 lea _00cf6(a6),a0
 move.l a0,d0
 bsr.w L04946
 addq.l #4,sp
L04fda movea.l D00028(a6),a0
 tst.w 5088(a0)
 beq.s L05028
 move.l a2,d1
 move.l d5,d0
 jsr _01898(a6)
 move.l a2,d1
 move.l a3,d0
 jsr _0169a(a6)
 pea (L0001e).w
 moveq #30,d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
L05000 equ *-2
 jsr _017d2(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 clr.w 5638(a0)
 movea.l D00028(a6),a0
 tst.w 5636(a0)
 beq.s L0505c
 movea.l D00028(a6),a0
 clr.w 5636(a0)
 moveq #0,d1
 moveq #0,d0
 bra.s L05058
L05028 clr.w D00022(a6)
 movea.l D00028(a6),a0
 tst.w 5636(a0)
 bne.s L0505c
 movea.l D00028(a6),a0
 addq.w #1,5638(a0)
 movea.l D00028(a6),a0
 cmpi.w #2880,5638(a0)
 ble.s L0505c
 movea.l D00028(a6),a0
 move.w #1,5636(a0)
 moveq #0,d1
 moveq #1,d0
L05058 bsr.w L080b8
L0505c tst.w d6
 beq.w L05134
 tst.w _00cf8(a6)
 bne.s L050ca
 tst.w D00024(a6)
 bne.s L0507c
 clr.l -(sp)
 clr.l -(sp)
 movea.l D00028(a6),a0
 movea.w 5588(a0),a0
 bra.s L0508c
L0507c pea (L00002).w
 pea (L00001).w
 movea.l D00028(a6),a0
 movea.w 5592(a0),a0
L0508c move.l a0,-(sp)
 pea (a3)
 pea (L00001).w
 movea.l D00028(a6),a0
 pea 5604(a0)
 movea.l D00028(a6),a0
 pea 5602(a0)
 movea.l D00028(a6),a0
 moveq #46,d0
 add.l 5018(a0),d0
 move.l d0,d1
 move.l #5594,d0
 add.l D00028(a6),d0
 bsr.w L04a4c
 lea 28(sp),sp
 move.l a2,d1
 move.l a3,d0
 jsr _0169a(a6)
L050ca tst.w _00cfa(a6)
 bne.s L05134
 cmpi.w #3,D00026(a6)
 bne.s L050e8
 pea (L00003).w
 clr.l -(sp)
 movea.l D00028(a6),a0
 movea.w 5586(a0),a0
 bra.s L050f8
L050e8 pea (L00001).w
 pea (L00001).w
 movea.l D00028(a6),a0
 movea.w 5590(a0),a0
L050f8 move.l a0,-(sp)
 pea (a3)
 clr.l -(sp)
 movea.l D00028(a6),a0
 pea 5606(a0)
 movea.l D00028(a6),a0
 pea 5603(a0)
 movea.l D00028(a6),a0
 moveq #44,d0
 add.l 5018(a0),d0
 move.l d0,d1
 move.l #5598,d0
 add.l D00028(a6),d0
 bsr.w L04a4c
 lea 28(sp),sp
 move.l a2,d1
 move.l a3,d0
 jsr _0169a(a6)
L05134 movea.l D00028(a6),a0
 tst.w 5100(a0)
 bne.s L0514a
 movea.l D00028(a6),a0
 movea.l 5018(a0),a0
 move.l d5,4(a0)
L0514a lea 12(sp),sp
L0514e movem.l -28(a5),a0/a2-a4/d4-d6
 unlk a5
 rts 
L05158 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4,-(sp)
 movea.l D00028(a6),a0
 move.l 4810(a0),d0
 jsr _017e4(a6)
 lea L059dc(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 4868(a0),d0
 jsr _017de(a6)
 movea.l D00028(a6),a0
 move.l d0,5018(a0)
 movea.l D00028(a6),a0
 movea.l 5018(a0),a2
 lea L059e5(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 4868(a0),d0
 jsr _017de(a6)
 move.l d0,(a2)
 movea.l d0,a3
 lea L059ee(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 4868(a0),d0
 jsr _017de(a6)
 move.l d0,6(a3)
 movea.l (a2),a0
 move.l 6(a0),4(a2)
 move.l 4(a2),16(a2)
 move.l 4(a2),20(a2)
 move.l #5022,d0
 add.l D00028(a6),d0
 move.l d0,12(a2)
 movea.l D00028(a6),a0
 clr.b 5094(a0)
 move.l 12(a2),-(sp)
 pea (L00004).w
 pea (a2)
 clr.l -(sp)
 clr.l -(sp)
 pea L04b84(pc)
 move.l _01828(a6),-(sp)
 lea L05688(pc),a0
 move.l a0,d1
 movea.l _0166c(a6),a0
 move.l a0,d0
 jsr _0185c(a6)
 lea 28(sp),sp
 movea.l D00028(a6),a0
 move.l 5084(a0),d1
 move.l a3,d0
 jsr _0189e(a6)
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 move.w #1,266(a0)
 movea.l D00028(a6),a0
 move.w 5106(a0),34(a2)
 movea.l D00028(a6),a0
 move.w 5566(a0),18(a3)
 movea.l D00028(a6),a0
 move.w 5568(a0),16(a3)
 move.b #1,42(a3)
 move.w #99,38(a3)
 move.w #1,44(a3)
 movea.l D00028(a6),a0
 tst.w 5012(a0)
 beq.s L05296
 move.w #140,34(a2)
 movea.l D00028(a6),a0
 move.w #140,5106(a0)
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 move.w #1,2(a0)
 move.w #36,18(a3)
 move.w #36,16(a3)
 movea.l D00028(a6),a0
 clr.w 5108(a0)
L05296 move.l 12(a2),d1
 move.l a2,d0
 jsr _0169a(a6)
 movea.l D00028(a6),a0
 move.w #1,5570(a0)
 movea.l D00028(a6),a0
 move.w #63,5576(a0)
 movea.l D00028(a6),a0
 clr.b 5564(a0)
 movea.l D00028(a6),a0
 move.w #1,6906(a0)
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 tst.w 2(a0)
 beq.s L052de
 movea.l D00028(a6),a0
 clr.w 6904(a0)
 bra.s L052e8
L052de movea.l D00028(a6),a0
 move.w #255,6904(a0)
L052e8 move.w #100,44(a2)
 move.w #80,46(a2)
 move.l 12(a2),d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _01838(a6)
 move.l #7852,d0
 add.l D00028(a6),d0
 move.l d0,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _01838(a6)
 moveq #0,d4
 bra.s L05344
L05320 move.l d4,d0
 moveq #60,d1
 jsr _016a0(a6)
 move.l #7912,d1
 add.l D00028(a6),d1
 add.l d1,d0
 move.l d0,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _01838(a6)
 addq.l #1,d4
L05344 moveq #3,d0
 cmp.l d4,d0
 bgt.s L05320
 bsr.w L02fec
 bsr.w L0336a
 moveq #2,d1
 move.l a2,d0
 jsr _01670(a6)
 movea.l D00028(a6),a0
 clr.w 5586(a0)
 movea.l D00028(a6),a0
 clr.w 5588(a0)
 move.w #384,d0
 sub.w 2(a3),d0
 movea.l D00028(a6),a0
 move.w d0,5590(a0)
 move.w #240,d0
 sub.w (a3),d0
 movea.l D00028(a6),a0
 move.w d0,5592(a0)
 movea.l D00028(a6),a0
 move.w #1,5608(a0)
 movea.l D00028(a6),a0
 move.l _00cd0(a6),5594(a0)
 movea.l D00028(a6),a0
 move.l _00cd0(a6),5598(a0)
 movem.l -20(a5),a0/a2-a3/d1/d4
 unlk a5
 rts 
L053b0 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
 movea.l D00028(a6),a0
 movea.l 5018(a0),a3
 movea.l 4(a3),a4
 addq.l #1,d4
 moveq #3,d0
 cmp.l d4,d0
 bge.s L053ee
 movea.l D00028(a6),a0
 move.l 5102(a0),4(a3)
 movea.l D00028(a6),a0
 clr.w 5100(a0)
 movea.l D00028(a6),a0
 move.b #1,5095(a0)
 bra.s L05408
L053ee move.b (a4,d4.l),d0
 ext.w d0
 move.w d0,38(a2)
 move.l d4,-(sp)
 lea L04b84(pc),a0
 move.l a0,d1
 move.l a2,d0
 jsr _017fc(a6)
 addq.l #4,sp
L05408 movem.l -20(a5),a0/a2-a4/d4
 unlk a5
 rts 
L05412 link.w a5,#0
 movem.l a0-a4/d0-d1/d4-d5,-(sp)
 movea.l D00028(a6),a0
 movea.l 5018(a0),a0
 movea.l 12(a0),a2
 movea.l D00028(a6),a0
 movea.l 5018(a0),a3
 movea.l (a3),a4
 movea.l D00028(a6),a0
 tst.w 5100(a0)
 bne.w L055a0
 movea.l D00028(a6),a0
 tst.w 6906(a0)
 bne.s L054b4
 movea.l D00028(a6),a0
 cmpi.w #255,6904(a0)
 beq.s L054b4
 movea.l D00028(a6),a0
 moveq #0,d0
 move.w 6904(a0),d0
 moveq #26,d1
 add.l d1,d0
 lsl.l #1,d0
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 tst.w (a0,d0.l)
 bne.s L054a2
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 tst.w 2(a0)
 bne.s L0548c
 movea.l D00028(a6),a0
 move.w #255,6904(a0)
 bra.w L055a0
L0548c movea.l D00028(a6),a0
 clr.w 6904(a0)
 movea.l D00028(a6),a0
 move.w #1,6906(a0)
 bra.w L055a0
L054a2 movea.l D00028(a6),a0
 moveq #0,d0
 move.w 6904(a0),d0
 jsr _018bc(a6)
 bra.w L055a0
L054b4 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 tst.w 2(a0)
 beq.w L055a0
 movea.l D00028(a6),a0
 move.l 4(a3),5102(a0)
 move.w 24(a3),d0
 ext.l d0
 addq.l #4,d0
 moveq #72,d1
 jsr _016a0(a6)
 add.l 6(a4),d0
 move.l d0,4(a3)
 move.l d0,d4
 movea.l d4,a0
 clr.w 18(a0)
 movea.l D00028(a6),a0
 move.w #1,5100(a0)
 movea.l D00028(a6),a0
 clr.b 5095(a0)
 clr.w 38(a2)
 pea (a3)
 moveq #0,d1
 moveq #0,d0
 bsr.w L077fe
 addq.l #4,sp
 clr.l -(sp)
 lea L04b84(pc),a0
 move.l a0,d1
 move.l a2,d0
 jsr _017fc(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 tst.b 5564(a0)
 beq.w L055a0
 movea.l D00028(a6),a0
 tst.b 5565(a0)
 bne.s L055a0
 movea.l D00028(a6),a0
 cmpi.w #1,6904(a0)
 bcs.s L055a0
 movea.l D00028(a6),a0
 move.l 5120(a0),d5
 movea.l d5,a0
 movea.l D00028(a6),a1
 move.w 5108(a1),d0
 cmp.w 16(a0),d0
 blt.s L055a0
 movea.l D00028(a6),a0
 move.b #1,5565(a0)
 movea.w 24(a3),a0
 move.l a0,-(sp)
 move.l a3,d1
 move.l #5116,d0
 add.l D00028(a6),d0
 jsr _018c2(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 tst.w 5562(a0)
 bne.s L0558e
 movea.l D00028(a6),a0
 clr.b 5565(a0)
 bra.s L055a0
L0558e movea.l d5,a0
 move.w 16(a0),d0
 movea.l D00028(a6),a0
 sub.w d0,5108(a0)
 bsr.w L0336a
L055a0 movem.l -32(a5),a0-a4/d1/d4-d5
 unlk a5
 rts 
L055aa link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4-d6,-(sp)
 move.l d0,d4
 move.l d1,d5
 subq.l #4,sp
 movea.l D00028(a6),a0
 movea.l 6788(a0),a2
 moveq #0,d6
 bra.s L05612
L055c4 tst.l 12(a2)
 beq.s L0560a
 movea.l (a2),a3
 cmpi.w #1,34(a3)
 beq.s L055dc
 cmpi.w #5,34(a3)
 bne.s L0560a
L055dc move.w 44(a2),d0
 add.w 2(a3),d0
 move.w d0,(sp)
 move.w 46(a2),d0
 add.w (a3),d0
 move.w d0,2(sp)
 cmp.w 44(a2),d4
 ble.s L0560a
 cmp.w (sp),d4
 bge.s L0560a
 cmp.w 46(a2),d5
 ble.s L0560a
 cmp.w 2(sp),d5
 bge.s L0560a
 move.l a2,d0
 bra.s L05622
L0560a addq.l #1,d6
 adda.l #54,a2
L05612 movea.l D00028(a6),a0
 move.w 6796(a0),d0
 ext.l d0
 cmp.l d6,d0
 bgt.s L055c4
 moveq #0,d0
L05622 addq.l #4,sp
 movem.l -24(a5),a0/a2-a3/d4-d6
 unlk a5
 rts 
L0562e link.w a5,#0
 movem.l a2-a4/d0-d2/d4-d5,-(sp)
 movea.l d0,a2
 movea.l 4(a2),a3
 moveq #36,d0
 add.l a3,d0
 movea.l d0,a4
 moveq #0,d5
 moveq #0,d4
 bra.s L05672
L05648 move.w 2(a4),d0
 ext.l d0
 move.w 46(a2),d1
 ext.l d1
 add.l d1,d0
 move.l d0,d1
 move.w (a4),d0
 ext.l d0
 move.w 44(a2),d2
 ext.l d2
 add.l d2,d0
 bsr.w L055aa
 move.l d0,d5
 tst.l d5
 bne.s L0567c
 addq.l #1,d4
 addq.l #4,a4
L05672 move.w 22(a3),d0
 ext.l d0
 cmp.l d4,d0
 bgt.s L05648
L0567c move.l d5,d0
 movem.l -28(a5),a2-a4/d1-d2/d4-d5
 unlk a5
 rts 
L05688 link.w a5,#0
 movem.l a0-a4/d0-d1/d4-d6,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 movea.l 46(a2),a4
 moveq #5,d6
 move.l a4,d0
 bsr.s L0562e
 move.l d0,d4
 tst.l d4
 beq.s L056b4
 movea.l d4,a0
 tst.b 48(a0)
 bne.s L056b4
 movea.l d4,a0
 tst.b 52(a0)
 beq.s L056ba
L056b4 moveq #0,d0
 bra.w L0578e
L056ba move.l a4,d1
 move.l d4,d0
 jsr _01892(a6)
 movea.l d4,a0
 clr.w 38(a0)
 movea.l d4,a0
 clr.w 50(a0)
 movea.l _0188e(a6),a0
 movea.l d4,a1
 movea.l 12(a1),a1
 move.l a0,14(a1)
 movea.l d4,a0
 cmpi.w #1,26(a0)
 bne.s L056fa
 movea.l d4,a0
 movea.l d4,a1
 move.w 44(a0),30(a1)
 movea.l d4,a0
 movea.l d4,a1
 move.w 46(a0),32(a1)
L056fa movea.l d4,a0
 cmpi.w #5,26(a0)
 bne.s L05716
 moveq #30,d0
 add.l d4,d0
 move.l d0,d5
 movea.l d4,a0
 movea.l 12(a0),a0
 movea.l d5,a1
 move.l 26(a0),(a1)
L05716 pea (L00003).w
 movea.w 24(a4),a0
 move.l a0,-(sp)
 move.l (a4),d1
 move.l d4,d0
 bsr.w L059fa
 addq.l #8,sp
 movea.l d4,a0
 movea.l (a0),a0
 cmpi.w #5,34(a0)
 bne.s L05738
 moveq #10,d6
L05738 ext.l d6
 move.l d6,-(sp)
 lea L05ee0(pc),a0
 move.l a0,d1
 movea.l d4,a0
 move.l 12(a0),d0
 jsr _017fc(a6)
 addq.l #4,sp
 movea.l d4,a0
 cmpi.w #1,34(a0)
 bge.s L05772
 move.l d4,d0
 bsr.w L0619a
 move.l d4,d0
 bsr.w L02b40
 move.l d4,-(sp)
 moveq #5,d1
 moveq #0,d0
 bsr.w L077fe
 addq.l #4,sp
 bra.s L0577a
L05772 move.l d4,d1
 moveq #3,d0
 bsr.w L00856
L0577a movea.l d4,a0
 movea.l 12(a0),a0
 clr.l 18(a0)
 movea.l d4,a0
 move.b #1,48(a0)
 moveq #1,d0
L0578e movem.l -32(a5),a0-a4/d4-d6
 unlk a5
 rts 
L05798 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 movea.l 46(a2),a3
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 move.w 316(a0),d4
 movea.l D00028(a6),a0
 clr.w 5630(a0)
 movea.l D00028(a6),a0
 tst.w 5012(a0)
 beq.s L057d8
 clr.l -(sp)
 moveq #0,d1
 move.l a2,d0
 jsr _017fc(a6)
 addq.l #4,sp
 moveq #0,d0
 bsr.w L04070
 bra.s L05844
L057d8 clr.l -(sp)
 lea L04b84(pc),a0
 move.l a0,d1
 move.l a2,d0
 jsr _017fc(a6)
 addq.l #4,sp
 moveq #4,d0
 bsr.w L04876
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 tst.w 258(a0)
 beq.s L05808
 move.w d4,d0
 ext.l d0
 lsl.l #2,d0
 lea _00c6a(a6),a0
 bra.s L05812
L05808 move.w d4,d0
 ext.l d0
 lsl.l #2,d0
 lea _00c8a(a6),a0
L05812 move.l (a0,d0.l),-(sp)
 lea L022c0(pc),a0
 move.l a0,d1
 moveq #4,d0
 jsr _016a6(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 move.w #1,266(a0)
 movea.l D00028(a6),a0
 move.w 5106(a0),34(a3)
 bsr.w L0178e
 bsr.w L00292
L05844 movem.l -20(a5),a0/a2-a3/d1/d4
 unlk a5
 rts 
L0584e link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 move.l d1,d4
 movea.l D00028(a6),a0
 movea.l 5018(a0),a3
 moveq #100,d0
 add.l D00028(a6),d0
 movea.l d0,a4
 move.l #140,d0
 add.l D00028(a6),d0
 move.l d0,d5
 subq.l #1,d4
 tst.l d4
 bne.s L05882
 moveq #1,d0
 move.l d0,_00d00(a6)
L05882 tst.l _00d00(a6)
 beq.w L05910
L0588a pea (L00001).w
 moveq #1,d1
 movea.l D00028(a6),a0
 move.l 182(a0),d0
 jsr _016f4(a6)
 addq.l #4,sp
 moveq #1,d1
 cmp.l d0,d1
 bne.s L0588a
 move.l D00028(a6),-(sp)
 movea.w (a4),a0
 move.l a0,-(sp)
 moveq #0,d1
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 jsr _016d0(a6)
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 movea.l d5,a0
 movea.w (a0),a0
 move.l a0,-(sp)
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016d0(a6)
 addq.l #8,sp
 subq.w #3,(a4)
 movea.l d5,a0
 subq.w #3,(a0)
 tst.w (a4)
 bge.s L058fa
 clr.w (a4)
L058fa movea.l d5,a0
 tst.w (a0)
 bge.s L05904
 movea.l d5,a0
 clr.w (a0)
L05904 move.l a4,d0
 bne.s L05910
 tst.l d5
 bne.s L05910
 clr.l _00d00(a6)
L05910 movea.l D00028(a6),a0
 tst.l 6412(a0)
 bne.s L0592e
 move.l a2,d0
 bsr.w L05798
 clr.l _00cfc(a6)
 movea.l D00028(a6),a0
 clr.b 5578(a0)
 bra.s L0595c
L0592e move.l d4,-(sp)
 lea L0584e(pc),a0
 move.l a0,d1
 move.l a2,d0
 jsr _017fc(a6)
 addq.l #4,sp
 move.l _00cfc(a6),d0
 asr.l #1,d0
 move.l d0,d1
 move.l a3,d0
 jsr _01670(a6)
 addq.l #1,_00cfc(a6)
 moveq #8,d0
 cmp.l _00cfc(a6),d0
 bgt.s L0595c
 clr.l _00cfc(a6)
L0595c movem.l -24(a5),a0/a2-a4/d4-d5
 unlk a5
 rts 
L05966 link.w a5,#0
 movem.l a0/d0,-(sp)
 movea.l D00028(a6),a0
 movea.l 5018(a0),a0
 subi.w #20,34(a0)
 bsr.w L0307a
 movem.l -4(a5),a0
 unlk a5
 rts 
 ori.w #$3132,(a3,d3.w)
 dc.w $7332
 move.w 115(a3,d0.w),d1
 move.w (a2,d3.w),-(a1)
 dc.w $7334
 move.w 115(a1,d0.w),d1
 dc.w $3532
 move.w d0,d2
 dc.w $7336
 move.w 115(sp,d0.w),d1
 dc.w $3732
 move.w d0,d1
 beq.s L059e2
 move.w d0,-(a1)
 dc.w $7331
 move.w 115(a1,d0.w),d0
 dc.w $3230
 move.w d0,-(a0)
 dc.w $7333
 move.w 115(a1,d0.w),d0
 dc.w $3430
 move.w d0,-(a0)
 dc.w $7335
 move.w 115(a1,d0.w),d0
 dc.w $3630
 move.w d0,-(a0)
 dc.w $7337
 move.w 103(a1,d0.w),d0
 dc.w $6c31
 dc.w $7a
L059d9 equ *-1
 dc.w $6400
L059dc moveq #115,d5
 moveq #95,d0
 dc.w $6361
L059e2 dc.w $7374
 dc.w $7a
L059e5 equ *-1
 dc.w $7370
 subq.w #7,-(a4)
 dc.w $6573
 dc.w $6300
L059ee moveq #115,d5
 moveq #95,d0
 beq.s L05a66
 dc.w $6f75
 moveq #115,d0
 dc.w $0
L059fa link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l 40(sp),d4
 move.l 44(sp),d5
 movea.l (a2),a4
 tst.w 38(a4)
 beq.s L05a3c
 moveq #0,d0
 move.w 40(a3),d0
 lsr.l #8,d0
 move.w 38(a4),d1
 ext.l d1
 cmp.l d1,d0
 beq.s L05a3c
 move.w #1,38(a2)
 pea (a2)
 moveq #5,d1
 moveq #0,d0
 bsr.w L077fe
 addq.l #4,sp
 bra.s L05a60
L05a3c pea (a2)
 moveq #4,d1
 moveq #0,d0
 bsr.w L077fe
 addq.l #4,sp
 movea.l (a2),a0
 move.b 43(a0),d0
 ext.w d0
 ext.l d0
 sub.l d0,d5
 move.b d5,d0
 ext.w d0
 move.w d0,40(a2)
 move.b d4,53(a2)
L05a60 movem.l -24(a5),a0/a2-a4/d4-d5
L05a66 unlk a5
 rts 
L05a6a link.w a5,#0
 movem.l a2/d0,-(sp)
 movea.l d0,a2
 tst.b 53(a2)
 beq.s L05a80
 subq.b #1,53(a2)
 bra.s L05a94
L05a80 cmpi.w #5,26(a2)
 beq.s L05a8e
 clr.b 52(a2)
 bra.s L05a94
L05a8e move.b _00f49(a6),52(a2)
L05a94 movem.l -4(a5),a2
 unlk a5
 rts 
L05a9e link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 lea -20(sp),sp
 moveq #50,d0
 add.l a2,d0
 movea.l d0,a4
 moveq #42,d0
 add.l a2,d0
 move.l d0,d4
 clr.w 10(sp)
 clr.w 8(sp)
 clr.w 6(sp)
 move.l (a3),d7
 move.l (a2),(sp)
 move.w 44(a3),d0
 movea.l d7,a0
 move.w 2(a0),d1
 asr.w #1,d1
 add.w d1,d0
 move.w d0,16(sp)
 move.w 46(a3),d0
 movea.l d7,a0
 move.w (a0),d1
 asr.w #1,d1
 add.w d1,d0
 move.w d0,18(sp)
 move.w 44(a2),d0
 movea.l (sp),a0
 move.w 2(a0),d1
 asr.w #1,d1
 add.w d1,d0
 move.w d0,12(sp)
 move.w 46(a2),d0
 movea.l (sp),a0
 move.w (a0),d1
 asr.w #1,d1
 add.w d1,d0
 move.w d0,14(sp)
 move.w 12(sp),d0
 ext.l d0
 move.w 16(sp),d1
 ext.l d1
 sub.l d0,d1
 move.l d1,d5
 move.w 14(sp),d0
 ext.l d0
 move.w 18(sp),d1
 ext.l d1
 sub.l d0,d1
 move.l d1,d6
 lsl.l #4,d5
 lsl.l #4,d6
 tst.l d5
 bne.s L05b3c
 tst.l d6
 beq.w L05c38
L05b3c tst.l d5
 bne.s L05b5a
 clr.w (a4)
 tst.l d6
 bge.s L05b50
 movea.l d4,a0
 move.w #-64,(a0)
 bra.w L05c38
L05b50 movea.l d4,a0
 move.w #64,(a0)
 bra.w L05c38
L05b5a tst.l d5
 ble.s L05b64
 clr.w 10(sp)
 bra.s L05b74
L05b64 move.w #1,10(sp)
 moveq #255,d0
 move.l d5,d1
 jsr _016a0(a6)
 move.l d0,d5
L05b74 tst.l d6
 bne.s L05b90
 movea.l d4,a0
 clr.w (a0)
 tst.l d5
 bge.s L05b88
 move.w #64,(a4)
 bra.w L05c38
L05b88 move.w #-64,(a4)
 bra.w L05c38
L05b90 tst.l d6
 ble.s L05b9a
 clr.w 8(sp)
 bra.s L05baa
L05b9a moveq #255,d0
 move.l d6,d1
 jsr _016a0(a6)
 move.l d0,d6
 move.w #1,8(sp)
L05baa cmp.l d6,d5
 ble.s L05bb6
 move.w #1,6(sp)
 bra.s L05bc6
L05bb6 move.w d6,4(sp)
 move.l d5,d6
 movea.w 4(sp),a0
 move.l a0,d5
 clr.w 6(sp)
L05bc6 move.l d5,d0
 bge.s L05bd0
 addi.l #$0000000f,d0
L05bd0 asr.l #4,d0
 move.l d0,d1
 move.l d6,d0
 jsr _01904(a6)
 moveq #64,d1
 sub.w d0,d1
 addq.w #8,d1
 move.w d1,(a4)
 move.l d5,d0
 bge.s L05bec
 addi.l #$0000000f,d0
L05bec asr.l #4,d0
 move.l d0,d1
 move.l d6,d0
 jsr _01904(a6)
 moveq #3,d1
 jsr _016a0(a6)
 addq.w #8,d0
 movea.l d4,a0
 move.w d0,(a0)
 tst.w 6(sp)
 bne.s L05c16
 movea.l d4,a0
 move.w (a0),4(sp)
 movea.l d4,a0
 move.w (a4),(a0)
 move.w 4(sp),(a4)
L05c16 cmpi.w #1,10(sp)
 bne.s L05c26
 move.w (a4),d0
 muls.w #-1,d0
 move.w d0,(a4)
L05c26 cmpi.w #1,8(sp)
 bne.s L05c38
 movea.l d4,a0
 move.w (a0),d0
 muls.w #-1,d0
 move.w d0,(a0)
L05c38 lea 20(sp),sp
 movem.l -32(a5),a0/a2-a4/d4-d7
 unlk a5
 rts 
L05c46 link.w a5,#0
 movem.l a0/a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 movea.l 46(a2),a3
 move.l a2,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _01844(a6)
 clr.w 38(a3)
 clr.l 12(a3)
 movem.l -16(a5),a0/a2-a3/d1
 unlk a5
 rts 
L05c74 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d6,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 moveq #50,d0
 add.l a2,d0
 movea.l d0,a4
 moveq #42,d0
 add.l a2,d0
 move.l d0,d4
 lea _01032(a6),a0
 move.l a0,d0
 move.w 24(a3),d1
 ext.l d1
 lsl.l #2,d1
 add.l d1,d0
 move.l d0,d5
 move.l (a2),d6
 movea.l d5,a0
 move.w (a0),d0
 ext.l d0
 lsl.l #1,d0
 move.w d0,(a4)
 movea.l d5,a0
 move.w 2(a0),d0
 ext.l d0
 lsl.l #1,d0
 movea.l d4,a0
 move.w d0,(a0)
 movea.l d6,a0
 cmpi.w #1,4(a0)
 ble.s L05cde
 moveq #72,d0
 muls.w 24(a3),d0
 movea.l d6,a0
 add.l 6(a0),d0
 move.l d0,4(a2)
 move.l 4(a2),16(a2)
 move.l 4(a2),20(a2)
L05cde movem.l -28(a5),a0/a2-a4/d4-d6
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l a3,d5
 moveq #8,d1
 move.l #8536,d0
 add.l D00028(a6),d0
 jsr _0182c(a6)
 movea.l d0,a4
 move.l a4,d0
 beq.w L05e46
 pea (L00002).w
 pea (a4)
 clr.l -(sp)
 pea L05c46(pc)
 clr.l -(sp)
 move.l _01828(a6),-(sp)
 move.l _01822(a6),-(sp)
 movea.l _0166c(a6),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _0183e(a6)
 lea 28(sp),sp
 move.l d0,12(a4)
 move.l d0,d4
 tst.l d4
 beq.w L05e1e
 addi.l #$0000002e,d5
 move.l d5,(a4)
 movea.l d5,a0
 move.l 6(a0),4(a4)
 movea.l d5,a0
 move.l 6(a0),16(a4)
 movea.l d5,a0
 move.l 6(a0),20(a4)
 move.w 44(a2),d0
 move.w 2(a3),d1
 asr.w #1,d1
 add.w d1,d0
 movea.l d5,a0
 move.w 2(a0),d1
 asr.w #1,d1
 sub.w d1,d0
 move.w d0,44(a4)
 move.w 46(a2),d0
 move.w (a3),d1
 asr.w #1,d1
 add.w d1,d0
 movea.l d5,a0
 move.w (a0),d1
 asr.w #1,d1
 sub.w d1,d0
 move.w d0,46(a4)
 movea.l d5,a0
 move.w #4,34(a0)
 move.w #50,26(a4)
 cmpi.w #4,4(a3)
 bge.s L05de6
 movea.l D00028(a6),a0
 move.l 5018(a0),d1
 move.l a4,d0
 bsr.w L05a9e
 pea (a4)
 movea.l _01900(a6),a0
 move.l a0,d1
 move.l 12(a4),d0
 jsr _017fc(a6)
 addq.l #4,sp
 move.w 44(a4),d0
 ext.l d0
 lsl.l #4,d0
 move.w d0,30(a4)
 move.w 46(a4),d0
 ext.l d0
 lsl.l #4,d0
 move.w d0,32(a4)
 bra.s L05e00
L05de6 move.l a2,d1
 move.l a4,d0
 bsr.w L05c74
 pea (a4)
 movea.l _018fa(a6),a0
 move.l a0,d1
 move.l 12(a4),d0
 jsr _017fc(a6)
 addq.l #4,sp
L05e00 clr.l -(sp)
 moveq #0,d1
 move.l a4,d0
 jsr _018ec(a6)
 addq.l #4,sp
 tst.l d0
 beq.s L05e24
 move.l d4,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _01844(a6)
L05e1e clr.w 38(a4)
 bra.s L05e46
L05e24 move.l d4,d1
 move.l a4,d0
 jsr _0169a(a6)
 move.l d4,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _016b2(a6)
 pea (a2)
 moveq #0,d1
 moveq #1,d0
 bsr.w L077fe
 addq.l #4,sp
L05e46 movem.l -24(a5),a0/a2-a4/d4-d5
 unlk a5
 rts 
L05e50 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l 40(sp),d5
 movea.l 44(sp),a3
 lea -22(sp),sp
 movea.l 46(a2),a4
 adda.l d4,a3
 move.l a3,4(sp)
 move.w d5,d0
 ext.l d0
 lsl.l #2,d0
 movea.l 4(a4),a0
 move.l (a0,d0.l),(sp)
 lea (sp),a0
 move.l a0,d0
 jsr _0190a(a6)
 lea 22(sp),sp
 movem.l -24(a5),a0/a2-a4/d4-d5
 unlk a5
 rts 
L05e96 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l 40(sp),d5
 movea.l 44(sp),a3
 lea -22(sp),sp
 movea.l 46(a2),a4
 adda.l d4,a3
 move.l a3,4(sp)
 move.w d5,d0
 ext.l d0
 lsl.l #2,d0
 movea.l 4(a4),a0
 move.l (a0,d0.l),(sp)
 clr.l 8(sp)
 lea (sp),a0
 move.l a0,d0
 jsr _01868(a6)
 lea 22(sp),sp
 movem.l -24(a5),a0/a2-a4/d4-d5
 unlk a5
 rts 
L05ee0 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
 movea.l 46(a2),a3
 moveq #30,d0
 add.l a3,d0
 movea.l d0,a4
 subq.l #1,d4
 addq.w #1,50(a3)
 cmpi.w #3,50(a3)
 ble.s L05f08
 clr.w 50(a3)
L05f08 tst.w 40(a3)
 beq.s L05f2c
 move.l _018ee(a6),-(sp)
 pea (L00005).w
 move.b 53(a3),d0
 ext.w d0
 ext.l d0
 move.l d0,d1
 move.l a3,d0
 jsr _018e0(a6)
 addq.l #8,sp
 subq.w #1,40(a3)
L05f2c tst.l d4
 beq.s L05f42
 move.l d4,-(sp)
 lea L05ee0(pc),a0
L05f36 move.l a0,d1
 move.l a2,d0
 jsr _017fc(a6)
 addq.l #4,sp
 bra.s L05fa6
L05f42 movea.l _01822(a6),a0
 move.l a0,18(a2)
 movea.l _0166c(a6),a0
 move.l a0,14(a2)
 cmpi.w #2,26(a3)
 bne.s L05f6c
 clr.l -(sp)
 movea.l _018b2(a6),a0
L05f60 move.l a0,d1
 move.l a2,d0
 jsr _017fc(a6)
 addq.l #4,sp
 bra.s L05fa2
L05f6c cmpi.w #1,26(a3)
 bne.s L05f7c
 clr.l -(sp)
 movea.l _018f4(a6),a0
 bra.s L05f36
L05f7c tst.w 26(a3)
 bne.s L05f8a
 pea (a3)
 movea.l _018dc(a6),a0
 bra.s L05f60
L05f8a pea (a3)
 move.l (a4),d1
 move.l a2,d0
 jsr _017fc(a6)
 addq.l #4,sp
 move.b #1,52(a3)
 move.b #14,53(a3)
L05fa2 clr.b 48(a3)
L05fa6 movem.l -20(a5),a0/a2-a4/d4
 unlk a5
 rts 
L05fb0 link.w a5,#0
 movem.l a0/a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 movea.l 46(a2),a3
 move.l a2,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _01844(a6)
 clr.l 12(a3)
 move.l a3,d1
 moveq #0,d0
 bsr.w L00856
 movea.l (a3),a0
 cmpi.w #1,34(a0)
 bne.s L05ff8
 movea.l D00028(a6),a0
 move.w 5000(a0),d0
 ext.l d0
 lsl.l #2,d0
 movea.l D00028(a6),a0
 adda.l d0,a0
 subq.w #1,4874(a0)
L05ff8 movem.l -16(a5),a0/a2-a3/d1
 unlk a5
 rts 
L06002 link.w a5,#0
 movem.l a0/a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 movea.l 46(a2),a3
 movea.l _0166c(a6),a0
 move.l a0,14(a2)
 movea.l _01822(a6),a0
 move.l a0,18(a2)
 cmpi.w #9,26(a3)
 bne.s L06030
 pea (a3)
 movea.l _018e8(a6),a0
 bra.s L0603c
L06030 tst.w 26(a3)
 bne.s L06046
 pea (a3)
 movea.l _018dc(a6),a0
L0603c move.l a0,d1
 move.l a2,d0
 jsr _017fc(a6)
 addq.l #4,sp
L06046 lea L05fb0(pc),a0
 move.l a0,30(a2)
 movem.l -16(a5),a0/a2-a3/d1
 unlk a5
 rts 
L06058 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
 movea.l 46(a2),a3
 subq.l #1,d4
 addq.w #1,50(a3)
 cmpi.w #3,50(a3)
 ble.s L0607a
 clr.w 50(a3)
L0607a moveq #1,d0
 cmp.l d4,d0
 ble.s L06086
 move.w #2,(a2)
 bra.s L06096
L06086 move.l d4,-(sp)
 lea L06058(pc),a0
 move.l a0,d1
 move.l a2,d0
 jsr _017fc(a6)
 addq.l #4,sp
L06096 movem.l -16(a5),a0/a2-a3/d4
 unlk a5
 rts 
L060a0 link.w a5,#0
 movem.l a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 addq.w #1,38(a2)
 cmpi.w #5,38(a2)
 ble.s L060c2
 move.w #5,38(a2)
 move.w #2,(a2)
L060c2 movem.l -8(a5),a2-a3
 unlk a5
 rts 
L060cc link.w a5,#0
 movem.l a0/a2/d0-d1,-(sp)
 movea.l d0,a2
 move.l a2,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _01844(a6)
 movem.l -12(a5),a0/a2/d1
 unlk a5
 rts 
L060ee link.w a5,#0
 movem.l a0/a2/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
 subq.l #1,d4
 tst.l d4
 beq.s L06110
 move.l d4,-(sp)
 lea L060ee(pc),a0
 move.l a0,d1
 move.l a2,d0
 jsr _017fc(a6)
 bra.s L06132
L06110 lea L060a0(pc),a0
 move.l a0,26(a2)
 lea L05e50(pc),a0
 move.l a0,14(a2)
 lea L05e96(pc),a0
 move.l a0,22(a2)
 clr.l -(sp)
 moveq #5,d1
 moveq #0,d0
 bsr.w L077fe
L06132 addq.l #4,sp
 movem.l -12(a5),a0/a2/d4
 unlk a5
 rts 
 link.w a5,#0
 movem.l a2-a3/d0,-(sp)
 movea.l d0,a2
 movea.l 12(a2),a3
 move.w #2,(a3)
 move.l a2,d0
 bsr.w L027b4
 movem.l -8(a5),a2-a3
 unlk a5
 rts 
L06160 link.w a5,#0
 movem.l a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 tst.w (a3)
 bge.s L06174
 clr.w (a3)
 bra.s L0617e
L06174 cmpi.w #200,(a3)
 ble.s L0617e
 move.w #200,(a3)
L0617e tst.w (a2)
 bge.s L06186
 clr.w (a2)
 bra.s L06190
L06186 cmpi.w #364,(a2)
 ble.s L06190
 move.w #364,(a2)
L06190 movem.l -8(a5),a2-a3
 unlk a5
 rts 
L0619a link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d6,-(sp)
 subq.l #4,sp
 movea.l 4(sp),a0
 movea.l 12(a0),a2
 moveq #0,d5
 movea.l 4(sp),a0
 move.l (a0),d6
 movea.l 4(sp),a0
 cmpi.w #5,26(a0)
 beq.w L06270
 pea (L00004).w
 lea L06058(pc),a0
 move.l a0,d1
 move.l a2,d0
 jsr _017fc(a6)
 addq.l #4,sp
 pea (L00006).w
 movea.l D00028(a6),a0
 move.l 5110(a0),-(sp)
 clr.l -(sp)
 pea L060cc(pc)
 pea L060a0(pc)
 pea L05e96(pc)
 clr.l -(sp)
 lea L05e50(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _0183e(a6)
 lea 28(sp),sp
 movea.l d0,a3
 move.l a3,d0
 beq.w L0638c
 move.l a3,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _01838(a6)
 movea.l 4(sp),a0
 move.w 44(a0),d0
 movea.l d6,a0
 move.w 2(a0),d1
 asr.w #1,d1
 add.w d1,d0
 subi.w #16,d0
 move.w d0,(sp)
 movea.l 4(sp),a0
 move.w 46(a0),d0
 movea.l d6,a0
 move.w (a0),d1
 asr.w #1,d1
 add.w d1,d0
 subi.w #16,d0
 move.w d0,2(sp)
 lea 2(sp),a0
 move.l a0,d1
 lea (sp),a0
 move.l a0,d0
 bsr.w L06160
 move.w #384,d0
 muls.w 2(sp),d0
 move.w (sp),d1
 ext.l d1
 add.l d1,d0
 move.l d0,2(a3)
 bra.w L0638c
L06270 moveq #0,d4
 bra.w L06372
L06276 tst.l d5
 bne.s L06284
 movea.l D00028(a6),a0
 movea.l 5110(a0),a4
 bra.s L0628c
L06284 movea.l D00028(a6),a0
 movea.l 5624(a0),a4
L0628c tst.l d5
 bne.s L06294
 moveq #1,d0
 bra.s L06296
L06294 moveq #0,d0
L06296 move.l d0,d5
 pea (L00006).w
 pea (a4)
 clr.l -(sp)
 pea L060cc(pc)
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 moveq #0,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _0183e(a6)
 lea 28(sp),sp
 movea.l d0,a3
 move.l a3,d0
 beq.w L0637a
 move.l a3,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _01838(a6)
 movea.l 4(sp),a0
 move.w 44(a0),d0
 movea.l d6,a0
 move.w 2(a0),d1
 asr.w #1,d1
 add.w d1,d0
 move.w d0,d1
 bsr.w L08ba2
 andi.w #$003e,d0
 add.w d0,d1
 subi.w #32,d1
 move.w d1,(sp)
 movea.l 4(sp),a0
 move.w 46(a0),d0
 movea.l d6,a0
 move.w (a0),d1
 asr.w #1,d1
 add.w d1,d0
 move.w d0,d1
 bsr.w L08ba2
 andi.w #$003e,d0
 add.w d0,d1
 subi.w #32,d1
 move.w d1,2(sp)
 tst.w 2(sp)
 bge.s L06326
 clr.w 2(sp)
 bra.s L06334
L06326 cmpi.w #200,2(sp)
 ble.s L06334
 move.w #200,2(sp)
L06334 tst.w (sp)
 bge.s L0633c
 clr.w (sp)
 bra.s L06346
L0633c cmpi.w #364,(sp)
 ble.s L06346
 move.w #364,(sp)
L06346 move.w #384,d0
 muls.w 2(sp),d0
 move.w (sp),d1
 ext.l d1
 add.l d1,d0
 move.l d0,2(a3)
 bsr.w L08ba2
 moveq #11,d1
 asr.l d1,d0
 move.l d0,-(sp)
 lea L060ee(pc),a0
 move.l a0,d1
 move.l a3,d0
 jsr _017fc(a6)
 addq.l #4,sp
 addq.l #1,d4
L06372 moveq #20,d0
 cmp.l d4,d0
 bgt.w L06276
L0637a pea (L0000e).w
 lea L06058(pc),a0
 move.l a0,d1
 move.l a2,d0
 jsr _017fc(a6)
 addq.l #4,sp
L0638c addq.l #4,sp
 movem.l -32(a5),a0/a2-a4/d1/d4-d6
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2/d0-d1/d4,-(sp)
 subq.l #2,sp
 movea.l D00048(a6),a2
 clr.b 1(sp)
 tst.w 112(a2)
 beq.w L0643a
 pea (L000ff).w
 pea (L00010).w
 pea (L00010).w
 movea.w 110(a2),a0
 move.l a0,-(sp)
 movea.w 108(a2),a0
 move.l a0,d1
 moveq #28,d0
 add.l a2,d0
 bsr.w L07580
 lea 16(sp),sp
 move.w 112(a2),d0
 ext.l d0
 subq.l #1,d0
 move.b 114(a2,d0.l),(sp)
 move.l 16(a2),d1
 lea (sp),a0
 move.l a0,d0
 bsr.w L07648
 move.l d0,d4
 move.w d4,d0
 sub.w d0,108(a2)
 subq.w #1,112(a2)
 move.w 112(a2),d0
 ext.l d0
 clr.b 114(a2,d0.l)
 pea (L000ff).w
 pea (L00010).w
 move.l d4,-(sp)
 movea.w 110(a2),a0
 move.l a0,-(sp)
 movea.w 108(a2),a0
 move.l a0,d1
 moveq #28,d0
 add.l a2,d0
 bsr.w L07580
 lea 16(sp),sp
 pea (L00002).w
 move.l 898(a2),-(sp)
 move.l 890(a2),d1
 moveq #2,d0
 bsr.w L07750
 addq.l #8,sp
L0643a addq.l #2,sp
 movem.l -12(a5),a0/a2/d4
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2/d0-d1/d4-d5,-(sp)
 lea -42(sp),sp
 movea.l D00048(a6),a2
 movea.l 46(sp),a0
 move.b 3(a0),d5
 move.l 8(a2),4(sp)
 move.w #524,14(sp)
 clr.b 41(sp)
 move.l 16(a2),d1
 moveq #114,d0
 add.l a2,d0
 bsr.w L07648
 move.l d0,d4
 cmpi.w #15,112(a2)
 bge.w L0651e
 cmpi.l #184,d4
 bge.w L0651e
 move.b d5,40(sp)
 pea (L000ff).w
 pea (L00010).w
 pea (L00010).w
 movea.w 110(a2),a0
 move.l a0,-(sp)
 movea.w 108(a2),a0
 move.l a0,d1
 moveq #28,d0
 add.l a2,d0
 bsr.w L07580
 lea 16(sp),sp
 move.l 16(a2),-(sp)
 pea 28(a2)
 pea 8(sp)
 movea.w 110(a2),a0
 move.l a0,-(sp)
 movea.w 108(a2),a0
 move.l a0,d1
 lea 56(sp),a0
 move.l a0,d0
 bsr.w L075de
 lea 16(sp),sp
 move.l 16(a2),d1
 lea 40(sp),a0
 move.l a0,d0
 bsr.w L07648
 add.w d0,108(a2)
 move.w 112(a2),d0
 addq.w #1,112(a2)
 ext.l d0
 move.b 40(sp),114(a2,d0.l)
 move.w 112(a2),d0
 ext.l d0
 clr.b 114(a2,d0.l)
 pea (L00002).w
 move.l 898(a2),-(sp)
 move.l 890(a2),d1
 moveq #0,d0
 bsr.w L07750
 addq.l #8,sp
L0651e lea 42(sp),sp
 movem.l -16(a5),a0/a2/d4-d5
 unlk a5
 rts 
L0652c link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 lea -228(sp),sp
 pea (L000e4).w
 moveq #0,d1
 lea 4(sp),a0
 move.l a0,d0
 jsr _016ac(a6)
 addq.l #4,sp
 movea.l 232(sp),a0
 tst.b 114(a0)
 beq.s L06590
 moveq #114,d0
 add.l 232(sp),d0
 move.l d0,d1
 lea (sp),a0
 move.l a0,d0
 jsr _017f6(a6)
 move.w #1,16(sp)
 lea (sp),a0
 move.l a0,d0
 jsr _01910(a6)
 movea.l 232(sp),a0
 pea 188(a0)
 lea 4(sp),a0
 move.l a0,d1
 movea.l 236(sp),a0
 movea.w 186(a0),a0
 move.l a0,d0
 jsr _01916(a6)
 addq.l #4,sp
L06590 clr.l -(sp)
 movea.l 236(sp),a0
 move.l 902(a0),-(sp)
 move.l 240(sp),-(sp)
 movea.l 244(sp),a0
 move.l 894(a0),-(sp)
 movea.l 248(sp),a0
 move.l 890(a0),-(sp)
 movea.l 252(sp),a0
 move.l 12(a0),-(sp)
 movea.l 256(sp),a0
 move.l 8(a0),-(sp)
 movea.l 260(sp),a0
 move.l 4(a0),-(sp)
 movea.l 264(sp),a0
 move.l (a0),d1
 movea.l 264(sp),a0
 move.l 32(a0),d0
 bsr.w L0db24
 lea 32(sp),sp
 lea 228(sp),sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L065ea link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 movea.l 4(sp),a0
 movea.l D00028(a6),a1
 move.l 902(a0),126(a1)
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016d0(a6)
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #122,d0
 add.l D00028(a6),d0
 move.l d0,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016dc(a6)
 addq.l #8,sp
 pea (L00005).w
 pea (L00005).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 move.l D00028(a6),d0
 jsr _016d6(a6)
 addq.l #8,sp
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 moveq #1,d0
 jsr _016e2(a6)
 pea (L00006).w
 clr.l -(sp)
 move.l 12(sp),-(sp)
 pea L0652c(pc)
 pea (L0003f).w
 moveq #0,d1
 moveq #122,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 cmpi.w #1,_00de4(a6)
 beq.s L06738
 move.w #1,_00de4(a6)
 movea.l D00048(a6),a0
 move.w #1,136(a0)
 pea (L0007a).w
 movea.l D00028(a6),a0
 move.l 6780(a0),d1
 movea.l D00048(a6),a0
 move.l 20(a0),d0
 jsr _01928(a6)
 addq.l #4,sp
 moveq #0,d0
 bsr.w L081b2
 bsr.w L08238
 pea (L00002).w
 movea.l D00048(a6),a0
 move.l 898(a0),-(sp)
 movea.l D00048(a6),a0
 move.l 890(a0),d1
 moveq #1,d0
 bsr.w L07750
 addq.l #8,sp
 pea (L00003).w
 pea (L00002).w
 move.l D00048(a6),-(sp)
 pea L065ea(pc)
 clr.l -(sp)
 moveq #63,d1
 moveq #82,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
L06738 movem.l -4(a5),a0
 unlk a5
 rts 
L06742 link.w a5,#0
 movem.l a0/a2/d0-d1,-(sp)
 movea.l 4(sp),a0
 move.l 130(a0),d0
 movea.l 4(sp),a0
 move.w 134(a0),d1
 ext.l d1
 lsl.l #3,d1
 add.l d1,d0
 movea.l d0,a2
 movea.l 4(sp),a0
 tst.w 136(a0)
 beq.s L06790
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.l 178(a0),-(sp)
 movea.l _01948(a6),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 movea.l 178(a0),a0
 move.l 48(a0),d0
 jsr _0193a(a6)
 addq.l #8,sp
 bra.s L067f8
L06790 movea.l 4(sp),a0
 movea.w 110(a0),a0
 move.l a0,-(sp)
 movea.l 8(sp),a0
 movea.w 108(a0),a0
 move.l a0,-(sp)
 movea.w 6(a2),a0
 move.l a0,-(sp)
 movea.w 4(a2),a0
 move.l a0,-(sp)
 movea.w 2(a2),a0
 move.l a0,-(sp)
 movea.w (a2),a0
 move.l a0,-(sp)
 moveq #28,d0
 add.l 28(sp),d0
 move.l d0,d1
 moveq #68,d0
 add.l 28(sp),d0
 bsr.w L074fc
 lea 24(sp),sp
 moveq #8,d1
 movea.l D00028(a6),a0
 movea.l 178(a0),a0
 move.l 48(a0),d0
 jsr _0191c(a6)
L067e2 bsr.w L08ba2
 moveq #13,d1
 asr.l d1,d0
 movea.l 4(sp),a0
 move.w d0,134(a0)
 cmpi.w #4,d0
 bgt.s L067e2
L067f8 movem.l -8(a5),a0/a2
 unlk a5
L06800 rts 
L06802 link.w a5,#0
 movem.l a0/a2/d0-d1,-(sp)
 movea.l D00028(a6),a0
 movea.l 178(a0),a2
 pea (L0007a).w
 movea.l D00028(a6),a0
 move.l 6780(a0),d1
 movea.l 8(sp),a0
 move.l 20(a0),d0
 jsr _01934(a6)
 addq.l #4,sp
 movea.l 4(sp),a0
 move.w #90,108(a0)
 movea.l 4(sp),a0
 move.w #92,110(a0)
 movea.l 4(sp),a0
 clr.w 112(a0)
 clr.l -(sp)
 move.l 8(sp),-(sp)
 lea L06742(pc),a0
 move.l a0,d1
 move.l 48(a2),d0
 jsr _0193a(a6)
 addq.l #8,sp
 movea.l 4(sp),a0
 clr.w 134(a0)
 move.l 4(sp),-(sp)
 lea L06742(pc),a0
 move.l a0,d1
 move.l 4(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
 movea.l 4(sp),a0
 clr.w 136(a0)
 bsr.w L081f6
 moveq #1,d0
 bsr.w L081b2
 clr.w _00de4(a6)
 movem.l -8(a5),a0/a2
 unlk a5
 rts 
L0689a link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4,-(sp)
 movea.l 4(sp),a0
 move.w #252,82(a0)
 movea.l 4(sp),a0
 movea.l (a0),a0
 pea 4(a0)
 pea (L00100).w
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 bsr.w L02672
 lea 16(sp),sp
 movea.l 4(sp),a0
 move.l 12(a0),d0
 jsr _017e4(a6)
 movea.l 4(sp),a0
 move.l 894(a0),d0
 jsr _017e4(a6)
 lea L06d3c(pc),a0
 move.l a0,d1
 movea.l 4(sp),a0
 move.l 894(a0),d0
 jsr _017de(a6)
 movea.l 4(sp),a0
 move.l d0,898(a0)
 lea L06d44(pc),a0
 move.l a0,d1
 movea.l 4(sp),a0
 move.l 12(a0),d0
 jsr _017de(a6)
 movea.l 4(sp),a0
 move.l d0,20(a0)
 lea L06d49(pc),a0
 move.l a0,d1
 movea.l 4(sp),a0
 move.l 12(a0),d0
 jsr _017de(a6)
 movea.l 4(sp),a0
 move.l d0,16(a0)
 lea L06d4e(pc),a0
 move.l a0,d1
 movea.l 4(sp),a0
 move.l 12(a0),d0
 jsr _017d8(a6)
 movea.l d0,a2
 lea L06d53(pc),a0
 move.l a0,d1
 movea.l 4(sp),a0
 move.l 12(a0),d0
 jsr _017de(a6)
 movea.l 4(sp),a0
 move.l d0,130(a0)
 move.l 8(a2),-(sp)
 movea.l 8(sp),a0
 pea 28(a0)
 movea.l 12(sp),a0
 pea 68(a0)
 moveq #0,d1
 movea.l 16(sp),a0
 move.l 20(a0),d0
 jsr _0192e(a6)
 lea 12(sp),sp
 movea.l 4(sp),a0
 movea.l 20(a0),a3
 moveq #0,d4
 bra.s L069ca
L069ba moveq #0,d1
 move.l a3,d0
 jsr _01922(a6)
 addq.l #1,d4
 adda.l #122,a3
L069ca cmp.l 8(a2),d4
 bcs.s L069ba
 move.l 8(a2),-(sp)
 pea _00d04(a6)
 moveq #4,d1
 movea.l 12(sp),a0
 move.l 20(a0),d0
 bsr.w L08304
 addq.l #8,sp
 lea L0827c(pc),a0
 move.l a0,_012da(a6)
 movea.l 4(sp),a0
 movea.l 20(a0),a0
 move.w 252(a0),d0
 ext.l d0
 movea.l 4(sp),a0
 movea.l 20(a0),a0
 move.w 256(a0),d1
 ext.l d1
 sub.l d0,d1
 bge.s L06a12
 addq.l #1,d1
L06a12 asr.l #1,d1
 movea.l 4(sp),a0
 movea.l 20(a0),a0
 move.w 252(a0),d0
 ext.l d0
 add.l d0,d1
 move.l d1,-(sp)
 movea.l 8(sp),a0
 movea.l 20(a0),a0
 move.w 250(a0),d0
 ext.l d0
 movea.l 8(sp),a0
 movea.l 20(a0),a0
 move.w 254(a0),d1
 ext.l d1
 sub.l d0,d1
 bge.s L06a48
 addq.l #1,d1
L06a48 asr.l #1,d1
 movea.l 8(sp),a0
 movea.l 20(a0),a0
 move.w 250(a0),d0
 ext.l d0
 add.l d0,d1
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _01940(a6)
 addq.l #4,sp
 movea.l 4(sp),a0
 movea.l 20(a0),a0
 move.w 250(a0),d0
 ext.l d0
 movea.l 4(sp),a0
 movea.l 20(a0),a0
 move.w 254(a0),d1
 ext.l d1
 sub.l d0,d1
 bge.s L06a8a
 addq.l #1,d1
L06a8a asr.l #1,d1
 movea.l 4(sp),a0
 movea.l 20(a0),a0
 add.w 250(a0),d1
 movea.l D00028(a6),a0
 movea.l 4(a0),a0
 movea.l 38(a0),a0
 move.w d1,98(a0)
 movea.l 4(sp),a0
 movea.l 20(a0),a0
 move.w 252(a0),d0
 ext.l d0
 movea.l 4(sp),a0
 movea.l 20(a0),a0
 move.w 256(a0),d1
 ext.l d1
 sub.l d0,d1
 bge.s L06aca
 addq.l #1,d1
L06aca asr.l #1,d1
 movea.l 4(sp),a0
 movea.l 20(a0),a0
 add.w 252(a0),d1
 movea.l D00028(a6),a0
 movea.l 4(a0),a0
 movea.l 38(a0),a0
 move.w d1,100(a0)
 movea.l 4(sp),a0
 movea.l 20(a0),a0
 move.w 250(a0),d0
 ext.l d0
 movea.l 4(sp),a0
 movea.l 20(a0),a0
 move.w 254(a0),d1
 ext.l d1
 sub.l d0,d1
 bge.s L06b0a
 addq.l #1,d1
L06b0a asr.l #1,d1
 movea.l 4(sp),a0
 movea.l 20(a0),a0
 add.w 250(a0),d1
 movea.l D00028(a6),a0
 movea.l 4(a0),a0
 movea.l 38(a0),a0
 move.w d1,22(a0)
 movea.l 4(sp),a0
 movea.l 20(a0),a0
 move.w 252(a0),d0
 ext.l d0
 movea.l 4(sp),a0
 movea.l 20(a0),a0
 move.w 256(a0),d1
 ext.l d1
 sub.l d0,d1
 bge.s L06b4a
 addq.l #1,d1
L06b4a asr.l #1,d1
 movea.l 4(sp),a0
 movea.l 20(a0),a0
 add.w 252(a0),d1
 movea.l D00028(a6),a0
 movea.l 4(a0),a0
 movea.l 38(a0),a0
 move.w d1,24(a0)
 pea (L00003).w
 clr.l -(sp)
 move.l 12(sp),-(sp)
 pea L06802(pc)
 pea (L0003f).w
 moveq #0,d1
 moveq #82,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 movem.l -16(a5),a0/a2-a3/d4
 unlk a5
 rts 
L06b94 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 clr.l -(sp)
 clr.l -(sp)
 pea (L00800).w
 movea.l 16(sp),a0
 move.l (a0),-(sp)
 move.l #5978,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5956,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 pea (L01800).w
 movea.l 16(sp),a0
 move.l 12(a0),-(sp)
 move.l #6000,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5978,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 pea (L00800).w
 movea.l 16(sp),a0
 move.l 894(a0),-(sp)
 moveq #0,d1
 move.l #6000,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 movea.l 16(sp),a0
 move.l 32(a0),-(sp)
 move.l #5670,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5648,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 movea.l 16(sp),a0
 move.l 4(a0),-(sp)
 move.l #5692,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5670,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 movea.l 16(sp),a0
 move.l 8(a0),-(sp)
 moveq #0,d1
 move.l #5692,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #48384,-(sp)
 movea.l 16(sp),a0
 move.l 890(a0),-(sp)
 moveq #0,d1
 move.l #5780,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 movea.l D00028(a6),a0
 pea 5956(a0)
 movea.l D00028(a6),a0
 pea 5780(a0)
 move.l #5648,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01700(a6)
 addq.l #8,sp
 lea L0689a(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6396(a1)
 movea.l D00028(a6),a0
 move.l 4(sp),6400(a0)
 andi.w #$feff,_011ba(a6)
 lea L06d59(pc),a0
 move.l a0,d1
 move.l #6188,d0
 add.l D00028(a6),d0
 jsr _0170c(a6)
 moveq #1,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01706(a6)
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L06d3c ble.s L06da4
 dc.w $6673
 bcs.s L06db6
 dc.w $7300
L06d44 dc.w $6b65
 dc.w $7973
 ori.w #$6f6e,-(a6)
L06d49 equ *-3
 moveq #0,d2
L06d4e dc.w $6b65
 dc.w $7973
 ori.w #$6c61,-(a6)
L06d53 equ *-3
 dc.w $6d65
 ori.w #$6e74,-(a5)
L06d59 equ *-3
 dc.w $0
L06d5e link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4-d6,-(sp)
 movea.l D00028(a6),a0
 movea.l 166(a0),a2
 movea.l D00028(a6),a0
 movea.l 162(a0),a3
 moveq #0,d4
 moveq #0,d5
 move.l (a2),d6
 addq.l #4,a2
 bra.w L06dfc
L06d82 btst.b #7,(a2)
 beq.s L06de8
 tst.b 1(a2)
 beq.s L06dba
 moveq #0,d0
 move.b 1(a2),d0
 move.l d0,-(sp)
 moveq #127,d0
 and.b (a2),d0
 moveq #0,d1
 move.b d0,d1
 move.l a3,d0
 jsr _016ac(a6)
L06da4 addq.l #4,sp
 addq.l #2,d5
 moveq #0,d0
 move.b 1(a2),d0
 add.l d0,d4
 addq.l #1,a2
 moveq #0,d0
 move.b (a2),d0
L06db6 adda.l d0,a3
 bra.s L06de4
L06dba move.l #384,d0
 sub.l d4,d0
 move.l d0,-(sp)
 moveq #127,d0
 and.b (a2),d0
 moveq #0,d1
 move.b d0,d1
 move.l a3,d0
 jsr _016ac(a6)
 addq.l #4,sp
 move.l #384,d0
 sub.l d4,d0
 adda.l d0,a3
 addq.l #2,d5
 moveq #0,d4
 addq.l #1,a2
L06de4 addq.l #1,a2
 bra.s L06dfc
L06de8 move.b (a2),(a3)
 addq.l #1,a3
 addq.l #1,a2
 addq.l #1,d5
 addq.l #1,d4
 cmpi.l #384,d4
 blt.s L06dfc
 moveq #0,d4
L06dfc cmp.l d6,d5
 bcs.w L06d82
 movem.l -28(a5),a0/a2-a3/d1/d4-d6
 unlk a5
 rts 
L06e0c link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 pea L08bea(pc)
 movea.l D00028(a6),a0
 move.l 4038(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 162(a0),d1
 lea L07462(pc),a0
 move.l a0,d0
 jsr _0194c(a6)
 lea 20(sp),sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L06e46 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 pea L07467(pc)
 pea L0746c(pc)
 pea L07471(pc)
 clr.l -(sp)
 pea L06e0c(pc)
 movea.l D00028(a6),a0
 move.l 4806(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 4830(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 166(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 4038(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 6798(a0),-(sp)
 movea.l D00028(a6),a0
 move.l #47040,d0
 add.l 162(a0),d0
 move.l d0,d1
 movea.l D00028(a6),a0
 move.l 162(a0),d0
 bsr.w L07122
 lea 40(sp),sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L06eb2 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 pea (L00005).w
 pea (L00005).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 move.l D00028(a6),d0
 jsr _016d6(a6)
 addq.l #8,sp
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 move.l D00028(a6),d0
 jsr _016e8(a6)
 addq.l #4,sp
 clr.l -(sp)
 clr.l -(sp)
 movea.l 12(sp),a0
 move.l 28(a0),-(sp)
 movea.l 16(sp),a0
 move.l 24(a0),-(sp)
 movea.l 20(sp),a0
 move.l 16(a0),-(sp)
 movea.l 24(sp),a0
 move.l 12(a0),d1
 movea.l 24(sp),a0
 move.l 42(a0),d0
 jsr _0194c(a6)
 lea 20(sp),sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L06f3e link.w a5,#0
 movem.l d0-d1,-(sp)
 pea (L00003).w
 pea (L00002).w
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 moveq #63,d1
 moveq #82,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 pea (L00003).w
 pea (L00002).w
 move.l 12(sp),-(sp)
 pea L06eb2(pc)
 clr.l -(sp)
 moveq #63,d1
 moveq #122,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 unlk a5
 rts 
L06f8a link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 movea.l 4(sp),a0
 movea.l 20(a0),a0
 pea 4(a0)
 pea (L00080).w
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 bsr.w L02672
 lea 16(sp),sp
 movea.l 4(sp),a0
 move.l 4(a0),-(sp)
 pea L0e580(pc)
 move.l #94080,-(sp)
 movea.l 16(sp),a0
 move.l 4(a0),-(sp)
 move.l #5670,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5648,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 movea.l 4(sp),a0
 move.l 8(a0),-(sp)
 pea L0e580(pc)
 move.l #94080,-(sp)
 movea.l 16(sp),a0
 move.l 8(a0),-(sp)
 move.l #5692,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5670,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 movea.l 4(sp),a0
 move.l (a0),-(sp)
 pea L0e580(pc)
 move.l #94080,-(sp)
 movea.l 16(sp),a0
 move.l (a0),-(sp)
 move.l #5648,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5692,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 lea L06f3e(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6396(a1)
 movea.l D00028(a6),a0
 move.l 4(sp),6400(a0)
 clr.l -(sp)
 clr.l -(sp)
 move.l #5648,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01700(a6)
 addq.l #8,sp
 movea.l 4(sp),a0
 move.l 38(a0),d1
 move.l #6222,d0
 add.l D00028(a6),d0
 jsr _0170c(a6)
 moveq #1,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01706(a6)
 pea (L00003).w
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 pea (L0003f).w
 moveq #60,d1
 moveq #82,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 pea (L00003).w
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 pea (L0003f).w
 moveq #60,d1
 moveq #122,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L07122 link.w a5,#0
 movem.l a0-a4/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 movea.l 52(sp),a4
 move.l 56(sp),d4
 move.l 60(sp),d5
 move.l 64(sp),d6
 move.l 68(sp),d7
 lea -12(sp),sp
 moveq #82,d0
 add.l D00028(a6),d0
 move.l d0,8(sp)
 moveq #122,d0
 add.l D00028(a6),d0
 move.l d0,4(sp)
 pea (L0002e).w
 moveq #0,d1
 move.l d7,d0
 jsr _016ac(a6)
 addq.l #4,sp
 movea.l d7,a0
 move.l a2,(a0)
 movea.l d7,a0
 move.l a3,4(a0)
 movea.l d7,a0
 move.l a4,8(a0)
 movea.l d7,a0
 move.l d5,12(a0)
 movea.l d7,a0
 move.l d4,16(a0)
 movea.l d7,a0
 move.l d6,20(a0)
 movea.l d7,a0
 move.l 84(sp),24(a0)
 movea.l d7,a0
 move.l 88(sp),28(a0)
 movea.l d7,a0
 move.l 92(sp),34(a0)
 movea.l d7,a0
 move.l 96(sp),38(a0)
 movea.l d7,a0
 move.l 100(sp),42(a0)
 movea.l 8(sp),a0
 move.l a2,4(a0)
 movea.l 4(sp),a0
 move.l d4,4(a0)
 movea.l 8(sp),a0
 move.l #268370175,8(a0)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 move.l D00028(a6),d0
 jsr _01952(a6)
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d1
 move.l D00028(a6),d0
 jsr _01952(a6)
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L07214
 moveq #1,d0
 bra.s L07216
L07214 moveq #0,d0
L07216 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 move.l D00028(a6),d0
 jsr _01952(a6)
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L07236
 moveq #1,d0
 bra.s L07238
L07236 moveq #0,d0
L07238 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d1
 move.l D00028(a6),d0
 jsr _01952(a6)
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016ee(a6)
 moveq #1,d1
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L07274
 moveq #1,d0
 bra.s L07276
L07274 moveq #0,d0
L07276 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016ee(a6)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 moveq #0,d0
 jsr _016e2(a6)
 move.l D00028(a6),-(sp)
 pea (L00028).w
 moveq #0,d1
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d0
 jsr _016d0(a6)
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),d0
 jsr _016d0(a6)
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #82,d0
 add.l D00028(a6),d0
 move.l d0,d1
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 jsr _016dc(a6)
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #122,d0
 add.l D00028(a6),d0
 move.l d0,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016dc(a6)
 addq.l #8,sp
 pea (L00005).w
 pea (L00003).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 move.l D00028(a6),d0
 jsr _016d6(a6)
 addq.l #8,sp
 pea (L00001).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 move.l D00028(a6),d0
 jsr _016e8(a6)
 addq.l #4,sp
 clr.l -(sp)
 clr.l -(sp)
 pea (L00800).w
 move.l d6,-(sp)
 moveq #0,d1
 move.l #5956,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 pea (a2)
 move.l #5670,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5648,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 move.l d4,-(sp)
 moveq #0,d1
 move.l #5670,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 lea L06f8a(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6396(a1)
 movea.l D00028(a6),a0
 move.l d7,6400(a0)
 andi.w #$feff,_011ba(a6)
 movea.l D00028(a6),a0
 pea 5956(a0)
 clr.l -(sp)
 move.l #5648,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01700(a6)
 addq.l #8,sp
 move.l 92(sp),d1
 move.l #6222,d0
 add.l D00028(a6),d0
 jsr _0170c(a6)
 move.l d0,(sp)
 moveq #255,d0
 cmp.l (sp),d0
 bne.s L07444
 moveq #0,d0
 jsr _01958(a6)
L07444 moveq #1,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01706(a6)
 lea 12(sp),sp
 movem.l -36(a5),a0-a4/d4-d7
 unlk a5
 rts 
L07462 bls.s L074d6
 bcs.s L074ca
 ori.w #$616e,-(sp)
L07467 equ *-3
 move.w d0,-(a2)
L0746c dc.w $6761
 bgt.s L074a4
 ori.w #$616e,-(sp)
L07471 equ *-3
 move.w (sp)+,26880(a1)
L07478 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l 48(sp),d4
 move.l 52(sp),d5
 move.l 4(a2),d0
 move.w d4,d1
 ext.l d1
 add.l d1,d0
 move.w 14(a2),d1
 muls.w d5,d1
 add.l d1,d0
 movea.l d0,a4
 move.l 4(a3),d0
L074a4 move.w 66(sp),d1
 ext.l d1
 add.l d1,d0
 move.w 14(a3),d1
 muls.w 70(sp),d1
 add.l d1,d0
 move.l d0,d7
 moveq #0,d6
 bra.s L074e8
L074bc move.b 75(sp),d0
 ext.w d0
 ext.l d0
 move.l d0,-(sp)
 movea.w 62(sp),a0
L074ca move.l a0,-(sp)
 move.l a4,d1
 move.l d7,d0
 jsr _0195e(a6)
 addq.l #8,sp
L074d6 addq.l #1,d6
 move.w 14(a2),d0
 ext.l d0
 adda.l d0,a4
 move.w 14(a3),d0
 ext.l d0
 add.l d0,d7
L074e8 move.w 62(sp),d0
 ext.l d0
 cmp.l d6,d0
 bhi.s L074bc
 movem.l -32(a5),a0/a2-a4/d4-d7
 unlk a5
 rts 
L074fc link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4,-(sp)
 movea.l (sp),a0
 move.l 4(a0),d0
 move.w 34(sp),d1
 ext.l d1
 add.l d1,d0
 movea.l (sp),a0
 move.w 14(a0),d1
 muls.w 38(sp),d1
 add.l d1,d0
 movea.l d0,a2
 movea.l 4(sp),a0
 move.l 4(a0),d0
 move.w 50(sp),d1
 ext.l d1
 add.l d1,d0
 movea.l 4(sp),a0
 move.w 14(a0),d1
 muls.w 54(sp),d1
 add.l d1,d0
 movea.l d0,a3
 moveq #0,d4
 bra.s L0756c
L07544 movea.w 42(sp),a0
 move.l a0,-(sp)
 move.l a2,d1
 move.l a3,d0
 jsr _017c6(a6)
 addq.l #4,sp
 addq.l #1,d4
 movea.l (sp),a0
 move.w 14(a0),d0
 ext.l d0
 adda.l d0,a2
 movea.l 4(sp),a0
 move.w 14(a0),d0
 ext.l d0
 adda.l d0,a3
L0756c move.w 46(sp),d0
 ext.l d0
 cmp.l d4,d0
 bhi.s L07544
 movem.l -16(a5),a0/a2-a3/d4
 unlk a5
 rts 
L07580 link.w a5,#0
 movem.l a0/a2/d0-d1/d4,-(sp)
 movea.l (sp),a0
 move.l 4(a0),d0
 move.w 6(sp),d1
 ext.l d1
 add.l d1,d0
 movea.l (sp),a0
 move.w 14(a0),d1
 muls.w 30(sp),d1
 add.l d1,d0
 movea.l d0,a2
 moveq #0,d4
 bra.s L075ca
L075a8 movea.w 34(sp),a0
 move.l a0,-(sp)
 moveq #0,d0
 move.b 47(sp),d0
 move.l d0,d1
 move.l a2,d0
 jsr _016ac(a6)
 addq.l #4,sp
 addq.l #1,d4
 movea.l (sp),a0
 move.w 14(a0),d0
 ext.l d0
 adda.l d0,a2
L075ca move.w 38(sp),d0
 ext.l d0
 cmp.l d4,d0
 bhi.s L075a8
 movem.l -12(a5),a0/a2/d4
 unlk a5
 rts 
L075de link.w a5,#0
 movem.l a0/a2-a3/d0-d1,-(sp)
 movea.l (sp),a2
 bra.s L0763a
L075ea move.b (a2),d0
 ext.w d0
 subi.w #55,d0
 ext.l d0
 lsl.l #3,d0
 add.l 40(sp),d0
 movea.l d0,a3
 movea.w 30(sp),a0
 move.l a0,-(sp)
 movea.w 10(sp),a0
 move.l a0,-(sp)
 movea.w 6(a3),a0
 move.l a0,-(sp)
 movea.w 4(a3),a0
 move.l a0,-(sp)
 movea.w 2(a3),a0
 move.l a0,-(sp)
 movea.w (a3),a0
 move.l a0,-(sp)
 move.l 60(sp),d1
 move.l 56(sp),d0
 bsr.w L074fc
 lea 24(sp),sp
 move.w 4(a3),d0
 addq.w #1,d0
 add.w d0,6(sp)
 addq.l #1,a2
L0763a tst.b (a2)
 bne.s L075ea
 movem.l -12(a5),a0/a2-a3
 unlk a5
 rts 
L07648 link.w a5,#0
 movem.l a2-a3/d0-d1/d4,-(sp)
 movea.l (sp),a2
 moveq #0,d4
 bra.s L07674
L07656 move.b (a2),d0
 ext.w d0
 subi.w #55,d0
 ext.l d0
 lsl.l #3,d0
 add.l 4(sp),d0
 movea.l d0,a3
 move.w 4(a3),d0
 ext.l d0
 addq.l #1,d0
 add.l d0,d4
 addq.l #1,a2
L07674 tst.b (a2)
 bne.s L07656
 move.l d4,d0
 movem.l -12(a5),a2-a3/d4
 unlk a5
 rts 
L07684 link.w a5,#0
 movem.l a0/d0-d1/d4-d5,-(sp)
 movea.l (sp),a0
 move.w 44(a0),d0
 movea.l (sp),a0
 movea.l (a0),a0
 move.w 2(a0),d1
 asr.w #1,d1
 add.w d1,d0
 move.w #192,d1
 sub.w d0,d1
 move.w d1,d4
 tst.w d4
 bge.s L076bc
 ext.l d4
 move.l d4,d0
 jsr _0196a(a6)
 asr.l #3,d0
 move.w d0,d5
 moveq #0,d0
 move.w d5,d0
 bra.s L076cc
L076bc tst.w d4
 blt.s L076de
 move.w d4,d0
 asr.w #3,d0
 move.w d0,d5
 moveq #0,d0
 move.w d5,d0
 lsl.l #8,d0
L076cc or.l 4(sp),d0
 move.l d0,d1
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _017ea(a6)
L076de movem.l -12(a5),a0/d4-d5
 unlk a5
 rts 
L076e8 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 lea L07f30(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 4868(a0),d0
 jsr _017de(a6)
 movea.l D00028(a6),a0
 move.l d0,6938(a0)
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
L07714 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 moveq #2,d0
 cmp.l 4(sp),d0
 bne.s L0772e
 movea.l (sp),a0
 andi.b #$40,30(a0)
 bra.s L07746
L0772e moveq #5,d0
 cmp.l 4(sp),d0
 bne.s L07746
 movea.l (sp),a0
 andi.b #$40,30(a0)
 movea.l (sp),a0
 ori.b #$45,30(a0)
L07746 movem.l -4(a5),a0
 unlk a5
 rts 
L07750 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d7,-(sp)
 move.l d0,d4
 movea.l d1,a2
 movea.l 48(sp),a3
 move.l 52(sp),d5
 move.l d4,d0
 moveq #6,d1
 jsr _016a0(a6)
 add.l a3,d0
 move.l d0,d6
 movea.l D00028(a6),a0
 move.l 6946(a0),d7
 movea.l d6,a0
 move.l (a0),d0
 add.l a2,d0
 movea.l d0,a4
 movea.l d7,a0
 move.l a4,10(a0)
 movea.l d6,a0
 moveq #18,d0
 muls.w 4(a0),d0
 movea.l d7,a0
 move.w d0,26(a0)
 movea.l d6,a0
 move.w #2304,d0
 muls.w 4(a0),d0
 movea.l d7,a0
 move.l d0,14(a0)
 pea (L00001).w
 movea.l d6,a0
 moveq #18,d0
 muls.w 4(a0),d0
 subq.l #1,d0
 move.l d0,-(sp)
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.l 6930(a0),d1
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _01988(a6)
 lea 12(sp),sp
 move.l d5,d1
 move.l d7,d0
 bsr.w L07714
 movea.l D00028(a6),a0
 pea 6922(a0)
 movea.l D00028(a6),a0
 move.l 6930(a0),d1
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _0198e(a6)
 addq.l #4,sp
 movem.l -32(a5),a0/a2-a4/d4-d7
 unlk a5
 rts 
L077fe link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d5,-(sp)
 move.l d0,d4
 move.l d1,d5
 movea.l 40(sp),a2
 movea.l D00028(a6),a0
 tst.w 6984(a0)
 bne.w L07896
 tst.l d4
 bne.s L07828
 movea.l D00028(a6),a0
 tst.l 6978(a0)
 bne.s L07896
L07828 move.l a2,d0
 beq.s L07836
 moveq #0,d1
 move.l a2,d0
 bsr.w L07684
 bra.s L07844
L07836 moveq #0,d1
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _017ea(a6)
L07844 tst.l d4
 bne.s L07864
 move.l d5,d0
 moveq #6,d1
 jsr _016a0(a6)
 movea.l D00028(a6),a0
 add.l 6938(a0),d0
 movea.l d0,a4
 movea.l D00028(a6),a0
 move.l 6954(a0),d0
 bra.s L07880
L07864 move.l d5,d0
 moveq #6,d1
 jsr _016a0(a6)
 movea.l D00028(a6),a0
 add.l 6942(a0),d0
 movea.l d0,a4
 movea.l D00028(a6),a0
 move.l 6958(a0),d0
 addq.l #8,d0
L07880 add.l (a4),d0
 movea.l d0,a3
 movea.l D00028(a6),a0
 move.l a3,6978(a0)
 movea.l D00028(a6),a0
 move.b 5(a4),6982(a0)
L07896 movem.l -24(a5),a0/a2-a4/d4-d5
 unlk a5
 rts 
L078a0 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4,-(sp)
 move.l d0,d4
 movea.l d1,a2
 movea.l D00028(a6),a0
 movea.l 6946(a0),a3
 movea.l D00028(a6),a0
 move.l 6970(a0),10(a3)
 move.w #90,26(a3)
 move.l #11520,14(a3)
 pea (L02710).w
 pea (L00059).w
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.l 6930(a0),d1
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _01988(a6)
 lea 12(sp),sp
 movea.l D00028(a6),a0
 pea 6922(a0)
 movea.l D00028(a6),a0
 move.l 6930(a0),d1
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _0198e(a6)
 addq.l #4,sp
 movem.l -16(a5),a0/a2-a3/d4
 unlk a5
 rts 
L07916 link.w a5,#0
 movem.l a0/a2/d0-d1,-(sp)
 movea.l D00028(a6),a0
 movea.l 6950(a0),a2
 movea.l D00028(a6),a0
 move.l 6974(a0),d0
 addq.l #8,d0
 move.l d0,10(a2)
 move.w #144,26(a2)
 move.l #18432,14(a2)
 pea (L02710).w
 pea (L0007d).w
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.l 6934(a0),d1
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _01988(a6)
 lea 12(sp),sp
 movea.l D00028(a6),a0
 pea 6926(a0)
 movea.l D00028(a6),a0
 move.l 6934(a0),d1
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _0198e(a6)
 addq.l #4,sp
 movem.l -12(a5),a0/a2/d1
 unlk a5
 rts 
L0798c link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4,-(sp)
 move.l d0,d4
 movea.l d1,a2
 movea.l D00028(a6),a0
 movea.l 6950(a0),a3
 movea.l D00028(a6),a0
 move.l 6974(a0),d0
 addq.l #8,d0
 move.l d0,10(a3)
 move.w #144,26(a3)
 move.l #18432,14(a3)
 pea (L02710).w
 pea (L0007d).w
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.l 6934(a0),d1
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _01988(a6)
 lea 12(sp),sp
 movea.l D00028(a6),a0
 pea 6926(a0)
 movea.l D00028(a6),a0
 move.l 6934(a0),d1
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _0198e(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 tst.w 6984(a0)
 beq.s L07a34
 movea.l D00028(a6),a0
 clr.w 6984(a0)
 movea.l D00028(a6),a0
 tst.l 6986(a0)
 beq.s L07a26
 movea.l D00028(a6),a0
 move.l 6986(a0),d1
 moveq #4,d0
 bsr.w L00856
L07a26 moveq #0,d1
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _017ea(a6)
L07a34 moveq #0,d1
 movea.l D00028(a6),a0
 move.l 4848(a0),d0
 bsr.w L07b7c
 movea.l D00028(a6),a0
 clr.l 6978(a0)
 movea.l D00028(a6),a0
 clr.b 6982(a0)
 movem.l -16(a5),a0/a2-a3/d4
 unlk a5
 rts 
L07a5c link.w a5,#0
 movem.l a0/a2-a3/d0-d1,-(sp)
 subq.l #8,sp
 movea.l 12(sp),a0
 movea.l 16(a0),a2
 movea.l D00028(a6),a0
 movea.l 6946(a0),a3
 movea.l D00028(a6),a0
 tst.l 6978(a0)
 beq.s L07af4
 movea.l D00028(a6),a0
 move.l 6978(a0),(sp)
 move.l a2,4(sp)
 movea.l D00028(a6),a0
 tst.w 6984(a0)
 bne.s L07aa0
 lea (sp),a0
 move.l a0,d0
 bsr.w L07f38
 bra.s L07aa8
L07aa0 lea (sp),a0
 move.l a0,d0
 bsr.w L07ff8
L07aa8 movea.l D00028(a6),a0
 subq.b #1,6982(a0)
 movea.l D00028(a6),a0
 addi.l #$00000900,6978(a0)
 movea.l D00028(a6),a0
 tst.b 6982(a0)
 bne.s L07af4
 movea.l D00028(a6),a0
 clr.l 6978(a0)
 movea.l D00028(a6),a0
 tst.w 6984(a0)
 beq.s L07af4
 movea.l D00028(a6),a0
 move.l 6974(a0),d0
 addq.l #8,d0
 movea.l D00028(a6),a0
 move.l d0,6978(a0)
 movea.l D00028(a6),a0
 move.b #7,6982(a0)
L07af4 movea.l D00028(a6),a0
 tst.w 6984(a0)
 beq.s L07b12
 movea.l D00028(a6),a0
 move.l 6290(a0),d0
 jsr _01964(a6)
 movea.l D00028(a6),a0
 move.l d0,6990(a0)
L07b12 addq.l #8,sp
 movem.l -12(a5),a0/a2-a3
 unlk a5
 rts 
L07b1e link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 subq.l #4,sp
 move.l 4(sp),d0
 jsr _01976(a6)
 move.l d0,(sp)
 movea.l D00028(a6),a0
 move.l 6994(a0),d0
 movea.l 4(sp),a0
 move.w 32(a0),d1
 ext.l d1
 jsr _016a0(a6)
 movea.l 4(sp),a0
 add.l 24(a0),d0
 move.l d0,d1
 move.l 4(sp),d0
 jsr _0197c(a6)
 move.l d0,(sp)
 clr.l -(sp)
 move.l 12(sp),d1
 movea.l 8(sp),a0
 move.l (a0),d0
 jsr _01970(a6)
 addq.l #4,sp
 move.l d0,(sp)
 addq.l #4,sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L07b7c link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 moveq #0,d1
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _017ea(a6)
 movea.l D00028(a6),a0
 move.l 6970(a0),-(sp)
 clr.l -(sp)
 pea (L00900).w
 movea.l D00028(a6),a0
 move.l 6970(a0),-(sp)
 move.l #5802,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5780,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 pea (L00900).w
 movea.l D00028(a6),a0
 movea.l 6970(a0),a0
 pea 2304(a0)
 move.l #5824,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5802,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 pea L078a0(pc)
 pea (L00900).w
 movea.l D00028(a6),a0
 movea.l 6970(a0),a0
 pea 4608(a0)
 move.l #5846,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5824,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 movea.l D00028(a6),a0
 movea.l 6970(a0),a0
 pea 6912(a0)
 pea L07a5c(pc)
 pea (L00900).w
 movea.l D00028(a6),a0
 movea.l 6970(a0),a0
 pea 6912(a0)
 move.l #5868,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5846,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 movea.l D00028(a6),a0
 movea.l 6970(a0),a0
 pea 9216(a0)
 pea L07a5c(pc)
 pea (L00900).w
 movea.l D00028(a6),a0
 movea.l 6970(a0),a0
 pea 9216(a0)
 move.l #5890,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5868,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 movea.l D00028(a6),a0
 move.l 6970(a0),-(sp)
 pea L07a5c(pc)
 pea (L00900).w
 movea.l D00028(a6),a0
 move.l 6970(a0),-(sp)
 move.l #5912,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5890,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 movea.l D00028(a6),a0
 movea.l 6970(a0),a0
 pea 2304(a0)
 pea L07a5c(pc)
 pea (L00900).w
 movea.l D00028(a6),a0
 movea.l 6970(a0),a0
 pea 2304(a0)
 move.l #5934,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5912,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 movea.l D00028(a6),a0
 movea.l 6970(a0),a0
 pea 4608(a0)
 pea L07a5c(pc)
 pea (L00900).w
 movea.l D00028(a6),a0
 movea.l 6970(a0),a0
 pea 4608(a0)
 move.l #5846,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5934,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 movea.l D00028(a6),a0
 pea 5780(a0)
 moveq #0,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01700(a6)
 addq.l #8,sp
 ori.w #$0190,_011ba(a6)
 tst.l 4(sp)
 bne.s L07d94
 move.l (sp),d1
 move.l #6256,d0
 add.l D00028(a6),d0
 jsr _0170c(a6)
 bra.s L07dc6
L07d94 moveq #1,d0
 cmp.l 4(sp),d0
 bne.s L07db6
 move.l (sp),d1
 move.l #6290,d0
 add.l D00028(a6),d0
 jsr _01982(a6)
 movea.l D00028(a6),a0
 move.l (sp),6994(a0)
 bra.s L07dc6
L07db6 move.l (sp),d1
 move.l #6290,d0
 add.l D00028(a6),d0
 bsr.w L07b1e
L07dc6 lea L0798c(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6396(a1)
 movea.l D00028(a6),a0
 move.l (sp),6400(a0)
 moveq #1,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01706(a6)
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L07df4 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 movea.l D00028(a6),a0
 tst.w 6984(a0)
 bne.w L07eb8
 movea.l D00028(a6),a0
 movea.l D00028(a6),a1
 move.l 6986(a1),d0
 cmp.l 5018(a0),d0
 bne.s L07e1e
 clr.l 4(sp)
L07e1e movea.l D00028(a6),a0
 move.l 4(sp),6986(a0)
 movea.l D00028(a6),a0
 tst.b 5009(a0)
 beq.s L07e50
 movea.l D00028(a6),a0
 move.b #1,5008(a0)
 movea.l D00028(a6),a0
 move.w 2(sp),5010(a0)
 movea.l D00028(a6),a0
 clr.b 5009(a0)
 bra.s L07eb8
L07e50 bsr.w L07916
 bsr.w L0c834
 moveq #1,d1
 movea.l D00028(a6),a0
 movea.l 4852(a0),a0
 move.l (a0),d0
 add.l (sp),d0
 bsr.w L07b7c
 tst.l 4(sp)
 beq.s L07e80
 move.l #252641280,d1
 move.l 4(sp),d0
 bsr.w L07684
 bra.s L07e92
L07e80 move.l #252641280,d1
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _017ea(a6)
L07e92 movea.l D00028(a6),a0
 move.w #1,6984(a0)
 movea.l D00028(a6),a0
 move.l 6974(a0),d0
 addq.l #8,d0
 movea.l D00028(a6),a0
 move.l d0,6978(a0)
 movea.l D00028(a6),a0
 move.b #7,6982(a0)
L07eb8 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L07ec2 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 bsr.w L07916
 bsr.w L0c834
 moveq #2,d1
 move.l (sp),d0
 bsr.w L07b7c
 movea.l D00028(a6),a0
 tst.l 6986(a0)
 beq.s L07ef8
 move.l #252641280,d1
 movea.l D00028(a6),a0
 move.l 6986(a0),d0
 bsr.w L07684
 bra.s L07f0a
L07ef8 move.l #252641280,d1
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _017ea(a6)
L07f0a movea.l D00028(a6),a0
 move.l 6974(a0),d0
 addq.l #8,d0
 movea.l D00028(a6),a0
 move.l d0,6978(a0)
 movea.l D00028(a6),a0
 move.b #7,6982(a0)
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
L07f30 ble.s L07f98
 dc.w $6673
 bcs.s L07faa
 dc.w $7300
L07f38 movem.l a0-a2/d2-d5,-(sp)
 movea.l d0,a0
 movea.l 0(a0),a1
 movea.l 4(a0),a2
 move.l #18,d3
L07f4c addq.l #1,a1
 addq.l #1,a2
 move.b (a1)+,(a2)+
 addq.l #1,a1
 addq.l #1,a2
 move.b (a1)+,(a2)+
 addq.l #1,a1
 addq.l #1,a2
 move.b (a1)+,(a2)+
 addq.l #1,a1
 addq.l #1,a2
 move.b (a1)+,(a2)+
 addq.l #1,a1
 addq.l #1,a2
 move.b (a1)+,(a2)+
 addq.l #1,a1
 addq.l #1,a2
 move.b (a1)+,(a2)+
 addq.l #1,a1
 addq.l #1,a2
 move.b (a1)+,(a2)+
 addq.l #1,a1
 addq.l #1,a2
 move.b (a1)+,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
L07f98 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
L07faa or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 subq.l #1,d3
 bne.w L07f4c
 movem.l (sp)+,a0-a2/d2-d5
 rts 
L07ff8 movem.l a0-a2/d2-d5,-(sp)
 movea.l d0,a0
 movea.l 0(a0),a1
 movea.l 4(a0),a2
 move.l #18,d3
L0800c move.b (a1)+,(a2)+
 addq.l #1,a1
 addq.l #1,a2
 move.b (a1)+,(a2)+
 addq.l #1,a1
 addq.l #1,a2
 move.b (a1)+,(a2)+
 addq.l #1,a1
 addq.l #1,a2
 move.b (a1)+,(a2)+
 addq.l #1,a1
 addq.l #1,a2
 move.b (a1)+,(a2)+
 addq.l #1,a1
 addq.l #1,a2
 move.b (a1)+,(a2)+
 addq.l #1,a1
 addq.l #1,a2
 move.b (a1)+,(a2)+
 addq.l #1,a1
 addq.l #1,a2
 move.b (a1)+,(a2)+
 addq.l #1,a1
 addq.l #1,a2
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 move.l (a1)+,d5
 or.l d5,(a2)+
 subq.l #1,d3
 bne.w L0800c
 movem.l (sp)+,a0-a2/d2-d5
 rts 
L080b8 link.w a5,#0
 movem.l a0/d0-d1/d4-d6,-(sp)
 move.l d0,d4
 move.l d1,d5
 moveq #63,d6
 moveq #1,d0
 cmp.l d4,d0
 bne.s L080ce
 moveq #20,d6
L080ce move.l D00028(a6),-(sp)
 move.l d6,-(sp)
 moveq #0,d1
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 jsr _016d0(a6)
 addq.l #8,sp
 tst.l d5
 bne.s L08100
 movea.l D00028(a6),a0
 cmpi.w #63,5576(a0)
 bne.s L08122
L08100 move.l D00028(a6),-(sp)
 move.l d6,-(sp)
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016d0(a6)
 addq.l #8,sp
L08122 movem.l -16(a5),a0/d4-d6
 unlk a5
 rts 
L0812c link.w a5,#0
 movem.l a0/a2/d0/d4,-(sp)
 move.l d0,d4
 movea.l D00028(a6),a0
 movea.l 4(a0),a0
 movea.l 38(a0),a2
 movea.l D00028(a6),a0
 movea.l 6780(a0),a0
 movea.l 2(a0),a0
 movea.l 2(a0),a0
 move.l d4,4(a0)
 bset.b #2,7(a2)
 movem.l -12(a5),a0/a2/d4
 unlk a5
 rts 
L08166 link.w a5,#0
 movem.l a2/d0-d1/d4,-(sp)
 move.l d0,d4
 movea.l d1,a2
 move.l #252645120,d0
 bsr.s L0812c
 moveq #1,d1
 moveq #1,d0
 bsr.w L080b8
 movem.l -8(a5),a2/d4
 unlk a5
 rts 
L0818c link.w a5,#0
 movem.l a2/d0-d1/d4,-(sp)
 move.l d0,d4
 movea.l d1,a2
 move.l #-256,d0
 bsr.s L0812c
 moveq #1,d1
 moveq #0,d0
 bsr.w L080b8
 movem.l -8(a5),a2/d4
 unlk a5
 rts 
L081b2 link.w a5,#0
 movem.l a0/d0-d1/d4,-(sp)
 move.l d0,d4
 moveq #1,d0
 cmp.l d4,d0
 bne.s L081d4
 pea (L00960).w
 clr.l -(sp)
 pea L0818c(pc)
 lea L08166(pc),a0
 move.l a0,d1
 bra.s L081dc
L081d4 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 moveq #0,d1
L081dc movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _019b2(a6)
 lea 12(sp),sp
 movem.l -12(a5),a0/d1/d4
 unlk a5
 rts 
L081f6 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.l 6780(a0),d1
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _01718(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _0171e(a6)
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _019b8(a6)
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
L08238 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 pea (Lffffffffffffffff).w
 movea.l D00028(a6),a0
 move.l 6780(a0),d1
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _01718(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _019a6(a6)
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _019ac(a6)
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
L0827c link.w a5,#0
 movem.l a2-a4/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l 44(sp),d4
 move.l 48(sp),d5
 move.l 4(a2),d0
 move.w d4,d1
 ext.l d1
 asr.l #1,d1
 add.l d1,d0
 move.w d5,d1
 asr.w #1,d1
 muls.w 14(a2),d1
 add.l d1,d0
 movea.l d0,a4
 move.l 4(a3),d0
 move.w 62(sp),d1
 ext.l d1
 asr.l #1,d1
 add.l d1,d0
 move.w 66(sp),d1
 asr.w #1,d1
 muls.w 14(a3),d1
 add.l d1,d0
 move.l d0,d7
 moveq #0,d6
 bra.s L082ee
L082c8 move.w 54(sp),d0
 ext.l d0
 asr.l #1,d0
 move.l d0,-(sp)
 move.l a4,d1
 move.l d7,d0
 jsr _017c6(a6)
 addq.l #4,sp
 addq.l #1,d6
 move.w 14(a2),d0
 ext.l d0
 adda.l d0,a4
 move.w 14(a3),d0
 ext.l d0
 add.l d0,d7
L082ee move.w 58(sp),d0
 ext.l d0
 asr.l #1,d0
 cmp.l d6,d0
 bhi.s L082c8
 movem.l -28(a5),a2-a4/d4-d7
 unlk a5
 rts 
L08304 link.w a5,#0
 movem.l a2-a3/d0-d1/d4-d6,-(sp)
 movea.l d0,a2
 move.l d1,d4
 movea.l 36(sp),a3
 move.l 40(sp),d5
 moveq #0,d6
 bra.s L08336
L0831c move.l 4(a3),-(sp)
 move.l (a3),-(sp)
 move.l d4,d1
 move.l a2,d0
 jsr _019a0(a6)
 addq.l #8,sp
 addq.l #1,d6
 adda.l #122,a2
 addq.l #8,a3
L08336 cmp.l d5,d6
 blt.s L0831c
 movem.l -20(a5),a2-a3/d4-d6
 unlk a5
 rts 
L08344 link.w a5,#0
 movem.l a0/d0-d1/d4,-(sp)
 bsr.w L08ba2
 moveq #12,d1
 asr.l d1,d0
 move.l d0,d4
 move.l d4,d0
 lsl.l #2,d0
 lea _00de6(a6),a0
 move.l (a0,d0.l),d1
 move.l #4856,d0
 add.l D00028(a6),d0
 jsr _017f6(a6)
 movem.l -12(a5),a0/d1/d4
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2/d0-d1/d4,-(sp)
 move.l d0,d4
 movea.l d1,a2
 movea.l D00028(a6),a0
 movea.l 178(a0),a0
 move.w #1,52(a0)
 bsr.w L02d48
 movem.l -12(a5),a0/a2/d4
 unlk a5
 rts 
L083a2 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 move.l d1,d4
 movea.l 36(sp),a3
 move.l 40(sp),d5
L083b6 pea (L00001).w
 moveq #1,d1
 movea.l D00028(a6),a0
 move.l 182(a0),d0
 jsr _016f4(a6)
 addq.l #4,sp
 moveq #1,d1
 cmp.l d0,d1
 bne.s L083b6
 move.l a3,d0
 andi.l #$00ffffff,d0
 bset.l #30,d0
 move.l d0,-(sp)
 clr.l -(sp)
 movea.l D00028(a6),a0
 movea.w 66(a0),a0
 move.l a0,-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _017ba(a6)
 lea 12(sp),sp
 movea.l D00028(a6),a0
 movea.l 178(a0),a0
 move.w #1,52(a0)
 bsr.w L02d48
 movem.l -20(a5),a0/a2-a3/d4-d5
 unlk a5
 rts 
L0842a link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 lea -14(sp),sp
 pea 2(sp)
 pea 4(sp)
 pea 14(sp)
 lea 22(sp),a0
 move.l a0,d1
 moveq #3,d0
 jsr _0199a(a6)
 lea 12(sp),sp
 movea.l D00028(a6),a0
 move.w 12(sp),6912(a0)
 lea 14(sp),sp
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
L0846a link.w a5,#0
 movem.l a0/a2-a4/d0-d1,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 movea.l D00028(a6),a0
 movea.l 4(a0),a0
 movea.l 38(a0),a4
 bset.b #2,7(a4)
 movea.l 10(a2),a0
 move.l a3,(a0)
 movea.l 2(a2),a0
 move.l a3,(a0)
 movem.l -16(a5),a0/a2-a4
 unlk a5
 rts 
L0849e link.w a5,#0
 movem.l a0/a2/d0-d1/d4,-(sp)
 move.l d0,d4
 movea.l d1,a2
 movea.l D00028(a6),a0
 pea 4856(a0)
 lea L022c0(pc),a0
 move.l a0,d1
 moveq #4,d0
 jsr _016a6(a6)
 addq.l #4,sp
 movem.l -12(a5),a0/a2/d4
 unlk a5
 rts 
L084ca link.w a5,#0
 movem.l a0/a2/d0-d1/d4,-(sp)
 move.l d0,d4
 movea.l d1,a2
 clr.l -(sp)
 pea L0849e(pc)
 movea.l D00028(a6),a0
 pea 6290(a0)
 lea L08ca9(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 6424(a0),d0
 bsr.w L0c6c6
 lea 12(sp),sp
 movem.l -12(a5),a0/a2/d4
 unlk a5
 rts 
L08504 link.w a5,#0
 movem.l a0/a2/d0-d1/d4,-(sp)
 move.l d0,d4
 movea.l d1,a2
 pea (a2)
 pea L084ca(pc)
 movea.l D00028(a6),a0
 pea 6324(a0)
 lea L08cae(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 6436(a0),d0
 bsr.w L0c6c6
 lea 12(sp),sp
 move.l #6324,d0
 add.l D00028(a6),d0
 movea.l D00028(a6),a0
 move.l d0,6392(a0)
 movem.l -12(a5),a0/a2/d4
 unlk a5
 rts 
L08550 link.w a5,#0
 movem.l a0-a2/d0-d1/d4,-(sp)
 move.l d0,d4
 movea.l d1,a2
 moveq #0,d1
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _017ea(a6)
 movea.l D00028(a6),a0
 tst.w 5012(a0)
 beq.s L08580
 bsr.w L08344
 movea.l D00028(a6),a0
 clr.w 5014(a0)
L08580 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _019be(a6)
 bsr.w L01146
 bsr.w L03208
 bsr.w L05158
 moveq #5,d1
 movea.l D00028(a6),a0
 move.l 6946(a0),d0
 bsr.w L07714
 bsr.w L076e8
 bsr.w L0284c
 moveq #8,d1
 move.l #8536,d0
 add.l D00028(a6),d0
 jsr _01994(a6)
 moveq #8,d1
 move.l #5120,d0
 add.l D00028(a6),d0
 jsr _01994(a6)
 bsr.w L0178e
 movea.l D00028(a6),a0
 movea.l 6780(a0),a0
 clr.l 26(a0)
 jsr _016be(a6)
 movea.l D00028(a6),a0
 move.w #478,80(a0)
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016ee(a6)
 moveq #1,d1
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L08616
 moveq #1,d0
 bra.s L08618
L08616 moveq #0,d0
L08618 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016ee(a6)
 movea.l D00028(a6),a0
 clr.l 90(a0)
 movea.l D00028(a6),a0
 movea.l D00028(a6),a1
 move.l 162(a0),86(a1)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 moveq #0,d0
 jsr _016e2(a6)
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #82,d0
 add.l D00028(a6),d0
 move.l d0,d1
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 jsr _016dc(a6)
 addq.l #8,sp
 pea (L00005).w
 pea (L00001).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 move.l D00028(a6),d0
 jsr _016d6(a6)
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #82,d0
 add.l D00028(a6),d0
 move.l d0,d1
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L086c0
 moveq #1,d0
 bra.s L086c2
L086c0 moveq #0,d0
L086c2 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 jsr _016dc(a6)
 addq.l #8,sp
 pea (L00005).w
 pea (L00001).w
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L086e8
 moveq #1,d0
 bra.s L086ea
L086e8 moveq #0,d0
L086ea lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 move.l D00028(a6),d0
 jsr _016d6(a6)
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 pea (L0003f).w
 moveq #1,d1
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L08716
 moveq #1,d0
 bra.s L08718
L08716 moveq #0,d0
L08718 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016d0(a6)
 addq.l #8,sp
 pea (L00008).w
 pea (L00001).w
 pea (L00001).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 move.l D00028(a6),d0
 jsr _017a8(a6)
 lea 12(sp),sp
 clr.l -(sp)
 pea L08504(pc)
 movea.l D00028(a6),a0
 pea 6256(a0)
 lea L08cb3(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 6428(a0),d0
 bsr.w L0c6c6
 lea 12(sp),sp
 movem.l -16(a5),a0-a2/d4
 unlk a5
 rts 
L08782 link.w a5,#0
 movem.l a0/a2/d0-d1/d4,-(sp)
 move.l d0,d4
 movea.l d1,a2
 pea L08cb8(pc)
 pea L08cbd(pc)
 pea L08cc1(pc)
 clr.l -(sp)
 pea L06e46(pc)
 movea.l D00028(a6),a0
 move.l 4806(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 4830(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 166(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 4038(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 6798(a0),-(sp)
 movea.l D00028(a6),a0
 move.l #47040,d0
 add.l 162(a0),d0
 move.l d0,d1
 movea.l D00028(a6),a0
 move.l 162(a0),d0
 bsr.w L07122
 lea 40(sp),sp
 movem.l -12(a5),a0/a2/d4
 unlk a5
 rts 
L087f2 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D00028(a6),a0
 move.l 4830(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 6798(a0),-(sp)
 movea.l D00028(a6),a0
 movea.l 162(a0),a0
 move.l #61152,d0
 pea (a0,d0.l)
 movea.l D00028(a6),a0
 movea.l 162(a0),a0
 pea 30576(a0)
 movea.l D00028(a6),a0
 move.l 162(a0),d1
 movea.l D00028(a6),a0
 move.l 4038(a0),d0
 bsr.w L0c4ba
 lea 16(sp),sp
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
L0884a link.w a5,#0
 movem.l a0/a2/d0-d1/d4,-(sp)
 move.l d0,d4
 movea.l d1,a2
 movea.l D00028(a6),a0
 move.l 6802(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 4830(a0),-(sp)
 movea.l D00028(a6),a0
 movea.l 6798(a0),a0
 pea 23520(a0)
 movea.l D00028(a6),a0
 movea.l 6798(a0),a0
 pea 11760(a0)
 movea.l D00028(a6),a0
 move.l 6798(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 166(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 4030(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 162(a0),d1
 movea.l D00028(a6),a0
 move.l 4038(a0),d0
 bsr.w L00d68
 lea 28(sp),sp
 movem.l -12(a5),a0/a2/d4
 unlk a5
 rts 
L088b8 link.w a5,#0
 movem.l a0/a2/d0-d1/d4,-(sp)
 move.l d0,d4
 movea.l d1,a2
 movea.l D00028(a6),a0
 move.l 4830(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 166(a0),-(sp)
 movea.l D00028(a6),a0
 movea.l 162(a0),a0
 move.l #47040,d0
 pea (a0,d0.l)
 movea.l D00028(a6),a0
 move.l 162(a0),d1
 movea.l D00028(a6),a0
 move.l 174(a0),d0
 bsr.w L0e822
 lea 12(sp),sp
 movem.l -12(a5),a0/a2/d4
 unlk a5
 rts 
L08908 link.w a5,#0
 movem.l a0/a2/d0-d1/d4,-(sp)
 move.l d0,d4
 movea.l d1,a2
 movea.l D00028(a6),a0
 move.w #478,80(a0)
 pea (L00001).w
 clr.l -(sp)
 clr.l -(sp)
 pea L088b8(pc)
 movea.l D00028(a6),a0
 move.l 4038(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 162(a0),d1
 lea L08cc7(pc),a0
 move.l a0,d0
 jsr _0194c(a6)
 lea 20(sp),sp
 movem.l -12(a5),a0/a2/d4
 unlk a5
 rts 
L08952 link.w a5,#0
 movem.l a0/d0-d1/d4-d5,-(sp)
 move.l d0,d4
 move.l d1,d5
 andi.w #$feff,_011ba(a6)
 moveq #0,d1
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _017ea(a6)
 ext.l d5
 move.l d5,-(sp)
 movea.l D00028(a6),a0
 move.l 4792(a0),-(sp)
 movea.l D00028(a6),a0
 movea.l 5084(a0),a0
 pea 23520(a0)
 movea.l D00028(a6),a0
 move.l 6798(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 166(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 5084(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 4796(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 4038(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 4830(a0),d1
 movea.l D00028(a6),a0
 move.l 162(a0),d0
 bsr.w L0db24
 lea 32(sp),sp
 movem.l -12(a5),a0/d4-d5
 unlk a5
 rts 
L089d4 link.w a5,#0
 movem.l a0-a2/d0-d1/d4,-(sp)
 move.l d0,d4
 movea.l d1,a2
 clr.l -(sp)
 clr.l -(sp)
 move.l #46080,-(sp)
 movea.l D00028(a6),a0
 move.l 6954(a0),-(sp)
 moveq #0,d1
 move.l #5780,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 pea (L00800).w
 movea.l D00028(a6),a0
 move.l 4868(a0),-(sp)
 move.l #5978,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5956,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #36864,-(sp)
 movea.l D00028(a6),a0
 move.l 5084(a0),-(sp)
 move.l #6000,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5978,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 pea (L05000).w
 movea.l D00028(a6),a0
 move.l 6974(a0),-(sp)
 moveq #0,d1
 move.l #6000,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 pea (L00930).w
 movea.l D00028(a6),a0
 move.l 7842(a0),-(sp)
 move.l #5670,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5648,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 pea (L01260).w
 movea.l D00028(a6),a0
 move.l 5110(a0),-(sp)
 move.l #5692,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5670,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 pea (L00930).w
 movea.l D00028(a6),a0
 move.l 5624(a0),-(sp)
 move.l #5714,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5692,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 pea (L00930).w
 movea.l D00028(a6),a0
 move.l 7846(a0),-(sp)
 moveq #0,d1
 move.l #5714,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 movea.l D00028(a6),a0
 pea 5956(a0)
 movea.l D00028(a6),a0
 pea 5780(a0)
 move.l #5648,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01700(a6)
 addq.l #8,sp
 andi.w #$feff,_011ba(a6)
 lea L08ccb(pc),a0
 move.l a0,d1
 move.l #6188,d0
 add.l D00028(a6),d0
 jsr _0170c(a6)
 lea L08550(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6396(a1)
 moveq #1,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01706(a6)
 movem.l -16(a5),a0-a2/d4
 unlk a5
 rts 
L08ba2 link.w a5,#0
 movem.l a0/d0-d1/d4,-(sp)
 move.l #78665521,d4
 movea.l D00028(a6),a0
 moveq #0,d0
 move.w 6912(a0),d0
 move.l d4,d1
 jsr _016a0(a6)
 addq.w #1,d0
 andi.w #$ffff,d0
 movea.l D00028(a6),a0
 move.w d0,6912(a0)
 movea.l D00028(a6),a0
 move.w #-1,d0
 and.w 6912(a0),d0
 moveq #0,d1
 move.w d0,d1
 move.l d1,d0
 movem.l -12(a5),a0/d1/d4
 unlk a5
 rts 
L08bea link.w a5,#0
 movem.l a2/d0-d1/d4,-(sp)
 move.l d0,d4
 movea.l d1,a2
 jsr _0187a(a6)
 movem.l -8(a5),a2/d4
 unlk a5
 rts 
L08c04 link.w a5,#0
 movem.l a0/a2/d0-d1/d4,-(sp)
 move.l d0,d4
 movea.l d1,a2
 movea.l D00028(a6),a0
 cmpi.w #52,9858(a0)
 bge.s L08c58
 move.l #-2139062144,d1
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _017ea(a6)
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 pea L08bea(pc)
 movea.l D00028(a6),a0
 move.l 4038(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 162(a0),d1
 lea L08cd1(pc),a0
 move.l a0,d0
 bsr.w L10b50
 lea 20(sp),sp
 bra.s L08c5e
L08c58 moveq #0,d1
 moveq #0,d0
 bsr.s L08bea
L08c5e movem.l -12(a5),a0/a2/d4
 unlk a5
 rts 
 bvs.s L08c9c
 move.w d0,-(a1)
 ble.s L08ca0
 move.w d0,d1
 dc.w $6d31
 move.w d0,d1
 dc.w $6c31
 move.w d0,-(a0)
 dc.w $6b31
 move.w d0,-(a4)
 dc.w $6931
 move.w d0,d0
 bvc.s L08cb4
 move.w d0,-(a3)
 dc.w $6733
 move.w d0,d0
 dc.w $6f31
 move.w d0,d1
 dc.w $6539
 ori.w #$3700,-(a3)
 dc.w $6a31
 move.w d0,d0
 dc.w $7332
 move.w 115(a4,d0.w),-(a0)
L08c9c dc.w $3431
 move.w d0,-(a2)
L08ca0 dc.w $7336
 move.w 107(a3,d0.w),-(a0)
 move.w (L766d61).l,-(a0)
L08ca9 equ *-3
 moveq #0,d0
L08cae dc.w $6f6d
 bsr.s L08d22
 ori.w #$6d61,-(a1)
L08cb3 equ *-3
L08cb4 equ *-2
 moveq #0,d0
L08cb8 dc.w $6761
 bgt.s L08cee
 ori.w #$616e,-(sp)
L08cbd equ *-3
 ori.w #$616e,-(sp)
L08cc1 equ *-3
 subq.w #7,115(a1)
L08cc7 equ *-1
 moveq #114,d2
 dc.w $7a
L08ccb equ *-1
 bvs.s L08d3c
 bvs.s L08d44
 ori.w #$6567,24940(a4)
L08cd1 equ *-5
 dc.w $0
L08cd8 link.w a5,#0
 movem.l a0/d0,-(sp)
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _01a36(a6)
 jsr _01a4e(a6)
L08cee equ *-2
 moveq #0,d0
 jsr _01958(a6)
 movem.l -4(a5),a0
 unlk a5
 rts 
L08d00 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 jsr _01a24(a6)
 moveq #0,d1
 lea L08cd8(pc),a0
 move.l a0,d0
 jsr _019dc(a6)
 move.l 4(sp),d1
 move.l (sp),d0
 bsr.w L010da
L08d22 movem.l -4(a5),a0
 unlk a5
 rts 
L08d2c link.w a5,#0
 movem.l d0,-(sp)
 unlk a5
 rts 
 link.w a5,#0
L08d3c movem.l a0/d0-d1,-(sp)
 pea L08d2c(pc)
L08d44 pea (L00014).w
 move.l #128,d1
 moveq #50,d0
 jsr _019e2(a6)
 addq.l #8,sp
 move.l 4(sp),-(sp)
 move.l 4(sp),d1
 lea L08d00(pc),a0
 move.l a0,d0
 jsr _019e8(a6)
 addq.l #4,sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L08d74 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 move.l #128,d1
 move.l #94080,d0
 jsr _019ca(a6)
 movea.l D00028(a6),a0
 move.l d0,162(a0)
 movea.l D00028(a6),a0
 tst.l 162(a0)
 bne.s L08da2
 jsr _0187a(a6)
L08da2 move.l #129,d1
 move.l #94080,d0
 jsr _019ca(a6)
 movea.l D00028(a6),a0
 move.l d0,170(a0)
 movea.l D00028(a6),a0
 tst.l 170(a0)
 bne.s L08dc8
 jsr _0187a(a6)
L08dc8 movea.l D00028(a6),a0
 movea.l D00028(a6),a1
 move.l 170(a0),4038(a1)
 move.l #129,d1
 move.l #188160,d0
 jsr _019ca(a6)
 movea.l D00028(a6),a0
 move.l d0,174(a0)
 movea.l D00028(a6),a0
 tst.l 174(a0)
 bne.s L08dfc
 jsr _0187a(a6)
L08dfc move.l #129,d1
 move.l #32768,d0
 jsr _019ca(a6)
 movea.l D00028(a6),a0
 move.l d0,5084(a0)
 movea.l D00028(a6),a0
 tst.l 5084(a0)
 bne.s L08e22
 jsr _0187a(a6)
L08e22 move.l #128,d1
 move.l #10240,d0
 jsr _019ca(a6)
 movea.l D00028(a6),a0
 move.l d0,6416(a0)
 movea.l D00028(a6),a0
 tst.l 6416(a0)
 bne.s L08e48
 jsr _0187a(a6)
L08e48 move.l #128,d1
 move.l #14336,d0
 jsr _019ca(a6)
 movea.l D00028(a6),a0
 move.l d0,6420(a0)
 movea.l D00028(a6),a0
 tst.l 6420(a0)
 bne.s L08e6e
 jsr _0187a(a6)
L08e6e move.l #128,d1
 move.l #94080,d0
 jsr _019ca(a6)
 movea.l D00028(a6),a0
 move.l d0,166(a0)
 movea.l D00028(a6),a0
 tst.l 166(a0)
 bne.s L08e94
 jsr _0187a(a6)
L08e94 move.l #128,d1
 move.l #2048,d0
 jsr _019ca(a6)
 movea.l D00028(a6),a0
 move.l d0,4806(a0)
 movea.l D00028(a6),a0
 tst.l 4806(a0)
 bne.s L08eba
 jsr _0187a(a6)
L08eba move.l #128,d1
 move.l #8192,d0
 jsr _019ca(a6)
 movea.l D00028(a6),a0
 move.l d0,4818(a0)
 movea.l D00028(a6),a0
 tst.l 4818(a0)
 bne.s L08ee0
 jsr _0187a(a6)
L08ee0 move.l #129,d1
 move.l #2048,d0
 jsr _019ca(a6)
 movea.l D00028(a6),a0
 move.l d0,6908(a0)
 movea.l D00028(a6),a0
 tst.l 6908(a0)
 bne.s L08f08
 jsr _0187a(a6)
 bra.s L08f1c
L08f08 pea (L00800).w
 moveq #0,d1
 movea.l D00028(a6),a0
 move.l 6908(a0),d0
 jsr _016ac(a6)
 addq.l #4,sp
L08f1c move.l #129,d1
 move.l #2048,d0
 jsr _019ca(a6)
 movea.l D00028(a6),a0
 move.l d0,4026(a0)
 movea.l D00028(a6),a0
 tst.l 4026(a0)
 bne.s L08f42
 jsr _0187a(a6)
L08f42 move.l #128,d1
 move.l #2048,d0
 jsr _019ca(a6)
 movea.l D00028(a6),a0
 move.l d0,4868(a0)
 movea.l D00028(a6),a0
 tst.l 4868(a0)
 bne.s L08f68
 jsr _0187a(a6)
L08f68 move.l #128,d1
 move.l #2048,d0
 jsr _019ca(a6)
 movea.l D00028(a6),a0
 move.l d0,4830(a0)
 movea.l D00028(a6),a0
 tst.l 4830(a0)
 bne.s L08f8e
 jsr _0187a(a6)
L08f8e move.l #128,d1
 move.l #2048,d0
 jsr _019ca(a6)
 movea.l D00028(a6),a0
 move.l d0,6802(a0)
 movea.l D00028(a6),a0
 tst.l 6802(a0)
 bne.s L08fb4
 jsr _0187a(a6)
L08fb4 move.l #128,d1
 move.l #47104,d0
 jsr _019ca(a6)
 movea.l D00028(a6),a0
 move.l d0,6798(a0)
 movea.l D00028(a6),a0
 tst.l 6798(a0)
 bne.s L08fda
 jsr _0187a(a6)
L08fda move.l #128,d1
 move.l #8192,d0
 jsr _019ca(a6)
 movea.l D00028(a6),a0
 move.l d0,4814(a0)
 movea.l D00028(a6),a0
 tst.l 4814(a0)
 bne.s L09000
 jsr _0187a(a6)
L09000 move.l #128,d1
 move.l #18432,d0
 jsr _019ca(a6)
 movea.l D00028(a6),a0
 move.l d0,4776(a0)
 movea.l D00028(a6),a0
 tst.l 4776(a0)
 bne.s L09026
 jsr _0187a(a6)
L09026 move.l #128,d1
 move.l #41472,d0
 jsr _019ca(a6)
 movea.l D00028(a6),a0
 move.l d0,6954(a0)
 movea.l D00028(a6),a0
 tst.l 6954(a0)
 bne.s L0904c
 jsr _0187a(a6)
L0904c move.l #128,d1
 move.l #2352,d0
 jsr _019ca(a6)
 movea.l D00028(a6),a0
 move.l d0,7842(a0)
 movea.l D00028(a6),a0
 tst.l 7842(a0)
 bne.s L09072
 jsr _0187a(a6)
L09072 move.l #129,d1
 move.l #2352,d0
 jsr _019ca(a6)
 movea.l D00028(a6),a0
 move.l d0,7846(a0)
 movea.l D00028(a6),a0
 tst.l 7846(a0)
 bne.s L09098
 jsr _0187a(a6)
L09098 move.l #128,d1
 move.l #11520,d0
 jsr _019ca(a6)
 movea.l D00028(a6),a0
 move.l d0,6970(a0)
 movea.l D00028(a6),a0
 tst.l 6970(a0)
 bne.s L090be
 jsr _0187a(a6)
L090be move.l #128,d1
 move.l #20480,d0
 jsr _019ca(a6)
 movea.l D00028(a6),a0
 move.l d0,6974(a0)
 movea.l D00028(a6),a0
 tst.l 6974(a0)
 bne.s L090e4
 jsr _0187a(a6)
L090e4 move.l #128,d1
 move.l #1056,d0
 jsr _019ca(a6)
 movea.l D00028(a6),a0
 move.l d0,8092(a0)
 movea.l D00028(a6),a0
 tst.l 8092(a0)
 bne.s L0910a
 jsr _0187a(a6)
L0910a pea (L00420).w
 moveq #0,d1
 movea.l D00028(a6),a0
 move.l 8092(a0),d0
 jsr _016ac(a6)
 addq.l #4,sp
 move.l #128,d1
 move.l #7056,d0
 jsr _019ca(a6)
 movea.l D00028(a6),a0
 move.l d0,5110(a0)
 movea.l D00028(a6),a0
 tst.l 5110(a0)
 bne.s L09144
 jsr _0187a(a6)
L09144 move.l #128,d1
 move.l #2048,d0
 jsr _019ca(a6)
 movea.l D00028(a6),a0
 move.l d0,5116(a0)
 movea.l D00028(a6),a0
 tst.l 5116(a0)
 bne.s L0916a
 jsr _0187a(a6)
L0916a move.l #128,d1
 move.l #6144,d0
 jsr _019ca(a6)
 movea.l D00028(a6),a0
 move.l d0,5552(a0)
 movea.l D00028(a6),a0
 tst.l 5552(a0)
 bne.s L09190
 jsr _0187a(a6)
L09190 move.l #128,d1
 move.l #7056,d0
 jsr _019ca(a6)
 movea.l D00028(a6),a0
 move.l d0,9836(a0)
 movea.l D00028(a6),a0
 tst.l 9836(a0)
 bne.s L091b6
 jsr _0187a(a6)
L091b6 pea (L02d00).w
 moveq #0,d1
 movea.l D00028(a6),a0
 move.l 6970(a0),d0
 jsr _016ac(a6)
 addq.l #4,sp
 move.l #128,d1
 moveq #24,d0
 jsr _019ca(a6)
 movea.l D00028(a6),a0
 move.l d0,4834(a0)
 movea.l D00028(a6),a0
 tst.l 4834(a0)
 bne.s L091ec
 jsr _0187a(a6)
L091ec pea (L00018).w
 moveq #0,d1
 movea.l D00028(a6),a0
 move.l 4834(a0),d0
 jsr _016ac(a6)
 addq.l #4,sp
 move.l #128,d1
 move.l #2352,d0
 jsr _019ca(a6)
 movea.l D00028(a6),a0
 move.l d0,5624(a0)
 movea.l D00028(a6),a0
 tst.l 5624(a0)
 bne.s L09226
 jsr _0187a(a6)
L09226 movea.l D00028(a6),a0
 movea.l D00028(a6),a1
 move.l 174(a0),4030(a1)
 movea.l D00028(a6),a0
 move.l #384,d0
 add.l 4030(a0),d0
 movea.l D00028(a6),a0
 move.l d0,4034(a0)
 move.l #2106,d0
 add.l D00028(a6),d0
 movea.l D00028(a6),a0
 move.l d0,4762(a0)
 movea.l D00028(a6),a0
 movea.l D00028(a6),a1
 move.l 4030(a0),4792(a1)
 movea.l D00028(a6),a0
 move.l #94080,d0
 add.l 4792(a0),d0
 movea.l D00028(a6),a0
 move.l d0,4796(a0)
 movea.l D00028(a6),a0
 move.l #65856,d0
 add.l 4796(a0),d0
 movea.l D00028(a6),a0
 move.l d0,6958(a0)
 movea.l D00028(a6),a0
 move.l #21168,d0
 add.l 4796(a0),d0
 movea.l D00028(a6),a0
 move.l d0,6966(a0)
 movea.l D00028(a6),a0
 move.l #2048,d0
 add.l 6420(a0),d0
 movea.l D00028(a6),a0
 move.l d0,6424(a0)
 movea.l D00028(a6),a0
 move.l #6144,d0
 add.l 6424(a0),d0
 movea.l D00028(a6),a0
 move.l d0,6428(a0)
 movea.l D00028(a6),a0
 movea.l D00028(a6),a1
 move.l 6416(a0),6432(a1)
 movea.l D00028(a6),a0
 movea.l D00028(a6),a1
 move.l 6432(a0),6436(a1)
 movea.l D00028(a6),a0
 movea.l D00028(a6),a1
 move.l 5110(a0),9964(a1)
 movem.l -12(a5),a0-a1/d1
 unlk a5
 rts 
L0930c link.w a5,#0
 movem.l a0/d0-d1/d4-d5,-(sp)
 moveq #1,d1
 lea L098b6(pc),a0
 move.l a0,d0
 jsr _01a06(a6)
 move.l d0,d4
 moveq #255,d0
 cmp.l d4,d0
 bne.s L0932c
 jsr _0187a(a6)
L0932c pea (L00002).w
 moveq #0,d1
 move.l d4,d0
 jsr _01970(a6)
 addq.l #4,sp
 move.l d0,d5
 clr.l -(sp)
 moveq #0,d1
 move.l d4,d0
 jsr _01970(a6)
 addq.l #4,sp
 move.l d5,-(sp)
 movea.l D00028(a6),a0
 move.l 6420(a0),d1
 move.l d4,d0
 jsr _01a1e(a6)
 addq.l #4,sp
 move.l d4,d0
 jsr _019d0(a6)
 movem.l -16(a5),a0/d1/d4-d5
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1/d4,-(sp)
 pea (L00001).w
 moveq #1,d1
 moveq #1,d0
 jsr _01a0c(a6)
 addq.l #4,sp
 ori.w #$0090,_011ba(a6)
 lea L0c76a(pc),a0
 move.l a0,_011d0(a6)
 lea L0c7c6(pc),a0
 move.l a0,_011d4(a6)
 lea L0c812(pc),a0
 move.l a0,_011d8(a6)
 clr.l _011dc(a6)
 lea L098c3(pc),a0
 move.l a0,d1
 move.l #6188,d0
 add.l D00028(a6),d0
 jsr _01a18(a6)
 move.l d0,d4
 moveq #255,d0
 cmp.l d4,d0
 bsr.w L0930c
 movea.l D00028(a6),a0
 move.l 6420(a0),d1
 move.l #6188,d0
 add.l D00028(a6),d0
 jsr _01a12(a6)
 move.l d0,d4
 moveq #255,d0
 cmp.l d4,d0
 lea L098cd(pc),a0
 move.l a0,d1
 move.l #6222,d0
 add.l D00028(a6),d0
 jsr _01a18(a6)
 move.l d0,d4
 moveq #255,d0
 cmp.l d4,d0
 lea L098da(pc),a0
 move.l a0,d1
 move.l #6256,d0
 add.l D00028(a6),d0
 jsr _01a18(a6)
 move.l d0,d4
 moveq #255,d0
 cmp.l d4,d0
 lea L098ea(pc),a0
 move.l a0,d1
 move.l #6290,d0
 add.l D00028(a6),d0
 jsr _01a18(a6)
 move.l d0,d4
 moveq #255,d0
 cmp.l d4,d0
 lea L098fa(pc),a0
 move.l a0,d1
 move.l #6324,d0
 add.l D00028(a6),d0
 jsr _01a18(a6)
 move.l d0,d4
 moveq #255,d0
 cmp.l d4,d0
 lea L09903(pc),a0
 move.l a0,d1
 move.l #6358,d0
 add.l D00028(a6),d0
 jsr _01a18(a6)
 move.l d0,d4
 moveq #255,d0
 cmp.l d4,d0
 movem.l -12(a5),a0/d1/d4
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2-a3/d0-d1,-(sp)
 moveq #82,d0
 add.l D00028(a6),d0
 movea.l d0,a2
 moveq #122,d0
 add.l D00028(a6),d0
 movea.l d0,a3
 move.l #188160,-(sp)
 moveq #0,d1
 movea.l D00028(a6),a0
 move.l 174(a0),d0
 jsr _017b4(a6)
 addq.l #4,sp
 move.l #94080,-(sp)
 moveq #4,d1
 movea.l D00028(a6),a0
 move.l 162(a0),d0
 jsr _017b4(a6)
 addq.l #4,sp
 move.l #94080,-(sp)
 moveq #4,d1
 movea.l D00028(a6),a0
 move.l 166(a0),d0
 jsr _017b4(a6)
 addq.l #4,sp
 move.l #94080,-(sp)
 moveq #4,d1
 movea.l D00028(a6),a0
 move.l 4038(a0),d0
 jsr _017b4(a6)
 addq.l #4,sp
 clr.w 18(a2)
 clr.w 18(a3)
 clr.l 8(a2)
 clr.l 8(a3)
 move.w #384,14(a2)
 move.w #240,16(a2)
 move.w #384,14(a3)
 move.w #240,16(a3)
 move.l D00028(a6),(a2)
 move.l D00028(a6),(a3)
 clr.w 12(a2)
 move.w #1,12(a3)
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016ee(a6)
 movem.l -16(a5),a0/a2-a3/d1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 moveq #1,d1
 moveq #2,d0
 jsr _019d6(a6)
 movea.l D00028(a6),a0
 move.l d0,6918(a0)
 moveq #3,d1
 movea.l D00028(a6),a0
 move.l 6918(a0),d0
 jsr _01a06(a6)
 movea.l D00028(a6),a0
 move.l d0,6914(a0)
 movea.l D00028(a6),a0
 move.l 6918(a0),d0
 jsr _019ee(a6)
 move.l #8388736,d1
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _017ea(a6)
 movea.l D00028(a6),a0
 clr.w 6924(a0)
 movea.l D00028(a6),a0
 clr.w 6928(a0)
 movea.l D00028(a6),a0
 pea 6970(a0)
 pea (L00012).w
 moveq #5,d1
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _01a2a(a6)
 addq.l #8,sp
 movea.l D00028(a6),a0
 move.l d0,6930(a0)
 movea.l D00028(a6),a0
 move.l 6970(a0),d1
 move.l #2304,d0
 jsr _019c4(a6)
 moveq #255,d1
 cmp.l d0,d1
 movea.l D00028(a6),a0
 move.l 6930(a0),d1
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _01a30(a6)
 movea.l D00028(a6),a0
 move.l d0,6946(a0)
 movea.l D00028(a6),a0
 pea 6974(a0)
 pea (L00012).w
 moveq #5,d1
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _01a2a(a6)
 addq.l #8,sp
 movea.l D00028(a6),a0
 move.l d0,6934(a0)
 movea.l D00028(a6),a0
 move.l 6974(a0),d1
 move.l #2304,d0
 jsr _019c4(a6)
 moveq #255,d1
 cmp.l d0,d1
 movea.l D00028(a6),a0
 move.l 6934(a0),d1
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _01a30(a6)
 movea.l D00028(a6),a0
 move.l d0,6950(a0)
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
 link.w a5,#0
 movem.l d0-d1,-(sp)
 move.l #128,d1
 move.l #9992,d0
 jsr _019ca(a6)
 move.l d0,D00028(a6)
 tst.l D00028(a6)
 beq.s L0967a
 pea (L02708).w
 moveq #0,d1
 move.l D00028(a6),d0
 jsr _016ac(a6)
 addq.l #4,sp
L0967a movem.l -4(a5),d1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 lea _00e48(a6),a0
 movea.l D00028(a6),a1
 move.l a0,6780(a1)
 movea.l D00028(a6),a0
 movea.l 6780(a0),a0
 movea.l 2(a0),a0
 movea.l 2(a0),a0
 move.l #-256,4(a0)
 pea (L00080).w
 movea.l D00028(a6),a0
 movea.w 66(a0),a0
 move.l a0,-(sp)
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.l 6780(a0),d1
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _01a3c(a6)
 lea 12(sp),sp
 lea _00e26(a6),a0
 move.l a0,d1
 lea _01434(a6),a0
 move.l a0,d0
 bsr.w L0846a
 movea.l D00028(a6),a0
 move.l 8(a0),-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 move.l 166(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 162(a0),-(sp)
 pea (L00080).w
 moveq #60,d1
 moveq #32,d0
 jsr _01a48(a6)
 lea 20(sp),sp
 movea.l D00028(a6),a0
 move.l d0,178(a0)
 pea (L00094).w
 move.l #168,d1
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _01940(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 movea.l 4(a0),a0
 movea.l 38(a0),a0
 move.w #168,98(a0)
 movea.l D00028(a6),a0
 movea.l 4(a0),a0
 movea.l 38(a0),a0
 move.w #148,100(a0)
 movea.l D00028(a6),a0
 movea.l 4(a0),a0
 movea.l 38(a0),a0
 move.w #168,22(a0)
 movea.l D00028(a6),a0
 movea.l 4(a0),a0
 movea.l 38(a0),a0
 move.w #148,24(a0)
 movea.l D00028(a6),a0
 tst.l 62(a0)
 beq.s L097a4
 pea (L001d6).w
 pea (L002bc).w
 pea (L00058).w
 bra.s L097b0
L097a4 pea (L001ae).w
 pea (L002bc).w
 pea (L00030).w
L097b0 moveq #68,d1
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _01a42(a6)
 lea 12(sp),sp
 movea.l D00028(a6),a0
 tst.l 178(a0)
 movem.l -12(a5),a0-a1/d1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1/d4-d5,-(sp)
 lea -18(sp),sp
 pea (sp)
 pea (L00080).w
 lea L0990d(pc),a0
 move.l a0,d1
 lea L09913(pc),a0
 move.l a0,d0
 jsr _01a00(a6)
 addq.l #8,sp
 move.l d0,d5
 tst.l d5
 bne.s L09810
 jsr _019f4(a6)
 move.l d0,d4
 cmpi.l #800,d4
 bge.s L09818
 moveq #255,d0
 bra.s L0981a
L09810 lea (sp),a0
 move.l a0,d0
 jsr _019fa(a6)
L09818 moveq #0,d0
L0981a lea 18(sp),sp
 movem.l -12(a5),a0/d4-d5
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 clr.l -(sp)
 clr.l -(sp)
 pea (L01b90).w
 movea.l D00028(a6),a0
 move.l 9836(a0),-(sp)
 moveq #0,d1
 move.l #5648,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #5648,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01700(a6)
 addq.l #8,sp
 lea L09923(pc),a0
 move.l a0,d1
 move.l #6188,d0
 add.l D00028(a6),d0
 jsr _0170c(a6)
 moveq #1,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01706(a6)
 moveq #0,d0
 jsr _01712(a6)
 moveq #1,d0
 jsr _01712(a6)
 movea.l D00028(a6),a0
 move.l (sp),6396(a0)
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
L098b6 moveq #101,d5
 bge.s L0991e
 bsr.s L098ea
 dc.w $6d61
 moveq #114,d0
 dc.w $6573
 dc.w $7a
L098c3 equ *-1
 bcs.s L09932
 dc.w $6461
 dc.w $2e72
 moveq #102,d2
 dc.w $7a
L098cd equ *-1
 bcs.s L0993c
 dc.w $6461
 dc.w $5f72
 bge.s L09904
 moveq #116,d1
 dc.w $6600
L098da moveq #101,d5
 bge.s L09942
 dc.w $615f
 dc.w $6175
 dc.w $6469
 ble.s L09914
 moveq #116,d1
 dc.w $6600
L098ea moveq #101,d5
 bge.s L09952
 dc.w $615f
 moveq #111,d3
 dc.w $6963
 bcs.s L09924
 moveq #116,d1
 bne.w L10870
L098fa equ *-2
 bcs.s L09970
 dc.w $2e72
 moveq #102,d2
 dc.w $75
L09903 equ *-1
L09904 bgt.s L0996a
 bcs.s L0997a
 dc.w $2e72
 moveq #102,d2
 ori.w #$656c,(a2)+
L0990d equ *-3
 dc.w $6461
 dc.w $2f
L09913 equ *-1
L09914 bgt.s L0998c
 moveq #47,d1
 moveq #101,d5
 bge.s L09980
 bsr.s L0994c
L0991e bgt.s L09996
 moveq #105,d1
 ori.w #$7274,-(a4)
L09923 equ *-3
L09924 equ *-2
 dc.w $0
L09928 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4,-(sp)
 movea.l D0002c(a6),a0
L09932 equ *-2
 movea.l 226(a0),a2
 movea.l D00028(a6),a0
L0993c move.l #158,d0
L09942 add.l 6908(a0),d0
 movea.l d0,a3
 moveq #0,d4
 bra.s L09994
L0994c tst.w (a3)
 beq.s L0998a
 clr.l -(sp)
L09952 movea.w 2(a2),a0
 move.l a0,-(sp)
 movea.w (a2),a0
 move.l a0,-(sp)
 movea.w 10(a2),a0
 move.l a0,-(sp)
 movea.w 8(a2),a0
 move.l a0,-(sp)
 movea.w 6(a2),a0
L0996a equ *-2
 move.l a0,-(sp)
 movea.w 4(a2),a0
L09970 equ *-2
 move.l a0,-(sp)
 moveq #32,d0
 add.l D0002c(a6),d0
L0997a move.l d0,d1
 moveq #112,d0
 add.l D0002c(a6),d0
L09980 equ *-2
 bsr.w L07478
 lea 28(sp),sp
L0998a addq.l #1,d4
L0998c addq.l #2,a3
 adda.l #12,a2
L09994 moveq #7,d0
L09996 cmp.l d4,d0
 bgt.s L0994c
 movem.l -20(a5),a0/a2-a3/d1/d4
 unlk a5
 rts 
L099a4 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4-d5,-(sp)
 lea -20(sp),sp
 lea 10(sp),a2
 move.w #324,d4
 moveq #118,d5
 lea L0aea8(pc),a0
 move.l a0,d1
 lea 10(sp),a0
 move.l a0,d0
 jsr _017f6(a6)
 pea (L00005).w
 pea (L0000a).w
 lea 8(sp),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 movea.w 314(a0),a0
 move.l a0,d0
 bsr.w L0aed4
 addq.l #8,sp
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 tst.w 314(a0)
 beq.s L099fe
 clr.b 11(sp)
L099fe lea (sp),a0
 move.l a0,d1
 lea 11(sp),a0
 move.l a0,d0
 jsr _01a72(a6)
 bra.s L09a64
L09a0e movea.l D0002c(a6),a0
 move.l 222(a0),d0
 move.b (a2),d1
 ext.w d1
 subi.w #48,d1
 ext.l d1
 lsl.l #3,d1
 add.l d1,d0
 movea.l d0,a3
 ext.l d5
 move.l d5,-(sp)
 ext.l d4
 move.l d4,-(sp)
 movea.w 6(a3),a0
 move.l a0,-(sp)
 movea.w 4(a3),a0
 move.l a0,-(sp)
 movea.w 2(a3),a0
 move.l a0,-(sp)
 movea.w (a3),a0
 move.l a0,-(sp)
 moveq #32,d0
 add.l D0002c(a6),d0
 move.l d0,d1
 move.l #152,d0
 add.l D0002c(a6),d0
 bsr.w L074fc
 lea 24(sp),sp
 add.w 4(a3),d4
 addq.l #1,a2
L09a64 tst.b (a2)
 bne.s L09a0e
 lea 20(sp),sp
 movem.l -24(a5),a0/a2-a3/d1/d4-d5
 unlk a5
 rts 
L09a76 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.l 178(a0),-(sp)
 movea.l _01948(a6),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 movea.l 178(a0),a0
 move.l 48(a0),d0
 jsr _0193a(a6)
 addq.l #8,sp
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
L09aaa link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l 4(sp),d0
 jsr _01a5a(a6)
 clr.l -(sp)
 lea L0a4a4(pc),a0
 move.l a0,d1
 move.l 4(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L09ad6 link.w a5,#0
 movem.l a0-a3/d0-d1/d4,-(sp)
 move.l #5116,d0
 add.l D00028(a6),d0
 movea.l d0,a3
 movea.l D00028(a6),a0
 moveq #0,d0
 move.w 6904(a0),d0
 move.l d0,d4
 movea.l D00028(a6),a0
 cmpi.w #1,6906(a0)
 bne.s L09b0e
 movea.l D00028(a6),a0
 cmpi.w #255,6904(a0)
 bne.s L09b18
L09b0e moveq #0,d4
 movea.l D00028(a6),a0
 clr.b 5564(a0)
L09b18 move.l d4,d0
 moveq #6,d1
 jsr _016a0(a6)
 movea.l D0002c(a6),a0
 add.l 218(a0),d0
 movea.l d0,a2
 clr.l -(sp)
 clr.l -(sp)
 pea (L00800).w
 move.l (a3),-(sp)
 move.l #5978,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5956,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 pea (L00800).w
 move.l 436(a3),-(sp)
 moveq #0,d1
 move.l #5978,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 pea (L00800).w
 movea.l D00028(a6),a0
 move.l 6954(a0),-(sp)
 moveq #0,d1
 move.l #5780,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 lea L09aaa(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6396(a1)
 movea.l D00028(a6),a0
 move.l a3,6400(a0)
 andi.w #$febf,_011ba(a6)
 movea.l D00028(a6),a0
 pea 5956(a0)
 movea.l D00028(a6),a0
 pea 5780(a0)
 moveq #0,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01700(a6)
 addq.l #8,sp
 move.l a2,d1
 move.l #6188,d0
 add.l D00028(a6),d0
 jsr _0170c(a6)
 moveq #1,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01706(a6)
 moveq #0,d0
 jsr _01712(a6)
 moveq #1,d0
 jsr _01712(a6)
 movem.l -20(a5),a0-a3/d4
 unlk a5
 rts 
L09c08 link.w a5,#0
 movem.l a0/a2/d0-d1/d4-d6,-(sp)
 move.l d0,d4
 move.l d1,d5
 movea.l 36(sp),a2
 move.l 40(sp),d6
 lea -22(sp),sp
 move.l a2,(sp)
 move.l d5,d0
 move.l #384,d1
 jsr _016a0(a6)
 movea.l D0002c(a6),a0
 move.l (a0),d1
 add.l d4,d1
 add.l d1,d0
 move.l d0,4(sp)
 moveq #255,d0
 move.l d0,8(sp)
 tst.l d6
 bne.s L09c50
 lea (sp),a0
 move.l a0,d0
 jsr _01856(a6)
 bra.s L09c58
L09c50 lea (sp),a0
 move.l a0,d0
 jsr _01868(a6)
L09c58 lea 22(sp),sp
 movem.l -20(a5),a0/a2/d4-d6
 unlk a5
 rts 
L09c66 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 pea (L000ff).w
 pea (L00020).w
 pea (L00020).w
 pea (L00091).w
 move.l #322,d1
 moveq #32,d0
 add.l D0002c(a6),d0
 bsr.w L07580
 lea 16(sp),sp
 movea.l D00028(a6),a0
 cmpi.w #255,6904(a0)
 beq.s L09cde
 tst.l (sp)
 bne.s L09cb4
 clr.l -(sp)
 move.l 8(sp),d0
 lsl.l #2,d0
 movea.l D0002c(a6),a0
 movea.l 28(a0),a0
 bra.s L09cc4
L09cb4 clr.l -(sp)
 move.l 8(sp),d0
 lsl.l #2,d0
 movea.l D0002c(a6),a0
 movea.l 24(a0),a0
L09cc4 movea.l 4(a0),a0
 move.l (a0,d0.l),-(sp)
 move.l #145,d1
 move.l #322,d0
 bsr.w L09c08
 addq.l #8,sp
L09cde movem.l -4(a5),a0
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2/d0-d1/d4-d6,-(sp)
 movea.l 4(sp),a0
 move.w 6(a0),d0
 asr.w #1,d0
 subi.w #58,d0
 move.w d0,d4
 movea.l 4(sp),a0
 move.l (a0),d5
 ext.l d4
 divs.w #38,d4
 tst.l d5
 bne.s L09d68
 cmpi.w #6,d4
 ble.s L09d18
 moveq #6,d4
L09d18 move.w d4,d0
 ext.l d0
 movea.l D0002c(a6),a0
 move.w 198(a0),d1
 ext.l d1
 add.l d1,d0
 move.l d0,d6
 movea.l D0002c(a6),a0
 move.w 194(a0),d0
 ext.l d0
 subq.l #1,d0
 cmp.l d6,d0
 blt.w L09dba
 move.l #6840,d0
 add.l D00028(a6),d0
 add.l d6,d0
 movea.l d0,a2
 movea.l D00028(a6),a0
 moveq #0,d0
 move.b (a2),d0
 move.w d0,6904(a0)
 movea.l D00028(a6),a0
 clr.w 6906(a0)
 moveq #0,d0
 move.b (a2),d0
 move.l d0,d1
 moveq #0,d0
 bra.s L09db6
L09d68 move.w d4,d0
 ext.l d0
 movea.l D0002c(a6),a0
 move.w 196(a0),d1
 ext.l d1
 add.l d1,d0
 move.l d0,d6
 movea.l D0002c(a6),a0
 move.w 192(a0),d0
 ext.l d0
 subq.l #1,d0
 cmp.l d6,d0
 blt.s L09dba
 move.l #6808,d0
 add.l D00028(a6),d0
 add.l d6,d0
 movea.l d0,a2
 movea.l D00028(a6),a0
 moveq #0,d0
 move.b (a2),d0
 move.w d0,6904(a0)
 movea.l D00028(a6),a0
 move.w #1,6906(a0)
 moveq #0,d0
 move.b (a2),d0
 move.l d0,d1
 moveq #1,d0
L09db6 bsr.w L09c66
L09dba movem.l -20(a5),a0/a2/d4-d6
 unlk a5
 rts 
 link.w a5,#0
 movem.l a2-a4/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 move.l 36(sp),d0
 move.l #384,d1
 jsr _016a0(a6)
 add.l 4(sp),d0
 adda.l d0,a2
 movea.l a2,a3
 moveq #0,d5
 bra.s L09e08
L09de8 movea.l a3,a4
 moveq #0,d4
 bra.s L09df6
L09dee move.l 48(sp),(a4)
 addq.l #1,d4
 addq.l #4,a4
L09df6 move.l 40(sp),d0
 asr.l #2,d0
 cmp.l d4,d0
 bgt.s L09dee
 addq.l #1,d5
 adda.l #384,a3
L09e08 cmp.l 44(sp),d5
 blt.s L09de8
 movem.l -20(a5),a2-a4/d4-d5
 unlk a5
 rts 
L09e18 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4-d6,-(sp)
 movea.l 40(sp),a2
 move.l 44(sp),d4
 move.l 48(sp),d5
 movea.l 52(sp),a3
 moveq #6,d0
 cmp.l d5,d0
 bge.s L09e38
 moveq #6,d5
L09e38 adda.l d4,a3
 moveq #0,d6
 bra.s L09e66
L09e3e move.l 56(sp),-(sp)
 moveq #0,d0
 move.b (a3),d0
 lsl.l #2,d0
 movea.l 4(a2),a0
 move.l (a0,d0.l),-(sp)
 move.l 12(sp),d1
 move.l 8(sp),d0
 bsr.w L09c08
 addq.l #8,sp
 addq.l #1,d6
 addq.l #1,a3
 moveq #38,d0
 add.l d0,(sp)
L09e66 cmp.l d5,d6
 blt.s L09e3e
 movem.l -24(a5),a0/a2-a3/d4-d6
 unlk a5
 rts 
L09e74 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 clr.l -(sp)
 movea.l D00028(a6),a0
 pea 6840(a0)
 movea.l D0002c(a6),a0
 movea.w 194(a0),a0
 move.l a0,-(sp)
 movea.l D0002c(a6),a0
 movea.w 198(a0),a0
 move.l a0,-(sp)
 movea.l D0002c(a6),a0
 move.l 28(a0),-(sp)
 moveq #119,d1
 moveq #58,d0
 bsr.w L09e18
 lea 20(sp),sp
 clr.l -(sp)
 movea.l D00028(a6),a0
 pea 6808(a0)
 movea.l D0002c(a6),a0
 movea.w 192(a0),a0
 move.l a0,-(sp)
 movea.l D0002c(a6),a0
 movea.w 196(a0),a0
 move.l a0,-(sp)
 movea.l D0002c(a6),a0
 move.l 24(a0),-(sp)
 move.l #177,d1
 moveq #58,d0
 bsr.w L09e18
 lea 20(sp),sp
 movea.l D00028(a6),a0
 moveq #0,d0
 move.w 6904(a0),d0
 move.l d0,d1
 movea.l D00028(a6),a0
 movea.w 6906(a0),a0
 move.l a0,d0
 bsr.w L09c66
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
L09f08 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 lea -12(sp),sp
 pea (sp)
 pea 8(sp)
 lea 16(sp),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01880(a6)
 addq.l #8,sp
 movea.l D0002c(a6),a0
 cmpi.w #1,208(a0)
 bne.s L09f5e
 btst.b #0,11(sp)
 beq.s L09f5e
 movea.l D0002c(a6),a0
 move.l 214(a0),-(sp)
 movea.l D0002c(a6),a0
 move.l 210(a0),d1
 move.l 16(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
 bra.s L09f66
L09f5e movea.l D0002c(a6),a0
 clr.w 208(a0)
L09f66 movea.l D0002c(a6),a0
 clr.l 204(a0)
 lea 12(sp),sp
 movem.l -4(a5),a0
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D0002c(a6),a0
 clr.w 208(a0)
 movea.l D0002c(a6),a0
 tst.l 204(a0)
 beq.s L09faa
 movea.l D0002c(a6),a0
 move.l 204(a0),d0
 jsr _01a60(a6)
 movea.l D0002c(a6),a0
 clr.l 204(a0)
L09faa movem.l -4(a5),a0
 unlk a5
 rts 
L09fb4 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D0002c(a6),a0
 tst.w 208(a0)
 bne.s L09fe6
 movea.l D0002c(a6),a0
 move.w #1,208(a0)
 movea.l D0002c(a6),a0
 move.l (sp),210(a0)
 movea.l D0002c(a6),a0
 move.l 4(sp),214(a0)
 moveq #50,d1
 bra.s L09fe8
L09fe6 moveq #6,d1
L09fe8 movea.l D0002c(a6),a0
 move.l 200(a0),d0
 jsr _0191c(a6)
 movea.l D0002c(a6),a0
 move.l d0,204(a0)
 movem.l -4(a5),a0
 unlk a5
 rts 
L0a006 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D00028(a6),a0
 btst.b #1,5623(a0)
 beq.s L0a022
 movea.l D00028(a6),a0
 clr.w 5618(a0)
L0a022 movea.l D0002c(a6),a0
 tst.w 198(a0)
 ble.s L0a0a8
 pea (L00001).w
 movea.l D00028(a6),a0
 pea 6840(a0)
 movea.l D0002c(a6),a0
 movea.w 194(a0),a0
 move.l a0,-(sp)
 movea.l D0002c(a6),a0
 movea.w 198(a0),a0
 move.l a0,-(sp)
 movea.l D0002c(a6),a0
 move.l 28(a0),-(sp)
 moveq #119,d1
 moveq #58,d0
 bsr.w L09e18
 lea 20(sp),sp
 movea.l D0002c(a6),a0
 subq.w #1,198(a0)
 clr.l -(sp)
 movea.l D00028(a6),a0
 pea 6840(a0)
 movea.l D0002c(a6),a0
 movea.w 194(a0),a0
 move.l a0,-(sp)
 movea.l D0002c(a6),a0
 movea.w 198(a0),a0
 move.l a0,-(sp)
 movea.l D0002c(a6),a0
 move.l 28(a0),-(sp)
 moveq #119,d1
 moveq #58,d0
 bsr.w L09e18
 lea 20(sp),sp
 move.l 4(sp),d1
 lea L0a006(pc),a0
 move.l a0,d0
 bsr.w L09fb4
L0a0a8 movem.l -4(a5),a0
 unlk a5
 rts 
L0a0b2 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D00028(a6),a0
 btst.b #1,5623(a0)
 beq.s L0a0d0
 movea.l D00028(a6),a0
 move.w #1,5618(a0)
L0a0d0 movea.l D0002c(a6),a0
 move.w 198(a0),d0
 ext.l d0
 movea.l D0002c(a6),a0
 move.w 194(a0),d1
 ext.l d1
 sub.l d0,d1
 moveq #6,d0
 cmp.l d1,d0
 bge.s L0a168
 pea (L00001).w
 movea.l D00028(a6),a0
 pea 6840(a0)
 movea.l D0002c(a6),a0
 movea.w 194(a0),a0
 move.l a0,-(sp)
 movea.l D0002c(a6),a0
 movea.w 198(a0),a0
 move.l a0,-(sp)
 movea.l D0002c(a6),a0
 move.l 28(a0),-(sp)
 moveq #119,d1
 moveq #58,d0
 bsr.w L09e18
 lea 20(sp),sp
 movea.l D0002c(a6),a0
 addq.w #1,198(a0)
 clr.l -(sp)
 movea.l D00028(a6),a0
 pea 6840(a0)
 movea.l D0002c(a6),a0
 movea.w 194(a0),a0
 move.l a0,-(sp)
 movea.l D0002c(a6),a0
 movea.w 198(a0),a0
 move.l a0,-(sp)
 movea.l D0002c(a6),a0
 move.l 28(a0),-(sp)
 moveq #119,d1
 moveq #58,d0
 bsr.w L09e18
 lea 20(sp),sp
 move.l 4(sp),d1
 lea L0a0b2(pc),a0
 move.l a0,d0
 bsr.w L09fb4
L0a168 movem.l -4(a5),a0
 unlk a5
 rts 
L0a172 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D0002c(a6),a0
 tst.w 196(a0)
 ble.w L0a20a
 pea (L00001).w
 movea.l D00028(a6),a0
 pea 6808(a0)
 movea.l D0002c(a6),a0
 movea.w 192(a0),a0
 move.l a0,-(sp)
 movea.l D0002c(a6),a0
 movea.w 196(a0),a0
 move.l a0,-(sp)
 movea.l D0002c(a6),a0
 move.l 24(a0),-(sp)
 move.l #177,d1
 moveq #58,d0
 bsr.w L09e18
 lea 20(sp),sp
 movea.l D0002c(a6),a0
 subq.w #1,196(a0)
 clr.l -(sp)
 movea.l D00028(a6),a0
 pea 6808(a0)
 movea.l D0002c(a6),a0
 movea.w 192(a0),a0
 move.l a0,-(sp)
 movea.l D0002c(a6),a0
 movea.w 196(a0),a0
 move.l a0,-(sp)
 movea.l D0002c(a6),a0
 move.l 24(a0),-(sp)
 move.l #177,d1
 moveq #58,d0
 bsr.w L09e18
 lea 20(sp),sp
 move.l 4(sp),d1
 lea L0a172(pc),a0
 move.l a0,d0
 bsr.w L09fb4
L0a20a movem.l -4(a5),a0
 unlk a5
 rts 
L0a214 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D0002c(a6),a0
 move.w 196(a0),d0
 ext.l d0
 movea.l D0002c(a6),a0
 move.w 192(a0),d1
 ext.l d1
 sub.l d0,d1
 moveq #6,d0
 cmp.l d1,d0
 bge.w L0a2be
 pea (L00001).w
 movea.l D00028(a6),a0
 pea 6808(a0)
 movea.l D0002c(a6),a0
 movea.w 192(a0),a0
 move.l a0,-(sp)
 movea.l D0002c(a6),a0
 movea.w 196(a0),a0
 move.l a0,-(sp)
 movea.l D0002c(a6),a0
 move.l 24(a0),-(sp)
 move.l #177,d1
 moveq #58,d0
 bsr.w L09e18
 lea 20(sp),sp
 movea.l D0002c(a6),a0
 addq.w #1,196(a0)
 clr.l -(sp)
 movea.l D00028(a6),a0
 pea 6808(a0)
 movea.l D0002c(a6),a0
 movea.w 192(a0),a0
 move.l a0,-(sp)
 movea.l D0002c(a6),a0
 movea.w 196(a0),a0
 move.l a0,-(sp)
 movea.l D0002c(a6),a0
 move.l 24(a0),-(sp)
 move.l #177,d1
 moveq #58,d0
 bsr.w L09e18
 lea 20(sp),sp
 move.l 4(sp),d1
 lea L0a214(pc),a0
 move.l a0,d0
 bsr.w L09fb4
L0a2be movem.l -4(a5),a0
 unlk a5
 rts 
L0a2c8 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4,-(sp)
 movea.l D0002c(a6),a0
 move.l 28(a0),d0
 jsr _01862(a6)
 movea.l D0002c(a6),a0
 move.l d0,28(a0)
 movea.l D0002c(a6),a0
 move.l 24(a0),d0
 jsr _01862(a6)
 movea.l D0002c(a6),a0
 move.l d0,24(a0)
 movea.l D00028(a6),a0
 move.l 6908(a0),d0
 addq.l #2,d0
 movea.l d0,a2
 move.l #6808,d0
 add.l D00028(a6),d0
 movea.l d0,a3
 pea (L00020).w
 moveq #0,d1
 move.l a3,d0
 jsr _016ac(a6)
 addq.l #4,sp
 movea.l D0002c(a6),a0
 clr.w 192(a0)
 movea.l D0002c(a6),a0
 clr.w 194(a0)
 moveq #1,d4
 bra.s L0a34a
L0a332 cmpi.w #1,(a2)
 bne.s L0a346
 move.b d4,d0
 subq.b #1,d0
 move.b d0,(a3)+
 movea.l D0002c(a6),a0
 addq.w #1,192(a0)
L0a346 addq.l #1,d4
 addq.l #2,a2
L0a34a moveq #25,d0
 cmp.l d4,d0
 bgt.s L0a332
 movea.l D00028(a6),a0
 tst.w 6906(a0)
 bne.s L0a36a
 movea.l D00028(a6),a0
 moveq #0,d0
 move.w 6904(a0),d0
 moveq #26,d1
 add.l d1,d0
 bra.s L0a376
L0a36a movea.l D00028(a6),a0
 moveq #0,d0
 move.w 6904(a0),d0
 addq.l #1,d0
L0a376 lsl.l #1,d0
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 tst.w (a0,d0.l)
 bne.s L0a390
 movea.l D00028(a6),a0
 move.w #255,6904(a0)
L0a390 movea.l D00028(a6),a0
 moveq #52,d0
 add.l 6908(a0),d0
 movea.l d0,a2
 move.l #6840,d0
 add.l D00028(a6),d0
 movea.l d0,a3
 pea (L00040).w
 moveq #0,d1
 move.l a3,d0
 jsr _016ac(a6)
 addq.l #4,sp
 moveq #26,d4
 bra.s L0a3d2
L0a3ba cmpi.w #1,(a2)
 bne.s L0a3ce
 moveq #230,d0
 add.b d4,d0
 move.b d0,(a3)+
 movea.l D0002c(a6),a0
 addq.w #1,194(a0)
L0a3ce addq.l #1,d4
 addq.l #2,a2
L0a3d2 moveq #78,d0
 cmp.l d4,d0
 bgt.s L0a3ba
 movem.l -20(a5),a0/a2-a3/d1/d4
 unlk a5
 rts 
L0a3e2 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 pea L040aa(pc)
 pea L083a2(pc)
 clr.l -(sp)
 moveq #6,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _0180e(a6)
 lea 12(sp),sp
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 movea.l D00028(a6),a1
 movea.l 178(a1),a1
 move.l 20(a0,d0.l),12(a1)
 movea.l D00028(a6),a0
 movea.l 6780(a0),a0
 clr.l 26(a0)
 movea.l D00028(a6),a0
 clr.w 5636(a0)
 movea.l D00028(a6),a0
 clr.w 5638(a0)
 movea.l D00028(a6),a0
 tst.w 5630(a0)
 beq.s L0a45a
 movea.l D00028(a6),a0
 movea.l 5018(a0),a0
 clr.w 34(a0)
 bsr.w L0307a
L0a45a movea.l D00028(a6),a0
 clr.l 6978(a0)
 movea.l D00028(a6),a0
 tst.w 6984(a0)
 bne.s L0a48e
 moveq #0,d1
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _017ea(a6)
 bsr.w L07916
 moveq #0,d1
 movea.l D00028(a6),a0
 move.l 4848(a0),d0
 bsr.w L07b7c
 bra.s L0a49a
L0a48e movea.l D00028(a6),a0
 move.l 6990(a0),d0
 bsr.w L07ec2
L0a49a movem.l -8(a5),a0-a1
 unlk a5
 rts 
L0a4a4 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 jsr _01a54(a6)
 move.l #92160,-(sp)
 movea.l D00028(a6),a0
 move.l 4792(a0),d1
 movea.l D00028(a6),a0
 move.l 162(a0),d0
 jsr _017c6(a6)
 addq.l #4,sp
 move.l #92160,-(sp)
 movea.l D00028(a6),a0
 move.l 4792(a0),d1
 movea.l D00028(a6),a0
 move.l 166(a0),d0
 jsr _017c6(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 move.l #16777215,d0
 and.l 162(a0),d0
 bset.l #30,d0
 move.l d0,-(sp)
 clr.l -(sp)
 movea.l D00028(a6),a0
 movea.w 66(a0),a0
 move.l a0,-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01814(a6)
 jsr _017ba(a6)
 lea 12(sp),sp
 bsr.w L09a76
 pea (L0001e).w
 moveq #30,d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _017d2(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 movea.l 5018(a0),a0
 movea.l 12(a0),a0
 clr.l 26(a0)
 clr.l -(sp)
 pea L083a2(pc)
 moveq #0,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _01808(a6)
 addq.l #8,sp
 lea L04b84(pc),a0
 movea.l D00028(a6),a1
 movea.l 5018(a1),a1
 movea.l 12(a1),a1
 move.l a0,26(a1)
 pea (L00006).w
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 pea (L0003f).w
 moveq #0,d1
 moveq #82,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 pea (L00006).w
 clr.l -(sp)
 clr.l -(sp)
 pea L0a3e2(pc)
 movea.l D00028(a6),a0
 movea.w 5576(a0),a0
 move.l a0,-(sp)
 moveq #0,d1
 moveq #122,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 bsr.w L08238
 clr.l -(sp)
 moveq #0,d1
 moveq #255,d0
 jsr _017c0(a6)
 addq.l #4,sp
 pea (L0001e).w
 movea.l D00028(a6),a0
 move.l 6780(a0),d1
 movea.l D0002c(a6),a0
 move.l 16(a0),d0
 jsr _01928(a6)
 addq.l #4,sp
 pea (L0007a).w
 movea.l D00028(a6),a0
 move.l 6780(a0),d1
 movea.l D0002c(a6),a0
 move.l 12(a0),d0
 jsr _01928(a6)
 addq.l #4,sp
 moveq #0,d0
 bsr.w L081b2
 pea (L00006).w
 pea (L00002).w
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 moveq #63,d1
 moveq #82,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 pea (L00006).w
 pea (L00002).w
 clr.l -(sp)
 pea L09ad6(pc)
 clr.l -(sp)
 moveq #63,d1
 moveq #122,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L0a66a link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D00028(a6),a0
 movea.l 6802(a0),a0
 pea 4(a0)
 pea (L00100).w
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01a66(a6)
 lea 16(sp),sp
 movea.l D0002c(a6),a0
 move.l 8(a0),d0
 jsr _017e4(a6)
 lea L0aeab(pc),a0
 move.l a0,d1
 movea.l D0002c(a6),a0
 move.l 8(a0),d0
 jsr _017de(a6)
 movea.l D0002c(a6),a0
 move.l d0,222(a0)
 lea L0aeb0(pc),a0
 move.l a0,d1
 movea.l D0002c(a6),a0
 move.l 8(a0),d0
 jsr _017de(a6)
 movea.l D0002c(a6),a0
 move.l d0,226(a0)
 bsr.w L0a2c8
 bsr.w L09e74
 bsr.w L09928
 bsr.w L099a4
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
L0a716 link.w a5,#0
 movem.l a0-a2/d0-d1,-(sp)
 lea L0aeb6(pc),a0
 move.l a0,d1
 movea.l D0002c(a6),a0
 move.l 8(a0),d0
 jsr _017de(a6)
 movea.l D0002c(a6),a0
 move.l d0,218(a0)
 lea L0aebd(pc),a0
 move.l a0,d1
 movea.l D0002c(a6),a0
 move.l 8(a0),d0
 jsr _017de(a6)
 movea.l D0002c(a6),a0
 move.l d0,12(a0)
 lea L0aec1(pc),a0
 move.l a0,d1
 movea.l D0002c(a6),a0
 move.l 8(a0),d0
 jsr _017d8(a6)
 movea.l d0,a2
 move.l 8(a2),-(sp)
 movea.l D0002c(a6),a0
 pea 32(a0)
 movea.l D0002c(a6),a0
 pea 72(a0)
 moveq #0,d1
 movea.l D0002c(a6),a0
 move.l 12(a0),d0
 jsr _0192e(a6)
 lea 12(sp),sp
 move.l 8(a2),-(sp)
 pea _00e66(a6)
 moveq #4,d1
 movea.l D0002c(a6),a0
 move.l 12(a0),d0
 bsr.w L08304
 addq.l #8,sp
 move.l 8(a2),-(sp)
 pea _00e96(a6)
 moveq #8,d1
 movea.l D0002c(a6),a0
 move.l 12(a0),d0
 bsr.w L08304
 addq.l #8,sp
 move.l 8(a2),-(sp)
 pea _00ec6(a6)
 move.l #304,d1
 movea.l D0002c(a6),a0
 move.l 12(a0),d0
 bsr.w L08304
 addq.l #8,sp
 pea (L0007a).w
 movea.l D00028(a6),a0
 move.l 6780(a0),d1
 movea.l D0002c(a6),a0
 move.l 12(a0),d0
 jsr _01934(a6)
 addq.l #4,sp
 lea L0aec5(pc),a0
 move.l a0,d1
 movea.l D0002c(a6),a0
 move.l 8(a0),d0
 jsr _017de(a6)
 movea.l D0002c(a6),a0
 move.l d0,16(a0)
 lea L0aec9(pc),a0
 move.l a0,d1
 movea.l D0002c(a6),a0
 move.l 8(a0),d0
 jsr _017d8(a6)
 movea.l d0,a2
 move.l 8(a2),-(sp)
 lea _00ef6(a6),a0
 move.l a0,d1
 movea.l D0002c(a6),a0
 move.l 16(a0),d0
 jsr _01a6c(a6)
 addq.l #4,sp
 pea (L0001e).w
 movea.l D00028(a6),a0
 move.l 6780(a0),d1
 movea.l D0002c(a6),a0
 move.l 16(a0),d0
 jsr _01934(a6)
 addq.l #4,sp
 lea _00f32(a6),a0
 movea.l D00028(a6),a1
 movea.l 6780(a1),a1
 move.l a0,26(a1)
 bsr.w L081f6
 moveq #1,d0
 bsr.w L081b2
 movem.l -12(a5),a0-a2
 unlk a5
 rts 
L0a876 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 bsr.w L0a66a
 movea.l D00028(a6),a0
 move.l #16777215,d0
 and.l 162(a0),d0
 bset.l #30,d0
 move.l d0,-(sp)
 clr.l -(sp)
 movea.l D00028(a6),a0
 movea.w 66(a0),a0
 move.l a0,-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01814(a6)
 jsr _017ba(a6)
 lea 12(sp),sp
 pea (L00008).w
 pea (L00001).w
 pea (L00001).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 move.l D00028(a6),d0
 jsr _017a8(a6)
 lea 12(sp),sp
 pea (L00006).w
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 pea (L0003f).w
 moveq #0,d1
 moveq #82,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 pea (L00006).w
 clr.l -(sp)
 clr.l -(sp)
 pea L0a716(pc)
 pea (L0003f).w
 moveq #0,d1
 moveq #122,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L0a93e link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 movea.l D0002c(a6),a0
 move.l 4(a0),-(sp)
 move.l #5670,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5648,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 movea.l D0002c(a6),a0
 move.l 28(a0),-(sp)
 move.l #5692,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5670,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 movea.l D0002c(a6),a0
 move.l 24(a0),-(sp)
 move.l #5714,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5692,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 movea.l D0002c(a6),a0
 move.l (a0),-(sp)
 move.l #5736,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5714,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 movea.l D0002c(a6),a0
 move.l 116(a0),-(sp)
 move.l #5758,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5736,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 movea.l D0002c(a6),a0
 move.l 156(a0),-(sp)
 moveq #0,d1
 move.l #5758,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 pea (L00800).w
 movea.l D0002c(a6),a0
 move.l 20(a0),-(sp)
 move.l #5978,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5956,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 pea (L00800).w
 movea.l D0002c(a6),a0
 move.l 8(a0),-(sp)
 moveq #0,d1
 move.l #5978,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 movea.l D00028(a6),a0
 pea 5956(a0)
 clr.l -(sp)
 move.l #5648,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01700(a6)
 addq.l #8,sp
 lea L0a876(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6396(a1)
 movea.l D00028(a6),a0
 clr.l 6400(a0)
 jsr _0184a(a6)
 movea.l D00028(a6),a0
 movea.l 178(a0),a0
 clr.w 20(a0)
 lea L0aecd(pc),a0
 move.l a0,d1
 move.l #6188,d0
 add.l D00028(a6),d0
 jsr _0170c(a6)
 moveq #1,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01706(a6)
 moveq #0,d0
 jsr _01712(a6)
 moveq #1,d0
 jsr _01712(a6)
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L0ab30 link.w a5,#0
 movem.l a0-a4/d0-d1/d4-d7,-(sp)
 movea.l 52(sp),a2
 movea.l 56(sp),a3
 movea.l 60(sp),a4
 move.l 64(sp),d4
 move.l 68(sp),d5
 move.l 72(sp),d6
 move.l 76(sp),d7
 move.l d7,D0002c(a6)
 pea (L000e6).w
 moveq #0,d1
 move.l d7,d0
 jsr _016ac(a6)
 addq.l #4,sp
 movea.l D0002c(a6),a0
 move.l (sp),(a0)
 movea.l D0002c(a6),a0
 move.l 4(sp),4(a0)
 movea.l D0002c(a6),a0
 move.l a2,24(a0)
 movea.l D0002c(a6),a0
 move.l a3,28(a0)
 movea.l D0002c(a6),a0
 move.l a4,20(a0)
 movea.l D0002c(a6),a0
 move.l d4,8(a0)
 movea.l D0002c(a6),a0
 clr.w 196(a0)
 movea.l D0002c(a6),a0
 clr.w 198(a0)
 movea.l D00028(a6),a0
 movea.l 178(a0),a0
 movea.l D0002c(a6),a1
 move.l 48(a0),200(a1)
 movea.l D0002c(a6),a0
 clr.w 208(a0)
 movea.l D0002c(a6),a0
 clr.l 204(a0)
 movea.l D0002c(a6),a0
 move.l d5,116(a0)
 movea.l D0002c(a6),a0
 move.l d6,156(a0)
 movea.l D0002c(a6),a0
 move.w #88,126(a0)
 movea.l D0002c(a6),a0
 move.w #128,166(a0)
 movea.l D0002c(a6),a0
 move.w #384,46(a0)
 movea.l D0002c(a6),a0
 move.w #196,86(a0)
 movea.l D0002c(a6),a0
 move.l (sp),36(a0)
 movea.l D0002c(a6),a0
 move.l 4(sp),76(a0)
 clr.l -(sp)
 move.l D0002c(a6),-(sp)
 lea L09f08(pc),a0
 move.l a0,d1
 movea.l D0002c(a6),a0
 move.l 200(a0),d0
 jsr _0193a(a6)
 addq.l #8,sp
 move.l 80(sp),-(sp)
 lea L0a93e(pc),a0
 move.l a0,d1
 moveq #0,d0
 jsr _016a6(a6)
 addq.l #4,sp
 movem.l -36(a5),a0-a4/d4-d7
 unlk a5
 rts 
L0ac48 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l 4(sp),-(sp)
 movea.l D00028(a6),a0
 movea.l 166(a0),a0
 move.l #65856,d0
 pea (a0,d0.l)
 movea.l D00028(a6),a0
 movea.l 166(a0),a0
 move.l #47040,d0
 pea (a0,d0.l)
 movea.l D00028(a6),a0
 movea.l 166(a0),a0
 pea 28224(a0)
 movea.l D00028(a6),a0
 movea.l 166(a0),a0
 pea 23520(a0)
 movea.l D00028(a6),a0
 move.l 6802(a0),-(sp)
 movea.l D00028(a6),a0
 movea.l 4796(a0),a0
 pea 23520(a0)
 movea.l D00028(a6),a0
 move.l 4796(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 166(a0),d1
 movea.l D00028(a6),a0
 move.l 162(a0),d0
 bsr.w L0ab30
 lea 32(sp),sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L0acce link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 clr.l -(sp)
 moveq #0,d1
 moveq #255,d0
 jsr _017c0(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _017f0(a6)
 bsr.w L0c834
 pea (L00006).w
 pea (L00002).w
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 movea.l D00028(a6),a0
 movea.w 5576(a0),a0
 move.l a0,d1
 moveq #122,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 pea (L00006).w
 pea (L00002).w
 pea L0a876(pc)
 pea L0ac48(pc)
 clr.l -(sp)
 moveq #63,d1
 moveq #82,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L0ad44 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _017f0(a6)
 bsr.w L0c834
 movea.l D00028(a6),a0
 movea.l 178(a0),a0
 cmpi.w #8,(a0)
 beq.s L0ad82
 move.l 4(sp),-(sp)
 lea L0acce(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 jsr _01802(a6)
 bra.s L0ad94
L0ad82 move.l 4(sp),-(sp)
 lea L0acce(pc),a0
 move.l a0,d1
 move.l 4(sp),d0
 jsr _016a6(a6)
L0ad94 addq.l #4,sp
 movem.l -4(a5),a0
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D0002c(a6),a0
 move.l 24(a0),-(sp)
 movea.l D0002c(a6),a0
 move.l 4(a0),-(sp)
 movea.l D0002c(a6),a0
 move.l 20(a0),d1
 movea.l D00028(a6),a0
 move.l 162(a0),d0
 bsr.w L0c01c
 addq.l #8,sp
 movem.l -4(a5),a0
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 subq.l #4,sp
 movea.l 8(sp),a0
 move.l (a0),(sp)
 pea (L0001e).w
 movea.l D00028(a6),a0
 move.l 6780(a0),d1
 movea.l D0002c(a6),a0
 move.l 16(a0),d0
 jsr _01928(a6)
 addq.l #4,sp
 pea (L0007a).w
 movea.l D00028(a6),a0
 move.l 6780(a0),d1
 movea.l D0002c(a6),a0
 move.l 12(a0),d0
 jsr _01928(a6)
 addq.l #4,sp
 pea (Lffffffffffffffff).w
 movea.l D00028(a6),a0
 move.l 6780(a0),d1
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _01718(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _019a6(a6)
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _019ac(a6)
 clr.l -(sp)
 moveq #0,d1
 moveq #255,d0
 jsr _017c0(a6)
 addq.l #4,sp
 bsr.w L09a76
 pea (L00006).w
 pea (L00002).w
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 moveq #63,d1
 moveq #82,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 pea (L00006).w
 pea (L00002).w
 clr.l -(sp)
 move.l 12(sp),-(sp)
 clr.l -(sp)
 moveq #63,d1
 moveq #122,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 addq.l #4,sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L0aea8 move.w 102(a0,d0.w),d0
L0aeab equ *-1
 ble.s L0af1c
 moveq #0,d2
L0aeb0 dc.w $7369
 beq.s L0af22
 dc.w $7300
L0aeb6 dc.w $6c61
 dc.w $6265
 dc.w $6c73
 ori.w #$6e76,105(a1)
L0aebd equ *-5
L0aec1 equ *-1
 bgt.s L0af3a
 ori.w #$6f74,104(a0)
L0aec5 equ *-5
L0aec9 equ *-1
 ble.s L0af40
 ori.w #$6e76,25966(a1)
L0aecd equ *-5
 moveq #0,d2
L0aed4 link.w a5,#0
 movem.l a2/d0-d1/d4-d7,-(sp)
 move.l d0,d4
 movea.l d1,a2
 move.l 36(sp),d5
 move.l 40(sp),d6
 subq.l #6,sp
 moveq #0,d7
 move.l d6,-(sp)
 moveq #0,d1
 move.l a2,d0
 jsr _016ac(a6)
 addq.l #4,sp
 tst.w d5
 bne.s L0af2a
 moveq #10,d5
 bra.s L0af2a
L0af00 moveq #0,d0
 move.w d5,d0
 move.l d0,d1
 move.l d4,d0
 jsr _017ae(a6)
 move.b d0,1(sp)
 moveq #0,d0
 move.w d5,d0
 move.l d0,d1
 move.l d4,d0
 jsr _01904(a6)
L0af1c move.l d0,d4
 moveq #48,d0
 add.b 1(sp),d0
L0af22 equ *-2
 move.b d0,(a2,d7.l)
 addq.l #1,d7
L0af2a tst.l d4
 bne.s L0af00
 tst.l d7
 beq.s L0af6e
 subq.l #1,d7
 clr.l 2(sp)
 bra.s L0af64
L0af3a move.l 2(sp),d0
 move.b (a2,d0.l),1(sp)
L0af40 equ *-4
 move.l d7,d0
 sub.l 2(sp),d0
 move.l 2(sp),d1
 move.b (a2,d0.l),(a2,d1.l)
 move.l d7,d0
 sub.l 2(sp),d0
 move.b 1(sp),(a2,d0.l)
 addq.l #1,2(sp)
L0af64 move.l d7,d0
 asr.l #1,d0
 cmp.l 2(sp),d0
 bge.s L0af3a
L0af6e move.b (a2),d0
 ext.w d0
 ext.l d0
 addq.l #6,sp
 movem.l -20(a5),a2/d4-d7
 unlk a5
 rts 
L0af80 link.w a5,#0
 movem.l a0-a1/d0,-(sp)
 movea.l D00028(a6),a0
 subq.w #1,9566(a0)
 lea L110cc(pc),a0
 movea.l (sp),a1
 move.l a0,14(a1)
 lea L11768(pc),a0
 movea.l (sp),a1
 move.l a0,18(a1)
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L0afae link.w a5,#0
 movem.l a0-a4/d0-d1/d4-d6,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 subq.l #4,sp
 movea.l 8(a3),a4
 moveq #44,d0
 add.l a3,d0
 move.l d0,d4
 move.l a4,d0
 addq.l #8,d0
 move.l d0,d5
 moveq #0,d6
 movea.l d4,a0
 move.w (a0),d0
 ext.l d0
 movea.l d5,a0
 move.w (a0),d1
 ext.l d1
 sub.l d0,d1
 move.l d1,d0
 jsr _0196a(a6)
 move.w d0,(sp)
 movea.l d4,a0
 move.w 2(a0),d0
 ext.l d0
 movea.l d5,a0
 move.w 2(a0),d1
 ext.l d1
 sub.l d0,d1
 move.l d1,d0
 jsr _0196a(a6)
 move.w d0,2(sp)
 cmpi.w #8,(sp)
 ble.s L0b00a
 move.w #8,(sp)
L0b00a cmpi.w #8,2(sp)
 ble.s L0b018
 move.w #8,2(sp)
L0b018 movea.l d5,a0
 movea.l d4,a1
 move.w (a1),d0
 cmp.w (a0),d0
 bge.s L0b02a
 move.w (sp),d0
 movea.l d4,a0
 add.w d0,(a0)
 bra.s L0b03a
L0b02a movea.l d5,a0
 movea.l d4,a1
 move.w (a1),d0
 cmp.w (a0),d0
 ble.s L0b03c
 move.w (sp),d0
 movea.l d4,a0
 sub.w d0,(a0)
L0b03a moveq #1,d6
L0b03c movea.l d5,a0
 movea.l d4,a1
 move.w 2(a1),d0
 cmp.w 2(a0),d0
 bge.s L0b056
 move.w 2(sp),d0
 movea.l d4,a0
 add.w d0,2(a0)
 bra.s L0b06e
L0b056 movea.l d5,a0
 movea.l d4,a1
 move.w 2(a1),d0
 cmp.w 2(a0),d0
 ble.s L0b070
 move.w 2(sp),d0
 movea.l d4,a0
 sub.w d0,2(a0)
L0b06e moveq #1,d6
L0b070 move.l a2,d1
 move.l 4(a3),d0
 bsr.w L10dbc
 tst.w d6
 bne.s L0b090
 move.l 46(a2),-(sp)
 lea L0b0e4(pc),a0
 move.l a0,d1
 move.l a2,d0
 jsr _017fc(a6)
 addq.l #4,sp
L0b090 move.l a2,d1
 move.l a3,d0
 bsr.w L10d92
 move.l a3,d0
 bsr.w L05a6a
 addq.l #4,sp
 movem.l -32(a5),a0-a4/d4-d6
 unlk a5
 rts 
L0b0aa link.w a5,#0
 movem.l a0/a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 addq.w #1,14(a3)
 move.w 14(a3),d0
 cmp.w 12(a3),d0
 blt.s L0b0da
 clr.w 14(a3)
 move.l 46(a2),-(sp)
 lea L0b0e4(pc),a0
 move.l a0,d1
 move.l a2,d0
 jsr _017fc(a6)
 addq.l #4,sp
L0b0da movem.l -12(a5),a0/a2-a3
 unlk a5
 rts 
L0b0e4 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 movea.l 8(a3),a4
 move.l 4(a4),d4
 movea.l d4,a0
 move.l (a0),d0
 moveq #16,d1
 lsr.l d1,d0
 move.l d0,d5
 movea.l d4,a0
 move.l (a0),d0
 lsr.l #8,d0
 andi.l #$000000ff,d0
 subi.l #128,d0
 move.l d0,d6
 movea.l d4,a0
 move.l #255,d0
 and.l (a0),d0
 subi.l #128,d0
 move.l d0,d7
 bra.w L0b1cc
 move.l d7,d1
 move.l a3,d0
 bsr.w L11d68
 bra.w L0b1ee
 movea.l D00028(a6),a0
 tst.w 9566(a0)
 bne.w L0b1ee
 pea (L00002).w
 move.l a3,d1
 move.l #9120,d0
 add.l D00028(a6),d0
 jsr _018c2(a6)
 addq.l #4,sp
 move.l a2,d1
 move.l 4(a3),d0
 bsr.w L10dbc
 bra.w L0b1ee
 tst.l d6
 bne.s L0b174
 pea (a3)
 lea L11db2(pc),a0
 bra.s L0b17a
L0b174 clr.l -(sp)
 lea L1219e(pc),a0
L0b17a move.l a0,d1
 move.l a2,d0
 jsr _017fc(a6)
 addq.l #4,sp
 move.w d7,12(a4)
 clr.w 14(a4)
 bra.s L0b1ee
 move.w d6,d0
 lsl.w #1,d0
 move.w d0,8(a4)
 move.w d7,d0
 lsl.w #1,d0
 move.w d0,10(a4)
 pea (a3)
 lea L0afae(pc),a0
 move.l a0,d1
 move.l a2,d0
 jsr _017fc(a6)
 bra.s L0b1c8
 move.l d7,_00f46(a6)
 tst.b 53(a3)
 bne.s L0b1ee
 move.b d7,52(a3)
 bra.s L0b1ee
 pea (a3)
 move.l d7,d1
 moveq #1,d0
 bsr.w L077fe
L0b1c8 addq.l #4,sp
 bra.s L0b1ee
L0b1cc move.l d5,d0
 subq.l #4,d0
 cmpi.l #5,d0
 bhi.s L0b1ee
 add.w d0,d0
 move.w L0b1e0(pc,d0.w),d0
 jmp L0b1e0(pc,d0.w)
L0b1e0 equ *-2
 dc.w $ff86
 dc.w $ffac
 dc.w $ff56
 dc.w $ff4a
 dc.w $ffcc
 dc.w $ffdc
L0b1ee addq.l #4,4(a4)
 movea.l 4(a4),a0
 tst.l (a0)
 bne.s L0b1fe
 move.l (a4),4(a4)
L0b1fe movem.l -32(a5),a0/a2-a4/d4-d7
 unlk a5
 rts 
L0b208 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d6,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 movea.l 44(sp),a4
 move.l 48(sp),d4
 lea -12(sp),sp
 move.l #8968,d0
 add.l D00028(a6),d0
 move.l d0,d6
 subi.l #54,d4
 lea L0b338(pc),a0
 move.l a0,d1
 move.l a2,d0
 jsr _017de(a6)
 move.l d0,d5
 subi.l #76,d6
 bra.w L0b2ee
L0b24a movea.l d5,a0
 move.l (a0),d0
 moveq #16,d1
 lsr.l d1,d0
 move.l d0,(sp)
 movea.l d5,a0
 move.l (a0),d0
 lsr.l #8,d0
 andi.l #$000000ff,d0
 subi.l #128,d0
 move.l d0,8(sp)
 movea.l d5,a0
 move.l #255,d0
 and.l (a0),d0
 subi.l #128,d0
 move.l d0,4(sp)
 bra.s L0b2d0
L0b280 addi.l #$0000004c,d6
 addi.l #$00000036,d4
 movea.l d4,a0
 move.l d6,8(a0)
 movea.l d4,a0
 move.w #5,26(a0)
 movea.l d4,a0
 clr.b 49(a0)
 bra.s L0b2ec
L0b2a2 move.w 10(sp),d0
 lsl.w #1,d0
 movea.l d4,a0
 move.w d0,44(a0)
 move.w 6(sp),d0
 lsl.w #1,d0
 movea.l d4,a0
 move.w d0,46(a0)
 bra.s L0b2ec
L0b2bc move.l d5,d0
 addq.l #4,d0
 movea.l d6,a0
 move.l d0,(a0)
 move.l d5,d0
 addq.l #4,d0
 movea.l d6,a0
 move.l d0,4(a0)
 bra.s L0b2ec
L0b2d0 move.l (sp),d0
 cmpi.l #255,d0
 bhi.s L0b2ec
 cmpi.b #1,d0
 beq.s L0b280
 cmpi.b #2,d0
 beq.s L0b2a2
 cmpi.b #3,d0
 beq.s L0b2bc
L0b2ec addq.l #4,d5
L0b2ee movea.l d5,a0
 tst.l (a0)
 bne.w L0b24a
 adda.l #46,a3
 movea.l 6(a3),a4
 pea (L00002).w
 pea (a4)
 pea (a3)
 pea L0af80(pc)
 pea L11768(pc)
 move.l #9120,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l a2,d0
 jsr _01a78(a6)
 lea 20(sp),sp
 clr.l _00f46(a6)
 lea 12(sp),sp
 movem.l -28(a5),a0/a2-a4/d4-d6
 unlk a5
 rts 
L0b338 bmi.s L0b3aa
 subq.w #7,28265(a1)
 moveq #0,d2
 link.w a5,#0
 movem.l a0/a2/d0-d1,-(sp)
 bsr.w L08238
 moveq #0,d0
 bsr.w L081b2
 clr.l -(sp)
 moveq #0,d1
 moveq #255,d0
 jsr _017c0(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 movea.l 6780(a0),a0
 clr.l 26(a0)
 pea (L00003).w
 pea (L00002).w
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 moveq #63,d1
 moveq #82,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 pea (L00003).w
 pea (L00002).w
 pea L0a876(pc)
 pea L0ac48(pc)
 clr.l -(sp)
 moveq #63,d1
 moveq #122,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
L0b3aa movem.l -8(a5),a0/a2
 unlk a5
 rts 
L0b3b4 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.l 6780(a0),d1
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _01718(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _0171e(a6)
 lea _00f4a(a6),a0
 movea.l D00028(a6),a1
 movea.l 6780(a1),a1
 move.l a0,26(a1)
 moveq #1,d0
 bsr.w L081b2
 movem.l -12(a5),a0-a1/d1
 unlk a5
 rts 
L0b400 link.w a5,#0
 movem.l a0/a2-a4/d0-d2/d4-d7,-(sp)
 lea -10(sp),sp
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 move.w 320(a0),d7
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 move.w 316(a0),8(sp)
 movea.l D00028(a6),a0
 moveq #108,d0
 add.l 6908(a0),d0
 move.l d0,4(sp)
 movea.l D00028(a6),a0
 moveq #74,d0
 add.l 6908(a0),d0
 move.l d0,(sp)
 movea.l D00028(a6),a0
 move.l 4796(a0),d0
 jsr _01862(a6)
 movea.l d0,a4
 movea.l D00028(a6),a0
 move.l 166(a0),d0
 jsr _017e4(a6)
 lea L0b87c(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 166(a0),d0
 jsr _017de(a6)
 movea.l d0,a3
 lea L0b880(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 166(a0),d0
 jsr _017d8(a6)
 movea.l d0,a2
 lea L0b884(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 166(a0),d0
 jsr _017de(a6)
 move.l d0,d6
 moveq #0,d4
 bra.w L0b540
L0b49c move.l d4,d0
 addq.l #1,d0
 move.w d7,d1
 ext.l d1
 cmp.l d1,d0
 bne.s L0b4ac
 moveq #2,d5
 bra.s L0b50a
L0b4ac movea.l d6,a0
 move.w (a0),d0
 ext.l d0
 move.l d4,d1
 addq.l #1,d1
 cmp.l d1,d0
 bne.s L0b4d0
 move.w 8(sp),d0
 ext.l d0
 subq.l #1,d0
 lsl.l #1,d0
 movea.l (sp),a0
 tst.w (a0,d0.l)
 beq.s L0b4d0
 moveq #3,d5
 bra.s L0b50a
L0b4d0 move.w 8(sp),d0
 ext.l d0
 lsl.l #5,d0
 movea.l D00028(a6),a0
 adda.l d0,a0
 move.l d4,d0
 addq.l #1,d0
 adda.l d0,a0
 tst.b 9568(a0)
 beq.s L0b4ee
 moveq #1,d5
 bra.s L0b50a
L0b4ee move.w 8(sp),d0
 ext.l d0
 subq.l #1,d0
 lsl.l #1,d0
 movea.l 4(sp),a0
 cmpi.w #1,(a0,d0.l)
 bne.s L0b508
 moveq #0,d5
 bra.s L0b50a
L0b508 moveq #255,d5
L0b50a cmpi.w #-1,d5
 beq.s L0b53c
 clr.l -(sp)
 move.w d5,d0
 ext.l d0
 lsl.l #2,d0
 movea.l 4(a4),a0
 move.l (a0,d0.l),-(sp)
 moveq #10,d0
 muls.w 2(a3),d0
 moveq #60,d1
 add.l d1,d0
 move.l d0,d1
 move.w (a3),d0
 ext.l d0
 lsl.l #4,d0
 moveq #72,d2
 add.l d2,d0
 bsr.w L09c08
 addq.l #8,sp
L0b53c addq.l #1,d4
 addq.l #4,a3
L0b540 cmp.l 8(a2),d4
 bcs.w L0b49c
 lea 10(sp),sp
 movem.l -40(a5),a0/a2-a4/d1-d2/d4-d7
 unlk a5
 rts 
L0b556 link.w a5,#0
 movem.l a0/a2-a3/d0-d2/d4-d5,-(sp)
 movea.l D00028(a6),a0
 movea.l 8092(a0),a2
 movea.l D00028(a6),a0
 move.l 4796(a0),d0
 jsr _01862(a6)
 movea.l d0,a3
 moveq #0,d4
 bra.s L0b5ba
L0b578 moveq #0,d5
 bra.s L0b5b2
L0b57c move.l d5,d0
 lsl.l #5,d0
 add.l d4,d0
 cmpi.b #1,(a2,d0.l)
 bne.s L0b5b0
 clr.l -(sp)
 movea.l 4(a3),a0
 move.l 4(a0),-(sp)
 move.l d5,d0
 moveq #5,d1
 jsr _016a0(a6)
 moveq #58,d1
 add.l d1,d0
 move.l d0,d1
 move.l d4,d0
 lsl.l #3,d0
 moveq #66,d2
 add.l d2,d0
 bsr.w L09c08
 addq.l #8,sp
L0b5b0 addq.l #1,d5
L0b5b2 moveq #33,d0
 cmp.l d5,d0
 bgt.s L0b57c
 addq.l #1,d4
L0b5ba moveq #32,d0
 cmp.l d4,d0
 bgt.s L0b578
 clr.l -(sp)
 movea.l 4(a3),a0
 move.l 8(a0),-(sp)
 movea.l D00028(a6),a0
 moveq #5,d0
 muls.w 4846(a0),d0
 moveq #58,d1
 add.l d1,d0
 move.l d0,d1
 movea.l D00028(a6),a0
 move.w 4844(a0),d0
 ext.l d0
 lsl.l #3,d0
 moveq #66,d2
 add.l d2,d0
 bsr.w L09c08
 addq.l #8,sp
 movem.l -28(a5),a0/a2-a3/d1-d2/d4-d5
 unlk a5
 rts 
L0b5fa link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D00028(a6),a0
 movea.l 6802(a0),a0
 pea 4(a0)
 pea (L00100).w
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01a66(a6)
 lea 16(sp),sp
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 tst.w 316(a0)
 bne.s L0b660
 bsr.w L0b556
 bra.s L0b664
L0b660 bsr.w L0b400
L0b664 pea (L00003).w
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 pea (L0003f).w
 moveq #0,d1
 moveq #82,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 pea (L00003).w
 clr.l -(sp)
 clr.l -(sp)
 pea L0b3b4(pc)
 pea (L0003f).w
 moveq #0,d1
 moveq #122,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L0b6ac link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 lea -32(sp),sp
 lea L0b88d(pc),a0
 move.l a0,d1
 lea 16(sp),a0
 move.l a0,d0
 jsr _017f6(a6)
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 tst.w 316(a0)
 beq.s L0b706
 pea (L00010).w
 pea (L0000a).w
 lea 8(sp),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 movea.w 316(a0),a0
 move.l a0,d0
 bsr.w L0aed4
 addq.l #8,sp
 lea (sp),a0
 move.l a0,d1
 lea 19(sp),a0
 move.l a0,d0
 jsr _017f6(a6)
L0b706 clr.l -(sp)
 clr.l -(sp)
 pea (L00800).w
 movea.l D00028(a6),a0
 move.l 6802(a0),-(sp)
 move.l #5978,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5956,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 movea.l D00028(a6),a0
 move.l 166(a0),-(sp)
 moveq #0,d1
 move.l #5978,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 movea.l D00028(a6),a0
 move.l 162(a0),-(sp)
 move.l #5670,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5648,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 movea.l D00028(a6),a0
 move.l 4796(a0),-(sp)
 moveq #0,d1
 move.l #5670,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 movea.l D00028(a6),a0
 pea 5956(a0)
 clr.l -(sp)
 move.l #5648,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01700(a6)
 addq.l #8,sp
 lea L0b5fa(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6396(a1)
 movea.l D00028(a6),a0
 clr.l 6400(a0)
 lea 16(sp),a0
 move.l a0,d1
 move.l #6188,d0
 add.l D00028(a6),d0
 jsr _0170c(a6)
 moveq #1,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01706(a6)
 lea 32(sp),sp
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
 link.w a5,#0
 movem.l d0-d1,-(sp)
 bsr.w L08238
 clr.l -(sp)
 moveq #0,d1
 moveq #255,d0
 jsr _017c0(a6)
 addq.l #4,sp
 pea (L00003).w
 pea (L00002).w
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 moveq #63,d1
 moveq #82,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 pea (L00003).w
 pea (L00002).w
 clr.l -(sp)
 pea L0b6ac(pc)
 clr.l -(sp)
 moveq #63,d1
 moveq #122,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 movem.l -4(a5),d1
 unlk a5
 rts 
L0b87c dc.w $6d61
 moveq #0,d0
L0b880 dc.w $6d61
 moveq #0,d0
L0b884 moveq #114,d2
 dc.w $6561
 dc.w $7375
 moveq #101,d1
 ori.w #$6170,12288(a5)
L0b88d equ *-5
L0b892 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 movea.l 36(sp),a4
 move.l 48(sp),d4
 lea -88(sp),sp
 move.l a3,d0
 jsr _01850(a6)
 move.l d0,80(sp)
 moveq #32,d1
 cmp.l d0,d1
 bge.s L0b8c0
 moveq #32,d0
 move.l d0,80(sp)
L0b8c0 move.l a4,d0
 jsr _01850(a6)
 move.l d0,76(sp)
 moveq #40,d1
 cmp.l d0,d1
 bge.s L0b8d6
 moveq #40,d0
 move.l d0,76(sp)
L0b8d6 pea (L00004).w
 pea _0130a(a6)
 move.l 88(sp),-(sp)
 lea 52(sp),a0
 move.l a0,d1
 move.l a3,d0
 jsr _01a7e(a6)
 lea 12(sp),sp
 move.l d0,80(sp)
 pea (L00004).w
 pea _0130a(a6)
 move.l 84(sp),-(sp)
 lea 12(sp),a0
 move.l a0,d1
 move.l a4,d0
 jsr _01a7e(a6)
 lea 12(sp),sp
 move.l d0,76(sp)
 move.l 80(sp),d0
 addq.l #8,d0
 add.l 76(sp),d0
 add.l 128(sp),d0
 move.l d0,84(sp)
 move.l a2,d0
 jsr _01a84(a6)
 tst.l d0
 beq.w L0ba06
 move.l 84(sp),-(sp)
 pea (L0005b).w
 moveq #3,d1
 move.l a2,d0
 jsr _01a8a(a6)
 addq.l #8,sp
 move.l d0,72(sp)
 moveq #255,d0
 cmp.l 72(sp),d0
 beq.w L0b9fe
 tst.l d4
 beq.w L0b9f6
 movea.l d4,a0
 move.w #8,8(a0)
 movea.l d4,a0
 move.w 8(a0),d0
 add.w 82(sp),d0
 movea.l d4,a0
 move.w d0,10(a0)
 movea.l d4,a0
 move.w 10(a0),d0
 add.w 78(sp),d0
 movea.l d4,a0
 move.w d0,12(a0)
 movea.l d4,a0
 clr.w 6(a0)
 pea (L00008).w
 move.l d4,d0
 addq.l #6,d0
 move.l d0,d1
 move.l 76(sp),d0
 jsr _01a90(a6)
 addq.l #4,sp
 moveq #255,d1
 cmp.l d0,d1
 beq.s L0b9f6
 move.l 80(sp),-(sp)
 lea 44(sp),a0
 move.l a0,d1
 move.l 76(sp),d0
 jsr _01a90(a6)
 addq.l #4,sp
 moveq #255,d1
 cmp.l d0,d1
 beq.s L0b9f6
 move.l 76(sp),-(sp)
 lea 4(sp),a0
 move.l a0,d1
 move.l 76(sp),d0
 jsr _01a90(a6)
 addq.l #4,sp
 moveq #255,d1
 cmp.l d0,d1
 beq.s L0b9f6
 movea.l d4,a0
 move.l 72(sp),(a0)
 movea.l d4,a0
 move.w 134(sp),4(a0)
 movea.l d4,a0
 moveq #0,d0
 move.w 12(a0),d0
 movea.l d4,a0
 move.l d0,14(a0)
 move.l d4,d0
 bra.s L0ba08
L0b9f6 move.l 72(sp),d0
 jsr _019d0(a6)
L0b9fe move.l #12292,D0000c(a6)
L0ba06 moveq #0,d0
L0ba08 lea 88(sp),sp
 movem.l -20(a5),a0/a2-a4/d4
 unlk a5
 rts 
L0ba16 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 pea (L0007a).w
 movea.l D00028(a6),a0
 move.l 6780(a0),d1
 movea.l D00030(a6),a0
 move.l 8(a0),d0
 jsr _01928(a6)
 addq.l #4,sp
 bsr.w L08238
 moveq #0,d0
 bsr.w L081b2
 clr.l -(sp)
 moveq #0,d1
 moveq #255,d0
 jsr _017c0(a6)
 addq.l #4,sp
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 lea L0a876(pc),a0
 movea.l 4(sp),a1
 move.l a0,(a1)
 bsr.s L0ba16
 pea (L00003).w
 pea (L00002).w
 pea L0a876(pc)
 pea L0ac48(pc)
 clr.l -(sp)
 moveq #63,d1
 moveq #82,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
 link.w a5,#0
 movem.l d0-d1,-(sp)
 bsr.w L0ba16
 pea (L00003).w
 pea (L00002).w
 pea (L00001).w
 pea L08952(pc)
 clr.l -(sp)
 moveq #63,d1
 moveq #82,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 unlk a5
 rts 
L0baca link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 lea -246(sp),sp
 pea (sp)
 lea 22(sp),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 movea.w 5114(a0),a0
 move.l a0,d0
 bsr.w L0ec16
 addq.l #4,sp
 lea 18(sp),a0
 move.l a0,d0
 bsr.w L0ed8e
 pea (sp)
 lea 22(sp),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 movea.w 5114(a0),a0
 move.l a0,d0
 bsr.w L0ebb4
 addq.l #4,sp
 clr.l -(sp)
 lea L08952(pc),a0
 move.l a0,d1
 move.l 250(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
 lea 246(sp),sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L0bb30 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 movea.l D00028(a6),a0
 movea.l D00028(a6),a1
 move.l 4792(a0),126(a1)
 jsr _016be(a6)
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 jsr _016ee(a6)
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 bsr.w L1398c
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #122,d0
 add.l D00028(a6),d0
 move.l d0,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 bsr.w L139e4
 addq.l #8,sp
 pea (L00005).w
 pea (L00005).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 move.l D00028(a6),d0
 bsr.w L13aa2
 addq.l #8,sp
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 moveq #1,d0
 jsr _016e2(a6)
 pea (L00006).w
 clr.l -(sp)
 clr.l -(sp)
 pea L0baca(pc)
 pea (L0003f).w
 moveq #0,d1
 moveq #122,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L0bc18 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 movea.l D00028(a6),a0
 move.l 4792(a0),-(sp)
 moveq #0,d1
 move.l #5648,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #5648,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01700(a6)
 addq.l #8,sp
 lea L0bb30(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6396(a1)
 movea.l D00028(a6),a0
 clr.l 6400(a0)
 lea L0c180(pc),a0
 move.l a0,d1
 move.l #6188,d0
 add.l D00028(a6),d0
 jsr _0170c(a6)
 moveq #1,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01706(a6)
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
 link.w a5,#0
 movem.l d0-d1,-(sp)
 bsr.w L0ba16
 pea (L00003).w
 pea (L00002).w
 clr.l -(sp)
 pea L0bc18(pc)
 clr.l -(sp)
 moveq #63,d1
 moveq #82,d0
 add.l D00028(a6),d0
 jsr _016ca(a6)
 lea 20(sp),sp
 unlk a5
 rts 
L0bcd8 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D00028(a6),a0
 movea.l 6780(a0),a0
 clr.l 26(a0)
 pea (L0007a).w
 movea.l D00028(a6),a0
 move.l 6780(a0),d1
 movea.l 8(sp),a0
 move.l 8(a0),d0
 jsr _01934(a6)
 addq.l #4,sp
 bsr.w L081f6
 moveq #1,d0
 bsr.w L081b2
 movem.l -4(a5),a0
 unlk a5
 rts 
L0bd1a link.w a5,#0
 movem.l a0-a2/d0-d1,-(sp)
 move.l 4(sp),D00030(a6)
 movea.l 4(sp),a0
 movea.l 4(a0),a0
 pea 4(a0)
 pea (L00100).w
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01a66(a6)
 lea 16(sp),sp
 movea.l 4(sp),a0
 move.l 16(a0),d0
 jsr _017e4(a6)
 lea L0c184(pc),a0
 move.l a0,d1
 movea.l 4(sp),a0
 move.l 16(a0),d0
 jsr _017de(a6)
 movea.l 4(sp),a0
 move.l d0,8(a0)
 lea L0c18c(pc),a0
 move.l a0,d1
 movea.l 4(sp),a0
 move.l 16(a0),d0
 jsr _017d8(a6)
 movea.l d0,a2
 move.l 8(a2),-(sp)
 movea.l 8(sp),a0
 pea 20(a0)
 movea.l 12(sp),a0
 pea 60(a0)
 moveq #0,d1
 movea.l 16(sp),a0
 move.l 8(a0),d0
 jsr _0192e(a6)
 lea 12(sp),sp
 move.l 8(a2),-(sp)
 pea _00f54(a6)
 moveq #12,d1
 movea.l 12(sp),a0
 move.l 8(a0),d0
 bsr.w L08304
 addq.l #8,sp
 lea L0827c(pc),a0
 move.l a0,_012da(a6)
 movea.l 4(sp),a0
 movea.l D00028(a6),a1
 move.l (a0),86(a1)
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #82,d0
 add.l D00028(a6),d0
 move.l d0,d1
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 bsr.w L139e4
 addq.l #8,sp
 pea (L00005).w
 pea (L00001).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 move.l D00028(a6),d0
 bsr.w L13aa2
 addq.l #8,sp
 movea.l 4(sp),a0
 movea.l 8(a0),a0
 move.w 8(a0),d0
 ext.l d0
 movea.l 4(sp),a0
 movea.l 8(a0),a0
 move.w 12(a0),d1
 ext.l d1
 sub.l d0,d1
 bge.s L0be6e
 addq.l #1,d1
L0be6e asr.l #1,d1
 movea.l 4(sp),a0
 movea.l 8(a0),a0
 move.w 8(a0),d0
 ext.l d0
 add.l d0,d1
 move.l d1,-(sp)
 movea.l 8(sp),a0
 movea.l 8(a0),a0
 move.w 6(a0),d0
 ext.l d0
 movea.l 8(sp),a0
 movea.l 8(a0),a0
 move.w 10(a0),d1
 ext.l d1
 sub.l d0,d1
 bge.s L0bea4
 addq.l #1,d1
L0bea4 asr.l #1,d1
 movea.l 8(sp),a0
 movea.l 8(a0),a0
 move.w 6(a0),d0
 ext.l d0
 add.l d0,d1
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _01940(a6)
 addq.l #4,sp
 movea.l 4(sp),a0
 movea.l 8(a0),a0
 move.w 6(a0),d0
 ext.l d0
 movea.l 4(sp),a0
 movea.l 8(a0),a0
 move.w 10(a0),d1
 ext.l d1
 sub.l d0,d1
 bge.s L0bee6
 addq.l #1,d1
L0bee6 asr.l #1,d1
 movea.l 4(sp),a0
 movea.l 8(a0),a0
 add.w 6(a0),d1
 movea.l D00028(a6),a0
 movea.l 4(a0),a0
 movea.l 38(a0),a0
 move.w d1,98(a0)
 movea.l 4(sp),a0
 movea.l 8(a0),a0
 move.w 8(a0),d0
 ext.l d0
 movea.l 4(sp),a0
 movea.l 8(a0),a0
 move.w 12(a0),d1
 ext.l d1
 sub.l d0,d1
 bge.s L0bf26
 addq.l #1,d1
L0bf26 asr.l #1,d1
 movea.l 4(sp),a0
 movea.l 8(a0),a0
 add.w 8(a0),d1
 movea.l D00028(a6),a0
 movea.l 4(a0),a0
 movea.l 38(a0),a0
 move.w d1,100(a0)
 movea.l 4(sp),a0
 movea.l 8(a0),a0
 move.w 6(a0),d0
 ext.l d0
 movea.l 4(sp),a0
 movea.l 8(a0),a0
 move.w 10(a0),d1
 ext.l d1
 sub.l d0,d1
 bge.s L0bf66
 addq.l #1,d1
L0bf66 asr.l #1,d1
 movea.l 4(sp),a0
 movea.l 8(a0),a0
 add.w 6(a0),d1
 movea.l D00028(a6),a0
 movea.l 4(a0),a0
 movea.l 38(a0),a0
 move.w d1,22(a0)
 movea.l 4(sp),a0
 movea.l 8(a0),a0
 move.w 8(a0),d0
 ext.l d0
 movea.l 4(sp),a0
 movea.l 8(a0),a0
 move.w 12(a0),d1
 ext.l d1
 sub.l d0,d1
 bge.s L0bfa6
 addq.l #1,d1
L0bfa6 asr.l #1,d1
 movea.l 4(sp),a0
 movea.l 8(a0),a0
 add.w 8(a0),d1
 movea.l D00028(a6),a0
 movea.l 4(a0),a0
 movea.l 38(a0),a0
 move.w d1,24(a0)
 pea (L00008).w
 pea (L00008).w
 pea (L00001).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 move.l D00028(a6),d0
 jsr _017a8(a6)
 lea 12(sp),sp
 pea (L00003).w
 clr.l -(sp)
 move.l 12(sp),-(sp)
 pea L0bcd8(pc)
 pea (L0003f).w
 moveq #0,d1
 moveq #82,d0
 add.l D00028(a6),d0
 bsr.w L13f56
 lea 20(sp),sp
 movem.l -12(a5),a0-a2
 unlk a5
 rts 
L0c01c link.w a5,#0
 movem.l a0-a4/d0-d1/d4,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 movea.l 40(sp),a4
 move.l 44(sp),d4
 movea.l D00028(a6),a0
 move.l a2,9864(a0)
 movea.l D00028(a6),a0
 move.l a3,9868(a0)
 movea.l D00028(a6),a0
 move.l a4,9876(a0)
 movea.l D00028(a6),a0
 move.l d4,9880(a0)
 movea.l D00028(a6),a0
 move.l a2,9888(a0)
 movea.l D00028(a6),a0
 move.w #384,9898(a0)
 movea.l D00028(a6),a0
 move.w #240,9900(a0)
 movea.l D00028(a6),a0
 move.l a4,9928(a0)
 movea.l D00028(a6),a0
 move.w #252,9938(a0)
 clr.l -(sp)
 clr.l -(sp)
 pea (L00800).w
 pea (a3)
 move.l #5978,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5956,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 pea (L00800).w
 move.l d4,-(sp)
 moveq #0,d1
 move.l #5978,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 pea (a2)
 move.l #5670,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5648,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 pea (a4)
 moveq #0,d1
 move.l #5670,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 movea.l D00028(a6),a0
 pea 5956(a0)
 clr.l -(sp)
 move.l #5648,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01700(a6)
 addq.l #8,sp
 lea L0bd1a(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6396(a1)
 move.l #9864,d0
 add.l D00028(a6),d0
 movea.l D00028(a6),a0
 move.l d0,6400(a0)
 lea L0c194(pc),a0
 move.l a0,d1
 move.l #6188,d0
 add.l D00028(a6),d0
 jsr _0170c(a6)
 moveq #1,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01706(a6)
 movem.l -24(a5),a0-a4/d4
 unlk a5
 rts 
L0c180 moveq #119,d5
 dc.w $7300
L0c184 dc.w $6275
 moveq #116,d2
 ble.s L0c1f8
 dc.w $7300
L0c18c dc.w $6275
 moveq #116,d2
 ble.s L0c200
 dc.w $7300
L0c194 ble.s L0c206
 moveq #0,d2
L0c198 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D00028(a6),a0
 tst.w 9824(a0)
 bne.s L0c1c8
 clr.l -(sp)
 clr.l -(sp)
 pea (L00001).w
 movea.l 16(sp),a0
 move.l 4(a0),d1
 movea.l 16(sp),a0
 move.l (a0),d0
 bsr.w L1401a
 lea 12(sp),sp
L0c1c8 movem.l -4(a5),a0
 unlk a5
 rts 
L0c1d2 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 movea.l 4(sp),a0
 movea.l 36(a0),a0
 pea 4(a0)
 pea (L00080).w
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
L0c1f8 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),-(sp)
L0c200 movea.l D00028(a6),a0
 move.w 12(a0),d0
L0c206 equ *-2
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01a66(a6)
 lea 16(sp),sp
 movea.l 4(sp),a0
 move.l 12(a0),-(sp)
 pea L0e580(pc)
 move.l #94080,-(sp)
 movea.l 16(sp),a0
 move.l 12(a0),-(sp)
 move.l #5670,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5648,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 movea.l 4(sp),a0
 move.l 16(a0),-(sp)
 pea L0e580(pc)
 move.l #94080,-(sp)
 movea.l 16(sp),a0
 move.l 16(a0),-(sp)
 move.l #5692,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5670,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 movea.l 4(sp),a0
 move.l 8(a0),-(sp)
 pea L0e580(pc)
 move.l #94080,-(sp)
 movea.l 16(sp),a0
 move.l 8(a0),-(sp)
 move.l #5648,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5692,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #5648,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01700(a6)
 addq.l #8,sp
 movea.l _01a98(a6),a0
 movea.l D00028(a6),a1
 move.l a0,6396(a1)
 movea.l D00028(a6),a0
 move.l 4(sp),6400(a0)
 lea L0c198(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6404(a1)
 movea.l D00028(a6),a0
 move.l 4(sp),6408(a0)
 lea L0884a(pc),a0
 movea.l 4(sp),a1
 move.l a0,40(a1)
 lea L0c66c(pc),a0
 move.l a0,d1
 move.l #6222,d0
 add.l D00028(a6),d0
 jsr _0170c(a6)
 moveq #1,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01706(a6)
 pea (L0000f).w
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 pea (L0003f).w
 moveq #0,d1
 moveq #82,d0
 add.l D00028(a6),d0
 bsr.w L13f56
 lea 20(sp),sp
 movea.l D00028(a6),a0
 clr.w 9824(a0)
 movea.l D00028(a6),a0
 move.w #1,9826(a0)
 lea L088b8(pc),a0
 movea.l D00028(a6),a1
 move.l a0,9828(a1)
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.l 6780(a0),d1
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _01718(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _0171e(a6)
 lea _00ff0(a6),a0
 movea.l D00028(a6),a1
 movea.l 6780(a1),a1
 move.l a0,26(a1)
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L0c3c2 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 clr.l -(sp)
 clr.l -(sp)
 pea (L00800).w
 movea.l 16(sp),a0
 move.l 36(a0),-(sp)
 moveq #0,d1
 move.l #5956,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 movea.l 4(sp),a0
 move.l 8(a0),-(sp)
 pea L0e580(pc)
 move.l #94080,-(sp)
 movea.l 16(sp),a0
 move.l 8(a0),-(sp)
 move.l #5670,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5648,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 movea.l 16(sp),a0
 move.l 20(a0),-(sp)
 moveq #0,d1
 move.l #5670,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 movea.l D00028(a6),a0
 pea 5956(a0)
 clr.l -(sp)
 move.l #5648,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01700(a6)
 addq.l #8,sp
 lea L0c1d2(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6396(a1)
 movea.l D00028(a6),a0
 move.l 4(sp),6400(a0)
 lea L0c671(pc),a0
 move.l a0,d1
 move.l #6222,d0
 add.l D00028(a6),d0
 jsr _0170c(a6)
 moveq #255,d1
 cmp.l d0,d1
 moveq #1,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01706(a6)
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L0c4ba link.w a5,#0
 movem.l a0/a2-a4/d0-d1,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 movea.l 44(sp),a4
 pea (L0002c).w
 moveq #0,d1
 move.l a4,d0
 jsr _016ac(a6)
 addq.l #4,sp
 moveq #82,d0
 add.l D00028(a6),d0
 move.l d0,(a4)
 moveq #122,d0
 add.l D00028(a6),d0
 move.l d0,4(a4)
 move.l a2,20(a4)
 move.l a3,8(a4)
 move.l 32(sp),12(a4)
 move.l 36(sp),16(a4)
 move.l 40(sp),36(a4)
 lea L088b8(pc),a0
 move.l a0,40(a4)
 movea.l (a4),a0
 clr.l 8(a0)
 movea.l (a4),a0
 move.l a3,4(a0)
 movea.l 4(a4),a0
 move.l a2,4(a0)
 movea.l (a4),a0
 clr.w 18(a0)
 movea.l 4(a4),a0
 clr.w 18(a0)
 bsr.w L14194
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 bsr.w L140a6
 moveq #1,d1
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L0c55c
 moveq #1,d0
 bra.s L0c55e
L0c55c moveq #0,d0
L0c55e lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 bsr.w L140a6
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #0,d1
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 bsr.w L1398c
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 bsr.w L1398c
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 move.l (a4),d1
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 bsr.w L139e4
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 move.l 4(a4),d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 bsr.w L139e4
 addq.l #8,sp
 pea (L00005).w
 pea (L00003).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 move.l D00028(a6),d0
 bsr.w L13aa2
 addq.l #8,sp
 pea (L00001).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 move.l D00028(a6),d0
 bsr.w L13d72
 addq.l #4,sp
 pea (a4)
 pea L0c3c2(pc)
 movea.l D00028(a6),a0
 pea 6222(a0)
 lea L0c678(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 6432(a0),d0
 bsr.w L0c6c6
 lea 12(sp),sp
 movem.l -16(a5),a0/a2-a4
 unlk a5
 rts 
L0c66c moveq #105,d0
 dc.w $6d61
 dc.w $70
L0c671 equ *-1
 dc.w $696d
 dc.w $615f
 dc.w $6900
L0c678 moveq #109,d1
 bsr.s L0c6ec
 dc.w $0
L0c67e link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 subq.l #4,sp
 movea.l 8(sp),a0
 move.l (a0),d1
 movea.l 8(sp),a0
 move.l 12(a0),d0
 jsr _01a12(a6)
 move.l d0,(sp)
 moveq #255,d0
 cmp.l (sp),d0
 movea.l 8(sp),a0
 move.l 8(a0),-(sp)
 movea.l 12(sp),a0
 move.l 4(a0),d1
 move.l 8(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
 addq.l #4,sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L0c6c6 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 move.l (sp),D00034(a6)
 move.l 28(sp),D00038(a6)
 move.l 32(sp),D0003c(a6)
 move.l 24(sp),D00040(a6)
 move.l 4(sp),D00044(a6)
 clr.l -(sp)
L0c6ec clr.l -(sp)
 pea (L02800).w
 move.l 12(sp),-(sp)
 moveq #0,d1
 move.l #5956,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 movea.l D00028(a6),a0
 pea 5956(a0)
 clr.l -(sp)
 moveq #0,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01700(a6)
 addq.l #8,sp
 lea L0c67e(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6396(a1)
 lea D00034(a6),a0
 movea.l D00028(a6),a1
 move.l a0,6400(a1)
 move.l 4(sp),d1
 move.l #6188,d0
 add.l D00028(a6),d0
 jsr _0170c(a6)
 moveq #1,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01706(a6)
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L0c76a link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D00028(a6),a0
 clr.l 6412(a0)
 bsr.w L08238
 movea.l D00028(a6),a0
 tst.l 6396(a0)
 beq.s L0c7bc
 movea.l D00028(a6),a0
 tst.l 6776(a0)
 bne.s L0c7bc
 movea.l D00028(a6),a0
 move.l 6400(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 6396(a0),d1
 move.l 4(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 clr.l 6396(a0)
 movea.l D00028(a6),a0
 clr.l 6400(a0)
L0c7bc movem.l -4(a5),a0
 unlk a5
 rts 
L0c7c6 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D00028(a6),a0
 tst.l 6404(a0)
 beq.s L0c808
 movea.l D00028(a6),a0
 tst.l 6776(a0)
 bne.s L0c808
 movea.l D00028(a6),a0
 move.l 6408(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 6404(a0),d1
 move.l 4(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 clr.l 6404(a0)
 movea.l D00028(a6),a0
L0c808 movem.l -4(a5),a0
 unlk a5
 rts 
L0c812 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D00028(a6),a0
 move.l 6914(a0),d0
 jsr _017f0(a6)
 jsr _01a9c(a6)
 movem.l -4(a5),a0
 unlk a5
 rts 
L0c834 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 jsr _01aa8(a6)
 clr.l -(sp)
 moveq #0,d1
 move.l #-83886080,d0
 jsr _01aa2(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 clr.l 6396(a0)
 movea.l D00028(a6),a0
 move.l #1,6776(a0)
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
L0c86e link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 lea -12(sp),sp
 bsr.w L08238
 clr.l -(sp)
 moveq #0,d1
 moveq #255,d0
 jsr _017c0(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 movea.l D00028(a6),a1
 move.l 162(a0),86(a1)
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L0c8a6
 moveq #1,d0
 bra.s L0c8a8
L0c8a6 moveq #0,d0
L0c8a8 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 move.l D00028(a6),d0
 bsr.w L14106
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #82,d0
 add.l D00028(a6),d0
 move.l d0,d1
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L0c8d6
 moveq #1,d0
 bra.s L0c8d8
L0c8d6 moveq #0,d0
L0c8d8 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 bsr.w L139e4
 addq.l #8,sp
 pea (L00005).w
 pea (L00005).w
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L0c8fe
 moveq #1,d0
 bra.s L0c900
L0c8fe moveq #0,d0
L0c900 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 move.l D00028(a6),d0
 bsr.w L13aa2
 addq.l #8,sp
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L0c922
 moveq #1,d0
 bra.s L0c924
L0c922 moveq #0,d0
L0c924 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 moveq #0,d0
 bsr.w L13e0c
 move.l D00028(a6),-(sp)
 pea (L0003f).w
 moveq #0,d1
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L0c94c
 moveq #1,d0
 bra.s L0c94e
L0c94c moveq #0,d0
L0c94e lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 bsr.w L1398c
 addq.l #8,sp
 pea (L00008).w
 pea (L00001).w
 pea (L00001).w
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L0c978
 moveq #1,d0
 bra.s L0c97a
L0c978 moveq #0,d0
L0c97a lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 move.l D00028(a6),d0
 bsr.w L14140
 lea 12(sp),sp
 move.l D00028(a6),d0
 bsr.w L13af4
L0c998 pea (sp)
 pea 8(sp)
 lea 16(sp),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01880(a6)
 addq.l #8,sp
 moveq #3,d0
 and.l 8(sp),d0
 beq.s L0c998
 jsr _0187a(a6)
 lea 12(sp),sp
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 movea.l D00028(a6),a0
 move.l 162(a0),-(sp)
 moveq #0,d1
 move.l #5648,d0
 add.l D00028(a6),d0
 jsr _016fa(a6)
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #5648,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01700(a6)
 addq.l #8,sp
 lea L0c86e(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6396(a1)
 lea L0ca54(pc),a0
 move.l a0,d1
 move.l #6188,d0
 add.l D00028(a6),d0
 jsr _0170c(a6)
 moveq #1,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 jsr _01706(a6)
 movem.l -12(a5),a0-a1/d1
 unlk a5
 rts 
L0ca54 bgt.s L0cacc
 moveq #0,d1
L0ca58 link.w a5,#0
 movem.l a0/d0-d1/d4,-(sp)
 move.l d0,d4
 lea -54(sp),sp
 move.l D00048(a6),48(sp)
 movea.l D00048(a6),a0
 move.l 20(a0),4(sp)
 move.l d4,d0
 move.l #228,d1
 jsr _016a0(a6)
 move.l #206,d1
 add.l D00048(a6),d1
 add.l d1,d0
 move.l d0,(sp)
 movea.l 48(sp),a0
 move.l 8(a0),12(sp)
 move.w #524,22(sp)
 pea (L000ff).w
 pea (L00040).w
 pea (L0000c).w
 pea (L00034).w
 moveq #80,d1
 moveq #28,d0
 add.l 64(sp),d0
 bsr.w L07580
 lea 16(sp),sp
 clr.b 53(sp)
 move.b #91,52(sp)
 movea.l 48(sp),a0
L0cacc equ *-2
 move.l 16(a0),-(sp)
 movea.l 52(sp),a0
 pea 28(a0)
 pea 16(sp)
 move.l d4,d0
 lsl.l #1,d0
 lea _00fe4(a6),a0
 movea.w (a0,d0.l),a0
 move.l a0,-(sp)
 moveq #82,d1
 lea 68(sp),a0
 move.l a0,d0
 bsr.w L075de
 lea 16(sp),sp
 movea.l 48(sp),a0
 move.w d4,186(a0)
 move.w d4,_00fee(a6)
 movea.l (sp),a0
 tst.w 16(a0)
 beq.s L0cb2e
 movea.l 4(sp),a0
 bset.b #7,(a0)
 movea.l 4(sp),a0
 andi.w #$7fff,122(a0)
 movea.l 4(sp),a0
 andi.w #$7fff,366(a0)
 bra.s L0cb4a
L0cb2e movea.l 4(sp),a0
 bset.b #7,122(a0)
 movea.l 4(sp),a0
 bset.b #7,366(a0)
 movea.l 4(sp),a0
 andi.w #$7fff,(a0)
L0cb4a lea 54(sp),sp
 movem.l -12(a5),a0/d1/d4
 unlk a5
 rts 
 link.w a5,#0
 movem.l a2-a3/d0-d1/d4,-(sp)
 move.l d0,d4
 movea.l d1,a2
 movea.l D00048(a6),a3
 clr.w 906(a3)
 movem.l -12(a5),a2-a3/d4
 unlk a5
 rts 
L0cb76 link.w a5,#0
 movem.l a0/a2-a3/d0-d1,-(sp)
 lea -40(sp),sp
 movea.l D00048(a6),a2
 move.w #228,d0
 muls.w 186(a2),d0
 move.l #206,d1
 add.l a2,d1
 add.l d1,d0
 movea.l d0,a3
 move.l 8(a2),4(sp)
 move.w #524,14(sp)
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _019a6(a6)
 lea L0dc08(pc),a0
 move.l a0,d1
 move.l a3,d0
 jsr _017f6(a6)
 clr.w 16(a3)
 pea (L000d2).w
 moveq #0,d1
 moveq #18,d0
 add.l a3,d0
 jsr _016ac(a6)
 addq.l #4,sp
 pea (L000ff).w
 pea (L00010).w
 pea (L000d2).w
 move.w 186(a2),d0
 ext.l d0
 lsl.l #1,d0
 lea _00fe4(a6),a0
 movea.w (a0,d0.l),a0
 move.l a0,-(sp)
 moveq #94,d1
 moveq #28,d0
 add.l a2,d0
 bsr.w L07580
 lea 16(sp),sp
 move.l 16(a2),-(sp)
 pea 28(a2)
 pea 8(sp)
 move.w 186(a2),d0
 ext.l d0
 lsl.l #1,d0
 lea _00fe4(a6),a0
 movea.w (a0,d0.l),a0
 move.l a0,-(sp)
 moveq #94,d1
 lea L0dc0e(pc),a0
 move.l a0,d0
 bsr.w L075de
 lea 16(sp),sp
 pea 188(a2)
 move.l a3,d1
 movea.w 186(a2),a0
 move.l a0,d0
 bsr.w L0ebb4
 addq.l #4,sp
 pea (L000ff).w
 pea (L00010).w
 pea (L000d2).w
 move.w 186(a2),d0
 ext.l d0
 lsl.l #1,d0
 lea _00fe4(a6),a0
 movea.w (a0,d0.l),a0
 move.l a0,-(sp)
 moveq #94,d1
 moveq #28,d0
 add.l a2,d0
 bsr.w L07580
 lea 16(sp),sp
 movea.w 186(a2),a0
 move.l a0,d0
 bsr.w L0ca58
 move.l 16(a2),-(sp)
 pea 28(a2)
 pea 8(sp)
 move.w 186(a2),d0
 ext.l d0
 lsl.l #1,d0
 lea _00fe4(a6),a0
 movea.w (a0,d0.l),a0
 move.l a0,-(sp)
 moveq #94,d1
 move.l a3,d0
 bsr.w L075de
 lea 16(sp),sp
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _0171e(a6)
 pea (L00002).w
 move.l 898(a2),-(sp)
 move.l 890(a2),d1
 moveq #0,d0
 bsr.w L07750
 addq.l #8,sp
 clr.w 906(a2)
 lea 40(sp),sp
 movem.l -16(a5),a0/a2-a3/d1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a2-a3/d0-d1/d4,-(sp)
 move.l d0,d4
 movea.l d1,a2
 movea.l D00048(a6),a3
 move.w #1,906(a3)
 clr.w 908(a3)
 movem.l -12(a5),a2-a3/d4
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l 4(sp),a0
 move.l (a0),d0
 bsr.w L0ca58
 pea (L00002).w
 movea.l D00048(a6),a0
 move.l 898(a0),-(sp)
 movea.l D00048(a6),a0
 move.l 890(a0),d1
 moveq #0,d0
 bsr.w L07750
 addq.l #8,sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L0cd2c link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 clr.w D00054(a6)
 cmpi.w #2,_00fec(a6)
 beq.s L0cd5e
 move.w #1,_00fec(a6)
 move.l 4(sp),-(sp)
 lea L0cd2c(pc),a0
 move.l a0,d1
 move.l 4(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
 bra.w L0cdf2
L0cd5e clr.l -(sp)
 movea.l D00028(a6),a0
 move.l 178(a0),-(sp)
 movea.l _01948(a6),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 movea.l 178(a0),a0
 move.l 48(a0),d0
 jsr _0193a(a6)
 addq.l #8,sp
 pea (L0001e).w
 movea.l D00028(a6),a0
 move.l 6780(a0),d1
 movea.l D00048(a6),a0
 move.l 24(a0),d0
 jsr _01928(a6)
 addq.l #4,sp
 pea (L0007a).w
 movea.l D00028(a6),a0
 move.l 6780(a0),d1
 movea.l D00048(a6),a0
 move.l 20(a0),d0
 jsr _01928(a6)
 addq.l #4,sp
 bsr.w L08238
 clr.l -(sp)
 moveq #0,d1
 moveq #255,d0
 jsr _017c0(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 movea.l 6780(a0),a0
 clr.l 26(a0)
 pea (L00003).w
 pea (L00002).w
 move.l 12(sp),-(sp)
 move.l 12(sp),-(sp)
 clr.l -(sp)
 moveq #63,d1
 moveq #82,d0
 add.l D00028(a6),d0
 bsr.w L13f56
 lea 20(sp),sp
L0cdf2 movem.l -4(a5),a0
 unlk a5
 rts 
L0cdfc link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 pea (L00001).w
 clr.l -(sp)
 pea (L00001).w
 pea L08952(pc)
 movea.l D00028(a6),a0
 move.l 4038(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 162(a0),d1
 lea L0dc17(pc),a0
 move.l a0,d0
 bsr.w L10b50
 lea 20(sp),sp
 movem.l -4(a5),a0
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 tst.w D00054(a6)
 beq.s L0ce76
 move.w #1,_00fec(a6)
 moveq #0,d1
 lea L0cdfc(pc),a0
 move.l a0,d0
 bsr.w L0cd2c
 pea (L00002).w
 movea.l D00048(a6),a0
 move.l 898(a0),-(sp)
 movea.l D00048(a6),a0
 move.l 890(a0),d1
 moveq #0,d0
 bsr.w L07750
 addq.l #8,sp
L0ce76 movem.l -4(a5),a0
 unlk a5
 rts 
L0ce80 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 pea (L00001).w
 pea (L00034).w
 clr.l -(sp)
 pea L08c04(pc)
 movea.l D00028(a6),a0
 move.l 4038(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 162(a0),d1
 lea L0dc1b(pc),a0
 move.l a0,d0
 bsr.w L10b50
 lea 20(sp),sp
 movem.l -4(a5),a0
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 tst.w D00054(a6)
 beq.s L0cefa
 pea (L00002).w
 movea.l D00048(a6),a0
 move.l 898(a0),-(sp)
 movea.l D00048(a6),a0
 move.l 890(a0),d1
 moveq #0,d0
 bsr.w L07750
 addq.l #8,sp
 move.w #1,_00fec(a6)
 moveq #0,d1
 lea L0ce80(pc),a0
 move.l a0,d0
 bsr.w L0cd2c
L0cefa movem.l -4(a5),a0
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 tst.w D00054(a6)
 beq.s L0cf42
 move.w #1,_00fec(a6)
 move.l D00048(a6),d1
 lea L06b94(pc),a0
 move.l a0,d0
 bsr.w L0cd2c
 pea (L00002).w
 movea.l D00048(a6),a0
 move.l 898(a0),-(sp)
 movea.l D00048(a6),a0
 move.l 890(a0),d1
 moveq #0,d0
 bsr.w L07750
 addq.l #8,sp
L0cf42 movem.l -4(a5),a0
 unlk a5
 rts 
L0cf4c link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D00028(a6),a0
 clr.w 5622(a0)
 movea.l D00028(a6),a0
 clr.w 5620(a0)
 lea L0dc20(pc),a0
 move.l a0,d1
 move.l (sp),d0
 jsr _01aae(a6)
 tst.l d0
 bne.s L0cf7e
 movea.l D00028(a6),a0
 bset.b #1,5623(a0)
L0cf7e lea L0dc28(pc),a0
 move.l a0,d1
 move.l (sp),d0
 jsr _01aae(a6)
 tst.l d0
 bne.s L0cf98
 movea.l D00028(a6),a0
 bset.b #0,5623(a0)
L0cf98 lea L0dc33(pc),a0
 move.l a0,d1
 move.l (sp),d0
 jsr _01aae(a6)
 tst.l d0
 bne.s L0cfb2
 movea.l D00028(a6),a0
 move.w #3,5622(a0)
L0cfb2 lea L0dc3f(pc),a0
 move.l a0,d1
 move.l (sp),d0
 jsr _01aae(a6)
 tst.l d0
 bne.s L0cfcc
 movea.l D00028(a6),a0
 move.w #1,5620(a0)
L0cfcc movem.l -8(a5),a0/d1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 subq.l #4,sp
 tst.w D00054(a6)
 beq.w L0d08a
 movea.l D00048(a6),a0
 movea.l D00028(a6),a1
 move.w 186(a0),5114(a1)
 bsr.w L0eba8
 movea.l D00048(a6),a0
 move.w #228,d0
 muls.w 186(a0),d0
 move.l #206,d1
 add.l D00048(a6),d1
 add.l d1,d0
 move.l d0,(sp)
 movea.l D00048(a6),a0
 move.w #228,d0
 muls.w 186(a0),d0
 move.l #206,d1
 add.l D00048(a6),d1
 add.l d1,d0
 bsr.w L0ef52
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 move.w 316(a0),d0
 ext.l d0
 lsl.l #2,d0
 lea _00c8a(a6),a0
 move.l (a0,d0.l),d1
 move.l #4856,d0
 add.l D00028(a6),d0
 jsr _017f6(a6)
 move.w #1,_00fec(a6)
 move.l (sp),d0
 bsr.w L0cf4c
 moveq #0,d1
 lea L089d4(pc),a0
 move.l a0,d0
 bsr.w L0cd2c
 pea (L00002).w
 movea.l D00048(a6),a0
 move.l 898(a0),-(sp)
 movea.l D00048(a6),a0
 move.l 890(a0),d1
 moveq #0,d0
 bsr.w L07750
 addq.l #8,sp
L0d08a addq.l #4,sp
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L0d096 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.w #2,_00fec(a6)
 movea.l D00028(a6),a0
 move.w #1,5012(a0)
 moveq #0,d1
 lea L089d4(pc),a0
 move.l a0,d0
 bsr.w L0cd2c
 movem.l -4(a5),a0
 unlk a5
 rts 
L0d0c4 link.w a5,#0
 movem.l a0/a2/d0-d1,-(sp)
 lea -12(sp),sp
 movea.l D00048(a6),a2
 tst.w _00fec(a6)
 beq.s L0d0e4
 move.w #2,_00fec(a6)
 bra.w L0d18a
L0d0e4 tst.w 906(a2)
 bne.s L0d13c
 pea (sp)
 pea 8(sp)
 lea 16(sp),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01880(a6)
 addq.l #8,sp
 move.l 4(sp),d0
 cmp.l D0004c(a6),d0
 bne.s L0d12c
 move.l (sp),d0
 cmp.l D00050(a6),d0
 bne.s L0d12c
 addq.w #1,_00fea(a6)
 cmpi.w #300,_00fea(a6)
 ble.s L0d130
 bsr.w L0d096
 clr.w _00fea(a6)
 bra.s L0d18a
L0d12c clr.w _00fea(a6)
L0d130 move.l 4(sp),D0004c(a6)
 move.l (sp),D00050(a6)
 bra.s L0d178
L0d13c addq.w #1,908(a2)
 cmpi.w #30,908(a2)
 ble.s L0d14c
 bsr.w L0cb76
L0d14c move.w 908(a2),d0
 ext.l d0
 divs.w #10,d0
 swap d0
 tst.w d0
 bne.s L0d178
 pea (L00002).w
 movea.l D00048(a6),a0
 move.l 898(a0),-(sp)
 movea.l D00048(a6),a0
 move.l 890(a0),d1
 moveq #0,d0
 bsr.w L07750
 addq.l #8,sp
L0d178 moveq #10,d1
 movea.l D00028(a6),a0
 movea.l 178(a0),a0
 move.l 48(a0),d0
 jsr _0191c(a6)
L0d18a lea 12(sp),sp
 movem.l -8(a5),a0/a2
 unlk a5
 rts 
L0d198 link.w a5,#0
 movem.l a0-a2/d0-d1,-(sp)
 subq.l #4,sp
 movea.l D00028(a6),a0
 movea.l 178(a0),a2
 clr.w _00fea(a6)
 clr.w _00fec(a6)
 pea D00050(a6)
 pea D0004c(a6)
 lea 8(sp),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01880(a6)
 addq.l #8,sp
 clr.l -(sp)
 clr.l -(sp)
 lea L0d0c4(pc),a0
 move.l a0,d1
 move.l 48(a2),d0
 jsr _0193a(a6)
 addq.l #8,sp
 lea _00fda(a6),a0
 movea.l D00028(a6),a1
 movea.l 6780(a1),a1
 move.l a0,26(a1)
 pea (L0007a).w
 movea.l D00028(a6),a0
 move.l 6780(a0),d1
 movea.l 12(sp),a0
 move.l 20(a0),d0
 jsr _01934(a6)
 addq.l #4,sp
 pea (L0001e).w
 movea.l D00028(a6),a0
 move.l 6780(a0),d1
 movea.l 12(sp),a0
 move.l 24(a0),d0
 jsr _01934(a6)
 addq.l #4,sp
 bsr.w L081f6
 clr.l -(sp)
 lea L0d0c4(pc),a0
 move.l a0,d1
 move.l 8(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
 move.w #1,D00054(a6)
 addq.l #4,sp
 movem.l -12(a5),a0-a2
 unlk a5
 rts 
L0d24e link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 lea -40(sp),sp
 movea.l 40(sp),a0
 move.l 8(a0),4(sp)
 move.w #524,14(sp)
 movea.l 40(sp),a0
 pea 206(a0)
 movea.l 44(sp),a0
 pea 188(a0)
 movea.l 48(sp),a0
 pea 170(a0)
 move.l #154,d0
 add.l 52(sp),d0
 move.l d0,d1
 move.l #138,d0
 add.l 52(sp),d0
 bsr.w L0ec78
 lea 12(sp),sp
 movea.l 40(sp),a0
 move.l 16(a0),-(sp)
 movea.l 44(sp),a0
 pea 28(a0)
 pea 8(sp)
 pea (L00034).w
 moveq #94,d1
 move.l #138,d0
 add.l 56(sp),d0
 bsr.w L075de
 lea 16(sp),sp
 movea.l 40(sp),a0
 move.l 16(a0),-(sp)
 movea.l 44(sp),a0
 pea 28(a0)
 pea 8(sp)
 pea (L0004a).w
 moveq #94,d1
 move.l #154,d0
 add.l 56(sp),d0
 bsr.w L075de
 lea 16(sp),sp
 movea.l 40(sp),a0
 move.l 16(a0),-(sp)
 movea.l 44(sp),a0
 pea 28(a0)
 pea 8(sp)
 pea (L00060).w
 moveq #94,d1
 move.l #170,d0
 add.l 56(sp),d0
 bsr.w L075de
 lea 16(sp),sp
 lea 40(sp),sp
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
L0d332 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 subq.l #4,sp
 movea.l D00048(a6),a0
 move.l 20(a0),(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 moveq #0,d0
 bsr.w L13e0c
 bsr.w L14194
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 bsr.w L140a6
 moveq #1,d1
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L0d38c
 moveq #1,d0
 bra.s L0d38e
L0d38c moveq #0,d0
L0d38e lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 bsr.w L140a6
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #0,d1
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 bsr.w L1398c
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 bsr.w L1398c
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #82,d0
 add.l D00028(a6),d0
 move.l d0,d1
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 bsr.w L139e4
 addq.l #8,sp
 pea (L00005).w
 pea (L00001).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 move.l D00028(a6),d0
 bsr.w L13aa2
 addq.l #8,sp
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 move.l D00028(a6),d0
 bsr.w L13d72
 addq.l #4,sp
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 moveq #0,d0
 bsr.w L13e0c
 pea (L00800).w
 moveq #0,d1
 movea.l D00028(a6),a0
 move.l 6908(a0),d0
 jsr _016ac(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 clr.w 5006(a0)
 movea.l (sp),a0
 move.w 374(a0),d0
 ext.l d0
 movea.l (sp),a0
 move.w 378(a0),d1
 ext.l d1
 sub.l d0,d1
 bge.s L0d49a
 addq.l #1,d1
L0d49a asr.l #1,d1
 movea.l (sp),a0
 move.w 374(a0),d0
 ext.l d0
 add.l d0,d1
 move.l d1,-(sp)
 movea.l 4(sp),a0
 move.w 372(a0),d0
 ext.l d0
 movea.l 4(sp),a0
 move.w 376(a0),d1
 ext.l d1
 sub.l d0,d1
 bge.s L0d4c2
 addq.l #1,d1
L0d4c2 asr.l #1,d1
 movea.l 4(sp),a0
 move.w 372(a0),d0
 ext.l d0
 add.l d0,d1
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _01940(a6)
 addq.l #4,sp
 movea.l (sp),a0
 move.w 372(a0),d0
 ext.l d0
 movea.l (sp),a0
 move.w 376(a0),d1
 ext.l d1
 sub.l d0,d1
 bge.s L0d4f4
 addq.l #1,d1
L0d4f4 asr.l #1,d1
 movea.l (sp),a0
 add.w 372(a0),d1
 movea.l D00028(a6),a0
 movea.l 4(a0),a0
 movea.l 38(a0),a0
 move.w d1,98(a0)
 movea.l (sp),a0
 move.w 374(a0),d0
 ext.l d0
 movea.l (sp),a0
 move.w 378(a0),d1
 ext.l d1
 sub.l d0,d1
 bge.s L0d522
 addq.l #1,d1
L0d522 asr.l #1,d1
 movea.l (sp),a0
 add.w 374(a0),d1
 movea.l D00028(a6),a0
 movea.l 4(a0),a0
 movea.l 38(a0),a0
 move.w d1,100(a0)
 movea.l (sp),a0
 move.w 372(a0),d0
 ext.l d0
 movea.l (sp),a0
 move.w 376(a0),d1
 ext.l d1
 sub.l d0,d1
 bge.s L0d550
 addq.l #1,d1
L0d550 asr.l #1,d1
 movea.l (sp),a0
 add.w 372(a0),d1
 movea.l D00028(a6),a0
 movea.l 4(a0),a0
 movea.l 38(a0),a0
 move.w d1,22(a0)
 movea.l (sp),a0
 move.w 374(a0),d0
 ext.l d0
 movea.l (sp),a0
 move.w 378(a0),d1
 ext.l d1
 sub.l d0,d1
 bge.s L0d57e
 addq.l #1,d1
L0d57e asr.l #1,d1
 movea.l (sp),a0
 add.w 374(a0),d1
 movea.l D00028(a6),a0
 movea.l 4(a0),a0
 movea.l 38(a0),a0
 move.w d1,24(a0)
 pea (L00003).w
 clr.l -(sp)
 move.l 16(sp),-(sp)
 pea L0d198(pc)
 pea (L0003f).w
 moveq #0,d1
 moveq #82,d0
 add.l D00028(a6),d0
 bsr.w L13f56
 lea 20(sp),sp
 addq.l #4,sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L0d5c4 link.w a5,#0
 movem.l a0/a2-a3/d0-d1,-(sp)
 moveq #82,d0
 add.l D00028(a6),d0
 movea.l d0,a3
 movea.l 4(sp),a0
 move.l 32(a0),4(a3)
 move.l 4(sp),D00048(a6)
 movea.l D00028(a6),a0
 clr.w 5012(a0)
 movea.l 4(sp),a0
 movea.l (a0),a0
 pea 4(a0)
 pea (L00100).w
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01a66(a6)
 lea 16(sp),sp
 movea.l 4(sp),a0
 move.l 12(a0),d0
 jsr _017e4(a6)
 lea L0dc4b(pc),a0
 move.l a0,d1
 movea.l 4(sp),a0
 move.l 12(a0),d0
 jsr _017de(a6)
 movea.l 4(sp),a0
 move.l d0,20(a0)
 lea L0dc4f(pc),a0
 move.l a0,d1
 movea.l 4(sp),a0
 move.l 12(a0),d0
 jsr _017d8(a6)
 movea.l d0,a2
 move.l 8(a2),-(sp)
 movea.l 8(sp),a0
 pea 28(a0)
 movea.l 12(sp),a0
 pea 68(a0)
 moveq #0,d1
 movea.l 16(sp),a0
 move.l 20(a0),d0
 jsr _0192e(a6)
 lea 12(sp),sp
 move.l 8(a2),-(sp)
 pea _00f6c(a6)
 moveq #12,d1
 movea.l 12(sp),a0
 move.l 20(a0),d0
 bsr.w L08304
 addq.l #8,sp
 move.l 8(a2),-(sp)
 pea _00f94(a6)
 move.l #304,d1
 movea.l 12(sp),a0
 move.l 20(a0),d0
 bsr.w L08304
 addq.l #8,sp
 lea L0827c(pc),a0
 move.l a0,_012da(a6)
 lea L0dc53(pc),a0
 move.l a0,d1
 movea.l 4(sp),a0
 move.l 12(a0),d0
 jsr _017de(a6)
 movea.l 4(sp),a0
 move.l d0,24(a0)
 lea L0dc59(pc),a0
 move.l a0,d1
 movea.l 4(sp),a0
 move.l 12(a0),d0
 jsr _017d8(a6)
 movea.l d0,a2
 move.l 8(a2),-(sp)
 lea _00fbc(a6),a0
 move.l a0,d1
 movea.l 8(sp),a0
 move.l 24(a0),d0
 jsr _01a6c(a6)
 addq.l #4,sp
 lea L0dc5f(pc),a0
 move.l a0,d1
 movea.l 4(sp),a0
 move.l 12(a0),d0
 jsr _017de(a6)
 movea.l 4(sp),a0
 move.l d0,16(a0)
 movea.l 4(sp),a0
 move.l 894(a0),d0
 jsr _017e4(a6)
 lea L0dc64(pc),a0
 move.l a0,d1
 movea.l 4(sp),a0
 move.l 894(a0),d0
 jsr _017de(a6)
 movea.l 4(sp),a0
 move.l d0,898(a0)
 move.l 4(sp),d0
 bsr.w L0d24e
 cmpi.w #-1,_00fee(a6)
 beq.s L0d772
 movea.l 4(sp),a0
 move.w _00fee(a6),186(a0)
 bra.s L0d77e
L0d772 movea.l 4(sp),a0
 clr.w 186(a0)
 clr.w _00fee(a6)
L0d77e movea.l 4(sp),a0
 movea.w 186(a0),a0
 move.l a0,d0
 bsr.w L0ca58
 pea (L00006).w
 pea (L00002).w
 move.l 12(sp),-(sp)
 pea L0d332(pc)
 clr.l -(sp)
 moveq #63,d1
 moveq #122,d0
 add.l D00028(a6),d0
 bsr.w L13f56
 lea 20(sp),sp
 movem.l -12(a5),a0/a2-a3
 unlk a5
 rts 
L0d7b8 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 clr.l -(sp)
 clr.l -(sp)
 pea (L00800).w
 movea.l 16(sp),a0
 move.l (a0),-(sp)
 move.l #5978,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5956,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 pea (L00800).w
 movea.l 16(sp),a0
 move.l 12(a0),-(sp)
 move.l #6000,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5978,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 pea (L00800).w
 movea.l 16(sp),a0
 move.l 894(a0),-(sp)
 moveq #0,d1
 move.l #6000,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 movea.l 16(sp),a0
 move.l 890(a0),-(sp)
 moveq #0,d1
 move.l #5780,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 movea.l 16(sp),a0
 move.l 32(a0),-(sp)
 move.l #5670,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5648,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 movea.l 16(sp),a0
 move.l 4(a0),-(sp)
 move.l #5692,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5670,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 movea.l 16(sp),a0
 move.l 8(a0),-(sp)
 moveq #0,d1
 move.l #5692,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 movea.l D00028(a6),a0
 pea 5956(a0)
 movea.l D00028(a6),a0
 pea 5780(a0)
 move.l #5648,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 bsr.w L14c64
 addq.l #8,sp
 lea L0d5c4(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6396(a1)
 movea.l D00028(a6),a0
 move.l D00048(a6),6400(a0)
 lea L0dc6c(pc),a0
 move.l a0,d1
 move.l #6188,d0
 add.l D00028(a6),d0
 jsr _0170c(a6)
 moveq #1,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 bsr.w L14aa8
 moveq #0,d0
 jsr _01712(a6)
 moveq #1,d0
 jsr _01712(a6)
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L0d966 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 movea.l 4(sp),a0
 movea.l D00028(a6),a1
 move.l 902(a0),126(a1)
 bsr.w L14194
 movea.l D00028(a6),a0
 move.w #478,80(a0)
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 bsr.w L140a6
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 bsr.w L1398c
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #122,d0
 add.l D00028(a6),d0
 move.l d0,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 bsr.w L139e4
 addq.l #8,sp
 pea (L00005).w
 pea (L00005).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 move.l D00028(a6),d0
 bsr.w L13aa2
 addq.l #8,sp
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 moveq #1,d0
 bsr.w L13e0c
 pea (L00008).w
 pea (L00008).w
 pea (L00001).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 move.l D00028(a6),d0
 bsr.w L14140
 lea 12(sp),sp
 pea (L00006).w
 clr.l -(sp)
 move.l 12(sp),-(sp)
 pea L0d7b8(pc)
 pea (L0003f).w
 moveq #0,d1
 moveq #122,d0
 add.l D00028(a6),d0
 bsr.w L13f56
 lea 20(sp),sp
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L0da86 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 movea.l 16(sp),a0
 move.l 902(a0),-(sp)
 moveq #0,d1
 move.l #5648,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #5648,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 bsr.w L14c64
 addq.l #8,sp
 lea L0d966(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6396(a1)
 movea.l D00028(a6),a0
 move.l D00048(a6),6400(a0)
 lea L0dc70(pc),a0
 move.l a0,d1
 move.l #6188,d0
 add.l D00028(a6),d0
 jsr _0170c(a6)
 moveq #1,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 bsr.w L14aa8
 moveq #0,d0
 jsr _01712(a6)
 moveq #1,d0
 jsr _01712(a6)
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L0db24 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l 40(sp),D00048(a6)
 pea (L0038e).w
 moveq #0,d1
 move.l D00048(a6),d0
 jsr _016ac(a6)
 addq.l #4,sp
 movea.l D00048(a6),a0
 move.l 4(sp),(a0)
 movea.l D00048(a6),a0
 move.l 20(sp),4(a0)
 movea.l D00048(a6),a0
 move.l 24(sp),8(a0)
 movea.l D00048(a6),a0
 move.l 28(sp),12(a0)
 movea.l D00048(a6),a0
 move.l (sp),32(a0)
 movea.l D00048(a6),a0
 move.w #384,42(a0)
 movea.l D00048(a6),a0
 move.w #240,44(a0)
 movea.l D00048(a6),a0
 move.l 32(sp),890(a0)
 movea.l D00048(a6),a0
 move.l 36(sp),894(a0)
 movea.l D00048(a6),a0
 move.l 44(sp),902(a0)
 movea.l D00048(a6),a0
 move.l 20(sp),72(a0)
 movea.l D00048(a6),a0
 move.w #100,82(a0)
 andi.w #$feff,_011ba(a6)
 tst.w 50(sp)
 beq.s L0dbd8
 move.l D00048(a6),-(sp)
 pea L0da86(pc)
 movea.l D00028(a6),a0
 pea 6222(a0)
 lea L0dc74(pc),a0
 bra.s L0dbec
L0dbd8 move.l D00048(a6),-(sp)
 pea L0d7b8(pc)
 movea.l D00028(a6),a0
 pea 6222(a0)
 lea L0dc79(pc),a0
L0dbec move.l a0,d1
 movea.l D00028(a6),a0
 move.l 6432(a0),d0
 bsr.w L0c6c6
 lea 12(sp),sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L0dc08 dc.w $454d
 addq.w #8,(a4)
 subq.b #4,d0
L0dc0e neg.w d5
 dc.w $4c45
 addq.w #2,a1
 tcall #7,#104
L0dc17 equ *-1
 dc.w $6f77
 ori.w #$7265,-(a3)
L0dc1b equ *-3
 dc.w $6400
L0dc20 addq.w #4,(a1)+
 addq.w #5,a6
 dc.w $4f47
 dc.w $4f00
L0dc28 addq.w #4,(a1)+
 addq.w #5,a1
 link.w a6,#18766
 dc.w $434f
 ori.w #$594e,(a0)+
L0dc33 equ *-3
 dc.w $4f47
 dc.w $4f58
 subq.w #4,a1
 link.w a6,#77
L0dc3f equ *-1
 addq.w #3,d2
 dc.w $4152
 dc.w $4943
 dc.w $4b4d
 dc.w $414e
 ori.w #$6873,-(a3)
L0dc4b equ *-3
 ori.w #$6873,-(a3)
L0dc4f equ *-3
 ori.w #$616d,_0e573(a6)
L0dc53 equ *-5
 ori.w #$616d,_0e573(a6)
L0dc59 equ *-5
 ori.w #$6f6e,-(a6)
L0dc5f equ *-3
 moveq #0,d2
L0dc64 ble.s L0dccc
 dc.w $6673
 bcs.s L0dcde
 dc.w $7300
L0dc6c moveq #108,d0
 dc.w $7300
L0dc70 moveq #119,d5
 dc.w $7300
L0dc74 moveq #109,d1
 bsr.s L0dce8
 ori.w #$6d61,(a2,d7.w)
L0dc79 equ *-5
L0dc7e link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 moveq #1,d0
 bsr.w L13dbc
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 moveq #0,d0
 bsr.w L13e0c
 movea.l D00028(a6),a0
 move.l 9832(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 9828(a0),d1
 move.l 4(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L0dcca link.w a5,#0
L0dccc equ *-2
 movem.l a0/a2-a3/d0-d1,-(sp)
 moveq #82,d0
 add.l D00028(a6),d0
 movea.l d0,a2
 moveq #122,d0
 add.l D00028(a6),d0
L0dcde equ *-2
 movea.l d0,a3
 bsr.w L0c834
 movea.l D00028(a6),a0
L0dce8 equ *-2
 clr.w 9826(a0)
 movea.l D00028(a6),a0
 clr.w 9824(a0)
 clr.l -(sp)
 moveq #0,d1
 moveq #255,d0
 jsr _017c0(a6)
 addq.l #4,sp
 tst.w 18(a3)
 beq.s L0dd28
 pea (L00003).w
 pea (L00002).w
 clr.l -(sp)
 pea L0dc7e(pc)
 clr.l -(sp)
 movea.w 18(a3),a0
 move.l a0,d1
 move.l a3,d0
 bsr.w L13f56
 lea 20(sp),sp
L0dd28 tst.w 18(a2)
 beq.s L0dd4e
 pea (L00003).w
 pea (L00002).w
 clr.l -(sp)
 pea L0dc7e(pc)
 clr.l -(sp)
 movea.w 18(a2),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L13f56
 lea 20(sp),sp
L0dd4e movem.l -12(a5),a0/a2-a3
 unlk a5
 rts 
L0dd58 link.w a5,#0
 movem.l a0-a4/d0-d1,-(sp)
 moveq #82,d0
 add.l D00028(a6),d0
 movea.l d0,a2
 moveq #122,d0
 add.l D00028(a6),d0
 movea.l d0,a3
 movea.l D00028(a6),a0
 movea.l 76(a0),a4
 bsr.w L08238
 movea.l D00028(a6),a0
 movea.l 6780(a0),a0
 clr.l 26(a0)
 movea.l D00028(a6),a0
 tst.w 9824(a0)
 bne.s L0ddfc
 movea.l D00028(a6),a0
 tst.w 9826(a0)
 bne.s L0ddbc
 movea.l D00028(a6),a0
 move.w #1,9824(a0)
 move.l 4(sp),-(sp)
 lea L0dd58(pc),a0
 move.l a0,d1
 move.l 4(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
 bra.s L0ddfc
L0ddbc movea.l D00028(a6),a0
 tst.w 60(a0)
 beq.s L0ddf4
 tst.l 36(a2)
 beq.s L0ddd6
 move.l 36(a2),d1
 move.l (a2),d0
 bsr.w L1326a
L0ddd6 tst.l 36(a3)
 beq.s L0dde6
 move.l 36(a3),d1
 move.l (a3),d0
 bsr.w L1326a
L0dde6 lea L0dcca(pc),a0
 movea.l D00028(a6),a1
 move.l a0,72(a1)
 bra.s L0ddfc
L0ddf4 moveq #0,d1
 moveq #0,d0
 bsr.w L0dcca
L0ddfc movem.l -20(a5),a0-a4
 unlk a5
 rts 
L0de06 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 moveq #0,d0
 bsr.w L13e0c
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 move.l D00028(a6),d0
 bsr.w L13d72
 addq.l #4,sp
 pea (L00001).w
 clr.l -(sp)
 pea (L00001).w
 pea L08952(pc)
 movea.l D00028(a6),a0
 move.l 4038(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 162(a0),d1
 lea L0eb94(pc),a0
 move.l a0,d0
 bsr.w L10b50
 lea 20(sp),sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L0de7e link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 pea (L00001).w
 pea (L00002).w
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 moveq #63,d1
 moveq #82,d0
 add.l D00028(a6),d0
 bsr.w L13f56
 lea 20(sp),sp
 pea (L00001).w
 pea (L00002).w
 movea.l D00058(a6),a0
 move.l 4(a0),-(sp)
 movea.l D00058(a6),a0
 move.l (a0),-(sp)
 clr.l -(sp)
 moveq #63,d1
 moveq #122,d0
 add.l D00028(a6),d0
 bsr.w L13f56
 lea 20(sp),sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L0ded6 link.w a5,#0
 movem.l d0-d1,-(sp)
 move.l D00028(a6),d0
 bsr.w L13af4
 unlk a5
 rts 
L0deea link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.l 6780(a0),d1
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _01718(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _0171e(a6)
 lea _00ff0(a6),a0
 movea.l D00028(a6),a1
 movea.l 6780(a1),a1
 move.l a0,26(a1)
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L0df30 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 movea.l D00058(a6),a0
 movea.l 20(a0),a0
 pea 4(a0)
 pea (L00080).w
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01a66(a6)
 lea 16(sp),sp
 movea.l D00058(a6),a0
 move.l 12(a0),-(sp)
 pea L0e580(pc)
 move.l #94080,-(sp)
 movea.l D00058(a6),a0
 move.l 12(a0),-(sp)
 move.l #5670,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5648,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 movea.l D00058(a6),a0
 move.l 16(a0),-(sp)
 pea L0e580(pc)
 move.l #94080,-(sp)
 movea.l D00058(a6),a0
 move.l 16(a0),-(sp)
 move.l #5692,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5670,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 movea.l D00058(a6),a0
 move.l 8(a0),-(sp)
 pea L0e580(pc)
 move.l #94080,-(sp)
 movea.l D00058(a6),a0
 move.l 8(a0),-(sp)
 move.l #5648,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5692,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 movea.l D00058(a6),a0
 movea.l D00028(a6),a1
 move.l 38(a0),6404(a1)
 movea.l D00058(a6),a0
 movea.l D00028(a6),a1
 move.l 42(a0),6408(a1)
 lea L0de7e(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6396(a1)
 movea.l D00058(a6),a0
 movea.l D00028(a6),a1
 move.l 4(a0),6400(a1)
 andi.w #$feff,_011ba(a6)
 movea.l D00058(a6),a0
 move.l 34(a0),d1
 move.l #6222,d0
 add.l D00028(a6),d0
 bsr.w L15c48
 moveq #1,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 bsr.w L14aa8
 moveq #0,d0
 jsr _01712(a6)
 moveq #1,d0
 jsr _01712(a6)
 pea (L00001).w
 clr.l -(sp)
 clr.l -(sp)
 pea L0deea(pc)
 pea (L0003f).w
 moveq #0,d1
 moveq #82,d0
 add.l D00028(a6),d0
 bsr.w L13f56
 lea 20(sp),sp
 pea (L00001).w
 clr.l -(sp)
 clr.l -(sp)
 pea L0deea(pc)
 pea (L0003f).w
 moveq #0,d1
 moveq #122,d0
 add.l D00028(a6),d0
 bsr.w L13f56
 lea 20(sp),sp
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L0e0e2 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 lea -44(sp),sp
 moveq #82,d0
 add.l D00028(a6),d0
 move.l d0,36(sp)
 moveq #122,d0
 add.l D00028(a6),d0
 move.l d0,32(sp)
 move.l 44(sp),d1
 lea (sp),a0
 move.l a0,d0
 jsr _017f6(a6)
 lea L0eb98(pc),a0
 move.l a0,d1
 lea (sp),a0
 move.l a0,d0
 jsr _01a72(a6)
 pea (L0002e).w
 moveq #0,d1
 move.l 108(sp),d0
 jsr _016ac(a6)
 addq.l #4,sp
 move.l 104(sp),D00058(a6)
 movea.l D00058(a6),a0
 move.l 44(sp),34(a0)
 movea.l D00058(a6),a0
 move.l 48(sp),24(a0)
 movea.l D00058(a6),a0
 move.l 68(sp),28(a0)
 movea.l D00058(a6),a0
 move.l 72(sp),8(a0)
 movea.l D00058(a6),a0
 move.l 76(sp),12(a0)
 movea.l D00058(a6),a0
 move.l 80(sp),16(a0)
 movea.l D00058(a6),a0
 move.l 84(sp),20(a0)
 movea.l D00058(a6),a0
 move.l 96(sp),38(a0)
 movea.l D00058(a6),a0
 move.l 100(sp),42(a0)
 movea.l D00058(a6),a0
 move.l 88(sp),(a0)
 movea.l D00058(a6),a0
 move.l 92(sp),4(a0)
 movea.l 32(sp),a0
 move.l 68(sp),4(a0)
 movea.l 36(sp),a0
 move.l #16711935,8(a0)
 bsr.w L14194
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 bsr.w L140a6
 moveq #1,d1
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L0e1e2
 moveq #1,d0
 bra.s L0e1e4
L0e1e2 moveq #0,d0
L0e1e4 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 bsr.w L140a6
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #0,d1
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 bsr.w L1398c
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 bsr.w L1398c
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 pea (L0003f).w
 moveq #0,d1
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L0e24e
 moveq #1,d0
 bra.s L0e250
L0e24e moveq #0,d0
L0e250 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 bsr.w L1398c
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 move.l 40(sp),d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 bsr.w L139e4
 addq.l #8,sp
 movea.l 36(sp),a0
 move.l 48(sp),4(a0)
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 move.l 44(sp),d1
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L0e2a6
 moveq #1,d0
 bra.s L0e2a8
L0e2a6 moveq #0,d0
L0e2a8 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 bsr.w L139e4
 addq.l #8,sp
 movea.l 36(sp),a0
 move.l 72(sp),4(a0)
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 move.l 44(sp),d1
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 bsr.w L139e4
 addq.l #8,sp
 pea (L00005).w
 pea (L00003).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 move.l D00028(a6),d0
 bsr.w L13aa2
 addq.l #8,sp
 pea (L00001).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 move.l D00028(a6),d0
 bsr.w L13d72
 addq.l #4,sp
 pea (L00005).w
 pea (L00005).w
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L0e344
 moveq #1,d0
 bra.s L0e346
L0e344 moveq #0,d0
L0e346 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 move.l D00028(a6),d0
 bsr.w L13aa2
 addq.l #8,sp
 clr.l -(sp)
 clr.l -(sp)
 pea (L00800).w
 move.l 96(sp),-(sp)
 moveq #0,d1
 move.l #5956,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 move.l 84(sp),-(sp)
 move.l #5670,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5648,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 move.l 80(sp),-(sp)
 move.l #5692,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5670,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 move.l 60(sp),-(sp)
 moveq #0,d1
 move.l #5692,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 movea.l D00028(a6),a0
 pea 5956(a0)
 clr.l -(sp)
 move.l #5648,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 bsr.w L14c64
 addq.l #8,sp
 lea L0df30(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6396(a1)
 movea.l D00028(a6),a0
 move.l 92(sp),6400(a0)
 andi.w #$feff,_011ba(a6)
 lea (sp),a0
 move.l a0,d1
 move.l #6222,d0
 add.l D00028(a6),d0
 bsr.w L15c48
 move.l d0,40(sp)
 moveq #255,d0
 cmp.l 40(sp),d0
 bne.s L0e45a
 jsr _0187a(a6)
 bra.s L0e476
L0e45a moveq #1,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 bsr.w L14aa8
 moveq #0,d0
 jsr _01712(a6)
 moveq #1,d0
 jsr _01712(a6)
L0e476 lea 44(sp),sp
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L0e484 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 movea.l D00028(a6),a0
 move.l 6802(a0),-(sp)
 clr.l -(sp)
 clr.l -(sp)
 pea (L00001).w
 pea L0de06(pc)
 movea.l D00028(a6),a0
 move.l 4830(a0),-(sp)
 movea.l D00028(a6),a0
 movea.l 162(a0),a0
 move.l #61152,d0
 pea (a0,d0.l)
 movea.l D00028(a6),a0
 movea.l 162(a0),a0
 pea 30576(a0)
 movea.l D00028(a6),a0
 move.l 162(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 4038(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 166(a0),d1
 lea L0eb9b(pc),a0
 move.l a0,d0
 bsr.w L0e0e2
 lea 40(sp),sp
 lea L08952(pc),a0
 movea.l D00028(a6),a1
 move.l a0,9828(a1)
 movea.l D00028(a6),a0
 move.l #1,9832(a0)
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L0e50e link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D00028(a6),a0
 move.l 6802(a0),-(sp)
 clr.l -(sp)
 pea L0ded6(pc)
 clr.l -(sp)
 pea L0e484(pc)
 movea.l D00028(a6),a0
 move.l 4830(a0),-(sp)
 movea.l D00028(a6),a0
 movea.l 162(a0),a0
 move.l #61152,d0
 pea (a0,d0.l)
 movea.l D00028(a6),a0
 movea.l 162(a0),a0
 pea 30576(a0)
 movea.l D00028(a6),a0
 move.l 162(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 4038(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 166(a0),d1
 lea L0eb9f(pc),a0
 move.l a0,d0
 bsr.w L0e0e2
 lea 40(sp),sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L0e580 link.w a5,#0
 movem.l a0/a2/d0-d1/d4,-(sp)
 movea.l 4(sp),a0
 movea.l 16(a0),a2
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d4
 tst.w D00056(a6)
 beq.s L0e5c4
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L0e5b8
 moveq #1,d0
 bra.s L0e5ba
L0e5b8 moveq #0,d0
L0e5ba lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d4
L0e5c4 move.l a2,d0
 andi.l #$00ffffff,d0
 bset.l #30,d0
 move.l d0,-(sp)
 clr.l -(sp)
 movea.l D00028(a6),a0
 movea.w 66(a0),a0
 move.l a0,-(sp)
 move.l d4,d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01814(a6)
 jsr _017ba(a6)
 lea 12(sp),sp
 tst.w D00056(a6)
 beq.s L0e606
 moveq #0,d1
 moveq #0,d0
 bsr.w L101e0
 clr.w D00056(a6)
L0e606 jsr _0184a(a6)
 movem.l -12(a5),a0/a2/d4
 unlk a5
 rts 
L0e614 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 subq.l #4,sp
 movea.l 8(sp),a0
 move.l 16(a0),(sp)
 movea.l (sp),a0
 pea 4(a0)
 pea (L00080).w
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01a66(a6)
 lea 16(sp),sp
 addq.l #4,sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L0e676 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 pea (L00001).w
 pea (L00002).w
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 moveq #63,d1
 moveq #82,d0
 add.l D00028(a6),d0
 bsr.w L13f56
 lea 20(sp),sp
 pea (L00001).w
 pea (L00002).w
 movea.l 12(sp),a0
 move.l 4(a0),-(sp)
 movea.l 16(sp),a0
 move.l (a0),-(sp)
 clr.l -(sp)
 moveq #63,d1
 moveq #122,d0
 add.l D00028(a6),d0
 bsr.w L13f56
 lea 20(sp),sp
 movea.l 4(sp),a0
 clr.l (a0)
 movea.l 4(sp),a0
 clr.l 4(a0)
 movem.l -4(a5),a0
 unlk a5
 rts 
L0e6dc link.w a5,#0
 movem.l d0-d1,-(sp)
 pea (L00001).w
 clr.l -(sp)
 clr.l -(sp)
 pea L0deea(pc)
 pea (L0003f).w
 moveq #0,d1
 moveq #82,d0
 add.l D00028(a6),d0
 bsr.w L13f56
 lea 20(sp),sp
 pea (L00001).w
 clr.l -(sp)
 clr.l -(sp)
 pea L0deea(pc)
 pea (L0003f).w
 moveq #0,d1
 moveq #122,d0
 add.l D00028(a6),d0
 bsr.w L13f56
 lea 20(sp),sp
 unlk a5
 rts 
L0e728 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4,-(sp)
 move.l d0,d4
 movea.l d1,a2
 moveq #122,d0
 add.l D00028(a6),d0
 movea.l d0,a3
 move.l a2,d0
 andi.l #$00ffffff,d0
 bset.l #30,d0
 move.l d0,-(sp)
 clr.l -(sp)
 movea.l D00028(a6),a0
 movea.w 66(a0),a0
 move.l a0,-(sp)
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01814(a6)
 jsr _017ba(a6)
 lea 12(sp),sp
 jsr _0184a(a6)
 tst.l _00ffe(a6)
 bne.s L0e79a
 suba.l #384,a2
 subq.l #1,_00ffa(a6)
 movea.l 36(a3),a0
 move.l a2,4(a0)
L0e79a tst.l _00ffe(a6)
 bne.s L0e7a4
 moveq #1,d0
 bra.s L0e7a6
L0e7a4 moveq #0,d0
L0e7a6 move.l d0,_00ffe(a6)
 tst.l _00ffa(a6)
 bgt.s L0e7be
 move.l 36(a3),d1
 move.l (a3),d0
 bsr.w L1326a
 clr.l 36(a3)
L0e7be movem.l -16(a5),a0/a2-a3/d4
 unlk a5
 rts 
L0e7c8 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 subq.l #4,sp
 moveq #122,d0
 add.l D00028(a6),d0
 move.l d0,(sp)
 movea.l D00028(a6),a0
 tst.w 9824(a0)
 bne.s L0e816
 movea.l (sp),a0
 move.l (a0),d0
 bsr.w L131f4
 movea.l (sp),a0
 move.l d0,36(a0)
 move.l 8(sp),-(sp)
 pea L0e728(pc)
 movea.l 8(sp),a0
 move.l 36(a0),d1
 movea.l 8(sp),a0
 move.l (a0),d0
 bsr.w L1321e
 addq.l #8,sp
 movea.l (sp),a0
 move.l (a0),d0
 bsr.w L13f1a
L0e816 addq.l #4,sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L0e822 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 subq.l #8,sp
 moveq #82,d0
 add.l D00028(a6),d0
 move.l d0,4(sp)
 moveq #122,d0
 add.l D00028(a6),d0
 move.l d0,(sp)
 movea.l 4(sp),a0
 move.l 12(sp),4(a0)
 movea.l (sp),a0
 move.l 8(sp),4(a0)
 movea.l 4(sp),a0
 move.l #16711935,8(a0)
 bsr.w L14194
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 bsr.w L140a6
 moveq #1,d1
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L0e88a
 moveq #1,d0
 bra.s L0e88c
L0e88a moveq #0,d0
L0e88c lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 bsr.w L140a6
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 moveq #0,d0
 bsr.w L13e0c
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #0,d1
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d0
 bsr.w L1398c
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),d0
 bsr.w L1398c
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #82,d0
 add.l D00028(a6),d0
 move.l d0,d1
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 bsr.w L139e4
 addq.l #8,sp
 pea (L00005).w
 pea (L00003).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 move.l D00028(a6),d0
 bsr.w L13aa2
 addq.l #8,sp
 pea (L00001).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 move.l D00028(a6),d0
 bsr.w L13d72
 addq.l #4,sp
 move.l #92160,d0
 add.l 8(sp),d0
 andi.l #$00ffffff,d0
 bset.l #30,d0
 move.l d0,-(sp)
 clr.l -(sp)
 movea.l D00028(a6),a0
 movea.w 66(a0),a0
 move.l a0,-(sp)
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _017ba(a6)
 lea 12(sp),sp
 move.l 40(sp),-(sp)
 pea L0e614(pc)
 pea (L00800).w
 move.l 52(sp),-(sp)
 moveq #0,d1
 move.l #5956,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 move.l 12(sp),-(sp)
 pea L0e580(pc)
 move.l #94080,-(sp)
 move.l 24(sp),-(sp)
 move.l #5670,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5648,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 pea D0005c(a6)
 pea L0e6dc(pc)
 move.l #188160,-(sp)
 move.l 20(sp),-(sp)
 move.l #5692,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5670,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 move.l 32(sp),-(sp)
 pea L0e580(pc)
 move.l #94080,-(sp)
 move.l 44(sp),-(sp)
 move.l #5714,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5692,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 move.l 36(sp),-(sp)
 pea L0e580(pc)
 move.l #94080,-(sp)
 move.l 48(sp),-(sp)
 move.l #5736,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5714,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 move.l 12(sp),-(sp)
 pea L0e580(pc)
 move.l #94080,-(sp)
 move.l 24(sp),-(sp)
 move.l #5692,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5736,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 movea.l D00028(a6),a0
 pea 5956(a0)
 clr.l -(sp)
 move.l #5648,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 bsr.w L14c64
 addq.l #8,sp
 addi.l #$00016800,8(sp)
 lea L0e50e(pc),a0
 move.l a0,D0005c(a6)
 clr.l D00060(a6)
 clr.w D0007c(a6)
 lea L0e676(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6396(a1)
 lea D0005c(a6),a0
 movea.l D00028(a6),a1
 move.l a0,6400(a1)
 lea L0e7c8(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6404(a1)
 movea.l D00028(a6),a0
 move.l 8(sp),6408(a0)
 lea L08952(pc),a0
 movea.l D00028(a6),a1
 move.l a0,9828(a1)
 movea.l D00028(a6),a0
 move.l #1,9832(a0)
 movea.l D00028(a6),a0
 clr.w 9826(a0)
 lea L0eba3(pc),a0
 move.l a0,d1
 move.l #6222,d0
 add.l D00028(a6),d0
 bsr.w L15c48
 movea.l D00028(a6),a0
 move.w #1,9826(a0)
 moveq #1,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 bsr.w L14aa8
 moveq #0,d0
 jsr _01712(a6)
 moveq #1,d0
 jsr _01712(a6)
 addq.l #8,sp
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L0eb94 moveq #105,d5
 move.w d0,d1
L0eb98 subq.w #7,122(a1)
L0eb9b equ *-1
 dc.w $6933
 dc.w $7a
L0eb9f equ *-1
 dc.w $6931
 ori.w #$6173,-(a3)
L0eba3 equ *-3
 moveq #0,d2
L0eba8 link.w a5,#0
 movem.l d0,-(sp)
 unlk a5
 rts 
L0ebb4 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l 20(sp),-(sp)
 pea (L00080).w
 lea L0f15c(pc),a0
 move.l a0,d1
 lea L0f162(pc),a0
 move.l a0,d0
 jsr _01a00(a6)
 addq.l #8,sp
 tst.l 20(sp)
 beq.s L0ec0c
 move.l (sp),d0
 move.l #228,d1
 jsr _016a0(a6)
 move.l d0,d1
 move.l 20(sp),d0
 jsr _01aba(a6)
 pea (L000e4).w
 move.l 8(sp),d1
 move.l 24(sp),d0
 jsr _01ac0(a6)
 addq.l #4,sp
 move.l 20(sp),d0
 jsr _019fa(a6)
L0ec0c movem.l -4(a5),a0
 unlk a5
 rts 
L0ec16 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l 20(sp),-(sp)
 pea (L00080).w
 lea L0f172(pc),a0
 move.l a0,d1
 lea L0f178(pc),a0
 move.l a0,d0
 jsr _01a00(a6)
 addq.l #8,sp
 tst.l 20(sp)
 beq.s L0ec6e
 move.l (sp),d0
 move.l #228,d1
 jsr _016a0(a6)
 move.l d0,d1
 move.l 20(sp),d0
 jsr _01aba(a6)
 pea (L000e4).w
 move.l 8(sp),d1
 move.l 24(sp),d0
 jsr _01ab4(a6)
 addq.l #4,sp
 move.l 20(sp),d0
 jsr _019fa(a6)
L0ec6e movem.l -4(a5),a0
 unlk a5
 rts 
L0ec78 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 lea -12(sp),sp
 move.l 40(sp),4(sp)
 move.l 36(sp),-(sp)
 pea (L00080).w
 lea L0f188(pc),a0
 move.l a0,d1
 lea L0f18e(pc),a0
 move.l a0,d0
 jsr _01a00(a6)
 addq.l #8,sp
 move.l d0,(sp)
 tst.l (sp)
 bne.w L0ed32
 move.l 36(sp),-(sp)
 pea (L00080).w
 pea (L002ac).w
 pea L0f19e(pc)
 lea L0f1aa(pc),a0
 move.l a0,d1
 lea L0f1b0(pc),a0
 move.l a0,d0
 bsr.w L0b892
 lea 16(sp),sp
 tst.l 36(sp)
 clr.l 8(sp)
 bra.s L0ed0e
L0ecda lea L0f1c0(pc),a0
 move.l a0,d1
 move.l 4(sp),d0
 jsr _017f6(a6)
 pea (L00032).w
 moveq #0,d1
 moveq #18,d0
 add.l 8(sp),d0
 jsr _016ac(a6)
 addq.l #4,sp
 movea.l 4(sp),a0
 clr.w 16(a0)
 addq.l #1,8(sp)
 addi.l #$000000e4,4(sp)
L0ed0e moveq #3,d0
 cmp.l 8(sp),d0
 bgt.s L0ecda
 pea (L002ac).w
 move.l 44(sp),d1
 move.l 40(sp),d0
 jsr _01ac0(a6)
 addq.l #4,sp
 moveq #0,d1
 move.l 36(sp),d0
 jsr _01aba(a6)
L0ed32 pea (L002ac).w
 move.l 44(sp),d1
 move.l 40(sp),d0
 jsr _01ab4(a6)
 addq.l #4,sp
 move.l 36(sp),d0
 jsr _019fa(a6)
 move.l 40(sp),d1
 move.l 12(sp),d0
 jsr _017f6(a6)
 move.l #228,d0
 add.l 40(sp),d0
 move.l d0,d1
 move.l 16(sp),d0
 jsr _017f6(a6)
 move.l #456,d0
 add.l 40(sp),d0
 move.l d0,d1
 move.l 32(sp),d0
 jsr _017f6(a6)
 lea 12(sp),sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L0ed8e link.w a5,#0
 movem.l a0-a4/d0-d2/d4-d6,-(sp)
 subq.l #8,sp
 clr.w 6(sp)
 clr.w 4(sp)
 clr.w 2(sp)
 move.w #16,6(sp)
 move.w 6(sp),d0
 ext.l d0
 divs.w #2,d0
 swap d0
 tst.w d0
 beq.s L0edbe
 addq.w #1,6(sp)
L0edbe move.w #4,4(sp)
 movea.l D00028(a6),a0
 movea.l 6908(a0),a3
 moveq #18,d0
 add.l 8(sp),d0
 movea.l d0,a2
 pea (L00032).w
 moveq #0,d1
 moveq #18,d0
 add.l 12(sp),d0
 jsr _016ac(a6)
 addq.l #4,sp
 moveq #0,d4
 bra.s L0ee1e
L0edea moveq #1,d0
 and.b 1(a3),d0
 move.b d0,1(sp)
 move.w 2(sp),d0
 ext.l d0
 moveq #7,d1
 sub.l d0,d1
 moveq #0,d0
 move.b 1(sp),d0
 lsl.l d1,d0
 or.b d0,(a2)
 addq.w #1,2(sp)
 cmpi.w #7,2(sp)
 ble.s L0ee1a
 clr.w 2(sp)
 addq.l #1,a2
L0ee1a addq.l #1,d4
 addq.l #2,a3
L0ee1e moveq #126,d0
 cmp.l d4,d0
 bgt.s L0edea
 movea.l D00028(a6),a0
 move.l #310,d0
 add.l 6908(a0),d0
 movea.l d0,a3
 addq.l #1,a2
 moveq #0,d4
 bra.s L0ee44
L0ee3a move.b 1(a3),(a2)
 addq.l #1,d4
 addq.l #2,a3
 addq.l #1,a2
L0ee44 move.w 4(sp),d0
 ext.l d0
 cmp.l d4,d0
 bgt.s L0ee3a
 addq.l #1,a2
 clr.w 2(sp)
 movea.l D00028(a6),a0
 movea.l 8092(a0),a4
 moveq #0,d4
 bra.s L0ee88
L0ee60 move.w 2(sp),d0
 ext.l d0
 moveq #7,d1
 sub.l d0,d1
 moveq #0,d0
 move.b (a4),d0
 lsl.l d1,d0
 or.b d0,(a2)
 addq.w #1,2(sp)
 cmpi.w #7,2(sp)
 ble.s L0ee84
 clr.w 2(sp)
 addq.l #1,a2
L0ee84 addq.l #1,d4
 addq.l #1,a4
L0ee88 cmpi.l #1056,d4
 blt.s L0ee60
 move.l a2,d0
 moveq #2,d1
 jsr _017ae(a6)
 beq.s L0ee9c
 addq.l #1,a2
L0ee9c clr.w 2(sp)
 moveq #0,d4
 bra.s L0eee4
L0eea4 moveq #0,d5
 bra.s L0eedc
L0eea8 move.l d4,d0
 lsl.l #5,d0
 movea.l D00028(a6),a0
 adda.l d0,a0
 adda.l d5,a0
 moveq #0,d0
 move.b 9568(a0),d0
 move.w 2(sp),d1
 ext.l d1
 moveq #7,d2
 sub.l d1,d2
 lsl.l d2,d0
 or.b d0,(a2)
 addq.w #1,2(sp)
 cmpi.w #7,2(sp)
 ble.s L0eeda
 clr.w 2(sp)
 addq.l #1,a2
L0eeda addq.l #1,d5
L0eedc moveq #32,d0
 cmp.l d5,d0
 bgt.s L0eea8
 addq.l #1,d4
L0eee4 moveq #8,d0
 cmp.l d4,d0
 bgt.s L0eea4
 move.l a2,d0
 moveq #2,d1
 jsr _017ae(a6)
 beq.s L0eef6
 addq.l #1,a2
L0eef6 move.l a2,d6
 movea.l D00028(a6),a0
 movea.l d6,a1
 addq.l #2,d6
 move.w 5108(a0),(a1)
 movea.l D00028(a6),a0
 movea.l d6,a1
 addq.l #2,d6
 move.w 5106(a0),(a1)
 movea.l D00028(a6),a0
 movea.l d6,a1
 addq.l #2,d6
 move.w 5566(a0),(a1)
 movea.l D00028(a6),a0
 movea.l d6,a1
 addq.l #2,d6
 move.w 5568(a0),(a1)
 movea.l D00028(a6),a0
 moveq #0,d0
 move.w 6904(a0),d0
 lsl.l #8,d0
 movea.l d6,a0
 move.w d0,(a0)
 movea.l D00028(a6),a0
 move.w 6906(a0),d0
 movea.l d6,a0
 addq.l #2,d6
 or.w d0,(a0)
 addq.l #8,sp
 movem.l -40(a5),a0-a4/d1-d2/d4-d6
 unlk a5
 rts 
L0ef52 link.w a5,#0
 movem.l a0-a4/d0-d1/d4-d6,-(sp)
 subq.l #6,sp
 clr.w 4(sp)
 clr.w 2(sp)
 clr.w (sp)
 move.w #16,4(sp)
 move.w 4(sp),d0
 ext.l d0
 divs.w #2,d0
 swap d0
 tst.w d0
 beq.s L0ef80
 addq.w #1,4(sp)
L0ef80 move.w #4,2(sp)
 movea.l D00028(a6),a0
 movea.l 6908(a0),a3
 moveq #18,d0
 add.l 6(sp),d0
 movea.l d0,a2
 moveq #0,d4
 bra.s L0efc0
L0ef9a move.w (sp),d0
 ext.l d0
 moveq #7,d1
 sub.l d0,d1
 move.b (a2),d0
 lsr.b d1,d0
 andi.b #$01,d0
 moveq #0,d1
 move.b d0,d1
 move.w d1,(a3)
 addq.w #1,(sp)
 cmpi.w #7,(sp)
 ble.s L0efbc
 clr.w (sp)
 addq.l #1,a2
L0efbc addq.l #1,d4
 addq.l #2,a3
L0efc0 moveq #126,d0
 cmp.l d4,d0
 bgt.s L0ef9a
 movea.l D00028(a6),a0
 move.l #310,d0
 add.l 6908(a0),d0
 movea.l d0,a3
 addq.l #1,a2
 moveq #0,d4
 bra.s L0efe8
L0efdc moveq #0,d0
 move.b (a2),d0
 move.w d0,(a3)
 addq.l #1,d4
 addq.l #2,a3
 addq.l #1,a2
L0efe8 move.w 2(sp),d0
 ext.l d0
 cmp.l d4,d0
 bgt.s L0efdc
 addq.l #1,a2
 clr.w (sp)
 movea.l D00028(a6),a0
 movea.l 8092(a0),a4
 moveq #0,d4
 bra.s L0f026
L0f002 clr.b (a4)
 move.w (sp),d0
 ext.l d0
 moveq #7,d1
 sub.l d0,d1
 move.b (a2),d0
 lsr.b d1,d0
 andi.b #$01,d0
 move.b d0,(a4)
 addq.w #1,(sp)
 cmpi.w #7,(sp)
 ble.s L0f022
 clr.w (sp)
 addq.l #1,a2
L0f022 addq.l #1,d4
 addq.l #1,a4
L0f026 cmpi.l #1056,d4
 blt.s L0f002
 move.l a2,d0
 moveq #2,d1
 jsr _017ae(a6)
 beq.s L0f03a
 addq.l #1,a2
L0f03a clr.w (sp)
 moveq #0,d4
 bra.s L0f07a
L0f040 moveq #0,d5
 bra.s L0f072
L0f044 move.w (sp),d0
 ext.l d0
 moveq #7,d1
 sub.l d0,d1
 move.b (a2),d0
 lsr.b d1,d0
 andi.b #$01,d0
 move.l d4,d1
 lsl.l #5,d1
 movea.l D00028(a6),a0
 adda.l d1,a0
 adda.l d5,a0
 move.b d0,9568(a0)
 addq.w #1,(sp)
 cmpi.w #7,(sp)
 ble.s L0f070
 clr.w (sp)
 addq.l #1,a2
L0f070 addq.l #1,d5
L0f072 moveq #32,d0
 cmp.l d5,d0
 bgt.s L0f044
 addq.l #1,d4
L0f07a moveq #8,d0
 cmp.l d4,d0
 bgt.s L0f040
 move.l a2,d0
 moveq #2,d1
 jsr _017ae(a6)
 beq.s L0f08c
 addq.l #1,a2
L0f08c move.l a2,d6
 movea.l d6,a0
 addq.l #2,d6
 movea.l D00028(a6),a1
 move.w (a0),5108(a1)
 movea.l d6,a0
 addq.l #2,d6
 movea.l D00028(a6),a1
 move.w (a0),5106(a1)
 movea.l d6,a0
 addq.l #2,d6
 movea.l D00028(a6),a1
 move.w (a0),5566(a1)
 movea.l d6,a0
 addq.l #2,d6
 movea.l D00028(a6),a1
 move.w (a0),5568(a1)
 movea.l d6,a0
 move.w (a0),d0
 lsr.w #8,d0
 movea.l D00028(a6),a0
 move.w d0,6904(a0)
 movea.l d6,a0
 addq.l #2,d6
 move.w #255,d0
 and.w (a0),d0
 movea.l D00028(a6),a0
 move.w d0,6906(a0)
 addq.l #6,sp
 movem.l -36(a5),a0-a4/d1/d4-d6
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D00028(a6),a0
 move.w #60,5106(a0)
 movea.l D00028(a6),a0
 move.w #30,5566(a0)
 movea.l D00028(a6),a0
 move.w #30,5568(a0)
 movea.l D00028(a6),a0
 move.w #255,6904(a0)
 movea.l D00028(a6),a0
 clr.w 5108(a0)
 pea (L00100).w
 moveq #0,d1
 move.l #9568,d0
 add.l D00028(a6),d0
 jsr _016ac(a6)
 addq.l #4,sp
 pea (L00420).w
 moveq #0,d1
 movea.l D00028(a6),a0
 move.l 8092(a0),d0
 jsr _016ac(a6)
 addq.l #4,sp
 move.l (sp),d0
 bsr.w L0ed8e
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
L0f15c addq.w #5,-(a5)
 bge.s L0f1c4
 bsr.w L120d0
L0f162 equ *-2
 moveq #114,d3
 move.l L156d4(pc),25697(sp)
 movea.l _0f672(a6),sp
 dc.w $6900
L0f172 addq.w #5,-(a5)
 bge.s L0f1da
 bsr.w L120e6
L0f178 equ *-2
 moveq #114,d3
 move.l L156ea(pc),25697(sp)
 movea.l _0f672(a6),sp
 dc.w $6900
L0f188 addq.w #5,-(a5)
 bge.s L0f1f0
 bsr.w L120fc
L0f18e equ *-2
 moveq #114,d3
 move.l L15700(pc),25697(sp)
 movea.l _0f672(a6),sp
 dc.w $6900
L0f19e addq.w #5,-(a5)
 bge.s L0f206
 bsr.s L0f1c4
 subq.w #1,-(a1)
 moveq #101,d3
 dc.w $7300
L0f1aa addq.w #5,-(a5)
 bge.s L0f212
 bsr.w L1211e
L0f1b0 equ *-2
 moveq #114,d3
 move.l L15722(pc),25697(sp)
 movea.l _0f672(a6),sp
 dc.w $6900
L0f1c0 dc.w $454d
 addq.w #8,(a4)
L0f1c4 subq.b #4,d0
L0f1c6 link.w a5,#0
 movem.l a2-a3/d0-d1/d4-d6,-(sp)
 movea.l d0,a2
 move.l d1,d4
 movea.l 36(sp),a3
 move.l 40(sp),d5
L0f1da moveq #0,d6
 bra.s L0f1f2
L0f1de pea (L00180).w
 move.l a2,d1
 move.l a3,d0
 jsr _017c6(a6)
 addq.l #4,sp
 addq.l #1,d6
 adda.l d4,a2
L0f1f0 adda.l d5,a3
L0f1f2 cmpi.l #240,d6
 blt.s L0f1de
 movem.l -20(a5),a2-a3/d4-d6
 unlk a5
 rts 
L0f204 link.w a5,#0
L0f206 equ *-2
 movem.l a2-a4/d0-d2/d4-d5,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 movea.l 40(sp),a4
L0f212 equ *-2
 move.l 44(sp),d4
 moveq #0,d5
 bra.s L0f264
L0f21c move.l a3,d0
 andi.l #$00ffffff,d0
 bset.l #30,d0
 move.l d0,(a2)+
 move.b #255,d0
 and.b (a4),d0
 moveq #0,d1
 move.b d0,d1
 moveq #16,d0
 lsl.l d0,d1
 ori.l #$cb000000,d1
 move.b #255,d0
 and.b 1(a4),d0
 moveq #0,d2
 move.b d0,d2
 lsl.l #8,d2
 or.l d2,d1
 move.b #255,d0
 and.b 2(a4),d0
 moveq #0,d2
 move.b d0,d2
 or.l d2,d1
 move.l d1,(a2)+
 addq.l #1,d5
 adda.l d4,a3
 addq.l #3,a4
L0f264 cmpi.l #240,d5
 blt.s L0f21c
 movem.l -24(a5),a2-a4/d2/d4-d5
 unlk a5
 rts 
L0f276 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 pea (L002d0).w
 movea.l D00028(a6),a0
 move.l 4026(a0),d1
 move.l #4042,d0
 add.l D00028(a6),d0
 jsr _017c6(a6)
 addq.l #4,sp
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
L0f2a4 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
L0f2ac pea (L00001).w
 moveq #1,d1
 movea.l D00028(a6),a0
 move.l 182(a0),d0
 jsr _016f4(a6)
 addq.l #4,sp
 moveq #1,d1
 cmp.l d0,d1
 bne.s L0f2ac
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 movea.l D00028(a6),a1
 move.l 4800(a1),d1
 lsl.l #3,d1
 movea.l D00028(a6),a1
 move.l 36(a1,d1.l),d1
 cmp.l 36(a0,d0.l),d1
 beq.w L0f3e8
 movea.l D00028(a6),a0
 cmpi.w #2,4804(a0)
 beq.s L0f35a
 movea.l D00028(a6),a0
 pea 186(a0)
 pea (L00002).w
 pea (L000f0).w
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.w 66(a0),d0
 ext.l d0
 asr.l #1,d0
 move.l d0,-(sp)
 movea.l D00028(a6),a0
 tst.l 4800(a0)
 bne.s L0f32a
 moveq #1,d0
 bra.s L0f32c
L0f32a moveq #0,d0
L0f32c lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01814(a6)
 jsr _01ad2(a6)
 lea 20(sp),sp
 clr.l -(sp)
 movea.l D00028(a6),a0
 tst.l 4800(a0)
 bne.s L0f3ba
 moveq #1,d0
 bra.s L0f3bc
L0f35a movea.l D00028(a6),a0
 move.l 4762(a0),-(sp)
 pea (L00002).w
 pea (L000f0).w
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.w 66(a0),d0
 ext.l d0
 asr.l #1,d0
 move.l d0,-(sp)
 clr.l -(sp)
 movea.l D00028(a6),a0
 tst.l 4800(a0)
 bne.s L0f38a
 moveq #1,d0
 bra.s L0f38c
L0f38a moveq #0,d0
L0f38c lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01814(a6)
 jsr _01ad2(a6)
 lea 24(sp),sp
 clr.l -(sp)
 movea.l D00028(a6),a0
 tst.l 4800(a0)
 bne.s L0f3ba
 moveq #1,d0
 bra.s L0f3bc
L0f3ba moveq #0,d0
L0f3bc lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01acc(a6)
 addq.l #8,sp
L0f3e8 movea.l D00028(a6),a0
 tst.l 4768(a0)
 beq.s L0f41c
 movea.l D00028(a6),a0
 move.l 4772(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 4768(a0),d1
 move.l 4(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 clr.l 4768(a0)
 movea.l D00028(a6),a0
 clr.l 4772(a0)
L0f41c movem.l -8(a5),a0-a1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 pea (L00180).w
 movea.l D00028(a6),a0
 move.l 4026(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 4038(a0),d1
 move.l #186,d0
 add.l D00028(a6),d0
 bsr.w L0f204
 addq.l #8,sp
L0f452 pea (L00001).w
 moveq #1,d1
 movea.l D00028(a6),a0
 move.l 182(a0),d0
 jsr _016f4(a6)
 addq.l #4,sp
 moveq #1,d1
 cmp.l d0,d1
 bne.s L0f452
 movea.l D00028(a6),a0
 pea 186(a0)
 pea (L00002).w
 pea (L000f0).w
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.w 66(a0),d0
 ext.l d0
 asr.l #1,d0
 move.l d0,-(sp)
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01ad2(a6)
 lea 20(sp),sp
 bsr.w L0f276
 pea (L00003).w
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 pea (L0003f).w
 moveq #0,d1
 moveq #82,d0
 add.l D00028(a6),d0
 bsr.w L13f56
 lea 20(sp),sp
 pea (L00003).w
 clr.l -(sp)
 clr.l -(sp)
 pea L0f2a4(pc)
 movea.l D00028(a6),a0
 movea.w 5576(a0),a0
 move.l a0,-(sp)
 moveq #0,d1
 moveq #122,d0
 add.l D00028(a6),d0
 bsr.w L13f56
 lea 20(sp),sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L0f502 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D00028(a6),a0
 pea 186(a0)
 pea (L00002).w
 pea (L000f0).w
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.w 66(a0),d0
 ext.l d0
 asr.l #1,d0
 move.l d0,-(sp)
 movea.l D00028(a6),a0
 tst.l 4800(a0)
 bne.s L0f538
 moveq #1,d0
 bra.s L0f53a
L0f538 moveq #0,d0
L0f53a lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01814(a6)
 jsr _01ad2(a6)
 lea 20(sp),sp
 movea.l D00028(a6),a0
 tst.l 4800(a0)
 bne.s L0f566
 moveq #1,d0
 bra.s L0f568
L0f566 moveq #0,d0
L0f568 movea.l D00028(a6),a0
 move.l d0,4800(a0)
L0f570 pea (L00001).w
 moveq #1,d1
 movea.l D00028(a6),a0
 move.l 182(a0),d0
 jsr _016f4(a6)
 addq.l #4,sp
 moveq #1,d1
 cmp.l d0,d1
 bne.s L0f570
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.l 4800(a0),d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01814(a6)
 jsr _01acc(a6)
 addq.l #8,sp
 jsr _0184a(a6)
 tst.l 4(sp)
 beq.s L0f5e0
 pea _01002(a6)
 move.l 8(sp),d1
 move.l 4(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
L0f5e0 movem.l -4(a5),a0
 unlk a5
 rts 
L0f5ea link.w a5,#0
 movem.l a0/d0-d1,-(sp)
L0f5f2 pea (L00001).w
 moveq #1,d1
 movea.l D00028(a6),a0
 move.l 182(a0),d0
 jsr _016f4(a6)
 addq.l #4,sp
 moveq #1,d1
 cmp.l d0,d1
 bne.s L0f5f2
 movea.l D00028(a6),a0
 move.l 4762(a0),-(sp)
 pea (L00002).w
 pea (L000f0).w
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.w 66(a0),d0
 ext.l d0
 asr.l #1,d0
 move.l d0,-(sp)
 movea.l D00028(a6),a0
 tst.l 4800(a0)
 bne.s L0f63a
 moveq #1,d0
 bra.s L0f63c
L0f63a moveq #0,d0
L0f63c lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01814(a6)
 jsr _01ad2(a6)
 lea 20(sp),sp
 movea.l D00028(a6),a0
 tst.l 4800(a0)
 bne.s L0f668
 moveq #1,d0
 bra.s L0f66a
L0f668 moveq #0,d0
L0f66a movea.l D00028(a6),a0
 move.l d0,4800(a0)
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.l 4800(a0),d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01814(a6)
 jsr _01acc(a6)
 addq.l #8,sp
 jsr _0184a(a6)
 tst.l 4(sp)
 beq.s L0f6c8
 pea _01002(a6)
 move.l 8(sp),d1
 move.l 4(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
L0f6c8 movem.l -4(a5),a0
 unlk a5
 rts 
L0f6d2 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 pea (L00180).w
 movea.l D00028(a6),a0
 move.l 4026(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 4038(a0),d1
 move.l #186,d0
 add.l D00028(a6),d0
 bsr.w L0f204
 addq.l #8,sp
 pea L0f2a4(pc)
 lea L0f502(pc),a0
 move.l a0,d1
 move.l 4(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
 bsr.w L0f276
 movem.l -4(a5),a0
 unlk a5
 rts 
L0f720 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 pea (L00300).w
 movea.l D00028(a6),a0
 move.l 4026(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 4034(a0),d1
 move.l #186,d0
 add.l D00028(a6),d0
 bsr.w L0f204
 addq.l #8,sp
 pea L0f6d2(pc)
 lea L0f502(pc),a0
 move.l a0,d1
 move.l 4(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L0f76a link.w a5,#0
 movem.l a0/a2-a4/d0-d2/d4-d5,-(sp)
 movea.l d1,a2
 move.l #186,d0
 add.l D00028(a6),d0
 movea.l d0,a4
 move.w _01012(a6),d0
 asr.w #4,d0
 muls.w #720,d0
 movea.l D00028(a6),a0
 add.l 4776(a0),d0
 move.l d0,d4
 movea.l D00028(a6),a0
 move.l 174(a0),d0
 move.w _01012(a6),d1
 ext.l d1
 add.l d1,d0
 movea.l d0,a3
 moveq #0,d5
 bra.s L0f7fc
L0f7aa move.l a3,d0
 andi.l #$00ffffff,d0
 bset.l #30,d0
 move.l d0,(a4)+
 movea.l d4,a0
 addq.l #1,d4
 move.b #255,d0
 and.b (a0),d0
 moveq #0,d1
 move.b d0,d1
 moveq #16,d0
 lsl.l d0,d1
 ori.l #$cb000000,d1
 movea.l d4,a0
 addq.l #1,d4
 move.b #255,d0
 and.b (a0),d0
 moveq #0,d2
 move.b d0,d2
 lsl.l #8,d2
 or.l d2,d1
 movea.l d4,a0
 addq.l #1,d4
 move.b #255,d0
 and.b (a0),d0
 moveq #0,d2
 move.b d0,d2
 or.l d2,d1
 move.l d1,(a4)+
 addq.l #1,d5
 adda.l #768,a3
L0f7fc cmpi.l #240,d5
 blt.s L0f7aa
 addi.w #$0010,_01012(a6)
 cmpi.w #384,_01012(a6)
 bgt.s L0f828
 pea L0f76a(pc)
 lea L0f502(pc),a0
 move.l a0,d1
 move.l 4(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
 bra.s L0f838
L0f828 clr.w _01012(a6)
 lea L0f720(pc),a0
 move.l a0,d1
 move.l (sp),d0
 jsr _016a6(a6)
L0f838 movem.l -28(a5),a0/a2-a4/d2/d4-d5
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 pea (L00300).w
 movea.l D00028(a6),a0
 move.l 4034(a0),-(sp)
 move.l #384,d1
 movea.l D00028(a6),a0
 move.l 4038(a0),d0
 bsr.w L0f1c6
 addq.l #8,sp
 lea _01002(a6),a0
 move.l a0,d1
 move.l (sp),d0
 bsr.w L0f76a
 movem.l -4(a5),a0
 unlk a5
 rts 
L0f880 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 bsr.w L0f276
 pea (L00180).w
 movea.l D00028(a6),a0
 move.l 4026(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 4038(a0),d1
 move.l #186,d0
 add.l D00028(a6),d0
 bsr.w L0f204
 addq.l #8,sp
 pea L0f2a4(pc)
 lea L0f502(pc),a0
 move.l a0,d1
 move.l 4(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L0f8ce link.w a5,#0
 movem.l a0/a2-a4/d0-d2/d4-d5,-(sp)
 movea.l d1,a2
 move.l #186,d0
 add.l D00028(a6),d0
 movea.l d0,a4
 move.w _01014(a6),d0
 bge.s L0f8ee
 addi.w #$000f,d0
L0f8ee asr.w #4,d0
 muls.w #720,d0
 movea.l D00028(a6),a0
 add.l 4776(a0),d0
 move.l d0,d4
 movea.l D00028(a6),a0
 move.l 174(a0),d0
 move.w _01014(a6),d1
 ext.l d1
 add.l d1,d0
 movea.l d0,a3
 moveq #0,d5
 bra.s L0f966
L0f914 move.l a3,d0
 andi.l #$00ffffff,d0
 bset.l #30,d0
 move.l d0,(a4)+
 movea.l d4,a0
 addq.l #1,d4
 move.b #255,d0
 and.b (a0),d0
 moveq #0,d1
 move.b d0,d1
 moveq #16,d0
 lsl.l d0,d1
 ori.l #$cb000000,d1
 movea.l d4,a0
 addq.l #1,d4
 move.b #255,d0
 and.b (a0),d0
 moveq #0,d2
 move.b d0,d2
 lsl.l #8,d2
 or.l d2,d1
 movea.l d4,a0
 addq.l #1,d4
 move.b #255,d0
 and.b (a0),d0
 moveq #0,d2
 move.b d0,d2
 or.l d2,d1
 move.l d1,(a4)+
 addq.l #1,d5
 adda.l #768,a3
L0f966 cmpi.l #240,d5
 blt.s L0f914
 subi.w #16,_01014(a6)
 tst.w _01014(a6)
 blt.s L0f990
 pea L0f8ce(pc)
 lea L0f502(pc),a0
 move.l a0,d1
 move.l 4(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
 bra.s L0f9a2
L0f990 move.w #368,_01014(a6)
 lea L0f880(pc),a0
 move.l a0,d1
 move.l (sp),d0
 jsr _016a6(a6)
L0f9a2 movem.l -28(a5),a0/a2-a4/d2/d4-d5
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 pea (L00300).w
 movea.l D00028(a6),a0
 move.l 4030(a0),-(sp)
 move.l #384,d1
 movea.l D00028(a6),a0
 move.l 4038(a0),d0
 bsr.w L0f1c6
 addq.l #8,sp
 pea (L00300).w
 movea.l D00028(a6),a0
 pea 4042(a0)
 movea.l D00028(a6),a0
 move.l 4034(a0),d1
 move.l #186,d0
 add.l D00028(a6),d0
 bsr.w L0f204
 addq.l #8,sp
 pea L0f8ce(pc)
 lea L0f502(pc),a0
 move.l a0,d1
 move.l 4(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L0fa16 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
L0fa1e pea (L00001).w
 moveq #1,d1
 movea.l D00028(a6),a0
 move.l 182(a0),d0
 jsr _016f4(a6)
 addq.l #4,sp
 moveq #1,d1
 cmp.l d0,d1
 bne.s L0fa1e
 movea.l D00028(a6),a0
 move.w 4766(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 adda.l d0,a0
 pea 186(a0)
 pea (L00002).w
 pea (L000f0).w
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.w 66(a0),d0
 ext.l d0
 asr.l #1,d0
 move.l d0,-(sp)
 movea.l D00028(a6),a0
 tst.l 4800(a0)
 bne.s L0fa74
 moveq #1,d0
 bra.s L0fa76
L0fa74 moveq #0,d0
L0fa76 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01814(a6)
 jsr _01ad2(a6)
 lea 20(sp),sp
 movea.l D00028(a6),a0
 tst.l 4800(a0)
 bne.s L0faa2
 moveq #1,d0
 bra.s L0faa4
L0faa2 moveq #0,d0
L0faa4 movea.l D00028(a6),a0
 move.l d0,4800(a0)
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.l 4800(a0),d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01814(a6)
 jsr _01acc(a6)
 addq.l #8,sp
 jsr _0184a(a6)
 tst.l 4(sp)
 beq.s L0fb02
 pea _01002(a6)
 move.l 8(sp),d1
 move.l 4(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
L0fb02 movem.l -4(a5),a0
 unlk a5
 rts 
L0fb0c link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 pea (L00180).w
 movea.l D00028(a6),a0
 move.l 4026(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 4038(a0),d1
 move.l #186,d0
 add.l D00028(a6),d0
 bsr.w L0f204
 addq.l #8,sp
 pea L0f2a4(pc)
 lea L0f502(pc),a0
 move.l a0,d1
 move.l 4(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
 bsr.w L0f276
 movem.l -4(a5),a0
 unlk a5
 rts 
L0fb5a link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D00028(a6),a0
 addq.w #4,4766(a0)
 movea.l D00028(a6),a0
 cmpi.w #240,4766(a0)
 bgt.s L0fb80
 pea L0fb5a(pc)
 lea L0fa16(pc),a0
 bra.s L0fb86
L0fb80 clr.l -(sp)
 lea L0fb0c(pc),a0
L0fb86 move.l a0,d1
 move.l 4(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
 movem.l -4(a5),a0
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 pea (L00180).w
 movea.l D00028(a6),a0
 move.l 4026(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 4038(a0),d1
 movea.l D00028(a6),a0
 move.l 4762(a0),d0
 bsr.w L0f204
 addq.l #8,sp
 movea.l D00028(a6),a0
 clr.w 4766(a0)
 move.l 4(sp),d1
 move.l (sp),d0
 bsr.s L0fb5a
 movem.l -4(a5),a0
 unlk a5
 rts 
L0fbe0 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D00028(a6),a0
 clr.w 4766(a0)
 bsr.w L0f276
 clr.l -(sp)
 lea L0f2a4(pc),a0
 move.l a0,d1
 move.l 4(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L0fc10 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D00028(a6),a0
 subq.w #4,4766(a0)
 movea.l D00028(a6),a0
 tst.w 4766(a0)
 blt.s L0fc34
 pea L0fc10(pc)
 lea L0fa16(pc),a0
 bra.s L0fc3a
L0fc34 clr.l -(sp)
 lea L0fbe0(pc),a0
L0fc3a move.l a0,d1
 move.l 4(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
 movem.l -4(a5),a0
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 pea (L00300).w
 movea.l D00028(a6),a0
 pea 4042(a0)
 movea.l D00028(a6),a0
 move.l 4030(a0),d1
 movea.l D00028(a6),a0
 move.l 4762(a0),d0
 bsr.w L0f204
 addq.l #8,sp
 pea (L00180).w
 movea.l D00028(a6),a0
 move.l 4026(a0),-(sp)
 movea.l D00028(a6),a0
 move.l 4038(a0),d1
 move.l #186,d0
 add.l D00028(a6),d0
 bsr.w L0f204
 addq.l #8,sp
 movea.l D00028(a6),a0
 move.w #240,4766(a0)
 pea L0fc10(pc)
 lea L0fa16(pc),a0
 move.l a0,d1
 move.l 4(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
 movem.l -4(a5),a0
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 pea (L00300).w
 movea.l D00028(a6),a0
 move.l 4030(a0),-(sp)
 move.l #384,d1
 movea.l D00028(a6),a0
 move.l 4038(a0),d0
 bsr.w L0f1c6
 addq.l #8,sp
 pea (L00300).w
 movea.l D00028(a6),a0
 pea 4042(a0)
 movea.l D00028(a6),a0
 move.l 4030(a0),d1
 movea.l D00028(a6),a0
 move.l 4762(a0),d0
 bsr.w L0f204
 addq.l #8,sp
 move.l _01ac8(a6),-(sp)
 lea L0f5ea(pc),a0
 move.l a0,d1
 moveq #0,d0
 jsr _016a6(a6)
 addq.l #4,sp
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 pea (L00300).w
 movea.l D00028(a6),a0
 move.l 4030(a0),-(sp)
 move.l #384,d1
 movea.l D00028(a6),a0
 move.l 4038(a0),d0
 bsr.w L0f1c6
 addq.l #8,sp
 pea (L00300).w
 movea.l D00028(a6),a0
 pea 4042(a0)
 movea.l D00028(a6),a0
 move.l 4030(a0),d1
 move.l #186,d0
 add.l D00028(a6),d0
 bsr.w L0f204
 addq.l #8,sp
 move.l _01ac8(a6),-(sp)
 lea L0f502(pc),a0
 move.l a0,d1
 moveq #0,d0
 jsr _016a6(a6)
 addq.l #4,sp
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 pea (L00300).w
 movea.l D00028(a6),a0
 move.l 4030(a0),-(sp)
 move.l #384,d1
 movea.l D00028(a6),a0
 move.l 4038(a0),d0
 bsr.w L0f1c6
 addq.l #8,sp
 pea (L00300).w
 movea.l D00028(a6),a0
 pea 4042(a0)
 movea.l D00028(a6),a0
 move.l 4030(a0),d1
 move.l #186,d0
 add.l D00028(a6),d0
 bsr.w L0f204
 addq.l #8,sp
 move.l _01ac8(a6),-(sp)
 lea L0f502(pc),a0
 move.l a0,d1
 moveq #0,d0
 jsr _016a6(a6)
 addq.l #4,sp
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 pea (L00300).w
 movea.l D00028(a6),a0
 move.l 4034(a0),-(sp)
 move.l #384,d1
 movea.l D00028(a6),a0
 move.l 4038(a0),d0
 bsr.w L0f1c6
 addq.l #8,sp
 pea (L00300).w
 movea.l D00028(a6),a0
 pea 4042(a0)
 movea.l D00028(a6),a0
 move.l 4034(a0),d1
 move.l #186,d0
 add.l D00028(a6),d0
 bsr.w L0f204
 addq.l #8,sp
 move.l _01ac8(a6),-(sp)
 lea L0f502(pc),a0
 move.l a0,d1
 moveq #0,d0
 jsr _016a6(a6)
 addq.l #4,sp
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D00028(a6),a0
 tst.w 100(a0)
 beq.s L0febe
 pea (L00003).w
 pea (L00002).w
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 moveq #63,d1
 moveq #82,d0
 add.l D00028(a6),d0
 bsr.w L13f56
 lea 20(sp),sp
 pea (L00003).w
 pea (L00002).w
 clr.l -(sp)
 move.l _01ac8(a6),-(sp)
 clr.l -(sp)
 movea.l D00028(a6),a0
 movea.w 5576(a0),a0
 move.l a0,d1
 moveq #122,d0
 add.l D00028(a6),d0
 bsr.w L13f56
 lea 20(sp),sp
 bra.s L0fece
L0febe clr.l -(sp)
 movea.l _01ac8(a6),a0
 move.l a0,d1
 moveq #0,d0
 jsr _016a6(a6)
 addq.l #4,sp
L0fece movem.l -8(a5),a0/d1
 unlk a5
 rts 
L0fed8 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D0008a(a6),a0
 move.l 48(a0),-(sp)
 movea.l D0008a(a6),a0
 move.l 44(a0),d1
 move.l 4(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L0ff04 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D00028(a6),a0
 tst.w 60(a0)
 beq.s L0ff2c
 move.l 4(sp),-(sp)
 lea L0ff04(pc),a0
 move.l a0,d1
 move.l 4(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
 bra.s L0ff88
L0ff2c pea (L00001).w
 pea (L00002).w
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 moveq #63,d1
 moveq #82,d0
 add.l D00028(a6),d0
 bsr.w L13f56
 lea 20(sp),sp
 pea (L00001).w
 pea (L00002).w
 clr.l -(sp)
 pea L0fed8(pc)
 clr.l -(sp)
 moveq #63,d1
 moveq #122,d0
 add.l D00028(a6),d0
 bsr.w L13f56
 lea 20(sp),sp
 movea.l D00028(a6),a0
 addi.w #$0014,5106(a0)
 movea.l D00028(a6),a0
 addq.w #2,5566(a0)
 movea.l D00028(a6),a0
 addq.w #2,5568(a0)
 jsr _01ad8(a6)
L0ff88 movem.l -4(a5),a0
 unlk a5
 rts 
L0ff92 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 lea -44(sp),sp
 moveq #82,d0
 add.l D00028(a6),d0
 move.l d0,40(sp)
 moveq #122,d0
 add.l D00028(a6),d0
 move.l d0,36(sp)
 moveq #52,d0
 add.l D0008a(a6),d0
 move.l d0,32(sp)
 moveq #76,d0
 add.l D0008a(a6),d0
 move.l d0,d1
 lea (sp),a0
 move.l a0,d0
 jsr _017f6(a6)
 lea L1092e(pc),a0
 move.l a0,d1
 lea (sp),a0
 move.l a0,d0
 jsr _01a72(a6)
 movea.l 32(sp),a0
 move.l 40(sp),(a0)
 movea.l 32(sp),a0
 move.l 36(sp),4(a0)
 movea.l 32(sp),a0
 move.w #1,8(a0)
 movea.l D0008a(a6),a0
 movea.l 40(sp),a1
 move.l 18(a0),4(a1)
 movea.l D0008a(a6),a0
 movea.l 36(sp),a1
 move.l 12(a0),4(a1)
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 move.l 48(sp),d1
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L1002a
 moveq #1,d0
 bra.s L1002c
L1002a moveq #0,d0
L1002c lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 bsr.w L139e4
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 move.l 44(sp),d1
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L10054
 moveq #1,d0
 bra.s L10056
L10054 moveq #0,d0
L10056 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 bsr.w L139e4
 addq.l #8,sp
 pea (L00005).w
 pea (L00005).w
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L1007c
 moveq #1,d0
 bra.s L1007e
L1007c moveq #0,d0
L1007e lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 move.l D00028(a6),d0
 bsr.w L13aa2
 addq.l #8,sp
 clr.l -(sp)
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L100a2
 moveq #1,d0
 bra.s L100a4
L100a2 moveq #0,d0
L100a4 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 move.l D00028(a6),d0
 bsr.w L13d72
 addq.l #4,sp
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L100c6
 moveq #1,d0
 bra.s L100c8
L100c6 moveq #0,d0
L100c8 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 moveq #1,d0
 bsr.w L13e0c
L100d8 pea (L00001).w
 moveq #1,d1
 movea.l D00028(a6),a0
 move.l 182(a0),d0
 jsr _016f4(a6)
 addq.l #4,sp
 moveq #1,d1
 cmp.l d0,d1
 bne.s L100d8
 move.l D00028(a6),d0
 bsr.w L13af4
 movea.l D0008a(a6),a0
 pea 52(a0)
 pea L109ce(pc)
 move.l #94080,-(sp)
 movea.l D0008a(a6),a0
 move.l 18(a0),-(sp)
 move.l #5670,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5648,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 movea.l D0008a(a6),a0
 pea 52(a0)
 pea L109ce(pc)
 move.l #94080,-(sp)
 movea.l D0008a(a6),a0
 move.l 12(a0),-(sp)
 move.l #5648,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5670,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #5648,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 bsr.w L14c64
 addq.l #8,sp
 lea L0ff04(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6396(a1)
 movea.l D00028(a6),a0
 clr.l 6400(a0)
 lea (sp),a0
 move.l a0,d1
 move.l #6222,d0
 add.l D00028(a6),d0
 bsr.w L15c48
 moveq #1,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 bsr.w L14aa8
 lea 44(sp),sp
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L101ce link.w a5,#0
 movem.l d0-d1,-(sp)
 move.w #1,D00056(a6)
 unlk a5
 rts 
L101e0 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 subq.l #4,sp
 moveq #122,d0
 add.l D00028(a6),d0
 move.l d0,(sp)
 movea.l D0008a(a6),a0
 addq.w #1,16(a0)
 movea.l D0008a(a6),a0
 addq.w #1,42(a0)
 movea.l D0008a(a6),a0
 move.w 16(a0),d0
 ext.l d0
 lsl.l #2,d0
 movea.l D0008a(a6),a0
 movea.l (sp),a1
 move.l 4(a0,d0.l),4(a1)
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 move.l 8(sp),d1
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L10232
 moveq #1,d0
 bra.s L10234
L10232 moveq #0,d0
L10234 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 bsr.w L139e4
 addq.l #8,sp
 movea.l D0008a(a6),a0
 move.w 42(a0),d0
 ext.l d0
 lsl.l #2,d0
 movea.l D0008a(a6),a0
 movea.l 30(a0,d0.l),a0
 pea 4(a0)
 pea (L00080).w
 clr.l -(sp)
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L10270
 moveq #1,d0
 bra.s L10272
L10270 moveq #0,d0
L10272 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L1028a
 moveq #1,d0
 bra.s L1028c
L1028a moveq #0,d0
L1028c lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01a66(a6)
 lea 16(sp),sp
L102a6 pea (L00001).w
 moveq #1,d1
 movea.l D00028(a6),a0
 move.l 182(a0),d0
 jsr _016f4(a6)
 addq.l #4,sp
 moveq #1,d1
 cmp.l d0,d1
 bne.s L102a6
 move.l D00028(a6),d0
 bsr.w L13af4
 lea L101ce(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6404(a1)
 movea.l D00028(a6),a0
 clr.l 6408(a0)
 addq.l #4,sp
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L102e8 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 movea.l D0008a(a6),a0
 move.w 42(a0),d0
 ext.l d0
 lsl.l #2,d0
 movea.l D0008a(a6),a0
 movea.l 30(a0,d0.l),a0
 pea 4(a0)
 pea (L00080).w
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 jsr _01a66(a6)
 lea 16(sp),sp
 movea.l D0008a(a6),a0
 move.l 22(a0),-(sp)
 pea L0e580(pc)
 move.l #94080,-(sp)
 movea.l D0008a(a6),a0
 move.l 22(a0),-(sp)
 move.l #5670,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5648,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 movea.l D0008a(a6),a0
 move.l 26(a0),-(sp)
 pea L0e580(pc)
 move.l #94080,-(sp)
 movea.l D0008a(a6),a0
 move.l 26(a0),-(sp)
 move.l #5692,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5670,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 movea.l D0008a(a6),a0
 move.l 18(a0),-(sp)
 pea L0e580(pc)
 move.l #94080,-(sp)
 movea.l D0008a(a6),a0
 move.l 18(a0),-(sp)
 move.l #5648,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5692,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 lea L101ce(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6404(a1)
 movea.l D00028(a6),a0
 clr.l 6408(a0)
 lea L0ff92(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6396(a1)
 movea.l D00028(a6),a0
 clr.l 6400(a0)
 moveq #76,d0
 add.l D0008a(a6),d0
 move.l d0,d1
 move.l #6222,d0
 add.l D00028(a6),d0
 bsr.w L15c48
 moveq #1,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 bsr.w L14aa8
 pea (L00001).w
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 pea (L0003f).w
 moveq #0,d1
 moveq #82,d0
 add.l D00028(a6),d0
 bsr.w L13f56
 lea 20(sp),sp
 pea (L00001).w
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 pea (L0003f).w
 moveq #0,d1
 moveq #122,d0
 add.l D00028(a6),d0
 bsr.w L13f56
 lea 20(sp),sp
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 lea -44(sp),sp
 moveq #82,d0
 add.l D00028(a6),d0
 move.l d0,40(sp)
 moveq #122,d0
 add.l D00028(a6),d0
 move.l d0,36(sp)
 move.l 92(sp),D0008a(a6)
 pea (L0005a).w
 moveq #0,d1
 move.l D0008a(a6),d0
 jsr _016ac(a6)
 addq.l #4,sp
 move.l 44(sp),d1
 moveq #76,d0
 add.l D0008a(a6),d0
 jsr _017f6(a6)
 move.l 44(sp),d1
 lea 4(sp),a0
 move.l a0,d0
 jsr _017f6(a6)
 lea L10931(pc),a0
 move.l a0,d1
 lea 4(sp),a0
 move.l a0,d0
 jsr _01a72(a6)
 movea.l D0008a(a6),a0
 move.l 48(sp),4(a0)
 movea.l D0008a(a6),a0
 move.l 68(sp),8(a0)
 movea.l D0008a(a6),a0
 move.l 72(sp),12(a0)
 movea.l D0008a(a6),a0
 clr.w 16(a0)
 movea.l D0008a(a6),a0
 move.l 76(sp),18(a0)
 move.l #30576,d0
 add.l 76(sp),d0
 movea.l D0008a(a6),a0
 move.l d0,22(a0)
 move.l #61152,d0
 add.l 76(sp),d0
 movea.l D0008a(a6),a0
 move.l d0,26(a0)
 movea.l D0008a(a6),a0
 move.l 80(sp),30(a0)
 movea.l D0008a(a6),a0
 move.l 84(sp),34(a0)
 movea.l D0008a(a6),a0
 move.l 88(sp),38(a0)
 movea.l D0008a(a6),a0
 clr.w 42(a0)
 movea.l D0008a(a6),a0
 move.l 96(sp),44(a0)
 movea.l D0008a(a6),a0
 move.l 100(sp),48(a0)
 movea.l 40(sp),a0
 move.l 76(sp),4(a0)
 movea.l 36(sp),a0
 move.l 48(sp),4(a0)
 movea.l 40(sp),a0
 move.l #16711935,8(a0)
 bsr.w L14194
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 bsr.w L140a6
 moveq #1,d1
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L105c0
 moveq #1,d0
 bra.s L105c2
L105c0 moveq #0,d0
L105c2 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 bsr.w L140a6
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #0,d1
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 bsr.w L1398c
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 bsr.w L1398c
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 pea (L0003f).w
 moveq #0,d1
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L1062c
 moveq #1,d0
 bra.s L1062e
L1062c moveq #0,d0
L1062e lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 bsr.w L1398c
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 pea (L0003f).w
 moveq #1,d1
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L10656
 moveq #1,d0
 bra.s L10658
L10656 moveq #0,d0
L10658 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 bsr.w L1398c
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 move.l 48(sp),d1
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 bsr.w L139e4
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 move.l 44(sp),d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 bsr.w L139e4
 addq.l #8,sp
 pea (L00005).w
 pea (L00003).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 move.l D00028(a6),d0
 bsr.w L13aa2
 addq.l #8,sp
 pea (L00001).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 move.l D00028(a6),d0
 bsr.w L13d72
 addq.l #4,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 move.l 48(sp),d1
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L10710
 moveq #1,d0
 bra.s L10712
L10710 moveq #0,d0
L10712 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 bsr.w L139e4
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 move.l 44(sp),d1
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L1073a
 moveq #1,d0
 bra.s L1073c
L1073a moveq #0,d0
L1073c lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 bsr.w L139e4
 addq.l #8,sp
 pea (L00005).w
 pea (L00003).w
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L10762
 moveq #1,d0
 bra.s L10764
L10762 moveq #0,d0
L10764 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 move.l D00028(a6),d0
 bsr.w L13aa2
 addq.l #8,sp
 pea (L00001).w
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L1078a
 moveq #1,d0
 bra.s L1078c
L1078a moveq #0,d0
L1078c lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 move.l D00028(a6),d0
 bsr.w L13d72
 addq.l #4,sp
 clr.l -(sp)
 clr.l -(sp)
 pea (L00800).w
 move.l 92(sp),-(sp)
 move.l #5978,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5956,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 pea (L00800).w
 move.l 96(sp),-(sp)
 move.l #6000,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5978,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 pea (L00800).w
 move.l 100(sp),-(sp)
 moveq #0,d1
 move.l #6000,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 move.l 88(sp),-(sp)
 move.l #5670,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5648,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 move.l 60(sp),-(sp)
 move.l #5692,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5670,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
L10870 move.l #94080,-(sp)
 move.l 80(sp),-(sp)
 move.l #5714,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5692,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #94080,-(sp)
 move.l 84(sp),-(sp)
 moveq #0,d1
 move.l #5714,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 movea.l D00028(a6),a0
 pea 5956(a0)
 clr.l -(sp)
 move.l #5648,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 bsr.w L14c64
 addq.l #8,sp
 lea L102e8(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6396(a1)
 movea.l D00028(a6),a0
 clr.l 6400(a0)
 andi.w #$feff,_011ba(a6)
 lea 4(sp),a0
 move.l a0,d1
 move.l #6222,d0
 add.l D00028(a6),d0
 bsr.w L15c48
 move.l d0,(sp)
 moveq #1,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 bsr.w L14aa8
 lea 44(sp),sp
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L1092e subq.b #7,95(a2,d0.w)
L10931 equ *-1
 dc.w $6900
L10934 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 moveq #0,d0
 bsr.w L13e0c
 movea.l 4(sp),a0
 tst.l 10(a0)
 beq.s L1097a
 movea.l 4(sp),a0
 move.l 14(a0),-(sp)
 movea.l 8(sp),a0
 move.l 10(a0),d1
 move.l 4(sp),d0
 jsr _016a6(a6)
 addq.l #4,sp
L1097a movem.l -4(a5),a0
 unlk a5
 rts 
L10984 link.w a5,#0
 movem.l a0/a2/d0-d1,-(sp)
 movea.l 4(sp),a0
 movea.l (a0),a2
 movea.l 4(sp),a0
 cmpi.w #1,8(a0)
 bne.s L109a6
 movea.l 4(sp),a0
 movea.l 4(a0),a2
L109a6 pea (L00001).w
 pea (L00002).w
 move.l 12(sp),-(sp)
 pea L10934(pc)
 clr.l -(sp)
 moveq #63,d1
 move.l a2,d0
 bsr.w L13f56
 lea 20(sp),sp
 movem.l -8(a5),a0/a2
 unlk a5
 rts 
L109ce link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 subq.l #4,sp
 movea.l 8(sp),a0
 move.l 16(a0),(sp)
 movea.l (sp),a0
 tst.w 8(a0)
 bne.s L10a00
 clr.l -(sp)
 clr.l -(sp)
 pea (L00003).w
 movea.l 12(sp),a0
 move.l 4(a0),d1
 movea.l 12(sp),a0
 move.l (a0),d0
 bra.s L10a16
L10a00 clr.l -(sp)
 clr.l -(sp)
 pea (L00003).w
 movea.l 12(sp),a0
 move.l (a0),d1
 movea.l 12(sp),a0
 move.l 4(a0),d0
L10a16 bsr.w L1401a
 lea 12(sp),sp
 movea.l (sp),a0
 tst.w 8(a0)
 bne.s L10a2a
 moveq #1,d0
 bra.s L10a2c
L10a2a moveq #0,d0
L10a2c movea.l (sp),a0
 move.w d0,8(a0)
 movea.l (sp),a0
 addq.w #1,18(a0)
 movea.l (sp),a0
 movea.l (sp),a1
 move.w 18(a1),d0
 cmp.w 20(a0),d0
 blt.s L10a80
 movea.l (sp),a0
 tst.w 20(a0)
 beq.s L10a80
 pea (Lffffffffffffffff).w
 movea.l D00028(a6),a0
 move.l 6780(a0),d1
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _01718(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _019a6(a6)
 movea.l D00028(a6),a0
 movea.l 6780(a0),a0
 clr.l 26(a0)
L10a80 addq.l #4,sp
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L10a8c link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 movea.l 4(sp),a0
 tst.w 22(a0)
 beq.s L10b00
 movea.l D00028(a6),a0
 clr.w 9824(a0)
 movea.l D00028(a6),a0
 move.w #1,9826(a0)
 movea.l 4(sp),a0
 movea.l D00028(a6),a1
 move.l 10(a0),9828(a1)
 movea.l 4(sp),a0
 movea.l D00028(a6),a1
 move.l 14(a0),9832(a1)
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.l 6780(a0),d1
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _01718(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 move.l 4(a0),d0
 jsr _0171e(a6)
 lea _00ff0(a6),a0
 movea.l D00028(a6),a1
 movea.l 6780(a1),a1
 move.l a0,26(a1)
L10b00 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L10b0a link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 subq.l #4,sp
 movea.l 8(sp),a0
 move.l 16(a0),(sp)
 pea (L00003).w
 clr.l -(sp)
 move.l 8(sp),-(sp)
 pea L10a8c(pc)
 pea (L0003f).w
 moveq #0,d1
 movea.l 20(sp),a0
 move.l (a0),d0
 bsr.w L13f56
 lea 20(sp),sp
 movea.l (sp),a0
 addq.w #1,18(a0)
 addq.l #4,sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L10b50 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 movea.l D00028(a6),a0
 move.l 28(sp),9850(a0)
 movea.l D00028(a6),a0
 move.l 32(sp),9854(a0)
 moveq #82,d0
 add.l D00028(a6),d0
 movea.l D00028(a6),a0
 move.l d0,9840(a0)
 moveq #122,d0
 add.l D00028(a6),d0
 movea.l D00028(a6),a0
 move.l d0,9844(a0)
 movea.l D00028(a6),a0
 movea.l 9840(a0),a0
 move.l 4(sp),4(a0)
 movea.l D00028(a6),a0
 movea.l 9844(a0),a0
 move.l 24(sp),4(a0)
 movea.l D00028(a6),a0
 clr.w 9848(a0)
 movea.l D00028(a6),a0
 clr.w 9858(a0)
 movea.l D00028(a6),a0
 move.w 38(sp),9860(a0)
 movea.l D00028(a6),a0
 move.w 42(sp),9862(a0)
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #0,d1
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 bsr.w L1398c
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 moveq #1,d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 bsr.w L1398c
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.l 9840(a0),d1
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d0
 bsr.w L139e4
 addq.l #8,sp
 move.l D00028(a6),-(sp)
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.l 9844(a0),d1
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d0
 bsr.w L139e4
 addq.l #8,sp
 pea (L00005).w
 pea (L00005).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 move.l D00028(a6),d0
 bsr.w L13aa2
 addq.l #8,sp
 movea.l D00028(a6),a0
 pea 9840(a0)
 pea L10b0a(pc)
 move.l #94080,-(sp)
 move.l 16(sp),-(sp)
 move.l #5670,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5648,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 movea.l D00028(a6),a0
 pea 9840(a0)
 pea L109ce(pc)
 move.l #94080,-(sp)
 move.l 36(sp),-(sp)
 move.l #5692,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5670,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 movea.l D00028(a6),a0
 pea 9840(a0)
 pea L109ce(pc)
 move.l #94080,-(sp)
 move.l 16(sp),-(sp)
 move.l #5670,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #5692,d0
 add.l D00028(a6),d0
 bsr.w L14bea
 lea 16(sp),sp
 clr.l -(sp)
 clr.l -(sp)
 move.l #5648,d0
 add.l D00028(a6),d0
 move.l d0,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 bsr.w L14c64
 addq.l #8,sp
 lea L10984(pc),a0
 movea.l D00028(a6),a1
 move.l a0,6396(a1)
 move.l #9840,d0
 add.l D00028(a6),d0
 movea.l D00028(a6),a0
 move.l d0,6400(a0)
 move.l (sp),d1
 move.l #6222,d0
 add.l D00028(a6),d0
 bsr.w L15c48
 moveq #1,d1
 move.l #6176,d0
 add.l D00028(a6),d0
 bsr.w L14aa8
 moveq #0,d0
 jsr _01712(a6)
 moveq #1,d0
 jsr _01712(a6)
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L10d92 link.w a5,#0
 movem.l a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.w #384,d0
 muls.w 46(a2),d0
 move.w 44(a2),d1
 ext.l d1
 add.l d1,d0
 move.l d0,2(a3)
 movem.l -8(a5),a2-a3
 unlk a5
 rts 
L10dbc link.w a5,#0
 movem.l a2-a4/d0-d1,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 movea.l 46(a3),a4
 addq.w #1,40(a3)
 move.w 40(a3),d0
 cmp.w 20(a2),d0
 blt.s L10df2
 clr.w 40(a3)
 addq.b #1,28(a4)
 move.b 28(a4),d0
 ext.w d0
 cmp.w 16(a2),d0
 blt.s L10df2
 clr.b 28(a4)
L10df2 move.b 28(a4),d0
 ext.w d0
 ext.l d0
 move.b (a2,d0.l),d0
 ext.w d0
 move.w d0,38(a3)
 move.l a4,d0
 jsr _01b14(a6)
 movem.l -12(a5),a2-a4
 unlk a5
 rts 
L10e14 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 movea.l (a2),a4
 move.l (a3),d4
 movea.l d4,a0
 move.w 18(a0),d0
 sub.w 16(a4),d0
 move.w d0,d5
 tst.w d5
 bge.s L10e36
 moveq #0,d5
L10e36 movea.l d4,a0
 moveq #0,d0
 move.w 40(a0),d0
 lsr.l #8,d0
 move.w 38(a4),d1
 ext.l d1
 cmp.l d1,d0
 bne.s L10e56
 movea.l d4,a0
 move.w #255,d0
 and.w 40(a0),d0
 add.w d0,d5
L10e56 tst.w d5
 ble.s L10e68
 sub.w d5,34(a2)
 tst.w 34(a2)
 bge.s L10e68
 clr.w 34(a2)
L10e68 movem.l -24(a5),a0/a2-a4/d4-d5
 unlk a5
 rts 
L10e72 link.w a5,#0
 movem.l a0/a2-a4/d0/d4-d5,-(sp)
 movea.l d0,a2
 subq.l #4,sp
 movea.l D00028(a6),a0
 movea.l 4826(a0),a3
 moveq #24,d0
 add.l 4(a2),d0
 movea.l d0,a4
 moveq #0,d5
 bra.s L10ef8
L10e92 move.w (a4),d0
 add.w 44(a2),d0
 move.w d0,(sp)
 move.w 2(a4),d0
 add.w 46(a2),d0
 move.w d0,2(sp)
 movea.l D00028(a6),a0
 movea.l 4826(a0),a3
 moveq #0,d4
 bra.s L10ee4
L10eb2 move.w (sp),d0
 cmp.w (a3),d0
 blt.s L10edc
 move.w (sp),d0
 cmp.w 4(a3),d0
 bgt.s L10edc
 move.w 2(sp),d0
 cmp.w 2(a3),d0
 blt.s L10edc
 move.w 2(sp),d0
 cmp.w 6(a3),d0
 bgt.s L10edc
 move.w 8(a3),d0
 ext.l d0
 bra.s L10f00
L10edc addq.l #1,d4
 adda.l #10,a3
L10ee4 movea.l D00028(a6),a0
 movea.l 4822(a0),a0
 moveq #0,d0
 move.w (a0),d0
 cmp.l d4,d0
 bgt.s L10eb2
 addq.l #1,d5
 addq.l #4,a4
L10ef8 moveq #3,d0
 cmp.l d5,d0
 bgt.s L10e92
 moveq #255,d0
L10f00 addq.l #4,sp
 movem.l -24(a5),a0/a2-a4/d4-d5
 unlk a5
 rts 
L10f0c link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d6,-(sp)
 movea.l d0,a2
 subq.l #6,sp
 movea.l 12(a2),a3
 movea.l (a2),a4
 moveq #22,d0
 add.l a4,d0
 move.l d0,d5
 moveq #44,d0
 add.l a2,d0
 move.l d0,2(sp)
 move.l a3,d1
 move.l a2,d0
 bsr.w L10d92
 movea.l 2(sp),a0
 move.w (a0),d0
 ext.l d0
 move.w 2(a4),d1
 ext.l d1
 add.l d1,d0
 cmpi.l #374,d0
 bgt.s L10f7a
 movea.l 2(sp),a0
 cmpi.w #10,2(a0)
 blt.s L10f7a
 movea.l 2(sp),a0
 move.w 2(a0),d0
 ext.l d0
 move.w (a4),d1
 ext.l d1
 add.l d1,d0
 cmpi.l #230,d0
 bgt.s L10f7a
 movea.l 2(sp),a0
 cmpi.w #10,(a0)
 bge.s L10f8e
L10f7a move.w 12(sp),d0
 sub.w d0,44(a2)
 move.w 52(sp),d0
 sub.w d0,46(a2)
 moveq #1,d0
 bra.s L10ffc
L10f8e moveq #0,d4
 bra.s L10ff4
L10f92 movea.l d5,a0
 andi.w #$fffe,(a0)
 movea.l D00028(a6),a0
 move.l 4792(a0),d0
 add.l 2(a3),d0
 movea.l d5,a0
 move.w (a0),d1
 ext.l d1
 add.l d1,d0
 movea.l d5,a0
 move.w #384,d1
 muls.w 2(a0),d1
 add.l d1,d0
 move.l d0,d6
 movea.l d6,a0
 move.w (a0),d0
 lsr.w #8,d0
 move.b d0,1(sp)
 cmpi.b #5,1(sp)
 beq.s L10fdc
 cmpi.b #6,1(sp)
 blt.s L10ff0
 cmpi.w #4,34(a4)
 beq.s L10ff0
L10fdc move.w 12(sp),d0
 sub.w d0,44(a2)
 move.w 52(sp),d0
 sub.w d0,46(a2)
 moveq #2,d0
 bra.s L10ffc
L10ff0 addq.l #1,d4
 addq.l #4,d5
L10ff4 moveq #2,d0
 cmp.l d4,d0
 bgt.s L10f92
 moveq #0,d0
L10ffc addq.l #6,sp
 movem.l -28(a5),a0/a2-a4/d4-d6
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l 48(sp),d5
 movea.l 52(sp),a3
 lea -30(sp),sp
 movea.l 46(a2),a4
 movea.l D00028(a6),a0
 move.l 178(a0),4(sp)
 move.l 4(a4),d7
 moveq #0,d0
 move.w 38(a4),d0
 lsl.l #2,d0
 lea _01092(a6),a0
 move.l (a0,d0.l),(sp)
 move.l a4,d0
 bsr.w L10e72
 move.l d0,d6
 adda.l d4,a3
 move.l a3,12(sp)
 movea.l D00028(a6),a0
 move.l 4792(a0),d0
 add.l d4,d0
 movea.l d0,a3
 move.l a3,16(sp)
 move.w d5,d0
 ext.l d0
 lsl.l #2,d0
 movea.l d7,a0
 movea.l 68(a0),a0
 movea.l 4(a0),a0
 move.l (a0,d0.l),8(sp)
 move.b d6,24(sp)
 move.w 50(a4),d0
 ext.l d0
 lsl.l #2,d0
 movea.l (sp),a0
 move.l (a0,d0.l),26(sp)
 move.l #-16711936,20(sp)
 movea.l 4(sp),a0
 move.w 20(a0),d0
 ext.l d0
 lsl.l #2,d0
 move.l d7,16(a4,d0.l)
 moveq #255,d0
 cmp.l d6,d0
 bne.s L110b4
 lea 8(sp),a0
 move.l a0,d0
 bsr.w L179a4
 bra.s L110be
L110b4 lea 8(sp),a0
 move.l a0,d0
 bsr.w L17cea
L110be lea 30(sp),sp
 movem.l -32(a5),a0/a2-a4/d4-d7
 unlk a5
 rts 
L110cc link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 movea.l 44(sp),a3
 lea -26(sp),sp
 movea.l 46(a2),a4
 movea.l D00028(a6),a0
 move.l 178(a0),(sp)
 move.l 4(a4),d5
 move.l a4,d0
 bsr.w L10e72
 move.l d0,d4
 move.l 30(sp),d0
 adda.l d0,a3
 move.l a3,8(sp)
 movea.l D00028(a6),a0
 move.l 4792(a0),d0
 add.l 30(sp),d0
 movea.l d0,a3
 move.l a3,12(sp)
 move.w 68(sp),d0
 ext.l d0
 lsl.l #2,d0
 movea.l d5,a0
 movea.l 68(a0),a0
 movea.l 4(a0),a0
 move.l (a0,d0.l),4(sp)
 move.b d4,20(sp)
 movea.l (a4),a0
 move.w 44(a0),d0
 ext.l d0
 lsl.l #2,d0
 lea _010c4(a6),a0
 move.l (a0,d0.l),16(sp)
 movea.l (sp),a0
 move.w 20(a0),d0
 ext.l d0
 lsl.l #2,d0
 move.l d5,16(a4,d0.l)
 moveq #255,d0
 cmp.l d4,d0
 bne.s L11162
 lea 4(sp),a0
 move.l a0,d0
 bsr.w L17d44
 bra.s L1116c
L11162 lea 4(sp),a0
 move.l a0,d0
 bsr.w L17932
L1116c lea 26(sp),sp
 movem.l -24(a5),a0/a2-a4/d4-d5
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4,-(sp)
 movea.l d0,a2
 movea.l 40(sp),a3
 movea.l 46(a2),a4
 movea.l D00028(a6),a0
 move.l 178(a0),d4
 movea.l d4,a0
 move.w 20(a0),d0
 ext.l d0
 lsl.l #2,d0
 move.l 4(a4),16(a4,d0.l)
 movem.l -20(a5),a0/a2-a4/d4
 unlk a5
 rts 
L111ae link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4,-(sp)
 movea.l d0,a2
 movea.l 40(sp),a3
 lea -14(sp),sp
 movea.l 46(a2),a4
 move.l 58(sp),d0
 lsl.l #2,d0
 move.l 16(a4,d0.l),d4
 move.l 18(sp),d0
 adda.l d0,a3
 move.l a3,4(sp)
 move.w 52(sp),d0
 ext.l d0
 lsl.l #2,d0
 movea.l d4,a0
 movea.l 68(a0),a0
 movea.l 4(a0),a0
 move.l (a0,d0.l),(sp)
 movea.l D00028(a6),a0
 move.l 4792(a0),d0
 add.l 18(sp),d0
 movea.l d0,a3
 move.l a3,8(sp)
 lea (sp),a0
 move.l a0,d0
 bsr.w L17640
 lea 14(sp),sp
 movem.l -20(a5),a0/a2-a4/d4
 unlk a5
 rts 
L11216 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l 36(sp),d4
 move.l 40(sp),d5
 movea.l D00028(a6),a0
 move.w (a2),d0
 cmp.w 5590(a0),d0
 bgt.s L1125e
 movea.l D00028(a6),a0
 move.w 2(a2),d0
 cmp.w 5588(a0),d0
 blt.s L1125e
 movea.l D00028(a6),a0
 move.w 2(a2),d0
 cmp.w 5592(a0),d0
 bgt.s L1125e
 movea.l D00028(a6),a0
 move.w (a2),d0
 cmp.w 5586(a0),d0
 bge.s L1126c
L1125e move.w d4,d0
 sub.w d0,(a2)
 move.w d5,d0
 sub.w d0,2(a2)
 moveq #1,d0
 bra.s L1126e
L1126c moveq #0,d0
L1126e movem.l -20(a5),a0/a2-a3/d4-d5
 unlk a5
 rts 
L11278 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l 48(sp),d5
 movea.l 52(sp),a3
 lea _01032(a6),a0
 move.l a0,d0
 move.l d4,d1
 lsl.l #2,d1
 add.l d1,d0
 movea.l d0,a4
 moveq #44,d0
 add.l a2,d0
 move.l d0,d7
 moveq #0,d6
 bra.s L112ea
L112a4 move.w (a4),d0
 movea.l d7,a0
 add.w d0,(a0)
 move.w 2(a4),d0
 movea.l d7,a0
 add.w d0,2(a0)
 movea.l _01b04(a6),a0
 cmpa.l a3,a0
 bne.s L112d4
 movea.w 2(a4),a0
 move.l a0,-(sp)
 movea.w (a4),a0
 move.l a0,-(sp)
 move.l (a2),d1
 move.l d7,d0
 bsr.w L11216
 addq.l #8,sp
 tst.l d0
 bne.s L112ee
L112d4 movea.w 2(a4),a0
 move.l a0,-(sp)
 movea.w (a4),a0
 move.l a0,d1
 move.l a2,d0
 jsr (a3)
 addq.l #4,sp
 tst.l d0
 bne.s L112ee
 addq.l #1,d6
L112ea cmp.l d5,d6
 blt.s L112a4
L112ee movem.l -32(a5),a0/a2-a4/d4-d7
 unlk a5
 rts 
L112f8 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4-d5,-(sp)
 lea -12(sp),sp
 movea.l D00028(a6),a0
 movea.l 5018(a0),a0
 move.l (a0),4(sp)
 movea.l D00028(a6),a0
 moveq #44,d0
 add.l 5018(a0),d0
 movea.l d0,a2
 moveq #44,d0
 add.l 12(sp),d0
 movea.l d0,a3
 movea.l 12(sp),a0
 moveq #36,d0
 add.l 4(a0),d0
 move.l 16(sp),d1
 lsl.l #2,d1
 add.l d1,d0
 move.l d0,(sp)
 move.w (a3),d0
 ext.l d0
 movea.l (sp),a0
 move.w (a0),d1
 ext.l d1
 add.l d1,d0
 move.l d0,d4
 move.w 2(a3),d0
 ext.l d0
 movea.l (sp),a0
 move.w 2(a0),d1
 ext.l d1
 add.l d1,d0
 move.l d0,d5
 move.w (a2),d0
 movea.l 4(sp),a0
 add.w 2(a0),d0
 subi.w #20,d0
 move.w d0,8(sp)
 move.w 2(a2),d0
 movea.l 4(sp),a0
 add.w (a0),d0
 subi.w #14,d0
 move.w d0,10(sp)
 move.w (a2),d0
 ext.l d0
 moveq #22,d1
 add.l d1,d0
 cmp.l d4,d0
 bge.s L113ae
 move.w 8(sp),d0
 ext.l d0
 cmp.l d4,d0
 ble.s L113ae
 move.w 2(a2),d0
 ext.l d0
 moveq #12,d1
 add.l d1,d0
 cmp.l d5,d0
 bge.s L113ae
 move.w 10(sp),d0
 ext.l d0
 cmp.l d5,d0
 ble.s L113ae
 moveq #1,d0
 bra.s L113b0
L113ae moveq #0,d0
L113b0 lea 12(sp),sp
 movem.l -20(a5),a0/a2-a3/d4-d5
 unlk a5
 rts 
L113be link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4,-(sp)
 subq.l #6,sp
 movea.l 6(sp),a0
 move.l 4(a0),2(sp)
 moveq #36,d0
 add.l 2(sp),d0
 movea.l d0,a2
 movea.l 6(sp),a0
 movea.l 12(a0),a4
 moveq #0,d4
 bra.s L11428
L113e6 move.l 2(a4),d0
 add.l 10(sp),d0
 move.w (a2),d1
 ext.l d1
 add.l d1,d0
 move.w #384,d1
 muls.w 2(a2),d1
 add.l d1,d0
 movea.l d0,a3
 moveq #232,d0
 add.b (a3),d0
 move.b d0,1(sp)
 cmpi.b #48,1(sp)
 bcc.s L11424
 move.l d4,d1
 move.l 6(sp),d0
 bsr.w L112f8
 moveq #1,d1
 cmp.l d0,d1
 bne.s L11424
 moveq #1,d0
 bra.s L11438
L11424 addq.l #1,d4
 addq.l #4,a2
L11428 movea.l 2(sp),a0
 move.w 22(a0),d0
 ext.l d0
 cmp.l d4,d0
 bgt.s L113e6
 moveq #0,d0
L11438 addq.l #6,sp
 movem.l -20(a5),a0/a2-a4/d4
 unlk a5
 rts 
L11444 link.w a5,#0
 movem.l a2-a3/d0-d1/d4-d5,-(sp)
 move.l d0,d4
 move.l d1,d5
 movea.l 32(sp),a2
 movea.l 36(sp),a3
 cmp.w (a2),d4
 blt.s L1148e
 cmp.w 2(a2),d5
 blt.s L1148e
 move.w (a2),d0
 ext.l d0
 move.w 2(a3),d1
 ext.l d1
 add.l d1,d0
 move.w d4,d1
 ext.l d1
 cmp.l d1,d0
 blt.s L1148e
 move.w 2(a2),d0
 ext.l d0
 move.w (a3),d1
 ext.l d1
 add.l d1,d0
 move.w d5,d1
 ext.l d1
 cmp.l d1,d0
 blt.s L1148e
 moveq #1,d0
 bra.s L11490
L1148e moveq #0,d0
L11490 movem.l -16(a5),a2-a3/d4-d5
 unlk a5
 rts 
L1149a link.w a5,#0
 movem.l a0/a2-a4/d0-d2/d4-d6,-(sp)
 movea.l d0,a2
 subq.l #2,sp
 moveq #44,d0
 add.l a2,d0
 movea.l d0,a3
 movea.l D00028(a6),a0
 movea.l 6788(a0),a4
 move.l (a2),d6
 clr.w (sp)
 moveq #0,d4
 bra.w L11576
L114be move.l 12(a4),d5
 tst.l d5
 beq.w L1156e
 cmpa.l a2,a4
 beq.w L1156e
 cmpi.w #4,26(a4)
 bne.w L1156e
 move.l (a4),-(sp)
 pea 44(a4)
 movea.w 2(a3),a0
 move.l a0,d1
 movea.w (a3),a0
 move.l a0,d0
 bsr.w L11444
 addq.l #8,sp
 tst.l d0
 bne.s L11568
 move.l (a4),-(sp)
 pea 44(a4)
 movea.w 2(a3),a0
 move.l a0,d1
 move.w (a3),d0
 ext.l d0
 movea.l d6,a0
 move.w 2(a0),d2
 ext.l d2
 add.l d2,d0
 bsr.w L11444
 addq.l #8,sp
 tst.l d0
 bne.s L11568
 move.l (a4),-(sp)
 pea 44(a4)
 move.w 2(a3),d0
 ext.l d0
 movea.l d6,a0
 move.w (a0),d1
 ext.l d1
 add.l d1,d0
 move.l d0,d1
 movea.w (a3),a0
 move.l a0,d0
 bsr.w L11444
 addq.l #8,sp
 tst.l d0
 bne.s L11568
 move.l (a4),-(sp)
 pea 44(a4)
 move.w 2(a3),d0
 ext.l d0
 movea.l d6,a0
 move.w (a0),d1
 ext.l d1
 add.l d1,d0
 move.l d0,d1
 move.w (a3),d0
 ext.l d0
 movea.l d6,a0
 move.w 2(a0),d2
 ext.l d2
 add.l d2,d0
 bsr.w L11444
 addq.l #8,sp
 tst.l d0
 beq.s L1156e
L11568 move.w #1,(sp)
 bra.s L11586
L1156e addq.l #1,d4
 adda.l #54,a4
L11576 movea.l D00028(a6),a0
 move.w 6796(a0),d0
 ext.l d0
 cmp.l d4,d0
 bgt.w L114be
L11586 tst.w (sp)
 beq.s L11598
 move.w 8(sp),d0
 sub.w d0,(a3)
 move.w 52(sp),d0
 sub.w d0,2(a3)
L11598 move.w (sp),d0
 ext.l d0
 addq.l #2,sp
 movem.l -32(a5),a0/a2-a4/d2/d4-d6
 unlk a5
 rts 
L115a8 link.w a5,#0
 movem.l a0/a2/d0-d1,-(sp)
 movea.l (sp),a0
 movea.l 46(a0),a2
 tst.l 4(sp)
 bne.s L115f2
 move.l a2,d1
 moveq #1,d0
 jsr _01b20(a6)
 movea.l D00028(a6),a0
 clr.w 5614(a0)
 move.b #1,48(a2)
 movea.l D00028(a6),a0
 move.w #1,5570(a0)
 pea (L00001).w
 lea L115a8(pc),a0
 move.l a0,d1
 move.l 4(sp),d0
 bsr.w L17982
 addq.l #4,sp
 bra.s L11606
L115f2 clr.l -(sp)
 moveq #0,d1
 move.l 4(sp),d0
 bsr.w L17982
 addq.l #4,sp
 movea.l (sp),a0
 clr.l 22(a0)
L11606 movem.l -8(a5),a0/a2
 unlk a5
 rts 
L11610 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
 movea.l 46(a2),a3
 move.l d4,d0
 lsl.l #1,d0
 lea _01062(a6),a0
 move.w (a0,d0.l),d0
 add.w d0,44(a3)
 move.l d4,d0
 lsl.l #1,d0
 lea _0106a(a6),a0
 move.w (a0,d0.l),d0
 add.w d0,46(a3)
 addq.b #2,53(a3)
 move.w 24(a3),d0
 ext.l d0
 lsl.l #1,d0
 lea _0106a(a6),a0
 movea.w (a0,d0.l),a0
 move.l a0,-(sp)
 move.w 24(a3),d0
 ext.l d0
 lsl.l #1,d0
 lea _01062(a6),a0
 movea.w (a0,d0.l),a0
 move.l a0,d1
 move.l a3,d0
 bsr.w L10f0c
 addq.l #4,sp
 moveq #2,d1
 cmp.l d0,d1
 beq.s L116c4
 move.l a2,d1
 move.l a3,d0
 bsr.w L10d92
 move.w 24(a3),d0
 ext.l d0
 lsl.l #1,d0
 lea _0106a(a6),a0
 movea.w (a0,d0.l),a0
 move.l a0,-(sp)
 move.w 24(a3),d0
 ext.l d0
 lsl.l #1,d0
 lea _01062(a6),a0
 movea.w (a0,d0.l),a0
 move.l a0,d1
 move.l a3,d0
 bsr.w L1149a
 addq.l #4,sp
 tst.l d0
 bne.s L116c4
 movea.l (a3),a0
 move.w 2(a0),d0
 ext.l d0
 addq.l #2,d0
 move.b 53(a3),d1
 ext.w d1
 ext.l d1
 cmp.l d1,d0
 bgt.s L116d4
L116c4 clr.l -(sp)
 lea L115a8(pc),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L17982
 addq.l #4,sp
L116d4 movem.l -16(a5),a0/a2-a3/d4
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 movea.l 12(a2),a3
 movea.l D00028(a6),a0
 movea.l 5018(a0),a0
 move.w 24(a0),d4
 move.w d4,d5
 moveq #1,d0
 lsl.l d4,d0
 move.w d0,d4
 movea.l D00028(a6),a0
 tst.w 5614(a0)
 bne.s L1175e
 move.w 50(a2),d0
 and.w d4,d0
 bne.s L11720
 clr.w 42(a2)
 movea.l D00028(a6),a0
 clr.w 5614(a0)
 bra.s L1175e
L11720 cmpi.w #10,42(a2)
 bcc.s L1172e
 addq.w #1,42(a2)
 bra.s L1175e
L1172e move.w d4,50(a2)
 movea.l D00028(a6),a0
 move.w #1,5614(a0)
 lea L111ae(pc),a0
 move.l a0,22(a3)
 ext.l d5
 move.l d5,-(sp)
 lea L11610(pc),a0
 move.l a0,d1
 move.l a3,d0
 bsr.w L17982
 addq.l #4,sp
 movea.l D00028(a6),a0
 clr.w 5570(a0)
L1175e movem.l -24(a5),a0/a2-a3/d1/d4-d5
 unlk a5
 rts 
L11768 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 movea.l 46(a2),a4
 move.l (a4),d4
 move.l a3,d1
 move.l a4,d0
 bsr.w L113be
 tst.l d0
 beq.w L1188c
 movea.l d4,a0
 cmpi.w #2,34(a0)
 bne.s L1179c
 move.l a4,d0
 jsr _01b32(a6)
 bra.w L1188c
L1179c cmpi.w #3,26(a4)
 beq.s L117ac
 cmpi.w #1,26(a4)
 bne.s L117b4
L117ac move.l a4,d1
 moveq #1,d0
 jsr _01b20(a6)
L117b4 movea.l d4,a0
 cmpi.w #1,34(a0)
 beq.s L117d4
 movea.l d4,a0
 cmpi.w #4,34(a0)
 beq.s L117d4
 movea.l d4,a0
 cmpi.w #5,34(a0)
 bne.w L11874
L117d4 movea.l D00028(a6),a0
 tst.b 5094(a0)
 bne.w L1188c
 movea.l d4,a0
 cmpi.w #4,34(a0)
 bne.s L1181c
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 tst.w 124(a0)
 beq.s L1181c
 movea.l D00028(a6),a0
 tst.w 5088(a0)
 bne.s L1181c
 movea.l D00028(a6),a0
 tst.w 5100(a0)
 bne.s L1181c
 cmpi.w #50,26(a4)
 bne.s L1181c
 move.l a4,d0
 jsr _01b1a(a6)
 bra.s L1188c
L1181c movea.l D00028(a6),a0
 movea.l 5018(a0),a0
 clr.w 42(a0)
 movea.l D00028(a6),a0
 move.b #1,5094(a0)
 movea.l D00028(a6),a0
 move.l 5018(a0),-(sp)
 moveq #1,d1
 moveq #0,d0
 jsr _01b26(a6)
 addq.l #4,sp
 move.l _01b04(a6),-(sp)
 pea (L00002).w
 movea.w 24(a4),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 5018(a0),d0
 bsr.w L11278
 addq.l #8,sp
 move.l a4,d1
 movea.l D00028(a6),a0
 move.l 5018(a0),d0
 bsr.w L10e14
 jsr _01ae4(a6)
 bra.s L1188c
L11874 cmpi.w #6,26(a4)
 bne.s L1188c
 movea.l D00028(a6),a0
 tst.l 5582(a0)
 bne.s L1188c
 move.l a4,d0
 bsr.w L125e8
L1188c movem.l -20(a5),a0/a2-a4/d4
 unlk a5
 rts 
L11896 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 subq.l #4,sp
 movea.l a3,a4
 move.l a2,d5
 move.l a4,d0
 bsr.w L178ae
 moveq #0,d7
 bra.s L118fe
L118b2 move.l d7,d0
 lsl.l #2,d0
 movea.l 4(a4),a0
 move.l (a0,d0.l),d0
 bsr.w L178ae
 move.l d0,d4
 movea.l d5,a0
 move.l 6(a0),d6
 clr.l (sp)
 bra.s L118ee
L118ce move.l (sp),d0
 lsl.l #2,d0
 movea.l d4,a0
 movea.l 4(a0),a0
 move.l (a0,d0.l),d0
 bsr.w L178ae
 movea.l d6,a0
 move.l d0,68(a0)
 addq.l #1,(sp)
 addi.l #$00000048,d6
L118ee movea.l d4,a0
 move.l (sp),d0
 cmp.l (a0),d0
 bcs.s L118ce
 addq.l #1,d7
 addi.l #$0000002e,d5
L118fe cmp.l (a4),d7
 bcs.s L118b2
 addq.l #4,sp
 movem.l -32(a5),a0/a2-a4/d4-d7
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0-a4/d0-d1/d4-d7,-(sp)
 lea -20(sp),sp
 moveq #0,d7
 movea.l D00028(a6),a0
 move.l 4818(a0),12(sp)
 movea.l D00028(a6),a0
 movea.l 4822(a0),a0
 tst.w 2(a0)
 beq.w L11a24
 movea.l D00028(a6),a0
 move.l 4814(a0),d0
 bsr.w L15e04
 lea L12d01(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 4814(a0),d0
 bsr.w L16034
 movea.l D00028(a6),a0
 move.l d0,6792(a0)
 lea L12d09(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 4814(a0),d0
 bsr.w L15ffe
 move.l d0,16(sp)
 lea L12d11(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 4814(a0),d0
 bsr.w L16034
 movea.l d0,a2
 lea L12d1b(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 4814(a0),d0
 bsr.w L16034
 move.l d0,d5
 lea L12d25(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 4814(a0),d0
 bsr.w L16034
 move.l d0,d6
 lea L12d2e(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 4814(a0),d0
 bsr.w L16034
 movea.l D00028(a6),a0
 move.l d0,6788(a0)
 lea L12d36(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 4814(a0),d0
 bsr.w L15ffe
 movea.l D00028(a6),a0
 move.w d0,6796(a0)
 movea.l D00028(a6),a0
 movea.l 6792(a0),a3
 movea.l a2,a4
 moveq #0,d7
 bra.s L11a1e
L119f0 move.l a4,6(a3)
 clr.w 44(a3)
 moveq #72,d0
 muls.w 4(a3),d0
 adda.l d0,a4
 move.l d7,d0
 lsl.l #2,d0
 movea.l 12(sp),a0
 movea.l 16(a0),a0
 movea.l 12(a0),a0
 move.l (a0,d0.l),10(a3)
 addq.l #1,d7
 adda.l #46,a3
L11a1e cmp.l 16(sp),d7
 blt.s L119f0
L11a24 move.l d7,d0
 addq.l #1,d7
 lsl.l #2,d0
 movea.l 12(sp),a0
 movea.l 16(a0),a0
 movea.l 12(a0),a0
 movea.l D00028(a6),a1
 move.l (a0,d0.l),5096(a1)
 move.l d7,d0
 addq.l #1,d7
 lsl.l #2,d0
 movea.l 12(sp),a0
 movea.l 16(a0),a0
 movea.l 12(a0),a0
 move.l (a0,d0.l),8(sp)
 moveq #0,d1
 move.l 8(sp),d0
 bsr.w L160f0
 move.l d0,4(sp)
 moveq #0,d1
 move.l 8(sp),d0
 bsr.w L15fb6
 move.l d0,(sp)
 move.l (sp),d0
 lsl.l #1,d0
 move.l d0,-(sp)
 move.l 8(sp),d1
 movea.l D00028(a6),a0
 move.l #356,d0
 add.l 6908(a0),d0
 jsr _017c6(a6)
 addq.l #4,sp
 movea.l D00028(a6),a0
 movea.l 4822(a0),a0
 tst.w 2(a0)
 beq.w L11b7c
 movea.l D00028(a6),a0
 move.l 6788(a0),d4
 moveq #0,d7
 bra.w L11b58
L11aae movea.l d4,a0
 move.b 29(a0),d0
 ext.w d0
 muls.w #46,d0
 movea.l D00028(a6),a0
 add.l 6792(a0),d0
 movea.l d4,a0
 move.l d0,(a0)
 movea.l d4,a0
 movea.l (a0),a0
 movea.l d4,a1
 move.l 6(a0),4(a1)
 movea.l d4,a0
 movea.l d4,a1
 move.l 4(a0),16(a1)
 movea.l d4,a0
 movea.l d4,a1
 move.l 4(a0),20(a1)
 movea.l d4,a0
 cmpi.w #1,26(a0)
 beq.s L11b04
 movea.l d4,a0
 cmpi.w #6,26(a0)
 beq.s L11b04
 movea.l d4,a0
 cmpi.w #7,26(a0)
 bne.s L11b2a
L11b04 movea.l d4,a0
 move.l d5,8(a0)
 movea.l d4,a0
 movea.l 8(a0),a0
 move.l d6,10(a0)
 addi.l #$0000000e,d5
 movea.l d4,a0
 movea.l 8(a0),a0
 move.w 4(a0),d0
 ext.l d0
 lsl.l #1,d0
 add.l d0,d6
L11b2a movea.l d4,a0
 movea.l (a0),a0
 cmpi.w #5,34(a0)
 bne.s L11b50
 move.l d4,-(sp)
 movea.l d4,a0
 move.l 4(a0),-(sp)
 movea.l d4,a0
 move.l (a0),d1
 movea.l D00028(a6),a0
 move.l 4814(a0),d0
 bsr.w L0b208
 addq.l #8,sp
L11b50 addq.l #1,d7
 addi.l #$00000036,d4
L11b58 movea.l D00028(a6),a0
 move.w 6796(a0),d0
 ext.l d0
 cmp.l d7,d0
 bgt.w L11aae
 movea.l D00028(a6),a0
 move.l 6798(a0),d1
 movea.l D00028(a6),a0
 move.l 6792(a0),d0
 bsr.w L11896
L11b7c lea 20(sp),sp
 movem.l -40(a5),a0-a4/d1/d4-d7
 unlk a5
 rts 
 link.w a5,#0
 movem.l a2/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 move.l d1,d4
 moveq #0,d5
 bra.s L11bb2
L11b9a tst.w 38(a2)
 bne.s L11baa
 move.w #1,38(a2)
 move.l a2,d0
 bra.s L11bb8
L11baa addq.l #1,d5
 adda.l #54,a2
L11bb2 cmp.l d4,d5
 blt.s L11b9a
 moveq #0,d0
L11bb8 movem.l -12(a5),a2/d4-d5
 unlk a5
 rts 
L11bc2 link.w a5,#0
 movem.l a2/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 move.l d1,d4
 moveq #0,d5
 bra.s L11be2
L11bd2 clr.w 38(a2)
 clr.l 12(a2)
 addq.l #1,d5
 adda.l #54,a2
L11be2 cmp.l d4,d5
 blt.s L11bd2
 movem.l -12(a5),a2/d4-d5
 unlk a5
 rts 
L11bf0 link.w a5,#0
 movem.l a0/a2/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 move.l d1,d4
 moveq #0,d5
 bra.s L11c22
L11c00 tst.l 12(a2)
 beq.s L11c1a
 move.l 12(a2),d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 bsr.w L178ec
 clr.l 12(a2)
L11c1a addq.l #1,d5
 adda.l #54,a2
L11c22 cmp.l d4,d5
 blt.s L11c00
 movem.l -16(a5),a0/a2/d4-d5
 unlk a5
 rts 
L11c30 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d6,-(sp)
 move.l d0,d4
 move.l d1,d5
 move.l 44(sp),d6
 movea.l D00028(a6),a0
 movea.l 178(a0),a0
 movea.l 24(a0),a2
 bra.s L11c8a
L11c4e movea.l 56(a2),a3
 move.w 50(a2),d0
 ext.l d0
 cmp.l d4,d0
 bne.s L11c88
 move.l a2,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 bsr.w L1736c
 tst.l d5
 beq.s L11c88
 move.l a2,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 bsr.w L178ec
 tst.l d6
 beq.s L11c88
 movea.l 46(a2),a4
 clr.l 12(a4)
L11c88 movea.l a3,a2
L11c8a move.l a2,d0
 bne.s L11c4e
 movem.l -28(a5),a0/a2-a4/d4-d6
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 pea (L00001).w
 moveq #1,d1
 moveq #0,d0
 bsr.w L11c30
 addq.l #4,sp
 pea (L00001).w
 moveq #1,d1
 moveq #1,d0
 bsr.w L11c30
 addq.l #4,sp
 pea (L00001).w
 moveq #1,d1
 moveq #2,d0
 bsr.w L11c30
 addq.l #4,sp
 clr.l -(sp)
 moveq #1,d1
 moveq #6,d0
 bsr.w L11c30
 addq.l #4,sp
 moveq #8,d1
 move.l #8536,d0
 add.l D00028(a6),d0
 bsr.w L11bc2
 moveq #8,d1
 move.l #9124,d0
 add.l D00028(a6),d0
 bsr.w L11bf0
 movea.l D00028(a6),a0
 movea.w 6796(a0),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 6788(a0),d0
 bsr.w L11bf0
 moveq #8,d1
 move.l #8104,d0
 add.l D00028(a6),d0
 bsr.w L11bc2
 clr.l -(sp)
 moveq #0,d1
 moveq #5,d0
 bsr.w L11c30
 addq.l #4,sp
 movea.l D00028(a6),a0
 clr.b 5565(a0)
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
L11d3a link.w a5,#0
 movem.l a2/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
 addq.w #1,36(a2)
 move.w 36(a2),d0
 ext.l d0
 cmp.l d4,d0
 blt.s L11d5c
 clr.w 36(a2)
 moveq #0,d0
 bra.s L11d5e
L11d5c moveq #1,d0
L11d5e movem.l -8(a5),a2/d4
 unlk a5
 rts 
L11d68 link.w a5,#0
 movem.l a0-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
 movea.l (a2),a3
 move.w 4(a3),d0
 ext.l d0
 cmp.l d4,d0
 ble.s L11da8
 move.l d4,d0
 moveq #72,d1
 jsr _016a0(a6)
 add.l 6(a3),d0
 move.l d0,4(a2)
 clr.b 28(a2)
 movea.l 12(a2),a0
 movea.l 4(a2),a1
 move.b (a1),d0
 ext.w d0
 move.w d0,38(a0)
 move.w d4,24(a2)
L11da8 movem.l -20(a5),a0-a3/d4
 unlk a5
 rts 
L11db2 link.w a5,#0
 movem.l a0/a2-a4/d0-d1,-(sp)
 movea.l d0,a2
 movea.l 46(a2),a3
 movea.l 4(a3),a4
 move.l a2,d1
 move.l a4,d0
 bsr.w L10dbc
 movea.l (a3),a0
 cmpi.w #5,34(a0)
 bne.s L11de0
 move.l 8(a3),d1
 move.l a2,d0
 bsr.w L0b0aa
L11de0 movem.l -16(a5),a0/a2-a4
 unlk a5
 rts 
L11dea link.w a5,#0
 movem.l a0-a1/d0-d1/d4,-(sp)
 movea.l 4(sp),a0
 move.w 30(a0),d0
 movea.l 4(sp),a0
 add.w d0,44(a0)
 movea.l 4(sp),a0
 move.w 32(a0),d0
 movea.l 4(sp),a0
 add.w d0,46(a0)
 movea.l 4(sp),a0
 movea.w 32(a0),a0
 move.l a0,-(sp)
 movea.l 8(sp),a0
 movea.w 30(a0),a0
 move.l a0,d1
 move.l 8(sp),d0
 bsr.w L10f0c
 addq.l #4,sp
 tst.l d0
 beq.s L11e66
 jsr _01b2c(a6)
 andi.w #$0003,d0
 move.w d0,d4
 move.w d4,d0
 ext.l d0
 lsl.l #2,d0
 lea _01042(a6),a0
 movea.l 4(sp),a1
 move.w (a0,d0.l),30(a1)
 move.w d4,d0
 ext.l d0
 lsl.l #2,d0
 lea _01042(a6),a0
 movea.l 4(sp),a1
 move.w 2(a0,d0.l),32(a1)
L11e66 move.l (sp),d1
 move.l 4(sp),d0
 bsr.w L10d92
 move.l (sp),d1
 movea.l 4(sp),a0
 move.l 4(a0),d0
 bsr.w L10dbc
 movem.l -12(a5),a0-a1/d4
 unlk a5
 rts 
L11e88 link.w a5,#0
 movem.l a0/a2-a4/d0-d1,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.w 30(a3),d0
 add.w d0,44(a3)
 move.w 32(a3),d0
 add.w d0,46(a3)
 movea.w 32(a3),a0
 move.l a0,-(sp)
 movea.w 30(a3),a0
 move.l a0,d1
 move.l a3,d0
 bsr.w L10f0c
 addq.l #4,sp
 tst.l d0
 beq.s L11eec
 movea.l 8(a3),a4
 tst.w 24(a3)
 bne.s L11eca
 moveq #1,d0
 bra.s L11ecc
L11eca moveq #0,d0
L11ecc move.w d0,24(a3)
 move.w 24(a3),d0
 ext.l d0
 lsl.l #2,d0
 move.w (a4,d0.l),30(a3)
 move.w 24(a3),d0
 ext.l d0
 lsl.l #2,d0
 move.w 2(a4,d0.l),32(a3)
L11eec move.l a2,d1
 move.l a3,d0
 bsr.w L10d92
 move.l a2,d1
 move.l 4(a3),d0
 bsr.w L10dbc
 movem.l -16(a5),a0/a2-a4
 unlk a5
 rts 
L11f08 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 moveq #44,d0
 add.l a2,d0
 movea.l d0,a3
 movea.l D00028(a6),a0
 moveq #44,d0
 add.l 5018(a0),d0
 movea.l d0,a4
 move.w (a4),d0
 ext.l d0
 move.w (a3),d1
 ext.l d1
 sub.l d0,d1
 move.l d1,d0
 jsr _0196a(a6)
 move.w d0,d4
 move.w 2(a4),d0
 ext.l d0
 move.w 2(a3),d1
 ext.l d1
 sub.l d0,d1
 move.l d1,d0
 jsr _0196a(a6)
 move.w d0,d5
 cmpi.w #120,d4
 bge.s L11f80
 cmpi.w #80,d5
 bge.s L11f80
 movea.l 12(a2),a0
 cmpi.w #4,50(a0)
 beq.s L11f70
 pea (a2)
 moveq #0,d1
 moveq #1,d0
 jsr _01b26(a6)
 addq.l #4,sp
L11f70 move.w #1,38(a2)
 move.w 42(a2),d0
 lsr.w #1,d0
 move.w d0,42(a2)
L11f80 movem.l -28(a5),a0/a2-a4/d1/d4-d5
 unlk a5
 rts 
L11f8a link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 movea.l 40(sp),a4
 move.l 44(sp),d4
 move.w 50(a3),d0
 asr.w #8,d0
 move.w d0,d5
 move.l a2,d1
 move.l a3,d0
 bsr.w L10d92
 addq.w #1,d5
 andi.w #$00ff,50(a3)
 moveq #0,d0
 move.w d5,d0
 lsl.l #8,d0
 or.w d0,50(a3)
 move.l a2,d1
 move.l a4,d0
 bsr.w L10dbc
 cmp.w 42(a3),d5
 bcc.s L11fd2
 tst.w d4
 beq.s L11fe2
L11fd2 clr.l -(sp)
 lea L1219e(pc),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L17982
 addq.l #4,sp
L11fe2 movem.l -24(a5),a0/a2-a4/d4-d5
 unlk a5
 rts 
L11fec link.w a5,#0
 movem.l a2-a4/d0-d1/d4-d6,-(sp)
 movea.l d0,a2
 movea.l 46(a2),a3
 moveq #44,d0
 add.l a3,d0
 movea.l d0,a4
 moveq #15,d0
 and.b 51(a3),d0
 subq.b #1,d0
 move.b d0,d4
 move.l 4(a3),d5
 moveq #0,d6
 moveq #0,d0
 move.w 38(a3),d0
 move.l d0,d1
 move.l a3,d0
 bsr.w L11d3a
 tst.l d0
 bne.s L12094
 cmpi.w #1,38(a3)
 beq.s L12030
 move.l a3,d0
 bsr.w L11f08
L12030 ext.w d4
 muls.w #6,d4
 move.b d4,d0
 ext.w d0
 add.w d0,(a4)
 cmpi.w #4,50(a2)
 beq.s L1205a
 clr.l -(sp)
 move.b d4,d0
 ext.w d0
 ext.l d0
 move.l d0,d1
 move.l a3,d0
 bsr.w L10f0c
 addq.l #4,sp
 move.l d0,d6
 bra.s L12086
L1205a clr.l -(sp)
 move.b d4,d0
 ext.w d0
 ext.l d0
 move.l d0,d1
 move.l a3,d0
 jsr _01b02(a6)
 addq.l #4,sp
 move.l d0,d6
 clr.l -(sp)
 move.b d4,d0
 ext.w d0
 ext.l d0
 move.l d0,-(sp)
 move.l (a3),d1
 moveq #44,d0
 add.l a3,d0
 bsr.w L11216
 addq.l #8,sp
 or.l d0,d6
L12086 move.l d6,-(sp)
 move.l d5,-(sp)
 move.l a3,d1
 move.l a2,d0
 bsr.w L11f8a
 addq.l #8,sp
L12094 movem.l -24(a5),a2-a4/d4-d6
 unlk a5
 rts 
L1209e link.w a5,#0
 movem.l a2-a4/d0-d1/d4-d6,-(sp)
 movea.l d0,a2
 movea.l 46(a2),a3
 moveq #44,d0
 add.l a3,d0
 movea.l d0,a4
 moveq #15,d0
 and.b 51(a3),d0
 subq.b #1,d0
 move.b d0,d4
 move.l 4(a3),d5
 moveq #0,d6
 moveq #0,d0
 move.w 38(a3),d0
 move.l d0,d1
 move.l a3,d0
 bsr.w L11d3a
L120d0 tst.l d0
 bne.s L12148
 cmpi.w #1,38(a3)
 beq.s L120e2
 move.l a3,d0
 bsr.w L11f08
L120e2 ext.w d4
 muls.w #6,d4
L120e6 equ *-2
 move.b d4,d0
 ext.w d0
 add.w d0,2(a4)
 cmpi.w #4,50(a2)
 beq.s L1210e
 move.b d4,d0
 ext.w d0
L120fc ext.l d0
 move.l d0,-(sp)
 moveq #0,d1
 move.l a3,d0
 bsr.w L10f0c
 addq.l #4,sp
 move.l d0,d6
 bra.s L1213a
L1210e move.b d4,d0
 ext.w d0
 ext.l d0
 move.l d0,-(sp)
 moveq #0,d1
 move.l a3,d0
 jsr _01b02(a6)
L1211e addq.l #4,sp
 move.l d0,d6
 move.b d4,d0
 ext.w d0
 ext.l d0
 move.l d0,-(sp)
 clr.l -(sp)
 move.l (a3),d1
 moveq #44,d0
 add.l a3,d0
 bsr.w L11216
 addq.l #8,sp
 or.l d0,d6
L1213a move.l d6,-(sp)
 move.l d5,-(sp)
 move.l a3,d1
 move.l a2,d0
 bsr.w L11f8a
 addq.l #8,sp
L12148 movem.l -24(a5),a2-a4/d4-d6
 unlk a5
 rts 
L12152 link.w a5,#0
 movem.l a0/a2-a3/d0/d4,-(sp)
 movea.l D00028(a6),a0
 movea.l 6788(a0),a2
 moveq #0,d4
 bra.s L12184
L12166 movea.l (a2),a3
 cmpi.w #1,34(a3)
 bne.s L1217c
 tst.l 12(a2)
 beq.s L1217c
 moveq #44,d0
 add.l a2,d0
 bra.s L12194
L1217c addq.l #1,d4
 adda.l #54,a2
L12184 movea.l D00028(a6),a0
 move.w 6796(a0),d0
 ext.l d0
 cmp.l d4,d0
 bgt.s L12166
 moveq #0,d0
L12194 movem.l -16(a5),a0/a2-a3/d4
 unlk a5
 rts 
L1219e link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d6,-(sp)
 movea.l d0,a2
 lea -10(sp),sp
 movea.l 46(a2),a3
 movea.l D00028(a6),a0
 moveq #44,d0
 add.l 5018(a0),d0
 movea.l d0,a4
 moveq #44,d0
 add.l a3,d0
 move.l d0,d5
 move.l (a3),d6
 clr.w 50(a3)
 jsr _01b2c(a6)
 moveq #15,d1
 asr.l d1,d0
 move.b d0,d4
 cmpi.w #4,50(a2)
 bne.s L121ee
 bsr.w L12152
 movea.l d0,a4
 move.l a4,d0
 bne.s L121ee
 moveq #0,d0
 jsr _01af6(a6)
 bra.w L1247a
L121ee move.w (a4),d0
 ext.l d0
 movea.l d5,a0
 move.w (a0),d1
 ext.l d1
 sub.l d0,d1
 move.l d1,d0
 jsr _0196a(a6)
 move.w d0,4(sp)
 move.w 2(a4),d0
 ext.l d0
 movea.l d5,a0
 move.w 2(a0),d1
 ext.l d1
 sub.l d0,d1
 move.l d1,d0
 jsr _0196a(a6)
 move.w d0,2(sp)
 jsr _01b2c(a6)
 moveq #12,d1
 asr.l d1,d0
 move.w d0,6(sp)
 cmpi.w #120,4(sp)
 bgt.s L1223a
 cmpi.w #80,2(sp)
 ble.s L12246
L1223a move.w #1,(sp)
 move.w #2,38(a3)
 bra.s L12262
L12246 clr.w (sp)
 cmpi.w #2,38(a3)
 bne.s L1225c
 pea (a3)
 moveq #0,d1
 moveq #1,d0
 jsr _01b26(a6)
 addq.l #4,sp
L1225c move.w #1,38(a3)
L12262 tst.b d4
 bne.w L1232a
 tst.w (sp)
 bne.s L122c2
 movea.l d5,a0
 move.w (a0),d0
 cmp.w (a4),d0
 bge.s L12294
 move.b #2,9(sp)
 move.w #1,24(a3)
 movea.l d6,a0
 cmpi.w #5,34(a0)
 beq.s L122ba
 moveq #1,d1
L1228c move.l a3,d0
 bsr.w L11d68
 bra.s L122ba
L12294 movea.l d5,a0
 move.w (a0),d0
 cmp.w (a4),d0
 ble.s L122b4
 clr.b 9(sp)
 move.w #3,24(a3)
 movea.l d6,a0
 cmpi.w #5,34(a0)
 beq.s L122ba
 moveq #3,d1
 bra.s L1228c
L122b4 move.b #1,9(sp)
L122ba andi.w #$000c,6(sp)
 bra.s L12310
L122c2 jsr _01b2c(a6)
 moveq #15,d1
 asr.l d1,d0
 move.b d0,9(sp)
 tst.b 9(sp)
 beq.s L122ee
 move.b #2,9(sp)
 move.w #1,24(a3)
 movea.l d6,a0
 cmpi.w #5,34(a0)
 beq.s L12306
 moveq #1,d1
 bra.s L12300
L122ee move.w #3,24(a3)
 movea.l d6,a0
 cmpi.w #5,34(a0)
 beq.s L12306
 moveq #3,d1
L12300 move.l a3,d0
 bsr.w L11d68
L12306 move.w 6(sp),d0
 lsl.w #2,d0
 move.w d0,6(sp)
L12310 moveq #0,d0
 move.b 9(sp),d0
 move.w d0,50(a3)
 move.w 6(sp),42(a3)
 clr.l -(sp)
 lea L11fec(pc),a0
 bra.w L123ec
L1232a tst.w (sp)
 bne.s L1238a
 movea.l d5,a0
 move.w 2(a0),d0
 cmp.w 2(a4),d0
 bge.s L1235a
 move.b #2,9(sp)
 move.w #2,24(a3)
 movea.l d6,a0
 cmpi.w #5,34(a0)
 beq.s L12382
 moveq #2,d1
L12352 move.l a3,d0
 bsr.w L11d68
 bra.s L12382
L1235a movea.l d5,a0
 move.w 2(a0),d0
 cmp.w 2(a4),d0
 ble.s L1237c
 clr.b 9(sp)
 clr.w 24(a3)
 movea.l d6,a0
 cmpi.w #5,34(a0)
 beq.s L12382
 moveq #0,d1
 bra.s L12352
L1237c move.b #1,9(sp)
L12382 andi.w #$000c,6(sp)
 bra.s L123d6
L1238a jsr _01b2c(a6)
 moveq #15,d1
 asr.l d1,d0
 move.b d0,9(sp)
 tst.b 9(sp)
 beq.s L123b6
 move.b #2,9(sp)
 move.w #2,24(a3)
 movea.l d6,a0
 cmpi.w #5,34(a0)
 beq.s L123cc
 moveq #2,d1
 bra.s L123c6
L123b6 clr.w 24(a3)
 movea.l d6,a0
 cmpi.w #5,34(a0)
 beq.s L123cc
 moveq #0,d1
L123c6 move.l a3,d0
 bsr.w L11d68
L123cc move.w 6(sp),d0
 lsl.w #2,d0
 move.w d0,6(sp)
L123d6 moveq #0,d0
 move.b 9(sp),d0
 move.w d0,50(a3)
 move.w 6(sp),42(a3)
 clr.l -(sp)
 lea L1209e(pc),a0
L123ec move.l a0,d1
 move.l a2,d0
 bsr.w L17982
 addq.l #4,sp
 tst.b 49(a3)
 bne.s L1244e
 movea.l d6,a0
 tst.b 42(a0)
 beq.s L1244e
 movea.l d6,a0
 cmpi.w #5,34(a0)
 beq.s L1244e
 jsr _01b2c(a6)
 moveq #14,d1
 asr.l d1,d0
 move.w d0,(sp)
 cmpi.w #1,(sp)
 bne.s L12452
 cmpi.w #4,50(a2)
 beq.s L12452
 move.l d6,d1
 move.l a3,d0
 jsr _01b0e(a6)
 move.l 26(a2),8(a3)
 pea (L0000a).w
 lea L12d3e(pc),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L17982
 addq.l #4,sp
 move.b #1,49(a3)
 bra.s L12452
L1244e clr.b 49(a3)
L12452 cmpi.w #4,50(a2)
 bne.s L12466
 tst.l 14(sp)
 bne.s L12466
 jsr _01af0(a6)
 bra.s L1247a
L12466 movea.l d6,a0
 cmpi.w #5,34(a0)
 bne.s L1247a
 move.l 8(a3),d1
 move.l a2,d0
 bsr.w L0b0aa
L1247a lea 10(sp),sp
 movem.l -28(a5),a0/a2-a4/d4-d6
 unlk a5
 rts 
L12488 link.w a5,#0
 movem.l a0/a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 movea.l 12(a2),a3
 move.w 30(a2),44(a2)
 move.w 32(a2),46(a2)
 move.l a3,d1
 move.l a2,d0
 bsr.w L10d92
 clr.l -(sp)
 lea L1219e(pc),a0
 move.l a0,d1
 move.l a3,d0
 bsr.w L17982
 addq.l #4,sp
 movem.l -16(a5),a0/a2-a3/d1
 unlk a5
 rts 
L124c4 link.w a5,#0
 movem.l a0/a2-a4/d0-d1,-(sp)
 movea.l d0,a2
 movea.l 12(a2),a3
 movea.l (a2),a4
 move.w 30(a2),44(a2)
 move.w 32(a2),46(a2)
 move.l a3,d1
 move.l a2,d0
 bsr.w L10d92
 cmpi.w #6,34(a4)
 bne.s L124f4
 clr.l 22(a3)
L124f4 cmpi.w #6,26(a2)
 bne.s L12504
 clr.l -(sp)
 lea L12a34(pc),a0
 bra.s L1250a
L12504 clr.l -(sp)
 lea L11db2(pc),a0
L1250a move.l a0,d1
 move.l a3,d0
 bsr.w L17982
 addq.l #4,sp
 movem.l -20(a5),a0/a2-a4/d1
 unlk a5
 rts 
L1251e link.w a5,#0
 movem.l a0/a2-a4/d0-d1,-(sp)
 movea.l d0,a2
 movea.l 12(a2),a3
 movea.l 8(a2),a4
 move.w (a4),44(a2)
 move.w 2(a4),46(a2)
 move.l 10(a4),6(a4)
 move.l a3,d1
 move.l a2,d0
 bsr.w L10d92
 clr.l -(sp)
 lea L12f98(pc),a0
 move.l a0,d1
 move.l a3,d0
 bsr.w L17982
 addq.l #4,sp
 movem.l -20(a5),a0/a2-a4/d1
 unlk a5
 rts 
L12562 link.w a5,#0
 movem.l a0/a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 movea.l 12(a2),a3
 move.w 30(a2),44(a2)
 move.w 32(a2),46(a2)
 move.l a3,d1
 move.l a2,d0
 bsr.w L10d92
 clr.l -(sp)
 moveq #0,d1
 move.l a3,d0
 bsr.w L17982
 addq.l #4,sp
 clr.l 18(a3)
 movea.l D00028(a6),a0
 move.w #1,5016(a0)
 clr.l 22(a3)
 movem.l -16(a5),a0/a2-a3/d1
 unlk a5
 rts 
L125ac link.w a5,#0
 movem.l a0/a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 movea.l 12(a2),a3
 move.w 30(a2),44(a2)
 move.w 32(a2),46(a2)
 move.l a3,d1
 move.l a2,d0
 bsr.w L10d92
 pea (a2)
 lea L0b0e4(pc),a0
 move.l a0,d1
 move.l a3,d0
 bsr.w L17982
 addq.l #4,sp
 movem.l -16(a5),a0/a2-a3/d1
 unlk a5
 rts 
L125e8 link.w a5,#0
 movem.l a0/a2/d0,-(sp)
 movea.l d0,a2
 movea.l D00028(a6),a0
 move.l a2,5582(a0)
 move.l a2,d0
 bsr.w L1251e
 movem.l -8(a5),a0/a2
 unlk a5
 rts 
L1260a link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4,-(sp)
 movea.l d0,a2
 movea.l D00028(a6),a0
 movea.l 5018(a0),a3
 movea.l (a2),a4
 move.l (a3),d4
 move.w 30(a2),d0
 move.w 2(a4),d1
 asr.w #1,d1
 add.w d1,d0
 movea.l d4,a0
 move.w 2(a0),d1
 asr.w #1,d1
 sub.w d1,d0
 move.w d0,44(a3)
 move.w 32(a2),d0
 move.w (a4),d1
 asr.w #1,d1
 add.w d1,d0
 movea.l d4,a0
 move.w (a0),d1
 asr.w #1,d1
 sub.w d1,d0
 subi.w #10,d0
 move.w d0,46(a3)
 move.l 12(a3),d1
 move.l a3,d0
 bsr.w L10d92
 movea.l D00028(a6),a0
 move.l a2,5582(a0)
 move.w #6,26(a2)
 move.l a2,d0
 bsr.w L1251e
 movem.l -24(a5),a0/a2-a4/d1/d4
 unlk a5
 rts 
L1267c link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 movea.l 12(a2),a3
 jsr _01b2c(a6)
 andi.w #$0003,d0
 move.w d0,d4
 move.w 30(a2),44(a2)
 move.w 32(a2),46(a2)
 move.l a3,d1
 move.l a2,d0
 bsr.w L10d92
 move.w d4,d0
 ext.l d0
 lsl.l #2,d0
 lea _01042(a6),a0
 move.w (a0,d0.l),30(a2)
 move.w d4,d0
 ext.l d0
 lsl.l #2,d0
 lea _01042(a6),a0
 move.w 2(a0,d0.l),32(a2)
 pea (a2)
 lea L11dea(pc),a0
 move.l a0,d1
 move.l a3,d0
 bsr.w L17982
 addq.l #4,sp
 movem.l -20(a5),a0/a2-a3/d1/d4
 unlk a5
 rts 
L126e2 link.w a5,#0
 movem.l a0/a2-a4/d0-d1,-(sp)
 movea.l d0,a2
 movea.l 12(a2),a3
 move.w 30(a2),44(a2)
 move.w 32(a2),46(a2)
 move.l a3,d1
 move.l a2,d0
 bsr.w L10d92
 tst.w 50(a2)
 bne.s L12710
 lea _01052(a6),a0
 bra.s L12714
L12710 lea _0105a(a6),a0
L12714 move.l a0,8(a2)
 movea.l 8(a2),a4
 clr.w 24(a2)
 move.w 24(a2),d0
 ext.l d0
 lsl.l #2,d0
 move.w (a4,d0.l),30(a2)
 move.w 24(a2),d0
 ext.l d0
 lsl.l #2,d0
 move.w 2(a4,d0.l),32(a2)
 pea (a2)
 lea L11e88(pc),a0
 move.l a0,d1
 move.l a3,d0
 bsr.w L17982
 addq.l #4,sp
 movem.l -20(a5),a0/a2-a4/d1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 movea.l (a2),a3
 tst.l 12(a2)
 bne.s L12796
 clr.l -(sp)
 pea (a2)
 clr.l -(sp)
 move.l _01b0a(a6),-(sp)
 clr.l -(sp)
 pea L111ae(pc)
 pea L11768(pc)
 lea L110cc(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 bsr.w L16e04
 lea 28(sp),sp
 move.l d0,12(a2)
L12796 tst.l 12(a2)
 bra.s L127dc
 move.l a2,d0
 bsr.w L1251e
 bra.s L12804
 move.l a2,d0
 bsr.w L12488
 bra.s L12804
 move.l a2,d0
 bsr.w L12562
 bra.s L12804
 move.l a2,d0
 bsr.w L125ac
 bra.s L12804
 move.l a2,d0
 bsr.w L124c4
 bra.s L12804
 move.l a2,d0
 bsr.w L1260a
 bra.s L12804
 move.l a2,d0
 bsr.w L1267c
 bra.s L12804
 move.l a2,d0
 bsr.w L126e2
 bra.s L12804
L127dc move.w 26(a2),d0
 cmpi.w #9,d0
 bhi.s L12804
 add.w d0,d0
 move.w L127ee(pc,d0.w),d0
 jmp L127ee(pc,d0.w)
L127ee equ *-2
 dc.w $ffcc
 dc.w $ffac
 dc.w $ffb4
 dc.w $ffcc
 dc.w $ffbc
 dc.w $ffc4
 dc.w $ffcc
 dc.w $ffd4
 dc.w $ffdc
 dc.w $ffe4
L12804 move.l 12(a2),d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 bsr.w L16d80
 cmpi.w #1,34(a3)
 bne.s L1282a
 tst.w 26(a2)
 beq.s L1282a
 movea.l D00028(a6),a0
 addq.w #1,5002(a0)
L1282a movem.l -16(a5),a0/a2-a3/d1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d5,-(sp)
 movea.l D00028(a6),a0
 movea.l 178(a0),a0
 movea.l 24(a0),a3
 moveq #0,d5
 movea.l D00028(a6),a0
 move.w 5000(a0),d0
 ext.l d0
 lsl.l #2,d0
 movea.l D00028(a6),a0
 adda.l d0,a0
 move.w 4874(a0),d0
 ext.l d0
 movea.l D00028(a6),a0
 move.w 5002(a0),d1
 ext.l d1
 sub.l d0,d1
 move.l d1,d4
 tst.l d4
 bne.s L128bc
 bra.s L128c0
L12876 movea.l 56(a3),a4
 tst.w 50(a3)
 bne.s L128ba
 movea.l 46(a3),a2
 movea.l (a2),a0
 cmpi.w #1,34(a0)
 bne.s L128ba
 tst.w 26(a2)
 beq.s L128ba
 move.l a3,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 bsr.w L1736c
 move.l a3,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 bsr.w L178ec
 clr.l 12(a2)
 addq.l #1,d5
 cmp.l d4,d5
 bge.s L128c0
L128ba movea.l a4,a3
L128bc move.l a3,d0
 bne.s L12876
L128c0 movem.l -28(a5),a0/a2-a4/d1/d4-d5
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2/d0-d1/d4,-(sp)
 movea.l D00028(a6),a0
 movea.l 6788(a0),a2
 movea.l D00028(a6),a0
 clr.w 5002(a0)
 moveq #0,d4
 bra.s L128f6
L128e6 move.l a2,d1
 moveq #5,d0
 jsr _01b20(a6)
 addq.l #1,d4
 adda.l #54,a2
L128f6 movea.l D00028(a6),a0
 move.w 6796(a0),d0
 ext.l d0
 cmp.l d4,d0
 bgt.s L128e6
 movem.l -16(a5),a0/a2/d1/d4
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
 movea.l 12(a2),a3
 moveq #30,d0
 add.l a2,d0
 movea.l d0,a4
 tst.l d4
 bne.s L12938
 movea.l 26(a3),a4
 move.l 34(a3),-(sp)
 lea L11db2(pc),a0
 move.l a0,d1
 bra.s L1293e
L12938 move.l 34(a3),-(sp)
 move.l a4,d1
L1293e move.l a3,d0
 bsr.w L17982
 addq.l #4,sp
 movem.l -20(a5),a0/a2-a4/d4
 unlk a5
 rts 
L12950 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 move.l d1,d4
 movea.l 46(a2),a3
 movea.l D00028(a6),a0
 movea.l 178(a0),a4
 move.w 20(a4),d0
 ext.l d0
 lsl.l #2,d0
 move.l 2(a4,d0.l),d5
 moveq #0,d1
 move.l a3,d0
 bsr.w L11d68
 move.l d5,d1
 move.l a3,d0
 bsr.w L113be
 tst.l d0
 bne.s L129aa
 moveq #0,d1
 move.l a3,d0
 bsr.w L11d68
 clr.l -(sp)
 lea L11db2(pc),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L17982
 addq.l #4,sp
 movea.l D00028(a6),a0
 clr.l 5572(a0)
 bra.s L129ec
L129aa movea.w 50(a3),a0
 move.l a0,d1
 move.l a3,d0
 bsr.w L11d68
 subq.l #1,d4
 moveq #1,d0
 cmp.l d4,d0
 ble.s L129dc
 tst.w 50(a3)
 bne.s L129c8
 moveq #1,d0
 bra.s L129ca
L129c8 moveq #0,d0
L129ca move.w d0,50(a3)
 movea.w 50(a3),a0
 move.l a0,d1
 move.l a3,d0
 bsr.w L11d68
 moveq #8,d4
L129dc move.l d4,-(sp)
 lea L12950(pc),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L17982
 addq.l #4,sp
L129ec movem.l -24(a5),a0/a2-a4/d4-d5
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2/d0-d1,-(sp)
 movea.l d0,a2
 movea.l D00028(a6),a0
 tst.l 5572(a0)
 bne.s L12a2a
 movea.l D00028(a6),a0
 move.l a2,5572(a0)
 clr.w 50(a2)
 pea (L00008).w
 lea L12950(pc),a0
 move.l a0,d1
 move.l 12(a2),d0
 bsr.w L17982
 addq.l #4,sp
L12a2a movem.l -12(a5),a0/a2/d1
 unlk a5
 rts 
L12a34 link.w a5,#0
 movem.l a0/a2-a4/d0-d1,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 movea.l 46(a2),a4
 move.w 50(a4),d0
 ext.l d0
 lsl.l #1,d0
 lea _0109a(a6),a0
 move.w (a0,d0.l),d0
 add.w d0,46(a4)
 addq.w #1,50(a4)
 move.w 50(a4),d0
 ext.l d0
 lsl.l #1,d0
 lea _0109a(a6),a0
 cmpi.w #99,(a0,d0.l)
 bne.s L12a74
 clr.w 50(a4)
L12a74 move.l a2,d1
 move.l a4,d0
 bsr.w L10d92
 movem.l -16(a5),a0/a2-a4
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
 movea.l D00028(a6),a0
 move.w 5108(a0),d0
 ext.l d0
 cmp.l d4,d0
 blt.s L12aca
 move.w d4,d0
 movea.l D00028(a6),a0
 sub.w d0,5108(a0)
 jsr _01aea(a6)
 pea (a2)
 moveq #3,d1
 moveq #0,d0
 jsr _01b26(a6)
 addq.l #4,sp
 move.l a2,d1
 moveq #2,d0
 jsr _01b20(a6)
 movea.l D00028(a6),a0
 clr.l 5572(a0)
L12aca movem.l -12(a5),a0/a2/d4
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1/d4-d5,-(sp)
 move.l d0,d4
 move.l d1,d5
 tst.l d4
 bne.s L12af0
 move.w d5,d0
 movea.l D00028(a6),a0
 sub.w d0,5108(a0)
 bra.s L12afa
L12af0 move.w d5,d0
 movea.l D00028(a6),a0
 add.w d0,5610(a0)
L12afa jsr _01aea(a6)
 movea.l D00028(a6),a0
 move.l 5018(a0),-(sp)
 moveq #3,d1
 moveq #0,d0
 jsr _01b26(a6)
 addq.l #4,sp
 movem.l -12(a5),a0/d4-d5
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0-a2/d0-d1/d4-d5,-(sp)
 move.l d0,d4
 movea.l D00028(a6),a0
 movea.l 6788(a0),a2
 movea.l D00028(a6),a0
 tst.l 5572(a0)
 beq.s L12b4e
 moveq #46,d0
 cmp.l d4,d0
 bne.s L12b4e
 movea.l D00028(a6),a0
 move.l 5572(a0),d1
 moveq #3,d0
 jsr _01b20(a6)
 bra.w L12ca4
L12b4e moveq #8,d0
 cmp.l d4,d0
 bne.s L12b7a
 movea.l D00028(a6),a0
 cmpi.w #63,5576(a0)
 bge.s L12b7a
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 clr.w 68(a0)
 movea.l D00028(a6),a0
 move.w #1,5634(a0)
 bra.w L12ca4
L12b7a moveq #27,d0
 cmp.l d4,d0
 bne.s L12bb0
 movea.l D00028(a6),a0
 move.b #1,5579(a0)
 movea.l D00028(a6),a0
 clr.w 5570(a0)
 movea.l D00028(a6),a0
 movea.l D00028(a6),a1
 move.w 5106(a0),5580(a1)
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 clr.w 106(a0)
 bra.w L12ca4
L12bb0 moveq #25,d0
 cmp.l d4,d0
 bne.s L12bf4
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 tst.w 316(a0)
 beq.s L12bf4
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 cmpi.w #8,316(a0)
 bge.s L12bf4
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 move.w #1,266(a0)
 movea.l D00028(a6),a0
 move.w 5616(a0),d0
 ext.l d0
 lsl.l #2,d0
 lea _00c8a(a6),a0
 bra.s L12c32
L12bf4 moveq #11,d0
 cmp.l d4,d0
 bgt.s L12c4c
 moveq #17,d0
 cmp.l d4,d0
 blt.s L12c4c
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 tst.w 316(a0)
 bne.s L12c4c
 movea.l D00028(a6),a0
 tst.l 5582(a0)
 bne.s L12c4c
 moveq #11,d0
 sub.l d0,d4
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 move.w #1,266(a0)
 move.l d4,d0
 lsl.l #2,d0
 lea _01016(a6),a0
L12c32 move.l (a0,d0.l),-(sp)
 movea.l _01ae0(a6),a0
 move.l a0,d1
 moveq #4,d0
 bsr.w L1a7bc
 addq.l #4,sp
 moveq #4,d0
 jsr _01afc(a6)
 bra.s L12ca4
L12c4c moveq #0,d5
 bra.s L12c8a
L12c50 movea.l (a2),a0
 moveq #0,d0
 move.w 40(a0),d0
 lsr.l #8,d0
 cmp.l d4,d0
 bne.s L12c82
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 move.w #1,264(a0)
 move.l a2,d1
 moveq #4,d0
 jsr _01b20(a6)
 movea.l D00028(a6),a0
 movea.l 6908(a0),a0
 clr.w 264(a0)
 bra.s L12ca4
L12c82 addq.l #1,d5
 adda.l #54,a2
L12c8a movea.l D00028(a6),a0
 move.w 6796(a0),d0
 ext.l d0
 cmp.l d5,d0
 bgt.s L12c50
 clr.l -(sp)
 moveq #2,d1
 moveq #0,d0
 jsr _01b26(a6)
 addq.l #4,sp
L12ca4 movem.l -24(a5),a0-a2/d1/d4-d5
 unlk a5
 rts 
L12cae link.w a5,#0
 movem.l a0-a3/d0,-(sp)
 movea.l d0,a2
 movea.l (a2),a3
 cmpi.w #6,34(a3)
 beq.s L12cca
 cmpi.w #4,26(a2)
 bne.s L12cd6
L12cca lea L111ae(pc),a0
 movea.l 12(a2),a1
 move.l a0,22(a1)
L12cd6 movea.l 12(a2),a0
 move.w #2,(a0)
 movem.l -16(a5),a0-a3
 unlk a5
 rts 
 dc.w $6733
 move.w d0,d1
 bge.s L12d26
 dc.w $7a
 move.w d0,-(a2)
 dc.w $7335
 ori.w #$3239,97(a1,d0.w)
 dc.w $6231
 move.w d0,-(a3)
 dc.w $6237
 dc.w $73
L12d01 equ *-1
 moveq #95,d0
 dc.w $6465
 dc.w $7363
 dc.w $73
L12d09 equ *-1
 moveq #95,d0
 dc.w $6465
 dc.w $7363
 dc.w $73
L12d11 equ *-1
 moveq #95,d0
 beq.s L12d88
 dc.w $6f75
 moveq #115,d0
 dc.w $73
L12d1b equ *-1
 moveq #95,d0
 moveq #101,d3
 bls.s L12d96
 ble.s L12d96
 dc.w $73
L12d25 equ *-1
L12d26 moveq #95,d0
 moveq #97,d2
 bhi.s L12d98
 bcs.w L1a09e
L12d2e equ *-2
 subq.w #7,-(a3)
 dc.w $6173
 moveq #0,d2
L12d36 dc.w $7370
 subq.w #7,-(a3)
 dc.w $6173
 moveq #0,d2
L12d3e link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
 movea.l 46(a2),a3
 subq.l #1,d4
 tst.l d4
 ble.s L12d5e
 move.l d4,-(sp)
 lea L12d3e(pc),a0
L12d5a move.l a0,d1
 bra.s L12d74
L12d5e cmpi.w #1,26(a3)
 bne.s L12d6e
 clr.l -(sp)
 lea L12f98(pc),a0
 bra.s L12d5a
L12d6e clr.l -(sp)
 move.l 8(a3),d1
L12d74 move.l a2,d0
 bsr.w L17982
 addq.l #4,sp
 cmpi.w #2,26(a3)
 bne.s L12d8e
 move.l a2,d1
 move.l 4(a3),d0
L12d88 equ *-2
 bsr.w L10dbc
L12d8e movem.l -16(a5),a0/a2-a3/d4
 unlk a5
L12d96 rts 
L12d98 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 move.l d1,d4
 movea.l 12(a2),a3
 move.b #240,d0
 and.b d4,d0
 move.b d0,d7
 cmpi.b #16,d7
 bne.s L12dce
 moveq #15,d0
 and.b d4,d0
 moveq #0,d1
 move.b d0,d1
 move.l d1,d5
 move.l d5,d1
 move.l a2,d0
 bsr.w L11d68
 move.w d5,24(a2)
 bra.s L12e28
L12dce cmpi.b #48,d7
 bne.s L12df4
 jsr _01b2c(a6)
 moveq #9,d1
 asr.l d1,d0
 move.w d0,d6
 moveq #0,d0
 move.w d6,d0
 move.l d0,-(sp)
 lea L12d3e(pc),a0
 move.l a0,d1
 move.l a3,d0
 bsr.w L17982
 addq.l #4,sp
 bra.s L12e28
L12df4 cmpi.b #32,d7
 bne.s L12e04
 move.l (a2),d1
 move.l a2,d0
 jsr _01b0e(a6)
 bra.s L12e28
L12e04 cmpi.b #80,d7
 bne.s L12e14
 moveq #15,d0
 and.b d4,d0
 move.b d0,52(a2)
 bra.s L12e28
L12e14 cmpi.b #96,d7
 bne.s L12e28
 move.l a2,d1
 moveq #2,d0
 jsr _01b20(a6)
 move.l a2,d0
 bsr.w L12cae
L12e28 movem.l -28(a5),a0/a2-a3/d4-d7
 unlk a5
 rts 
L12e32 link.w a5,#0
 movem.l a0-a4/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 subq.l #8,sp
 movea.l 46(a2),a4
 moveq #0,d4
 moveq #44,d0
 add.l a4,d0
 move.l d0,d5
 moveq #30,d0
 add.l a4,d0
 move.l d0,d6
 move.l 4(a4),d7
 movea.w 24(a4),a0
 move.l a0,(sp)
 movea.l d5,a0
 move.w (a0),d0
 ext.l d0
 movea.l d6,a0
 move.w (a0),d1
 ext.l d1
 sub.l d0,d1
 move.l d1,d0
 jsr _0196a(a6)
 move.w d0,4(sp)
 movea.l d5,a0
 move.w 2(a0),d0
 ext.l d0
 movea.l d6,a0
 move.w 2(a0),d1
 ext.l d1
 sub.l d0,d1
 move.l d1,d0
 jsr _0196a(a6)
 move.w d0,6(sp)
 cmpi.w #4,4(sp)
 ble.s L12e9e
 move.w #4,4(sp)
L12e9e cmpi.w #4,6(sp)
 ble.s L12eac
 move.w #4,6(sp)
L12eac movea.l d6,a0
 movea.l d5,a1
 move.w (a1),d0
 cmp.w (a0),d0
 bge.s L12ec8
 move.w 4(sp),d0
 movea.l d5,a0
 add.w d0,(a0)
 moveq #1,d4
 move.w #1,24(a4)
 bra.s L12ee2
L12ec8 movea.l d6,a0
 movea.l d5,a1
 move.w (a1),d0
 cmp.w (a0),d0
 ble.s L12ee2
 move.w 4(sp),d0
 movea.l d5,a0
 sub.w d0,(a0)
 moveq #1,d4
 move.w #3,24(a4)
L12ee2 movea.l d6,a0
 movea.l d5,a1
 move.w 2(a1),d0
 cmp.w 2(a0),d0
 bge.s L12f04
 move.w 6(sp),d0
 movea.l d5,a0
 add.w d0,2(a0)
 moveq #1,d4
 move.w #2,24(a4)
 bra.s L12f22
L12f04 movea.l d6,a0
 movea.l d5,a1
 move.w 2(a1),d0
 cmp.w 2(a0),d0
 ble.s L12f22
 move.w 6(sp),d0
 movea.l d5,a0
 sub.w d0,2(a0)
 moveq #1,d4
 clr.w 24(a4)
L12f22 move.l a2,d1
 move.l a4,d0
 bsr.w L10d92
 move.l a2,d1
 move.l d7,d0
 bsr.w L10dbc
 move.w 24(a4),d0
 ext.l d0
 cmp.l (sp),d0
 beq.s L12f48
 movea.w 24(a4),a0
 move.l a0,d1
 move.l a4,d0
 bsr.w L11d68
L12f48 tst.w d4
 bne.s L12f8c
 cmpi.w #4,50(a2)
 beq.s L12f6a
 clr.l -(sp)
 lea L12f98(pc),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L17982
 addq.l #4,sp
 clr.b 48(a4)
 bra.s L12f8c
L12f6a clr.l -(sp)
 movea.l _01b3a(a6),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L17982
 addq.l #4,sp
 movea.l D00028(a6),a0
 clr.w 5100(a0)
 movea.l D00028(a6),a0
 move.w #1,5570(a0)
L12f8c addq.l #8,sp
 movem.l -36(a5),a0-a4/d4-d7
 unlk a5
 rts 
L12f98 link.w a5,#0
 movem.l a0-a4/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 lea -10(sp),sp
 movea.l 46(a2),a4
 move.l 8(a4),d4
 movea.l d4,a0
 move.l 6(a0),d6
 movea.l D00028(a6),a0
 move.l 5018(a0),d7
 move.l (a4),4(sp)
 movea.l d7,a0
 move.l (a0),(sp)
 movea.l d4,a0
 movea.l d4,a1
 move.l 6(a1),d0
 sub.l 10(a0),d0
 bge.s L12fd6
 addq.l #1,d0
L12fd6 asr.l #1,d0
 movea.l d4,a0
 move.w 4(a0),d1
 ext.l d1
 cmp.l d1,d0
 blt.w L13074
 clr.l 26(a2)
 cmpi.w #6,26(a4)
 beq.s L12ffc
 move.l a4,d0
 bsr.w L1251e
 bra.w L13122
L12ffc movea.l D00028(a6),a0
 clr.l 5582(a0)
 clr.l 18(a2)
 lea L12a34(pc),a0
 move.l a0,26(a2)
 move.l a4,d1
 moveq #0,d0
 jsr _01b20(a6)
 movea.l D00028(a6),a0
 clr.w 5570(a0)
 move.w 44(a4),d0
 movea.l 4(sp),a0
 move.w 2(a0),d1
 asr.w #1,d1
 add.w d1,d0
 movea.l (sp),a0
 move.w 2(a0),d1
 asr.w #1,d1
 sub.w d1,d0
 movea.l d7,a0
 move.w d0,30(a0)
 move.w 46(a4),d0
 movea.l 4(sp),a0
 move.w (a0),d1
 asr.w #1,d1
 add.w d1,d0
 movea.l (sp),a0
 sub.w (a0),d0
 addi.w #$0014,d0
 movea.l d7,a0
 move.w d0,32(a0)
 clr.l -(sp)
 lea L12e32(pc),a0
 move.l a0,d1
 movea.l d7,a0
 move.l 12(a0),d0
 bsr.w L17982
 addq.l #4,sp
 bra.w L13122
L13074 movea.l d6,a0
 move.w (a0),d0
 lsr.w #4,d0
 andi.b #$0f,d0
 subq.b #8,d0
 move.b d0,9(sp)
 movea.l d6,a0
 moveq #15,d0
 and.b 1(a0),d0
 subq.b #8,d0
 move.b d0,8(sp)
 move.b 9(sp),d0
 ext.w d0
 add.w d0,44(a4)
 move.b 8(sp),d0
 ext.w d0
 add.w d0,46(a4)
 move.l a2,d1
 move.l a4,d0
 bsr.w L10d92
 cmpi.w #6,26(a4)
 bne.s L130f6
 move.b 9(sp),d0
 ext.w d0
 movea.l d7,a0
 add.w d0,44(a0)
 move.b 8(sp),d0
 ext.w d0
 movea.l d7,a0
 add.w d0,46(a0)
 move.b 8(sp),d0
 ext.w d0
 ext.l d0
 move.l d0,-(sp)
 move.b 13(sp),d0
 ext.w d0
 ext.l d0
 move.l d0,d1
 move.l d7,d0
 jsr _01b02(a6)
 addq.l #4,sp
 movea.l d7,a0
 move.l 12(a0),d1
 move.l d7,d0
 bsr.w L10d92
L130f6 movea.l d6,a0
 move.w #-256,d0
 and.w (a0),d0
 lsr.w #8,d0
 move.b d0,d5
 tst.b d5
 beq.s L13112
 moveq #0,d0
 move.b d5,d0
 move.l d0,d1
 move.l a4,d0
 bsr.w L12d98
L13112 move.l a2,d1
 move.l 4(a4),d0
 bsr.w L10dbc
 movea.l d4,a0
 addq.l #2,6(a0)
L13122 lea 10(sp),sp
 movem.l -36(a5),a0-a4/d4-d7
 unlk a5
 rts 
L13130 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d6,-(sp)
 move.l d0,d4
 movea.l d1,a2
 movea.l 44(sp),a3
 moveq #1,d1
 moveq #3,d0
 bsr.w L1afe6
 movea.l d0,a4
 tst.l d0
 beq.s L1315e
 move.l a4,d0
 bsr.w L1b05c
 move.l d0,d5
 bne.s L13164
 move.l a4,d0
 jsr _019ee(a6)
L1315e moveq #255,d0
 bra.w L131ea
L13164 move.l #1,(a3)
 move.l d5,d6
 bra.s L13192
L1316e lea L14222(pc),a0
 move.l a0,d0
 jsr _01850(a6)
 move.l d0,-(sp)
 lea L14225(pc),a0
 move.l a0,d1
 move.l d6,d0
 addq.l #1,d6
 jsr _01b56(a6)
 addq.l #4,sp
 tst.l d0
 bne.s L13192
 clr.l (a3)
 bra.s L13198
L13192 movea.l d6,a0
 tst.b (a0)
 bne.s L1316e
L13198 clr.l (a2)
 move.l d5,d6
 bra.s L131ce
L1319e lea L14228(pc),a0
 move.l a0,d0
 jsr _01850(a6)
 move.l d0,-(sp)
 lea L1422c(pc),a0
 move.l a0,d1
 move.l d6,d0
 addq.l #1,d6
 jsr _01b56(a6)
 addq.l #4,sp
 tst.l d0
 bne.s L131ce
 move.l #1,(a2)
 moveq #1,d0
 cmp.l (a3),d0
 bne.s L131d4
 clr.l (a3)
 bra.s L131d4
L131ce movea.l d6,a0
 tst.b (a0)
 bne.s L1319e
L131d4 move.l a4,d0
 jsr _019ee(a6)
 move.l d5,d0
 jsr _019ee(a6)
 move.l (a3),d1
 move.l d4,d0
 jsr _01b4a(a6)
 moveq #0,d0
L131ea movem.l -28(a5),a0/a2-a4/d4-d6
 unlk a5
 rts 
L131f4 link.w a5,#0
 movem.l a0/a2/d0,-(sp)
 movea.l (sp),a0
 movea.l 56(a0),a2
 movea.l (sp),a0
 move.l 12(a2),56(a0)
 clr.l 12(a2)
 clr.l 8(a2)
 move.l a2,d0
 movem.l -8(a5),a0/a2
 unlk a5
 rts 
L1321e link.w a5,#0
 movem.l a0/a2/d0-d1,-(sp)
 movea.l (sp),a0
 movea.l 48(a0),a2
 movea.l 4(sp),a0
 move.l a2,12(a0)
 move.l a2,d0
 beq.s L1323e
 move.l 4(sp),8(a2)
L1323e movea.l (sp),a0
 move.l 4(sp),48(a0)
 movea.l 4(sp),a0
 clr.l 8(a0)
 movea.l 4(sp),a0
 move.l 24(sp),(a0)
 movea.l 4(sp),a0
 move.l 28(sp),4(a0)
 movem.l -8(a5),a0/a2
 unlk a5
 rts 
L1326a link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 movea.l 4(sp),a0
 tst.l 8(a0)
 beq.s L132ac
 movea.l 4(sp),a0
 movea.l 4(sp),a1
 movea.l 8(a1),a1
 move.l 12(a0),12(a1)
 movea.l 4(sp),a0
 tst.l 12(a0)
 beq.s L132ce
 movea.l 4(sp),a0
 movea.l 4(sp),a1
 movea.l 12(a1),a1
 move.l 8(a0),8(a1)
 bra.s L132ce
L132ac movea.l 4(sp),a0
 movea.l (sp),a1
 move.l 12(a0),48(a1)
 movea.l 4(sp),a0
 tst.l 12(a0)
 beq.s L132ce
 movea.l 4(sp),a0
 movea.l 12(a0),a0
 clr.l 8(a0)
L132ce movea.l (sp),a0
 movea.l 4(sp),a1
 move.l 56(a0),12(a1)
 movea.l (sp),a0
 move.l 4(sp),56(a0)
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L132ec link.w a5,#0
 movem.l d0-d1/d4-d6,-(sp)
 move.l d0,d4
 move.l d1,d5
 pea (L0008e).w
 move.l d4,d1
 move.l d5,d0
 jsr _01b44(a6)
 addq.l #4,sp
 move.l d0,d6
 moveq #255,d0
 cmp.l d6,d0
 bne.s L13318
 bsr.w L1a6ba
 moveq #255,d0
 bra.w L13474
L13318 tst.l d4
 bne.s L1336a
 move.l #-1073736941,-(sp)
 clr.l -(sp)
 move.l d6,d1
 move.l d5,d0
 jsr _01b50(a6)
 addq.l #8,sp
 move.l #-1048573951,-(sp)
 pea (L00001).w
 move.l d6,d1
 move.l d5,d0
 jsr _01b50(a6)
 addq.l #8,sp
 move.l #-1040187392,-(sp)
 pea (L00002).w
 move.l d6,d1
 move.l d5,d0
 jsr _01b50(a6)
 addq.l #8,sp
 move.l #-671088640,-(sp)
 pea (L00008).w
 move.l d6,d1
 move.l d5,d0
 jsr _01b50(a6)
 addq.l #8,sp
L1336a tst.l d4
 bne.s L13376
 move.l #-1006632960,d0
 bra.s L1337c
L13376 move.l #-973078528,d0
L1337c move.l d0,-(sp)
 pea (L00003).w
 move.l d6,d1
 move.l d5,d0
 jsr _01b50(a6)
 addq.l #8,sp
 tst.l d4
 bne.s L13398
 move.l #-956301312,d0
 bra.s L1339e
L13398 move.l #-922746880,d0
L1339e move.l d0,-(sp)
 pea (L00004).w
 move.l d6,d1
 move.l d5,d0
 jsr _01b50(a6)
 addq.l #8,sp
 tst.l d4
 bne.s L133ba
 move.l #-654311424,d0
 bra.s L133c0
L133ba move.l #-637534208,d0
L133c0 move.l d0,-(sp)
 pea (L00005).w
 move.l d6,d1
 move.l d5,d0
 jsr _01b50(a6)
 addq.l #8,sp
 tst.l d4
 bne.s L133dc
 move.l #-620756992,d0
 bra.s L133e2
L133dc move.l #-603979776,d0
L133e2 move.l d0,-(sp)
 pea (L00006).w
 move.l d6,d1
 move.l d5,d0
 jsr _01b50(a6)
 addq.l #8,sp
 move.l #2013266944,-(sp)
 pea (L00007).w
 move.l d6,d1
 move.l d5,d0
 jsr _01b50(a6)
 addq.l #8,sp
 tst.l d4
 bne.s L13412
 move.l #-905969664,d0
 bra.s L13418
L13412 move.l #-889192448,d0
L13418 bset.l #23,d0
 bset.l #15,d0
 bset.l #7,d0
 move.l d0,-(sp)
 pea (L00009).w
 move.l d6,d1
 move.l d5,d0
 jsr _01b50(a6)
 addq.l #8,sp
 move.l d4,d0
 lsl.l #1,d0
 moveq #3,d1
 and.l d1,d0
 ori.l #$c3000000,d0
 move.l d0,-(sp)
 pea (L0000a).w
 move.l d6,d1
 move.l d5,d0
 jsr _01b50(a6)
 addq.l #8,sp
 move.l d4,d0
 lsl.l #1,d0
 addq.l #1,d0
 moveq #3,d1
 and.l d1,d0
 ori.l #$c3000000,d0
 move.l d0,-(sp)
 pea (L0004c).w
 move.l d6,d1
 move.l d5,d0
 jsr _01b50(a6)
 addq.l #8,sp
 move.l d6,d0
L13474 movem.l -12(a5),d4-d6
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0-a3/d0-d1/d4,-(sp)
 tst.l (sp)
 beq.w L1354a
 moveq #1,d1
 moveq #3,d0
 bsr.w L1afe6
 movea.l d0,a2
 tst.l d0
 beq.w L13546
 moveq #1,d1
 move.l a2,d0
 jsr _01a06(a6)
 movea.l (sp),a0
 move.l d0,8(a0)
 moveq #255,d1
 cmp.l d0,d1
 beq.w L13546
 move.l a2,d0
 jsr _019ee(a6)
 moveq #0,d4
 bra.w L135a2
L134be movea.l (sp),a0
 move.l 8(a0),d1
 moveq #0,d0
 bsr.w L132ec
 move.l d4,d1
 lsl.l #3,d1
 movea.l (sp),a0
 move.l d0,16(a0,d1.l)
 movea.l (sp),a0
 move.l 8(a0),d1
 moveq #1,d0
 bsr.w L132ec
 move.l d4,d1
 lsl.l #3,d1
 movea.l (sp),a0
 move.l d0,32(a0,d1.l)
 clr.l -(sp)
 pea (L0020a).w
 moveq #0,d1
 movea.l 8(sp),a0
 move.l 8(a0),d0
 bsr.w L1b3da
 addq.l #8,sp
 move.l d4,d1
 lsl.l #3,d1
 movea.l (sp),a0
 move.l d0,20(a0,d1.l)
 clr.l -(sp)
 pea (L0020a).w
 moveq #1,d1
 movea.l 8(sp),a0
 move.l 8(a0),d0
 bsr.w L1b3da
 addq.l #8,sp
 move.l d4,d1
 lsl.l #3,d1
 movea.l (sp),a0
 move.l d0,36(a0,d1.l)
 move.l d4,d0
 lsl.l #3,d0
 movea.l (sp),a0
 moveq #255,d1
 cmp.l 20(a0,d0.l),d1
 beq.s L13546
 move.l d4,d0
 lsl.l #3,d0
 movea.l (sp),a0
 moveq #255,d1
 cmp.l 36(a0,d0.l),d1
 bne.s L13550
L13546 bsr.w L1a6ba
L1354a moveq #255,d0
 bra.w L13982
L13550 clr.l -(sp)
 move.l d4,d0
 lsl.l #3,d0
 movea.l 4(sp),a0
 move.l 20(a0,d0.l),-(sp)
 move.l d4,d0
 lsl.l #3,d0
 movea.l 8(sp),a0
 move.l 16(a0,d0.l),d1
 movea.l 8(sp),a0
 move.l 8(a0),d0
 bsr.w L1b444
 addq.l #8,sp
 clr.l -(sp)
 move.l d4,d0
 lsl.l #3,d0
 movea.l 4(sp),a0
 move.l 36(a0,d0.l),-(sp)
 move.l d4,d0
 lsl.l #3,d0
 movea.l 8(sp),a0
 move.l 32(a0,d0.l),d1
 movea.l 8(sp),a0
 move.l 8(a0),d0
 bsr.w L1b444
 addq.l #8,sp
 addq.l #1,d4
L135a2 moveq #2,d0
 cmp.l d4,d0
 bgt.w L134be
 move.l #-620756992,-(sp)
 pea (L00003).w
 pea (L00208).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 movea.l 12(sp),a0
 move.l 8(a0),d0
 bsr.w L197f4
 bsr.w L1b47a
 lea 12(sp),sp
 move.l #-620756992,-(sp)
 pea (L00003).w
 pea (L00208).w
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L135fc
 moveq #1,d0
 bra.s L135fe
L135fc moveq #0,d0
L135fe lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 movea.l 12(sp),a0
 move.l 8(a0),d0
 bsr.w L197f4
 bsr.w L1b47a
 lea 12(sp),sp
 move.l #-603979776,-(sp)
 pea (L00003).w
 pea (L00208).w
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d1
 movea.l 12(sp),a0
 move.l 8(a0),d0
 bsr.w L197f4
 bsr.w L1b47a
 lea 12(sp),sp
 move.l #-603979776,-(sp)
 pea (L00003).w
 pea (L00208).w
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L1366e
 moveq #1,d0
 bra.s L13670
L1366e moveq #0,d0
L13670 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d1
 movea.l 12(sp),a0
 move.l 8(a0),d0
 bsr.w L197f4
 bsr.w L1b47a
 lea 12(sp),sp
 move.l #-1048573944,-(sp)
 pea (L00006).w
 pea (L00208).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 movea.l 12(sp),a0
 move.l 8(a0),d0
 bsr.w L197f4
 bsr.w L1b47a
 lea 12(sp),sp
 move.l #-1048573944,-(sp)
 pea (L00006).w
 pea (L00208).w
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L136e0
 moveq #1,d0
 bra.s L136e2
L136e0 moveq #0,d0
L136e2 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 movea.l 12(sp),a0
 move.l 8(a0),d0
 bsr.w L197f4
 bsr.w L1b47a
 lea 12(sp),sp
 movea.l (sp),a0
 clr.w 12(a0)
 movea.l (sp),a0
 clr.w 14(a0)
 move.l #128,d1
 moveq #48,d0
 bsr.w L1aa4e
 movea.l (sp),a0
 move.l d0,52(a0)
 movea.l (sp),a0
 tst.l 52(a0)
 bne.s L1372a
 bsr.w L1a6ba
L1372a movea.l (sp),a0
 clr.l 48(a0)
 movea.l (sp),a0
 movea.l (sp),a1
 move.l 52(a0),56(a1)
 moveq #0,d4
 movea.l (sp),a0
 movea.l 52(a0),a3
 bra.s L13758
L13744 moveq #16,d0
 add.l a3,d0
 move.l d0,12(a3)
 clr.l 8(a3)
 addq.l #1,d4
 adda.l #16,a3
L13758 moveq #2,d0
 cmp.l d4,d0
 bgt.s L13744
 clr.l 12(a3)
 clr.l 8(a3)
 movea.l (sp),a0
 clr.w 60(a0)
 movea.l (sp),a0
 move.l 8(a0),d0
 bsr.w L1a9fa
 pea (L00080).w
 moveq #16,d1
 movea.l 4(sp),a0
 move.l 8(a0),d0
 bsr.w L19a5a
 addq.l #4,sp
 movea.l (sp),a0
 move.l d0,4(a0)
 movea.l (sp),a0
 tst.l 4(a0)
 bne.s L1379c
 bsr.w L1a6ba
L1379c movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 movea.l 4(sp),a0
 move.l 4(a0),d0
 bsr.w L1990e
 addq.l #4,sp
 movea.l (sp),a0
 move.l 4(a0),d0
 bsr.w L19c1a
 movea.l (sp),a0
 move.l 4(a0),d0
 bsr.w L19958
 pea (L00001).w
 pea (L00001).w
 move.l #128,d1
 movea.l 8(sp),a0
 move.l 4(a0),d0
 bsr.w L18c8c
 addq.l #8,sp
 moveq #255,d1
 cmp.l d0,d1
 bne.s L1380c
 bsr.w L1a6ba
L1380c movea.l (sp),a0
 move.l 4(a0),d0
 bsr.w L192fa
 movea.l (sp),a0
 move.l 4(a0),d0
 bsr.w L19a00
 movea.l (sp),a0
 pea 68(a0)
 moveq #62,d0
 add.l 4(sp),d0
 move.l d0,d1
 movea.l 4(sp),a0
 move.l 8(a0),d0
 bsr.w L13130
 addq.l #4,sp
 movea.l (sp),a0
 tst.l 62(a0)
 beq.w L13960
 movea.l (sp),a0
 move.w #40,66(a0)
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),-(sp)
 pea (L00208).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 movea.l 12(sp),a0
 move.l 8(a0),d0
 bsr.w L1b46e
 lea 12(sp),sp
 clr.l -(sp)
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L1389c
 moveq #1,d0
 bra.s L1389e
L1389c moveq #0,d0
L1389e lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),-(sp)
 pea (L00208).w
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L138ba
 moveq #1,d0
 bra.s L138bc
L138ba moveq #0,d0
L138bc lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 movea.l 12(sp),a0
 move.l 8(a0),d0
 bsr.w L1b46e
 lea 12(sp),sp
 clr.l -(sp)
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),-(sp)
 pea (L00208).w
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d1
 movea.l 12(sp),a0
 move.l 8(a0),d0
 bsr.w L1b46e
 lea 12(sp),sp
 clr.l -(sp)
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L13924
 moveq #1,d0
 bra.s L13926
L13924 moveq #0,d0
L13926 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),-(sp)
 pea (L00208).w
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L13942
 moveq #1,d0
 bra.s L13944
L13942 moveq #0,d0
L13944 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d1
 movea.l 12(sp),a0
 move.l 8(a0),d0
 bsr.w L1b46e
 lea 12(sp),sp
 bra.s L13966
L13960 movea.l (sp),a0
 clr.w 66(a0)
L13966 lea L14230(pc),a0
 move.l a0,d0
 jsr _01b3e(a6)
 movea.l D00028(a6),a0
 move.l d0,182(a0)
 movea.l D00028(a6),a0
 move.w #478,80(a0)
L13982 movem.l -24(a5),a0-a3/d1/d4
 unlk a5
 rts 
L1398c link.w a5,#0
 movem.l a0/a2/d0-d1/d4-d6,-(sp)
 move.l d0,d4
 move.l d1,d5
 move.l 36(sp),d6
 movea.l 40(sp),a2
 tst.l d5
 bne.s L139ac
 move.l #-620756992,d0
 bra.s L139b2
L139ac move.l #-603979776,d0
L139b2 moveq #63,d1
 and.l d6,d1
 or.l d1,d0
 move.l d0,-(sp)
 pea (L00003).w
 movea.w 66(a2),a0
 move.l a0,-(sp)
 move.l d4,d1
 move.l 8(a2),d0
 bsr.w L197f4
 bsr.w L1b47a
 lea 12(sp),sp
 bsr.w L19814
 movem.l -20(a5),a0/a2/d4-d6
 unlk a5
 rts 
L139e4 link.w a5,#0
 movem.l a2-a3/d0-d2/d4-d5,-(sp)
 move.l d0,d4
 movea.l d1,a2
 move.l 36(sp),d5
 movea.l 40(sp),a3
 move.l #16777215,d0
 and.l 4(a2),d0
 bset.l #30,d0
 move.l d0,-(sp)
 clr.l -(sp)
 move.w 66(a3),d0
 ext.l d0
 move.l d5,d1
 lsl.l #1,d1
 add.l d1,d0
 move.l d0,-(sp)
 move.l d4,d1
 move.l 8(a3),d0
 bsr.w L197f4
 bsr.w L1b47a
 lea 12(sp),sp
 tst.w 12(a2)
 bne.s L13a38
 move.l #-1006632960,d0
 bra.s L13a3e
L13a38 move.l #-973078528,d0
L13a3e move.l 8(a2),d1
 moveq #16,d2
 asr.l d2,d1
 andi.l #$000000ff,d1
 moveq #16,d2
 lsl.l d2,d1
 or.l d1,d0
 move.l 8(a2),d1
 asr.l #8,d1
 andi.l #$000000ff,d1
 lsl.l #8,d1
 or.l d1,d0
 move.l #255,d1
 and.l 8(a2),d1
 or.l d1,d0
 move.l d0,-(sp)
 pea (L00006).w
 move.w 66(a3),d0
 ext.l d0
 move.l d5,d1
 lsl.l #1,d1
 add.l d1,d0
 move.l d0,-(sp)
 move.l d4,d1
 move.l 8(a3),d0
 bsr.w L197f4
 bsr.w L1b47a
 lea 12(sp),sp
 bsr.w L19814
 movem.l -20(a5),a2-a3/d2/d4-d5
 unlk a5
 rts 
L13aa2 link.w a5,#0
 movem.l a0/a2/d0-d1/d4-d6,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l 36(sp),d5
 move.l 40(sp),d6
 moveq #15,d0
 and.l d6,d0
 lsl.l #8,d0
 ori.l #$c0001010,d0
 moveq #15,d1
 and.l d5,d1
 or.l d1,d0
 move.l d0,-(sp)
 pea (L00004).w
 movea.w 66(a2),a0
 move.l a0,-(sp)
 move.l d4,d1
 move.l 8(a2),d0
 bsr.w L197f4
 bsr.w L1b47a
 lea 12(sp),sp
 bsr.w L19814
 movem.l -20(a5),a0/a2/d4-d6
 unlk a5
 rts 
L13af4 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l (sp),a0
 tst.w 12(a0)
 bne.s L13b08
 moveq #1,d0
 bra.s L13b0a
L13b08 moveq #0,d0
L13b0a movea.l (sp),a0
 move.w d0,12(a0)
 movea.l (sp),a0
 tst.w 14(a0)
 bne.s L13b1c
 moveq #1,d0
 bra.s L13b1e
L13b1c moveq #0,d0
L13b1e movea.l (sp),a0
 move.w d0,14(a0)
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 32(a0,d0.l),-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 movea.l 4(sp),a0
 move.l 4(a0),d0
 bsr.w L1990e
 addq.l #4,sp
 movea.l (sp),a0
 move.l 4(a0),d0
 bsr.w L19a00
 movea.l (sp),a0
 move.l 68(a0),d1
 movea.l (sp),a0
 move.l 8(a0),d0
 bsr.w L1b42c
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
L13b7e link.w a5,#0
 movem.l a0-a1/d0-d1/d4,-(sp)
 movea.l 4(sp),a0
 move.w 34(a0),d0
 movea.l 4(sp),a0
 add.w d0,18(a0)
 movea.l 4(sp),a0
 tst.w 12(a0)
 bne.s L13bb6
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d4
 bra.s L13bca
L13bb6 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d4
L13bca movea.l 4(sp),a0
 movea.l 4(sp),a1
 move.w 18(a1),d0
 cmp.w 20(a0),d0
 blt.s L13c4c
 movea.l 4(sp),a0
 move.l (a0),-(sp)
 movea.l 8(sp),a0
 movea.w 20(a0),a0
 move.l a0,-(sp)
 movea.l 12(sp),a0
 movea.w 12(a0),a0
 move.l a0,d1
 move.l d4,d0
 bsr.w L1398c
 addq.l #8,sp
 movea.l 4(sp),a0
 move.l 36(a0),d1
 movea.l 4(sp),a0
 move.l (a0),d0
 bsr.w L1326a
 movea.l 4(sp),a0
 clr.l 36(a0)
 movea.l 4(sp),a0
 movea.l 4(sp),a1
 move.w 20(a0),18(a1)
 movea.l 4(sp),a0
 tst.l 22(a0)
 beq.s L13c6e
 movea.l 4(sp),a0
 move.l 26(a0),-(sp)
 movea.l 8(sp),a0
 move.l 22(a0),d1
 move.l 4(sp),d0
 bsr.w L1a7bc
 addq.l #4,sp
 bra.s L13c6e
L13c4c movea.l 4(sp),a0
 move.l (a0),-(sp)
 movea.l 8(sp),a0
 movea.w 18(a0),a0
 move.l a0,-(sp)
 movea.l 12(sp),a0
 movea.w 12(a0),a0
 move.l a0,d1
 move.l d4,d0
 bsr.w L1398c
 addq.l #8,sp
L13c6e movem.l -12(a5),a0-a1/d4
 unlk a5
 rts 
L13c78 link.w a5,#0
 movem.l a0-a1/d0-d1/d4,-(sp)
 movea.l 4(sp),a0
 move.w 34(a0),d0
 movea.l 4(sp),a0
 sub.w d0,18(a0)
 movea.l 4(sp),a0
 tst.w 12(a0)
 bne.s L13cb0
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d4
 bra.s L13cc4
L13cb0 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d4
L13cc4 movea.l 4(sp),a0
 movea.l 4(sp),a1
 move.w 18(a1),d0
 cmp.w 20(a0),d0
 bgt.s L13d46
 movea.l 4(sp),a0
 movea.l 4(sp),a1
 move.w 20(a0),18(a1)
 movea.l 4(sp),a0
 move.l (a0),-(sp)
 movea.l 8(sp),a0
 movea.w 20(a0),a0
 move.l a0,-(sp)
 movea.l 12(sp),a0
 movea.w 12(a0),a0
 move.l a0,d1
 move.l d4,d0
 bsr.w L1398c
 addq.l #8,sp
 movea.l 4(sp),a0
 move.l 36(a0),d1
 movea.l 4(sp),a0
 move.l (a0),d0
 bsr.w L1326a
 movea.l 4(sp),a0
 clr.l 36(a0)
 movea.l 4(sp),a0
 tst.l 22(a0)
 beq.s L13d68
 movea.l 4(sp),a0
 move.l 26(a0),-(sp)
 movea.l 8(sp),a0
 move.l 22(a0),d1
 move.l 4(sp),d0
 bsr.w L1a7bc
 addq.l #4,sp
 bra.s L13d68
L13d46 movea.l 4(sp),a0
 move.l (a0),-(sp)
 movea.l 8(sp),a0
 movea.w 18(a0),a0
 move.l a0,-(sp)
 movea.l 12(sp),a0
 movea.w 12(a0),a0
 move.l a0,d1
 move.l d4,d0
 bsr.w L1398c
 addq.l #8,sp
L13d68 movem.l -12(a5),a0-a1/d4
 unlk a5
 rts 
L13d72 link.w a5,#0
 movem.l a2/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l 28(sp),d5
 moveq #1,d0
 cmp.l d5,d0
 bne.s L13d8c
 moveq #2,d5
 bra.s L13d8e
L13d8c moveq #0,d5
L13d8e moveq #3,d0
 and.l d5,d0
 ori.l #$78000400,d0
 move.l d0,-(sp)
 pea (L00007).w
 move.l d4,d1
 move.l 8(a2),d0
 bsr.w L197f4
 bsr.w L1b486
 addq.l #8,sp
 bsr.w L19814
 movem.l -12(a5),a2/d4-d5
 unlk a5
 rts 
L13dbc link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 moveq #1,d0
 and.l (sp),d0
 moveq #23,d1
 lsl.l d1,d0
 ori.l #$c1000801,d0
 move.l d0,-(sp)
 pea (L00001).w
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 bsr.w L197f4
 bsr.w L1b486
 addq.l #8,sp
 bsr.w L19814
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
L13e0c link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 moveq #7,d0
 and.l (sp),d0
 ori.l #$c2000000,d0
 move.l d0,-(sp)
 pea (L00002).w
 move.l 12(sp),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 bsr.w L197f4
 bsr.w L1b486
 addq.l #8,sp
 bsr.w L19814
 movem.l -4(a5),a0
 unlk a5
 rts 
L13e48 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 moveq #1,d0
 bsr.w L13dbc
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 16(a0,d0.l),d1
 movea.l 4(sp),a0
 move.l (a0),d0
 bsr.s L13e0c
 movea.l 4(sp),a0
 tst.l 4(a0)
 beq.s L13e96
 movea.l 4(sp),a0
 move.l 8(a0),-(sp)
 movea.l 8(sp),a0
 move.l 4(a0),d1
 move.l 4(sp),d0
 bsr.w L1a7bc
 addq.l #4,sp
L13e96 movem.l -4(a5),a0
 unlk a5
 rts 
L13ea0 link.w a5,#0
 movem.l a0/a2-a3/d0-d1,-(sp)
 movea.l 4(sp),a0
 movea.l 48(a0),a2
 move.l a2,d0
 bne.s L13ef2
 movea.l 4(sp),a0
 clr.w 60(a0)
 movea.l 4(sp),a0
 tst.l 72(a0)
 beq.s L13f10
 movea.l 4(sp),a0
 move.l 76(a0),-(sp)
 movea.l 8(sp),a0
 move.l 72(a0),d1
 move.l 4(sp),d0
 bsr.w L1a7bc
 addq.l #4,sp
 bra.s L13f10
L13ee2 movea.l 12(a2),a3
 move.l 4(a2),d1
 move.l (sp),d0
 movea.l (a2),a0
 jsr (a0)
 movea.l a3,a2
L13ef2 move.l a2,d0
 bne.s L13ee2
 clr.l -(sp)
 move.l 8(sp),-(sp)
 lea L13ea0(pc),a0
 move.l a0,d1
 movea.l 12(sp),a0
 move.l 4(a0),d0
 bsr.w L18e50
 addq.l #8,sp
L13f10 movem.l -12(a5),a0/a2-a3
 unlk a5
 rts 
L13f1a link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l (sp),a0
 tst.w 60(a0)
 bne.s L13f4c
 movea.l (sp),a0
 move.w #1,60(a0)
 clr.l -(sp)
 move.l 4(sp),-(sp)
 lea L13ea0(pc),a0
 move.l a0,d1
 movea.l 8(sp),a0
 move.l 4(a0),d0
 bsr.w L18e50
 addq.l #8,sp
L13f4c movem.l -8(a5),a0/d1
 unlk a5
 rts 
L13f56 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l 48(sp),d5
 movea.l 52(sp),a3
 movea.l 56(sp),a4
 move.l 60(sp),d6
 move.l 64(sp),d7
 subq.l #4,sp
 move.w d4,18(a2)
 move.w d5,20(a2)
 movea.l (a2),a0
 move.l a3,72(a0)
 movea.l (a2),a0
 move.l a4,76(a0)
 move.w d7,34(a2)
 clr.l 22(a2)
 clr.l 26(a2)
 tst.w 12(a2)
 bne.s L13fb4
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),(sp)
 bra.s L13fc8
L13fb4 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),(sp)
L13fc8 move.l (a2),-(sp)
 movea.w 18(a2),a0
 move.l a0,-(sp)
 movea.w 12(a2),a0
 move.l a0,d1
 move.l 8(sp),d0
 bsr.w L1398c
 addq.l #8,sp
 move.l (a2),d0
 bsr.w L131f4
 move.l d0,36(a2)
 tst.l d6
 bne.s L13ff6
 pea (a2)
 pea L13b7e(pc)
 bra.s L13ffc
L13ff6 pea (a2)
 pea L13c78(pc)
L13ffc move.l 36(a2),d1
 move.l (a2),d0
 bsr.w L1321e
 addq.l #8,sp
 move.l (a2),d0
 bsr.w L13f1a
 addq.l #4,sp
 movem.l -32(a5),a0/a2-a4/d4-d7
 unlk a5
 rts 
L1401a link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l 40(sp),d4
 movea.l 44(sp),a4
 move.l 48(sp),d5
 tst.w 12(a2)
 bne.s L14046
 movea.l D00028(a6),a0
 move.l #1,9968(a0)
 bra.s L1404e
L14046 movea.l D00028(a6),a0
 clr.l 9968(a0)
L1404e movea.l D00028(a6),a0
 move.l a4,9972(a0)
 movea.l D00028(a6),a0
 move.l d5,9976(a0)
 moveq #0,d0
 bsr.w L13dbc
 move.l d4,-(sp)
 pea (L00002).w
 clr.l -(sp)
 clr.l -(sp)
 clr.l -(sp)
 moveq #63,d1
 move.l a2,d0
 bsr.w L13f56
 lea 20(sp),sp
 move.l d4,-(sp)
 clr.l -(sp)
 movea.l D00028(a6),a0
 pea 9968(a0)
 pea L13e48(pc)
 pea (L0003f).w
 moveq #0,d1
 move.l a3,d0
 bsr.w L13f56
 lea 20(sp),sp
 movem.l -24(a5),a0/a2-a4/d4-d5
 unlk a5
 rts 
L140a6 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 moveq #1,d0
 cmp.l 4(sp),d0
 bne.s L140be
 move.l #1610612736,-(sp)
 bra.s L140c4
L140be move.l #268435456,-(sp)
L140c4 pea (L00007).w
 movea.l D00028(a6),a0
 move.w 66(a0),d0
 ext.l d0
 movea.l D00028(a6),a0
 move.w 80(a0),d1
 ext.l d1
 add.l d1,d0
 move.l d0,-(sp)
 move.l 12(sp),d1
 movea.l D00028(a6),a0
 move.l 8(a0),d0
 bsr.w L197f4
 bsr.w L1b47a
 lea 12(sp),sp
 bsr.w L19814
 movem.l -4(a5),a0
 unlk a5
 rts 
L14106 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 pea (L00008).w
 pea (L001e0).w
 clr.l -(sp)
 movea.l 12(sp),a0
 movea.w 66(a0),a0
 move.l a0,-(sp)
 move.l 20(sp),d1
 movea.l 16(sp),a0
 move.l 8(a0),d0
 bsr.w L1b504
 lea 16(sp),sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L14140 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 moveq #1,d0
 and.l 20(sp),d0
 moveq #23,d1
 lsl.l d1,d0
 ori.l #$c1000000,d0
 moveq #15,d1
 and.l 24(sp),d1
 or.l d1,d0
 moveq #15,d1
 and.l 28(sp),d1
 lsl.l #8,d1
 or.l d1,d0
 move.l d0,-(sp)
 pea (L00001).w
 move.l 12(sp),d1
 movea.l 8(sp),a0
 move.l 8(a0),d0
 bsr.w L197f4
 bsr.w L1b486
 addq.l #8,sp
 bsr.w L19814
 movem.l -4(a5),a0
 unlk a5
 rts 
L14194 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l D00028(a6),a0
 move.w 12(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 move.l D00028(a6),d0
 bsr.w L14106
 movea.l D00028(a6),a0
 move.w 14(a0),d0
 ext.l d0
 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d1
 move.l D00028(a6),d0
 bsr.w L14106
 movea.l D00028(a6),a0
 tst.w 12(a0)
 bne.s L141e2
 moveq #1,d0
 bra.s L141e4
L141e2 moveq #0,d0
L141e4 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 20(a0,d0.l),d1
 move.l D00028(a6),d0
 bsr.w L14106
 movea.l D00028(a6),a0
 tst.w 14(a0)
 bne.s L14204
 moveq #1,d0
 bra.s L14206
L14204 moveq #0,d0
L14206 lsl.l #3,d0
 movea.l D00028(a6),a0
 move.l 36(a0,d0.l),d1
 move.l D00028(a6),d0
 bsr.w L14106
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
L14222 addq.w #2,(a6)
 ori.w #$5600,(a4)
L14225 equ *-3
L14228 dc.w $3632
 move.w d0,-(a2)
L1422c dc.w $3632
 move.w d0,-(a2)
L14230 dc.w $6c69
 dc.w $6e65
 subq.w #7,-(a5)
 moveq #101,d3
 bgt.s L142ae
 dc.w $0
L1423c link.w a5,#0
 movem.l a2-a4/d0-d1,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 movea.l 46(a2),a4
 move.l a3,d1
 move.l a2,d0
 jsr _01b62(a6)
 tst.l d0
 beq.s L14262
 tst.w 40(a4)
 bne.s L14262
 move.w #2,(a2)
L14262 movem.l -12(a5),a2-a4
 unlk a5
 rts 
L1426c link.w a5,#0
 movem.l a0/a2/d0,-(sp)
 movea.l d0,a2
 movea.l D00028(a6),a0
 subq.w #1,5562(a0)
 movea.l D00028(a6),a0
 tst.w 5562(a0)
 bne.s L14290
 movea.l D00028(a6),a0
 clr.b 5565(a0)
L14290 lea L110cc(pc),a0
 move.l a0,14(a2)
 lea L1423c(pc),a0
 move.l a0,18(a2)
 movem.l -8(a5),a0/a2
 unlk a5
 rts 
 link.w a5,#0
L142ae movem.l a0/a2-a4/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 moveq #50,d0
 add.l a3,d0
 movea.l d0,a4
 moveq #42,d0
 add.l a3,d0
 move.l d0,d4
 move.w (a4),d0
 add.w d0,30(a3)
 movea.l d4,a0
 move.w (a0),d0
 add.w d0,32(a3)
 move.w 30(a3),d0
 bge.s L142da
 addi.w #$000f,d0
L142da asr.w #4,d0
 move.w d0,44(a3)
 move.w 32(a3),d0
 bge.s L142ea
 addi.w #$000f,d0
L142ea asr.w #4,d0
 move.w d0,46(a3)
 andi.w #$fffe,44(a3)
 movea.l d4,a0
 move.w (a0),d0
 ext.l d0
 bge.s L14304
 addi.l #$0000000f,d0
L14304 asr.l #4,d0
 ext.l d0
 move.l d0,-(sp)
 move.w (a4),d0
 ext.l d0
 bge.s L14316
 addi.l #$0000000f,d0
L14316 asr.l #4,d0
 andi.l #$0000fffe,d0
 move.l d0,d1
 move.l a3,d0
 bsr.w L10f0c
 addq.l #4,sp
 move.l d0,d5
 tst.l d5
 beq.s L1433e
 move.w #2,(a2)
 moveq #2,d0
 cmp.l d5,d0
 bne.s L1433e
 move.l a3,d0
 jsr _01b5c(a6)
L1433e move.l a2,d1
 move.l a3,d0
 bsr.w L10d92
 move.l a2,d1
 move.l 4(a3),d0
 bsr.w L10dbc
 movem.l -24(a5),a0/a2-a4/d4-d5
 unlk a5
 rts 
L1435a link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 moveq #50,d0
 add.l a3,d0
 movea.l d0,a4
 moveq #42,d0
 add.l a3,d0
 move.l d0,d4
 move.w (a4),d0
 add.w d0,44(a3)
 movea.l d4,a0
 move.w (a0),d0
 add.w d0,46(a3)
 tst.w 40(a3)
 beq.s L1439a
 addq.w #1,36(a3)
 move.w 36(a3),d0
 cmp.w 40(a3),d0
 blt.s L1439a
 move.w #2,(a2)
 bra.s L143d4
L1439a movea.l d4,a0
 movea.w (a0),a0
 move.l a0,-(sp)
 movea.w (a4),a0
 move.l a0,d1
 move.l a3,d0
 bsr.w L10f0c
 addq.l #4,sp
 move.l d0,d5
 tst.l d5
 beq.s L143c2
 move.w #2,(a2)
 moveq #2,d0
 cmp.l d5,d0
 bne.s L143c2
 move.l a3,d0
 jsr _01b5c(a6)
L143c2 move.l a2,d1
 move.l a3,d0
 bsr.w L10d92
 move.l a2,d1
 move.l 4(a3),d0
 bsr.w L10dbc
L143d4 movem.l -24(a5),a0/a2-a4/d4-d5
 unlk a5
 rts 
L143de link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
 movea.l 46(a2),a3
 subq.l #1,d4
 tst.l d4
 beq.s L14416
 tst.b 49(a3)
 beq.s L14404
 move.l a2,d1
 move.l 4(a3),d0
 bsr.w L10dbc
L14404 move.l d4,-(sp)
 lea L143de(pc),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L17982
 addq.l #4,sp
 bra.s L1443e
L14416 pea (a3)
 lea L1435a(pc),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L17982
 addq.l #4,sp
 lea L110cc(pc),a0
 move.l a0,14(a2)
 lea L111ae(pc),a0
 move.l a0,22(a2)
 lea L1423c(pc),a0
 move.l a0,18(a2)
L1443e movem.l -16(a5),a0/a2-a3/d4
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 lea -44(sp),sp
 move.l a2,d0
 addq.l #4,d0
 movea.l d0,a4
 move.l (a3),d4
 lea _010cc(a6),a0
 move.l a0,d0
 move.w 94(sp),d1
 ext.l d1
 add.l d1,d0
 move.l d0,32(sp)
 lea _010d0(a6),a0
 move.l a0,d0
 move.w 94(sp),d1
 ext.l d1
 lsl.l #2,d1
 add.l d1,d0
 move.l d0,28(sp)
 move.w 44(a3),d0
 movea.l d4,a0
 move.w 2(a0),d1
 asr.w #1,d1
 add.w d1,d0
 move.w d0,24(sp)
 move.w 46(a3),d0
 movea.l d4,a0
 move.w (a0),d1
 asr.w #1,d1
 add.w d1,d0
 move.w d0,26(sp)
 move.w 444(a2),446(a2)
 moveq #0,d6
 bra.w L14630
L144b4 move.l 12(a4),d7
 move.l a4,d0
 addq.l #8,d0
 move.l d0,4(sp)
 moveq #30,d0
 add.l a4,d0
 move.l d0,(sp)
 movea.l 32(sp),a0
 move.b (a0),d0
 ext.w d0
 ext.l d0
 lsl.l #1,d0
 add.l 4(sp),d0
 move.l d0,20(sp)
 movea.l 32(sp),a0
 tst.b (a0)
 bne.s L144e6
 moveq #1,d0
 bra.s L144e8
L144e6 moveq #0,d0
L144e8 lsl.l #1,d0
 add.l 4(sp),d0
 move.l d0,16(sp)
 movea.l 32(sp),a0
 move.b (a0),d0
 ext.w d0
 ext.l d0
 lsl.l #1,d0
 add.l (sp),d0
 move.l d0,12(sp)
 movea.l 32(sp),a0
 tst.b (a0)
 bne.s L14510
 moveq #1,d0
 bra.s L14512
L14510 moveq #0,d0
L14512 lsl.l #1,d0
 add.l (sp),d0
 move.l d0,8(sp)
 move.l (a4),d5
 movea.l 12(sp),a0
 move.w (a0),d0
 movea.l 28(sp),a0
 muls.w (a0),d0
 add.w 24(sp),d0
 movea.l d5,a0
 move.w 2(a0),d1
 asr.w #1,d1
 sub.w d1,d0
 move.w d0,44(a4)
 movea.l 8(sp),a0
 move.w (a0),d0
 movea.l 28(sp),a0
 muls.w 2(a0),d0
 add.w 26(sp),d0
 movea.l d5,a0
 move.w (a0),d1
 asr.w #1,d1
 sub.w d1,d0
 move.w d0,46(a4)
 clr.l -(sp)
 moveq #0,d1
 move.l a4,d0
 bsr.w L10f0c
 addq.l #4,sp
 tst.l d0
 bne.w L14624
 moveq #50,d0
 add.l a4,d0
 move.l d0,40(sp)
 moveq #42,d0
 add.l a4,d0
 move.l d0,36(sp)
 movea.l 20(sp),a0
 move.w (a0),d0
 movea.l 28(sp),a0
 muls.w (a0),d0
 movea.l 40(sp),a0
 move.w d0,(a0)
 movea.l 16(sp),a0
 move.w (a0),d0
 movea.l 28(sp),a0
 muls.w 2(a0),d0
 movea.l 36(sp),a0
 move.w d0,(a0)
 move.l d7,d1
 move.l a4,d0
 bsr.w L10d92
 move.w 24(a3),d0
 move.b 29(a4),d1
 ext.w d1
 add.w d1,d0
 move.w d0,24(a4)
 cmpi.w #3,24(a4)
 ble.s L145c4
 subq.w #4,24(a4)
L145c4 movea.w 24(a4),a0
 move.l a0,d1
 move.l a4,d0
 bsr.w L11d68
 clr.w 36(a4)
 tst.w 34(a4)
 bne.s L145e2
 pea (a4)
 lea L1435a(pc),a0
 bra.s L14604
L145e2 tst.b 49(a4)
 bne.s L145fa
 movea.l d7,a0
 clr.l 14(a0)
 movea.l d7,a0
 clr.l 22(a0)
 movea.l d7,a0
 clr.l 18(a0)
L145fa movea.w 34(a4),a0
 move.l a0,-(sp)
 lea L143de(pc),a0
L14604 move.l a0,d1
 move.l d7,d0
 bsr.w L17982
 addq.l #4,sp
 move.l 12(a3),-(sp)
 move.l d7,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 bsr.w L16cd2
 addq.l #4,sp
 bra.s L14628
L14624 subq.w #1,446(a2)
L14628 addq.l #1,d6
 adda.l #54,a4
L14630 move.w 444(a2),d0
 ext.l d0
 cmp.l d6,d0
 bgt.w L144b4
 lea 44(sp),sp
 movem.l -32(a5),a0/a2-a4/d4-d7
 unlk a5
 rts 
L1464a link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d6,-(sp)
 movea.l d1,a2
 movea.l 52(sp),a3
 movea.l 56(sp),a4
 lea -12(sp),sp
 move.l a2,d0
 addq.l #4,d0
 move.l d0,d4
 clr.l -(sp)
 moveq #0,d1
 movea.w 78(sp),a0
 move.l a0,d0
 bsr.w L11c30
 addq.l #4,sp
 moveq #8,d1
 move.l a2,d0
 addq.l #4,d0
 bsr.w L11bf0
 subi.l #54,d4
 lea L14858(pc),a0
 move.l a0,d1
 move.l 12(sp),d0
 bsr.w L16034
 move.l d0,d5
 clr.w 446(a2)
 clr.w 444(a2)
 bra.w L147c0
L146a2 movea.l d5,a0
 move.l (a0),d0
 moveq #16,d1
 lsr.l d1,d0
 move.l d0,8(sp)
 movea.l d5,a0
 move.l (a0),d0
 lsr.l #8,d0
 andi.l #$000000ff,d0
 subi.l #128,d0
 move.l d0,4(sp)
 movea.l d5,a0
 move.l #255,d0
 and.l (a0),d0
 subi.l #128,d0
 move.l d0,(sp)
 bra.w L1479a
 addi.l #$00000036,d4
 movea.w 74(sp),a0
 move.l a0,-(sp)
 move.l d4,-(sp)
 clr.l -(sp)
 move.l 72(sp),-(sp)
 clr.l -(sp)
 pea L111ae(pc)
 move.l 80(sp),-(sp)
 lea L110cc(pc),a0
 move.l a0,d1
 movea.l D00028(a6),a0
 move.l 178(a0),d0
 bsr.w L16e04
 lea 28(sp),sp
 movea.l d4,a0
 move.l d0,12(a0)
 addq.w #1,444(a2)
 movea.l d4,a0
 clr.w 34(a0)
 movea.l d4,a0
 clr.b 49(a0)
 movea.l d4,a0
 clr.b 29(a0)
 movea.l d4,a0
 move.l a3,(a0)
 movea.l d4,a0
 move.l a4,4(a0)
 movea.l d4,a0
 move.l a4,16(a0)
 movea.l d4,a0
 move.l a4,20(a0)
 movea.l d4,a0
 move.w #2,26(a0)
 bra.w L147be
 movea.l d4,a0
 move.w 6(sp),30(a0)
 movea.l d4,a0
 move.w 2(sp),32(a0)
 bra.s L147be
 move.l d4,d0
 addq.l #8,d0
 move.l d0,d6
 movea.l d6,a0
 move.w 6(sp),(a0)
 movea.l d6,a0
 move.w 2(sp),2(a0)
 bra.s L147be
 movea.l d4,a0
 move.w 2(sp),40(a0)
 bra.s L147be
 movea.l d4,a0
 move.w 2(sp),34(a0)
 movea.l d4,a0
 move.b 7(sp),49(a0)
 bra.s L147be
 movea.l d4,a0
 move.b 3(sp),29(a0)
 bra.s L147be
L1479a move.l 8(sp),d0
 subq.l #1,d0
 cmpi.l #5,d0
 bhi.s L147be
 add.w d0,d0
 move.w L147b0(pc,d0.w),d0
 jmp L147b0(pc,d0.w)
L147b0 equ *-2
 dc.w $ff28
 dc.w $ff9a
 dc.w $ffac
 dc.w $ffc2
 dc.w $ffcc
 dc.w $ffde
L147be addq.l #4,d5
L147c0 movea.l d5,a0
 tst.l (a0)
 bne.w L146a2
 lea 12(sp),sp
 movem.l -28(a5),a0/a2-a4/d4-d6
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2-a4/d0-d1,-(sp)
 movea.l d0,a2
 move.l (a2),d0
 bsr.w L15e04
 movea.l D00028(a6),a0
 clr.b 5565(a0)
 lea L14860(pc),a0
 move.l a0,d1
 move.l (a2),d0
 bsr.w L16034
 movea.l d0,a3
 lea L14868(pc),a0
 move.l a0,d1
 move.l (a2),d0
 bsr.w L16034
 movea.l d0,a4
 move.l a4,6(a3)
 move.l 436(a2),d1
 move.l a3,d0
 bsr.w L11896
 pea (L00005).w
 pea (a4)
 pea (a3)
 pea L1426c(pc)
 pea L1423c(pc)
 move.l a2,d1
 move.l (a2),d0
 bsr.w L1464a
 lea 20(sp),sp
 lea L14872(pc),a0
 move.l a0,d1
 move.l (a2),d0
 bsr.w L16034
 move.l d0,440(a2)
 movea.l D00028(a6),a0
 move.b #1,5564(a0)
 movem.l -20(a5),a0/a2-a4/d1
 unlk a5
 rts 
L14858 dc.w $7770
 subq.w #7,-(a3)
 blt.s L148c2
 dc.w $7300
L14860 dc.w $7370
 subq.w #7,-(a4)
 dc.w $6573
 bls.w L1bbd8
L14868 equ *-2
 subq.w #7,-(sp)
 moveq #111,d1
 dc.w $7570
 dc.w $7300
L14872 bls.s L148e0
 dc.w $7574
 dc.w $0
L14878 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 lea -24(sp),sp
 tst.l 24(sp)
 bne.s L14890
 moveq #255,d0
 bra.w L14a58
L14890 clr.l D0067e(a6)
 clr.l D00686(a6)
 clr.l D00682(a6)
 clr.l D0068a(a6)
 clr.l D0068e(a6)
 clr.l 8(sp)
 bra.w L14a4a
L148ac move.l 8(sp),d0
 move.l #298,d1
 jsr _016a0(a6)
 lea D001d6(a6),a0
 add.l a0,d0
 move.l d0,16(sp)
L148c2 equ *-2
 movea.l 24(sp),a0
 tst.l (a0)
 beq.s L1492e
 movea.l 24(sp),a0
 movea.l 16(sp),a1
 move.l (a0),d0
 move.l d0,268(a1)
 move.l d0,20(sp)
 move.l 16(sp),d0
L148e0 equ *-2
 addq.l #4,d0
 move.l d0,12(sp)
 clr.l 4(sp)
 bra.s L1491a
L148ee tst.l 20(sp)
 beq.s L14922
 movea.l 20(sp),a0
 movea.l 12(sp),a1
 move.l 4(a0),10(a1)
 addq.l #1,D0067e(a6)
 movea.l 20(sp),a0
 move.l (a0),20(sp)
 addq.l #1,4(sp)
 addi.l #$0000001c,12(sp)
L1491a moveq #3,d0
 cmp.l 4(sp),d0
 bgt.s L148ee
L14922 movea.l 16(sp),a0
 move.l 20(sp),280(a0)
 bra.s L1493e
L1492e movea.l 16(sp),a0
 move.l (a0),d0
 lsl.l #2,d0
 lea D00092(a6),a0
 clr.l (a0,d0.l)
L1493e movea.l 24(sp),a0
 tst.l 4(a0)
 beq.s L149ac
 movea.l 24(sp),a0
 movea.l 16(sp),a1
 move.l 4(a0),d0
 move.l d0,272(a1)
 move.l d0,20(sp)
 moveq #88,d0
 add.l 16(sp),d0
 move.l d0,12(sp)
 clr.l 4(sp)
 bra.s L14998
L1496c tst.l 20(sp)
 beq.s L149a0
 movea.l 20(sp),a0
 movea.l 12(sp),a1
 move.l 4(a0),10(a1)
 addq.l #1,D00682(a6)
 movea.l 20(sp),a0
 move.l (a0),20(sp)
 addq.l #1,4(sp)
 addi.l #$0000001c,12(sp)
L14998 moveq #3,d0
 cmp.l 4(sp),d0
 bgt.s L1496c
L149a0 movea.l 16(sp),a0
 move.l 20(sp),284(a0)
 bra.s L149bc
L149ac movea.l 16(sp),a0
 move.l (a0),d0
 lsl.l #2,d0
 lea D00112(a6),a0
 clr.l (a0,d0.l)
L149bc movea.l 24(sp),a0
 tst.l 8(a0)
 beq.s L14a2e
 movea.l 24(sp),a0
 movea.l 16(sp),a1
 move.l 8(a0),d0
 move.l d0,276(a1)
 move.l d0,20(sp)
 move.l #172,d0
 add.l 16(sp),d0
 move.l d0,12(sp)
 clr.l 4(sp)
 bra.s L14a1a
L149ee tst.l 20(sp)
 beq.s L14a22
 movea.l 20(sp),a0
 movea.l 12(sp),a1
 move.l 4(a0),10(a1)
 addq.l #1,D00686(a6)
 movea.l 20(sp),a0
 move.l (a0),20(sp)
 addq.l #1,4(sp)
 addi.l #$0000001c,12(sp)
L14a1a moveq #3,d0
 cmp.l 4(sp),d0
 bgt.s L149ee
L14a22 movea.l 16(sp),a0
 move.l 20(sp),288(a0)
 bra.s L14a3e
L14a2e movea.l 16(sp),a0
 move.l (a0),d0
 lsl.l #2,d0
 lea D00152(a6),a0
 clr.l (a0,d0.l)
L14a3e addi.l #$0000000c,24(sp)
 addq.l #1,8(sp)
L14a4a move.l 8(sp),d0
 cmp.l D00696(a6),d0
 blt.w L148ac
 moveq #0,d0
L14a58 lea 24(sp),sp
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L14a66 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 subq.l #4,sp
 move.l 4(sp),d0
 move.l d0,_011a4(a6)
 move.l d0,D00692(a6)
 clr.w _011a0(a6)
 lea _011a0(a6),a0
 move.l a0,d1
 movea.l D0008e(a6),a0
 move.l (a0),d0
 bsr.w L1b146
 move.l d0,(sp)
 movea.l D00028(a6),a0
 clr.l 6776(a0)
 move.l (sp),d0
 addq.l #4,sp
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
L14aa8 link.w a5,#0
 movem.l d0-d1,-(sp)
 subq.l #4,sp
 move.l 8(sp),d1
 move.l 4(sp),d0
 bsr.w L14878
 move.l d0,(sp)
 moveq #255,d0
 cmp.l (sp),d0
 beq.s L14ace
 move.l 8(sp),d0
 bsr.s L14a66
 move.l d0,(sp)
L14ace move.l (sp),d0
 addq.l #4,sp
 unlk a5
 rts 
L14ad6 link.w a5,#0
 movem.l d0-d1,-(sp)
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4-d6,-(sp)
 move.l d0,d4
 movea.l d1,a2
 movea.l _015b4(a6),a3
 moveq #0,d5
 moveq #0,d6
 moveq #1,d0
 jsr _01b6e(a6)
 move.w #1,_015b8(a6)
 moveq #255,d0
 cmp.l d4,d0
 bne.s L14b44
 move.l _015a2(a6),d6
 moveq #0,d0
 move.l d0,_015a2(a6)
 move.l d0,_0159e(a6)
 move.l d0,_0159a(a6)
 clr.l -(sp)
 moveq #0,d1
 move.l D006c2(a6),d0
 jsr _01b68(a6)
 addq.l #4,sp
 bra.s L14b4e
L14b2a move.l (a3),d0
 and.l d4,d0
 cmp.l d4,d0
 bne.s L14b3c
 lea L14ad6(pc),a0
 move.l a0,4(a3)
 addq.l #1,d6
L14b3c addq.l #1,d5
 adda.l #12,a3
L14b44 move.w _01596(a6),d0
 ext.l d0
 cmp.l d5,d0
 bgt.s L14b2a
L14b4e clr.w _015b8(a6)
 moveq #255,d0
 jsr _01b6e(a6)
 move.l d6,d0
 movem.l -24(a5),a0/a2-a3/d4-d6
 unlk a5
 rts 
 link.w a5,#0
 movem.l d0,-(sp)
 move.l #-64,d0
 jsr _01b74(a6)
 unlk a5
 rts 
L14b7a link.w a5,#0
 movem.l d0,-(sp)
 move.l #-64,d0
 jsr _01b74(a6)
 unlk a5
 rts 
 link.w a5,#0
 movem.l d0,-(sp)
 move.l #-64,d0
 jsr _01b74(a6)
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0,-(sp)
 move.l #-72,d0
 jsr _01b74(a6)
 subq.l #4,sp
 tst.l D0008e(a6)
 beq.w L14bd2
 movea.l D0008e(a6),a0
 move.l (a0),d0
 bsr.w L1b152
 move.l d0,(sp)
 bra.w L14bd6
L14bd2 moveq #255,d0
 move.l d0,(sp)
L14bd6 move.l (sp),d0
 addq.l #4,sp
 bra.w L14be0
 nop 
L14be0 movem.l -4(a5),a0
 unlk a5
 rts 
L14bea link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l #-68,d0
 jsr _01b74(a6)
 subq.l #4,sp
 clr.l (sp)
 tst.l 4(sp)
 beq.w L14c4c
 movea.l 4(sp),a0
 move.l 8(sp),(a0)
 movea.l 4(sp),a0
 move.l 24(sp),4(a0)
 movea.l 4(sp),a0
 move.l 28(sp),8(a0)
 movea.l 4(sp),a0
 move.l 32(sp),12(a0)
 movea.l 4(sp),a0
 move.l 36(sp),16(a0)
 movea.l 4(sp),a0
 clr.b 20(a0)
 movea.l 4(sp),a0
 clr.b 21(a0)
 bra.w L14c50
L14c4c moveq #255,d0
 move.l d0,(sp)
L14c50 move.l (sp),d0
 addq.l #4,sp
 bra.w L14c5a
 nop 
L14c5a movem.l -4(a5),a0
 unlk a5
 rts 
L14c64 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l #-68,d0
 jsr _01b74(a6)
 subq.l #4,sp
 clr.l (sp)
 tst.l 4(sp)
 beq.w L14ca2
 movea.l 4(sp),a0
 move.l 8(sp),(a0)
 movea.l 4(sp),a0
 move.l 24(sp),4(a0)
 movea.l 4(sp),a0
 move.l 28(sp),8(a0)
 bra.w L14ca6
L14ca2 moveq #255,d0
 move.l d0,(sp)
L14ca6 move.l (sp),d0
 addq.l #4,sp
 bra.w L14cb0
 nop 
L14cb0 movem.l -4(a5),a0
 unlk a5
 rts 
L14cba link.w a5,#0
 movem.l a0/d0-d2,-(sp)
 move.l #-76,d0
 jsr _01b74(a6)
 lea -12(sp),sp
 clr.l 8(sp)
 bra.w L14eac
L14cd8 clr.l 4(sp)
 bra.w L14e02
L14ce0 moveq #255,d0
 cmp.l _011bc(a6),d0
 beq.w L14d1a
 move.l 4(sp),d0
 moveq #28,d1
 bsr.w L1ca40
 move.l d0,d2
 move.l 8(sp),d0
 move.l #298,d1
 bsr.w L1ca40
 lea D001d6(a6),a0
 add.l d2,d0
 move.w _011be(a6),d1
 add.w 10(sp),d1
 move.w d1,8(a0,d0.l)
 bra.w L14d3e
L14d1a move.l 4(sp),d0
 moveq #28,d1
 bsr.w L1ca40
 move.l d0,d2
 move.l 8(sp),d0
 move.l #298,d1
 bsr.w L1ca40
 lea D001d6(a6),a0
 add.l d2,d0
 clr.w 8(a0,d0.l)
L14d3e moveq #255,d0
 cmp.l _011c0(a6),d0
 beq.w L14d78
 move.l 4(sp),d0
 moveq #28,d1
 bsr.w L1ca40
 move.l d0,d2
 move.l 8(sp),d0
 move.l #298,d1
 bsr.w L1ca40
 lea D001d6(a6),a0
 add.l d2,d0
 move.w _011c2(a6),d1
 add.w 10(sp),d1
 move.w d1,92(a0,d0.l)
 bra.w L14d9c
L14d78 move.l 4(sp),d0
 moveq #28,d1
 bsr.w L1ca40
 move.l d0,d2
 move.l 8(sp),d0
 move.l #298,d1
 bsr.w L1ca40
 lea D001d6(a6),a0
 add.l d2,d0
 clr.w 92(a0,d0.l)
L14d9c moveq #255,d0
 cmp.l _011c4(a6),d0
 beq.w L14dd8
 move.l 4(sp),d0
 moveq #28,d1
 bsr.w L1ca40
 move.l d0,d2
 move.l 8(sp),d0
 move.l #298,d1
 bsr.w L1ca40
 lea D001d6(a6),a0
 adda.l d0,a0
 adda.l d2,a0
 move.w _011c6(a6),d0
 add.w 10(sp),d0
 move.w d0,176(a0)
 bra.w L14dfe
L14dd8 move.l 4(sp),d0
 moveq #28,d1
 bsr.w L1ca40
 move.l d0,d2
 move.l 8(sp),d0
 move.l #298,d1
 bsr.w L1ca40
 lea D001d6(a6),a0
 adda.l d0,a0
 adda.l d2,a0
 clr.w 176(a0)
L14dfe addq.l #1,4(sp)
L14e02 moveq #3,d0
 cmp.l 4(sp),d0
 bgt.w L14ce0
 move.l 8(sp),d0
 move.l #298,d1
 bsr.w L1ca40
 lea D001d6(a6),a0
 add.l a0,d0
 addq.l #4,d0
 move.l d0,(sp)
 moveq #28,d0
 add.l (sp),d0
 movea.l (sp),a0
 move.l d0,6(a0)
 moveq #56,d0
 add.l (sp),d0
 movea.l (sp),a0
 move.l d0,34(a0)
 movea.l (sp),a0
 move.l (sp),62(a0)
 move.l 8(sp),d0
 move.l #298,d1
 bsr.w L1ca40
 lea D001d6(a6),a0
 add.l a0,d0
 moveq #88,d1
 add.l d1,d0
 move.l d0,(sp)
 moveq #28,d0
 add.l (sp),d0
 movea.l (sp),a0
 move.l d0,6(a0)
 moveq #56,d0
 add.l (sp),d0
 movea.l (sp),a0
 move.l d0,34(a0)
 movea.l (sp),a0
 move.l (sp),62(a0)
 move.l 8(sp),d0
 move.l #298,d1
 bsr.w L1ca40
 lea D001d6(a6),a0
 add.l a0,d0
 addi.l #$000000ac,d0
 move.l d0,(sp)
 moveq #28,d0
 add.l (sp),d0
 movea.l (sp),a0
 move.l d0,6(a0)
 moveq #56,d0
 add.l (sp),d0
 movea.l (sp),a0
 move.l d0,34(a0)
 movea.l (sp),a0
 move.l (sp),62(a0)
 addq.l #1,8(sp)
L14eac moveq #4,d0
 cmp.l 8(sp),d0
 bgt.w L14cd8
 lea 12(sp),sp
 movem.l -12(a5),a0/d1-d2
 unlk a5
 rts 
L14ec4 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 move.l #-80,d0
 jsr _01b74(a6)
 subq.l #8,sp
 addq.l #1,D0068a(a6)
 move.l #255,d0
 and.l 8(sp),d0
 move.l #298,d1
 bsr.w L1ca40
 lea D001d6(a6),a0
 add.l a0,d0
 move.l d0,4(sp)
 movea.l 4(sp),a0
 tst.l 280(a0)
 beq.w L14f96
 movea.l 4(sp),a0
 move.l 256(a0),(sp)
 movea.l (sp),a0
 movea.l 4(sp),a1
 movea.l 268(a1),a1
 move.b (a0),20(a1)
 movea.l (sp),a0
 movea.l 4(sp),a1
 movea.l 268(a1),a1
 move.b 3(a0),21(a1)
 movea.l (sp),a0
 move.b (a0),d0
 ext.w d0
 andi.w #$0080,d0
 cmpi.w #128,d0
 bne.w L14f42
 addq.l #1,D0068e(a6)
L14f42 movea.l (sp),a0
 clr.b (a0)
 movea.l (sp),a0
 clr.l 24(a0)
 movea.l 4(sp),a0
 move.w 292(a0),d0
 ext.l d0
 movea.l D0008e(a6),a0
 movea.l 12(a0),a0
 moveq #0,d1
 move.b (a0,d0.l),d1
 movea.l (sp),a0
 move.l d1,14(a0)
 movea.l 4(sp),a0
 movea.l 280(a0),a0
 movea.l (sp),a1
 move.l 4(a0),10(a1)
 movea.l 4(sp),a0
 addq.w #1,292(a0)
 addq.l #1,D0067e(a6)
 movea.l 4(sp),a0
 movea.l 280(a0),a0
 movea.l 4(sp),a1
 move.l (a0),280(a1)
L14f96 movea.l 4(sp),a0
 movea.l 268(a0),a0
 tst.l 12(a0)
 beq.w L15004
 btst.b #1,_011bb(a6)
 beq.w L14fde
 movea.l 4(sp),a0
 move.l 268(a0),-(sp)
 movea.l 8(sp),a0
 movea.l 268(a0),a0
 move.l 12(a0),d1
 move.l #255,d0
 and.l 12(sp),d0
 ori.l #$fb020000,d0
 bsr.w L1a7bc
 addq.l #4,sp
 bra.w L15004
L14fde movea.l 4(sp),a0
 move.l 268(a0),d1
 move.l #255,d0
 and.l 8(sp),d0
 ori.l #$fb030000,d0
 movea.l 4(sp),a0
 movea.l 268(a0),a0
 movea.l 12(a0),a0
 jsr (a0)
L15004 movea.l 4(sp),a0
 movea.l 256(a0),a0
 movea.l 4(sp),a1
 move.l 6(a0),256(a1)
 movea.l 4(sp),a0
 tst.l 268(a0)
 beq.w L15032
 movea.l 4(sp),a0
 movea.l 268(a0),a0
 movea.l 4(sp),a1
 move.l (a0),268(a1)
L15032 addq.l #8,sp
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L1503e link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 move.l #-80,d0
 jsr _01b74(a6)
 subq.l #8,sp
 addq.l #1,D0068a(a6)
 move.l #255,d0
 and.l 8(sp),d0
 move.l #298,d1
 bsr.w L1ca40
 lea D001d6(a6),a0
 add.l a0,d0
 move.l d0,4(sp)
 movea.l 4(sp),a0
 tst.l 284(a0)
 beq.w L1512c
 movea.l 4(sp),a0
 move.l 260(a0),(sp)
 movea.l (sp),a0
 movea.l 4(sp),a1
 movea.l 272(a1),a1
 move.b (a0),20(a1)
 movea.l (sp),a0
 movea.l 4(sp),a1
 movea.l 272(a1),a1
 move.b 3(a0),21(a1)
 movea.l (sp),a0
 move.b (a0),d0
 ext.w d0
 andi.w #$0080,d0
 cmpi.w #128,d0
 bne.w L150bc
 addq.l #1,D0068e(a6)
L150bc movea.l (sp),a0
 clr.b (a0)
 movea.l (sp),a0
 clr.l 24(a0)
 move.w _011ba(a6),d0
 ext.l d0
 btst.l #8,d0
 beq.w L150e2
 movea.l (sp),a0
 move.l #1,14(a0)
 bra.w L15108
L150e2 movea.l 4(sp),a0
 move.w 294(a0),d0
 ext.l d0
 movea.l D0008e(a6),a0
 movea.l 16(a0),a0
 moveq #0,d1
 move.b (a0,d0.l),d1
 movea.l (sp),a0
 move.l d1,14(a0)
 movea.l 4(sp),a0
 addq.w #1,294(a0)
L15108 movea.l 4(sp),a0
 movea.l 284(a0),a0
 movea.l (sp),a1
 move.l 4(a0),10(a1)
 addq.l #1,D00682(a6)
 movea.l 4(sp),a0
 movea.l 284(a0),a0
 movea.l 4(sp),a1
 move.l (a0),284(a1)
L1512c movea.l 4(sp),a0
 movea.l 272(a0),a0
 tst.l 12(a0)
 beq.w L1519a
 btst.b #2,_011bb(a6)
 beq.w L15174
 movea.l 4(sp),a0
 move.l 272(a0),-(sp)
 movea.l 8(sp),a0
 movea.l 272(a0),a0
 move.l 12(a0),d1
 move.l #255,d0
 and.l 12(sp),d0
 ori.l #$fb040000,d0
 bsr.w L1a7bc
 addq.l #4,sp
 bra.w L1519a
L15174 movea.l 4(sp),a0
 move.l 272(a0),d1
 move.l #255,d0
 and.l 8(sp),d0
 ori.l #$fb050000,d0
 movea.l 4(sp),a0
 movea.l 272(a0),a0
 movea.l 12(a0),a0
 jsr (a0)
L1519a movea.l 4(sp),a0
 movea.l 260(a0),a0
 movea.l 4(sp),a1
 move.l 6(a0),260(a1)
 movea.l 4(sp),a0
 tst.l 272(a0)
 beq.w L151c8
 movea.l 4(sp),a0
 movea.l 272(a0),a0
 movea.l 4(sp),a1
 move.l (a0),272(a1)
L151c8 addq.l #8,sp
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L151d4 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 move.l #-80,d0
 jsr _01b74(a6)
 subq.l #8,sp
 addq.l #1,D0068a(a6)
 move.l #255,d0
 and.l 8(sp),d0
 move.l #298,d1
 bsr.w L1ca40
 lea D001d6(a6),a0
 add.l a0,d0
 move.l d0,4(sp)
 movea.l 4(sp),a0
 tst.l 288(a0)
 beq.w L152a6
 movea.l 4(sp),a0
 move.l 264(a0),(sp)
 movea.l (sp),a0
 movea.l 4(sp),a1
 movea.l 276(a1),a1
 move.b (a0),20(a1)
 movea.l (sp),a0
 movea.l 4(sp),a1
 movea.l 276(a1),a1
 move.b 3(a0),21(a1)
 movea.l (sp),a0
 move.b (a0),d0
 ext.w d0
 andi.w #$0080,d0
 cmpi.w #128,d0
 bne.w L15252
 addq.l #1,D0068e(a6)
L15252 movea.l (sp),a0
 clr.b (a0)
 movea.l (sp),a0
 clr.l 24(a0)
 movea.l 4(sp),a0
 move.w 296(a0),d0
 ext.l d0
 movea.l D0008e(a6),a0
 movea.l 20(a0),a0
 moveq #0,d1
 move.b (a0,d0.l),d1
 movea.l (sp),a0
 move.l d1,14(a0)
 movea.l 4(sp),a0
 movea.l 288(a0),a0
 movea.l (sp),a1
 move.l 4(a0),10(a1)
 movea.l 4(sp),a0
 addq.w #1,296(a0)
 addq.l #1,D00686(a6)
 movea.l 4(sp),a0
 movea.l 288(a0),a0
 movea.l 4(sp),a1
 move.l (a0),288(a1)
L152a6 movea.l 4(sp),a0
 movea.l 276(a0),a0
 tst.l 12(a0)
 beq.w L15314
 btst.b #3,_011bb(a6)
 beq.w L152ee
 movea.l 4(sp),a0
 move.l 276(a0),-(sp)
 movea.l 8(sp),a0
 movea.l 276(a0),a0
 move.l 12(a0),d1
 move.l #255,d0
 and.l 12(sp),d0
 ori.l #$fb080000,d0
 bsr.w L1a7bc
 addq.l #4,sp
 bra.w L15314
L152ee movea.l 4(sp),a0
 move.l 276(a0),d1
 move.l #255,d0
 and.l 8(sp),d0
 ori.l #$fb090000,d0
 movea.l 4(sp),a0
 movea.l 276(a0),a0
 movea.l 12(a0),a0
 jsr (a0)
L15314 movea.l 4(sp),a0
 movea.l 264(a0),a0
 movea.l 4(sp),a1
 move.l 6(a0),264(a1)
 movea.l 4(sp),a0
 tst.l 276(a0)
 beq.w L15342
 movea.l 4(sp),a0
 movea.l 276(a0),a0
 movea.l 4(sp),a1
 move.l (a0),276(a1)
L15342 addq.l #8,sp
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L1534e link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l #-76,d0
 jsr _01b74(a6)
 subq.l #4,sp
 movea.w _011a0(a6),a0
 move.l a0,(sp)
 btst.b #4,3(sp)
 beq.w L153c0
 tst.l _011d4(a6)
 beq.w L153bc
 btst.b #5,_011bb(a6)
 beq.w L153a4
 move.l (sp),-(sp)
 move.l _011d4(a6),d1
 move.l #255,d0
 and.l 8(sp),d0
 ori.l #$fb200000,d0
 bsr.w L1a7bc
 addq.l #4,sp
 bra.w L153bc
L153a4 move.l (sp),d1
 move.l #255,d0
 and.l 4(sp),d0
 ori.l #$fb210000,d0
 movea.l _011d4(a6),a0
 jsr (a0)
L153bc bra.w L154a2
L153c0 btst.b #0,3(sp)
 beq.w L1543c
 move.l D00692(a6),d0
 cmp.l _011a4(a6),d0
 beq.w L153dc
 bset.b #0,3(sp)
L153dc subq.l #1,D00692(a6)
 beq.w L153ee
 btst.b #0,_011bb(a6)
 bne.w L15438
L153ee tst.l _011d0(a6)
 beq.w L15438
 btst.b #4,_011bb(a6)
 beq.w L15420
 move.l (sp),-(sp)
 move.l _011d0(a6),d1
 move.l #255,d0
 and.l 8(sp),d0
 ori.l #$fb100000,d0
 bsr.w L1a7bc
 addq.l #4,sp
 bra.w L15438
L15420 move.l (sp),d1
 move.l #255,d0
 and.l 4(sp),d0
 ori.l #$fb110000,d0
 movea.l _011d0(a6),a0
 jsr (a0)
L15438 bra.w L154a2
L1543c btst.b #7,2(sp)
 beq.w L154a2
 tst.l D0008e(a6)
 beq.w L15458
 movea.l D0008e(a6),a0
 move.l (a0),d0
 bsr.w L1b152
L15458 tst.l _011d8(a6)
 beq.w L154a2
 btst.b #7,_011bb(a6)
 beq.w L1548a
 move.l (sp),-(sp)
 move.l _011d8(a6),d1
 move.l #255,d0
 and.l 8(sp),d0
 ori.l #$fb800000,d0
 bsr.w L1a7bc
 addq.l #4,sp
 bra.w L154a2
L1548a move.l (sp),d1
 move.l #255,d0
 and.l 4(sp),d0
 ori.l #$fb810000,d0
 movea.l _011d8(a6),a0
 jsr (a0)
L154a2 addq.l #4,sp
 movem.l -4(a5),a0
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l #-80,d0
 jsr _01b74(a6)
 subq.l #4,sp
 tst.l 4(sp)
 ble.w L154e4
 moveq #32,d0
 cmp.l 4(sp),d0
 ble.w L154e4
 move.l 4(sp),d0
 bsr.w L1a162
 moveq #0,d1
 move.w d0,d1
 move.l d1,_011bc(a6)
L154e4 tst.l 8(sp)
 ble.w L15506
 moveq #16,d0
 cmp.l 8(sp),d0
 ble.w L15506
 move.l 8(sp),d0
 bsr.w L1a162
 moveq #0,d1
 move.w d0,d1
 move.l d1,_011c0(a6)
L15506 tst.l 24(sp)
 ble.w L15528
 moveq #32,d0
 cmp.l 24(sp),d0
 ble.w L15528
 move.l 24(sp),d0
 bsr.w L1a162
 moveq #0,d1
 move.w d0,d1
 move.l d1,_011c4(a6)
L15528 moveq #1,d0
 bsr.w L1a162
 moveq #0,d1
 move.w d0,d1
 move.l d1,_011c8(a6)
 moveq #255,d0
 cmp.l _011c8(a6),d0
 bne.w L15540
L15540 moveq #1,d0
 bsr.w L1a162
 moveq #0,d1
 move.w d0,d1
 move.l d1,_011cc(a6)
 moveq #255,d0
 cmp.l _011cc(a6),d0
 bne.w L15558
L15558 pea (L00001).w
 clr.l -(sp)
 lea L14ec4(pc),a0
 move.l a0,d1
 move.l #65280,d0
 and.l _011bc(a6),d0
 bsr.w L1a29a
 addq.l #8,sp
 move.l d0,(sp)
 moveq #255,d0
 cmp.l (sp),d0
 bne.w L1557e
L1557e pea (L00001).w
 clr.l -(sp)
 lea L1503e(pc),a0
 move.l a0,d1
 move.l #65280,d0
 and.l _011c0(a6),d0
 bsr.w L1a29a
 addq.l #8,sp
 move.l d0,(sp)
 moveq #255,d0
 cmp.l (sp),d0
 bne.w L155a4
L155a4 pea (L00001).w
 clr.l -(sp)
 lea L151d4(pc),a0
 move.l a0,d1
 move.l #65280,d0
 and.l _011c4(a6),d0
 bsr.w L1a29a
 addq.l #8,sp
 move.l d0,(sp)
 moveq #255,d0
 cmp.l (sp),d0
 bne.w L155ca
L155ca pea (L00001).w
 clr.l -(sp)
 lea L1534e(pc),a0
 move.l a0,d1
 move.l #65280,d0
 and.l _011c8(a6),d0
 bsr.w L1a370
 addq.l #8,sp
 move.l d0,(sp)
 moveq #255,d0
 cmp.l (sp),d0
 bne.w L155f0
L155f0 bsr.w L14cba
 move.w #256,_011a0(a6)
 addq.l #4,sp
 movem.l -4(a5),a0
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l #-72,d0
 jsr _01b74(a6)
 subq.l #4,sp
 clr.l (sp)
 tst.l 4(sp)
 beq.w L156d8
 move.l 8(sp),d0
 bsr.w L15e04
 lea L156f0(pc),a0
 move.l a0,d1
 move.l 8(sp),d0
 bsr.w L15ffe
 movea.l 4(sp),a0
 move.l d0,8(a0)
 lea L156f2(pc),a0
 move.l a0,d1
 move.l 8(sp),d0
 bsr.w L16034
 movea.l 4(sp),a0
 move.l d0,24(a0)
 lea L156f4(pc),a0
 move.l a0,d1
 move.l 8(sp),d0
 bsr.w L16034
 movea.l 4(sp),a0
 move.l d0,28(a0)
 lea L156f6(pc),a0
 move.l a0,d1
 move.l 8(sp),d0
 bsr.w L16034
 movea.l 4(sp),a0
 move.l d0,12(a0)
 lea L156f8(pc),a0
 move.l a0,d1
 move.l 8(sp),d0
 bsr.w L16034
 movea.l 4(sp),a0
 move.l d0,16(a0)
 lea L156fa(pc),a0
 move.l a0,d1
 move.l 8(sp),d0
 bsr.w L16034
 movea.l 4(sp),a0
 move.l d0,20(a0)
 movea.l 4(sp),a0
 tst.l 12(a0)
 bne.w L156ca
 movea.l 4(sp),a0
 move.w #6,32(a0)
 bra.w L156d4
L156ca movea.l 4(sp),a0
 move.w #12,32(a0)
L156d4 bra.w L156dc
L156d8 moveq #255,d0
 move.l d0,(sp)
L156dc move.l (sp),d0
 addq.l #4,sp
 bra.w L156e6
 nop 
L156e6 movem.l -4(a5),a0
L156ea equ *-2
 unlk a5
 rts 
L156f0 moveq #0,d1
L156f2 moveq #0,d1
L156f4 bge.w L1ccf6
L156f6 equ *-2
L156f8 bsr.w L1bafa
L156fa equ *-2
 link.w a5,#0
L15700 movem.l a0/d0-d1,-(sp)
 move.l #-76,d0
 jsr _01b74(a6)
 subq.l #4,sp
 pea (L00022).w
 move.l #255,d1
 move.l 8(sp),d0
 bsr.w L1c98a
L15722 addq.l #4,sp
 moveq #1,d1
 move.l 8(sp),d0
 bsr.w L1cd64
 move.l d0,(sp)
 moveq #255,d0
 cmp.l (sp),d0
 beq.w L1573e
 movea.l 4(sp),a0
 move.l (sp),(a0)
L1573e move.l (sp),d0
 addq.l #4,sp
 bra.w L15748
 nop 
L15748 movem.l -4(a5),a0
 unlk a5
 rts 
L15752 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l #-84,d0
 jsr _01b74(a6)
 lea -16(sp),sp
 tst.l 16(sp)
 beq.w L157e4
 tst.l 20(sp)
 beq.w L157e4
 movea.l 16(sp),a0
 move.l 28(a0),8(sp)
 movea.l 8(sp),a0
 move.l (a0),4(sp)
 clr.l 12(sp)
 bra.w L157d4
L15792 move.l 20(sp),d1
 move.l 12(sp),d0
 lsl.l #2,d0
 movea.l 8(sp),a0
 move.l (a0,d0.l),d0
 bsr.w L1bd94
 tst.l d0
 bne.w L157d0
 movea.l 16(sp),a0
 move.w 32(a0),d0
 ext.l d0
 move.l 12(sp),d1
 bsr.w L1ca40
 movea.l 16(sp),a0
 add.l 24(a0),d0
 lea 16(sp),sp
 bra.w L157f0
L157d0 addq.l #1,12(sp)
L157d4 movea.l 16(sp),a0
 move.l 12(sp),d0
 cmp.l 8(a0),d0
 blt.w L15792
L157e4 moveq #0,d0
 lea 16(sp),sp
 bra.w L157f0
 nop 
L157f0 movem.l -4(a5),a0
 unlk a5
 rts 
L157fa link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 move.l #-80,d0
 jsr _01b74(a6)
 lea -16(sp),sp
 movea.l 20(sp),a0
 moveq #127,d0
 and.w (a0),d0
 ext.l d0
 move.l d0,(sp)
 movea.l 40(sp),a0
 move.l d0,(a0)
 movea.l 20(sp),a0
 cmpi.w #-1,6(a0)
 beq.w L158c2
 movea.l 20(sp),a0
 movea.l 40(sp),a1
 move.w 6(a0),292(a1)
 move.l 40(sp),d0
 addq.l #4,d0
 movea.l 40(sp),a0
 move.l d0,256(a0)
 move.l d0,12(sp)
 movea.l 20(sp),a0
 movea.w 6(a0),a0
 move.l a0,4(sp)
 clr.l 8(sp)
 bra.w L1589c
L15864 movea.l 12(sp),a0
 clr.b (a0)
 movea.l 12(sp),a0
 clr.l 24(a0)
 movea.l 16(sp),a0
 movea.l 12(a0),a0
 move.l 4(sp),d0
 moveq #0,d1
 move.b (a0,d0.l),d1
 movea.l 12(sp),a0
 move.l d1,14(a0)
 addq.l #1,4(sp)
 addq.l #1,8(sp)
 addi.l #$0000001c,12(sp)
L1589c moveq #3,d0
 cmp.l 8(sp),d0
 bgt.w L15864
 movea.l 40(sp),a0
 move.w 6(sp),292(a0)
 move.l (sp),d0
 lsl.l #2,d0
 lea D00092(a6),a0
 movea.l 40(sp),a1
 move.l 256(a1),(a0,d0.l)
L158c2 move.w _011ba(a6),d0
 ext.l d0
 btst.l #8,d0
 beq.w L1592a
 moveq #88,d0
 add.l 40(sp),d0
 movea.l 40(sp),a0
 move.l d0,260(a0)
 move.l (sp),d1
 lsl.l #2,d1
 lea D00112(a6),a0
 move.l d0,(a0,d1.l)
 move.l d0,12(sp)
 clr.l 8(sp)
 bra.w L1591c
L158f6 movea.l 12(sp),a0
 clr.b (a0)
 movea.l 12(sp),a0
 clr.l 24(a0)
 movea.l 12(sp),a0
 move.l #1,14(a0)
 addq.l #1,8(sp)
 addi.l #$0000001c,12(sp)
L1591c moveq #3,d0
 cmp.l 8(sp),d0
 bgt.w L158f6
 bra.w L159ca
L1592a movea.l 20(sp),a0
 cmpi.w #-1,8(a0)
 beq.w L159ca
 movea.l 20(sp),a0
 movea.l 40(sp),a1
 move.w 8(a0),294(a1)
 moveq #88,d0
 add.l 40(sp),d0
 movea.l 40(sp),a0
 move.l d0,260(a0)
 move.l d0,12(sp)
 movea.l 20(sp),a0
 movea.w 8(a0),a0
 move.l a0,4(sp)
 clr.l 8(sp)
 bra.w L159a4
L1596c movea.l 12(sp),a0
 clr.b (a0)
 movea.l 12(sp),a0
 clr.l 24(a0)
 movea.l 16(sp),a0
 movea.l 16(a0),a0
 move.l 4(sp),d0
 moveq #0,d1
 move.b (a0,d0.l),d1
 movea.l 12(sp),a0
 move.l d1,14(a0)
 addq.l #1,4(sp)
 addq.l #1,8(sp)
 addi.l #$0000001c,12(sp)
L159a4 moveq #3,d0
 cmp.l 8(sp),d0
 bgt.w L1596c
 movea.l 40(sp),a0
 move.w 6(sp),294(a0)
 move.l (sp),d0
 lsl.l #2,d0
 lea D00112(a6),a0
 movea.l 40(sp),a1
 move.l 260(a1),(a0,d0.l)
L159ca movea.l 20(sp),a0
 cmpi.w #-1,10(a0)
 beq.w L15a6e
 movea.l 20(sp),a0
 movea.l 40(sp),a1
 move.w 10(a0),296(a1)
 move.l #172,d0
 add.l 40(sp),d0
 movea.l 40(sp),a0
 move.l d0,264(a0)
 move.l d0,12(sp)
 movea.l 20(sp),a0
 movea.w 10(a0),a0
 move.l a0,4(sp)
 clr.l 8(sp)
 bra.w L15a48
L15a10 movea.l 12(sp),a0
 clr.b (a0)
 movea.l 12(sp),a0
 clr.l 24(a0)
 movea.l 16(sp),a0
 movea.l 20(a0),a0
 move.l 4(sp),d0
 moveq #0,d1
 move.b (a0,d0.l),d1
 movea.l 12(sp),a0
 move.l d1,14(a0)
 addq.l #1,4(sp)
 addq.l #1,8(sp)
 addi.l #$0000001c,12(sp)
L15a48 moveq #3,d0
 cmp.l 8(sp),d0
 bgt.w L15a10
 movea.l 40(sp),a0
 move.w 6(sp),296(a0)
 move.l (sp),d0
 lsl.l #2,d0
 lea D00152(a6),a0
 movea.l 40(sp),a1
 move.l 264(a1),(a0,d0.l)
L15a6e lea 16(sp),sp
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L15a7c link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l #-72,d0
 jsr _01b74(a6)
 move.l #65280,d0
 and.l _011c8(a6),d0
 move.w d0,_011a2(a6)
 clr.l _011a8(a6)
 clr.w _011ac(a6)
 pea (L00080).w
 moveq #0,d1
 lea D00092(a6),a0
 move.l a0,d0
 bsr.w L1c98a
 addq.l #4,sp
 pea (L00040).w
 moveq #0,d1
 lea D00112(a6),a0
 move.l a0,d0
 bsr.w L1c98a
 addq.l #4,sp
 pea (L00080).w
 moveq #0,d1
 lea D00152(a6),a0
 move.l a0,d0
 bsr.w L1c98a
 addq.l #4,sp
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
L15ae4 link.w a5,#0
 movem.l d0,-(sp)
 move.l #-68,d0
 jsr _01b74(a6)
 tst.l (sp)
 bne.w L15b02
 moveq #255,d0
 bra.w L15b1c
L15b02 move.l (sp),D0008e(a6)
 clr.l D00696(a6)
 moveq #255,d0
 move.l d0,D0069a(a6)
 bsr.w L15a7c
 moveq #0,d0
 bra.w L15b1c
 nop 
L15b1c unlk a5
 rts 
L15b20 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l #-72,d0
 jsr _01b74(a6)
 movea.l 4(sp),a0
 moveq #127,d0
 and.w (a0),d0
 moveq #1,d1
 lsl.l d0,d1
 or.l d1,_011a8(a6)
 movea.l 4(sp),a0
 btst.b #7,1(a0)
 beq.w L15b64
 move.w _011ba(a6),d0
 ext.l d0
 btst.l #8,d0
 bne.w L15b64
 move.w _011aa(a6),_011ac(a6)
L15b64 movea.l (sp),a0
 cmpi.w #12,32(a0)
 bne.w L15b94
 move.l D00696(a6),d0
 move.l #298,d1
 bsr.w L1ca40
 lea D001d6(a6),a0
 pea (a0,d0.l)
 move.l 8(sp),d1
 move.l 4(sp),d0
 bsr.w L157fa
 addq.l #4,sp
L15b94 addq.l #1,D00696(a6)
 moveq #255,d0
 cmp.l D0069a(a6),d0
 beq.w L15bb2
 movea.l 4(sp),a0
 move.l D0069a(a6),d0
 cmp.l 2(a0),d0
 ble.w L15bbc
L15bb2 movea.l 4(sp),a0
 move.l 2(a0),D0069a(a6)
L15bbc move.l D0069a(a6),d0
 bra.w L15bc6
 nop 
L15bc6 movem.l -4(a5),a0
 unlk a5
 rts 
L15bd0 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l #-76,d0
 jsr _01b74(a6)
 subq.l #4,sp
 tst.l _011dc(a6)
 beq.w L15c1c
 clr.w D001d2(a6)
 move.l #65280,d0
 and.l _011cc(a6),d0
 move.w d0,D001d4(a6)
 pea D001d2(a6)
 moveq #11,d0
 move.l 12(sp),d1
 lsl.l d0,d1
 movea.l 8(sp),a0
 move.l (a0),d0
 bsr.w L1b12a
 addq.l #4,sp
 move.l d0,(sp)
 bra.w L15c34
L15c1c clr.l -(sp)
 moveq #11,d0
 move.l 12(sp),d1
 lsl.l d0,d1
 movea.l 8(sp),a0
 move.l (a0),d0
 bsr.w L1cec8
 addq.l #4,sp
 move.l d0,(sp)
L15c34 move.l (sp),d0
 addq.l #4,sp
 bra.w L15c3e
 nop 
L15c3e movem.l -4(a5),a0
 unlk a5
 rts 
L15c48 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l #-76,d0
 jsr _01b74(a6)
 subq.l #8,sp
 moveq #255,d0
 move.l d0,(sp)
 move.l 8(sp),d0
 bsr.w L15ae4
 move.l d0,(sp)
 moveq #255,d0
 cmp.l (sp),d0
 beq.w L15cbc
 movea.l 8(sp),a0
 tst.l 28(a0)
 beq.w L15cbc
 move.l 12(sp),d1
 move.l 8(sp),d0
 bsr.w L15752
 move.l d0,4(sp)
 bne.w L15c9a
 moveq #255,d0
 addq.l #8,sp
 bra.w L15cc6
L15c9a move.l 4(sp),d1
 move.l 8(sp),d0
 bsr.w L15b20
 move.l d0,(sp)
 moveq #255,d0
 cmp.l (sp),d0
 beq.w L15cbc
 move.l (sp),d1
 move.l 8(sp),d0
 bsr.w L15bd0
 move.l d0,(sp)
L15cbc move.l (sp),d0
 addq.l #8,sp
 bra.w L15cc6
 nop 
L15cc6 movem.l -4(a5),a0
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l #-80,d0
 jsr _01b74(a6)
 lea -12(sp),sp
 moveq #255,d0
 move.l d0,(sp)
 move.l 12(sp),d0
 bsr.w L15ae4
 move.l d0,(sp)
 moveq #255,d0
 cmp.l (sp),d0
 beq.w L15d6c
 movea.l 12(sp),a0
 tst.l 28(a0)
 beq.w L15d6c
 clr.l 8(sp)
 bra.w L15d4a
L15d10 move.l 8(sp),d0
 lsl.l #2,d0
 movea.l 16(sp),a0
 move.l (a0,d0.l),d1
 move.l 12(sp),d0
 bsr.w L15752
 move.l d0,4(sp)
 bne.w L15d38
 moveq #255,d0
 lea 12(sp),sp
 bra.w L15d78
L15d38 move.l 4(sp),d1
 move.l 12(sp),d0
 bsr.w L15b20
 move.l d0,(sp)
 addq.l #1,8(sp)
L15d4a move.l 8(sp),d0
 cmp.l 32(sp),d0
 blt.w L15d10
 moveq #255,d0
 cmp.l (sp),d0
 beq.w L15d6c
 move.l D0069a(a6),d1
 move.l 12(sp),d0
 bsr.w L15bd0
 move.l d0,(sp)
L15d6c move.l (sp),d0
 lea 12(sp),sp
 bra.w L15d78
 nop 
L15d78 movem.l -4(a5),a0
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l #-72,d0
 jsr _01b74(a6)
 subq.l #4,sp
 moveq #255,d0
 move.l d0,(sp)
 move.l 4(sp),d0
 bsr.w L15ae4
 movea.l 4(sp),a0
 move.l 8(sp),d0
 cmp.l 8(a0),d0
 bge.w L15df0
 movea.l 4(sp),a0
 move.w 32(a0),d0
 ext.l d0
 move.l 8(sp),d1
 bsr.w L1ca40
 movea.l 4(sp),a0
 add.l 24(a0),d0
 move.l d0,d1
 move.l 4(sp),d0
 bsr.w L15b20
 move.l d0,(sp)
 moveq #255,d0
 cmp.l (sp),d0
 beq.w L15dec
 move.l (sp),d1
 move.l 4(sp),d0
 bsr.w L15bd0
 move.l d0,(sp)
L15dec bra.w L15df0
L15df0 move.l (sp),d0
 addq.l #4,sp
 bra.w L15dfa
 nop 
L15dfa movem.l -4(a5),a0
 unlk a5
 rts 
L15e04 link.w a5,#0
 movem.l a0/d0,-(sp)
 move.l #-88,d0
 jsr _01b74(a6)
 lea -20(sp),sp
 tst.l 20(sp)
 beq.w L15f74
 movea.l 20(sp),a0
 btst.b #7,2(a0)
 bne.w L15f66
 movea.l 20(sp),a0
 tst.l (a0)
 bne.w L15ec6
 move.l 20(sp),8(sp)
 movea.l 8(sp),a0
 tst.l 12(a0)
 beq.s L15e68
 movea.l 8(sp),a0
 move.l 12(a0),d0
 add.l 8(sp),d0
 movea.l 8(sp),a0
 move.l d0,12(a0)
 movea.l 8(sp),a0
 move.l 12(a0),d0
 bsr.s L15e04
L15e68 movea.l 8(sp),a0
 tst.l 16(a0)
 beq.w L15f66
 movea.l 8(sp),a0
 move.l 16(a0),d0
 add.l 8(sp),d0
 movea.l 8(sp),a0
 move.l d0,16(a0)
 movea.l 8(sp),a0
 move.l 16(a0),d0
 bsr.w L15e04
 movea.l 8(sp),a0
 movea.l 16(a0),a0
 move.l 12(a0),4(sp)
 clr.l (sp)
 bra.s L15eb6
L15ea6 movea.l 4(sp),a0
 move.l (a0),d0
 bsr.w L15e04
 addq.l #4,4(sp)
 addq.l #1,(sp)
L15eb6 movea.l 8(sp),a0
 move.l (sp),d0
 cmp.l 8(a0),d0
 bcs.s L15ea6
 bra.w L15f6a
L15ec6 movea.l 20(sp),a0
 moveq #1,d0
 cmp.l (a0),d0
 bne.s L15eee
 move.l 20(sp),16(sp)
 movea.l 16(sp),a0
 move.l 16(a0),d0
 add.l 16(sp),d0
 movea.l 16(sp),a0
 move.l d0,16(a0)
 bra.w L15f6a
L15eee movea.l 20(sp),a0
 moveq #2,d0
 cmp.l (a0),d0
 bne.s L15f6a
 move.l 20(sp),12(sp)
 movea.l 12(sp),a0
 move.l 16(a0),d0
 add.l 12(sp),d0
 movea.l 12(sp),a0
 move.l d0,16(a0)
 movea.l 12(sp),a0
 tst.l 12(a0)
 beq.s L15f66
 movea.l 12(sp),a0
 move.l 12(a0),d0
 add.l 12(sp),d0
 movea.l 12(sp),a0
 move.l d0,12(a0)
 movea.l 12(sp),a0
 move.l 12(a0),4(sp)
 clr.l (sp)
 bra.s L15f58
L15f3e movea.l 4(sp),a0
 move.l (a0),d0
 movea.l 12(sp),a0
 add.l 16(a0),d0
 movea.l 4(sp),a0
 move.l d0,(a0)
 addq.l #4,4(sp)
 addq.l #1,(sp)
L15f58 movea.l 12(sp),a0
 move.l (sp),d0
 cmp.l 8(a0),d0
 bcs.s L15f3e
 bra.s L15f6a
L15f66 moveq #255,d0
 bra.s L15f76
L15f6a movea.l 20(sp),a0
 bset.b #7,2(a0)
L15f74 moveq #0,d0
L15f76 lea 20(sp),sp
 movem.l -4(a5),a0
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0,-(sp)
 move.l #-68,d0
 jsr _01b74(a6)
 subq.l #4,sp
 move.l 4(sp),(sp)
 tst.l (sp)
 beq.s L15fa8
 movea.l (sp),a0
 move.l 8(a0),d0
 bra.s L15faa
L15fa8 moveq #255,d0
L15faa addq.l #4,sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L15fb6 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l #-68,d0
 jsr _01b74(a6)
 tst.l (sp)
 beq.s L15fde
 tst.l 4(sp)
 blt.s L15fde
 movea.l (sp),a0
 move.l 4(sp),d0
 cmp.l 8(a0),d0
 bls.s L15fe2
L15fde moveq #255,d0
 bra.s L15ff4
L15fe2 move.l 4(sp),d1
 move.l (sp),d0
 bsr.w L1611e
 move.l d0,(sp)
 movea.l (sp),a0
 move.l 8(a0),d0
L15ff4 movem.l -4(a5),a0
 unlk a5
 rts 
L15ffe link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l #-68,d0
 jsr _01b74(a6)
 move.l 4(sp),d1
 move.l (sp),d0
 bsr.w L16062
 move.l d0,(sp)
 tst.l (sp)
 bne.s L16024
 moveq #255,d0
 bra.s L1602a
L16024 movea.l (sp),a0
 move.l 8(a0),d0
L1602a movem.l -4(a5),a0
 unlk a5
 rts 
L16034 link.w a5,#0
 movem.l d0-d1,-(sp)
 move.l #-72,d0
 jsr _01b74(a6)
 subq.l #4,sp
 move.l 8(sp),d1
 move.l 4(sp),d0
 bsr.w L16062
 move.l d0,(sp)
 move.l (sp),d0
 bsr.w L16174
 addq.l #4,sp
 unlk a5
 rts 
L16062 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l #-80,d0
 jsr _01b74(a6)
 lea -12(sp),sp
 tst.l 12(sp)
 beq.s L160e0
 movea.l 12(sp),a0
 move.l #-32769,d0
 and.l (a0),d0
 bne.s L160e0
 movea.l 12(sp),a0
 tst.l 12(a0)
 beq.s L160e0
 movea.l 12(sp),a0
 move.l 8(a0),8(sp)
 movea.l 12(sp),a0
 movea.l 12(a0),a0
 move.l 12(a0),(sp)
 clr.l 4(sp)
 bra.s L160d6
L160b2 move.l 16(sp),d1
 movea.l (sp),a0
 move.l (a0),d0
 bsr.w L1bd94
 tst.l d0
 bne.s L160d0
 move.l 4(sp),d1
 move.l 12(sp),d0
 bsr.w L1611e
 bra.s L160e2
L160d0 addq.l #1,4(sp)
 addq.l #4,(sp)
L160d6 move.l 4(sp),d0
 cmp.l 8(sp),d0
 blt.s L160b2
L160e0 moveq #0,d0
L160e2 lea 12(sp),sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L160f0 link.w a5,#0
 movem.l d0-d1,-(sp)
 move.l #-72,d0
 jsr _01b74(a6)
 subq.l #4,sp
 move.l 8(sp),d1
 move.l 4(sp),d0
 bsr.w L1611e
 move.l d0,(sp)
 move.l (sp),d0
 bsr.w L16174
 addq.l #4,sp
 unlk a5
 rts 
L1611e link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l #-64,d0
 jsr _01b74(a6)
 tst.l (sp)
 beq.s L16168
 movea.l (sp),a0
 move.l #-32769,d0
 and.l (a0),d0
 bne.s L16168
 tst.l 4(sp)
 blt.s L16168
 movea.l (sp),a0
 move.l 4(sp),d0
 cmp.l 8(a0),d0
 bhi.s L16168
 move.l 4(sp),d0
 lsl.l #2,d0
 movea.l (sp),a0
 movea.l 16(a0),a0
 movea.l 12(a0),a0
 move.l (a0,d0.l),d0
 bra.s L1616a
L16168 moveq #0,d0
L1616a movem.l -4(a5),a0
 unlk a5
 rts 
L16174 link.w a5,#0
 movem.l a0/d0,-(sp)
 move.l #-72,d0
 jsr _01b74(a6)
 subq.l #8,sp
 tst.l 8(sp)
 beq.s L161c8
 bra.s L161ac
L16190 move.l 8(sp),4(sp)
 movea.l 4(sp),a0
 move.l 16(a0),d0
 bra.s L161ca
L161a0 move.l 8(sp),(sp)
 movea.l (sp),a0
 move.l 12(a0),d0
 bra.s L161ca
L161ac movea.l 8(sp),a0
 move.l #-32769,d0
 and.l (a0),d0
 cmpi.l #1,d0
 beq.s L16190
 cmpi.l #2,d0
 beq.s L161a0
L161c8 moveq #0,d0
L161ca addq.l #8,sp
 movem.l -4(a5),a0
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2/d0-d1/d4-d6,-(sp)
 move.l #-64,d0
 jsr _01b74(a6)
 movea.l (sp),a2
 tst.l 4(sp)
 bne.s L161f8
 lea _01238(a6),a0
 move.l a0,4(sp)
L161f8 moveq #0,d4
 bra.w L16272
L161fe clr.l 2(a2)
 moveq #255,d0
 cmp.l 22(a2),d0
 beq.s L1621e
 move.l 22(a2),d0
 moveq #122,d1
 bsr.w L1ca40
 add.l (sp),d0
 move.l d0,22(a2)
 moveq #0,d5
 bra.s L16224
L1621e clr.l 22(a2)
 moveq #1,d5
L16224 moveq #255,d0
 cmp.l 18(a2),d0
 beq.s L16240
 move.l 18(a2),d0
 moveq #122,d1
 bsr.w L1ca40
 add.l (sp),d0
 move.l d0,18(a2)
 moveq #1,d6
 bra.s L16246
L16240 clr.l 18(a2)
 moveq #0,d6
L16246 move.l 4(sp),26(a2)
 clr.l 14(a2)
 move.l 36(sp),110(a2)
 move.l 40(sp),114(a2)
 move.l 44(sp),d0
 subq.l #1,d0
 cmp.l d4,d0
 bne.s L1626a
 bset.b #3,(a2)
L1626a addq.l #1,d4
 adda.l #122,a2
L16272 cmp.l 44(sp),d4
 blt.w L161fe
 tst.l d6
 bne.s L16282
 tst.l d5
 beq.s L16286
L16282 moveq #255,d0
 bra.s L16288
L16286 moveq #0,d0
L16288 movem.l -20(a5),a0/a2/d4-d6
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l #-76,d0
 jsr _01b74(a6)
 lea -12(sp),sp
 clr.l 4(sp)
 move.l 12(sp),(sp)
 clr.l 8(sp)
 bra.w L16360
L162b8 movea.l (sp),a0
 clr.l 2(a0)
 movea.l (sp),a0
 moveq #255,d0
 cmp.l 22(a0),d0
 beq.s L162e0
 movea.l (sp),a0
 move.l 22(a0),d0
 moveq #30,d1
 bsr.w L1ca40
 add.l 12(sp),d0
 movea.l (sp),a0
 move.l d0,22(a0)
 bra.s L162e6
L162e0 movea.l (sp),a0
 clr.l 22(a0)
L162e6 movea.l (sp),a0
 moveq #255,d0
 cmp.l 18(a0),d0
 beq.s L16308
 movea.l (sp),a0
 move.l 18(a0),d0
 moveq #30,d1
 bsr.w L1ca40
 add.l 12(sp),d0
 movea.l (sp),a0
 move.l d0,18(a0)
 bra.s L1630e
L16308 movea.l (sp),a0
 clr.l 18(a0)
L1630e movea.l (sp),a0
 move.l 16(sp),26(a0)
 movea.l (sp),a0
 clr.l 14(a0)
 bra.s L16326
L1631e addi.l #$0000000a,16(sp)
L16326 movea.l 16(sp),a0
 move.w (a0),d0
 ext.l d0
 andi.l #$00004000,d0
 cmpi.l #16384,d0
 bne.s L1631e
 move.l 32(sp),d0
 subq.l #1,d0
 cmp.l 8(sp),d0
 bne.s L1634e
 movea.l (sp),a0
 bset.b #3,(a0)
L1634e addq.l #1,8(sp)
 addi.l #$0000001e,(sp)
 addi.l #$0000000a,16(sp)
L16360 move.l 8(sp),d0
 cmp.l 32(sp),d0
 blt.w L162b8
 lea 12(sp),sp
 movem.l -4(a5),a0
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 move.l #-68,d0
 jsr _01b74(a6)
 subq.l #4,sp
 movea.l 4(sp),a0
 move.w 118(a0),d0
 ext.l d0
 andi.l #$00007fff,d0
 move.l d0,(sp)
 tst.l (sp)
 bne.s L163b4
 movea.l 4(sp),a0
 movea.l 8(sp),a1
 move.l 18(a0),22(a1)
 bra.s L163c2
L163b4 movea.l 4(sp),a0
 movea.l 4(sp),a1
 move.l 18(a0),-104(a1)
L163c2 addq.l #4,sp
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 move.l #-68,d0
 jsr _01b74(a6)
 subq.l #4,sp
 move.l 4(sp),(sp)
 bra.s L163fa
L163e8 move.l (sp),d0
 cmp.l D0069e(a6),d0
 bne.s L163f4
 clr.l D0069e(a6)
L163f4 move.l 28(sp),d0
 add.l d0,(sp)
L163fa movea.l (sp),a0
 move.w (a0),d0
 ext.l d0
 btst.l #11,d0
 beq.s L163e8
 move.l (sp),d0
 cmp.l D0069e(a6),d0
 bne.s L16412
 clr.l D0069e(a6)
L16412 movea.l (sp),a0
 movea.l 8(sp),a1
 move.l 18(a0),22(a1)
 movea.l (sp),a0
 clr.l 18(a0)
 addq.l #4,sp
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L16430 link.w a5,#0
 movem.l d0-d1,-(sp)
 move.l #-68,d0
 jsr _01b74(a6)
 tst.l D0069e(a6)
 beq.s L16456
 moveq #0,d1
 move.l D0069e(a6),d0
 bsr.w L16a70
 clr.l D0069e(a6)
L16456 movem.l -4(a5),d1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2/d0-d1,-(sp)
 movea.l d1,a2
 move.l #-80,d0
 jsr _01b74(a6)
 subq.l #8,sp
 move.l 22(a2),4(sp)
 move.l (a2),d0
 lsl.l #3,d0
 movea.l 4(sp),a0
 move.l 30(a0,d0.l),(sp)
 move.l (a2),d0
 lsl.l #3,d0
 movea.l 4(sp),a0
 move.l 34(a0,d0.l),(a2)
 tst.l (sp)
 beq.s L164a8
 pea (a2)
 move.l 4(sp),d1
 move.l 12(sp),d0
 bsr.w L1a7bc
 addq.l #4,sp
L164a8 addq.l #8,sp
 movem.l -8(a5),a0/a2
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2/d0-d1,-(sp)
 movea.l d1,a2
 move.l #-106,d0
 jsr _01b74(a6)
 lea -14(sp),sp
 move.l 22(a2),10(sp)
 movea.l 10(sp),a0
 move.w 100(a0),4(sp)
 move.l (a2),d0
 lsl.l #3,d0
 movea.l 10(sp),a0
 move.l 30(a0,d0.l),6(sp)
 movea.l 10(sp),a0
 tst.w 120(a0)
 beq.s L16500
 movea.l 10(sp),a0
 cmpi.w #2,120(a0)
 bne.s L16534
L16500 movea.l 10(sp),a0
 cmpi.w #-1,104(a0)
 beq.s L16520
 movea.l 10(sp),a0
 move.l 102(a0),(sp)
 movea.l 10(sp),a0
 move.w #3,120(a0)
 bra.s L1657c
L16520 movea.l 10(sp),a0
 move.l 98(a0),(sp)
 movea.l 10(sp),a0
 move.w #1,120(a0)
 bra.s L1657c
L16534 movea.l 10(sp),a0
 cmpi.w #1,120(a0)
 beq.s L1654c
 movea.l 10(sp),a0
 cmpi.w #3,120(a0)
 bne.s L16582
L1654c movea.l 10(sp),a0
 cmpi.w #-1,96(a0)
 beq.s L1656c
 movea.l 10(sp),a0
 move.l 94(a0),(sp)
 movea.l 10(sp),a0
 move.w #2,120(a0)
 bra.s L1657c
L1656c movea.l 10(sp),a0
 move.l 90(a0),(sp)
 movea.l 10(sp),a0
 clr.w 120(a0)
L1657c move.w 2(sp),4(sp)
L16582 move.l D0069e(a6),d0
 cmp.l 10(sp),d0
 beq.s L16590
 bsr.w L16430
L16590 cmpi.w #-1,2(sp)
 beq.w L16634
 cmpi.w #-1,(sp)
 bne.s L165e0
 movea.w 4(sp),a0
 move.l a0,-(sp)
 movea.l 14(sp),a0
 movea.w 88(a0),a0
 move.l a0,-(sp)
 movea.l 18(sp),a0
 movea.w 86(a0),a0
 move.l a0,-(sp)
 movea.l 22(sp),a0
 movea.w 108(a0),a0
 move.l a0,-(sp)
 movea.l 26(sp),a0
 movea.w 106(a0),a0
 move.l a0,d1
 movea.l 26(sp),a0
 move.l 114(a0),d0
 bsr.w L1806c
 lea 16(sp),sp
 bra.s L1662e
L165e0 movea.l 10(sp),a0
 movea.w 108(a0),a0
 move.l a0,-(sp)
 movea.l 14(sp),a0
 movea.w 106(a0),a0
 move.l a0,-(sp)
 movea.l 18(sp),a0
 movea.w 88(a0),a0
 move.l a0,-(sp)
 movea.l 22(sp),a0
 movea.w 86(a0),a0
 move.l a0,-(sp)
 movea.w 18(sp),a0
 move.l a0,-(sp)
 movea.w 20(sp),a0
 move.l a0,-(sp)
 movea.l 34(sp),a0
 move.l 114(a0),d1
 movea.l 34(sp),a0
 move.l 110(a0),d0
 movea.l _012da(a6),a0
 jsr (a0)
 lea 24(sp),sp
L1662e move.l 10(sp),D0069e(a6)
L16634 move.l (a2),d0
 lsl.l #3,d0
 movea.l 10(sp),a0
 move.l 34(a0,d0.l),(a2)
 tst.l 6(sp)
 beq.s L16656
 pea (a2)
 move.l 10(sp),d1
 move.l 18(sp),d0
 bsr.w L1a7bc
 addq.l #4,sp
L16656 lea 14(sp),sp
 movem.l -8(a5),a0/a2
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 move.l #-106,d0
 jsr _01b74(a6)
 lea -14(sp),sp
 movea.l 18(sp),a0
 move.l 22(a0),10(sp)
 movea.l 10(sp),a0
 move.l 70(a0),6(sp)
 movea.l 10(sp),a0
 move.w 96(a0),4(sp)
 movea.l 10(sp),a0
 cmpi.w #1,120(a0)
 bne.s L166b4
 movea.l 10(sp),a0
 move.l 98(a0),(sp)
 move.w 2(sp),4(sp)
 bra.s L166cc
L166b4 movea.l 10(sp),a0
 move.l 94(a0),(sp)
 move.w 2(sp),4(sp)
 movea.l 10(sp),a0
 move.w #2,120(a0)
L166cc bsr.w L16430
 cmpi.w #-1,2(sp)
 beq.w L16774
 cmpi.w #-1,(sp)
 bne.s L16720
 movea.w 4(sp),a0
 move.l a0,-(sp)
 movea.l 14(sp),a0
 movea.w 88(a0),a0
 move.l a0,-(sp)
 movea.l 18(sp),a0
 movea.w 86(a0),a0
 move.l a0,-(sp)
 movea.l 22(sp),a0
 movea.w 108(a0),a0
 move.l a0,-(sp)
 movea.l 26(sp),a0
 movea.w 106(a0),a0
 move.l a0,d1
 movea.l 26(sp),a0
 move.l 114(a0),d0
 bsr.w L1806c
 lea 16(sp),sp
 bra.s L1676e
L16720 movea.l 10(sp),a0
 movea.w 108(a0),a0
 move.l a0,-(sp)
 movea.l 14(sp),a0
 movea.w 106(a0),a0
 move.l a0,-(sp)
 movea.l 18(sp),a0
 movea.w 88(a0),a0
 move.l a0,-(sp)
 movea.l 22(sp),a0
 movea.w 86(a0),a0
 move.l a0,-(sp)
 movea.w 18(sp),a0
 move.l a0,-(sp)
 movea.w 20(sp),a0
 move.l a0,-(sp)
 movea.l 34(sp),a0
 move.l 114(a0),d1
 movea.l 34(sp),a0
 move.l 110(a0),d0
 movea.l _012da(a6),a0
 jsr (a0)
 lea 24(sp),sp
L1676e move.l 10(sp),D0069e(a6)
L16774 movea.l 18(sp),a0
 move.l (a0),d0
 lsl.l #3,d0
 movea.l 10(sp),a0
 movea.l 18(sp),a1
 move.l 34(a0,d0.l),(a1)
 tst.l 6(sp)
 beq.s L167a0
 move.l 18(sp),-(sp)
 move.l 10(sp),d1
 move.l 18(sp),d0
 bsr.w L1a7bc
 addq.l #4,sp
L167a0 lea 14(sp),sp
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 move.l #-102,d0
 jsr _01b74(a6)
 lea -10(sp),sp
 movea.l 14(sp),a0
 move.l 22(a0),6(sp)
 movea.l 6(sp),a0
 move.l 78(a0),2(sp)
 movea.l 6(sp),a0
 move.w 92(a0),(sp)
 movea.l 6(sp),a0
 cmpi.w #-1,92(a0)
 beq.w L1688e
 movea.l 6(sp),a0
 cmpi.w #-1,90(a0)
 bne.s L16838
 movea.w (sp),a0
 move.l a0,-(sp)
 movea.l 10(sp),a0
 movea.w 88(a0),a0
 move.l a0,-(sp)
 movea.l 14(sp),a0
 movea.w 86(a0),a0
 move.l a0,-(sp)
 movea.l 18(sp),a0
 movea.w 108(a0),a0
 move.l a0,-(sp)
 movea.l 22(sp),a0
 movea.w 106(a0),a0
 move.l a0,d1
 movea.l 22(sp),a0
 move.l 114(a0),d0
 bsr.w L1806c
 lea 16(sp),sp
 bra.s L1688e
L16838 movea.l 6(sp),a0
 movea.w 108(a0),a0
 move.l a0,-(sp)
 movea.l 10(sp),a0
 movea.w 106(a0),a0
 move.l a0,-(sp)
 movea.l 14(sp),a0
 movea.w 88(a0),a0
 move.l a0,-(sp)
 movea.l 18(sp),a0
 movea.w 86(a0),a0
 move.l a0,-(sp)
 movea.l 22(sp),a0
 movea.w 92(a0),a0
 move.l a0,-(sp)
 movea.l 26(sp),a0
 movea.w 90(a0),a0
 move.l a0,-(sp)
 movea.l 30(sp),a0
 move.l 114(a0),d1
 movea.l 30(sp),a0
 move.l 110(a0),d0
 movea.l _012da(a6),a0
 jsr (a0)
 lea 24(sp),sp
L1688e clr.l D0069e(a6)
 movea.l 6(sp),a0
 clr.w 120(a0)
 movea.l 14(sp),a0
 move.l (a0),d0
 lsl.l #3,d0
 movea.l 6(sp),a0
 movea.l 14(sp),a1
 move.l 34(a0,d0.l),(a1)
 tst.l 2(sp)
 beq.s L168c6
 move.l 14(sp),-(sp)
 move.l 6(sp),d1
 move.l 14(sp),d0
 bsr.w L1a7bc
 addq.l #4,sp
L168c6 lea 10(sp),sp
 movem.l -8(a5),a0-a1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2/d0-d1,-(sp)
 movea.l d1,a2
 move.l #-106,d0
 jsr _01b74(a6)
 lea -14(sp),sp
 move.l 22(a2),10(sp)
 movea.l 10(sp),a0
 move.w 100(a0),4(sp)
 move.l (a2),d0
 lsl.l #3,d0
 movea.l 10(sp),a0
 move.l 30(a0,d0.l),6(sp)
 movea.l 10(sp),a0
 tst.w 120(a0)
 beq.s L16920
 movea.l 10(sp),a0
 cmpi.w #2,120(a0)
 bne.s L16954
L16920 movea.l 10(sp),a0
 cmpi.w #-1,104(a0)
 beq.s L16940
 movea.l 10(sp),a0
 move.l 102(a0),(sp)
 movea.l 10(sp),a0
 move.w #3,120(a0)
 bra.s L1699c
L16940 movea.l 10(sp),a0
 move.l 98(a0),(sp)
 movea.l 10(sp),a0
 move.w #1,120(a0)
 bra.s L1699c
L16954 movea.l 10(sp),a0
 cmpi.w #1,120(a0)
 beq.s L1696c
 movea.l 10(sp),a0
 cmpi.w #3,120(a0)
 bne.s L169a2
L1696c movea.l 10(sp),a0
 cmpi.w #-1,96(a0)
 beq.s L1698c
 movea.l 10(sp),a0
 move.l 94(a0),(sp)
 movea.l 10(sp),a0
 move.w #2,120(a0)
 bra.s L1699c
L1698c movea.l 10(sp),a0
 move.l 90(a0),(sp)
 movea.l 10(sp),a0
 clr.w 120(a0)
L1699c move.w 2(sp),4(sp)
L169a2 cmpi.w #-1,2(sp)
 beq.w L16a40
 cmpi.w #-1,(sp)
 bne.s L169f2
 movea.w 4(sp),a0
 move.l a0,-(sp)
 movea.l 14(sp),a0
 movea.w 88(a0),a0
 move.l a0,-(sp)
 movea.l 18(sp),a0
 movea.w 86(a0),a0
 move.l a0,-(sp)
 movea.l 22(sp),a0
 movea.w 108(a0),a0
 move.l a0,-(sp)
 movea.l 26(sp),a0
 movea.w 106(a0),a0
 move.l a0,d1
 movea.l 26(sp),a0
 move.l 114(a0),d0
 bsr.w L1806c
 lea 16(sp),sp
 bra.s L16a40
L169f2 movea.l 10(sp),a0
 movea.w 108(a0),a0
 move.l a0,-(sp)
 movea.l 14(sp),a0
 movea.w 106(a0),a0
 move.l a0,-(sp)
 movea.l 18(sp),a0
 movea.w 88(a0),a0
 move.l a0,-(sp)
 movea.l 22(sp),a0
 movea.w 86(a0),a0
 move.l a0,-(sp)
 movea.w 18(sp),a0
 move.l a0,-(sp)
 movea.w 20(sp),a0
 move.l a0,-(sp)
 movea.l 34(sp),a0
 move.l 114(a0),d1
 movea.l 34(sp),a0
 move.l 110(a0),d0
 movea.l _012da(a6),a0
 jsr (a0)
 lea 24(sp),sp
L16a40 move.l (a2),d0
 lsl.l #3,d0
 movea.l 10(sp),a0
 move.l 34(a0,d0.l),(a2)
 tst.l 6(sp)
 beq.s L16a62
 pea (a2)
 move.l 10(sp),d1
 move.l 18(sp),d0
 bsr.w L1a7bc
 addq.l #4,sp
L16a62 lea 14(sp),sp
 movem.l -8(a5),a0/a2
 unlk a5
 rts 
L16a70 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l #-98,d0
 jsr _01b74(a6)
 subq.l #6,sp
 bra.s L16ab6
 movea.l 6(sp),a0
 move.l 98(a0),2(sp)
 bra.s L16ad4
 movea.l 6(sp),a0
 move.l 90(a0),2(sp)
 bra.s L16ad4
 movea.l 6(sp),a0
 move.l 94(a0),2(sp)
 bra.s L16ad4
 movea.l 6(sp),a0
 move.l 102(a0),2(sp)
 bra.s L16ad4
L16ab6 move.w 12(sp),d0
 cmpi.w #3,d0
 bhi.w L16b80
 add.w d0,d0
 move.w L16aca(pc,d0.w),d0
 jmp L16aca(pc,d0.w)
L16aca equ *-2
 dc.w $ffc6
 dc.w $ffba
 dc.w $ffd2
 dc.w $ffde
L16ad4 move.w 4(sp),(sp)
 cmpi.w #-1,4(sp)
 beq.w L16b76
 cmpi.w #-1,2(sp)
 bne.s L16b28
 movea.w (sp),a0
 move.l a0,-(sp)
 movea.l 10(sp),a0
 movea.w 88(a0),a0
 move.l a0,-(sp)
 movea.l 14(sp),a0
 movea.w 86(a0),a0
 move.l a0,-(sp)
 movea.l 18(sp),a0
 movea.w 108(a0),a0
 move.l a0,-(sp)
 movea.l 22(sp),a0
 movea.w 106(a0),a0
 move.l a0,d1
 movea.l 22(sp),a0
 move.l 114(a0),d0
 bsr.w L1806c
 lea 16(sp),sp
 bra.s L16b76
L16b28 movea.l 6(sp),a0
 movea.w 108(a0),a0
 move.l a0,-(sp)
 movea.l 10(sp),a0
 movea.w 106(a0),a0
 move.l a0,-(sp)
 movea.l 14(sp),a0
 movea.w 88(a0),a0
 move.l a0,-(sp)
 movea.l 18(sp),a0
 movea.w 86(a0),a0
 move.l a0,-(sp)
 movea.w 20(sp),a0
 move.l a0,-(sp)
 movea.w 22(sp),a0
 move.l a0,-(sp)
 movea.l 30(sp),a0
 move.l 114(a0),d1
 movea.l 30(sp),a0
 move.l 110(a0),d0
 movea.l _012da(a6),a0
 jsr (a0)
 lea 24(sp),sp
L16b76 movea.l 6(sp),a0
 move.w 12(sp),120(a0)
L16b80 addq.l #6,sp
 movem.l -4(a5),a0
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2/d0-d1,-(sp)
 move.l #-64,d0
 jsr _01b74(a6)
 movea.l (sp),a2
 bra.s L16ba8
L16ba2 move.l 24(sp),d0
 adda.l d0,a2
L16ba8 tst.l 18(a2)
 bne.s L16ba2
 movea.l 4(sp),a0
 move.l 22(a0),18(a2)
 movea.l 4(sp),a0
 move.l (sp),22(a0)
 movem.l -8(a5),a0/a2
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l #-64,d0
 jsr _01b74(a6)
 btst.b #2,7(sp)
 beq.s L16bf4
 movea.l (sp),a0
 move.l 20(sp),38(a0)
 movea.l (sp),a0
 move.l 24(sp),42(a0)
L16bf4 btst.b #4,7(sp)
 beq.s L16c0c
 movea.l (sp),a0
 move.l 20(sp),54(a0)
 movea.l (sp),a0
 move.l 24(sp),58(a0)
L16c0c btst.b #3,7(sp)
 beq.s L16c24
 movea.l (sp),a0
 move.l 20(sp),46(a0)
 movea.l (sp),a0
 move.l 24(sp),50(a0)
L16c24 btst.b #5,7(sp)
 beq.s L16c3c
 movea.l (sp),a0
 move.l 20(sp),62(a0)
 movea.l (sp),a0
 move.l 24(sp),66(a0)
L16c3c btst.b #0,6(sp)
 beq.s L16c54
 movea.l (sp),a0
 move.l 20(sp),70(a0)
 movea.l (sp),a0
 move.l 24(sp),74(a0)
L16c54 btst.b #1,6(sp)
 beq.s L16c6c
 movea.l (sp),a0
 move.l 20(sp),78(a0)
 movea.l (sp),a0
 move.l 24(sp),82(a0)
L16c6c btst.b #0,7(sp)
 beq.s L16c84
 movea.l (sp),a0
 move.l 20(sp),30(a0)
 movea.l (sp),a0
 move.l 24(sp),34(a0)
L16c84 movem.l -4(a5),a0
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0,-(sp)
 move.l #-68,d0
 jsr _01b74(a6)
 subq.l #4,sp
 clr.l (sp)
 bra.s L16cc0
L16ca6 move.l (sp),d0
 lsl.l #3,d0
 movea.l 4(sp),a0
 clr.l 30(a0,d0.l)
 move.l (sp),d0
 lsl.l #3,d0
 movea.l 4(sp),a0
 clr.l 34(a0,d0.l)
 addq.l #1,(sp)
L16cc0 moveq #7,d0
 cmp.l (sp),d0
 bgt.s L16ca6
 addq.l #4,sp
 movem.l -4(a5),a0
 unlk a5
 rts 
L16cd2 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 tst.l (sp)
 beq.s L16d38
 tst.l 4(sp)
 beq.s L16d38
 tst.l 24(sp)
 beq.s L16d38
 move.l 4(sp),d1
 move.l (sp),d0
 bsr.w L1736c
 movea.l (sp),a0
 move.l 24(sp),d0
 cmp.l 28(a0),d0
 bne.s L16d2e
 movea.l 24(sp),a0
 move.l 4(sp),56(a0)
 movea.l 4(sp),a0
 move.l 24(sp),52(a0)
 movea.l 4(sp),a0
 clr.l 56(a0)
 movea.l 4(sp),a0
 move.w #1,(a0)
 movea.l (sp),a0
 move.l 4(sp),28(a0)
 bra.s L16d74
L16d2e movea.l 24(sp),a0
 tst.l 56(a0)
 bne.s L16d3c
L16d38 moveq #255,d0
 bra.s L16d76
L16d3c movea.l 24(sp),a0
 movea.l 4(sp),a1
 move.l 56(a0),56(a1)
 movea.l 4(sp),a0
 movea.l 56(a0),a0
 move.l 4(sp),52(a0)
 movea.l 4(sp),a0
 move.l 24(sp),52(a0)
 movea.l 24(sp),a0
 move.l 4(sp),56(a0)
 movea.l 4(sp),a0
 move.w #1,(a0)
L16d74 moveq #0,d0
L16d76 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L16d80 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 tst.l (sp)
 beq.s L16d92
 tst.l 4(sp)
 bne.s L16d96
L16d92 moveq #255,d0
 bra.s L16dfa
L16d96 movea.l (sp),a0
 move.l 4(sp),d0
 cmp.l 28(a0),d0
 beq.s L16df8
 move.l 4(sp),d1
 move.l (sp),d0
 bsr.w L1736c
 movea.l (sp),a0
 tst.l 28(a0)
 beq.s L16de0
 movea.l (sp),a0
 movea.l 4(sp),a1
 move.l 28(a0),52(a1)
 movea.l 4(sp),a0
 movea.l 52(a0),a0
 move.l 4(sp),56(a0)
 movea.l 4(sp),a0
 clr.l 56(a0)
 movea.l (sp),a0
 move.l 4(sp),28(a0)
 bra.s L16df0
L16de0 movea.l (sp),a0
 move.l 4(sp),28(a0)
 movea.l (sp),a0
 move.l 4(sp),24(a0)
L16df0 movea.l 4(sp),a0
 move.w #1,(a0)
L16df8 moveq #0,d0
L16dfa movem.l -8(a5),a0-a1
 unlk a5
 rts 
L16e04 link.w a5,#0
 movem.l a0/a2/d0-d1,-(sp)
 tst.l (sp)
 beq.s L16e18
 movea.l (sp),a0
 tst.l 32(a0)
 bne.s L16e1c
L16e18 moveq #0,d0
 bra.s L16e80
L16e1c movea.l (sp),a0
 movea.l 32(a0),a2
 movea.l (sp),a0
 move.l 56(a2),32(a0)
 clr.l 56(a2)
 move.l 4(sp),14(a2)
 move.l 24(sp),18(a2)
 move.l 28(sp),22(a2)
 move.l 32(sp),26(a2)
 move.l 36(sp),30(a2)
 clr.l 34(a2)
 move.w 42(sp),38(a2)
 move.w #8,(a2)
 clr.l 6(a2)
 clr.l 10(a2)
 move.w 42(sp),42(a2)
 move.w 42(sp),44(a2)
 clr.w 40(a2)
 move.l 44(sp),46(a2)
 move.w 50(sp),50(a2)
 move.l a2,d0
L16e80 movem.l -8(a5),a0/a2
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 tst.l (sp)
 beq.s L16ef0
 tst.l 4(sp)
 beq.s L16ef0
 tst.l 24(sp)
 beq.s L16ef0
 move.l 4(sp),d1
 move.l (sp),d0
 bsr.w L1736c
 movea.l (sp),a0
 move.l 24(sp),d0
 cmp.l 24(a0),d0
 bne.s L16ee6
 movea.l 24(sp),a0
 move.l 4(sp),52(a0)
 movea.l 4(sp),a0
 move.l 24(sp),56(a0)
 movea.l 4(sp),a0
 clr.l 52(a0)
 movea.l 4(sp),a0
 move.w #1,(a0)
 movea.l (sp),a0
 move.l 4(sp),24(a0)
 bra.s L16f2c
L16ee6 movea.l 24(sp),a0
 tst.l 52(a0)
 bne.s L16ef4
L16ef0 moveq #255,d0
 bra.s L16f2e
L16ef4 movea.l 24(sp),a0
 movea.l 52(a0),a0
 move.l 4(sp),56(a0)
 movea.l 24(sp),a0
 movea.l 4(sp),a1
 move.l 52(a0),52(a1)
 movea.l 4(sp),a0
 move.l 24(sp),56(a0)
 movea.l 24(sp),a0
 move.l 4(sp),52(a0)
 movea.l 4(sp),a0
 move.w #1,(a0)
L16f2c moveq #0,d0
L16f2e movem.l -8(a5),a0-a1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 tst.l 4(sp)
 bne.s L16f4a
 moveq #255,d0
 bra.s L16f92
L16f4a movea.l (sp),a0
 movea.l 4(sp),a1
 move.l 24(a0),56(a1)
 movea.l (sp),a0
 move.l 4(sp),24(a0)
 movea.l 4(sp),a0
 clr.l 52(a0)
 movea.l 4(sp),a0
 move.w #1,(a0)
 movea.l 4(sp),a0
 tst.l 56(a0)
 beq.s L16f88
 movea.l 4(sp),a0
 movea.l 56(a0),a0
 move.l 4(sp),52(a0)
 bra.s L16f90
L16f88 movea.l (sp),a0
 move.l 4(sp),28(a0)
L16f90 moveq #0,d0
L16f92 movem.l -8(a5),a0-a1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2-a3/d0-d2/d4,-(sp)
 tst.l 40(sp)
 beq.s L16fe6
 tst.l 44(sp)
 beq.s L16fe6
 tst.l 4(sp)
 beq.s L16fe6
 move.l 36(sp),d1
 moveq #70,d0
 bsr.w L1aa4e
 movea.l d0,a3
 move.l a3,d0
 beq.s L16fe6
 move.l 36(sp),d1
 move.l d1,d2
 move.l (sp),d0
 move.l 4(sp),d1
 bsr.w L1ca40
 move.l d2,d1
 bsr.w L1aa4e
 move.l d0,36(a3)
 tst.l 36(a3)
 bne.s L16fea
L16fe6 moveq #0,d0
 bra.s L1704c
L16fea move.l 4(sp),44(a3)
 move.l (sp),40(a3)
 move.l a3,d0
 bsr.w L17e40
 move.l 48(sp),12(a3)
 move.l 40(sp),2(a3)
 move.l 44(sp),6(a3)
 clr.w 20(a3)
 clr.l 24(a3)
 clr.l 28(a3)
 move.l 36(a3),32(a3)
 move.l 52(sp),16(a3)
 move.w #8,(a3)
 moveq #1,d0
 bsr.w L1a162
 moveq #0,d1
 move.w d0,d1
 move.l d1,48(a3)
 clr.l -(sp)
 pea (a3)
 lea L1709a(pc),a0
 move.l a0,d1
 move.l 48(a3),d0
 bsr.w L1a29a
 addq.l #8,sp
 move.l a3,d0
L1704c movem.l -20(a5),a0/a2-a3/d2/d4
 unlk a5
 rts 
L17056 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
 movea.l 32(sp),a3
 move.l a3,d0
 andi.l #$00ffffff,d0
 bset.l #30,d0
 move.l d0,-(sp)
 clr.l -(sp)
 movea.w 10(a2),a0
 move.l a0,-(sp)
 move.l 12(a2),d1
 move.l d4,d0
 bsr.w L1b47a
 lea 12(sp),sp
 move.w #1,52(a2)
 movem.l -16(a5),a0/a2-a3/d4
 unlk a5
 rts 
L1709a link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d5,-(sp)
 movea.l d1,a2
 subq.l #4,sp
 move.w 20(a2),d0
 ext.l d0
 lsl.l #2,d0
 movea.l 2(a2,d0.l),a4
 tst.w 20(a2)
 bne.s L170bc
 moveq #1,d0
 bra.s L170be
L170bc moveq #0,d0
L170be lsl.l #2,d0
 move.l 2(a2,d0.l),d4
 movea.w 20(a2),a0
 move.l a0,d5
 tst.w 52(a2)
 bne.s L170da
 pea (a2)
 lea L1709a(pc),a0
 move.l a0,d1
 bra.s L1710a
L170da cmpi.w #1,(a2)
 bne.s L170f0
 movea.w 22(a2),a0
 move.l a0,d1
 move.l 48(a2),d0
 bsr.w L1d574
 bra.s L17118
L170f0 cmpi.w #2,(a2)
 bne.s L17118
 move.w #8,(a2)
 tst.l 62(a2)
 beq.w L17258
 move.l 66(a2),-(sp)
 move.l 62(a2),d1
L1710a move.l 8(sp),d0
 bsr.w L1a7bc
 addq.l #4,sp
 bra.w L17258
L17118 movea.l 24(a2),a3
 bra.s L1718a
L1711e tst.l 22(a3)
 beq.s L17146
 move.l d5,-(sp)
 pea (a4)
 move.l d5,d0
 lsl.l #1,d0
 movea.w 42(a3,d0.l),a0
 move.l a0,-(sp)
 move.l d5,d0
 lsl.l #2,d0
 move.l 6(a3,d0.l),d1
 move.l a3,d0
 movea.l 22(a3),a0
 jsr (a0)
 lea 12(sp),sp
L17146 move.l 56(a3),(sp)
 btst.b #1,1(a3)
 beq.s L17188
 btst.b #2,1(a3)
 beq.s L17176
 move.w #8,(a3)
 move.l a3,d1
 move.l a2,d0
 bsr.w L1736c
 tst.l 30(a3)
 beq.s L17188
 move.l a3,d0
 movea.l 30(a3),a0
 jsr (a0)
 bra.s L17188
L17176 bset.b #2,1(a3)
 clr.l 26(a3)
 clr.l 18(a3)
 clr.l 14(a3)
L17188 movea.l (sp),a3
L1718a move.l a3,d0
 bne.s L1711e
 movea.l 28(a2),a3
 bra.s L171c8
L17194 tst.l 14(a3)
 beq.s L171b0
 pea (a4)
 movea.w 38(a3),a0
 move.l a0,-(sp)
 move.l 2(a3),d1
 move.l a3,d0
 movea.l 14(a3),a0
 jsr (a0)
 addq.l #8,sp
L171b0 move.l d5,d0
 lsl.l #2,d0
 move.l 2(a3),6(a3,d0.l)
 move.l d5,d0
 lsl.l #1,d0
 move.w 38(a3),42(a3,d0.l)
 movea.l 52(a3),a3
L171c8 move.l a3,d0
 bne.s L17194
 clr.w 52(a2)
 movea.w 20(a2),a0
 move.l a0,-(sp)
 pea (a4)
 move.l 16(a2),d1
 move.l a2,d0
 movea.l 54(a2),a0
 jsr (a0)
 addq.l #8,sp
 cmpi.w #16,(a2)
 bne.s L171fe
 tst.w 20(a2)
 bne.s L171f6
 moveq #1,d0
 bra.s L171f8
L171f6 moveq #0,d0
L171f8 move.w d0,20(a2)
 bra.s L17258
L171fe movea.l 24(a2),a3
 bra.s L17218
L17204 tst.l 18(a3)
 beq.s L17214
 move.l a4,d1
 move.l a3,d0
 movea.l 18(a3),a0
 jsr (a0)
L17214 movea.l 56(a3),a3
L17218 move.l a3,d0
 bne.s L17204
 movea.l 24(a2),a3
 bra.s L17238
L17222 tst.l 26(a3)
 beq.s L17234
 move.l 34(a3),d1
 move.l a3,d0
 movea.l 26(a3),a0
 jsr (a0)
L17234 movea.l 56(a3),a3
L17238 move.l a3,d0
 bne.s L17222
 tst.w 20(a2)
 bne.s L17246
 moveq #1,d0
 bra.s L17248
L17246 moveq #0,d0
L17248 move.w d0,20(a2)
 tst.l 58(a2)
 beq.s L17258
 movea.l 58(a2),a0
 jsr (a0)
L17258 addq.l #4,sp
 movem.l -24(a5),a0/a2-a4/d4-d5
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 tst.l (sp)
 bne.s L17274
 moveq #255,d0
 bra.s L172d0
L17274 tst.l 28(sp)
 beq.s L17284
 movea.l (sp),a0
 move.l 28(sp),54(a0)
 bra.s L1728e
L17284 lea L17056(pc),a0
 movea.l (sp),a1
 move.l a0,54(a1)
L1728e movea.l (sp),a0
 move.w 6(sp),22(a0)
 movea.l (sp),a0
 move.w #1,(a0)
 movea.l (sp),a0
 move.w 26(sp),10(a0)
 movea.l (sp),a0
 move.l 32(sp),58(a0)
 movea.l (sp),a0
 move.w #1,52(a0)
 movea.l (sp),a0
 move.l 36(sp),62(a0)
 movea.l (sp),a0
 movea.w 22(a0),a0
 move.l a0,d1
 movea.l (sp),a0
 move.l 48(a0),d0
 bsr.w L1d574
 moveq #0,d0
L172d0 movem.l -8(a5),a0-a1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 tst.l (sp)
 bne.s L172ea
 moveq #255,d0
 bra.s L17330
L172ea tst.l 24(sp)
 beq.s L172fa
 movea.l (sp),a0
 move.l 24(sp),54(a0)
 bra.s L17304
L172fa lea L17056(pc),a0
 movea.l (sp),a1
 move.l a0,54(a1)
L17304 movea.l (sp),a0
 move.w #16,(a0)
 movea.l (sp),a0
 move.w 6(sp),10(a0)
 movea.l (sp),a0
 move.l 28(sp),58(a0)
 movea.l (sp),a0
 move.w #1,52(a0)
 movea.l (sp),a0
 clr.l 62(a0)
 move.l (sp),d1
 moveq #0,d0
 bsr.w L1709a
L17330 movem.l -8(a5),a0-a1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 tst.l (sp)
 bne.s L1734a
 moveq #255,d0
 bra.s L17362
L1734a movea.l (sp),a0
 move.w #2,(a0)
 movea.l (sp),a0
 move.l 4(sp),62(a0)
 movea.l (sp),a0
 move.l 20(sp),66(a0)
 moveq #0,d0
L17362 movem.l -4(a5),a0
 unlk a5
 rts 
L1736c link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 tst.l 4(sp)
 beq.w L17448
 tst.l (sp)
 beq.w L17448
 movea.l (sp),a0
 tst.l 24(a0)
 beq.w L17448
 movea.l (sp),a0
 move.l 4(sp),d0
 cmp.l 24(a0),d0
 bne.s L173be
 movea.l 4(sp),a0
 movea.l (sp),a1
 move.l 56(a0),24(a1)
 bne.s L173b0
 movea.l (sp),a0
 clr.l 28(a0)
 bra.w L1742c
L173b0 movea.l 4(sp),a0
 movea.l 56(a0),a0
 clr.l 52(a0)
 bra.s L1742c
L173be movea.l (sp),a0
 move.l 4(sp),d0
 cmp.l 28(a0),d0
 bne.s L173f4
 movea.l 4(sp),a0
 movea.l (sp),a1
 move.l 52(a0),28(a1)
 movea.l 4(sp),a0
 movea.l 52(a0),a0
 clr.l 56(a0)
 movea.l 4(sp),a0
 clr.l 52(a0)
 movea.l 4(sp),a0
 clr.l 56(a0)
 bra.s L1743c
L173f4 movea.l 4(sp),a0
 tst.l 52(a0)
 beq.s L17448
 movea.l 4(sp),a0
 tst.l 56(a0)
 beq.s L17448
 movea.l 4(sp),a0
 movea.l 4(sp),a1
 movea.l 52(a1),a1
 move.l 56(a0),56(a1)
 movea.l 4(sp),a0
 movea.l 4(sp),a1
 movea.l 56(a1),a1
 move.l 52(a0),52(a1)
L1742c movea.l 4(sp),a0
 clr.l 56(a0)
 movea.l 4(sp),a0
 clr.l 52(a0)
L1743c movea.l 4(sp),a0
 move.w #8,(a0)
 moveq #0,d0
 bra.s L1744a
L17448 moveq #255,d0
L1744a movem.l -8(a5),a0-a1
 unlk a5
 rts 
 movem.l a0-a2/d2-d5,-(sp)
 movea.l d0,a0
 movea.l 0(a0),a1
 movea.l 4(a0),a2
 addq.l #4,a1
 moveq #0,d1
 moveq #0,d2
L17468 move.l (a1),d3
 beq.s L1747c
 move.w (a1)+,d1
 adda.l d1,a2
 move.w (a1)+,d2
 beq.s L17468
L17474 move.l (a1)+,(a2)+
 subq.l #1,d2
 bne.s L17474
 bra.s L17468
L1747c movem.l (sp)+,a0-a2/d2-d5
 rts 
 movem.l a0-a2/d2-d5,-(sp)
 movea.l d0,a0
 movea.l 0(a0),a1
 movea.l 4(a0),a2
 move.l 8(a0),d4
 move.l (a1)+,d0
 moveq #0,d1
 moveq #0,d2
L1749a move.l (a1),d3
 beq.w L1763a
 move.w (a1)+,d1
 adda.l d1,a2
 move.w (a1)+,d2
 beq.s L1749a
 move.l #96,d3
 sub.l d2,d3
 lsl.l #2,d3
 jmp L174b4(pc,d3.l)
L174b4 equ *-2
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 move.l d4,(a2)+
 addq.l #4,a1
 bra.w L1749a
L1763a movem.l (sp)+,a0-a2/d2-d5
 rts 
L17640 movem.l a0-a2/d2-d5,-(sp)
 movea.l d0,a0
 movea.l 0(a0),a1
 movea.l 4(a0),a2
 movea.l 8(a0),a3
 addq.l #4,a1
 moveq #0,d1
 moveq #0,d2
 moveq #0,d3
L1765a move.l (a1),d3
 beq.w L177fc
 move.w (a1)+,d1
 adda.l d1,a2
 adda.l d1,a3
 move.w (a1)+,d2
 beq.s L1765a
 move.l #96,d3
 sub.l d2,d3
 lsl.l #2,d3
 jmp L17676(pc,d3.l)
L17676 equ *-2
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 move.l (a3)+,(a2)+
 addq.l #4,a1
 bra.w L1765a
L177fc movem.l (sp)+,a0-a2/d2-d5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l 44(sp),a0
 move.l (sp),14(a0)
 movea.l 44(sp),a0
 move.l 4(sp),18(a0)
 movea.l 44(sp),a0
 move.l 20(sp),22(a0)
 movea.l 44(sp),a0
 move.l 24(sp),26(a0)
 movea.l 44(sp),a0
 move.l 28(sp),30(a0)
 movea.l 44(sp),a0
 clr.l 34(a0)
 movea.l 44(sp),a0
 move.w 34(sp),38(a0)
 movea.l 44(sp),a0
 move.w #8,(a0)
 movea.l 44(sp),a0
 clr.l 6(a0)
 movea.l 44(sp),a0
 clr.l 10(a0)
 movea.l 44(sp),a0
 move.w 34(sp),42(a0)
 movea.l 44(sp),a0
 move.w 34(sp),44(a0)
 movea.l 44(sp),a0
 clr.w 40(a0)
 movea.l 44(sp),a0
 move.l 36(sp),46(a0)
 movea.l 44(sp),a0
 move.w 42(sp),50(a0)
 movea.l 44(sp),a0
 clr.l 52(a0)
 movea.l 44(sp),a0
 clr.l 56(a0)
 movem.l -4(a5),a0
 unlk a5
 rts 
L178ae link.w a5,#0
 movem.l a0/a2-a3/d0/d4,-(sp)
 subq.l #4,sp
 movea.l 4(sp),a2
 move.l 4(sp),(sp)
 addq.l #8,a2
 movea.l a2,a3
 movea.l (sp),a0
 move.l a2,4(a0)
 moveq #0,d4
 bra.s L178d8
L178ce move.l 4(sp),d0
 add.l d0,(a3)
 addq.l #1,d4
 addq.l #4,a3
L178d8 movea.l (sp),a0
 cmp.l (a0),d4
 bcs.s L178ce
 move.l (sp),d0
 addq.l #4,sp
 movem.l -16(a5),a0/a2-a3/d4
 unlk a5
 rts 
L178ec link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 tst.l (sp)
 beq.s L17908
 tst.l 4(sp)
 beq.s L17908
 movea.l 4(sp),a0
 cmpi.w #8,(a0)
 beq.s L1790c
L17908 moveq #255,d0
 bra.s L17928
L1790c movea.l 4(sp),a0
 clr.w (a0)
 movea.l (sp),a0
 movea.l 4(sp),a1
 move.l 32(a0),56(a1)
 movea.l (sp),a0
 move.l 4(sp),32(a0)
 moveq #0,d0
L17928 movem.l -8(a5),a0-a1
 unlk a5
 rts 
L17932 movem.l a0-a2/d2-d5,-(sp)
 movea.l d0,a0
 movea.l 0(a0),a1
 movea.l 4(a0),a2
 movea.l 8(a0),a3
 move.b 16(a0),d4
 move.l 12(a0),d5
 addq.l #4,a1
 moveq #0,d1
 moveq #0,d2
L17952 move.l (a1),d3
 beq.s L1797c
 move.w (a1)+,d1
 adda.l d1,a2
 adda.l d1,a3
 move.w (a1)+,d2
 beq.s L17952
L17960 cmp.b 1(a3),d4
 bcc.s L17970
 cmp.b 3(a3),d4
 bcc.s L17970
 move.l (a1)+,(a2)+
 bra.s L17974
L17970 move.l d5,(a2)+
 addq.l #4,a1
L17974 addq.l #4,a3
 subq.l #1,d2
 bne.s L17960
 bra.s L17952
L1797c movem.l (sp)+,a0-a2/d2-d5
 rts 
L17982 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.l (sp),a0
 move.l 4(sp),26(a0)
 movea.l (sp),a0
 move.l 20(sp),34(a0)
 movem.l -4(a5),a0
 unlk a5
 rts 
L179a4 movem.l a0-a2/d2-d7,-(sp)
 movea.l d0,a0
 movea.l 0(a0),a1
 movea.l 4(a0),a2
 addq.l #4,a1
 moveq #0,d1
 moveq #0,d2
 move.l 12(a0),d4
 move.l 18(a0),d5
L179c0 move.l (a1),d3
 beq.w L17ce0
 move.w (a1)+,d1
 adda.l d1,a2
 move.w (a1)+,d2
 beq.s L179c0
 move.l #96,d3
 sub.l d2,d3
 lsl.l #3,d3
 jmp L179da(pc,d3.l)
L179da equ *-2
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 move.l (a1)+,d6
 and.l d4,d6
 or.l d5,d6
 move.l d6,(a2)+
 bra.w L179c0
L17ce0 move.l d5,4(a0)
 movem.l (sp)+,a0-a2/d2-d7
 rts 
L17cea movem.l a0-a2/d2-d7,-(sp)
 movea.l d0,a0
 movea.l 0(a0),a1
 movea.l 4(a0),a2
 movea.l 8(a0),a3
 move.b 16(a0),d4
 addq.l #4,a1
 moveq #0,d1
 moveq #0,d2
 move.l 12(a0),d5
 move.l 18(a0),d6
L17d0e move.l (a1),d3
 beq.s L17d3e
 move.w (a1)+,d1
 adda.l d1,a2
 adda.l d1,a3
 move.w (a1)+,d2
 beq.s L17d0e
L17d1c cmp.b 1(a3),d4
 bcc.s L17d32
 cmp.b 3(a3),d4
 bcc.s L17d32
 move.l (a1)+,d7
 and.l d5,d7
 or.l d6,d7
 move.l d7,(a2)+
 bra.s L17d36
L17d32 addq.l #4,a1
 addq.l #4,a2
L17d36 addq.l #4,a3
 subq.l #1,d2
 bne.s L17d1c
 bra.s L17d0e
L17d3e movem.l (sp)+,a0-a2/d2-d7
 rts 
L17d44 movem.l a0-a2/d2-d5,-(sp)
 movea.l d0,a0
 movea.l 0(a0),a1
 movea.l 4(a0),a2
 addq.l #4,a1
 moveq #0,d1
 moveq #0,d2
 moveq #0,d3
L17d5a move.l (a1),d3
 beq.w L17e3a
 move.w (a1)+,d1
 adda.l d1,a2
 move.w (a1)+,d2
 beq.s L17d5a
 move.l #96,d3
 sub.l d2,d3
 lsl.l #1,d3
 jmp L17d74(pc,d3.l)
L17d74 equ *-2
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 move.l (a1)+,(a2)+
 bra.w L17d5a
L17e3a movem.l (sp)+,a0-a2/d2-d5
 rts 
L17e40 link.w a5,#0
 movem.l a0-a2/d0/d4,-(sp)
 tst.l (sp)
 bne.s L17e50
 moveq #255,d0
 bra.s L17ea4
L17e50 movea.l (sp),a0
 clr.l 24(a0)
 movea.l (sp),a0
 clr.l 28(a0)
 movea.l (sp),a0
 movea.l (sp),a1
 move.l 36(a0),32(a1)
 moveq #0,d4
 movea.l (sp),a0
 movea.l 36(a0),a2
 bra.s L17e8c
L17e70 clr.w (a2)
 clr.l 52(a2)
 movea.l (sp),a0
 move.l 44(a0),d0
 add.l a2,d0
 move.l d0,56(a2)
 movea.l (sp),a0
 move.l 44(a0),d0
 adda.l d0,a2
 addq.l #1,d4
L17e8c movea.l (sp),a0
 move.l 40(a0),d0
 subq.l #1,d0
 cmp.l d4,d0
 bgt.s L17e70
 clr.w (a2)
 clr.l 52(a2)
 clr.l 56(a2)
 moveq #0,d0
L17ea4 movem.l -16(a5),a0-a2/d4
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 lea -36(sp),sp
 move.w 78(sp),8(sp)
 move.w 82(sp),10(sp)
 move.w 86(sp),12(sp)
 move.w 90(sp),14(sp)
 lea 8(sp),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L18152
 move.l d0,24(sp)
 moveq #1,d0
 cmp.l 24(sp),d0
 beq.w L1805c
 moveq #255,d0
 cmp.l 24(sp),d0
 beq.w L1802a
 moveq #15,d0
 and.w (a2),d0
 cmpi.w #3,d0
 bne.s L17f12
 moveq #48,d0
 and.w (a2),d0
 cmpi.w #16,d0
 bne.s L17f12
 moveq #1,d0
 bra.s L17f14
L17f12 moveq #0,d0
L17f14 move.l d0,20(sp)
 tst.l 20(sp)
 beq.s L17f2e
 moveq #1,d0
 and.w 8(sp),d0
 ext.l d0
 move.l d0,16(sp)
 asr 8(sp)
L17f2e move.w 94(sp),(sp)
 move.w 98(sp),2(sp)
 move.w 86(sp),4(sp)
 move.w 90(sp),6(sp)
 lea (sp),a0
 move.l a0,d1
 move.l a3,d0
 bsr.w L18152
 move.l d0,24(sp)
 moveq #1,d0
 cmp.l 24(sp),d0
 beq.w L1805c
 moveq #255,d0
 cmp.l 24(sp),d0
 beq.w L1802a
 moveq #15,d0
 and.w (a3),d0
 cmpi.w #3,d0
 bne.s L17f7e
 moveq #48,d0
 and.w (a3),d0
 cmpi.w #16,d0
 bne.s L17f7e
 moveq #1,d0
 bra.s L17f80
L17f7e moveq #0,d0
L17f80 move.l d0,32(sp)
 tst.l 32(sp)
 beq.s L17f96
 moveq #1,d0
 and.w (sp),d0
 ext.l d0
 move.l d0,28(sp)
 asr (sp)
L17f96 moveq #0,d5
 move.w 6(a2),d0
 muls.w 10(sp),d0
 add.l 12(a2),d0
 move.w 8(sp),d1
 ext.l d1
 add.l d1,d0
 move.l d0,d4
 move.w 6(a3),d0
 muls.w 2(sp),d0
 add.l 12(a3),d0
 move.w (sp),d1
 ext.l d1
 add.l d1,d0
 movea.l d0,a4
 bra.w L18050
L17fc6 tst.l 20(sp)
 beq.s L1800a
 tst.l 32(sp)
 beq.s L17ff4
 move.l 16(sp),-(sp)
 move.l 32(sp),-(sp)
 movea.w 20(sp),a0
 move.l a0,-(sp)
 move.l d4,d1
 move.l a4,d0
 bsr.w L1ab6c
 lea 12(sp),sp
L17fec moveq #255,d1
 cmp.l d0,d1
 beq.s L1802a
 bra.s L1803e
L17ff4 move.l 16(sp),-(sp)
 movea.w 16(sp),a0
 move.l a0,-(sp)
 move.l d4,d1
 move.l a4,d0
 bsr.w L1ac96
 addq.l #8,sp
 bra.s L17fec
L1800a tst.l 32(sp)
 beq.s L1802e
 move.l 28(sp),-(sp)
 movea.w 16(sp),a0
 move.l a0,-(sp)
 move.l d4,d1
 move.l a4,d0
 bsr.w L1ac36
 addq.l #8,sp
 moveq #255,d1
 cmp.l d0,d1
 bne.s L1803e
L1802a moveq #255,d0
 bra.s L1805e
L1802e movea.w 12(sp),a0
 move.l a0,-(sp)
 move.l d4,d1
 move.l a4,d0
 bsr.w L1c870
 addq.l #4,sp
L1803e addq.l #1,d5
 move.w 6(a2),d0
 ext.l d0
 add.l d0,d4
 move.w 6(a3),d0
 ext.l d0
 adda.l d0,a4
L18050 move.w 14(sp),d0
 ext.l d0
 cmp.l d5,d0
 bgt.w L17fc6
L1805c moveq #0,d0
L1805e lea 36(sp),sp
 movem.l -24(a5),a0/a2-a4/d4-d5
 unlk a5
 rts 
L1806c link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 move.l 56(sp),d4
 lea -12(sp),sp
 move.w 18(sp),(sp)
 move.w 58(sp),2(sp)
 move.w 62(sp),4(sp)
 move.w 66(sp),6(sp)
 lea (sp),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L18152
 move.l d0,8(sp)
 moveq #1,d0
 cmp.l 8(sp),d0
 beq.w L18142
 moveq #255,d0
 cmp.l 8(sp),d0
 beq.s L18116
 moveq #15,d0
 and.w (a2),d0
 cmpi.w #3,d0
 bne.s L180cc
 moveq #48,d0
 and.w (a2),d0
 cmpi.w #16,d0
 bne.s L180cc
 moveq #1,d0
 bra.s L180ce
L180cc moveq #0,d0
L180ce move.l d0,d5
 tst.l d5
 beq.s L180de
 moveq #1,d0
 and.w (sp),d0
 ext.l d0
 move.l d0,d6
 asr (sp)
L180de moveq #0,d7
 move.w 6(a2),d0
 muls.w 2(sp),d0
 add.l 12(a2),d0
 move.w (sp),d1
 ext.l d1
 add.l d1,d0
 movea.l d0,a3
 bra.s L18138
L180f6 tst.l d5
 beq.s L1811a
 move.l d6,-(sp)
 movea.w 8(sp),a0
 move.l a0,-(sp)
 moveq #0,d0
 move.b d4,d0
 move.l d0,d1
 move.l a3,d0
 bsr.w L1aaa0
 addq.l #8,sp
 moveq #255,d1
 cmp.l d0,d1
 bne.s L1812e
L18116 moveq #255,d0
 bra.s L18144
L1811a movea.w 4(sp),a0
 move.l a0,-(sp)
 moveq #0,d0
 move.b d4,d0
 move.l d0,d1
 move.l a3,d0
 bsr.w L1ab14
 addq.l #4,sp
L1812e addq.l #1,d7
 move.w 6(a2),d0
 ext.l d0
 adda.l d0,a3
L18138 move.w 6(sp),d0
 ext.l d0
 cmp.l d7,d0
 bgt.s L180f6
L18142 moveq #0,d0
L18144 lea 12(sp),sp
 movem.l -28(a5),a0/a2-a3/d4-d7
 unlk a5
 rts 
L18152 link.w a5,#0
 movem.l a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l a2,d0
 beq.s L1818c
 move.l a3,d0
 beq.s L1818c
 moveq #15,d0
 and.w (a2),d0
 ext.l d0
 move.l d0,d4
 moveq #6,d0
 cmp.l d4,d0
 beq.s L1818c
 moveq #7,d0
 cmp.l d4,d0
 beq.s L1818c
 move.w (a2),d0
 ext.l d0
 andi.l #$00000100,d0
 cmpi.l #256,d0
 bne.s L1819a
L1818c move.l #10753,D0000c(a6)
 moveq #255,d0
 bra.w L18256
L1819a tst.w (a3)
 bge.s L181a0
 clr.w (a3)
L181a0 tst.w 2(a3)
 bge.s L181aa
 clr.w 2(a3)
L181aa move.w (a3),d0
 cmp.w 2(a2),d0
 bge.s L181bc
 move.w 2(a3),d0
 cmp.w 4(a2),d0
 blt.s L181c2
L181bc moveq #1,d0
 bra.w L18256
L181c2 tst.w 4(a3)
 beq.s L181de
 move.w (a3),d0
 ext.l d0
 move.w 4(a3),d1
 ext.l d1
 add.l d1,d0
 move.w 2(a2),d1
 ext.l d1
 cmp.l d1,d0
 ble.s L181e8
L181de move.w 2(a2),d0
 sub.w (a3),d0
 move.w d0,4(a3)
L181e8 tst.w 6(a3)
 beq.s L18206
 move.w 2(a3),d0
 ext.l d0
 move.w 6(a3),d1
 ext.l d1
 add.l d1,d0
 move.w 4(a2),d1
 ext.l d1
 cmp.l d1,d0
 ble.s L18212
L18206 move.w 4(a2),d0
 sub.w 2(a3),d0
 move.w d0,6(a3)
L18212 moveq #48,d0
 and.w (a2),d0
 cmpi.w #16,d0
 beq.s L18230
 move.w (a3),d0
 asr.w #1,d0
 move.w d0,(a3)
 move.w 4(a3),d0
 ext.l d0
 addq.l #1,d0
 asr.l #1,d0
 move.w d0,4(a3)
L18230 move.w #192,d0
 and.w (a2),d0
 cmpi.w #64,d0
 beq.s L18254
 move.w 2(a3),d0
 asr.w #1,d0
 move.w d0,2(a3)
 move.w 6(a3),d0
 ext.l d0
 addq.l #1,d0
 asr.l #1,d0
 move.w d0,6(a3)
L18254 moveq #0,d0
L18256 movem.l -12(a5),a2-a3/d4
 unlk a5
 rts 
 link.w a5,#0
 movem.l a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l a2,d0
 bne.s L1827a
 move.l #12290,D0000c(a6)
 bra.s L182b4
L1827a clr.l -(sp)
 move.l 14(a2),d1
 move.l (a2),d0
 bsr.w L1cec8
 addq.l #4,sp
 moveq #255,d1
 cmp.l d0,d1
 beq.s L182ac
 move.l 28(sp),-(sp)
 move.l a3,d1
 move.l (a2),d0
 bsr.w L1ce98
 addq.l #4,sp
 move.l d0,d4
 moveq #255,d1
 cmp.l d0,d1
 beq.s L182ac
 add.l d4,14(a2)
 move.l d4,d0
 bra.s L182b6
L182ac move.l #12291,D0000c(a6)
L182b4 moveq #255,d0
L182b6 movem.l -12(a5),a2-a3/d4
 unlk a5
 rts 
 link.w a5,#0
 movem.l a2/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l a2,d0
 bne.s L182da
 move.l #12290,D0000c(a6)
 bra.s L182f4
L182da tst.l d4
 ble.s L182ec
 moveq #0,d0
 move.w 12(a2),d0
 add.l d4,d0
 move.l d0,14(a2)
 bra.s L182f6
L182ec move.l #12291,D0000c(a6)
L182f4 moveq #255,d0
L182f6 movem.l -8(a5),a2/d4
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1/d4,-(sp)
 tst.l (sp)
 bne.s L18316
 move.l #12290,D0000c(a6)
 bra.s L1835a
L18316 clr.l -(sp)
 movea.l 4(sp),a0
 move.l 14(a0),d1
 movea.l 4(sp),a0
 move.l (a0),d0
 bsr.w L1cec8
 addq.l #4,sp
 moveq #255,d1
 cmp.l d0,d1
 beq.s L18352
 move.l 24(sp),-(sp)
 move.l 8(sp),d1
 movea.l 4(sp),a0
 move.l (a0),d0
 bsr.w L1ce5e
 addq.l #4,sp
 move.l d0,d4
 movea.l (sp),a0
 add.l d4,14(a0)
 move.l d4,d0
 bra.s L1835c
L18352 move.l #12291,D0000c(a6)
L1835a moveq #255,d0
L1835c movem.l -8(a5),a0/d4
 unlk a5
 rts 
L18366 link.w a5,#0
 movem.l a0/a2-a4/d0-d2/d4,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 movea.l 44(sp),a4
 lea -32(sp),sp
 move.l a2,d0
 bsr.w L18582
 tst.l d0
 beq.s L18398
 moveq #3,d1
 move.l a2,d0
 bsr.w L1cd64
 move.l d0,d4
 moveq #255,d1
 cmp.l d0,d1
 beq.w L18440
 bra.s L183a4
L18398 move.l #12293,D0000c(a6)
 bra.w L18440
L183a4 move.l a4,d0
 beq.w L1843a
 move.l d4,(a4)
 move.w 74(sp),4(a4)
 pea (L00008).w
 move.l a4,d0
 addq.l #6,d0
 move.l d0,d1
 move.l d4,d0
 bsr.w L1ce5e
 addq.l #4,sp
 moveq #255,d1
 cmp.l d0,d1
 beq.s L1843a
 lea L1849c(pc),a0
 move.l a0,d1
 move.l a3,d0
 bsr.w L1bd94
 tst.l d0
 beq.s L18410
 lea (sp),a0
 move.l a0,d1
 move.l a4,d0
 bsr.w L18952
 moveq #255,d1
 cmp.l d0,d1
 beq.s L183f8
 lea (sp),a0
 move.l a0,d1
 move.l a3,d0
 bsr.w L1bd94
 tst.l d0
 beq.s L18410
L183f8 move.l #12289,D0000c(a6)
 move.l d4,d0
 bsr.w L1cd7a
 move.l a4,d1
 moveq #18,d0
 bsr.w L1aa7a
 bra.s L18440
L18410 move.l a4,d0
 bsr.w L185d2
 andi.l #$00003fff,d0
 move.w #16383,d1
 and.w 6(a4),d1
 moveq #0,d2
 move.w d1,d2
 cmp.l d2,d0
 bne.s L1843a
 moveq #0,d0
 move.w 12(a4),d0
 move.l d0,14(a4)
 move.l a4,d0
 bra.s L18442
L1843a move.l d4,d0
 bsr.w L1cd7a
L18440 moveq #0,d0
L18442 lea 32(sp),sp
 movem.l -24(a5),a0/a2-a4/d2/d4
 unlk a5
 rts 
 link.w a5,#0
 movem.l a2-a4/d0-d1,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l 28(sp),d1
 moveq #18,d0
 bsr.w L1aa4e
 movea.l d0,a4
 tst.l d0
 beq.s L18490
 pea (a4)
 move.l 32(sp),-(sp)
 move.l a3,d1
 move.l a2,d0
 bsr.w L18366
 addq.l #8,sp
 movea.l d0,a4
 tst.l d0
 bne.s L1848c
 move.l a4,d1
 moveq #18,d0
 bsr.w L1aa7a
 bra.s L18490
L1848c move.l a4,d0
 bra.s L18492
L18490 moveq #0,d0
L18492 movem.l -12(a5),a2-a4
 unlk a5
 rts 
L1849c dc.w $414c
 dc.w $4c00
L184a0 link.w a5,#0
 movem.l a2/d0-d1,-(sp)
 movea.l d0,a2
 move.l a2,d0
 bne.s L184b8
 move.l #12290,D0000c(a6)
 bra.s L18506
L184b8 move.w #-16384,d0
 and.w 6(a2),d0
 move.w d0,d1
 move.l a2,d0
 bsr.w L185d2
 andi.w #$3fff,d0
 or.w d0,d1
 move.w d1,6(a2)
 clr.l -(sp)
 moveq #0,d1
 move.l (a2),d0
 bsr.w L1cec8
 addq.l #4,sp
 moveq #255,d1
 cmp.l d0,d1
 beq.s L18506
 pea (L00002).w
 move.l a2,d0
 addq.l #6,d0
 move.l d0,d1
 move.l (a2),d0
 bsr.w L1ce98
 addq.l #4,sp
 move.l (a2),d0
 bsr.w L1cd7a
 moveq #255,d1
 cmp.l d0,d1
 beq.s L18506
 moveq #0,d0
 bra.s L18508
L18506 moveq #255,d0
L18508 movem.l -8(a5),a2/d1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a2/d0-d1,-(sp)
 movea.l d0,a2
 move.l a2,d0
 bsr.w L184a0
 tst.l d0
 bne.s L18532
 move.l a2,d1
 moveq #18,d0
 bsr.w L1aa7a
 moveq #0,d0
 bra.s L18534
L18532 moveq #255,d0
L18534 movem.l -8(a5),a2/d1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1/d4-d5,-(sp)
 move.l #128,d1
 lea L1857c(pc),a0
 move.l a0,d0
 bsr.w L1cd64
 move.l d0,d4
 moveq #255,d1
 cmp.l d0,d1
 bne.s L18562
 moveq #255,d0
 bra.s L18572
L18562 move.l d4,d0
 bsr.w L1b628
 move.l d0,d5
 move.l d4,d0
 bsr.w L1cd7a
 move.l d5,d0
L18572 movem.l -16(a5),a0/d1/d4-d5
 unlk a5
 rts 
L1857c move.l _0f672(a6),0(sp)
L18582 link.w a5,#0
 movem.l a2/d0,-(sp)
 subq.l #4,sp
 move.l 4(sp),d0
 bsr.w L1be08
 move.l d0,(sp)
 move.l (sp),d0
 subq.l #4,d0
 add.l 4(sp),d0
 movea.l d0,a2
 cmpi.b #110,(a2)+
 bne.s L185bc
 cmpi.b #118,(a2)+
 bne.s L185bc
 cmpi.b #114,(a2)+
 bne.s L185bc
 cmpi.b #105,(a2)
 bne.s L185bc
 moveq #1,d0
 bra.s L185c6
L185bc move.l #12288,D0000c(a6)
 moveq #0,d0
L185c6 addq.l #4,sp
 movem.l -4(a5),a2
 unlk a5
 rts 
L185d2 link.w a5,#0
 movem.l a0/a2/d0-d1/d4,-(sp)
 movea.l d0,a2
 subq.l #2,sp
 moveq #0,d4
 clr.l -(sp)
 moveq #0,d0
 move.w 8(a2),d0
 move.l d0,d1
 move.l (a2),d0
 bsr.w L1cec8
 addq.l #4,sp
 bra.s L185fc
L185f4 moveq #0,d0
 move.b 1(sp),d0
 add.l d0,d4
L185fc pea (L00001).w
 lea 5(sp),a0
 move.l a0,d1
 move.l (a2),d0
 bsr.w L1ce5e
 addq.l #4,sp
 tst.l d0
 bne.s L185f4
 move.l d4,d0
 addq.l #2,sp
 movem.l -16(a5),a0/a2/d1/d4
 unlk a5
 rts 
L18620 link.w a5,#0
 movem.l a0/a2-a4/d0-d1,-(sp)
 lea -26(sp),sp
 lea 8(sp),a2
 lea 3(sp),a3
 movea.l 62(sp),a4
 move.l 26(sp),(a2)
 movea.l 62(sp),a0
 move.l 58(sp),6(a0)
 pea (L00008).w
 lea 4(sp),a0
 move.l a0,d1
 move.l 30(sp),d0
 bsr.w L1cc0c
 addq.l #4,sp
 move.b (a3)+,(a4)+
 move.b (a3)+,(a4)+
 move.b (a3)+,(a4)+
 move.b (a3)+,(a4)+
 move.b (a3),(a4)
 move.b (sp),d0
 ext.w d0
 btst.l #7,d0
 beq.s L18678
 movea.l 62(sp),a0
 clr.b 10(a0)
 bra.s L1868a
L18678 move.l 30(sp),d0
 addq.l #8,d0
 move.l d0,d1
 moveq #10,d0
 add.l 62(sp),d0
 bsr.w L1be26
L1868a pea (L00006).w
 lea L188a8(pc),a0
 move.l a0,d1
 move.l 34(sp),d0
 addq.l #8,d0
 bsr.w L1cf6a
 addq.l #4,sp
 tst.l d0
 bne.w L18732
 movea.l 62(sp),a0
 move.b #2,5(a0)
 clr.l -(sp)
 moveq #0,d1
 move.l 30(sp),d0
 bsr.w L1cec8
 addq.l #4,sp
 pea (L00008).w
 move.l a2,d0
 addq.l #6,d0
 move.l d0,d1
 move.l 30(sp),d0
 bsr.w L1ce5e
 addq.l #4,sp
 moveq #255,d1
 cmp.l d0,d1
 beq.s L18724
 btst.b #7,6(a2)
 beq.s L186ea
 movea.l 62(sp),a0
 bset.b #7,5(a0)
L186ea btst.b #6,6(a2)
 beq.s L186fc
 movea.l 62(sp),a0
 bset.b #6,5(a0)
L186fc moveq #42,d0
 add.l 62(sp),d0
 move.l d0,d1
 move.l a2,d0
 bsr.w L18952
 moveq #255,d1
 cmp.l d0,d1
 beq.s L18724
 moveq #74,d0
 add.l 62(sp),d0
 move.l d0,d1
 move.l a2,d0
 bsr.w L188ba
 moveq #255,d1
 cmp.l d0,d1
 bne.s L1874c
L18724 movea.l 62(sp),a0
 move.b #1,5(a0)
 moveq #255,d0
 bra.s L1874e
L18732 movea.l 62(sp),a0
 moveq #0,d0
 move.b d0,5(a0)
 movea.l 62(sp),a0
 move.b d0,74(a0)
 movea.l 62(sp),a0
 move.b d0,42(a0)
L1874c moveq #0,d0
L1874e lea 26(sp),sp
 movem.l -16(a5),a0/a2-a4
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4-d5,-(sp)
 movea.l 36(sp),a2
 lea -76(sp),sp
 bra.s L18780
L1876e moveq #22,d5
 bra.s L1879c
L18772 move.l 80(sp),d0
 bsr.w L1be08
 move.l d0,(sp)
 moveq #0,d5
 bra.s L1879c
L18780 move.l 76(sp),d0
 cmpi.l #255,d0
 bhi.s L1879c
 tst.b d0
 beq.s L1876e
 cmpi.b #1,d0
 beq.s L18772
 cmpi.b #2,d0
 beq.s L18772
L1879c lea L188af(pc),a0
 move.l a0,d0
 bsr.w L1bac6
 move.l d0,72(sp)
 beq.w L18896
 bra.w L1887e
L187b2 move.l (sp),-(sp)
 move.l 84(sp),d1
 move.l a3,d0
 addq.l #8,d0
 bsr.w L1cf6a
 addq.l #4,sp
 tst.l d0
 bne.w L1887e
 addq.l #1,d5
 bra.w L1887e
L187ce lea L188b4(pc),a0
 move.l a0,d1
 lea 8(sp),a0
 move.l a0,d0
 bsr.w L1be26
 move.l a3,d0
 addq.l #8,d0
 move.l d0,d1
 lea 8(sp),a0
 move.l a0,d0
 bsr.w L1be42
 moveq #1,d1
 lea 8(sp),a0
 move.l a0,d0
 bsr.w L1cd64
 move.l d0,4(sp)
 moveq #255,d1
 cmp.l d0,d1
 beq.w L1887e
 move.l 4(sp),d0
 bsr.w L1cc30
 move.l d0,d4
 moveq #255,d1
 cmp.l d0,d1
 beq.s L18852
 tst.l 76(sp)
 bne.s L18828
 move.l #256,d0
 add.l d4,d0
 add.l d0,d5
 bra.s L18852
L18828 move.l (sp),-(sp)
 move.l 84(sp),d1
 move.l a3,d0
 addq.l #8,d0
 bsr.w L1cf6a
 addq.l #4,sp
 tst.l d0
 bne.s L18852
 pea (a2)
 adda.l #114,a2
 move.l d4,-(sp)
 move.l a3,d1
 move.l 12(sp),d0
 bsr.w L18620
 addq.l #8,sp
L18852 move.l 4(sp),d0
 bsr.w L1cd7a
 bra.s L1887e
L1885c move.l 76(sp),d0
 cmpi.l #255,d0
 bhi.s L1887e
 tst.b d0
 beq.w L187ce
 cmpi.b #1,d0
 beq.w L187b2
 cmpi.b #2,d0
 beq.w L187ce
L1887e move.l 72(sp),d0
 bsr.w L1bb2c
 movea.l d0,a3
 tst.l d0
 bne.s L1885c
 move.l 72(sp),d0
 bsr.w L1bcb0
 bra.s L18898
L18896 moveq #255,d5
L18898 move.l d5,d0
 lea 76(sp),sp
 movem.l -20(a5),a0/a2-a3/d4-d5
 unlk a5
 rts 
L188a8 move.l _0ee76(a6),d5
 moveq #105,d1
 dc.w $2f
L188af equ *-1
 bgt.s L18928
 moveq #0,d1
L188b4 move.l _0f672(a6),12032(sp)
L188ba link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 lea -40(sp),sp
 move.l a2,d0
 bne.s L188d8
 move.l #12290,D0000c(a6)
 bra.s L18942
L188d8 clr.l -(sp)
 moveq #0,d0
 move.w 10(a2),d0
 move.l d0,d1
 move.l (a2),d0
 bsr.w L1cec8
 addq.l #4,sp
 moveq #255,d1
 cmp.l d0,d1
 beq.s L18940
 moveq #0,d0
 move.w 10(a2),d0
 moveq #0,d1
 move.w 12(a2),d1
 sub.l d0,d1
 move.l d1,d4
 beq.s L18940
 move.l d4,-(sp)
 lea 4(sp),a0
 move.l a0,d1
 move.l (a2),d0
 bsr.w L1ce5e
 addq.l #4,sp
 tst.l d0
 beq.s L18940
 lea (sp),a0
 clr.b (a0,d4.l)
 pea (L00004).w
 pea _0130a(a6)
 move.l d4,-(sp)
 move.l a3,d1
L18928 lea 12(sp),a0
 move.l a0,d0
 bsr.w L18b38
 lea 12(sp),sp
 move.l d0,d5
 clr.b (a3,d5.l)
 moveq #0,d0
 bra.s L18944
L18940 clr.b (a3)
L18942 moveq #255,d0
L18944 lea 40(sp),sp
 movem.l -20(a5),a0/a2-a3/d4-d5
 unlk a5
 rts 
L18952 link.w a5,#0
 movem.l a0/d0-d1/d4-d5,-(sp)
 lea -32(sp),sp
 tst.l 32(sp)
 bne.s L18970
 move.l #12290,D0000c(a6)
 bra.w L189f8
L18970 clr.l -(sp)
 movea.l 36(sp),a0
 moveq #0,d0
 move.w 8(a0),d0
 move.l d0,d1
 movea.l 36(sp),a0
 move.l (a0),d0
 bsr.w L1cec8
 addq.l #4,sp
 moveq #255,d1
 cmp.l d0,d1
 beq.s L189f2
 movea.l 32(sp),a0
 moveq #0,d0
 move.w 8(a0),d0
 movea.l 32(sp),a0
 moveq #0,d1
 move.w 10(a0),d1
 sub.l d0,d1
 move.l d1,d4
 beq.s L189f2
 move.l d4,-(sp)
 lea 4(sp),a0
 move.l a0,d1
 movea.l 36(sp),a0
 move.l (a0),d0
 bsr.w L1ce5e
 addq.l #4,sp
 tst.l d0
 beq.s L189f2
 lea (sp),a0
 clr.b (a0,d4.l)
 pea (L00004).w
 pea _0130a(a6)
 move.l d4,-(sp)
 move.l 48(sp),d1
 lea 12(sp),a0
 move.l a0,d0
 bsr.w L18b38
 lea 12(sp),sp
 move.l d0,d5
 movea.l 36(sp),a0
 clr.b (a0,d5.l)
 moveq #0,d0
 bra.s L189fa
L189f2 movea.l 36(sp),a0
 clr.b (a0)
L189f8 moveq #255,d0
L189fa lea 32(sp),sp
 movem.l -12(a5),a0/d4-d5
 unlk a5
 rts 
 movem.l a0-a2/d2-d7,-(sp)
 tst.l d0
 beq.s L18a20
 tst.l d1
 beq.s L18a20
 movea.l d0,a0
 movea.l d1,a1
 move.l d1,d2
 move.l 40(sp),d1
 bgt.s L18a26
L18a20 moveq #0,d0
 bra.w L18b2c
L18a26 move.l 48(sp),d6
 cmp.b #7,d6
 bgt.s L18a20
 moveq #255,d7
 moveq #8,d0
 sub.b d6,d0
 lsr.b d0,d7
 subq.b #1,d7
 movea.l 44(sp),a2
 moveq #0,d0
 moveq #8,d4
 clr.b (a1)
 bra.s L18a4c
L18a46 subq.b #1,d1
 beq.w L18b2c
L18a4c move.b (a0)+,d0
 moveq #2,d3
L18a50 cmp.b -2(a2,d3.w),d0
 beq.w L18ad8
 addq.b #1,d3
 cmp.b d7,d3
 blt.s L18a50
 btst.l #7,d0
 bne.s L18a6e
 btst.l #31,d0
 bne.w L18b04
 bra.s L18a72
L18a6e moveq #1,d3
 bra.s L18a74
L18a72 moveq #0,d3
L18a74 cmp.b d6,d4
 blt.s L18aa4
 sub.b d6,d4
 lsl.b d4,d3
 or.b d3,(a1)
 tst.b d4
 bne.s L18a88
 moveq #8,d4
 addq.w #1,a1
 clr.b (a1)
L18a88 cmp.b #8,d4
 bne.s L18abe
 move.b d0,(a1)+
L18a90 clr.b (a1)
L18a92 btst.b #7,-1(a0)
 bne.w L18a46
 bset.l #31,d0
 bra.w L18a46
L18aa4 move.b d6,d5
 swap d3
 move.b #255,d3
 sub.b d4,d5
 lsl.b d4,d3
 and.b d3,(a1)+
 swap d3
 moveq #8,d4
 sub.b d5,d4
 lsl.b d4,d3
 move.b d3,(a1)
 bra.s L18a88
L18abe move.b d0,d3
 moveq #8,d5
 sub.b d4,d5
 lsr.b d5,d0
 or.b d0,(a1)+
 clr.b (a1)
 lsl.b d4,d3
 move.b d3,(a1)
 tst.b d4
 bne.s L18a92
 moveq #8,d4
 addq.w #1,a1
 bra.s L18a90
L18ad8 bclr.l #31,d0
 cmp.b d6,d4
 blt.s L18aea
 sub.b d6,d4
 lsl.b d4,d3
 or.b d3,(a1)
 tst.b d4
 bra.s L18b1e
L18aea move.b d6,d5
 move.b d3,d0
 sub.b d4,d5
 lsr.b d5,d3
 or.b d3,(a1)+
 clr.b (a1)
 moveq #8,d5
 sub.b d6,d5
 add.b d5,d4
 lsl.b d4,d0
 move.b d0,(a1)
 bra.w L18a46
L18b04 move.b d0,d3
 move.b d4,d5
 subq.b #1,d5
 bset.b d5,-1(a1)
 moveq #8,d5
 sub.b d4,d5
 lsr.b d5,d0
 or.b d0,(a1)+
 clr.b (a1)
 lsl.b d4,d3
 move.b d3,(a1)
 tst.b d4
L18b1e bne.w L18a46
 moveq #8,d4
 addq.w #1,a1
 clr.b (a1)
 bra.w L18a46
L18b2c suba.l d2,a1
 move.l a1,d0
 addq.w #1,d0
 movem.l (sp)+,a0-a2/d2-d7
 rts 
L18b38 movem.l a0-a2/d2-d7,-(sp)
 tst.l d0
 beq.s L18b50
 tst.l d1
 beq.s L18b50
 movea.l d0,a0
 movea.l d1,a1
 move.l d1,d2
 move.l 40(sp),d1
 bgt.s L18b56
L18b50 moveq #0,d0
 bra.w L18c82
L18b56 move.l 48(sp),d6
 cmp.b #7,d6
 bgt.w L18a20
 moveq #255,d7
 moveq #8,d0
 sub.b d6,d0
 lsr.b d0,d7
 movea.l 44(sp),a2
 moveq #0,d0
 moveq #8,d4
L18b72 tst.b d4
 bne.s L18b80
 subq.b #1,d1
 beq.w L18c82
 addq.w #1,a0
 moveq #8,d4
L18b80 bclr.l #30,d0
 move.b (a0),d0
 move.b d6,d5
 cmp.b d5,d4
 blt.s L18bb2
 sub.b d5,d4
 lsr.b d4,d0
 and.b d7,d0
 btst.l #31,d0
 bne.s L18be6
 tst.b d0
 beq.w L18c44
 cmp.b #1,d0
 bra.s L18bdc
L18ba4 bclr.l #31,d0
 and.b d7,d0
 move.b -2(a2,d0.w),d0
 move.b d0,(a1)+
 bra.s L18b72
L18bb2 move.b d6,d5
 sub.b d4,d5
 lsl.b d5,d0
 subq.b #1,d1
 beq.w L18c82
 addq.w #1,a0
 move.b (a0),d3
 moveq #8,d4
 sub.b d5,d4
 lsr.b d4,d3
 or.b d3,d0
 and.b d7,d0
 btst.l #31,d0
 bne.s L18be6
 tst.b d0
 beq.w L18c44
 cmp.b #1,d0
L18bdc bne.s L18ba4
 bset.l #30,d0
 bra.w L18c44
L18be6 moveq #8,d5
 sub.b d6,d5
 lsl.b d5,d0
 cmp.b d4,d5
 blt.s L18c16
 moveq #8,d5
 move.b #255,d3
 sub.b d4,d5
 lsr.b d5,d3
 and.b (a0)+,d3
 subq.b #1,d1
 beq.w L18c82
 moveq #8,d5
 sub.b d6,d5
 sub.b d4,d5
 lsl.b d5,d3
 or.b d3,d0
 moveq #8,d4
 move.b (a0),d3
 sub.b d5,d4
 lsr.b d4,d3
 bra.s L18c3a
L18c16 move.b (a0),d3
 sub.b d5,d4
 bne.s L18c28
 subq.b #1,d1
 beq.w L18c82
 addq.w #1,a0
 moveq #8,d4
 sub.b d5,d4
L18c28 lsr.b d4,d3
 swap d7
 move.b #8,d7
 sub.b d5,d7
 moveq #255,d5
 lsr.b d7,d5
 and.b d5,d3
 swap d7
L18c3a or.b d3,d0
 bclr.b #7,-1(a1)
 bra.s L18c4e
L18c44 move.b (a0),d0
 moveq #8,d5
 cmp.b d4,d5
 bne.s L18c62
 addq.w #1,a0
L18c4e btst.l #7,d0
 beq.s L18c78
 bset.l #31,d0
 bclr.l #7,d0
 move.b d0,(a1)+
 bra.w L18b72
L18c62 sub.b d4,d5
 lsl.b d5,d0
 subq.b #1,d1
 beq.s L18c82
 addq.w #1,a0
 move.b (a0),d3
 lsr.b d4,d3
 or.b d3,d0
 btst.l #30,d0
 beq.s L18c4e
L18c78 move.b d0,(a1)+
 bclr.l #31,d0
 bra.w L18b72
L18c82 move.l a1,d0
 sub.l d2,d0
 movem.l (sp)+,a0-a2/d2-d7
 rts 
L18c8c link.w a5,#0
 movem.l a2-a3/d0-d6,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l 44(sp),d5
 move.l 48(sp),d6
 move.l a2,d0
 beq.s L18caa
 moveq #1,d0
 cmp.l d5,d0
 ble.s L18cb4
L18caa move.l #10753,D0000c(a6)
 bra.s L18cda
L18cb4 move.l d4,d1
 move.l d1,d2
 move.l d5,d0
 moveq #30,d1
 bsr.w L1ca40
 move.l d0,d3
 move.l d6,d0
 moveq #24,d1
 bsr.w L1ca40
 add.l d0,d3
 move.l d3,d0
 move.l d2,d1
 bsr.w L1aa4e
 movea.l d0,a3
 tst.l d0
 bne.s L18cde
L18cda moveq #255,d0
 bra.s L18cec
L18cde pea (a3)
 move.l d6,-(sp)
 move.l d5,d1
 move.l a2,d0
 bsr.w L18cf6
 addq.l #8,sp
L18cec movem.l -28(a5),a2-a3/d2-d6
 unlk a5
 rts 
L18cf6 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d6,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l 44(sp),d5
 move.l a2,d0
 beq.s L18d10
 moveq #1,d0
 cmp.l d4,d0
 ble.s L18d1c
L18d10 move.l #10753,D0000c(a6)
 bra.w L18e32
L18d1c tst.l 62(a2)
 beq.s L18d2e
 move.l #14085,D0000c(a6)
 bra.w L18e32
L18d2e move.l 48(sp),62(a2)
 move.l d4,d0
 moveq #30,d1
 bsr.w L1ca40
 add.l 48(sp),d0
 move.l d0,70(a2)
 move.l d4,d0
 moveq #30,d1
 bsr.w L1ca40
 add.l 62(a2),d0
 moveq #30,d1
 sub.l d1,d0
 move.l d0,66(a2)
 movea.l 66(a2),a0
 clr.l 4(a0)
 movea.l 66(a2),a0
 clr.l 8(a0)
 moveq #1,d0
 cmp.l d4,d0
 bne.s L18d74
 clr.l 62(a2)
 bra.s L18da6
L18d74 movea.l 62(a2),a3
 bra.s L18d90
L18d7a moveq #30,d0
 add.l a3,d0
 move.l d0,4(a3)
 moveq #226,d0
 add.l a3,d0
 move.l d0,8(a3)
 adda.l #30,a3
L18d90 move.l d4,d0
 subq.l #1,d4
 moveq #1,d1
 cmp.l d0,d1
 blt.s L18d7a
 movea.l 62(a2),a0
 clr.l 8(a0)
 clr.l -26(a3)
L18da6 movea.l 70(a2),a4
 bra.s L18db8
L18dac moveq #24,d0
 add.l a4,d0
 move.l d0,(a4)
 adda.l #24,a4
L18db8 move.l d5,d0
 subq.l #1,d5
 moveq #1,d1
 cmp.l d0,d1
 blt.s L18dac
 clr.l (a4)
 lea L18ec4(pc),a0
 move.l a0,_01360(a6)
 lea L19238(pc),a0
 move.l a0,_01364(a6)
 lea L18e50(pc),a0
 move.l a0,_01368(a6)
 lea L192fa(pc),a0
 move.l a0,_0136c(a6)
 lea L19122(pc),a0
 move.l a0,_01370(a6)
 movea.l 66(a2),a3
 moveq #0,d0
 move.l d0,12(a3)
 move.w d0,18(a3)
 move.w d0,16(a3)
 clr.l (a3)
 move.w #800,26(a3)
 moveq #1,d0
 move.b d0,29(a3)
 move.b d0,28(a3)
 movea.l _013ae(a6),a0
 clr.w 18(a0)
 movea.l _013ae(a6),a0
 andi.w #$feff,(a0)
 move.l a2,d0
 bsr.w L19826
 moveq #255,d1
 cmp.l d0,d1
 bne.s L18e36
 moveq #255,d0
 move.l d0,D0000c(a6)
L18e32 moveq #255,d0
 bra.s L18e46
L18e36 move.l _013ae(a6),d0
 bsr.w L19358
 move.l a2,d0
 bsr.w L19554
 moveq #0,d0
L18e46 movem.l -28(a5),a0/a2-a4/d4-d6
 unlk a5
 rts 
L18e50 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 movea.l 36(sp),a4
 move.l 40(sp),d4
 move.l a3,d0
 beq.s L18e7e
 movea.l _013ae(a6),a0
 tst.l 24(a0)
 beq.s L18e7e
 move.l #14084,D0000c(a6)
 moveq #255,d0
 bra.s L18eba
L18e7e movea.l _013ae(a6),a0
 clr.l 24(a0)
 moveq #1,d0
 and.w d4,d0
 movea.l _013ae(a6),a0
 or.w d0,(a0)
 movea.l _013ae(a6),a0
 move.l a4,28(a0)
 movea.l _013ae(a6),a0
 move.l a3,24(a0)
 move.l a3,d0
 beq.s L18eb8
 movea.l _013ae(a6),a0
 tst.l 10(a0)
 bne.s L18eb8
 movea.l _013ae(a6),a0
 move.l 66(a2),10(a0)
L18eb8 moveq #0,d0
L18eba movem.l -20(a5),a0/a2-a4/d4
 unlk a5
 rts 
L18ec4 link.w a5,#0
 movem.l a0-a4/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l a2,d0
 bne.s L18ede
 move.l #10753,D0000c(a6)
 bra.w L18f6c
L18ede tst.l 62(a2)
 bne.s L18ef6
 tst.l 66(a2)
 bne.s L18ef6
 move.l #14083,D0000c(a6)
 bra.w L18f6c
L18ef6 movea.l _013ae(a6),a0
 cmpa.l 20(a0),a2
 bne.s L18f26
 movea.l _013ae(a6),a0
 move.w (a0),d0
 ext.l d0
 btst.l #8,d0
 bne.s L18f1c
 movea.l _013ae(a6),a0
 move.w (a0),d0
 ext.l d0
 btst.l #15,d0
 beq.s L18f26
L18f1c move.l #14084,D0000c(a6)
 bra.s L18f6c
L18f26 movea.l _013ae(a6),a0
 bset.b #0,(a0)
 bset.b #0,7(sp)
 move.w 60(a2),d0
 ext.l d0
 cmp.l 4(sp),d0
 ble.s L18f4c
 move.w 58(a2),d0
 ext.l d0
 cmp.l 4(sp),d0
 ble.s L18f56
L18f4c move.l #14082,D0000c(a6)
 bra.s L18f64
L18f56 move.l 70(a2),d4
 bne.s L18f72
 move.l #14081,D0000c(a6)
L18f64 movea.l _013ae(a6),a0
 andi.w #$feff,(a0)
L18f6c moveq #0,d0
 bra.w L19118
L18f72 movea.l d4,a0
 move.w 46(sp),16(a0)
 movea.l d4,a0
 movea.l d4,a1
 move.w 16(a0),18(a1)
 movea.l d4,a0
 move.w 50(sp),20(a0)
 movea.l d4,a0
 move.l 52(sp),8(a0)
 movea.l d4,a0
 move.l 56(sp),12(a0)
 movea.l d4,a0
 move.w 62(sp),22(a0)
 movea.l 66(a2),a3
 bra.s L18fae
L18faa movea.l 4(a3),a3
L18fae move.w 26(a3),d0
 ext.l d0
 cmp.l 4(sp),d0
 bge.s L18fc0
 tst.l 4(a3)
 bne.s L18faa
L18fc0 move.w 26(a3),d0
 ext.l d0
 cmp.l 4(sp),d0
 bne.s L18fe6
 movea.l d4,a0
 move.l (a0),70(a2)
 movea.l d4,a0
 move.l (a3),(a0)
 movea.l d4,a0
 move.l a3,4(a0)
 move.l d4,(a3)
 addq.b #1,28(a3)
 bra.w L190fe
L18fe6 lea -14(sp),sp
 move.l 18(sp),-(sp)
 move.l 58(sp),-(sp)
 lea 8(sp),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L19440
 addq.l #8,sp
 moveq #255,d1
 cmp.l d0,d1
 beq.w L190da
 movea.l 62(a2),a4
 move.l a4,d0
 bne.s L1901c
 move.l #14080,D0000c(a6)
 bra.w L190da
L1901c tst.l 4(a4)
 beq.s L1902a
 movea.l 4(a4),a0
 clr.l 8(a0)
L1902a move.l 4(a4),62(a2)
 movea.l d4,a0
 move.l (a0),70(a2)
 movea.l d4,a0
 move.l (a3),(a0)
 tst.l 8(a3)
 bne.s L19046
 move.l a4,66(a2)
 bra.s L1904e
L19046 movea.l 8(a3),a0
 move.l a4,4(a0)
L1904e move.l 8(a3),8(a4)
 move.l a3,4(a4)
 move.l a4,8(a3)
 clr.b 29(a4)
 move.w 20(sp),26(a4)
 move.l (sp),12(a4)
 move.l 4(sp),16(a4)
 move.l 8(sp),20(a4)
 move.w 12(sp),24(a4)
 move.w 56(sp),20(a4)
 move.b #1,28(a4)
 movea.l d4,a0
 clr.l (a0)
 move.l d4,(a4)
 movea.l d4,a0
 move.l a4,4(a0)
 movea.l d4,a0
 clr.l (a0)
 movea.l _01354(a6),a0
 cmpa.l 4(a0),a2
 beq.s L190f2
 movea.l _013ae(a6),a0
 cmpa.l 20(a0),a2
 beq.s L190f2
 move.l #1610612736,-(sp)
 movea.w 10(sp),a0
 move.l a0,-(sp)
 movea.w 12(sp),a0
 move.l a0,-(sp)
 move.l 12(sp),d1
 move.l D006a6(a6),d0
 bsr.w L1b47a
 lea 12(sp),sp
 moveq #255,d1
 cmp.l d0,d1
 bne.s L190ea
 move.b #2,29(a4)
L190da movea.l _013ae(a6),a0
 andi.w #$feff,(a0)
 moveq #0,d0
 lea 14(sp),sp
 bra.s L19118
L190ea move.b #1,29(a4)
 bra.s L190fa
L190f2 movea.l _013ae(a6),a0
 addq.w #1,18(a0)
L190fa lea 14(sp),sp
L190fe movea.l _013ae(a6),a0
 andi.w #$feff,(a0)
 movea.l _01354(a6),a0
 cmpa.l 4(a0),a2
 bne.s L19116
 move.l a2,d0
 bsr.w L192fa
L19116 move.l d4,d0
L19118 movem.l -24(a5),a0-a4/d4
 unlk a5
 rts 
L19122 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 lea -14(sp),sp
 move.l a2,d0
 bne.s L19140
 move.l #10753,D0000c(a6)
 bra.w L191fe
L19140 movea.l _013ae(a6),a0
 cmpa.l 20(a0),a2
 bne.s L19152
 movea.l _013ae(a6),a0
 bset.b #0,(a0)
L19152 movea.l 66(a2),a3
 bra.w L19206
L1915a movea.w 26(a3),a0
 move.l a0,d4
 move.w 58(a2),d0
 ext.l d0
 cmp.l d4,d0
 ble.s L19172
 movea.w 58(a2),a0
 move.l a0,d4
 bra.s L19186
L19172 move.w 60(a2),d0
 ext.l d0
 cmp.l d4,d0
 bgt.s L19186
 move.w 60(a2),d0
 ext.l d0
 subq.l #1,d0
 move.l d0,d4
L19186 tst.l 4(a3)
 bne.s L19196
 move.w 60(a2),d0
 ext.l d0
 subq.l #1,d0
 move.l d0,d4
L19196 move.w d4,26(a3)
 move.l d4,-(sp)
 movea.w 20(a3),a0
 move.l a0,-(sp)
 lea 8(sp),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L19440
 addq.l #8,sp
 moveq #255,d1
 cmp.l d0,d1
 bne.s L191c0
 move.l #14086,D0000c(a6)
 bra.s L191fe
L191c0 move.l (sp),12(a3)
 move.l 4(sp),16(a3)
 move.l 8(sp),20(a3)
 move.w 12(sp),24(a3)
 move.l #1610612736,-(sp)
 movea.w 10(sp),a0
 move.l a0,-(sp)
 movea.w 12(sp),a0
 move.l a0,-(sp)
 move.l 12(sp),d1
 move.l D006a6(a6),d0
 bsr.w L1b47a
 lea 12(sp),sp
 moveq #255,d1
 cmp.l d0,d1
 bne.s L19202
L191fe moveq #255,d0
 bra.s L1922a
L19202 movea.l 4(a3),a3
L19206 move.l a3,d0
 bne.w L1915a
 movea.l _013ae(a6),a0
 tst.l 10(a0)
 bne.s L19220
 movea.l _013ae(a6),a0
 move.l 66(a2),10(a0)
L19220 movea.l _013ae(a6),a0
 andi.w #$feff,(a0)
 moveq #0,d0
L1922a lea 14(sp),sp
 movem.l -20(a5),a0/a2-a3/d1/d4
 unlk a5
 rts 
L19238 link.w a5,#0
 movem.l a0/a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l a2,d0
 beq.s L1924c
 move.l a3,d0
 bne.s L19258
L1924c move.l #10753,D0000c(a6)
 moveq #255,d0
 bra.s L192a4
L19258 movea.l _013ae(a6),a0
 move.w (a0),d0
 ext.l d0
 btst.l #9,d0
 beq.s L1926e
 move.w #1,20(a3)
 bra.s L192a2
L1926e movea.l _013ae(a6),a0
 bset.b #1,(a0)
 bsr.w L1a46e
 tst.l d0
 bne.s L19284
 moveq #1,d0
 bsr.w L1d64e
L19284 move.l a3,d1
 move.l a2,d0
 bsr.w L192ae
 movea.l _013ae(a6),a0
 andi.w #$fdff,(a0)
 bsr.w L1a46e
 tst.l d0
 bne.s L192a2
 moveq #0,d0
 bsr.w L1d64e
L192a2 moveq #0,d0
L192a4 movem.l -12(a5),a0/a2-a3
 unlk a5
 rts 
L192ae link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l 4(a3),d4
 movea.l d4,a4
 bra.s L192c4
L192c2 movea.l (a4),a4
L192c4 move.l a4,d0
 beq.s L192cc
 cmpa.l (a4),a3
 bne.s L192c2
L192cc move.l a4,d0
 bne.s L192d6
 addq.l #1,_01348(a6)
 bra.s L192f0
L192d6 move.l (a3),(a4)
 movea.l d4,a0
 subq.b #1,28(a0)
 bne.s L192e8
 movea.l d4,a0
 move.b #2,29(a0)
L192e8 move.l 70(a2),(a3)
 move.l a3,70(a2)
L192f0 movem.l -20(a5),a0/a2-a4/d4
 unlk a5
 rts 
L192fa link.w a5,#0
 movem.l a0-a2/d0,-(sp)
 movea.l d0,a2
 move.l a2,d0
 bne.s L19314
 move.l #10753,D0000c(a6)
 moveq #255,d0
 bra.s L1934e
L19314 movea.l _013ae(a6),a0
 tst.l 10(a0)
 bne.s L1934c
 tst.l 62(a2)
 bne.s L1932a
 tst.l 66(a2)
 beq.s L1934c
L1932a movea.l _013ae(a6),a0
 move.l a2,20(a0)
 movea.l _013ae(a6),a0
 movea.l 20(a0),a0
 movea.l _013ae(a6),a1
 move.l 66(a0),10(a1)
 movea.l _013ae(a6),a0
 andi.w #$feff,(a0)
L1934c moveq #0,d0
L1934e movem.l -12(a5),a0-a2
 unlk a5
 rts 
L19358 link.w a5,#0
 movem.l a0-a2/d0-d1/d4,-(sp)
 movea.l d0,a2
 lea L19430(pc),a0
 move.l a0,d0
 bsr.w L193e8
 moveq #255,d1
 cmp.l d0,d1
 beq.s L193ce
 movea.l _013ae(a6),a0
 andi.w #$bfff,(a0)
 lea L19520(pc),a0
 movea.l _013ae(a6),a1
 move.l a0,32(a1)
 move.l a2,d0
 bsr.w L19410
 clr.l -(sp)
 pea (L00100).w
 clr.l -(sp)
 move.l _00b6a(a6),-(sp)
 pea _0134c(a6)
 move.l _0134c(a6),d1
 lea L1d49a(pc),a0
 move.l a0,d0
 bsr.w L1b6bc
 lea 20(sp),sp
 move.l d0,d4
 moveq #1,d0
 bsr.w L1cf5a
 pea (L000ff).w
 moveq #2,d1
 move.l #2216,d0
 bsr.w L1d090
 addq.l #4,sp
 moveq #255,d0
 cmp.l d4,d0
 bne.s L193d2
L193ce moveq #255,d0
 bra.s L193de
L193d2 movea.l _013ae(a6),a0
 move.w d4,36(a0)
 move.w d4,d0
 ext.l d0
L193de movem.l -20(a5),a0-a2/d1/d4
 unlk a5
 rts 
L193e8 movem.l a0-a2,-(sp)
 movea.l d0,a0
 move.l #5,d0
 moveq #0,d1
 os9 F$TLink
 bcs.s L19404
 moveq #0,d0
L193fe movem.l (sp)+,a0-a2
 rts 
L19404 move.l d1,D0000c(a6)
 move.l #-1,d0
 bra.s L193fe
L19410 tcall #5,#0
 bcs.s L1941a
 moveq #0,d0
 rts 
L1941a move.l d1,D0000c(a6)
 move.l #-1,d0
 rts 
 bls.s L1948c
 dc.w $695f
 moveq #115,d3
 dc.w $796e
 bls.w L1f794
L19430 equ *-2
 dc.w $695f
 moveq #115,d3
 dc.w $796e
 dc.w $635f
 moveq #114,d2
 bsr.s L194ae
 dc.w $0
L19440 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d6,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 subq.l #8,sp
 move.l a2,d0
 beq.s L19456
 move.l a3,d0
 bne.s L19462
L19456 move.l #10753,D0000c(a6)
 bra.w L194fc
L19462 move.l 74(a2),(sp)
 bne.s L1947a
 move.l _01354(a6),(sp)
 bne.s L1947a
 move.l #14086,D0000c(a6)
 bra.w L194fc
L1947a move.l 56(sp),d1
 move.l (sp),d0
 bsr.w L1956a
 move.l d0,d6
 beq.w L194fc
 movea.l d6,a0
L1948c move.w 28(a0),d0
 ext.l d0
 move.l 56(sp),d1
 sub.l d0,d1
 move.l d1,d4
 tst.l 52(sp)
 bne.s L194ae
 movea.l d6,a0
 movea.l 12(a0),a4
 movea.l d6,a0
 move.w 34(a0),d0
 bra.s L194ba
L194ae movea.l d6,a0
 movea.l 16(a0),a4
 movea.l d6,a0
 move.w 36(a0),d0
L194ba ext.l d0
 add.l d0,d4
 clr.l 4(sp)
L194c2 pea (L00001).w
 pea (L00001).w
 move.l 64(sp),d1
 move.l a4,d0
 bsr.w L195d8
 addq.l #8,sp
 move.l d0,d5
 moveq #255,d1
 cmp.l d0,d1
 bne.s L194e6
 addq.l #2,56(sp)
 addq.l #1,4(sp)
L194e6 moveq #255,d0
 cmp.l d5,d0
 bne.s L194f4
 moveq #4,d0
 cmp.l 4(sp),d0
 bgt.s L194c2
L194f4 moveq #4,d0
 cmp.l 4(sp),d0
 bne.s L19500
L194fc moveq #255,d0
 bra.s L19514
L19500 tst.l 4(sp)
 move.w d5,6(a3)
 move.l (a4),(a3)
 move.w d4,4(a3)
 move.l a4,10(a3)
 moveq #0,d0
L19514 addq.l #8,sp
 movem.l -28(a5),a0/a2-a4/d4-d6
 unlk a5
 rts 
L19520 link.w a5,#0
 movem.l a0/a2/d0-d1,-(sp)
 movea.l d0,a2
 pea (L00001).w
 pea (L00001).w
 movea.w 6(a2),a0
 move.l a0,-(sp)
 movea.w 4(a2),a0
 move.l a0,d1
 move.l 10(a2),d0
 bsr.w L196b0
 lea 12(sp),sp
 movem.l -12(a5),a0/a2/d1
 unlk a5
 rts 
L19554 tcall #5,#8
 bcs.s L1955e
 moveq #0,d0
 rts 
L1955e move.l d1,D0000c(a6)
 move.l #-1,d0
 rts 
L1956a link.w a5,#0
 movem.l a2-a3/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l a2,d0
 bne.s L19584
 move.l #10753,D0000c(a6)
 bra.s L195cc
L19584 movea.l (a2),a3
 moveq #0,d5
 bra.s L195b2
L1958a move.w 28(a3),d0
 ext.l d0
 cmp.l d4,d0
 bgt.s L195aa
 move.w 28(a3),d0
 ext.l d0
 move.w 30(a3),d1
 ext.l d1
 add.l d1,d0
 cmp.l d4,d0
 ble.s L195aa
 move.l a3,d0
 bra.s L195ce
L195aa adda.l #38,a3
 addq.l #1,d5
L195b2 moveq #255,d0
 cmp.l 4(a3),d0
 beq.s L195c4
 move.w 80(a2),d0
 ext.l d0
 cmp.l d5,d0
 bgt.s L1958a
L195c4 move.l #11009,D0000c(a6)
L195cc moveq #0,d0
L195ce movem.l -16(a5),a2-a3/d4-d5
 unlk a5
 rts 
L195d8 link.w a5,#0
 movem.l a2-a3/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 move.l 44(sp),d4
 subq.l #4,sp
 move.l a2,d0
 bne.s L195f8
 move.l #10753,D0000c(a6)
 bra.w L1967a
L195f8 tst.b 6(a2)
 bne.s L1961a
 moveq #1,d0
 and.l 8(sp),d0
 add.l 44(sp),d0
 addq.l #1,d0
 asr.l #1,d0
 move.l d0,44(sp)
 move.l 8(sp),d0
 asr.l #1,d0
 move.l d0,8(sp)
L1961a moveq #0,d6
 move.l 16(a2),d0
 add.l 8(sp),d0
 movea.l d0,a3
 moveq #0,d5
 bra.s L19632
L1962a moveq #0,d0
 move.b (a3)+,d0
 or.l d0,d6
 addq.l #1,d5
L19632 cmp.l 44(sp),d5
 blt.s L1962a
 moveq #0,d7
 moveq #255,d0
 move.l d0,(sp)
 moveq #0,d5
 bra.s L19666
L19642 btst.l #0,d6
 bne.s L19654
 addq.l #1,d7
 moveq #255,d0
 cmp.l (sp),d0
 bne.s L1965a
 move.l d5,(sp)
 bra.s L1965a
L19654 moveq #0,d7
 moveq #255,d0
 move.l d0,(sp)
L1965a cmp.l d4,d7
 beq.s L1966c
 move.l d6,d0
 asr.l #1,d0
 move.l d0,d6
 addq.l #1,d5
L19666 moveq #8,d0
 cmp.l d5,d0
 bgt.s L19642
L1966c moveq #8,d0
 cmp.l d5,d0
 bne.s L1967e
 move.l #11061,D0000c(a6)
L1967a moveq #255,d0
 bra.s L196a4
L1967e move.l d4,d1
 move.l (sp),d0
 bsr.w L19768
 move.l d0,d6
 move.l 16(a2),d0
 add.l 8(sp),d0
 movea.l d0,a3
 moveq #0,d5
 bra.s L1969c
L19696 move.b d6,d0
 or.b d0,(a3)+
 addq.l #1,d5
L1969c cmp.l 44(sp),d5
 blt.s L19696
 move.l (sp),d0
L196a4 addq.l #4,sp
 movem.l -24(a5),a2-a3/d4-d7
 unlk a5
 rts 
L196b0 link.w a5,#0
 movem.l a2/d0-d1/d4-d6,-(sp)
 movea.l d0,a2
 move.l 32(sp),d5
 move.l 40(sp),d4
 move.l a2,d0
 bne.s L196d0
 move.l #10753,D0000c(a6)
 bra.s L196f2
L196d0 move.l d4,d1
 move.l d5,d0
 bsr.w L19768
 move.l d0,d6
 move.l d6,-(sp)
 move.l 40(sp),-(sp)
 move.l 12(sp),d1
 move.l a2,d0
 bsr.w L19702
 addq.l #8,sp
 moveq #255,d1
 cmp.l d0,d1
 bne.s L196f6
L196f2 moveq #255,d0
 bra.s L196f8
L196f6 moveq #0,d0
L196f8 movem.l -16(a5),a2/d4-d6
 unlk a5
 rts 
L19702 link.w a5,#0
 movem.l a2-a3/d0-d1/d4-d6,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l 36(sp),d5
 move.l 40(sp),d6
 move.l a2,d0
 bne.s L19726
 move.l #10753,D0000c(a6)
 moveq #255,d0
 bra.s L1975e
L19726 tst.b 6(a2)
 bne.s L1973a
 moveq #1,d0
 and.l d4,d0
 add.l d5,d0
 addq.l #1,d0
 asr.l #1,d0
 move.l d0,d5
 asr.l #1,d4
L1973a move.l 16(a2),d0
 add.l d4,d0
 movea.l d0,a3
 bra.s L19754
L19744 moveq #0,d0
 move.b (a3),d0
 and.l d6,d0
 cmp.l d6,d0
 move.b d6,d0
 eori.b #$ff,d0
 and.b d0,(a3)+
L19754 move.l d5,d0
 subq.l #1,d5
 tst.l d0
 bne.s L19744
 moveq #0,d0
L1975e movem.l -20(a5),a2-a3/d4-d6
 unlk a5
 rts 
L19768 swap d0
 move.b #8,d0
 sub.b d1,d0
 moveq #255,d1
 lsr.b d0,d1
 swap d0
 lsl.b d0,d1
 moveq #0,d0
 move.b d1,d0
 rts 
 link.w a5,#0
 movem.l a0/d0-d1/d4-d5,-(sp)
 subq.l #4,sp
 lea L197e2(pc),a0
 move.l a0,d0
 bsr.w L1d10c
 move.l d0,d4
 moveq #255,d1
 cmp.l d0,d1
 bne.s L1979e
 moveq #255,d0
 bra.s L197d6
L1979e movea.l _013ae(a6),a0
 bset.b #6,(a0)
 move.l #32768,-(sp)
 moveq #1,d1
 move.l d4,d0
 bsr.w L1d18e
 addq.l #4,sp
 lea (sp),a0
 move.l a0,d0
 bsr.w L1d448
 move.l d0,d5
 tst.l d5
 bge.s L197d4
 cmpi.l #226,D0000c(a6)
 bne.s L197d4
 clr.l D0000c(a6)
 clr.l (sp)
L197d4 move.l (sp),d0
L197d6 addq.l #4,sp
 movem.l -16(a5),a0/d1/d4-d5
 unlk a5
 rts 
L197e2 dc.w $6c69
 dc.w $6e65
 subq.w #7,-(a5)
 moveq #101,d3
 bgt.s L19860
 dc.w $0
 move.l a0,-(sp)
 movea.l d0,a0
 bra.s L197fa
L197f4 move.l a0,-(sp)
 movea.l _013ae(a6),a0
L197fa btst.b #7,(a0)
 beq.s L1980a
 move.l a1,2(a0)
 movea.l 6(a0),a1
 move.w (a1),d0
L1980a movea.l (sp)+,a0
 rts 
 move.l a0,-(sp)
 movea.l d0,a0
 bra.s L1981a
L19814 move.l a0,-(sp)
 movea.l _013ae(a6),a0
L1981a btst.b #7,(a0)
 movea.l 2(a0),a1
 movea.l (sp)+,a0
 rts 
L19826 movem.l d2,-(sp)
 movea.l d0,a0
 move.w 8(a0),d0
 move.w #81,d1
 move.w #16910,d2
 os9 I$SetStt
 bcs.s L19846
 clr.l d0
L19840 movem.l (sp)+,d2
 rts 
L19846 move.l d1,D0000c(a6)
 moveq #255,d0
 bra.s L19840
 link.w a5,#0
 movem.l a2/d0-d1,-(sp)
 movea.l d0,a2
 subq.l #4,sp
 clr.l (sp)
 tst.l 38(a2)
L19860 beq.s L19866
 moveq #16,d0
 move.l d0,(sp)
L19866 move.l a2,d0
 bsr.w L198ba
 moveq #255,d1
 cmp.l d0,d1
 bne.s L19876
 moveq #255,d0
 bra.s L19882
L19876 move.l a2,d1
 move.l (sp),d0
 bsr.w L19bb0
 bsr.w L1aa7a
L19882 addq.l #4,sp
 movem.l -8(a5),a2/d1
 unlk a5
 rts 
L1988e link.w a5,#0
 movem.l a2/d0-d2,-(sp)
 movea.l d0,a2
 move.l (a2),d1
 move.l d1,d2
 move.w 6(a2),d0
 ext.l d0
 addq.l #1,d0
 moveq #26,d1
 bsr.w L1ca40
 move.l d2,d1
 bsr.w L1aa7a
 movem.l -12(a5),a2/d1-d2
 unlk a5
 rts 
L198ba link.w a5,#0
 movem.l a2/d0,-(sp)
 movea.l d0,a2
 move.l a2,d0
 bne.s L198d2
 move.l #10753,D0000c(a6)
 bra.s L198e2
L198d2 btst.b #0,1(a2)
 beq.s L198e6
 move.l #13056,D0000c(a6)
L198e2 moveq #255,d0
 bra.s L19904
L198e6 clr.w (a2)
 moveq #0,d0
 move.l d0,18(a2)
 move.l d0,14(a2)
 tst.l 38(a2)
 beq.s L19902
 moveq #60,d0
 add.l 38(a2),d0
 bsr.s L1988e
 bra.s L19904
L19902 moveq #0,d0
L19904 movem.l -4(a5),a2
 unlk a5
 rts 
L1990e link.w a5,#0
 movem.l a2/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l 28(sp),d5
 move.l a2,d0
 bne.s L1992c
 move.l #10753,D0000c(a6)
 bra.s L19940
L1992c moveq #255,d0
 cmp.l d4,d0
 beq.s L19938
 moveq #255,d0
 cmp.l d5,d0
 bne.s L19944
L19938 move.l #13057,D0000c(a6)
L19940 moveq #255,d0
 bra.s L1994e
L19944 move.w d4,2(a2)
 move.w d5,4(a2)
 moveq #0,d0
L1994e movem.l -12(a5),a2/d4-d5
 unlk a5
 rts 
L19958 link.w a5,#0
 movem.l a2/d0-d1,-(sp)
 movea.l d0,a2
 move.l a2,d0
 bne.s L19970
 move.l #10753,D0000c(a6)
 bra.s L19992
L19970 tst.l 62(a2)
 bne.s L19982
 tst.l 66(a2)
 bne.s L19982
 tst.l 70(a2)
 beq.s L19988
L19982 move.l a2,d0
 bsr.w L19bd6
L19988 move.l a2,d0
 bsr.s L199ba
 moveq #255,d1
 cmp.l d0,d1
 bne.s L19996
L19992 moveq #255,d0
 bra.s L19998
L19996 moveq #0,d0
L19998 movem.l -8(a5),a2/d1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a2/d0,-(sp)
 movea.l d0,a2
 move.l a2,d0
 bsr.s L199e2
 movem.l -4(a5),a2
 unlk a5
 rts 
L199ba movem.l d2,-(sp)
 movea.l d0,a0
 move.w 8(a0),d0
 move.w #81,d1
 move.w #16904,d2
 os9 I$SetStt
 bcs.s L199da
 clr.l d0
L199d4 movem.l (sp)+,d2
 rts 
L199da move.l d1,D0000c(a6)
 moveq #255,d0
 bra.s L199d4
L199e2 movem.l d2,-(sp)
 movea.l d0,a0
 moveq #0,d0
 move.w 8(a0),d0
 move.w #81,d1
 move.w #16912,d2
 os9 I$SetStt
 movem.l (sp)+,d2
 rts 
L19a00 link.w a5,#0
 movem.l a2/d0-d1,-(sp)
 movea.l d0,a2
 move.l a2,d0
 bne.s L19a18
 move.l #10753,D0000c(a6)
 bra.s L19a22
L19a18 move.l a2,d0
 bsr.s L19a32
 moveq #255,d1
 cmp.l d0,d1
 bne.s L19a26
L19a22 moveq #255,d0
 bra.s L19a28
L19a26 moveq #0,d0
L19a28 movem.l -8(a5),a2/d1
 unlk a5
 rts 
L19a32 movem.l a0/d1,-(sp)
 movea.l d0,a0
 move.w 8(a0),d0
 move.w #81,d1
 move.w #16902,d2
 os9 I$SetStt
 bcs.s L19a52
 clr.l d0
L19a4c movem.l (sp)+,a0/d1
 rts 
L19a52 move.l d1,D0000c(a6)
 moveq #255,d0
 bra.s L19a4c
L19a5a link.w a5,#0
 movem.l a2/d0-d1/d4-d6,-(sp)
 move.l d0,d4
 move.l d1,d5
 move.l 32(sp),d6
 move.l d6,d1
 move.l d5,d0
 bsr.w L19bb0
 bsr.w L1aa4e
 movea.l d0,a2
 tst.l d0
 bne.s L19a80
 moveq #0,d0
 bra.s L19a8e
L19a80 pea (a2)
 move.l d6,-(sp)
 move.l d5,d1
 move.l d4,d0
 bsr.w L19b16
 addq.l #8,sp
L19a8e movem.l -16(a5),a2/d4-d6
 unlk a5
 rts 
L19a98 link.w a5,#0
 movem.l a2-a3/d0-d2/d4-d5,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l 36(sp),d5
 moveq #60,d0
 add.l a2,d0
 movea.l d0,a3
 move.w d4,6(a3)
 clr.w 4(a3)
 move.l d5,d1
 move.l d1,d2
 move.l d4,d0
 addq.l #1,d0
 moveq #26,d1
 bsr.w L1ca40
 move.l d2,d1
 bsr.w L1aa4e
 move.l d0,(a3)
 tst.l (a3)
 bne.s L19adc
 move.l #10989,D0000c(a6)
 moveq #0,d0
 bra.s L19ade
L19adc move.l (a3),d0
L19ade movem.l -20(a5),a2-a3/d2/d4-d5
 unlk a5
 rts 
 link.w a5,#0
 movem.l a2/d0,-(sp)
 movea.l d0,a2
 move.w 4(a2),d0
 addq.w #1,4(a2)
 cmp.w 6(a2),d0
 bne.s L19b04
 clr.w 4(a2)
L19b04 moveq #26,d0
 muls.w 4(a2),d0
 add.l (a2),d0
 movem.l -4(a5),a2
 unlk a5
 rts 
L19b16 link.w a5,#0
 movem.l a0-a3/d0-d1/d4-d6,-(sp)
 move.l d0,d4
 move.l d1,d5
 move.l 44(sp),d6
 movea.l 48(sp),a2
 move.l a2,d0
 bne.s L19b38
 move.l #10753,D0000c(a6)
 bra.s L19b98
L19b38 lea _013b2(a6),a0
 lea (a2),a1
 moveq #18,d0
L19b40 move.l (a0)+,(a1)+
 dbf d0,L19b40
 move.w (a0)+,(a1)+
 move.w d4,8(a2)
 bsr.s L19bac
 move.l d0,42(a2)
 lea _015b8(a6),a0
 move.l a0,46(a2)
 btst.l #4,d5
 beq.s L19ba0
 moveq #78,d0
 add.l a2,d0
 movea.l d0,a3
 move.l a3,38(a2)
 lea _0144e(a6),a0
 lea (a3),a1
 moveq #32,d0
L19b72 move.l (a0)+,(a1)+
 dbf d0,L19b72
 move.w (a0)+,(a1)+
 move.l a2,d0
 bsr.w L19ec2
 moveq #255,d1
 cmp.l d0,d1
 move.l d6,-(sp)
 movea.w _01596(a6),a0
 move.l a0,d1
 move.l a3,d0
 bsr.w L19a98
 addq.l #4,sp
 tst.l d0
 bne.s L19b9c
L19b98 moveq #0,d0
 bra.s L19ba2
L19b9c move.l d6,56(a3)
L19ba0 move.l a2,d0
L19ba2 movem.l -28(a5),a0-a3/d4-d6
 unlk a5
 rts 
L19bac move.l a6,d0
 rts 
L19bb0 link.w a5,#0
 movem.l d0/d4-d5,-(sp)
 move.l d0,d4
 btst.l #4,d4
 beq.s L19bc8
 move.l #212,d5
 bra.s L19bca
L19bc8 moveq #78,d5
L19bca move.l d5,d0
 movem.l -8(a5),d4-d5
 unlk a5
 rts 
L19bd6 tcall #5,#8
 bcs.s L19be0
 moveq #0,d0
 rts 
L19be0 move.l d1,D0000c(a6)
 move.l #-1,d0
 rts 
 link.w a5,#0
 movem.l a2-a3/d0,-(sp)
 movea.l d0,a2
 movea.l 38(a2),a3
 move.l a3,d0
 bne.s L19c0a
 move.l #10753,D0000c(a6)
 moveq #255,d0
 bra.s L19c10
L19c0a bset.b #7,(a3)
 moveq #0,d0
L19c10 movem.l -8(a5),a2-a3
 unlk a5
 rts 
L19c1a link.w a5,#0
 movem.l a0/a2-a3/d0,-(sp)
 movea.l d0,a2
 movea.l 38(a2),a3
 move.l a3,d0
 bne.s L19c38
 move.l #10753,D0000c(a6)
 moveq #255,d0
 bra.s L19c46
L19c38 bset.b #5,(a3)
 movea.w 8(a2),a0
 move.l a0,d0
 bsr.w L1b59e
L19c46 movem.l -12(a5),a0/a2-a3
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l 48(sp),d4
 move.l 52(sp),d5
 subq.l #4,sp
 movea.l 38(a2),a4
 movea.l 2(a3),a0
 move.l 2(a0),d6
 move.l 48(a4),d7
 move.l a4,d0
 beq.s L19c7e
 move.l a3,d0
 bne.s L19c88
L19c7e move.l #13320,D0000c(a6)
 bra.s L19c96
L19c88 move.l 60(sp),d1
 moveq #24,d0
 bsr.w L1aa4e
 move.l d0,(sp)
 bne.s L19c9a
L19c96 moveq #255,d0
 bra.s L19cd0
L19c9a movea.l (sp),a0
 clr.w (a0)
 movea.l (sp),a0
 move.l d4,4(a0)
 movea.l (sp),a0
 move.l d5,8(a0)
 movea.l (sp),a0
 move.l a3,12(a0)
 movea.l (sp),a0
 clr.l 16(a0)
 movea.l (sp),a0
 move.l d7,20(a0)
 bset.b #7,(a4)
 move.l (sp),48(a4)
 move.w #-1,6(a4)
 andi.b #$7f,(a4)
 moveq #0,d0
L19cd0 addq.l #4,sp
 movem.l -32(a5),a0/a2-a4/d4-d7
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l 40(sp),d4
 movea.l 38(a2),a4
 move.l 48(a4),d5
 move.l a4,d0
 beq.s L19cfc
 tst.l d5
 bne.s L19d06
L19cfc move.l #13320,D0000c(a6)
 bra.s L19d1a
L19d06 movea.l d5,a0
 cmpa.l 12(a0),a3
 beq.s L19d26
 move.l a3,d1
 move.l d5,d0
 bsr.w L19d5c
 move.l d0,d5
 bne.s L19d1e
L19d1a moveq #255,d0
 bra.s L19d52
L19d1e movea.l d5,a0
 move.l 20(a0),d5
 bra.s L19d2a
L19d26 move.l 48(a4),d5
L19d2a moveq #255,d0
 cmp.l d4,d0
 bne.s L19d38
 movea.l d5,a0
 bset.b #7,(a0)
 bra.s L19d50
L19d38 move.w #-1,6(a4)
 movea.l d5,a0
 clr.l 16(a0)
 movea.l d5,a0
 andi.w #$7fff,(a0)
 ori.b #$44,1(a4)
L19d50 moveq #0,d0
L19d52 movem.l -24(a5),a0/a2-a4/d4-d5
 unlk a5
 rts 
L19d5c link.w a5,#0
 movem.l a0/a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 bra.s L19d7e
L19d6a movea.l 20(a2),a2
 move.l a2,d0
 bne.s L19d7e
 move.l #13319,D0000c(a6)
 moveq #0,d0
 bra.s L19d8a
L19d7e movea.l 20(a2),a0
 cmpa.l 12(a0),a3
 bne.s L19d6a
 move.l a2,d0
L19d8a movem.l -12(a5),a0/a2-a3
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0-a4/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 movea.l 38(a2),a4
 move.l 48(a4),d4
 move.l a4,d0
 beq.s L19db0
 tst.l d4
 bne.s L19dba
L19db0 move.l #13320,D0000c(a6)
 bra.s L19dce
L19dba movea.l d4,a0
 cmpa.l 12(a0),a3
 beq.s L19de8
 move.l a3,d1
 move.l d4,d0
 bsr.w L19d5c
 move.l d0,d4
 bne.s L19dd2
L19dce moveq #255,d0
 bra.s L19e00
L19dd2 movea.l d4,a0
 move.l 20(a0),d5
 movea.l d4,a0
 movea.l 20(a0),a0
 movea.l d4,a1
 move.l 20(a0),20(a1)
 bra.s L19df2
L19de8 move.l d4,d5
 movea.l d4,a0
 move.l 20(a0),48(a4)
L19df2 move.w #-1,6(a4)
 move.l d5,d1
 moveq #24,d0
 bsr.w L1aa7a
L19e00 movem.l -28(a5),a0-a4/d4-d5
 unlk a5
 rts 
 link.w a5,#0
 movem.l a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 movea.l 38(a2),a3
 move.l 4(sp),72(a3)
 move.l 24(sp),76(a3)
 move.l 28(sp),80(a3)
 move.l 32(sp),d0
 moveq #10,d1
 bsr.w L1ca40
 move.l 68(a3),d1
 bsr.w L1ca78
 move.l d0,84(a3)
 bset.b #4,7(a3)
 btst.b #0,(a3)
 beq.s L19e50
 bset.b #4,(a3)
L19e50 moveq #0,d0
 movem.l -8(a5),a2-a3
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l 36(sp),d5
 subq.l #4,sp
 movea.l 38(a2),a3
 clr.l (sp)
 move.l a3,d0
 bne.s L19e84
 move.l #10753,D0000c(a6)
 moveq #255,d0
 bra.s L19eb6
L19e84 bset.b #7,(a3)
 move.l d5,-(sp)
 move.l d4,d1
 movea.w 8(a2),a0
 move.l a0,d0
 bsr.w L1b54e
 addq.l #4,sp
 moveq #255,d1
 cmp.l d0,d1
 beq.s L19eb0
 move.l d5,-(sp)
 move.l d4,d1
 movea.w 8(a2),a0
 move.l a0,d0
 bsr.w L1b586
 addq.l #4,sp
 move.l d0,(sp)
L19eb0 andi.b #$7f,(a3)
 move.l (sp),d0
L19eb6 addq.l #4,sp
 movem.l -20(a5),a0/a2-a3/d4-d5
 unlk a5
 rts 
L19ec2 link.w a5,#0
 movem.l a0/a2/d0-d1,-(sp)
 movea.l d0,a2
 subq.l #8,sp
 pea (sp)
 pea 6(sp)
 pea 12(sp)
 lea 18(sp),a0
 move.l a0,d1
 moveq #255,d0
 bsr.w L1ad22
 lea 12(sp),sp
 moveq #255,d1
 cmp.l d0,d1
 beq.s L19f0c
 movea.w (sp),a0
 move.l a0,-(sp)
 movea.w 6(sp),a0
 move.l a0,-(sp)
 clr.l -(sp)
 moveq #0,d1
 move.l a2,d0
 bsr.w L19f1e
 lea 12(sp),sp
 moveq #255,d1
 cmp.l d0,d1
 bne.s L19f10
L19f0c moveq #255,d0
 bra.s L19f12
L19f10 moveq #0,d0
L19f12 addq.l #8,sp
 movem.l -12(a5),a0/a2/d1
 unlk a5
 rts 
L19f1e link.w a5,#0
 movem.l a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 movea.l 38(a2),a3
 move.l a3,d0
 bne.s L19f3c
 move.l #10753,D0000c(a6)
 moveq #255,d0
 bra.s L19f5e
L19f3c bset.b #7,(a3)
 move.l 4(sp),28(a3)
 move.l 24(sp),32(a3)
 move.l 28(sp),36(a3)
 move.l 32(sp),40(a3)
 andi.b #$7f,(a3)
 moveq #0,d0
L19f5e movem.l -8(a5),a2-a3
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2-a3/d0,-(sp)
 movea.l d0,a2
 movea.l 38(a2),a3
 move.l a3,d0
 bne.s L19f86
 move.l #10753,D0000c(a6)
 moveq #255,d0
 bra.s L19f94
L19f86 andi.b #$df,(a3)
 movea.w 8(a2),a0
 move.l a0,d0
 bsr.w L1b596
L19f94 movem.l -12(a5),a0/a2-a3
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 movea.l 38(a2),a3
 move.l a3,d0
 bne.s L19fbc
 move.l #10753,D0000c(a6)
 moveq #255,d0
 bra.s L19fe4
L19fbc move.l a2,d0
 bsr.w L19fee
 movea.w 24(a3),a0
 move.l a0,-(sp)
 move.w 22(a3),d0
 ext.l d0
 subq.l #1,d0
 move.l d0,d1
 movea.w 8(a2),a0
 move.l a0,d0
 bsr.w L1b54e
 addq.l #4,sp
 andi.b #$7f,(a3)
 moveq #0,d0
L19fe4 movem.l -16(a5),a0/a2-a3/d1
 unlk a5
 rts 
L19fee link.w a5,#0
 movem.l a2-a3/d0/d4-d5,-(sp)
 movea.l d0,a2
 movea.l 38(a2),a3
 move.l 68(a3),d0
 lsl.l #4,d0
 move.l d0,d5
 move.l a2,d0
 beq.s L1a00c
 move.l a3,d0
 bne.s L1a016
L1a00c move.l #10753,D0000c(a6)
 bra.s L1a046
L1a016 bset.b #5,1(a3)
 moveq #0,d4
 bra.s L1a03a
L1a020 moveq #1,d0
 bsr.w L1cf5a
 tst.b 1(a3)
 bne.s L1a030
 moveq #1,d0
 bra.s L1a032
L1a030 moveq #0,d0
L1a032 btst.l #5,d0
 bne.s L1a03e
 addq.l #1,d4
L1a03a cmp.l d5,d4
 blt.s L1a020
L1a03e cmp.l d5,d4
 blt.s L1a046
 moveq #0,d0
 bra.s L1a048
L1a046 moveq #255,d0
L1a048 movem.l -16(a5),a2-a3/d4-d5
 unlk a5
 rts 
L1a052 link.w a5,#0
 movem.l a0/a2/d0-d1/d4-d5,-(sp)
 move.l d0,d4
 move.l d4,d0
 bsr.s L1a0ca
 movea.l d0,a2
 tst.l d0
 beq.s L1a0a4
 tst.b 8(a2)
 beq.s L1a090
 move.l D0000c(a6),d5
 moveq #1,d0
 move.l d0,_0154a(a6)
 move.l 4(a2),d1
 move.l #-184418304,d0
 or.l d4,d0
 movea.l (a2),a0
 jsr (a0)
 clr.l _0154a(a6)
 move.l d5,D0000c(a6)
 bra.s L1a0a4
L1a090 move.l 4(a2),-(sp)
 move.l (a2),d1
 move.l #-184483840,d0
 or.l d4,d0
L1a09e bsr.w L1a7bc
 addq.l #4,sp
L1a0a4 movem.l -20(a5),a0/a2/d1/d4-d5
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0,-(sp)
 lea L1a052(pc),a0
 move.l a0,d0
 bsr.w L1d52e
 movem.l -4(a5),a0
 unlk a5
 rts 
L1a0ca link.w a5,#0
 movem.l a0/a2/d0-d1/d4-d5,-(sp)
 move.l d0,d4
 move.l #255,d0
 and.l d4,d0
 move.l d0,d5
 move.l d4,d0
 asr.l #8,d0
 move.l d0,d4
 moveq #15,d0
 and.l d4,d0
 lsl.l #2,d0
 lea _01550(a6),a0
 movea.l (a0,d0.l),a2
 bra.s L1a120
L1a0f4 moveq #0,d0
 move.b 6(a2),d0
 cmp.l d4,d0
 bne.s L1a11e
 moveq #0,d0
 move.w 4(a2),d0
 cmp.l d5,d0
 ble.s L1a118
 move.l d5,d0
 moveq #10,d1
 bsr.w L1ca40
 moveq #18,d1
 add.l a2,d1
 add.l d1,d0
 bra.s L1a126
L1a118 move.l a2,d0
 addq.l #8,d0
 bra.s L1a126
L1a11e movea.l (a2),a2
L1a120 move.l a2,d0
 bne.s L1a0f4
 moveq #0,d0
L1a126 movem.l -20(a5),a0/a2/d1/d4-d5
 unlk a5
 rts 
L1a130 link.w a5,#0
 movem.l a2/d0-d1/d4,-(sp)
 move.l d0,d4
 movea.l d1,a2
 movem.l -8(a5),a2/d4
 unlk a5
 rts 
 link.w a5,#0
 movem.l d0-d1/d4-d5,-(sp)
 move.l d0,d4
 move.l d1,d5
 moveq #0,d0
 bsr.w L1a6ba
 movem.l -8(a5),d4-d5
 unlk a5
 rts 
L1a162 link.w a5,#0
 movem.l d0-d1/d4,-(sp)
 move.l d0,d4
 moveq #0,d1
 move.l d4,d0
 bsr.s L1a17c
 movem.l -8(a5),d1/d4
 unlk a5
 rts 
L1a17c link.w a5,#0
 movem.l a0/a2-a3/d0-d1,-(sp)
 moveq #1,d0
 cmp.l (sp),d0
 bgt.s L1a192
 cmpi.l #256,(sp)
 ble.s L1a19c
L1a192 move.l #12035,D0000c(a6)
 bra.s L1a1ca
L1a19c cmpi.b #254,_0154e(a6)
 bls.s L1a1ae
 move.l #12032,D0000c(a6)
 bra.s L1a1ca
L1a1ae move.l 4(sp),-(sp)
 move.l 4(sp),d1
 moveq #0,d0
 move.b _0154e(a6),d0
 addq.w #1,d0
 ext.l d0
 bsr.s L1a21c
 addq.l #4,sp
 movea.l d0,a2
 tst.l d0
 bne.s L1a1d0
L1a1ca move.w #-1,d0
 bra.s L1a212
L1a1d0 addq.b #1,_0154e(a6)
 moveq #15,d0
 and.b _0154e(a6),d0
 moveq #0,d1
 move.b d0,d1
 lsl.l #2,d1
 lea _01550(a6),a0
 movea.l (a0,d1.l),a3
 move.l a3,d0
 bne.s L1a204
 moveq #15,d0
 and.b _0154e(a6),d0
 moveq #0,d1
 move.b d0,d1
 lsl.l #2,d1
 lea _01550(a6),a0
 move.l a2,(a0,d1.l)
 bra.s L1a20a
L1a202 movea.l (a3),a3
L1a204 tst.l (a3)
 bne.s L1a202
 move.l a2,(a3)
L1a20a moveq #0,d0
 move.b _0154e(a6),d0
 lsl.w #8,d0
L1a212 movem.l -12(a5),a0/a2-a3
 unlk a5
 rts 
L1a21c link.w a5,#0
 movem.l a0/a2/d0-d2/d4-d6,-(sp)
 move.l d0,d4
 move.l d1,d5
 move.l 40(sp),d1
 move.l d1,d2
 moveq #0,d0
 move.w d5,d0
 subq.l #1,d0
 moveq #10,d1
 bsr.w L1ca40
 moveq #28,d1
 add.l d1,d0
 move.l d2,d1
 bsr.w L1aa4e
 movea.l d0,a2
 tst.l d0
 beq.s L1a28e
 clr.l (a2)
 move.w d5,4(a2)
 move.b d4,6(a2)
 lea L1a130(pc),a0
 move.l a0,8(a2)
 move.l a2,12(a2)
 move.b #1,16(a2)
 moveq #0,d6
 bra.s L1a28a
L1a26a moveq #0,d0
 move.w d6,d0
 moveq #10,d1
 bsr.w L1ca40
 lea 18(a2,d0.l),a0
 move.l 8(a2),(a0)
 move.l 12(a2),4(a0)
 move.w 16(a2),8(a0)
 addq.w #1,d6
L1a28a cmp.w d5,d6
 bcs.s L1a26a
L1a28e move.l a2,d0
 movem.l -24(a5),a0/a2/d2/d4-d6
 unlk a5
 rts 
L1a29a link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d6,-(sp)
 move.l d0,d4
 movea.l d1,a2
 movea.l 44(sp),a3
 move.l 48(sp),d5
 move.l d4,d0
 bsr.w L1a40c
 movea.l d0,a4
 tst.l d0
 bne.s L1a2c6
 move.l #12033,D0000c(a6)
 bra.w L1a364
L1a2c6 lea -10(sp),sp
 move.l a2,d0
 bne.s L1a2d6
 lea L1a130(pc),a2
 movea.l a4,a3
 moveq #1,d5
L1a2d6 move.l a2,(sp)
 move.l a3,4(sp)
 move.b d5,8(sp)
 moveq #1,d0
 bsr.w L1d64e
 moveq #0,d6
 bra.s L1a33c
L1a2ea move.l d6,d0
 moveq #10,d1
 bsr.w L1ca40
 move.l 8(a4),d1
 cmp.l 18(a4,d0.l),d1
 bne.s L1a33a
 move.l d6,d0
 moveq #10,d1
 bsr.w L1ca40
 move.l 12(a4),d1
 cmp.l 22(a4,d0.l),d1
 bne.s L1a33a
 move.l d6,d0
 moveq #10,d1
 bsr.w L1ca40
 move.b 16(a4),d1
 cmp.b 26(a4,d0.l),d1
 bne.s L1a33a
 move.l d6,d0
 moveq #10,d1
 bsr.w L1ca40
 lea 18(a4,d0.l),a0
 move.l (sp),(a0)
 move.l 4(sp),4(a0)
 move.w 8(sp),8(a0)
L1a33a addq.l #1,d6
L1a33c moveq #0,d0
 move.w 4(a4),d0
 cmp.l d6,d0
 bgt.s L1a2ea
 move.l (sp),8(a4)
 move.l 4(sp),12(a4)
 move.w 8(sp),16(a4)
 moveq #255,d0
 bsr.w L1d64e
 moveq #0,d0
 lea 10(sp),sp
 bra.s L1a366
L1a364 moveq #255,d0
L1a366 movem.l -28(a5),a0/a2-a4/d4-d6
 unlk a5
 rts 
L1a370 link.w a5,#0
 movem.l a2-a4/d0-d1/d4-d5,-(sp)
 move.l d0,d4
 movea.l d1,a2
 movea.l 36(sp),a3
 move.l 40(sp),d5
 subq.l #2,sp
 moveq #0,d0
 move.w d4,d0
 bsr.w L1a40c
 movea.l d0,a4
 tst.l d0
 bne.s L1a39e
 move.l #12033,D0000c(a6)
 bra.s L1a3fe
L1a39e move.w #255,d0
 and.w d4,d0
 move.w d0,(sp)
 cmp.w 4(a4),d0
 bcs.s L1a3b6
 move.l #12034,D0000c(a6)
 bra.s L1a3fe
L1a3b6 move.l a2,d0
 bne.s L1a3c4
 move.l #12037,D0000c(a6)
 bra.s L1a3fe
L1a3c4 moveq #1,d0
 bsr.w L1d64e
 moveq #0,d0
 move.w (sp),d0
 moveq #10,d1
 bsr.w L1ca40
 move.l a2,18(a4,d0.l)
 moveq #0,d0
 move.w (sp),d0
 moveq #10,d1
 bsr.w L1ca40
 move.l a3,22(a4,d0.l)
 moveq #0,d0
 move.w (sp),d0
 moveq #10,d1
 bsr.w L1ca40
 move.b d5,26(a4,d0.l)
 moveq #255,d0
 bsr.w L1d64e
 moveq #0,d0
 bra.s L1a400
L1a3fe moveq #255,d0
L1a400 addq.l #2,sp
 movem.l -20(a5),a2-a4/d4-d5
 unlk a5
 rts 
L1a40c link.w a5,#0
 movem.l a0/a2/d0-d1/d4,-(sp)
 move.l d0,d4
 move.w d4,d0
 lsr.w #8,d0
 move.w d0,d4
 moveq #15,d0
 and.w d4,d0
 moveq #0,d1
 move.w d0,d1
 lsl.l #2,d1
 lea _01550(a6),a0
 movea.l (a0,d1.l),a2
 bra.s L1a440
L1a430 moveq #0,d0
 move.b 6(a2),d0
 cmp.w d4,d0
 bne.s L1a43e
 move.l a2,d0
 bra.s L1a446
L1a43e movea.l (a2),a2
L1a440 move.l a2,d0
 bne.s L1a430
 moveq #0,d0
L1a446 movem.l -16(a5),a0/a2/d1/d4
 unlk a5
 rts 
 link.w a5,#0
 movem.l d0-d1/d4,-(sp)
 move.l d0,d4
 move.l d4,d1
 bsr.w L1d4f6
 bsr.w L1d438
 movem.l -8(a5),d1/d4
 unlk a5
 rts 
L1a46e link.w a5,#0
 movem.l d0,-(sp)
 move.l _0154a(a6),d0
 unlk a5
 rts 
L1a47e link.w a5,#0
 movem.l a0/a2-a3/d0-d1,-(sp)
 lea _01596(a6),a2
L1a48a move.l D006c2(a6),d0
 bsr.w L1d170
 tst.l d0
 bne.s L1a4be
 tst.l _015ac(a6)
 beq.s L1a4be
 move.w #1,_015b8(a6)
 move.l _015b0(a6),-(sp)
 move.l _015ac(a6),d1
 move.l #-50200576,d0
 bsr.w L1a8aa
 addq.l #4,sp
 clr.l _015ac(a6)
 clr.w _015b8(a6)
L1a4be movea.w _01596(a6),a0
 move.l a0,-(sp)
 moveq #1,d1
 move.l D006c2(a6),d0
 bsr.w L1d1c6
 addq.l #4,sp
 tst.l d0
 beq.s L1a4be
 move.w _015a6(a6),d0
 ext.l d0
 cmp.l 12(a2),d0
 bgt.s L1a504
 tst.w _01590(a6)
 bne.s L1a508
 tst.l _015a8(a6)
 beq.s L1a508
 move.w #1,_01590(a6)
 move.l 12(a2),d1
 move.l #-50266112,d0
 movea.l _015a8(a6),a0
 jsr (a0)
 bra.s L1a508
L1a504 clr.w _01590(a6)
L1a508 move.w #1,_015b8(a6)
 move.l 8(a2),d0
 moveq #12,d1
 bsr.w L1ca40
 add.l 30(a2),d0
 movea.l d0,a3
 subq.l #1,12(a2)
 addq.l #1,8(a2)
 move.w _01596(a6),d0
 ext.l d0
 cmp.l 8(a2),d0
 bgt.s L1a536
 clr.l 8(a2)
L1a536 clr.w _015b8(a6)
 move.l 8(a3),d1
 move.l (a3),d0
 movea.l 4(a3),a0
 jsr (a0)
 bra.w L1a48a
 movem.l -16(a5),a0/a2-a3/d1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 movea.w _01598(a6),a0
 move.l a0,d1
 moveq #12,d0
 muls.w _01596(a6),d0
 bsr.w L1aa4e
 move.l d0,_015b4(a6)
 tst.l _015b4(a6)
 bne.s L1a580
 move.l #10989,D0000c(a6)
 bra.s L1a5dc
L1a580 bsr.w L1d4f6
 move.l d0,-(sp)
 lea L1a612(pc),a0
 move.l a0,d1
 lea _015be(a6),a0
 move.l a0,d0
 bsr.w L14b7a
 addq.l #4,sp
 pea _015ba(a6)
 pea (L00001).w
 moveq #255,d1
 moveq #0,d0
 bsr.w L1d0e2
 addq.l #8,sp
 move.l d0,D006c2(a6)
 moveq #255,d1
 cmp.l d0,d1
 bne.s L1a5e0
 lea _015ba(a6),a0
 move.l a0,d0
 bsr.w L1d10c
 move.l d0,D006c2(a6)
 moveq #255,d1
 cmp.l d0,d1
 beq.s L1a5dc
 clr.l -(sp)
 moveq #0,d1
 move.l D006c2(a6),d0
 bsr.w L1d198
 addq.l #4,sp
 moveq #255,d1
 cmp.l d0,d1
 bne.s L1a5e0
L1a5dc moveq #255,d0
 bra.s L1a608
L1a5e0 moveq #2,d0
 bsr.w L1cf5a
 tst.l (sp)
 beq.s L1a602
 move.l 20(sp),d1
 move.l 4(sp),d0
 movea.l (sp),a0
 jsr (a0)
 tst.l d0
 bge.s L1a602
 move.l D0000c(a6),d0
 bsr.w L1a6ba
L1a602 bsr.w L1a47e
 moveq #0,d0
L1a608 movem.l -4(a5),a0
 unlk a5
 rts 
L1a612 dc.w $2530
 move.w _0b564(a6),-(a2)
 dc.w $0
 link.w a5,#0
 movem.l a0/a2-a4/d0-d1,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 movea.w _01598(a6),a0
 move.l a0,d1
 moveq #12,d0
 bsr.w L1aa4e
 movea.l d0,a4
 tst.l d0
 bne.s L1a642
 move.l #10989,D0000c(a6)
 bra.s L1a670
L1a642 move.l a2,d0
 bne.s L1a650
 move.l #10753,D0000c(a6)
 bra.s L1a670
L1a650 move.l a2,4(a4)
 move.l a3,8(a4)
 moveq #1,d0
 bsr.w L1d64e
 move.l _01592(a6),(a4)
 move.l a4,_01592(a6)
 moveq #255,d0
 bsr.w L1d64e
 moveq #0,d0
 bra.s L1a672
L1a670 moveq #255,d0
L1a672 movem.l -16(a5),a0/a2-a4
 unlk a5
 rts 
 link.w a5,#0
 movem.l a2/d0-d1,-(sp)
 movea.l _01592(a6),a2
 move.l a2,d0
 beq.s L1a6a6
 moveq #1,d0
 bsr.w L1d64e
 move.l (a2),_01592(a6)
 moveq #255,d0
 bsr.w L1d64e
 move.l a2,d1
 moveq #12,d0
 bsr.w L1aa7a
 bra.s L1a6b0
L1a6a6 move.l #10753,D0000c(a6)
 moveq #255,d0
L1a6b0 movem.l -8(a5),a2/d1
 unlk a5
 rts 
L1a6ba link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4-d5,-(sp)
 move.l d0,d4
 lea -32(sp),sp
 bra.s L1a6fc
L1a6ca moveq #1,d0
 bsr.w L1d64e
 movea.l _01592(a6),a2
 clr.l _01592(a6)
 moveq #255,d0
 bsr.w L1d64e
 bra.s L1a6f8
L1a6e0 move.l 8(a2),d1
 move.l d4,d0
 movea.l 4(a2),a0
 jsr (a0)
 movea.l (a2),a3
 move.l a2,d1
 moveq #12,d0
 bsr.w L1aa7a
 movea.l a3,a2
L1a6f8 move.l a2,d0
 bne.s L1a6e0
L1a6fc tst.l _01592(a6)
 bne.s L1a6ca
 lea (sp),a0
 move.l a0,d1
 move.l #65535,d0
 and.l D006c2(a6),d0
 bsr.w L1d148
 moveq #255,d1
 cmp.l d0,d1
 beq.s L1a73c
 moveq #0,d5
 bra.s L1a728
L1a71e move.l D006c2(a6),d0
 bsr.w L1d12e
 addq.l #1,d5
L1a728 moveq #0,d0
 move.w 22(sp),d0
 cmp.l d5,d0
 bgt.s L1a71e
 lea _015ba(a6),a0
 move.l a0,d0
 bsr.w L1d13a
L1a73c move.l d4,d0
 bsr.w L1d686
 lea 32(sp),sp
 movem.l -24(a5),a0/a2-a3/d1/d4-d5
 unlk a5
 rts 
 link.w a5,#0
 movem.l d0,-(sp)
 unlk a5
 rts 
 link.w a5,#0
 movem.l a2/d0-d1/d4-d6,-(sp)
 move.l d0,d4
 move.l d1,d5
 move.l 32(sp),d6
 movea.l 36(sp),a2
 move.w d4,_01596(a6)
 move.w d5,_01598(a6)
 move.w d6,_015a6(a6)
 move.l a2,d0
 beq.s L1a784
 move.l a2,_015a8(a6)
L1a784 movem.l -16(a5),a2/d4-d6
 unlk a5
 rts 
 link.w a5,#0
 movem.l d0,-(sp)
 move.l _015a2(a6),d0
 unlk a5
 rts 
 link.w a5,#0
 movem.l d0-d1,-(sp)
 move.l (sp),d0
 moveq #12,d1
 bsr.w L1ca40
 moveq #38,d1
 add.l d1,d0
 movem.l -4(a5),d1
 unlk a5
 rts 
L1a7bc link.w a5,#0
 movem.l a2-a3/d0-d1/d4-d5,-(sp)
 move.l d0,d4
 movea.l d1,a2
 movea.l 32(sp),a3
 move.l a2,d0
 bne.s L1a7da
 move.l #13569,D0000c(a6)
 bra.s L1a806
L1a7da moveq #1,d0
 bsr.w L1d64e
 move.w #1,_015b8(a6)
 pea (a3)
 move.l a2,d1
 move.l d4,d0
 bsr.w L1a8aa
 addq.l #4,sp
 move.l d0,d5
 clr.w _015b8(a6)
 moveq #255,d0
 bsr.w L1d64e
 tst.l d5
 beq.s L1a80a
 move.l d5,D0000c(a6)
L1a806 moveq #255,d0
 bra.s L1a80c
L1a80a moveq #0,d0
L1a80c movem.l -16(a5),a2-a3/d4-d5
 unlk a5
 rts 
 link.w a5,#0
 movem.l a2-a3/d0-d1/d4-d6,-(sp)
 move.l d0,d4
 movea.l d1,a2
 movea.l _015b4(a6),a3
 moveq #0,d5
 moveq #0,d6
 moveq #1,d0
 bsr.w L1d64e
 move.w #1,_015b8(a6)
 moveq #255,d0
 cmp.l d4,d0
 bne.s L1a874
 move.l _015a2(a6),d6
 moveq #0,d0
 move.l d0,_015a2(a6)
 move.l d0,_0159e(a6)
 move.l d0,_0159a(a6)
 clr.l -(sp)
 moveq #0,d1
 move.l D006c2(a6),d0
 bsr.w L1d198
 addq.l #4,sp
 bra.s L1a87e
L1a85e move.l (a3),d0
 and.l d4,d0
 cmp.l d4,d0
 bne.s L1a86c
 clr.l 4(a3)
 addq.l #1,d6
L1a86c addq.l #1,d5
 adda.l #12,a3
L1a874 move.w _01596(a6),d0
 ext.l d0
 cmp.l d5,d0
 bgt.s L1a85e
L1a87e clr.w _015b8(a6)
 moveq #255,d0
 bsr.w L1d64e
 move.l a2,d0
 beq.s L1a89e
 move.l 36(sp),-(sp)
 move.l a2,d1
 move.l #-50200576,d0
 bsr.w L1a7bc
 addq.l #4,sp
L1a89e move.l d6,d0
 movem.l -20(a5),a2-a3/d4-d6
 unlk a5
 rts 
L1a8aa link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d5,-(sp)
 move.l d0,d4
 movea.l d1,a2
 movea.l 40(sp),a3
 lea _01596(a6),a4
 move.w (a4),d0
 ext.l d0
 cmp.l 12(a4),d0
 ble.s L1a90e
 move.l 4(a4),d0
 moveq #12,d1
 bsr.w L1ca40
 add.l 30(a4),d0
 move.l d0,d5
 movea.l d5,a0
 move.l a2,4(a0)
 movea.l d5,a0
 move.l a3,8(a0)
 movea.l d5,a0
 move.l d4,(a0)
 addq.l #1,12(a4)
 move.l 4(a4),d0
 addq.l #1,d0
 move.w _01596(a6),d1
 ext.l d1
 bsr.w L1caa2
 move.l d0,4(a4)
 moveq #0,d1
 move.l D006c2(a6),d0
 bsr.w L1d156
 moveq #0,d0
 bra.s L1a914
L1a90e move.l #13568,d0
L1a914 movem.l -24(a5),a0/a2-a4/d4-d5
 unlk a5
 rts 
 link.w a5,#0
 movem.l a2-a4/d0-d1/d4-d5,-(sp)
 move.l d0,d4
 movea.l d1,a2
 movea.l 36(sp),a3
 moveq #1,d0
 bsr.w L1d64e
 move.w #1,_015b8(a6)
 move.w _01596(a6),d0
 ext.l d0
 cmp.l _015a2(a6),d0
 ble.s L1a98a
 tst.l _0159e(a6)
 beq.s L1a952
 move.l _0159e(a6),d0
 bra.s L1a958
L1a952 move.w _01596(a6),d0
 ext.l d0
L1a958 subq.l #1,d0
 move.l d0,_0159e(a6)
 move.l _0159e(a6),d0
 moveq #12,d1
 bsr.w L1ca40
 add.l _015b4(a6),d0
 movea.l d0,a4
 move.l a2,4(a4)
 move.l a3,8(a4)
 move.l d4,(a4)
 addq.l #1,_015a2(a6)
 moveq #0,d1
 move.l D006c2(a6),d0
 bsr.w L1d156
 moveq #0,d5
 bra.s L1a98c
L1a98a moveq #255,d5
L1a98c clr.w _015b8(a6)
 moveq #255,d0
 bsr.w L1d64e
 move.l d5,d0
 movem.l -20(a5),a2-a4/d4-d5
 unlk a5
 rts 
L1a9a2 movem.l d2-d3,-(sp)
 move.l d0,d3
 move.l #82,d1
 move.l #16896,d2
 os9 I$SetStt
 bcs.s L1a9d6
 move.l d3,d0
 move.l #89,d1
 move.l #16898,d2
 os9 I$SetStt
 bcs.s L1a9d6
 moveq #0,d0
L1a9d0 movem.l (sp)+,d2-d3
 rts 
L1a9d6 move.l d1,D0000c(a6)
 moveq #255,d0
 bra.s L1a9d0
L1a9de movem.l d2,-(sp)
 moveq #0,d1
 move.w #81,d1
 move.w #16914,d2
 os9 I$SetStt
 clr.w d0
 swap d0
 movem.l (sp)+,d2
 rts 
L1a9fa link.w a5,#0
 movem.l a0/d0-d1/d4-d5,-(sp)
 move.l d0,d4
 lea L1aa44(pc),a0
 move.l a0,d1
 move.l d4,d0
 bsr.w L1b60c
 moveq #255,d1
 cmp.l d0,d1
 beq.s L1aa34
 move.l d4,d0
 bsr.s L1a9de
 move.l d0,d5
 cmp.l _015c4(a6),d5
 beq.s L1aa2a
 move.l #10755,D0000c(a6)
L1aa2a move.l d4,d0
 bsr.w L1a9a2
 tst.l d0
 beq.s L1aa38
L1aa34 moveq #255,d0
 bra.s L1aa3a
L1aa38 moveq #0,d0
L1aa3a movem.l -16(a5),a0/d1/d4-d5
 unlk a5
 rts 
L1aa44 bls.s L1aaaa
 dc.w $695f
 bhi.s L1aaba
 dc.w $7379
 dc.w $7300
L1aa4e link.w a5,#0
 movem.l a2/d0-d1/d4-d5,-(sp)
 move.l d0,d4
 move.l d1,d5
 move.l d5,d1
 move.l d4,d0
 bsr.w L1d5ca
 movea.l d0,a2
 moveq #255,d1
 cmp.l d0,d1
 bne.s L1aa6e
 moveq #0,d0
 bra.s L1aa70
L1aa6e move.l a2,d0
L1aa70 movem.l -12(a5),a2/d4-d5
 unlk a5
 rts 
L1aa7a link.w a5,#0
 movem.l a2/d0-d1/d4-d5,-(sp)
 move.l d0,d4
 movea.l d1,a2
 move.l a2,d1
 move.l d4,d0
 bsr.w L1d342
 move.l d0,d5
 moveq #255,d1
 cmp.l d0,d1
 move.l d5,d0
 movem.l -12(a5),a2/d4-d5
 unlk a5
 rts 
L1aaa0 link.w a5,#0
 movem.l a2/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
L1aaaa move.l d1,d4
 move.l 36(sp),d5
 move.l 40(sp),d6
 move.l a2,d0
 bne.s L1aabc
 moveq #255,d0
L1aaba bra.s L1ab0a
L1aabc andi.b #$0f,d4
 moveq #0,d0
 move.b d4,d0
 lsl.w #4,d0
 or.b d4,d0
 move.b d0,d7
 tst.l d6
 beq.s L1aadc
 move.b #240,d0
 and.b (a2),d0
 or.b d4,d0
 move.b d0,(a2)
 addq.l #1,a2
 subq.l #1,d5
L1aadc moveq #1,d0
 and.l d5,d0
 move.l d0,d6
 lsr.l #1,d5
 move.l d5,-(sp)
 moveq #0,d0
 move.b d7,d0
 move.l d0,d1
 move.l a2,d0
 bsr.w L1ab14
 addq.l #4,sp
 tst.l d6
 beq.s L1ab08
 adda.l d5,a2
 moveq #15,d0
 and.b (a2),d0
 moveq #0,d1
 move.b d4,d1
 lsl.w #4,d1
 or.b d1,d0
 move.b d0,(a2)
L1ab08 moveq #0,d0
L1ab0a movem.l -20(a5),a2/d4-d7
 unlk a5
 rts 
L1ab14 link.w a5,#0
 movem.l a2-a4/d0-d2/d4-d5,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l 40(sp),d5
 lsl.l #8,d4
 or.w d1,d4
 move.w d4,d1
 swap d4
 or.l d1,d4
 bra.w L1ab36
L1ab32 move.b d4,(a2)+
 subq.l #1,d5
L1ab36 move.l a2,d0
 moveq #3,d1
 and.l d1,d0
 beq.s L1ab42
 tst.l d5
 bhi.s L1ab32
L1ab42 move.l a2,d0
 add.l d5,d0
 movea.l d0,a3
 moveq #252,d1
 and.l d1,d0
 movea.l d0,a4
 bra.w L1ab54
L1ab52 move.l d4,(a2)+
L1ab54 cmpa.l a4,a2
 bcs.s L1ab52
 bra.w L1ab5e
L1ab5c move.b d4,(a2)+
L1ab5e cmpa.l a3,a2
 bcs.s L1ab5c
 movem.l -24(a5),a2-a4/d2/d4-d5
 unlk a5
 rts 
L1ab6c link.w a5,#0
 movem.l a2-a3/d0-d1/d4-d6,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l 36(sp),d4
 subq.l #4,sp
 move.l a3,d0
 beq.s L1ab86
 move.l a2,d0
 bne.s L1ab8c
L1ab86 moveq #255,d0
 bra.w L1ac2a
L1ab8c move.l 48(sp),d0
 cmp.l 44(sp),d0
 bne.s L1abde
 moveq #1,d0
 cmp.l 48(sp),d0
 bne.s L1abb2
 move.b #240,d0
 and.b (a2),d0
 moveq #15,d1
 and.b (a3),d1
 or.b d1,d0
 move.b d0,(a2)
 addq.l #1,a2
 addq.l #1,a3
 subq.l #1,d4
L1abb2 moveq #1,d0
 and.l d4,d0
 move.l d0,(sp)
 lsr.l #1,d4
 move.l d4,-(sp)
 move.l a3,d1
 move.l a2,d0
 bsr.w L1c870
 addq.l #4,sp
 tst.l (sp)
 beq.s L1ac28
 adda.l d4,a3
 adda.l d4,a2
 moveq #15,d0
 and.b (a2),d0
 move.b #240,d1
 and.b (a3),d1
 or.b d1,d0
 move.b d0,(a2)
 bra.s L1ac28
L1abde moveq #0,d6
 bra.s L1ac24
L1abe2 tst.l 48(sp)
 beq.s L1abee
 moveq #15,d0
 and.b (a3)+,d0
 bra.s L1abf2
L1abee move.b (a3),d0
 lsr.b #4,d0
L1abf2 move.b d0,d5
 moveq #1,d0
 eor.l d0,48(sp)
 tst.l 44(sp)
 beq.s L1ac0e
 move.b #240,d0
 and.b (a2),d0
 or.b d5,d0
 move.b d0,(a2)
 addq.l #1,a2
 bra.s L1ac1c
L1ac0e moveq #15,d0
 and.b (a2),d0
 moveq #0,d1
 move.b d5,d1
 lsl.w #4,d1
 or.b d1,d0
 move.b d0,(a2)
L1ac1c moveq #1,d0
 eor.l d0,44(sp)
 addq.l #1,d6
L1ac24 cmp.l d4,d6
 bcs.s L1abe2
L1ac28 moveq #0,d0
L1ac2a addq.l #4,sp
 movem.l -20(a5),a2-a3/d4-d6
 unlk a5
 rts 
L1ac36 link.w a5,#0
 movem.l a2-a3/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l 40(sp),d4
 move.l 44(sp),d5
 move.l a3,d0
 beq.s L1ac52
 move.l a2,d0
 bne.s L1ac56
L1ac52 moveq #255,d0
 bra.s L1ac8c
L1ac56 moveq #0,d7
 bra.s L1ac86
L1ac5a moveq #15,d0
 and.b (a3)+,d0
 move.b d0,d6
 tst.l d5
 beq.s L1ac72
 move.b #240,d0
 and.b (a2),d0
 or.b d6,d0
 move.b d0,(a2)
 addq.l #1,a2
 bra.s L1ac80
L1ac72 moveq #15,d0
 and.b (a2),d0
 moveq #0,d1
 move.b d6,d1
 lsl.w #4,d1
 or.b d1,d0
 move.b d0,(a2)
L1ac80 moveq #1,d0
 eor.l d0,d5
 addq.l #1,d7
L1ac86 cmp.l d4,d7
 bcs.s L1ac5a
 moveq #0,d0
L1ac8c movem.l -24(a5),a2-a3/d4-d7
 unlk a5
 rts 
L1ac96 link.w a5,#0
 movem.l a2-a3/d0-d1/d4-d6,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l 36(sp),d4
 move.l a3,d0
 beq.s L1acae
 move.l a2,d0
 bne.s L1acb2
L1acae moveq #255,d0
 bra.s L1acd8
L1acb2 moveq #0,d6
 bra.s L1acd2
L1acb6 tst.l 40(sp)
 beq.s L1acc2
 moveq #15,d0
 and.b (a3)+,d0
 bra.s L1acc6
L1acc2 move.b (a3),d0
 lsr.b #4,d0
L1acc6 move.b d0,d5
 moveq #1,d0
 eor.l d0,40(sp)
 move.b d5,(a2)+
 addq.l #1,d6
L1acd2 cmp.l d4,d6
 bcs.s L1acb6
 moveq #0,d0
L1acd8 movem.l -20(a5),a2-a3/d4-d6
 unlk a5
 rts 
 link.w a5,#0
 movem.l a2-a3/d0-d1/d4-d6,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l 36(sp),d4
 move.l 40(sp),d5
 move.l a2,d0
 beq.s L1acfe
 move.l a3,d0
 bne.s L1ad0e
L1acfe moveq #255,d0
 bra.s L1ad18
L1ad02 move.b (a3)+,d6
 cmp.b d5,d6
 beq.s L1ad0c
 move.b d6,(a2)+
 bra.s L1ad0e
L1ad0c addq.l #1,a2
L1ad0e move.l d4,d0
 subq.l #1,d4
 tst.l d0
 bne.s L1ad02
 moveq #0,d0
L1ad18 movem.l -20(a5),a2-a3/d4-d6
 unlk a5
 rts 
L1ad22 link.w a5,#0
 movem.l a0/a2-a4/d0-d1,-(sp)
 subq.l #8,sp
 tst.l 12(sp)
 beq.s L1ad44
 tst.l 40(sp)
 beq.s L1ad44
 tst.l 44(sp)
 beq.s L1ad44
 tst.l 48(sp)
 bne.s L1ad4e
L1ad44 move.l #10753,D0000c(a6)
 bra.s L1ad96
L1ad4e tst.l 8(sp)
 bge.s L1ad5e
 moveq #0,d0
 bsr.w L1ae66
 move.l d0,8(sp)
L1ad5e moveq #1,d1
 moveq #3,d0
 bsr.w L1afe6
 movea.l d0,a2
 moveq #1,d1
 moveq #8,d0
 bsr.w L1afe6
 movea.l d0,a3
 tst.l 8(sp)
 bne.s L1ad7c
 move.l a3,(sp)
 bra.s L1ad7e
L1ad7c move.l a2,(sp)
L1ad7e move.l (sp),d0
 bsr.w L1b05c
 movea.l d0,a4
 tst.l d0
 bne.s L1ad9c
 move.l a2,d0
 bsr.w L1c5b4
 move.l a3,d0
 bsr.w L1c5b4
L1ad96 moveq #255,d0
 bra.w L1ae4e
L1ad9c clr.l 4(sp)
 pea L1ae5a(pc)
 move.l a4,d1
 moveq #1,d0
 bsr.w L1bcf8
 addq.l #4,sp
 tst.l d0
 beq.s L1adf6
 pea L1ae5e(pc)
 move.l a4,d1
 moveq #1,d0
 bsr.w L1bcf8
 addq.l #4,sp
 tst.l d0
 beq.s L1add4
 movea.l 12(sp),a0
 clr.w (a0)
 movea.l 44(sp),a0
 move.w #768,(a0)
 bra.s L1ade4
L1add4 movea.l 12(sp),a0
 move.w #1,(a0)
 movea.l 44(sp),a0
 move.w #720,(a0)
L1ade4 movea.l 40(sp),a0
 move.w #60,(a0)
 movea.l 48(sp),a0
 move.w #480,(a0)
 bra.s L1ae38
L1adf6 pea L1ae61(pc)
 move.l a4,d1
 moveq #1,d0
 bsr.w L1bcf8
 addq.l #4,sp
 tst.l d0
 beq.s L1ae2a
 movea.l 12(sp),a0
 move.w #2,(a0)
 movea.l 40(sp),a0
 move.w #50,(a0)
 movea.l 48(sp),a0
 move.w #560,(a0)
 movea.l 44(sp),a0
 move.w #768,(a0)
 bra.s L1ae38
L1ae2a move.l #11013,D0000c(a6)
 moveq #255,d0
 move.l d0,4(sp)
L1ae38 move.l a2,d0
 bsr.w L1c5b4
 move.l a4,d0
 bsr.w L1c5b4
 move.l a3,d0
 bsr.w L1c5b4
 move.l 4(sp),d0
L1ae4e addq.l #8,sp
 movem.l -16(a5),a0/a2-a4
 unlk a5
 rts 
L1ae5a dc.w $3532
 move.w d0,-(a2)
L1ae5e addq.w #2,(a6)
 dc.w $36
L1ae61 equ *-1
 move.w (a5,d0.w),d1
L1ae66 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d5,-(sp)
 lea -134(sp),sp
 moveq #1,d1
 moveq #0,d0
 bsr.w L1afe6
 movea.l d0,a3
 tst.l d0
 beq.s L1aec4
 move.l a3,d0
 bsr.w L1b05c
 movea.l d0,a4
 pea (L00080).w
 move.l a4,d1
 lea 10(sp),a0
 move.l a0,d0
 bsr.w L1be76
 addq.l #4,sp
 clr.b 133(sp)
 move.l a3,d0
 bsr.w L1c5b4
 move.l a4,d0
 beq.s L1aeae
 move.l a4,d0
 bsr.w L1c5b4
L1aeae pea L1af1c(pc)
 lea 10(sp),a0
 move.l a0,d1
 moveq #1,d0
 bsr.w L1bcf8
 addq.l #4,sp
 move.l d0,d4
 bne.s L1aec8
L1aec4 moveq #0,d0
 bra.s L1af0e
L1aec8 lea 6(sp),a0
 move.l a0,d0
 move.l d4,d1
 addq.l #3,d1
 add.l d1,d0
 movea.l d0,a2
 moveq #34,d1
 move.l a2,d0
 bsr.w L1bf18
 move.l d0,(sp)
 tst.l (sp)
 beq.s L1aee8
 movea.l (sp),a0
 clr.b (a0)
L1aee8 move.b (a2),4(sp)
 clr.b 5(sp)
 lea 4(sp),a0
 move.l a0,d0
 bsr.w L1bf60
 move.l d0,d5
 tst.l 134(sp)
 beq.s L1af0c
 move.l a2,d1
 move.l 134(sp),d0
 bsr.w L1be26
L1af0c move.l d5,d0
L1af0e lea 134(sp),sp
 movem.l -28(a5),a0/a2-a4/d1/d4-d5
 unlk a5
 rts 
L1af1c addq.w #1,(a6)
 move.w d0,-(a6)
L1af20 link.w a5,#0
 movem.l a2/d0,-(sp)
 movea.l d0,a2
L1af2a cmpi.b #58,(a2)+
 bne.s L1af2a
 move.l a2,d0
 movem.l -4(a5),a2
 unlk a5
 rts 
 link.w a5,#0
 movem.l a2/d0,-(sp)
 movea.l d0,a2
L1af46 cmpi.b #13,(a2)+
 bne.s L1af46
 move.l a2,d0
 movem.l -4(a5),a2
 unlk a5
 rts 
L1af58 link.w a5,#0
 movem.l a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 bra.s L1af6a
L1af66 addq.l #1,a2
 addq.l #1,a3
L1af6a tst.b (a2)
 beq.s L1af8e
 cmpi.b #58,(a2)
 beq.s L1af8e
 move.b (a3),d0
 ext.w d0
 ext.l d0
 bsr.w L1c928
 move.l d0,d1
 move.b (a2),d0
 ext.w d0
 ext.l d0
 bsr.w L1c928
 cmp.l d0,d1
 beq.s L1af66
L1af8e tst.b (a2)
 beq.s L1af98
 cmpi.b #58,(a2)
 bne.s L1afa6
L1af98 tst.b (a3)
 beq.s L1afa2
 cmpi.b #58,(a3)
 bne.s L1afa6
L1afa2 moveq #1,d0
 bra.s L1afa8
L1afa6 moveq #0,d0
L1afa8 movem.l -8(a5),a2-a3
 unlk a5
 rts 
L1afb2 link.w a5,#0
 movem.l a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 move.l a2,d0
 bsr.w L1be08
 addq.l #1,d0
 bsr.w L1c372
 movea.l d0,a3
 tst.l d0
 bne.s L1afd2
 moveq #255,d0
 bra.s L1afdc
L1afd2 move.l a2,d1
 move.l a3,d0
 bsr.w L1be26
 move.l a3,d0
L1afdc movem.l -12(a5),a2-a3/d1
 unlk a5
 rts 
L1afe6 link.w a5,#0
 movem.l a0/d0-d1/d4-d7,-(sp)
 move.l d0,d4
 move.l d1,d5
 moveq #1,d1
 move.l _015c8(a6),d0
 bsr.w L1cd64
 move.l d0,d7
 moveq #255,d1
 cmp.l d0,d1
 beq.s L1b050
 moveq #1,d6
 bra.s L1b034
L1b008 lea D006c6(a6),a0
 move.l a0,d0
 bsr.w L1bf60
 cmp.l d4,d0
 bne.s L1b034
 move.l d6,d0
 addq.l #1,d6
 cmp.l d5,d0
 bne.s L1b034
 move.l d7,d0
 bsr.w L1cd7a
 lea D006c6(a6),a0
 move.l a0,d0
 bsr.w L1b0ce
 bsr.w L1afb2
 bra.s L1b052
L1b034 pea (L00100).w
 lea D006c6(a6),a0
 move.l a0,d1
 move.l d7,d0
 bsr.w L1ce7e
 addq.l #4,sp
 tst.l d0
 bgt.s L1b008
 move.l d7,d0
 bsr.w L1cd7a
L1b050 moveq #0,d0
L1b052 movem.l -20(a5),a0/d4-d7
 unlk a5
 rts 
L1b05c link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4-d5,-(sp)
 movea.l d0,a2
 move.l a2,d0
 beq.s L1b0c2
 moveq #1,d1
 move.l _015c8(a6),d0
 bsr.w L1cd64
 move.l d0,d4
 moveq #255,d1
 cmp.l d0,d1
 beq.s L1b0c2
 bra.s L1b0a6
L1b07e lea D006c6(a6),a0
 move.l a0,d0
 bsr.w L1af20
 movea.l d0,a3
 move.l d0,d1
 move.l a2,d0
 bsr.w L1af58
 tst.l d0
 beq.s L1b0a6
 move.l d4,d0
 bsr.w L1cd7a
 move.l a3,d0
 bsr.s L1b0f6
 bsr.w L1afb2
 bra.s L1b0c4
L1b0a6 pea (L00100).w
 lea D006c6(a6),a0
 move.l a0,d1
 move.l d4,d0
 bsr.w L1ce7e
 addq.l #4,sp
 move.l d0,d5
 bgt.s L1b07e
 move.l d4,d0
 bsr.w L1cd7a
L1b0c2 moveq #0,d0
L1b0c4 movem.l -24(a5),a0/a2-a3/d1/d4-d5
 unlk a5
 rts 
L1b0ce link.w a5,#0
 movem.l a2-a3/d0,-(sp)
 movea.l d0,a2
L1b0d8 cmpi.b #58,(a2)+
 bne.s L1b0d8
 movea.l a2,a3
L1b0e0 addq.l #1,a2
 cmpi.b #58,(a2)
 bne.s L1b0e0
 clr.b (a2)
 move.l a3,d0
 movem.l -8(a5),a2-a3
 unlk a5
 rts 
L1b0f6 link.w a5,#0
 movem.l a2-a3/d0,-(sp)
 movea.l d0,a2
L1b100 cmpi.b #58,(a2)+
 bne.s L1b100
 movea.l a2,a3
 bra.s L1b10c
L1b10a addq.l #1,a2
L1b10c cmpi.b #13,(a2)
 bne.s L1b10a
 clr.b (a2)
 move.l a3,d0
 movem.l -8(a5),a2-a3
 unlk a5
 rts 
 move.l _0f672(a6),12131(sp)
 dc.w $7364
 dc.w $0
L1b12a movem.l a0/d1-d2,-(sp)
 move.l d1,d2
 movea.l 16(sp),a0
 move.w #48,d1
 os9 I$SetStt
 bcs.w L1b258
 move.l a0,d0
 bra.w L1b26a
L1b146 movem.l a0/d1-d2,-(sp)
 movea.l d1,a0
 move.w #45,d1
 bra.s L1b1b2
L1b152 movem.l a0/d1-d2,-(sp)
 move.w #49,d1
 bra.s L1b1b2
 movem.l a0/d1-d2,-(sp)
 move.l d1,d2
 movea.l 16(sp),a0
 move.w #50,d1
 bra.s L1b1b2
 movem.l a0/d1-d2,-(sp)
 move.w #51,d1
 bra.s L1b1b2
 movem.l a0/d1-d2,-(sp)
 move.w #52,d1
 bra.s L1b1b2
 movem.l a0/d1-d2,-(sp)
 move.l d1,d2
 move.w #53,d1
 bra.s L1b1b2
 movem.l a0/d1-d2,-(sp)
 move.w #56,d1
 bra.s L1b1b2
 movem.l a0/d1-d2,-(sp)
 move.w #57,d1
 bra.s L1b1b2
 movem.l a0/d1-d2,-(sp)
 move.w #55,d1
 bra.s L1b1b2
 movem.l a0/d1-d2,-(sp)
 move.w #54,d1
L1b1b2 os9 I$SetStt
 bcs.w L1b258
 bra.w L1b264
 movem.l a0/d1-d2,-(sp)
 movea.l d1,a0
 move.l 16(sp),d2
 move.w #47,d1
 os9 I$SetStt
 bcs.w L1b258
 move.l d1,d0
 bra.w L1b26a
 movem.l a0/d1-d2,-(sp)
 movea.l d1,a0
 move.l 16(sp),d2
 move.w #58,d1
 os9 I$SetStt
 bcs.w L1b258
 bra.w L1b264
 movem.l a0/d1-d2,-(sp)
 movea.l d1,a0
 move.w #0,d1
 os9 I$SetStt
 bcs.w L1b258
 bra.w L1b264
 movem.l a0/d1-d2,-(sp)
 move.w #145,d1
 bra.s L1b1b2
 movem.l a0/d1-d2,-(sp)
 movea.l d1,a0
 move.w #0,d1
 os9 I$GetStt
 bcs.s L1b258
 bra.s L1b264
 movem.l a0/d1-d2,-(sp)
 move.w #2,d1
L1b22e os9 I$GetStt
 bcs.s L1b258
 move.l d2,d0
 bra.s L1b26a
 movem.l a0/d1-d2,-(sp)
 movea.l d1,a0
 move.w #144,d1
 move.w 18(sp),d2
 os9 I$GetStt
 bcs.s L1b258
 bra.s L1b264
 movem.l a0/d1-d2,-(sp)
 move.w #5,d1
 bra.s L1b22e
L1b258 move.l d1,D0000c(a6)
 movem.l (sp)+,a0/d1-d2
 moveq #255,d0
 rts 
L1b264 move.l #0,d0
L1b26a bcs.s L1b258
 movem.l (sp)+,a0/d1-d2
 rts 
 movem.l a0/d1-d2,-(sp)
 move.w #6,d1
 os9 I$GetStt
 bcc.s L1b264
 cmpi.w #211,d1
 bne.s L1b258
 moveq #1,d0
 bra.s L1b26a
 movem.l a0/d1-d2,-(sp)
 movea.l d1,a0
 move.w #44,d1
 os9 I$GetStt
 bcs.s L1b258
 move.l a0,d0
 bra.s L1b26a
 movem.l d1-d7,-(sp)
 moveq #0,d2
L1b2a4 move.w d1,d3
 move.w 34(sp),d4
 move.w 38(sp),d5
 move.w 42(sp),d6
 move.w #60,d1
 os9 I$SetStt
 bcs.s L1b2c4
 moveq #0,d0
L1b2be movem.l (sp)+,d1-d7
 rts 
L1b2c4 moveq #255,d0
 move.l d1,D0000c(a6)
 bra.s L1b2be
 movem.l d1-d7,-(sp)
 moveq #1,d2
 move.w 46(sp),d7
 bra.s L1b2a4
 movem.l d1-d7,-(sp)
 moveq #2,d2
 bra.s L1b2a4
 movem.l a0-a1/d1-d4,-(sp)
 move.w d1,d3
 move.w #59,d1
 moveq #0,d2
 move.w 30(sp),d4
 movea.l 32(sp),a1
 os9 I$SetStt
 bcs.s L1b302
 move.l a0,(a1)
L1b2fc movem.l (sp)+,a0-a1/d1-d4
 rts 
L1b302 moveq #255,d0
 move.l d1,D0000c(a6)
 bra.s L1b2fc
 movem.l a0/d1-d4,-(sp)
 moveq #1,d2
 movea.l 24(sp),a0
L1b314 move.w d1,d3
 move.w #59,d1
 os9 I$SetStt
 bcs.s L1b328
 moveq #0,d0
L1b322 movem.l (sp)+,a0/d1-d4
 rts 
L1b328 moveq #255,d0
 move.l d1,D0000c(a6)
 bra.s L1b322
 movem.l a0/d1-d4,-(sp)
 moveq #2,d2
 bra.s L1b314
 movem.l a0/d1-d4,-(sp)
 moveq #3,d2
 movea.l 24(sp),a0
 bra.s L1b314
 movem.l a0/d1-d4,-(sp)
 moveq #4,d2
 bra.s L1b314
 movem.l a0/d1-d3,-(sp)
 move.w d1,d3
 moveq #0,d2
 move.w #59,d1
 os9 I$GetStt
 bcs.s L1b366
 move.l a0,d0
L1b360 movem.l (sp)+,a0/d1-d3
 rts 
L1b366 move.l d1,D0000c(a6)
 moveq #0,d0
 bra.s L1b360
 movem.l a0/d1-d2,-(sp)
 movea.l d1,a0
 moveq #1,d2
 move.w #59,d1
 os9 I$GetStt
 bcs.s L1b388
 moveq #0,d0
L1b382 movem.l (sp)+,a0/d1-d2
 rts 
L1b388 moveq #255,d0
 move.l d1,D0000c(a6)
 bra.s L1b382
 movem.l d1-d3,-(sp)
 move.l d1,d3
 moveq #0,d2
 move.w #61,d1
 os9 I$SetStt
 bcs.s L1b3a6
 moveq #0,d0
 bra.s L1b3ac
L1b3a6 moveq #255,d0
 move.l d1,D0000c(a6)
L1b3ac movem.l (sp)+,d1-d3
 rts 
 movem.l d1-d5,-(sp)
 moveq #0,d2
L1b3b8 move.w 30(sp),d5
 move.w 26(sp),d4
 move.w d1,d3
 move.w #86,d1
 os9 I$SetStt
 bcs.s L1b3d2
L1b3cc movem.l (sp)+,d1-d5
 rts 
L1b3d2 moveq #255,d0
 move.l d1,D0000c(a6)
 bra.s L1b3cc
L1b3da movem.l d1-d5,-(sp)
 moveq #6,d2
 bra.s L1b3b8
 movem.l d1-d5,-(sp)
 moveq #3,d2
 bra.s L1b3b8
 movem.l d1-d5,-(sp)
 moveq #9,d2
 bra.s L1b3b8
 movem.l d1-d3,-(sp)
 moveq #11,d2
L1b3f8 move.w d1,d3
 move.w #86,d1
 os9 I$SetStt
 bcs.s L1b40c
 moveq #0,d0
L1b406 movem.l (sp)+,d1-d3
 rts 
L1b40c moveq #255,d0
 move.l d1,D0000c(a6)
 bra.s L1b406
 movem.l d1-d3,-(sp)
 moveq #5,d2
 bra.s L1b3f8
 movem.l d1-d3,-(sp)
 moveq #18,d2
 bra.s L1b3f8
 movem.l d1-d3,-(sp)
 moveq #15,d2
 bra.s L1b3f8
L1b42c movem.l d1-d3,-(sp)
 moveq #19,d2
 move.w d1,d3
 move.w #86,d1
 os9 I$SetStt
 bcs.s L1b40c
 movem.l (sp)+,d1-d3
 rts 
L1b444 movem.l d1-d6,-(sp)
 moveq #12,d2
L1b44a move.l 32(sp),d5
L1b44e move.w 30(sp),d4
 move.w d1,d3
 move.w #86,d1
 os9 I$SetStt
 bcs.s L1b466
 moveq #0,d0
L1b460 movem.l (sp)+,d1-d6
 rts 
L1b466 moveq #255,d0
 move.l d1,D0000c(a6)
 bra.s L1b460
L1b46e movem.l d1-d6,-(sp)
 moveq #13,d2
 move.w 38(sp),d6
 bra.s L1b44a
L1b47a movem.l d1-d6,-(sp)
 moveq #10,d2
 move.l 36(sp),d6
 bra.s L1b44a
L1b486 movem.l d1-d6,-(sp)
 moveq #4,d2
 bra.s L1b44a
 movem.l d1-d6,-(sp)
 moveq #17,d2
 bra.s L1b44e
 movem.l d1-d6,-(sp)
 moveq #14,d2
 bra.s L1b44e
 movem.l a0/d1-d7,-(sp)
 moveq #7,d2
L1b4a4 movea.l 52(sp),a0
L1b4a8 move.w 50(sp),d7
 move.w 46(sp),d6
L1b4b0 move.w 42(sp),d5
 move.w 38(sp),d4
 move.w d1,d3
 move.w #86,d1
 os9 I$SetStt
 bcs.s L1b4cc
 moveq #0,d0
L1b4c6 movem.l (sp)+,a0/d1-d7
 rts 
L1b4cc moveq #255,d0
 move.l d1,D0000c(a6)
 bra.s L1b4c6
 movem.l a0/d1-d7,-(sp)
 moveq #27,d2
 bra.s L1b4a4
 movem.l a0/d1-d7,-(sp)
 moveq #8,d2
 bra.s L1b4a4
 movem.l a0/d1-d7,-(sp)
 moveq #28,d2
 bra.s L1b4a4
 movem.l a0/d1-d7,-(sp)
 moveq #1,d2
 movea.l 44(sp),a0
 bra.s L1b4b0
 movem.l a0/d1-d7,-(sp)
 moveq #2,d2
 movea.l 44(sp),a0
 bra.s L1b4b0
L1b504 movem.l a0/d1-d7,-(sp)
 move.w #16,d2
 bra.s L1b4a8
 movem.l a0/d1-d2,-(sp)
 moveq #89,d1
 move.w #0,d2
 os9 I$GetStt
 bcs.s L1b546
 movea.l 0(sp),a0
 clr.l (a0)
 move.w d0,2(a0)
 movea.l 20(sp),a0
 move.w d1,d0
 ext.l d0
 move.l d0,(a0)
 swap d1
 ext.l d1
 movea.l 16(sp),a0
 clr.l (a0)
 move.l d1,(a0)
 moveq #0,d0
L1b540 movem.l (sp)+,a0/d1-d2
 rts 
L1b546 move.l d1,D0000c(a6)
 moveq #255,d0
 bra.s L1b540
L1b54e movem.l d1-d3,-(sp)
 moveq #3,d2
L1b554 move.w d1,d3
 swap d3
 move.w 18(sp),d3
 move.w #89,d1
 os9 I$SetStt
 bcs.s L1b56e
 moveq #0,d0
L1b568 movem.l (sp)+,d1-d3
 rts 
L1b56e move.l d1,D0000c(a6)
 moveq #255,d0
 bra.s L1b568
 movem.l d1-d3,-(sp)
 moveq #4,d2
 bra.s L1b554
 movem.l d1-d3,-(sp)
 moveq #6,d2
 bra.s L1b58c
L1b586 movem.l d1-d3,-(sp)
 moveq #0,d2
L1b58c move.w d1,d3
 swap d3
 move.w 18(sp),d3
 bra.s L1b5ae
L1b596 movem.l d1-d3,-(sp)
 moveq #1,d2
 bra.s L1b5ae
L1b59e movem.l d1-d3,-(sp)
 moveq #2,d2
 bra.s L1b5ae
 movem.l d1-d3,-(sp)
 move.l d1,d3
 moveq #4,d2
L1b5ae move.w #82,d1
 os9 I$SetStt
 bcs.s L1b5c0
 moveq #0,d0
L1b5ba movem.l (sp)+,d1-d3
 rts 
L1b5c0 move.l d1,D0000c(a6)
 moveq #255,d0
 bra.s L1b5ba
 movem.l a0/d1-d5,-(sp)
 move.w d1,d3
 swap d3
 move.w 30(sp),d3
 move.w 34(sp),d4
 swap d4
 move.w 38(sp),d4
 move.w 42(sp),d5
 movea.l 44(sp),a0
 moveq #3,d2
 move.w #82,d1
 os9 I$SetStt
 bcs.s L1b5fa
 moveq #0,d0
L1b5f4 movem.l (sp)+,a0/d1-d5
 rts 
L1b5fa move.l d1,D0000c(a6)
 moveq #255,d0
 bra.s L1b5f4
 movem.l d1-d3,-(sp)
 moveq #5,d2
 move.l d1,d3
 bra.s L1b5ae
L1b60c move.l a0,-(sp)
 movea.l d1,a0
 move.w #90,d1
 os9 I$SetStt
 bcs.s L1b620
 moveq #0,d0
L1b61c movea.l (sp)+,a0
 rts 
L1b620 move.l d1,D0000c(a6)
 moveq #255,d0
 bra.s L1b61c
L1b628 link.w a5,#0
 movem.l d1-d2,-(sp)
 move.w #67,d1
 os9 I$GetStt
 bcs.s L1b644
 move.l d2,d0
L1b63c movem.l (sp)+,d1-d2
 unlk a5
 rts 
L1b644 move.l d1,D0000c(a6)
 moveq #255,d0
 bra.s L1b63c
L1b64c link.w a5,#0
 movem.l a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 movea.l d1,a3
L1b658 move.b (a3)+,(a2)+
 bne.s L1b658
 move.b #32,-1(a2)
 move.l a2,d0
 movem.l -8(a5),a2-a3
 unlk a5
 rts 
L1b66e movem.l a0/a2,-(sp)
 os9 F$SRqMem
 bcs.s L1b684
 movea.l d1,a0
 move.l d0,(a0)
 move.l a2,d0
L1b67e movem.l (sp)+,a0/a2
 rts 
L1b684 moveq #255,d0
 move.l d1,D0000c(a6)
 bra.s L1b67e
L1b68c move.l a2,-(sp)
 movea.l d1,a2
 os9 F$SRtMem
 movea.l (sp)+,a2
 rts 
L1b698 link.w a5,#0
 movem.l a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l 28(sp),d4
 bra.s L1b6ac
L1b6aa move.b (a3)+,(a2)+
L1b6ac subq.w #1,d4
 bge.s L1b6aa
 move.l a2,d0
 movem.l -12(a5),a2-a3/d4
 unlk a5
 rts 
L1b6bc link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d7,-(sp)
 lea -12(sp),sp
 moveq #0,d0
 move.w d0,10(sp)
 move.w d0,4(sp)
 move.w d0,6(sp)
 moveq #0,d1
 move.w d0,d1
 move.l d1,d5
 move.l d1,d4
 move.l d1,d6
 movea.l 60(sp),a0
 move.l (a0),d0
 bsr.w L1be08
 addq.l #1,d0
 move.l d0,d7
 moveq #1,d0
 and.w d7,d0
 move.w d0,8(sp)
 move.l 60(sp),d0
 addq.l #4,d0
 movea.l d0,a3
 bra.s L1b70e
L1b700 move.l (a3),d0
 bsr.w L1be08
 add.l d0,d4
 addq.l #4,a3
 addq.w #1,6(sp)
L1b70e tst.l (a3)
 bne.s L1b700
 movea.l 64(sp),a3
 bra.s L1b726
L1b718 move.l (a3),d0
 bsr.w L1be08
 add.l d0,d5
 addq.l #4,a3
 addq.w #1,4(sp)
L1b726 tst.l (a3)
 bne.s L1b718
 moveq #0,d0
 move.w 6(sp),d0
 addq.l #1,d0
 add.l d0,d4
 moveq #0,d0
 move.w 4(sp),d0
 add.l d0,d5
 addq.w #1,6(sp)
 move.l d4,d0
 add.l d5,d0
 btst.l #0,d0
 beq.s L1b74e
 addq.w #1,10(sp)
L1b74e move.l d4,d0
 add.l d5,d0
 moveq #0,d1
 move.w 10(sp),d1
 add.l d1,d0
 addq.l #6,d0
 add.l d7,d0
 moveq #0,d1
 move.w 8(sp),d1
 add.l d1,d0
 addq.l #2,d0
 moveq #0,d1
 move.w 6(sp),d1
 lsl.l #2,d1
 add.l d1,d0
 moveq #0,d1
 move.w 4(sp),d1
 lsl.l #2,d1
 add.l d1,d0
 addq.l #8,d0
 move.l d0,d6
 lea D007c6(a6),a0
 move.l a0,d1
 move.l d6,d0
 bsr.w L1b66e
 movea.l d0,a4
 movea.l d0,a2
 moveq #255,d1
 cmp.l d0,d1
 bne.s L1b79c
 moveq #255,d0
 bra.w L1b966
L1b79c move.l 60(sp),d0
 addq.l #4,d0
 movea.l d0,a3
 bra.s L1b7b2
L1b7a6 move.l (a3),d1
 move.l a2,d0
 bsr.w L1b64c
 movea.l d0,a2
 addq.l #4,a3
L1b7b2 tst.l (a3)
 bne.s L1b7a6
 cmpi.w #1,6(sp)
 bls.s L1b7c2
 clr.b -1(a2)
L1b7c2 move.b #13,(a2)+
 tst.w 10(sp)
 beq.s L1b7ce
 clr.b (a2)+
L1b7ce movea.l 64(sp),a3
 bra.s L1b7e0
L1b7d4 move.l (a3),d1
 move.l a2,d0
 bsr.w L1b64c
 movea.l d0,a2
 addq.l #4,a3
L1b7e0 tst.l (a3)
 bne.s L1b7d4
 clr.b -1(a2)
 move.l #64513,(sp)
 pea (L00002).w
 lea 6(sp),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L1b698
 addq.l #4,sp
 movea.l d0,a2
 move.l d4,d0
 add.l d5,d0
 moveq #0,d1
 move.w 10(sp),d1
 add.l d1,d0
 addq.l #6,d0
 move.l d0,(sp)
 pea (L00004).w
 lea 4(sp),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L1b698
 addq.l #4,sp
 movea.l d0,a2
 movea.l 60(sp),a0
 move.l (a0),d1
 move.l a2,d0
 bsr.w L1b64c
 movea.l d0,a2
 clr.b -1(a2)
 tst.w 8(sp)
 beq.s L1b840
 clr.b (a2)+
L1b840 clr.b (a2)+
 move.b #13,(a2)+
 clr.l (sp)
 pea (L00004).w
 lea 4(sp),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L1b698
 addq.l #4,sp
 movea.l d0,a2
 move.l 60(sp),d0
 addq.l #4,d0
 movea.l d0,a3
 bra.s L1b886
L1b866 pea (L00004).w
 lea 4(sp),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L1b698
 addq.l #4,sp
 movea.l d0,a2
 move.l (a3),d0
 bsr.w L1be08
 addq.l #1,d0
 add.l d0,(sp)
 addq.l #4,a3
L1b886 tst.l (a3)
 bne.s L1b866
 clr.l (sp)
 pea (L00004).w
 lea 4(sp),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L1b698
 addq.l #4,sp
 movea.l d0,a2
 moveq #0,d0
 move.w 10(sp),d0
 add.l d4,d0
 move.l d0,(sp)
 movea.l 64(sp),a3
 bra.s L1b8d0
L1b8b0 pea (L00004).w
 lea 4(sp),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L1b698
 addq.l #4,sp
 movea.l d0,a2
 move.l (a3),d0
 bsr.w L1be08
 addq.l #1,d0
 add.l d0,(sp)
 addq.l #4,a3
L1b8d0 tst.l (a3)
 bne.s L1b8b0
 clr.l (sp)
 pea (L00004).w
 lea 4(sp),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L1b698
 addq.l #4,sp
 movea.l d0,a2
 suba.l a2,a2
 clr.w 10(sp)
L1b8f0 lea -52(a5),sp
 movea.w 78(sp),a0
 move.l a0,-(sp)
 movea.w 78(sp),a0
 move.l a0,-(sp)
 move.l 76(sp),-(sp)
 clr.l -(sp)
 clr.l -(sp)
 pea (a4)
 move.l d6,d1
 move.l 40(sp),d0
 movea.l 36(sp),a0
 jsr (a0)
 lea 24(sp),sp
 move.l d0,(sp)
 moveq #255,d1
 cmp.l d0,d1
 bne.s L1b950
 cmpi.l #216,D0000c(a6)
 bne.s L1b950
 move.w 10(sp),d0
 addq.w #1,10(sp)
 tst.w d0
 bne.s L1b950
 clr.l -(sp)
 moveq #0,d1
 move.l 20(sp),d0
 bsr.w L1b974
 addq.l #4,sp
 movea.l d0,a2
 moveq #255,d1
 cmp.l d0,d1
 bne.s L1b8f0
 suba.l a2,a2
L1b950 move.l a2,d0
 beq.s L1b95a
 move.l a2,d0
 bsr.w L1d230
L1b95a move.l a4,d1
 move.l D007c6(a6),d0
 bsr.w L1b68c
 move.l (sp),d0
L1b966 lea 12(sp),sp
 movem.l -32(a5),a0/a2-a4/d4-d7
 unlk a5
 rts 
L1b974 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 movea.l 48(sp),a3
 lea -256(sp),sp
 moveq #0,d7
 move.l a3,d0
 bne.s L1b98e
 lea (sp),a3
L1b98e movea.w 262(sp),a0
 move.l a0,d1
 move.l a2,d0
 bsr.w L1d21a
 move.l d0,d5
 moveq #255,d1
 cmp.l d0,d1
 bne.w L1ba42
 cmpi.l #216,D0000c(a6)
 bne.w L1ba3e
 cmpi.b #47,(a2)
 beq.w L1ba3e
 lea L1ba5a(pc),a0
 move.l a0,d0
 bsr.w L1ba96
 movea.l d0,a4
 tst.l d0
 beq.w L1ba3e
L1b9ca moveq #58,d1
 move.l a4,d0
 bsr.w L1bf18
 move.l d0,d4
 beq.s L1b9de
 move.l d4,d0
 addq.l #1,d4
 sub.l a4,d0
 bra.s L1b9e4
L1b9de move.l a4,d0
 bsr.w L1be08
L1b9e4 move.l d0,d6
 move.l d6,-(sp)
 move.l a4,d1
 move.l a3,d0
 bsr.w L1be76
 addq.l #4,sp
 move.l d6,d0
 addq.l #1,d6
 move.b #47,(a3,d0.l)
 clr.b (a3,d6.l)
 move.l a2,d1
 move.l a3,d0
 bsr.w L1be42
 movea.w 262(sp),a0
 move.l a0,d1
 move.l a3,d0
 bsr.w L1d21a
 move.l d0,d5
 moveq #255,d1
 cmp.l d0,d1
 beq.s L1ba20
 addq.l #1,d7
 bra.s L1ba36
L1ba20 cmpi.l #216,D0000c(a6)
 beq.s L1ba2c
 moveq #0,d4
L1ba2c movea.l d4,a4
 move.l a4,d0
 beq.s L1ba36
 tst.l d7
 beq.s L1b9ca
L1ba36 move.l a4,d0
 bne.s L1ba4a
 tst.l d7
 bne.s L1ba4a
L1ba3e clr.b (a3)
 bra.s L1ba4a
L1ba42 move.l a2,d1
 move.l a3,d0
 bsr.w L1be26
L1ba4a move.l d5,d0
 lea 256(sp),sp
 movem.l -32(a5),a0/a2-a4/d4-d7
 unlk a5
 rts 
L1ba5a addq.w #8,d1
 addq.w #2,a0
 dc.w $0
L1ba60 link.w a5,#0
 movem.l a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 bra.s L1ba74
L1ba6e cmpi.b #61,(a2)+
 beq.s L1ba86
L1ba74 move.b (a2),d0
 cmp.b (a3)+,d0
 beq.s L1ba6e
 tst.b (a2)
 bne.s L1ba8a
 cmpi.b #61,-1(a3)
 bne.s L1ba8a
L1ba86 move.l a3,d0
 bra.s L1ba8c
L1ba8a moveq #0,d0
L1ba8c movem.l -8(a5),a2-a3
 unlk a5
 rts 
L1ba96 link.w a5,#0
 movem.l a2-a4/d0-d1,-(sp)
 movea.l d0,a2
 movea.l _00b6a(a6),a3
 bra.s L1bab6
L1baa6 move.l (a3)+,d1
 move.l a2,d0
 bsr.s L1ba60
 movea.l d0,a4
 tst.l d0
 beq.s L1bab6
 move.l a4,d0
 bra.s L1babc
L1bab6 tst.l (a3)
 bne.s L1baa6
 moveq #0,d0
L1babc movem.l -16(a5),a2-a4/d1
 unlk a5
 rts 
L1bac6 link.w a5,#0
 movem.l a0/a2/d0-d1,-(sp)
 lea -132(sp),sp
 move.l #129,d1
 move.l 132(sp),d0
 bsr.w L1cd64
 move.l d0,(sp)
 moveq #255,d1
 cmp.l d0,d1
 beq.s L1bafe
 move.l #268,d0
 bsr.w L1c372
 movea.l d0,a2
 tst.l d0
 bne.s L1bb02
 move.l (sp),d0
L1bafa bsr.w L1cd7a
L1bafe moveq #0,d0
 bra.s L1bb1e
L1bb02 move.l (sp),(a2)
 lea 4(sp),a0
 move.l a0,d1
 move.l (a2),d0
 bsr.w L1cbba
 move.b 4(sp),d0
 ext.w d0
 ext.l d0
 move.l d0,4(a2)
 move.l a2,d0
L1bb1e lea 132(sp),sp
 movem.l -12(a5),a0/a2/d1
 unlk a5
 rts 
L1bb2c link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 lea -66(sp),sp
 moveq #5,d0
 cmp.l 4(a2),d0
 bne.w L1bbda
 pea (L00021).w
 lea 36(sp),a0
 move.l a0,d1
 move.l (a2),d0
 bsr.w L1ce5e
 addq.l #4,sp
 tst.l d0
 ble.w L1bbfc
 moveq #12,d0
 add.l a2,d0
 movea.l d0,a3
 move.l 38(sp),(a3)
 moveq #0,d0
 move.b 64(sp),d0
 move.l d0,-(sp)
 move.l a3,d0
 addq.l #8,d0
 move.l d0,d1
 move.l (a2),d0
 bsr.w L1ce5e
 addq.l #4,sp
 tst.l d0
 bgt.s L1bba6
 bra.w L1bbfc
L1bb84 moveq #46,d0
 move.b d0,9(a3)
 move.b d0,8(a3)
 clr.b 10(a3)
 bra.s L1bbb8
L1bb94 move.b #46,8(a3)
L1bb9a moveq #0,d0
 move.b 64(sp),d0
 clr.b 8(a3,d0.l)
 bra.s L1bbb8
L1bba6 move.b 8(a3),d0
 ext.w d0
 tst.w d0
 beq.s L1bb94
 cmpi.w #1,d0
 beq.s L1bb84
 bra.s L1bb9a
L1bbb8 pea (L00001).w
 moveq #0,d0
 move.b 68(sp),d0
 moveq #0,d1
 move.b 36(sp),d1
 sub.w d0,d1
 ext.l d1
 moveq #33,d0
 sub.l d0,d1
 move.l (a2),d0
 bsr.w L1cec8
 addq.l #4,sp
L1bbd8 bra.s L1bc42
L1bbda pea (L00020).w
 lea 4(sp),a0
 move.l a0,d1
 move.l (a2),d0
 bsr.w L1ce5e
 addq.l #4,sp
 move.l d0,d4
 moveq #32,d1
 cmp.l d0,d1
 bne.s L1bbf8
 tst.b (sp)
 beq.s L1bbda
L1bbf8 tst.l d4
 bgt.s L1bc00
L1bbfc moveq #0,d0
 bra.s L1bc44
L1bc00 moveq #12,d0
 add.l a2,d0
 movea.l d0,a3
 move.b 29(sp),d0
 ext.w d0
 andi.w #$00ff,d0
 ext.l d0
 moveq #16,d1
 lsl.l d1,d0
 move.b 30(sp),d1
 ext.w d1
 andi.w #$00ff,d1
 ext.l d1
 lsl.l #8,d1
 or.l d1,d0
 move.b 31(sp),d1
 ext.w d1
 andi.w #$00ff,d1
 ext.l d1
 or.l d1,d0
 move.l d0,(a3)
 lea (sp),a0
 move.l a0,d1
 move.l a3,d0
 addq.l #8,d0
 bsr.w L1bcd0
L1bc42 move.l a3,d0
L1bc44 lea 66(sp),sp
 movem.l -20(a5),a0/a2-a3/d1/d4
 unlk a5
 rts 
 link.w a5,#0
 movem.l a2/d0-d1,-(sp)
 movea.l d0,a2
 pea (L00001).w
 moveq #0,d1
 move.l (a2),d0
 bsr.w L1cec8
 addq.l #4,sp
 movem.l -8(a5),a2/d1
 unlk a5
 rts 
L1bc74 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 clr.l -(sp)
 move.l 8(sp),d1
 movea.l 4(sp),a0
 move.l (a0),d0
 bsr.w L1cec8
 addq.l #4,sp
 movem.l -4(a5),a0
 unlk a5
 rts 
 link.w a5,#0
 movem.l d0-d1,-(sp)
 moveq #0,d1
 move.l (sp),d0
 bsr.s L1bc74
 movem.l -4(a5),d1
 unlk a5
 rts 
L1bcb0 link.w a5,#0
 movem.l a2/d0,-(sp)
 movea.l d0,a2
 move.l (a2),d0
 bsr.w L1cd7a
 move.l a2,d0
 bsr.w L1c5b4
 movem.l -4(a5),a2
 unlk a5
 rts 
L1bcd0 link.w a5,#0
 movem.l a2-a4/d0-d1,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 movea.l a2,a4
L1bcde move.b (a3)+,d0
 move.b d0,(a4)+
 bgt.s L1bcde
 andi.b #$7f,-1(a4)
 clr.b (a4)
 move.l a2,d0
 movem.l -12(a5),a2-a4
 unlk a5
 rts 
L1bcf8 link.w a5,#0
 movem.l a2-a3/d0-d1/d4,-(sp)
 move.l d0,d4
 movea.l d1,a2
 movea.l 28(sp),a3
 move.l d4,d0
 subq.l #1,d0
 adda.l d0,a2
 bra.s L1bd22
L1bd10 move.l a3,d1
 move.l a2,d0
 addq.l #1,a2
 bsr.s L1bd6e
 tst.l d0
 beq.s L1bd20
 move.l d4,d0
 bra.s L1bd28
L1bd20 addq.l #1,d4
L1bd22 tst.b (a2)
 bne.s L1bd10
 moveq #0,d0
L1bd28 movem.l -12(a5),a2-a3/d4
 unlk a5
 rts 
 link.w a5,#0
 movem.l a2-a3/d0-d1/d4,-(sp)
 move.l d0,d4
 movea.l d1,a2
 movea.l 28(sp),a3
 move.l d4,d0
 subq.l #1,d0
 adda.l d0,a2
 bra.s L1bd5c
L1bd4a move.l a3,d1
 move.l a2,d0
 addq.l #1,a2
 bsr.s L1bd6e
 tst.l d0
 beq.s L1bd5a
 move.l d4,d0
 bra.s L1bd64
L1bd5a addq.l #1,d4
L1bd5c cmp.l 32(sp),d4
 ble.s L1bd4a
 moveq #0,d0
L1bd64 movem.l -12(a5),a2-a3/d4
 unlk a5
 rts 
L1bd6e link.w a5,#0
 movem.l a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 bra.s L1bd84
L1bd7c cmpm.b (a3)+,(a2)+
 beq.s L1bd84
 moveq #0,d0
 bra.s L1bd8a
L1bd84 tst.b (a3)
 bne.s L1bd7c
 moveq #1,d0
L1bd8a movem.l -8(a5),a2-a3
 unlk a5
 rts 
L1bd94 move.l a0,-(sp)
 movea.l d0,a0
 eor.b d1,d0
 btst.l #0,d0
 bne.s L1bdf2
 btst.l #0,d1
 exg d1,a1
 beq.s L1bdc0
 cmpm.b (a1)+,(a0)+
 bcs.s L1bddc
 bhi.s L1bdce
 tst.b -1(a0)
 bne.s L1bdc0
 bra.s L1bdea
L1bdb6 tst.b d0
 beq.s L1bdea
 cmpi.w #255,d0
 bls.s L1bdea
L1bdc0 move.w (a0)+,d0
 cmp.w (a1)+,d0
 beq.s L1bdb6
 bcs.s L1bdd6
 cmpi.w #255,d0
 bls.s L1bde4
L1bdce moveq #1,d0
 movea.l (sp)+,a0
 exg d1,a1
 rts 
L1bdd6 cmpi.w #255,d0
 bls.s L1bde4
L1bddc moveq #255,d0
 movea.l (sp)+,a0
 exg d1,a1
 rts 
L1bde4 tst.b -2(a1)
 bne.s L1bddc
L1bdea moveq #0,d0
 movea.l (sp)+,a0
 exg d1,a1
 rts 
L1bdf2 exg d1,a1
 moveq #0,d0
L1bdf6 move.b (a0)+,d0
 cmp.b (a1)+,d0
 dbne d0,L1bdf6
 bcs.s L1bddc
 addq.w #1,d0
 movea.l (sp)+,a0
 exg d1,a1
 rts 
L1be08 move.l a0,-(sp)
 movea.l d0,a0
L1be0c tst.b (a0)+
 beq.s L1be1c
 tst.b (a0)+
 beq.s L1be1c
 tst.b (a0)+
 beq.s L1be1c
 tst.b (a0)+
 bne.s L1be0c
L1be1c suba.l d0,a0
 move.l a0,d0
 subq.l #1,d0
 movea.l (sp)+,a0
 rts 
L1be26 move.l a0,-(sp)
 movea.l d0,a0
 exg d1,a1
L1be2c move.b (a1)+,(a0)+
 beq.s L1be3c
 move.b (a1)+,(a0)+
 beq.s L1be3c
 move.b (a1)+,(a0)+
 beq.s L1be3c
 move.b (a1)+,(a0)+
 bne.s L1be2c
L1be3c movea.l (sp)+,a0
 exg d1,a1
 rts 
L1be42 move.l a0,-(sp)
 movea.l d0,a0
 exg d1,a1
L1be48 tst.b (a0)+
 beq.s L1be58
 tst.b (a0)+
 beq.s L1be58
 tst.b (a0)+
 beq.s L1be58
 tst.b (a0)+
 bne.s L1be48
L1be58 move.b (a1)+,-1(a0)
 bne.s L1be2c
 bra.s L1be3c
 move.l a0,-(sp)
 movea.l d0,a0
 exg d1,a1
L1be66 move.b (a1)+,(a0)+
 bpl.s L1be66
 clr.b (a0)
 andi.b #$7f,-(a0)
 movea.l (sp)+,a0
 exg d1,a1
 rts 
L1be76 link.w a5,#0
 movem.l a2-a4/d0-d1/d4,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l 32(sp),d4
 movea.l a2,a4
L1be88 subq.l #1,d4
 blt.s L1be94
 move.b (a3)+,(a4)+
 bne.s L1be88
 bra.s L1be94
L1be92 clr.b (a4)+
L1be94 subq.l #1,d4
 bge.s L1be92
 move.l a2,d0
 movem.l -16(a5),a2-a4/d4
 unlk a5
 rts 
 link.w a5,#0
 movem.l a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l 28(sp),d4
 bra.s L1bebc
L1beb6 tst.b (a3)+
 beq.s L1beca
 addq.l #1,a2
L1bebc subq.l #1,d4
 blt.s L1bec6
 move.b (a2),d0
 cmp.b (a3),d0
 beq.s L1beb6
L1bec6 tst.l d4
 bge.s L1bece
L1beca moveq #0,d0
 bra.s L1bedc
L1bece move.b (a3),d0
 ext.w d0
 move.b (a2),d1
 ext.w d1
 sub.w d0,d1
 ext.l d1
 move.l d1,d0
L1bedc movem.l -12(a5),a2-a3/d4
 unlk a5
 rts 
 link.w a5,#0
 movem.l a2-a4/d0-d1/d4,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l 32(sp),d4
 movea.l a2,a4
L1bef8 tst.b (a4)+
 bne.s L1bef8
 subq.l #1,a4
L1befe subq.l #1,d4
 blt.s L1bf06
 move.b (a3)+,(a4)+
 bne.s L1befe
L1bf06 tst.l d4
 bge.s L1bf0c
 clr.b (a4)
L1bf0c move.l a2,d0
 movem.l -16(a5),a2-a4/d4
 unlk a5
 rts 
L1bf18 link.w a5,#0
 movem.l a2/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
L1bf24 cmp.b (a2),d4
 bne.s L1bf2c
 move.l a2,d0
 bra.s L1bf32
L1bf2c tst.b (a2)+
 bne.s L1bf24
 moveq #0,d0
L1bf32 movem.l -8(a5),a2/d4
 unlk a5
 rts 
 link.w a5,#0
 movem.l a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
 suba.l a3,a3
L1bf4a cmp.b (a2),d4
 bne.s L1bf50
 movea.l a2,a3
L1bf50 tst.b (a2)+
 bne.s L1bf4a
 move.l a3,d0
 movem.l -12(a5),a2-a3/d4
 unlk a5
 rts 
L1bf60 link.w a5,#0
 movem.l a2/d0-d1,-(sp)
 movea.l d0,a2
 pea (L0000a).w
 moveq #0,d1
 move.l a2,d0
 bsr.w L1bf82
 addq.l #4,sp
 movem.l -8(a5),a2/d1
 unlk a5
 rts 
L1bf82 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4-d6,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l 40(sp),d4
 moveq #0,d5
 moveq #0,d6
L1bf96 move.b (a2)+,d0
 ext.w d0
 ext.l d0
 lea _015e5(a6),a0
 move.b (a0,d0.l),d0
 ext.w d0
 btst.l #4,d0
 bne.s L1bf96
 bra.s L1bfb4
L1bfae addq.l #1,d5
L1bfb0 addq.l #1,a2
 bra.s L1bfc4
L1bfb4 move.b -(a2),d0
 ext.w d0
 cmpi.w #43,d0
 beq.s L1bfb0
 cmpi.w #45,d0
 beq.s L1bfae
L1bfc4 clr.l D0000c(a6)
 move.l d4,-(sp)
 move.l a3,d1
 move.l a2,d0
 bsr.w L1c028
 addq.l #4,sp
 move.l d0,d6
 cmpi.l #256,D0000c(a6)
 beq.s L1bff4
 tst.l d5
 beq.s L1bfec
 cmpi.l #-2147483648,d6
 bhi.s L1bff4
L1bfec cmpi.l #2147483647,d6
 bls.s L1c012
L1bff4 tst.l d5
 beq.s L1c000
 move.l #-2147483648,d0
 bra.s L1c006
L1c000 move.l #2147483647,d0
L1c006 move.l d0,d6
 move.l #256,D0000c(a6)
 bra.s L1c01c
L1c012 tst.l d5
 beq.s L1c01c
 move.l d6,d0
 neg.l d0
 move.l d0,d6
L1c01c move.l d6,d0
 movem.l -24(a5),a0/a2-a3/d4-d6
 unlk a5
 rts 
L1c028 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 movea.l d1,a3
 move.l 44(sp),d4
 moveq #0,d5
 moveq #0,d6
L1c03c move.b (a2)+,d0
 ext.w d0
 ext.l d0
 lea _015e5(a6),a0
 move.b (a0,d0.l),d0
 ext.w d0
 btst.l #4,d0
 bne.s L1c03c
 subq.l #1,a2
 move.l a3,d0
 beq.s L1c05a
 move.l a2,(a3)
L1c05a moveq #2,d0
 cmp.l d4,d0
 bls.s L1c064
 tst.l d4
 bne.s L1c08e
L1c064 moveq #35,d0
 cmp.l d4,d0
 bcs.s L1c08e
 bra.s L1c0a2
L1c06c addq.l #1,d5
L1c06e addq.l #1,a2
L1c070 cmpi.b #120,1(a2)
 beq.s L1c080
 cmpi.b #88,1(a2)
 bne.s L1c098
L1c080 tst.l d4
 bne.s L1c088
 moveq #16,d4
 bra.s L1c094
L1c088 moveq #16,d0
 cmp.l d4,d0
 beq.s L1c094
L1c08e moveq #0,d0
 bra.w L1c1aa
L1c094 addq.l #2,a2
 bra.s L1c0be
L1c098 tst.l d4
 bne.s L1c0be
 moveq #8,d4
 addq.l #1,a2
 bra.s L1c0be
L1c0a2 move.b (a2),d0
 ext.w d0
 cmpi.w #255,d0
 bhi.s L1c0be
 cmpi.b #43,d0
 beq.s L1c06e
 cmpi.b #45,d0
 beq.s L1c06c
 cmpi.b #48,d0
 beq.s L1c070
L1c0be tst.l d4
 bne.s L1c0c4
 moveq #10,d4
L1c0c4 moveq #10,d0
 cmp.l d4,d0
 bcs.w L1c14a
 bra.s L1c0f6
L1c0ce moveq #255,d0
 sub.l d7,d0
 move.l d4,d1
 bsr.w L1cab2
 cmp.l d6,d0
 bcs.s L1c0ea
 move.l d6,d0
 move.l d4,d1
 bsr.w L1ca40
 add.l d7,d0
 move.l d0,d6
 bra.s L1c0f4
L1c0ea move.l #256,D0000c(a6)
 moveq #255,d6
L1c0f4 addq.l #1,a2
L1c0f6 move.b (a2),d0
 ext.w d0
 ext.l d0
 lea _015e5(a6),a0
 move.b (a0,d0.l),d0
 ext.w d0
 btst.l #3,d0
 beq.w L1c198
 move.b (a2),d0
 ext.w d0
 subi.w #48,d0
 ext.l d0
 move.l d0,d7
 cmp.l d4,d0
 bcs.s L1c0ce
 bra.w L1c198
L1c122 moveq #255,d0
 sub.l d7,d0
 move.l d4,d1
 bsr.w L1cab2
 cmp.l d6,d0
 bcs.s L1c13e
 move.l d6,d0
 move.l d4,d1
 bsr.w L1ca40
 add.l d7,d0
 move.l d0,d6
 bra.s L1c148
L1c13e move.l #256,D0000c(a6)
 moveq #255,d6
L1c148 addq.l #1,a2
L1c14a move.b (a2),d0
 ext.w d0
 ext.l d0
 lea _015e5(a6),a0
 move.b (a0,d0.l),d0
 ext.w d0
 btst.l #3,d0
 beq.s L1c16e
 move.b (a2),d0
 ext.w d0
 subi.w #48,d0
 ext.l d0
 move.l d0,d7
 bra.s L1c122
L1c16e move.b (a2),d0
 ext.w d0
 ext.l d0
 lea _015e5(a6),a0
 move.b (a0,d0.l),d0
 ext.w d0
 andi.w #$0006,d0
 beq.s L1c198
 move.b (a2),d0
 ext.w d0
 andi.w #$00df,d0
 ext.l d0
 moveq #55,d1
 sub.l d1,d0
 move.l d0,d7
 cmp.l d4,d0
 bcs.s L1c122
L1c198 move.l a3,d0
 beq.s L1c19e
 move.l a2,(a3)
L1c19e tst.l d5
 beq.s L1c1a8
 move.l d6,d0
 neg.l d0
 move.l d0,d6
L1c1a8 move.l d6,d0
L1c1aa movem.l -28(a5),a0/a2-a3/d4-d7
 unlk a5
 rts 
 link.w a5,#0
 movem.l d0,-(sp)
 move.w #65,D007d6(a6)
 clr.w D007d8(a6)
 move.w #2,D007f2(a6)
 move.w #1,D007f4(a6)
 move.w #2,D0080e(a6)
 move.w #2,D00810(a6)
 unlk a5
 rts 
L1c1e2 link.w a5,#0
 movem.l a2-a4/d0-d1,-(sp)
 movea.l d0,a2
 lea _015d4(a6),a4
 movea.l _015d4(a6),a3
 bra.s L1c25e
L1c1f6 move.l 4(a2),d0
 lsl.l #3,d0
 add.l a2,d0
 cmp.l a3,d0
 bne.s L1c232
 move.l a2,(a4)
 move.l (a3),(a2)
 move.l 4(a3),d0
 add.l d0,4(a2)
 moveq #8,d1
 move.l a3,d0
 bsr.w L1c69e
 move.l 4(a4),d0
 lsl.l #3,d0
 add.l a4,d0
 cmp.l a2,d0
 bne.s L1c266
 move.l 4(a2),d0
 add.l d0,4(a4)
 move.l (a2),(a4)
 moveq #8,d1
 move.l a3,d0
 bra.s L1c24a
L1c232 move.l 4(a3),d0
 lsl.l #3,d0
 add.l a3,d0
 cmp.l a2,d0
 bne.s L1c250
 move.l 4(a2),d0
 add.l d0,4(a3)
 moveq #8,d1
 move.l a2,d0
L1c24a bsr.w L1c69e
 bra.s L1c266
L1c250 cmpa.l a2,a3
 bcc.s L1c25a
 move.l a2,(a4)
 move.l a3,(a2)
 bra.s L1c266
L1c25a movea.l a3,a4
 movea.l (a3),a3
L1c25e move.l a3,d0
 bne.s L1c1f6
 move.l a2,(a4)
 clr.l (a2)
L1c266 movem.l -16(a5),a2-a4/d1
 unlk a5
 rts 
L1c270 link.w a5,#0
 movem.l a2/d0-d1/d4,-(sp)
 move.l d0,d4
 addq.l #1,d4
 cmp.l D00b4a(a6),d4
 bcc.s L1c286
 move.l D00b4a(a6),d4
L1c286 move.l d4,d0
 lsl.l #3,d0
 bsr.w L1d328
 movea.l d0,a2
 moveq #255,d1
 cmp.l d0,d1
 bne.s L1c29a
 moveq #0,d0
 bra.s L1c2be
L1c29a move.l D00b5a(a6),d0
 lsr.l #3,d0
 move.l d0,4(a2)
 move.l a2,d0
 bsr.w L1c1e2
 move.l D00b5a(a6),d0
 subq.l #8,d0
 move.l d0,d1
 move.l a2,d0
 addq.l #8,d0
 bsr.w L1c69e
 move.l _015dc(a6),d0
L1c2be movem.l -12(a5),a2/d1/d4
 unlk a5
 rts 
L1c2c8 link.w a5,#0
 movem.l a2-a3/d0/d4-d5,-(sp)
 move.l d0,d4
 move.l d4,d0
 addq.l #7,d0
 lsr.l #3,d0
 move.l d0,d5
 tst.l _015dc(a6)
 bne.s L1c2e2
 bsr.s L1c32e
L1c2e2 movea.l _015dc(a6),a3
 bra.s L1c300
L1c2e8 cmpa.l _015dc(a6),a2
 bne.s L1c2fe
 move.l d5,d0
 bsr.w L1c270
 movea.l d0,a2
 tst.l d0
 bne.s L1c2fe
 moveq #0,d0
 bra.s L1c324
L1c2fe movea.l a2,a3
L1c300 movea.l (a3),a2
 cmp.l 4(a2),d5
 bhi.s L1c2e8
 cmp.l 4(a2),d5
 bne.s L1c312
 move.l (a2),(a3)
 bra.s L1c31e
L1c312 sub.l d5,4(a2)
 move.l 4(a2),d0
 lsl.l #3,d0
 adda.l d0,a2
L1c31e move.l a3,_015dc(a6)
 move.l a2,d0
L1c324 movem.l -16(a5),a2-a3/d4-d5
 unlk a5
 rts 
L1c32e link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 subq.l #4,sp
 lea _015cc(a6),a0
 move.l a0,_015dc(a6)
 moveq #4,d1
 moveq #124,d0
 bsr.w L1d082
 bge.s L1c34c
 addq.l #7,d0
L1c34c asr.l #3,d0
 move.l d0,(sp)
 cmp.l _015e0(a6),d0
 bls.s L1c35a
 move.l (sp),_015e0(a6)
L1c35a move.l _015e0(a6),d0
 move.l d0,D00b4e(a6)
 move.l d0,D00b4a(a6)
 addq.l #4,sp
 movem.l -8(a5),a0/d1
 unlk a5
 rts 
L1c372 link.w a5,#0
 movem.l a2/d0/d4,-(sp)
 move.l d0,d4
 tst.l d4
 bne.s L1c384
 moveq #0,d0
 bra.s L1c3a6
L1c384 addq.l #8,d4
 move.l d4,d0
 bsr.w L1c2c8
 movea.l d0,a2
 tst.l d0
 beq.s L1c3a4
 move.l d4,d0
 addq.l #7,d0
 lsr.l #3,d0
 move.l d0,4(a2)
 move.l #-2023380019,(a2)
 addq.l #8,a2
L1c3a4 move.l a2,d0
L1c3a6 movem.l -8(a5),a2/d4
 unlk a5
 rts 
L1c3b0 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4-d7,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l 48(sp),d5
 lea -12(sp),sp
 move.l a2,d0
 bne.s L1c3d2
 move.l d4,d0
 bsr.w L1c2c8
 bra.w L1c50a
L1c3d2 tst.l d4
 bne.s L1c3e0
 move.l d5,d1
 move.l a2,d0
 bsr.w L1c57e
 bra.s L1c3ec
L1c3e0 move.l d5,d1
 move.l a2,d0
 bsr.w L1c72e
 tst.l d0
 bne.s L1c3f2
L1c3ec moveq #0,d0
 bra.w L1c50a
L1c3f2 movea.l a2,a3
 move.l d5,d0
 addq.l #7,d0
 lsr.l #3,d0
 move.l d0,d7
 move.l d4,d0
 addq.l #7,d0
 lsr.l #3,d0
 move.l d0,8(sp)
 cmp.l 8(sp),d7
 bcs.s L1c42e
 cmp.l 8(sp),d7
 bls.w L1c4a6
 move.l d7,d0
 sub.l 8(sp),d0
 lsl.l #3,d0
 move.l d0,d1
 move.l 8(sp),d0
 lsl.l #3,d0
 add.l a3,d0
 bsr.w L1c57e
 bra.w L1c4a6
L1c42e movea.l _015dc(a6),a4
 bra.s L1c436
L1c434 movea.l (a4),a4
L1c436 cmpa.l a4,a3
 bls.s L1c440
 cmpa.l (a4),a3
 bcs.s L1c448
 bra.s L1c444
L1c440 cmpa.l (a4),a3
 bcc.s L1c434
L1c444 cmpa.l (a4),a4
 bcs.s L1c434
L1c448 move.l (a4),d6
 move.l d7,d0
 lsl.l #3,d0
 add.l a3,d0
 cmp.l d6,d0
 bne.s L1c4aa
 movea.l d6,a0
 move.l 4(a0),d0
 add.l d7,d0
 cmp.l 8(sp),d0
 bcs.s L1c4aa
 movea.l d6,a0
 move.l 4(a0),d0
 add.l d7,d0
 cmp.l 8(sp),d0
 bls.s L1c49e
 movea.l d6,a0
 move.l 8(sp),d0
 lsl.l #3,d0
 move.l (a0),(a3,d0.l)
 movea.l d6,a0
 move.l 4(a0),d0
 add.l d7,d0
 sub.l 8(sp),d0
 move.l 8(sp),d1
 lsl.l #3,d1
 move.l d0,4(a3,d1.l)
 move.l 8(sp),d0
 lsl.l #3,d0
 add.l a3,d0
 move.l d0,(a4)
 bra.s L1c4a2
L1c49e movea.l d6,a0
 move.l (a0),(a4)
L1c4a2 move.l a4,_015dc(a6)
L1c4a6 move.l a3,d0
 bra.s L1c50a
L1c4aa move.l (a3),(sp)
 move.l 4(a3),4(sp)
 move.l d5,d1
 move.l a3,d0
 bsr.w L1c69e
 movea.l d0,a4
 move.l d4,d0
 bsr.w L1c2c8
 move.l d0,d6
 beq.s L1c4fe
 movea.l d6,a0
 move.l (sp),(a0)
 move.l 4(sp),4(a0)
 move.l d7,d0
 subq.l #1,d0
 lsl.l #3,d0
 move.l d0,-(sp)
 move.l a3,d0
 addq.l #8,d0
 move.l d0,d1
 move.l d6,d0
 addq.l #8,d0
 bsr.w L1c870
 addq.l #4,sp
 move.l a4,d0
 beq.s L1c508
 cmpa.l d6,a4
 bcs.s L1c502
 move.l 8(sp),d0
 lsl.l #3,d0
 add.l d6,d0
 cmp.l a4,d0
 bhi.s L1c508
 bra.s L1c502
L1c4fe move.l a4,d0
 beq.s L1c508
L1c502 move.l a4,d0
 bsr.w L1c800
L1c508 move.l d6,d0
L1c50a lea 12(sp),sp
 movem.l -32(a5),a0/a2-a4/d4-d7
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l a2,d0
 bne.s L1c530
 move.l d4,d0
 bsr.w L1c372
 bra.s L1c574
L1c530 move.l a2,d0
 btst.l #0,d0
 bne.s L1c548
 move.l a2,d0
 subq.l #8,d0
 movea.l d0,a3
 movea.l d0,a0
 cmpi.l #-2023380019,(a0)
 beq.s L1c54c
L1c548 moveq #0,d0
 bra.s L1c574
L1c54c move.l 4(a3),d0
 lsl.l #3,d0
 move.l d0,-(sp)
 addq.l #8,d4
 move.l d4,d1
 move.l a3,d0
 bsr.w L1c3b0
 addq.l #4,sp
 movea.l d0,a3
 tst.l d0
 beq.s L1c572
 move.l d4,d0
 addq.l #7,d0
 lsr.l #3,d0
 move.l d0,4(a3)
 addq.l #8,a3
L1c572 move.l a3,d0
L1c574 movem.l -16(a5),a0/a2-a3/d4
 unlk a5
 rts 
L1c57e link.w a5,#0
 movem.l a2-a3/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
 move.l d4,d1
 move.l a2,d0
 bsr.w L1c72e
 tst.l d0
 beq.s L1c5aa
 move.l d4,d1
 move.l a2,d0
 bsr.w L1c69e
 movea.l d0,a3
 tst.l d0
 beq.s L1c5aa
 move.l a3,d0
 bsr.w L1c800
L1c5aa movem.l -12(a5),a2-a3/d4
 unlk a5
 rts 
L1c5b4 link.w a5,#0
 movem.l a0/a2-a3/d0-d1,-(sp)
 movea.l d0,a2
 move.l a2,d0
 beq.s L1c5e6
 move.l a2,d0
 btst.l #0,d0
 bne.s L1c5e6
 move.l a2,d0
 subq.l #8,d0
 movea.l d0,a3
 movea.l d0,a0
 cmpi.l #-2023380019,(a0)
 bne.s L1c5e6
 move.l 4(a3),d0
 lsl.l #3,d0
 move.l d0,d1
 move.l a3,d0
 bsr.s L1c57e
L1c5e6 movem.l -16(a5),a0/a2-a3/d1
 unlk a5
 rts 
 link.w a5,#0
 movem.l d0-d1/d4,-(sp)
 move.l d0,d4
 tst.l _015dc(a6)
 bne.s L1c604
 bsr.w L1c32e
L1c604 tst.l d4
 bge.s L1c612
 move.l #-2147483648,D00b4e(a6)
 bra.s L1c644
L1c612 tst.l d4
 bge.s L1c618
 addq.l #7,d4
L1c618 asr.l #3,d4
 cmp.l _015e0(a6),d4
 bcs.s L1c644
 move.l d4,d0
 add.l _015e0(a6),d0
 subq.l #1,d0
 move.l _015e0(a6),d1
 bsr.w L1cab2
 move.l d0,D00b4e(a6)
 move.l _015e0(a6),d0
 move.l D00b4e(a6),d1
 bsr.w L1ca40
 move.l d0,D00b4e(a6)
L1c644 movem.l -8(a5),d1/d4
 unlk a5
 rts 
 link.w a5,#0
 movem.l d0-d1/d4,-(sp)
 move.l d0,d4
 tst.l _015dc(a6)
 bne.s L1c662
 bsr.w L1c32e
L1c662 tst.l d4
 bge.s L1c668
 addq.l #7,d4
L1c668 asr.l #3,d4
 cmp.l _015e0(a6),d4
 bcs.s L1c694
 move.l d4,d0
 add.l _015e0(a6),d0
 subq.l #1,d0
 move.l _015e0(a6),d1
 bsr.w L1cab2
 move.l d0,D00b4a(a6)
 move.l _015e0(a6),d0
 move.l D00b4a(a6),d1
 bsr.w L1ca40
 move.l d0,D00b4a(a6)
L1c694 movem.l -8(a5),d1/d4
 unlk a5
 rts 
L1c69e link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
 movea.l a2,a4
 move.l d4,d0
 addq.l #7,d0
 lsr.l #3,d0
 move.l d0,d4
 movea.l _015dc(a6),a3
 bra.s L1c6bc
L1c6ba movea.l (a3),a3
L1c6bc cmpa.l a3,a2
 bls.s L1c6c6
 cmpa.l (a3),a2
 bcs.s L1c6ce
 bra.s L1c6ca
L1c6c6 cmpa.l (a3),a2
 bcc.s L1c6ba
L1c6ca cmpa.l (a3),a3
 bcs.s L1c6ba
L1c6ce move.l d4,d0
 lsl.l #3,d0
 add.l a2,d0
 cmp.l (a3),d0
 bne.s L1c6ea
 movea.l (a3),a0
 move.l 4(a0),d0
 add.l d4,d0
 move.l d0,4(a2)
 movea.l (a3),a0
 move.l (a0),(a2)
 bra.s L1c6f0
L1c6ea move.l d4,4(a2)
 move.l (a3),(a2)
L1c6f0 move.l 4(a3),d0
 lsl.l #3,d0
 add.l a3,d0
 cmp.l a2,d0
 bne.s L1c70a
 move.l 4(a2),d0
 add.l d0,4(a3)
 move.l (a2),(a3)
 movea.l a3,a4
 bra.s L1c70c
L1c70a move.l a2,(a3)
L1c70c move.l a3,_015dc(a6)
 move.l D00b4e(a6),d0
 subq.l #1,d0
 cmp.l 4(a4),d0
 bhi.s L1c720
 movea.l a4,a0
 bra.s L1c722
L1c720 suba.l a0,a0
L1c722 move.l a0,d0
 movem.l -20(a5),a0/a2-a4/d4
 unlk a5
 rts 
L1c72e link.w a5,#0
 movem.l a2-a4/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l d1,d4
 tst.l _015dc(a6)
 beq.s L1c778
 move.l a2,d0
 beq.s L1c778
 move.l a2,d0
 btst.l #0,d0
 bne.s L1c778
 move.l d4,d0
 addq.l #7,d0
 lsr.l #3,d0
 lsl.l #3,d0
 add.l a2,d0
 movea.l d0,a4
 movea.l _015d4(a6),a3
 bra.s L1c774
L1c75e cmpa.l a3,a2
 bls.s L1c772
 move.l 4(a3),d0
 lsl.l #3,d0
 add.l a3,d0
 cmp.l a4,d0
 bcs.s L1c772
 moveq #1,d0
 bra.s L1c77a
L1c772 movea.l (a3),a3
L1c774 move.l a3,d0
 bne.s L1c75e
L1c778 moveq #0,d0
L1c77a movem.l -16(a5),a2-a4/d4
 unlk a5
 rts 
 link.w a5,#0
 movem.l a2/d0-d2/d4-d6,-(sp)
 move.l d0,d4
 move.l d1,d5
 moveq #1,d1
 move.l d1,d2
 move.l d4,d0
 move.l d5,d1
 bsr.w L1ca40
 addq.l #8,d0
 move.l d0,d6
 move.l d2,d1
 bsr.s L1c7c8
 movea.l d0,a2
 tst.l d0
 beq.s L1c7bc
 move.l d6,d0
 addq.l #7,d0
 lsr.l #3,d0
 move.l d0,4(a2)
 move.l #-2023380019,(a2)
 addq.l #8,a2
L1c7bc move.l a2,d0
 movem.l -20(a5),a2/d2/d4-d6
 unlk a5
 rts 
L1c7c8 link.w a5,#0
 movem.l a2/d0-d1/d4-d6,-(sp)
 move.l d0,d4
 move.l d1,d5
 move.l d4,d0
 move.l d5,d1
 bsr.w L1ca40
 move.l d0,d6
 bsr.w L1c2c8
 movea.l d0,a2
 tst.l d0
 beq.s L1c7f4
 move.l d6,-(sp)
 moveq #0,d1
 move.l a2,d0
 bsr.w L1c98a
 addq.l #4,sp
L1c7f4 move.l a2,d0
 movem.l -16(a5),a2/d4-d6
 unlk a5
 rts 
L1c800 link.w a5,#0
 movem.l a0/a2-a4/d0-d1/d4,-(sp)
 movea.l d0,a2
 move.l 4(a2),d0
 addq.l #1,d0
 cmp.l -4(a2),d0
 bne.s L1c866
 move.l a2,d0
 subq.l #8,d0
 movea.l d0,a4
 lea _015d4(a6),a0
 move.l a0,d4
 movea.l _015d4(a6),a3
 bra.s L1c830
L1c828 cmpa.l a4,a3
 beq.s L1c834
 move.l a3,d4
 movea.l (a3),a3
L1c830 move.l a3,d0
 bne.s L1c828
L1c834 move.l a3,d0
 beq.s L1c866
 movea.l d4,a0
 move.l (a3),(a0)
 move.l _015dc(a6),d4
 bra.s L1c846
L1c842 movea.l d4,a0
 move.l (a0),d4
L1c846 movea.l d4,a0
 cmpa.l (a0),a2
 bne.s L1c842
 cmpa.l _015dc(a6),a2
 bne.s L1c856
 move.l d4,_015dc(a6)
L1c856 movea.l d4,a0
 move.l (a2),(a0)
 move.l a3,d1
 move.l 4(a3),d0
 lsl.l #3,d0
 bsr.w L1d342
L1c866 movem.l -24(a5),a0/a2-a4/d1/d4
 unlk a5
 rts 
L1c870 link.w a5,#0
 movem.l a0-a2/d0-d2,-(sp)
 movea.l d0,a0
 movea.l d1,a2
 move.l 8(a5),d2
 beq.s L1c884
 bsr.s L1c88e
L1c884 movem.l -24(a5),a0-a2/d0-d2
 unlk a5
 rts 
L1c88e tst.l d2
 beq.s L1c8dc
 cmpa.l a2,a0
 bhi.s L1c8de
 beq.s L1c8dc
 move.w a2,d0
 btst.l #0,d0
 beq.s L1c8a4
 move.b (a2)+,(a0)+
 subq.l #1,d2
L1c8a4 move.w a0,d0
 btst.l #0,d0
 bne.s L1c8d0
 lsr.l #1,d2
 bcc.s L1c8b6
 bsr.s L1c8b6
 move.b (a2)+,(a0)+
 rts 
L1c8b6 lsr.l #1,d2
 bcc.s L1c8c0
 move.w (a2)+,(a0)+
 bra.s L1c8c0
L1c8be move.l (a2)+,(a0)+
L1c8c0 dbf d2,L1c8be
 addq.w #1,d2
 subq.l #1,d2
 bcc.s L1c8be
 moveq #0,d2
 rts 
L1c8ce move.b (a2)+,(a0)+
L1c8d0 dbf d2,L1c8ce
 addq.w #1,d2
 subq.l #1,d2
 bcc.s L1c8ce
 moveq #0,d2
L1c8dc rts 
L1c8de adda.l d2,a2
 adda.l d2,a0
 move.w a2,d0
 btst.l #0,d0
 beq.s L1c8ee
 move.b -(a2),-(a0)
 subq.l #1,d2
L1c8ee move.w a0,d0
 btst.l #0,d0
 bne.s L1c91a
 lsr.l #1,d2
 bcc.s L1c900
 bsr.s L1c900
 move.b -(a2),-(a0)
 rts 
L1c900 lsr.l #1,d2
 bcc.s L1c90a
 move.w -(a2),-(a0)
 bra.s L1c90a
L1c908 move.l -(a2),-(a0)
L1c90a dbf d2,L1c908
 addq.w #1,d2
 subq.l #1,d2
 bcc.s L1c908
 moveq #0,d2
 rts 
L1c918 move.b -(a2),-(a0)
L1c91a dbf d2,L1c918
 addq.w #1,d2
 subq.l #1,d2
 bcc.s L1c918
 moveq #0,d2
 rts 
L1c928 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l (sp),d0
 lea _015e5(a6),a0
 move.b (a0,d0.l),d1
 ext.w d1
 btst.l #2,d1
 beq.s L1c94a
 andi.l #$000000df,d0
 bra.s L1c94c
L1c94a move.l (sp),d0
L1c94c movem.l -8(a5),a0/d1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d0-d1,-(sp)
 move.l (sp),d0
 lea _015e5(a6),a0
 move.b (a0,d0.l),d1
 ext.w d1
 btst.l #1,d1
 beq.s L1c976
 bset.l #5,d0
 bra.s L1c978
L1c976 move.l (sp),d0
L1c978 movem.l -8(a5),a0/d1
 unlk a5
 rts 
 tst.l d0
 bpl.s L1c988
 neg.l d0
L1c988 rts 
L1c98a link.w a5,#0
 movem.l a0/d0/d2,-(sp)
 movea.l d0,a0
 move.l 8(a5),d2
 cmpi.l #12,d2
 bcc.s L1c9b0
 subq.w #1,d2
 bcs.w L1ca36
L1c9a6 move.b d1,(a0)+
 dbf d2,L1c9a6
 bra.w L1ca36
L1c9b0 move.l d1,-(sp)
 asl.w #8,d1
 move.b 3(sp),d1
 addq.l #4,sp
 btst.l #0,d0
 beq.s L1c9c6
 move.b d1,(a0)+
 subq.l #1,d2
 move.l a0,d0
L1c9c6 btst.l #1,d0
 beq.s L1c9d0
 move.w d1,(a0)+
 subq.l #2,d2
L1c9d0 move.w d1,d0
 swap d1
 move.w d0,d1
 moveq #96,d0
 cmp.l d0,d2
 bcs.s L1ca1a
 move.l d2,d0
 and.w #31,d2
 eor.w d2,d0
 lea (a0,d0.l),a0
 movem.l a0-a2/d3-d7,-(sp)
 move.l d1,d3
 move.l d1,d4
 move.l d1,d5
 move.l d1,d6
 move.l d1,d7
 movea.l d1,a1
 movea.l d1,a2
 lsr.l #5,d0
 subq.l #1,d0
L1c9fe movem.l a1-a2/d1/d3-d7,-(a0)
 dbf d0,L1c9fe
 addq.w #1,d0
 subq.l #1,d0
 bcc.s L1c9fe
 movem.l (sp)+,a0-a2/d3-d7
 move.w d2,d0
 beq.s L1ca36
 lsr.w #2,d0
 bne.s L1ca1e
 bra.s L1ca26
L1ca1a move.w d2,d0
 lsr.w #2,d0
L1ca1e subq.w #1,d0
L1ca20 move.l d1,(a0)+
 dbf d0,L1ca20
L1ca26 btst.l #1,d2
 beq.s L1ca2e
 move.w d1,(a0)+
L1ca2e btst.l #0,d2
 beq.s L1ca36
 move.b d1,(a0)
L1ca36 movem.l -12(a5),a0/d0/d2
 unlk a5
 rts 
L1ca40 movem.l d2-d4,-(sp)
 move.l d0,d2
 move.l d0,d3
 swap d3
 move.l d1,d4
 swap d4
 mulu.w d1,d0
 mulu.w d3,d1
 mulu.w d4,d2
 mulu.w d4,d3
 swap d0
 add.w d1,d0
 moveq #0,d4
 addx.l d4,d3
 add.w d2,d0
 addx.l d4,d3
 swap d0
 clr.w d1
 swap d1
 clr.w d2
 swap d2
 add.l d2,d1
 add.l d3,d1
 tst.l d0
 movem.l (sp)+,d2-d4
 rts 
L1ca78 move.l d2,-(sp)
 moveq #0,d2
 tst.l d0
 bpl.s L1ca84
 neg.l d0
 moveq #3,d2
L1ca84 tst.l d1
 bpl.s L1ca8e
 neg.l d1
 eori.b #$01,d2
L1ca8e bsr.s L1cab2
 lsr.b #1,d2
 bcc.s L1ca96
 neg.l d0
L1ca96 lsr.b #1,d2
 bcc.s L1ca9c
 neg.l d1
L1ca9c move.l (sp)+,d2
 tst.l d0
 rts 
L1caa2 bsr.s L1ca78
 exg d0,d1
 tst.l d0
 rts 
 bsr.s L1cab2
 exg d0,d1
 tst.l d0
 rts 
L1cab2 movem.l d2-d4,-(sp)
 move.l d1,d2
 bne.s L1cac0
 divs.w #0,d0
 bra.s L1cb2e
L1cac0 subq.l #1,d1
 beq.s L1cb2e
 move.l d1,d4
 move.l d0,d1
 cmp.l d1,d2
 bcs.s L1cad8
 beq.s L1cad2
 moveq #0,d0
 bra.s L1cb2e
L1cad2 moveq #1,d0
 sub.l d2,d1
 bra.s L1cb2e
L1cad8 move.l d2,d3
 bmi.s L1cad2
 and.l d4,d3
 bne.s L1caf2
 lsr.l #1,d2
 moveq #255,d3
L1cae4 lsr.l #1,d2
 dbcs d3,L1cae4
 neg.l d3
 lsr.l d3,d0
 and.l d4,d1
 bra.s L1cb2e
L1caf2 moveq #0,d0
 moveq #255,d3
L1caf6 asl.l #1,d2
 bpl.s L1cb00
 cmp.l d1,d2
 bhi.s L1cb08
 bra.s L1cb0c
L1cb00 cmp.l d1,d2
 dbcc d3,L1caf6
 beq.s L1cb0c
L1cb08 addq.l #1,d3
 lsr.l #1,d2
L1cb0c neg.l d3
 bra.s L1cb14
L1cb10 asl.l #1,d0
 lsr.l #1,d2
L1cb14 sub.l d2,d1
 bcs.s L1cb28
L1cb18 addq.l #1,d0
 dbf d3,L1cb10
 bra.s L1cb2e
L1cb20 asl.l #1,d0
 lsr.l #1,d2
 add.l d2,d1
 bcs.s L1cb18
L1cb28 dbf d3,L1cb20
 add.l d2,d1
L1cb2e movem.l (sp)+,d2-d4
 tst.l d0
 rts 
 movea.l (sp)+,a5
L1cb38 subq.l #1,d5
 bcs.s L1cb9e
 move.b (a0)+,d0
 beq.s L1cb38
 cmpi.b #13,d0
 beq.s L1cb9e
 cmpi.b #32,d0
 beq.s L1cb38
 cmpi.b #9,d0
 beq.s L1cb38
 cmpi.b #44,d0
 beq.s L1cb38
 addq.l #1,d2
 cmpi.b #34,d0
 beq.s L1cb90
 cmpi.b #39,d0
 beq.s L1cb90
 pea -1(a0)
L1cb6a subq.l #1,d5
 bcs.s L1cb9e
 move.b (a0)+,d0
 beq.s L1cb38
 cmpi.b #13,d0
 beq.s L1cb8a
 cmpi.b #32,d0
 beq.s L1cb8a
 cmpi.b #9,d0
 beq.s L1cb8a
 cmpi.b #44,d0
 bne.s L1cb6a
L1cb8a clr.b -1(a0)
 bra.s L1cb38
L1cb90 pea (a0)
L1cb92 subq.l #1,d5
 bcs.s L1cb9e
 move.b (a0)+,d1
 cmp.b d1,d0
 bne.s L1cb92
 bra.s L1cb8a
L1cb9e movea.l sp,a0
 pea (sp)
 move.l d2,-(sp)
 subq.l #1,d2
 beq.s L1cbb8
 asl.l #2,d2
L1cbaa move.l (a0,d2.l),d0
 move.l (a0),(a0,d2.l)
 move.l d0,(a0)+
 subq.l #8,d2
 bhi.s L1cbaa
L1cbb8 jmp (a5)
L1cbba link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d1,a0
 move.w #0,d1
L1cbc8 os9 I$GetStt
 bra.w L1d66e
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.w #1,d1
 os9 I$GetStt
 bcs.w L1d670
 move.l d1,d0
 bra.w L1d66e
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.w #6,d1
 os9 I$GetStt
 bcc.w L1d678
 cmpi.w #211,d1
 bne.w L1d670
 moveq #1,d0
 bra.w L1d66e
L1cc0c link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d1,a0
 move.w #15,d1
 move.l 8(a5),d2
 bra.s L1cbc8
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d1,a0
 move.w #14,d1
 bra.s L1cbc8
L1cc30 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.w #2,d1
L1cc3c os9 I$GetStt
 bcs.w L1d670
 move.l d2,d0
 bra.w L1d66e
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.w #5,d1
 bra.s L1cc3c
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d1,a0
 move.w #0,d1
L1cc66 os9 I$SetStt
 bra.w L1d66e
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.w #3,d1
 bra.s L1cc66
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.l d1,d2
 move.w #2,d1
 bra.s L1cc66
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d1,a0
 move.w #15,d1
 bra.s L1cc66
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.l d1,d2
 move.w #16,d1
 bra.s L1cc66
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.l d1,d2
 move.w #17,d1
 bra.s L1cc66
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.l d1,d2
 move.w #26,d1
L1ccca bra.s L1cc66
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.w #27,d1
 bra.s L1ccca
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movem.l a1/d3-d4,-(sp)
 move.l d1,d2
 moveq #4,d1
 movem.l 8(a5),a0-a1/d3-d4
 os9 I$SetStt
 movem.l (sp)+,a1/d3-d4
L1ccf6 equ *-2
 bra.w L1d66e
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.l d1,d2
 move.w #28,d1
 bra.s L1ccca
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.w #36,d1
 bra.s L1ccca
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.w #37,d1
 bra.s L1ccca
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.w d1,d2
 move.w #38,d1
 bra.s L1ccca
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.w d1,d2
 move.w #39,d1
 bra.s L1ccca
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 move.w d1,d0
 os9 I$Open
 bcs.w L1d670
 os9 I$Close
 bra.w L1d678
L1cd64 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 move.w d1,d0
 moveq #0,d2
 os9 I$Open
 bra.w L1d66e
L1cd7a link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 os9 I$Close
 bra.w L1d66e
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 moveq #130,d0
 moveq #0,d2
L1cd98 os9 I$MakDir
 bra.w L1d678
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 move.l d1,d0
 move.l 20(sp),d1
 move.l 24(sp),d2
 bra.s L1cd98
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 move.w d1,d0
 move.l 20(sp),d1
 move.l 24(sp),d2
 os9 I$Create
 bra.w L1d66e
 link.w a5,#0
 movem.l a0/d0-d2,-(sp)
 movea.l d0,a0
 move.w d1,d0
 andi.w #$0024,d1
 ori.w #$0003,d1
 moveq #0,d2
 os9 I$Create
 movea.l (sp)+,a0
 bcc.w L1d66e
 cmpi.b #218,d1
 bne.w L1d670
 move.w 2(sp),d0
 bmi.w L1d670
 andi.w #$0007,d0
 os9 I$Open
 bcs.w L1d670
 moveq #0,d2
 moveq #2,d1
 os9 I$SetStt
 bcc.w L1d66e
 move.w d1,d2
 os9 I$Close
 move.w d2,d1
 bra.w L1d670
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 move.w d1,d0
 os9 I$Delete
 bra.w L1d678
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 moveq #2,d0
 os9 I$Delete
 bra.w L1d678
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 os9 I$Dup
 bra.w L1d66e
L1ce5e link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d1,a0
 move.l 8(a5),d1
 os9 I$Read
 bcc.s L1ce92
L1ce72 cmpi.w #211,d1
 bne.w L1d670
 bra.w L1d678
L1ce7e link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d1,a0
 move.l 8(a5),d1
 os9 I$ReadLn
 bcs.s L1ce72
L1ce92 move.l d1,d0
 bra.w L1d66e
L1ce98 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d1,a0
 move.l 8(a5),d1
 os9 I$Write
 bcc.s L1ce92
 bra.w L1d670
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d1,a0
 move.l 8(a5),d1
 os9 I$WritLn
 bcc.s L1ce92
 bra.w L1d670
L1cec8 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.b 11(a5),d1
 beq.s L1cefc
 cmpi.b #1,d1
 beq.s L1cef2
 cmpi.b #2,d1
 beq.s L1cee8
 moveq #203,d1
L1cee4 bra.w L1d670
L1cee8 moveq #2,d1
 os9 I$GetStt
 bcc.s L1cefe
 bra.s L1cee4
L1cef2 moveq #5,d1
 os9 I$GetStt
 bcc.s L1cefe
 bra.s L1cee4
L1cefc moveq #0,d2
L1cefe add.l (sp),d2
 move.l d2,d1
 os9 I$Seek
 bcs.s L1cee4
 move.l d1,d0
 bra.w L1d66e
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 moveq #0,d0
 os9 F$Sleep
 bra.w L1d66e
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l 8(a5),a0
 move.l (a0),d1
 movea.l d0,a0
 move.l (sp),d0
 os9 F$CRC
 bcs.w L1d670
 movea.l 8(a5),a0
 move.l d1,(a0)
 bra.w L1d678
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 os9 F$PErr
 bra.w L1d66e
 lsl.l #8,d0
 bset.l #31,d0
L1cf5a link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 os9 F$Sleep
 bra.w L1d66e
L1cf6a link.w a5,#0
 movem.l a0-a1,-(sp)
 movea.l d1,a0
 movea.l d0,a1
 move.l 8(a5),d1
 os9 F$CmpNam
 bcs.s L1cfe0
 moveq #0,d0
 bra.s L1cfec
 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 movea.l d0,a0
 os9 F$PrsNam
 bcc.s L1cfe8
 bra.s L1cfe0
 link.w a5,#0
 movem.l a0-a1/d0-d1,-(sp)
 movea.l d0,a0
 movea.l a0,a1
L1cfa2 move.b (a1)+,d0
 cmpi.b #47,d0
 beq.s L1cfc4
 cmpi.b #46,d0
 bne.s L1cfd2
L1cfb0 cmpi.b #46,(a1)+
 beq.s L1cfb0
 move.b -(a1),d0
 beq.s L1cfe8
 cmpi.b #47,d0
 bne.s L1cfd2
 movea.l a1,a0
 bra.s L1cfa2
L1cfc4 move.b (a1)+,d0
 cmpi.b #47,d0
 beq.s L1cfd2
 cmpi.b #46,d0
 beq.s L1cfb0
L1cfd2 os9 F$PrsNam
 bcs.s L1cfe0
 tst.b d0
 beq.s L1cfe8
 movea.l a1,a0
 bra.s L1cfa2
L1cfe0 move.l d1,D0000c(a6)
 moveq #255,d0
 bra.s L1cfec
L1cfe8 move.l a1,d0
 sub.l (sp),d0
L1cfec movem.l -12(a5),a0-a1/d1
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movem.l a1-a2/d3-d4,-(sp)
 move.l 12(a5),d2
 btst.l #15,d2
 beq.s L1d014
 move.l 16(a5),d3
 move.l 20(a5),d4
L1d014 movea.l d0,a0
 move.l d1,d0
 move.l 8(a5),d1
 os9 F$DatMod
 bcs.s L1d024
 move.l a2,d0
L1d024 movem.l (sp)+,a1-a2/d3-d4
 bra.w L1d66e
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 os9 F$GModDr
 bcs.w L1d670
 move.l d1,d0
 bra.w L1d66e
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 os9 F$GPrDBT
 bcs.w L1d670
 move.l d1,d0
 bra.w L1d66e
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l 8(a5),a0
 os9 F$GPrDsc
 bra.w L1d66e
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 os9 F$SetCRC
 bra.w L1d66e
L1d082 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 bset.l #31,d1
 bra.s L1d09c
L1d090 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.l 8(a5),d2
L1d09c os9 F$SetSys
 bcs.w L1d670
 move.l d2,d0
 bra.w L1d66e
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 os9 F$SSpd
 bra.w L1d66e
 link.w a5,#0
 os9 F$SysDbg
 unlk a5
 rts 
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.l a1,-(sp)
 movea.l 8(a5),a0
 movea.l 12(a5),a1
 os9 F$CpyMem
 movea.l (sp)+,a1
 bra.w L1d66e
L1d0e2 link.w a5,#0
 movem.l a0/d2-d3,-(sp)
 move.l d1,d2
 move.l 20(sp),d3
 movea.l 24(sp),a0
 moveq #2,d1
L1d0f6 os9 F$Event
 bcc.s L1d102
 move.l d1,D0000c(a6)
 moveq #255,d0
L1d102 movem.l -12(a5),a0/d2-d3
 unlk a5
 rts 
L1d10c link.w a5,#0
 movem.l a0/d1-d3,-(sp)
 movea.l d0,a0
 moveq #0,d1
L1d118 os9 F$Event
 bcc.s L1d124
 move.l d1,D0000c(a6)
 moveq #255,d0
L1d124 movem.l -16(a5),a0/d1-d3
 unlk a5
 rts 
L1d12e link.w a5,#0
 movem.l a0/d1-d3,-(sp)
 moveq #1,d1
 bra.s L1d118
L1d13a link.w a5,#0
 movem.l a0/d1-d3,-(sp)
 movea.l d0,a0
 moveq #3,d1
 bra.s L1d118
L1d148 link.w a5,#0
 movem.l a0/d2-d3,-(sp)
 movea.l d1,a0
 moveq #7,d1
 bra.s L1d0f6
L1d156 link.w a5,#0
 or.w #8,d1
 os9 F$Event
 bcc.s L1d16a
 move.l d1,D0000c(a6)
 moveq #255,d1
L1d16a move.l d1,d0
 unlk a5
 rts 
L1d170 link.w a5,#0
 move.l d1,-(sp)
 moveq #6,d1
 os9 F$Event
 bcc.s L1d184
 move.l d1,D0000c(a6)
 moveq #255,d1
L1d184 move.l d1,d0
 move.l -4(a5),d1
 unlk a5
 rts 
L1d18e link.w a5,#0
 move.l d2,-(sp)
 moveq #9,d2
 bra.s L1d1aa
L1d198 link.w a5,#0
 move.l d2,-(sp)
 moveq #10,d2
 bra.s L1d1aa
 link.w a5,#0
 move.l d2,-(sp)
 moveq #11,d2
L1d1aa exg d1,d2
 or.w 14(sp),d1
 os9 F$Event
 bcc.s L1d1bc
 move.l d1,D0000c(a6)
 moveq #255,d1
L1d1bc move.l d1,d0
 move.l -4(a5),d2
 unlk a5
 rts 
L1d1c6 link.w a5,#0
 movem.l d2-d3,-(sp)
 moveq #4,d2
L1d1d0 exg d1,d2
 move.l 16(sp),d3
 os9 F$Event
 bcc.s L1d1e2
 move.l d1,D0000c(a6)
 moveq #255,d1
L1d1e2 move.l d1,d0
 movem.l -8(a5),d2-d3
 unlk a5
 rts 
 link.w a5,#0
 movem.l d2-d3,-(sp)
 moveq #5,d2
 bra.s L1d1d0
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 move.w d1,d0
 movem.l a1-a2,-(sp)
 os9 F$Link
L1d20e bcs.s L1d212
 move.l a2,d0
L1d212 movem.l (sp)+,a1-a2
 bra.w L1d66e
L1d21a link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 move.w d1,d0
 movem.l a1-a2,-(sp)
 os9 F$Load
 bra.s L1d20e
L1d230 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.l a2,-(sp)
 movea.l d0,a2
 os9 F$UnLink
 movea.l (sp)+,a2
 bra.w L1d66e
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 move.w d1,d0
 os9 F$UnLoad
 bra.w L1d66e
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.l d0,d1
 bne.s L1d26c
 moveq #203,d1
 bra.w L1d670
L1d26c addq.l #1,d1
 and.b #254,d1
 move.l D00b56(a6),d2
 sub.l d1,d2
 bcs.s L1d28a
 move.l D00b52(a6),d0
 add.l d1,D00b52(a6)
 sub.l d1,D00b56(a6)
 bra.w L1d30a
L1d28a move.l _01666(a6),d0
 cmp.l d1,d0
 bhi.s L1d294
 move.l d1,d0
L1d294 movea.l a2,a0
 os9 F$SRqMem
 exg a2,a0
 bcs.w L1d670
 move.l a0,D00b52(a6)
 move.l d0,D00b56(a6)
 add.l d0,D00010(a6)
 bra.s L1d26c
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.l d0,d1
 addq.l #1,d1
 and.b #254,d1
 move.l d1,d2
 add.l D00004(a6),d1
 bcs.s L1d2d8
 cmp.l D00008(a6),d1
 bcc.s L1d2d8
 move.l D00004(a6),d0
 move.l d1,D00004(a6)
 move.l d2,d1
 bra.s L1d30a
L1d2d8 moveq #207,d1
 bra.w L1d670
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 addq.l #1,d0
 and.b #254,d0
 move.l d0,d1
 add.l D00014(a6),d0
 movea.l a1,a0
 os9 F$Mem
 exg a1,a0
 bcs.w L1d670
 move.l d0,D00014(a6)
 add.l d1,D00010(a6)
 move.l a0,d0
 sub.l d1,d0
L1d30a movea.l d0,a0
 moveq #0,d2
 lsr.l #2,d1
 bcc.s L1d318
 move.w d2,(a0)+
 bra.s L1d318
L1d316 move.l d2,(a0)+
L1d318 dbf d1,L1d316
 addq.w #1,d1
 subq.l #1,d1
 bcc.s L1d316
 move.l d0,d0
 bra.w L1d66e
L1d328 link.w a5,#-4
 move.l a2,(sp)
 os9 F$SRqMem
 bcs.s L1d350
 move.l d0,D00b5a(a6)
 move.l a2,d0
L1d33a movea.l -4(a5),a2
 unlk a5
 rts 
L1d342 link.w a5,#-4
 move.l a2,(sp)
 movea.l d1,a2
 os9 F$SRtMem
 bcc.s L1d33a
L1d350 moveq #255,d0
 move.l d1,D0000c(a6)
 bra.s L1d33a
 link.w a5,#0
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
 bcs.w L1d670
 move.l a0,d0
 bra.w L1d66e
 link.w a5,#0
 movem.l a0/d1-d3,-(sp)
 movea.l d0,a0
 moveq #0,d0
 os9 F$Time
 bcs.s L1d3d4
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
L1d3cc movem.l (sp)+,a0/d1-d3
 unlk a5
 rts 
L1d3d4 moveq #255,d0
 move.l d1,D0000c(a6)
 bra.s L1d3cc
 link.w a5,#0
 movem.l a0-a1/d1-d3,-(sp)
 moveq #0,d2
 os9 F$Time
 bcs.s L1d40c
 movea.l -20(a5),a0
 move.l d0,(a0)
 lea 8(a5),a0
 movea.l (a0)+,a1
 move.l d1,(a1)
 movea.l (a0)+,a1
 move.w d2,(a1)
 movea.l (a0),a1
 move.l d3,(a1)
L1d402 moveq #0,d0
 movem.l (sp)+,a0-a1/d1-d3
 unlk a5
 rts 
L1d40c moveq #255,d0
 move.l d1,D0000c(a6)
 bra.s L1d402
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.l a1,-(sp)
 movea.l d0,a0
 movea.l d1,a1
 move.l (a0),d0
 move.l (a1),d1
 os9 F$Julian
 bcs.w L1d432
 move.l d0,(a0)
 move.l d1,(a1)
L1d432 movea.l (sp)+,a1
 bra.w L1d66e
L1d438 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 os9 F$Send
 bra.w L1d66e
L1d448 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movea.l d0,a0
 moveq #0,d0
 os9 F$Wait
 bcs.w L1d670
 move.l a0,d2
 beq.w L1d66e
 clr.w (a0)+
 move.w d1,(a0)
 bra.w L1d66e
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 os9 F$SPrior
 bra.w L1d66e
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movem.l a1/d3-d5,-(sp)
 moveq #3,d5
 bra.s L1d4b8
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movem.l a1/d3-d5,-(sp)
 moveq #1,d5
 bra.s L1d4b8
L1d49a link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movem.l a1/d3-d5,-(sp)
 moveq #2,d5
 bra.s L1d4b8
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movem.l a1/d3-d5,-(sp)
 moveq #0,d5
L1d4b8 movea.l d0,a0
 move.l d1,d2
 movea.l 8(a5),a1
 move.w 18(a5),d0
 swap d0
 move.w 14(a5),d0
 move.l 20(a5),d1
 moveq #3,d3
 btst.l #1,d5
 beq.s L1d4da
 move.l 28(a5),d3
L1d4da move.l 24(a5),d4
 btst.l #0,d5
 bne.s L1d4ea
 os9 F$Fork
 bra.s L1d4ee
L1d4ea os9 F$Chain
L1d4ee movem.l (sp)+,a1/d3-d5
 bra.w L1d66e
L1d4f6 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 os9 F$ID
 bra.w L1d66e
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 os9 F$ID
 bcs.w L1d670
 move.l d1,d0
 bra.w L1d66e
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 move.l d0,d1
 os9 F$SUser
 bra.w L1d66e
L1d52e link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 lea L1d54a(pc),a0
 move.l d0,D00b5e(a6)
 bne.s L1d542
 movea.l d0,a0
L1d542 os9 F$Icpt
 bra.w L1d66e
L1d54a move.l d1,d0
 movea.l D00b5e(a6),a0
 jsr (a0)
 os9 F$RTE
 link.w a5,#0
 move.l d1,-(sp)
 moveq #0,d1
 os9 F$Alarm
 bcs.s L1d56c
 moveq #0,d0
L1d566 move.l (sp)+,d1
 unlk a5
 rts 
L1d56c move.l d1,D0000c(a6)
 moveq #255,d0
 bra.s L1d566
L1d574 link.w a5,#0
 movem.l d1-d4,-(sp)
 move.l d1,d3
 moveq #1,d1
L1d580 move.w d0,d2
 moveq #0,d0
 os9 F$Alarm
 bcc.s L1d590
 move.l d1,D0000c(a6)
 moveq #255,d0
L1d590 movem.l (sp)+,d1-d4
 unlk a5
 rts 
 link.w a5,#0
 movem.l d1-d4,-(sp)
 move.l d1,d3
 moveq #2,d1
 bra.s L1d580
 link.w a5,#0
 movem.l d1-d4,-(sp)
 move.l d1,d3
 move.w #3,d1
L1d5b4 move.l 24(sp),d4
 bra.s L1d580
 link.w a5,#0
 movem.l d1-d4,-(sp)
 move.l d1,d3
 move.w #4,d1
 bra.s L1d5b4
L1d5ca link.w a5,#0
 movem.l a2/d1,-(sp)
 os9 F$SRqCMem
 bcs.s L1d5e6
 move.l a2,d0
 move.l d0,D00b62(a6)
L1d5de movem.l (sp)+,a2/d1
 unlk a5
 rts 
L1d5e6 moveq #255,d0
 move.l d1,D0000c(a6)
 bra.s L1d5de
 link.w a5,#0
 movem.l a0-a2/d1,-(sp)
 movea.l d0,a0
 move.b d1,d0
 bset.l #7,d0
 move.l 24(sp),d1
 os9 F$Load
 bcs.s L1d612
 move.l a2,d0
L1d60a movem.l (sp)+,a0-a2/d1
 unlk a5
 rts 
L1d612 moveq #255,d0
 move.l d1,D0000c(a6)
 bra.s L1d60a
 link.w a5,#0
 movem.l a0/d1-d2,-(sp)
 movem.l a1-a2/d3-d4,-(sp)
 movea.l d0,a0
 move.l d1,d0
 move.l 8(a5),d1
 move.l 12(a5),d2
 bset.l #15,d2
 move.l 16(a5),d3
 move.l 20(a5),d4
 os9 F$DatMod
 bcs.s L1d646
 move.l a2,d0
L1d646 movem.l (sp)+,a1-a2/d3-d4
 bra.w L1d66e
L1d64e link.w a5,#0
 move.l d1,-(sp)
 move.l d0,d1
 moveq #0,d0
 os9 F$SigMask
 bcs.s L1d666
 moveq #0,d0
L1d660 move.l (sp)+,d1
 unlk a5
 rts 
L1d666 move.l d1,D0000c(a6)
 moveq #255,d0
 bra.s L1d660
L1d66e bcc.s L1d67c
L1d670 move.l d1,D0000c(a6)
 moveq #255,d0
 bra.s L1d67c
L1d678 bcs.s L1d670
 moveq #0,d0
L1d67c movem.l -12(a5),a0/d1-d2
 unlk a5
 rts 
L1d686 link.w a5,#0
 move.l d0,d1
 bsr.w L1d6ac
 bsr.w L1d6ae
 bra.s L1d69e
 link.w a5,#0
 illegal 
 move.l d0,d1
L1d69e os9 F$Exit
 add.l -8531(a5),d7
 ori #1,ccr
 rts 
L1d6ac rts 
L1d6ae rts 

 ends 

