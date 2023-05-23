 psect cfinish_a,0,0,0,0,exit

exit: link.w a5,#0
 move.l d0,d1
 bsr.w _dumprof
 bsr.w _tidyup
 bra.s L00018
abort: link.w a5,#0
 illegal 
_exit: move.l d0,d1
L00018 os9 F$Exit
 add.l -8531(a5),d7

 ends 

