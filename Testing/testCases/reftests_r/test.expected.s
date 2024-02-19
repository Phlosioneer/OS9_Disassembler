
* Class equate external label equates

extDef1: equ $32
 psect reftests,0,0,0,0,int1


* D
 vsect 
uninitStart: ds.b 4


 ends 


* _
 vsect 
initStart: dc.l $00000000
 dc.l uninitStart
 dc.l initStart
 dc.l uninitRemoteStart
 dc.l initRemoteStart
 dc.l int1


 ends 


* G
 vsect remote
uninitRemoteStart: ds.b 20


 ends 


* H
 vsect remote
initRemoteStart: dc.l $00000000
 dc.l uninitStart
 dc.l initStart
 dc.l uninitRemoteStart
 dc.l initRemoteStart
 dc.l int1



 ends 

L00000 dc.w $1234,$5678
 dc.w ext1
 dc.w $5+ext1
 dc.l $58+ext2
 dc.w -ext1
 dc.w $4a-ext1
 dc.w ext1+ext2
 dc.w ext3+ext3
 dc.w ext1+ext2+ext3+ext4
 bgt.w ext1
 bgt.w L00020+ext1
 bgt.w -ext1
L00020 equ *-2
 bgt.w -ext1+ext2
L00024 equ *-2
 bgt.w L00024+ext1
L0002a dc.w L0002a
 dc.w L00056
L0002e dc.w -ext1+L0002e
 dc.w ext3-L0ffd0
 bgt.w L00036
L00034 equ *-2
L00036 bgt.w L00034
 bgt.w int1
 bgt.w int1-ext1
 bgt.w -int1+ext1
 dc.b -ext1+int1
 dc.b $00
 dc.l ext1-Lfff9c
 ori.b #$00,d0
 dc.l uninitStart
 dc.l initStart
 dc.l uninitRemoteStart
 dc.l initRemoteStart
 dc.l int1
int1: ori.b #$00,d0
 dc.w $0000

 ends 

