 psect zeroCat_c,$0,$0,0,0,L00000

* _
 vsect 
zeroCategory: dc.l $00000000
 dc.l $000a0000
 dc.l _defaultEventHandler
 dc.l zeroCategory
 dc.w $0000
 dc.l _defaultEventHandler
 dc.l zeroCategory
 dc.w $0000
_zeroCategoryExtraHandlers: dc.l _defaultEventHandler
 dc.l zeroCategory
 dc.w $0000
 dc.l _panicEventHandler
 dc.w $0000
 dc.w $0100
 dc.w $0000
 dc.l _panicEventHandler
 dc.w $0000
 dc.w $0000
 dc.w $0000
 dc.l _defaultEventHandler
 dc.l zeroCategory
 dc.w $0100
 dc.l _defaultEventHandler
 dc.l zeroCategory
 dc.w $0000
 dc.l _defaultEventHandler
 dc.l zeroCategory
 dc.w $0000
 dc.l _defaultEventHandler
 dc.l zeroCategory
 dc.w $0000
 dc.l _defaultEventHandler
 dc.l zeroCategory
 dc.w $0000
 dc.l _defaultEventHandler
 dc.l zeroCategory
 dc.w $0100


 ends 


 ends 

