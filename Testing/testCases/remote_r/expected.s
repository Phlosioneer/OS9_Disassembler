
* Class G external label equates

bigarray: equ $00000

* Class H external label equates

loremIpsum: equ $00000
 psect remote_t_c,$0,$0,0,0,main

G
 vsect remote
bigarray:: ds.b 40000


 ends 


H
 vsect remote
loremIpsum: dc.l $4c6f7265
 dc.l $6d206970
 dc.l $73756d20
 dc.l $646f6c6f
 dc.l $72207369
 dc.l $7420616d
 dc.l $65742c20
 dc.l $636f6e73
 dc.l $65637465
 dc.l $74757220
 dc.l $61646970
 dc.l $69736369
 dc.l $6e672065
 dc.l $6c69742e
 dc.l $204d6f72
 dc.l $62692073
 dc.l $69742061
 dc.l $6d657420
 dc.l $74656c6c
 dc.l $75732070
 dc.l $75727573
 dc.l $2e205574
 dc.l $20736365
 dc.l $6c657269
 dc.l $73717565
 dc.l $20696163
 dc.l $756c6973
 dc.l $206e6973
 dc.l $6c2c2065
 dc.l $67657420
 dc.l $67726176
 dc.l $69646120
 dc.l $6d617572
 dc.l $69732076
 dc.l $61726975
 dc.l $7320612e
 dc.l $20467573
 dc.l $63652069
 dc.l $64206e75
 dc.l $6e632065
 dc.l $74206c69
 dc.l $67756c61
 dc.l $20706c61
 dc.l $63657261
 dc.l $74206461
 dc.l $70696275
 dc.l $732e2043
 dc.l $75726162
 dc.l $69747572
 dc.l $20657520
 dc.l $616c6971
 dc.l $75657420
 dc.l $75726e61
 dc.l $2c207369
 dc.l $7420616d
 dc.l $65742073
 dc.l $6f64616c
 dc.l $6573206a
 dc.l $7573746f
 dc.l $2e205175
 dc.l $69737175
 dc.l $65207665
 dc.l $6c697420
 dc.l $616e7465
 dc.l $2c207661
 dc.l $72697573
 dc.l $20696e20
 dc.l $65756973
 dc.l $6d6f6420
 dc.l $76697461
 dc.l $652c206d
 dc.l $616c6573
 dc.l $75616461
 dc.l $2076656c
 dc.l $206f7263
 dc.l $692e2056
 dc.l $65737469
 dc.l $62756c75
 dc.l $6d207469
 dc.l $6e636964
 dc.l $756e7420
 dc.l $6f726369
 dc.l $20707572
 dc.l $75732c20
 dc.l $696e2075
 dc.l $6c6c616d
 dc.l $636f7270
 dc.l $65722075
 dc.l $726e6120
 dc.l $626c616e
 dc.l $64697420
 dc.l $65676574
 dc.l $2e205574
 dc.l $2076656c
 dc.l $20646963
 dc.l $74756d20
 dc.l $65726f73
 dc.l $2e204d6f
 dc.l $72626920
 dc.l $706c6163
 dc.l $65726174
 dc.l $20617263
 dc.l $75207175
 dc.l $69732065
 dc.l $6e696d20
 dc.l $636f6e67
 dc.l $75652c20
 dc.l $6120636f
 dc.l $6d6d6f64
 dc.l $6f20656c
 dc.l $69742076
 dc.l $65737469
 dc.l $62756c75
 dc.l $6d2e2050
 dc.l $656c6c65
 dc.l $6e746573
 dc.l $71756520
 dc.l $73656d70
 dc.l $6572206d
 dc.l $61747469
 dc.l $73207475
 dc.l $72706973
 dc.l $2c206964
 dc.l $20706c61
 dc.l $63657261
 dc.l $74206573
 dc.l $7420636f
 dc.l $6e64696d
 dc.l $656e7475
 dc.l $6d206964
 dc.l $2e0d0d53
 dc.l $75737065
 dc.l $6e646973
 dc.l $73652073
 dc.l $6f6c6c69
 dc.l $63697475
 dc.l $64696e2c
 dc.l $2065726f
 dc.l $73207365
 dc.l $64207363
 dc.l $656c6572
 dc.l $69737175
 dc.l $65206575
 dc.l $69736d6f
 dc.l $642c2065
 dc.l $6e696d20
 dc.l $6c656374
 dc.l $75732066
 dc.l $6163696c
 dc.l $69736973
 dc.l $206e6973
 dc.l $692c2076
 dc.l $656c2073
 dc.l $6f6c6c69
 dc.l $63697475
 dc.l $64696e20
 dc.l $6e657175
 dc.l $65206d61
 dc.l $73736120
 dc.l $696e2073
 dc.l $656d2e20
 dc.l $50686173
 dc.l $656c6c75
 dc.l $73206269
 dc.l $62656e64
 dc.l $756d2c20
 dc.l $6e696268
 dc.l $206e6f6e
 dc.l $20766172
 dc.l $69757320
 dc.l $6c616369
 dc.l $6e69612c
 dc.l $2075726e
 dc.l $61206c65
 dc.l $6f20756c
 dc.l $74726963
 dc.l $65732065
 dc.l $782c2064
 dc.l $69637475
 dc.l $6d20696e
 dc.l $74657264
 dc.l $756d206c
 dc.l $69626572
 dc.l $6f206a75
 dc.l $73746f20
 dc.l $76656c20
 dc.l $616e7465
 dc.l $2e204475
 dc.l $69732073
 dc.l $6f6c6c69
 dc.l $63697475
 dc.l $64696e2c
 dc.l $206d6574
 dc.l $75732073
 dc.l $65642063
 dc.l $6f6e7365
 dc.l $71756174
 dc.l $20637572
 dc.l $7375732c
 dc.l $2065726f
 dc.l $73206a75
 dc.l $73746f20
 dc.l $6469676e
 dc.l $69737369
 dc.l $6d206e75
 dc.l $6e632c20
 dc.l $73656420
 dc.l $656c6569
 dc.l $66656e64
 dc.l $2066656c
 dc.l $69732065
 dc.l $72617420
 dc.l $6964206d
 dc.l $61676e61
 dc.l $2e20416c
 dc.l $69717561
 dc.l $6d207665
 dc.l $6c207363
 dc.l $656c6572
 dc.l $69737175
 dc.l $65207365
 dc.l $6d2c206e
 dc.l $6f6e206d
 dc.l $6f6c6c69
 dc.l $73206c61
 dc.l $6375732e
 dc.l $2041656e
 dc.l $65616e20
 dc.l $6174206d
 dc.l $6f6c6573
 dc.l $74696520
 dc.l $6c616375
 dc.l $732c2070
 dc.l $656c6c65
 dc.l $6e746573
 dc.l $71756520
 dc.l $706f7274
 dc.l $61206573
 dc.l $742e2056
 dc.l $65737469
 dc.l $62756c75
 dc.l $6d207369
 dc.l $7420616d
 dc.l $65742074
 dc.l $75727069
 dc.l $73206d61
 dc.l $78696d75
 dc.l $73206e65
 dc.l $71756520
 dc.l $76656869
 dc.l $63756c61
 dc.l $20657569
 dc.l $736d6f64
 dc.l $2e20416c
 dc.l $69717561
 dc.l $6d206865
 dc.l $6e647265
 dc.l $72697420
 dc.l $616c6971
 dc.l $75616d20
 dc.l $6c656374
 dc.l $75732c20
 dc.l $65752076
 dc.l $65686963
 dc.l $756c6120
 dc.l $73656d20
 dc.l $64617069
 dc.l $62757320
 dc.l $70656c6c
 dc.l $656e7465
 dc.l $73717565
 dc.l $2e20446f
 dc.l $6e656320
 dc.l $65752070
 dc.l $68617265
 dc.l $74726120
 dc.l $65782e20
 dc.l $46757363
 dc.l $6520736f
 dc.l $64616c65
 dc.l $7320696e
 dc.l $74657264
 dc.l $756d2065
 dc.l $6c69742c
 dc.l $20696420
 dc.l $70756c76
 dc.l $696e6172
 dc.l $2073656d
 dc.l $20657569
 dc.l $736d6f64
 dc.l $20717569
 dc.l $732e2049
 dc.l $6e20656e
 dc.l $696d2074
 dc.l $75727069
 dc.l $732c2061
 dc.l $6c697175
 dc.l $6574206e
 dc.l $6563206e
 dc.l $756c6c61
 dc.l $2076656c
 dc.l $2c206c61
 dc.l $6f726565
 dc.l $7420756c
 dc.l $74726963
 dc.l $69657320
 dc.l $74757270
 dc.l $69732e20
 dc.l $53757370
 dc.l $656e6469
 dc.l $73736520
 dc.l $706f7465
 dc.l $6e74692e
 dc.l $20496e74
 dc.l $65676572
 dc.l $20756c74
 dc.l $72696369
 dc.l $65732073
 dc.l $6f6c6c69
 dc.l $63697475
 dc.l $64696e20
 dc.l $6d617373
 dc.l $61207574
 dc.l $2074656d
 dc.l $7075732e
 dc.l $20506861
 dc.l $73656c6c
 dc.l $75732061
 dc.l $20646961
 dc.l $6d206163
 dc.l $2075726e
 dc.l $61207375
 dc.l $73636970
 dc.l $69742076
 dc.l $69766572
 dc.l $72612e20
 dc.l $55742071
 dc.l $75697320
 dc.l $6f726e61
 dc.l $7265206a
 dc.l $7573746f
 dc.l $2c207669
 dc.l $74616520
 dc.l $76657374
 dc.l $6962756c
 dc.l $756d2073
 dc.l $61706965
 dc.l $6e2e0d0d
 dc.l $416c6971
 dc.l $75616d20
 dc.l $696d7065
 dc.l $72646965
 dc.l $742c206d
 dc.l $69206964
 dc.l $20766573
 dc.l $74696275
 dc.l $6c756d20
 dc.l $6d6f6c65
 dc.l $73746965
 dc.l $2c206d61
 dc.l $75726973
 dc.l $20617263
 dc.l $75206575
 dc.l $69736d6f
 dc.l $64206e75
 dc.l $6c6c612c
 dc.l $20696e20
 dc.l $74726973
 dc.l $74697175
 dc.l $65206f64
 dc.l $696f2073
 dc.l $61706965
 dc.l $6e207665
 dc.l $6c20616e
 dc.l $74652e20
 dc.l $496e2075
 dc.l $6c747269
 dc.l $63657320
 dc.l $696e2073
 dc.l $61706965
 dc.l $6e206174
 dc.l $20666163
 dc.l $696c6973
 dc.l $69732e20
 dc.l $53656420
 dc.l $6c6f7265
 dc.l $6d207475
 dc.l $72706973
 dc.l $2c207465
 dc.l $6d706f72
 dc.l $20736974
 dc.l $20616d65
 dc.l $7420706f
 dc.l $72746120
 dc.l $65742c20
 dc.l $706f7274
 dc.l $7469746f
 dc.l $72207369
 dc.l $7420616d
 dc.l $6574206c
 dc.l $69626572
 dc.l $6f2e2050
 dc.l $72616573
 dc.l $656e7420
 dc.l $61206d69
 dc.l $20706f73
 dc.l $75657265
 dc.l $20747572
 dc.l $70697320
 dc.l $62696265
 dc.l $6e64756d
 dc.l $206d6178
 dc.l $696d7573
 dc.l $2e204375
 dc.l $72616269
 dc.l $74757220
 dc.l $65726f73
 dc.l $20646f6c
 dc.l $6f722c20
 dc.l $73656d70
 dc.l $65722061
 dc.l $7420616c
 dc.l $69717565
 dc.l $74206174
 dc.l $2c20706f
 dc.l $72746120
 dc.l $696e2061
 dc.l $6e74652e
 dc.l $204f7263
 dc.l $69207661
 dc.l $72697573
 dc.l $206e6174
 dc.l $6f717565
 dc.l $2070656e
 dc.l $61746962
 dc.l $75732065
 dc.l $74206d61
 dc.l $676e6973
 dc.l $20646973
 dc.l $20706172
 dc.l $74757269
 dc.l $656e7420
 dc.l $6d6f6e74
 dc.l $65732c20
 dc.l $6e617363
 dc.l $65747572
 dc.l $20726964
 dc.l $6963756c
 dc.l $7573206d
 dc.l $75732e20
 dc.l $4e616d20
 dc.l $736f6c6c
 dc.l $69636974
 dc.l $7564696e
 dc.l $206e756c
 dc.l $6c612069
 dc.l $6e206172
 dc.l $63752063
 dc.l $6f6e6775
 dc.l $652c2065
 dc.l $75206d6f
 dc.l $6c6c6973
 dc.l $20617263
 dc.l $75206c61
 dc.l $6f726565
 dc.l $742e2049
 dc.l $6e20706f
 dc.l $73756572
 dc.l $6520656e
 dc.l $696d2065
 dc.l $7520616c
 dc.l $69717561
 dc.l $6d206567
 dc.l $65737461
 dc.l $732e2050
 dc.l $68617365
 dc.l $6c6c7573
 dc.l $20717569
 dc.l $73206c6f
 dc.l $72656d20
 dc.l $7574206f
 dc.l $64696f20
 dc.l $706f7274
 dc.l $7469746f
 dc.l $72206961
 dc.l $63756c69
 dc.l $73206575
 dc.l $20756c74
 dc.l $72696369
 dc.l $6573206d
 dc.l $61757269
 dc.l $732e2049
 dc.l $6e206669
 dc.l $6e696275
 dc.l $73206d69
 dc.l $20736564
 dc.l $20696d70
 dc.l $65726469
 dc.l $65742069
 dc.l $6e746572
 dc.l $64756d2e
 dc.l $0d0d4e75
 dc.l $6e632063
 dc.l $6f6e6469
 dc.l $6d656e74
 dc.l $756d2073
 dc.l $61706965
 dc.l $6e206d61
 dc.l $676e612c
 dc.l $2076656c
 dc.l $20707265
 dc.l $7469756d
 dc.l $206f7263
 dc.l $69206d6f
 dc.l $6c657374
 dc.l $69652061
 dc.l $632e2053
 dc.l $65642073
 dc.l $61706965
 dc.l $6e207175
 dc.l $616d2c20
 dc.l $74656d70
 dc.l $75732076
 dc.l $69746165
 dc.l $20726973
 dc.l $75732069
 dc.l $642c2068
 dc.l $656e6472
 dc.l $65726974
 dc.l $20696163
 dc.l $756c6973
 dc.l $206c6967
 dc.l $756c612e
 dc.l $20446f6e
 dc.l $65632061
 dc.l $74206d61
 dc.l $78696d75
 dc.l $73206f64
 dc.l $696f2e20
 dc.l $50726f69
 dc.l $6e206566
 dc.l $66696369
 dc.l $7475722c
 dc.l $206e6962
 dc.l $68206574
 dc.l $2073656d
 dc.l $70657220
 dc.l $6d617869
 dc.l $6d75732c
 dc.l $20657820
 dc.l $64756920
 dc.l $65666669
 dc.l $63697475
 dc.l $72206f64
 dc.l $696f2c20
 dc.l $65752061
 dc.l $7563746f
 dc.l $72206475
 dc.l $69206175
 dc.l $67756520
 dc.l $7574206f
 dc.l $7263692e
 dc.l $204e756c
 dc.l $6c612066
 dc.l $6163696c
 dc.l $6973692e
 dc.l $20437261
 dc.l $73207465
 dc.l $6d707573
 dc.l $20646963
 dc.l $74756d20
 dc.l $6c6f7265
 dc.l $6d2c2074
 dc.l $696e6369
 dc.l $64756e74
 dc.l $20766172
 dc.l $69757320
 dc.l $6a757374
 dc.l $6f20756c
 dc.l $74726963
 dc.l $65732061
 dc.l $2e205669
 dc.l $76616d75
 dc.l $7320636f
 dc.l $6e736563
 dc.l $74657475
 dc.l $72206475
 dc.l $69206163
 dc.l $20616c69
 dc.l $7175616d
 dc.l $20656c65
 dc.l $6966656e
 dc.l $642e2046
 dc.l $75736365
 dc.l $20766f6c
 dc.l $75747061
 dc.l $74207469
 dc.l $6e636964
 dc.l $756e7420
 dc.l $6e657175
 dc.l $65207669
 dc.l $74616520
 dc.l $6c616369
 dc.l $6e69612e
 dc.l $0d0d4e75
 dc.l $6e632076
 dc.l $65737469
 dc.l $62756c75
 dc.l $6d206475
 dc.l $69206964
 dc.l $20656c65
 dc.l $6d656e74
 dc.l $756d2066
 dc.l $6163696c
 dc.l $69736973
 dc.l $2e20446f
 dc.l $6e656320
 dc.l $75726e61
 dc.l $20617567
 dc.l $75652c20
 dc.l $72686f6e
 dc.l $63757320
 dc.l $61206d61
 dc.l $6c657375
 dc.l $61646120
 dc.l $65742c20
 dc.l $66617563
 dc.l $69627573
 dc.l $20657420
 dc.l $61756775
 dc.l $652e2050
 dc.l $656c6c65
 dc.l $6e746573
 dc.l $71756520
 dc.l $696d7065
 dc.l $72646965
 dc.l $74207175
 dc.l $616d2061
 dc.l $74206573
 dc.l $74207665
 dc.l $73746962
 dc.l $756c756d
 dc.l $20656c65
 dc.l $6d656e74
 dc.l $756d2e20
 dc.l $45746961
 dc.l $6d206865
 dc.l $6e647265
 dc.l $7269742c
 dc.l $206e756e
 dc.l $63207175
 dc.l $69732075
 dc.l $6c747269
 dc.l $63657320
 dc.l $73656d70
 dc.l $65722c20
 dc.l $64756920
 dc.l $6469616d
 dc.l $20656c65
 dc.l $6d656e74
 dc.l $756d206d
 dc.l $61737361
 dc.l $2c207365
 dc.l $64207065
 dc.l $6c6c656e
 dc.l $74657371
 dc.l $75652064
 dc.l $69616d20
 dc.l $61756775
 dc.l $65207665
 dc.l $6c206175
 dc.l $6775652e
 dc.l $20536564
 dc.l $20736564
 dc.l $20617563
 dc.l $746f7220
 dc.l $616e7465
 dc.l $2c206d6f
 dc.l $6c657374
 dc.l $69652070
 dc.l $72657469
 dc.l $756d2070
 dc.l $75727573
 dc.l $2e20496e
 dc.l $74656765
 dc.l $72206120
 dc.l $6d692069
 dc.l $6e206e75
 dc.l $6e632075
 dc.l $6c747269
 dc.l $63696573
 dc.l $2073656d
 dc.l $70657220
 dc.l $61742061
 dc.l $206d692e
 dc.l $20536564
 dc.l $20626962
 dc.l $656e6475
 dc.l $6d206c69
 dc.l $67756c61
 dc.l $20656765
 dc.l $74206175
 dc.l $67756520
 dc.l $616c6971
 dc.l $75657420
 dc.l $706c6163
 dc.l $65726174
 dc.l $2e205175
 dc.l $69737175
 dc.l $65207268
 dc.l $6f6e6375
 dc.l $73206672
 dc.l $696e6769
 dc.l $6c6c6120
 dc.l $616c6971
 dc.l $7565742e
 dc.l $204d6f72
 dc.l $62692066
 dc.l $656c6973
 dc.l $206f6469
 dc.l $6f2c2072
 dc.l $686f6e63
 dc.l $75732073
 dc.l $65642070
 dc.l $756c7669
 dc.l $6e617220
 dc.l $73697420
 dc.l $616d6574
 dc.l $2c206c61
 dc.l $63696e69
 dc.l $6120696e
 dc.l $206c6163
 dc.l $75732e0d
 dc.l $0d436c61
 dc.l $73732061
 dc.l $7074656e
 dc.l $74207461
 dc.l $63697469
 dc.l $20736f63
 dc.l $696f7371
 dc.l $75206164
 dc.l $206c6974
 dc.l $6f726120
 dc.l $746f7271
 dc.l $75656e74
 dc.l $20706572
 dc.l $20636f6e
 dc.l $75626961
 dc.l $206e6f73
 dc.l $7472612c
 dc.l $20706572
 dc.l $20696e63
 dc.l $6570746f
 dc.l $73206869
 dc.l $6d656e61
 dc.l $656f732e
 dc.l $20457469
 dc.l $616d206d
 dc.l $6f6c6573
 dc.l $74696520
 dc.l $65737420
 dc.l $73656420
 dc.l $66656c69
 dc.l $73207072
 dc.l $65746975
 dc.l $6d206d61
 dc.l $78696d75
 dc.l $732e204e
 dc.l $756c6c61
 dc.l $6d206c61
 dc.l $6f726565
 dc.l $74206a75
 dc.l $73746f20
 dc.l $76656c20
 dc.l $65782068
 dc.l $656e6472
 dc.l $65726974
 dc.l $2c206e65
 dc.l $63206469
 dc.l $676e6973
 dc.l $73696d20
 dc.l $70757275
 dc.l $73207275
 dc.l $7472756d
 dc.l $2e204d61
 dc.l $6563656e
 dc.l $61732066
 dc.l $656c6973
 dc.l $20747572
 dc.l $7069732c
 dc.l $20616363
 dc.l $756d7361
 dc.l $6e206163
 dc.l $2076656c
 dc.l $69742061
 dc.l $742c2066
 dc.l $61756369
 dc.l $62757320
 dc.l $6d6f6c65
 dc.l $73746965
 dc.l $20697073
 dc.l $756d2e20
 dc.l $56697661
 dc.l $6d757320
 dc.l $76656e65
 dc.l $6e617469
 dc.l $73206c69
 dc.l $6265726f
 dc.l $2076656c
 dc.l $20657374
 dc.l $20696d70
 dc.l $65726469
 dc.l $65742062
 dc.l $6962656e
 dc.l $64756d2e
 dc.l $2050726f
 dc.l $696e2067
 dc.l $72617669
 dc.l $64612065
 dc.l $73742074
 dc.l $75727069
 dc.l $732c2073
 dc.l $69742061
 dc.l $6d657420
 dc.l $63757273
 dc.l $75732061
 dc.l $75677565
 dc.l $20637572
 dc.l $73757320
 dc.l $75742e20
 dc.l $44756973
 dc.l $20717569
 dc.l $73207475
 dc.l $72706973
 dc.l $20636f6d
 dc.l $6d6f646f
 dc.l $2c20636f
 dc.l $6e736563
 dc.l $74657475
 dc.l $72206c61
 dc.l $63757320
 dc.l $69642c20
 dc.l $6d6f6c6c
 dc.l $69732065
 dc.l $726f732e
 dc.l $20566573
 dc.l $74696275
 dc.l $6c756d20
 dc.l $616e7465
 dc.l $20697073
 dc.l $756d2070
 dc.l $72696d69
 dc.l $7320696e
 dc.l $20666175
 dc.l $63696275
 dc.l $73206f72
 dc.l $6369206c
 dc.l $75637475
 dc.l $73206574
 dc.l $20756c74
 dc.l $72696365
 dc.l $7320706f
 dc.l $73756572
 dc.l $65206375
 dc.l $62696c69
 dc.l $61206375
 dc.l $7261653b
 dc.l $0d0d4e75
 dc.l $6c6c6120
 dc.l $616c6971
 dc.l $75657420
 dc.l $746f7274
 dc.l $6f722061
 dc.l $63206475
 dc.l $69207068
 dc.l $61726574
 dc.l $72612c20
 dc.l $73656420
 dc.l $656c656d
 dc.l $656e7475
 dc.l $6d206469
 dc.l $616d2063
 dc.l $6f6e7365
 dc.l $71756174
 dc.l $2e20496e
 dc.l $74656765
 dc.l $72207361
 dc.l $67697474
 dc.l $6973206c
 dc.l $65637475
 dc.l $73206572
 dc.l $6f732c20
 dc.l $6e656320
 dc.l $6672696e
 dc.l $67696c6c
 dc.l $61207269
 dc.l $73757320
 dc.l $636f6e64
 dc.l $696d656e
 dc.l $74756d20
 dc.l $65676574
 dc.l $2e205072
 dc.l $61657365
 dc.l $6e742070
 dc.l $72657469
 dc.l $756d206d
 dc.l $61737361
 dc.l $20656765
 dc.l $74206c6f
 dc.l $72656d20
 dc.l $736f6461
 dc.l $6c657320
 dc.l $70686172
 dc.l $65747261
 dc.l $20617420
 dc.l $76697461
 dc.l $65206175
 dc.l $6775652e
 dc.l $2050656c
 dc.l $6c656e74
 dc.l $65737175
 dc.l $65206574
 dc.l $206f726e
 dc.l $61726520
 dc.l $66656c69
 dc.l $732e2049
 dc.l $6e206861
 dc.l $63206861
 dc.l $62697461
 dc.l $73736520
 dc.l $706c6174
 dc.l $65612064
 dc.l $69637475
 dc.l $6d73742e
 dc.l $20566573
 dc.l $74696275
 dc.l $6c756d20
 dc.l $64617069
 dc.l $62757320
 dc.l $636f6e64
 dc.l $696d656e
 dc.l $74756d20
 dc.l $6a757374
 dc.l $6f206964
 dc.l $20637572
 dc.l $7375732e
 dc.l $20416c69
 dc.l $7175616d
 dc.l $20616c69
 dc.l $71756574
 dc.l $20706c61
 dc.l $63657261
 dc.l $74206665
 dc.l $6c69732c
 dc.l $20656765
 dc.l $74206566
 dc.l $66696369
 dc.l $74757220
 dc.l $616e7465
 dc.l $20696163
 dc.l $756c6973
 dc.l $2076656c
 dc.l $2e20446f
 dc.l $6e656320
 dc.l $636f6e64
 dc.l $696d656e
 dc.l $74756d20
 dc.l $6f64696f
 dc.l $20636f6d
 dc.l $6d6f646f
 dc.l $2c20756c
 dc.l $74726963
 dc.l $6573206e
 dc.l $756e6320
 dc.l $65742c20
 dc.l $76617269
 dc.l $75732074
 dc.l $656c6c75
 dc.l $732e204d
 dc.l $61757269
 dc.l $73207675
 dc.l $6c707574
 dc.l $61746520
 dc.l $76697461
 dc.l $65206e69
 dc.l $62682073
 dc.l $65642063
 dc.l $6f6e6775
 dc.l $652e2049
 dc.l $6e207675
 dc.l $6c707574
 dc.l $61746520
 dc.l $70686172
 dc.l $65747261
 dc.l $2075726e
 dc.l $61207369
 dc.l $7420616d
 dc.l $65742074
 dc.l $656d706f
 dc.l $722e2049
 dc.l $6e206861
 dc.l $63206861
 dc.l $62697461
 dc.l $73736520
 dc.l $706c6174
 dc.l $65612064
 dc.l $69637475
 dc.l $6d73742e
 dc.l $204e756e
 dc.l $63207465
 dc.l $6d706f72
 dc.l $20646170
 dc.l $69627573
 dc.l $20656765
 dc.l $73746173
 dc.l $2e20446f
 dc.l $6e656320
 dc.l $6469616d
 dc.l $20647569
 dc.l $2c206d6f
 dc.l $6c6c6973
 dc.l $2076656c
 dc.l $20636f6e
 dc.l $67756520
 dc.l $6e65632c
 dc.l $20636f6e
 dc.l $67756520
 dc.l $65676574
 dc.l $206c6f72
 dc.l $656d2e0d
 dc.l $0d50726f
 dc.l $696e2061
 dc.l $63206c75
 dc.l $63747573
 dc.l $206c6163
 dc.l $75732e20
 dc.l $446f6e65
 dc.l $6320696e
 dc.l $20617263
 dc.l $75207574
 dc.l $20736170
 dc.l $69656e20
 dc.l $656c656d
 dc.l $656e7475
 dc.l $6d207665
 dc.l $6e656e61
 dc.l $74697320
 dc.l $73697420
 dc.l $616d6574
 dc.l $20766974
 dc.l $6165206e
 dc.l $756e632e
 dc.l $2050656c
 dc.l $6c656e74
 dc.l $65737175
 dc.l $65206575
 dc.l $20656666
 dc.l $69636974
 dc.l $75722076
 dc.l $656c6974
 dc.l $2e204375
 dc.l $72616269
 dc.l $74757220
 dc.l $636f6e76
 dc.l $616c6c69
 dc.l $73207665
 dc.l $73746962
 dc.l $756c756d
 dc.l $206f726e
 dc.l $6172652e
 dc.l $2050656c
 dc.l $6c656e74
 dc.l $65737175
 dc.l $65206174
 dc.l $206c6163
 dc.l $696e6961
 dc.l $2073656d
 dc.l $2e20446f
 dc.l $6e656320
 dc.l $67726176
 dc.l $6964612c
 dc.l $20617263
 dc.l $75206669
 dc.l $6e696275
 dc.l $73207075
 dc.l $6c76696e
 dc.l $61722076
 dc.l $69766572
 dc.l $72612c20
 dc.l $61726375
 dc.l $20717561
 dc.l $6d206175
 dc.l $63746f72
 dc.l $206e756e
 dc.l $632c2071
 dc.l $75697320
 dc.l $626c616e
 dc.l $64697420
 dc.l $616e7465
 dc.l $206e6571
 dc.l $75652073
 dc.l $69742061
 dc.l $6d657420
 dc.l $65782e20
 dc.l $4d617572
 dc.l $69732061
 dc.l $63206578
 dc.l $20757420
 dc.l $72697375
 dc.l $7320766f
 dc.l $6c757470
 dc.l $6174206d
 dc.l $6f6c6c69
 dc.l $73207369
 dc.l $7420616d
 dc.l $65742061
 dc.l $74206e75
 dc.l $6e632e20
 dc.l $51756973
 dc.l $71756520
 dc.l $61742074
 dc.l $75727069
 dc.l $7320696e
 dc.l $20617263
 dc.l $75206175
 dc.l $63746f72
 dc.l $2068656e
 dc.l $64726572
 dc.l $69742061
 dc.l $74207574
 dc.l $206c6967
 dc.l $756c612e
 dc.l $20416c69
 dc.l $7175616d
 dc.l $206e6973
 dc.l $69206e75
 dc.l $6e632c20
 dc.l $636f6d6d
 dc.l $6f646f20
 dc.l $76697461
 dc.l $65206672
 dc.l $696e6769
 dc.l $6c6c6120
 dc.l $73697420
 dc.l $616d6574
 dc.l $2c20616c
 dc.l $69717565
 dc.l $7420696e
 dc.l $20747572
 dc.l $7069732e
 dc.l $20536564
 dc.l $20766976
 dc.l $65727261
 dc.l $206f7263
 dc.l $69207365
 dc.l $6420646f
 dc.l $6c6f7220
 dc.l $73616769
 dc.l $74746973
 dc.l $20636f6e
 dc.l $6775652e
 dc.l $20496e20
 dc.l $68616320
 dc.l $68616269
 dc.l $74617373
 dc.l $6520706c
 dc.l $61746561
 dc.l $20646963
 dc.l $74756d73
 dc.l $742e2050
 dc.l $656c6c65
 dc.l $6e746573
 dc.l $71756520
 dc.l $68616269
 dc.l $74616e74
 dc.l $206d6f72
 dc.l $62692074
 dc.l $72697374
 dc.l $69717565
 dc.l $2073656e
 dc.l $65637475
 dc.l $73206574
 dc.l $206e6574
 dc.l $75732065
 dc.l $74206d61
 dc.l $6c657375
 dc.l $61646120
 dc.l $66616d65
 dc.l $73206163
 dc.l $20747572
 dc.l $70697320
 dc.l $65676573
 dc.l $7461732e
 dc.l $0d0d4165
 dc.l $6e65616e
 dc.l $20636f6d
 dc.l $6d6f646f
 dc.l $20766974
 dc.l $61652071
 dc.l $75616d20
 dc.l $65742065
 dc.l $66666963
 dc.l $69747572
 dc.l $2e204574
 dc.l $69616d20
 dc.l $6c6f626f
 dc.l $72746973
 dc.l $20657261
 dc.l $74206567
 dc.l $65742065
 dc.l $73742062
 dc.l $6c616e64
 dc.l $69742070
 dc.l $756c7669
 dc.l $6e61722e
 dc.l $2041656e
 dc.l $65616e20
 dc.l $636f6e67
 dc.l $75652065
 dc.l $6e696d20
 dc.l $696e206c
 dc.l $6f72656d
 dc.l $20756c6c
 dc.l $616d636f
 dc.l $72706572
 dc.l $2074696e
 dc.l $63696475
 dc.l $6e742e20
 dc.l $53656420
 dc.l $73697420
 dc.l $616d6574
 dc.l $20727574
 dc.l $72756d20
 dc.l $6e657175
 dc.l $652e2043
 dc.l $72617320
 dc.l $65676574
 dc.l $20636f6e
 dc.l $67756520
 dc.l $6573742e
 dc.l $20537573
 dc.l $70656e64
 dc.l $69737365
 dc.l $20666575
 dc.l $67696174
 dc.l $20646f6c
 dc.l $6f722065
 dc.l $75206c69
 dc.l $6265726f
 dc.l $20707265
 dc.l $7469756d
 dc.l $2070756c
 dc.l $76696e61
 dc.l $722e204e
 dc.l $756e6320
 dc.l $76697665
 dc.l $72726120
 dc.l $74757270
 dc.l $69732065
 dc.l $67657374
 dc.l $61732064
 dc.l $75692063
 dc.l $6f6e6469
 dc.l $6d656e74
 dc.l $756d2063
 dc.l $75727375
 dc.l $732e2055
 dc.l $74206f72
 dc.l $6e617265
 dc.l $20717561
 dc.l $6d207075
 dc.l $7275732c
 dc.l $206e6f6e
 dc.l $20636f6e
 dc.l $73656374
 dc.l $65747572
 dc.l $20646961
 dc.l $6d206566
 dc.l $66696369
 dc.l $74757220
 dc.l $71756973
 dc.l $2e0d0d43
 dc.l $72617320
 dc.l $6d6f6c6c
 dc.l $69732065
 dc.l $73742076
 dc.l $656c206f
 dc.l $64696f20
 dc.l $73757363
 dc.l $69706974
 dc.l $206d6f6c
 dc.l $6c69732e
 dc.l $204e756c
 dc.l $6c612066
 dc.l $6163696c
 dc.l $6973692e
 dc.l $20537573
 dc.l $70656e64
 dc.l $69737365
 dc.l $20647569
 dc.l $206a7573
 dc.l $746f2c20
 dc.l $736f6c6c
 dc.l $69636974
 dc.l $7564696e
 dc.l $20616320
 dc.l $6d616c65
 dc.l $73756164
 dc.l $61206964
 dc.l $2c206d61
 dc.l $74746973
 dc.l $2076656c
 dc.l $206e756e
 dc.l $632e2050
 dc.l $72616573
 dc.l $656e7420
 dc.l $74757270
 dc.l $69732074
 dc.l $6f72746f
 dc.l $722c2066
 dc.l $65756769
 dc.l $61742070
 dc.l $6f737565
 dc.l $7265206d
 dc.l $65747573
 dc.l $2075742c
 dc.l $20636f6e
 dc.l $76616c6c
 dc.l $69732076
 dc.l $61726975
 dc.l $73206e69
 dc.l $736c2e20
 dc.l $53656420
 dc.l $626c616e
 dc.l $64697420
 dc.l $65737420
 dc.l $6d692c20
 dc.l $756c7472
 dc.l $69636573
 dc.l $20626c61
 dc.l $6e646974
 dc.l $206c6f72
 dc.l $656d2070
 dc.l $6c616365
 dc.l $72617420
 dc.l $696e2e20
 dc.l $496e2068
 dc.l $61632068
 dc.l $61626974
 dc.l $61737365
 dc.l $20706c61
 dc.l $74656120
 dc.l $64696374
 dc.l $756d7374
 dc.l $2e204165
 dc.l $6e65616e
 dc.l $206e6f6e
 dc.l $2074656c
 dc.l $6c757320
 dc.l $616e7465
 dc.l $2e204e75
 dc.l $6e63206e
 dc.l $6f6e206e
 dc.l $756e6320
 dc.l $61206e75
 dc.l $6e632076
 dc.l $756c7075
 dc.l $74617465
 dc.l $20706f73
 dc.l $75657265
 dc.l $206e6f6e
 dc.l $20757420
 dc.l $61726375
 dc.l $2e20446f
 dc.l $6e656320
 dc.l $69642069
 dc.l $7073756d
 dc.l $20757420
 dc.l $6c656f20
 dc.l $696e7465
 dc.l $7264756d
 dc.l $20626962
 dc.l $656e6475
 dc.l $6d207365
 dc.l $64206567
 dc.l $6574206d
 dc.l $61737361
 dc.l $2e205375
 dc.l $7370656e
 dc.l $64697373
 dc.l $65207365
 dc.l $6420656e
 dc.l $696d2076
 dc.l $69746165
 dc.l $20697073
 dc.l $756d2064
 dc.l $61706962
 dc.l $75732070
 dc.l $72657469
 dc.l $756d2e0d
 dc.l $0d4d6175
 dc.l $72697320
 dc.l $756c6c61
 dc.l $6d636f72
 dc.l $70657220
 dc.l $6d616c65
 dc.l $73756164
 dc.l $61206665
 dc.l $6c69732e
 dc.l $2050656c
 dc.l $6c656e74
 dc.l $65737175
 dc.l $65207365
 dc.l $6420696e
 dc.l $74657264
 dc.l $756d206d
 dc.l $65747573
 dc.l $2e204e75
 dc.l $6c6c616d
 dc.l $20626962
 dc.l $656e6475
 dc.l $6d206175
 dc.l $67756520
 dc.l $76656c20
 dc.l $6a757374
 dc.l $6f207469
 dc.l $6e636964
 dc.l $756e742c
 dc.l $20657520
 dc.l $706c6163
 dc.l $65726174
 dc.l $20617567
 dc.l $75652061
 dc.l $7563746f
 dc.l $722e204e
 dc.l $756c6c61
 dc.l $20656765
 dc.l $7420706f
 dc.l $73756572
 dc.l $65206175
 dc.l $6775652e
 dc.l $20496e74
 dc.l $65676572
 dc.l $20612070
 dc.l $72657469
 dc.l $756d2064
 dc.l $69616d2c
 dc.l $20736974
 dc.l $20616d65
 dc.l $74207469
 dc.l $6e636964
 dc.l $756e7420
 dc.l $656e696d
 dc.l $2e205365
 dc.l $64206574
 dc.l $2068656e
 dc.l $64726572
 dc.l $6974206c
 dc.l $69626572
 dc.l $6f2c2069
 dc.l $64207068
 dc.l $61726574
 dc.l $72612074
 dc.l $6f72746f
 dc.l $722e2044
 dc.l $6f6e6563
 dc.l $2061206c
 dc.l $75637475
 dc.l $73206e75
 dc.l $6c6c612e
 dc.l $204d6f72
 dc.l $62692065
 dc.l $7569736d
 dc.l $6f64206e
 dc.l $756c6c61
 dc.l $206c6563
 dc.l $7475732c
 dc.l $2076656c
 dc.l $2066696e
 dc.l $69627573
 dc.l $206f7263
 dc.l $6920656c
 dc.l $65696665
 dc.l $6e642073
 dc.l $69742061
 dc.l $6d65742e
 dc.l $204e616d
 dc.l $20706f73
 dc.l $75657265
 dc.l $2c206e69
 dc.l $736c206e
 dc.l $6f6e2063
 dc.l $6f6e6469
 dc.l $6d656e74
 dc.l $756d2076
 dc.l $656e656e
 dc.l $61746973
 dc.l $2c206c69
 dc.l $67756c61
 dc.l $2075726e
 dc.l $6120696d
 dc.l $70657264
 dc.l $69657420
 dc.l $6f726369
 dc.l $2c206575
 dc.l $20766976
 dc.l $65727261
 dc.l $20697073
 dc.l $756d206c
 dc.l $61637573
 dc.l $20757420
 dc.l $76656c69
 dc.l $742e2046
 dc.l $75736365
 dc.l $2076656c
 dc.l $20736365
 dc.l $6c657269
 dc.l $73717565
 dc.l $206c6563
 dc.l $7475732e
 dc.l $20557420
 dc.l $65742073
 dc.l $656d7065
 dc.l $7220616e
 dc.l $74652e0d
 dc.l $0d566976
 dc.l $616d7573
 dc.l $20757420
 dc.l $73616769
 dc.l $74746973
 dc.l $206c6563
 dc.l $7475732c
 dc.l $20766974
 dc.l $61652062
 dc.l $6962656e
 dc.l $64756d20
 dc.l $616e7465
 dc.l $2e204372
 dc.l $61732073
 dc.l $69742061
 dc.l $6d657420
 dc.l $72757472
 dc.l $756d2064
 dc.l $6f6c6f72
 dc.l $2e205665
 dc.l $73746962
 dc.l $756c756d
 dc.l $20736365
 dc.l $6c657269
 dc.l $73717565
 dc.l $20657261
 dc.l $74206e65
 dc.l $7175652c
 dc.l $206e6f6e
 dc.l $2072686f
 dc.l $6e637573
 dc.l $20616e74
 dc.l $65206d61
 dc.l $6c657375
 dc.l $61646120
 dc.l $6e6f6e2e
 dc.l $204d6f72
 dc.l $62692066
 dc.l $72696e67
 dc.l $696c6c61
 dc.l $20696420
 dc.l $65737420
 dc.l $6e656320
 dc.l $6665726d
 dc.l $656e7475
 dc.l $6d2e2043
 dc.l $75726162
 dc.l $69747572
 dc.l $206e6f6e
 dc.l $206f6469
 dc.l $6f206d61
 dc.l $78696d75
 dc.l $732c2066
 dc.l $6163696c
 dc.l $69736973
 dc.l $20656c69
 dc.l $74206e65
 dc.l $632c2063
 dc.l $6f6e6469
 dc.l $6d656e74
 dc.l $756d2065
 dc.l $73742e20
 dc.l $41656e65
 dc.l $616e2076
 dc.l $69746165
 dc.l $20657374
 dc.l $20666575
 dc.l $67696174
 dc.l $2c20636f
 dc.l $6e76616c
 dc.l $6c697320
 dc.l $6d617373
 dc.l $61206964
 dc.l $2c207665
 dc.l $68696375
 dc.l $6c612064
 dc.l $6f6c6f72
 dc.l $2e204e61
 dc.l $6d20656c
 dc.l $656d656e
 dc.l $74756d20
 dc.l $6e657175
 dc.l $65206e69
 dc.l $73692c20
 dc.l $66696e69
 dc.l $62757320
 dc.l $76656e65
 dc.l $6e617469
 dc.l $73206d61
 dc.l $73736120
 dc.l $63757273
 dc.l $75732071
 dc.l $7569732e
 dc.l $20457469
 dc.l $616d2061
 dc.l $74206d65
 dc.l $74757320
 dc.l $76697461
 dc.l $65206572
 dc.l $61742076
 dc.l $61726975
 dc.l $7320636f
 dc.l $6e76616c
 dc.l $6c69732e
 dc.l $20536564
 dc.l $2076656e
 dc.l $656e6174
 dc.l $69732070
 dc.l $75727573
 dc.l $20766974
 dc.l $61652061
 dc.l $7563746f
 dc.l $7220636f
 dc.l $6d6d6f64
 dc.l $6f2e2050
 dc.l $68617365
 dc.l $6c6c7573
 dc.l $20696420
 dc.l $65726f73
 dc.l $206f7263
 dc.l $692e2044
 dc.l $75697320
 dc.l $74726973
 dc.l $74697175
 dc.l $65206c61
 dc.l $63757320
 dc.l $61632061
 dc.l $6c697175
 dc.l $65742076
 dc.l $69766572
 dc.l $72612e20
 dc.l $45746961
 dc.l $6d207665
 dc.l $68696375
 dc.l $6c612070
 dc.l $6f727461
 dc.l $2075726e
 dc.l $61207574
 dc.l $2076756c
 dc.l $70757461
 dc.l $74652e20
 dc.l $41656e65
 dc.l $616e2074
 dc.l $75727069
 dc.l $73206f64
 dc.l $696f2c20
 dc.l $766f6c75
 dc.l $74706174
 dc.l $20696e20
 dc.l $6a757374
 dc.l $6f206567
 dc.l $65742c20
 dc.l $76657374
 dc.l $6962756c
 dc.l $756d206d
 dc.l $616c6573
 dc.l $75616461
 dc.l $206d6175
 dc.l $7269732e
 dc.l $20496e20
 dc.l $64696374
 dc.l $756d2065
 dc.l $6c656d65
 dc.l $6e74756d
 dc.l $20706f72
 dc.l $74612e20
 dc.l $4e756c6c
 dc.l $61206661
 dc.l $63696c69
 dc.l $73692e20
 dc.l $416c6971
 dc.l $75616d20
 dc.l $65726174
 dc.l $20766f6c
 dc.l $75747061
 dc.l $742e0d0d
 dc.l $496e2068
 dc.l $61632068
 dc.l $61626974
 dc.l $61737365
 dc.l $20706c61
 dc.l $74656120
 dc.l $64696374
 dc.l $756d7374
 dc.l $2e205065
 dc.l $6c6c656e
 dc.l $74657371
 dc.l $75652068
 dc.l $61626974
 dc.l $616e7420
 dc.l $6d6f7262
 dc.l $69207472
 dc.l $69737469
 dc.l $71756520
 dc.l $73656e65
 dc.l $63747573
 dc.l $20657420
 dc.l $6e657475
 dc.l $73206574
 dc.l $206d616c
 dc.l $65737561
 dc.l $64612066
 dc.l $616d6573
 dc.l $20616320
 dc.l $74757270
 dc.l $69732065
 dc.l $67657374
 dc.l $61732e20
 dc.l $51756973
 dc.l $71756520
 dc.l $6f726e61
 dc.l $72652065
 dc.l $67657420
 dc.l $61756775
 dc.l $65207365
 dc.l $6420616c
 dc.l $69717561
 dc.l $6d2e2051
 dc.l $75697371
 dc.l $7565206e
 dc.l $6563206a
 dc.l $7573746f
 dc.l $20736564
 dc.l $206a7573
 dc.l $746f206c
 dc.l $75637475
 dc.l $73207068
 dc.l $61726574
 dc.l $72612e20
 dc.l $43726173
 dc.l $2070656c
 dc.l $6c656e74
 dc.l $65737175
 dc.l $65207665
 dc.l $6c697420
 dc.l $65752066
 dc.l $656c6973
 dc.l $20617563
 dc.l $746f722c
 dc.l $2076656c
 dc.l $20736f64
 dc.l $616c6573
 dc.l $20726973
 dc.l $75732066
 dc.l $61756369
 dc.l $6275732e
 dc.l $20557420
 dc.l $636f6e73
 dc.l $65637465
 dc.l $74757220
 dc.l $76656e65
 dc.l $6e617469
 dc.l $73206c6f
 dc.l $626f7274
 dc.l $69732e20
 dc.l $4e756c6c
 dc.l $616d206e
 dc.l $6f6e2070
 dc.l $6f727474
 dc.l $69746f72
 dc.l $20656e69
 dc.l $6d2e2049
 dc.l $6e746567
 dc.l $65722070
 dc.l $6f727474
 dc.l $69746f72
 dc.l $2065726f
 dc.l $73206e65
 dc.l $6320656c
 dc.l $656d656e
 dc.l $74756d20
 dc.l $6c616f72
 dc.l $6565742e
 dc.l $20467573
 dc.l $63652073
 dc.l $6f6c6c69
 dc.l $63697475
 dc.l $64696e20
 dc.l $6c616f72
 dc.l $65657420
 dc.l $70756c76
 dc.l $696e6172
 dc.l $2e205072
 dc.l $6f696e20
 dc.l $73757363
 dc.l $69706974
 dc.l $2c207665
 dc.l $6c697420
 dc.l $73656420
 dc.l $64617069
 dc.l $62757320
 dc.l $636f6d6d
 dc.l $6f646f2c
 dc.l $20646f6c
 dc.l $6f722071
 dc.l $75616d20
 dc.l $736f6c6c
 dc.l $69636974
 dc.l $7564696e
 dc.l $206d6173
 dc.l $73612c20
 dc.l $73697420
 dc.l $616d6574
 dc.l $20677261
 dc.l $76696461
 dc.l $20617263
 dc.l $75207572
 dc.l $6e612065
 dc.l $67657420
 dc.l $746f7274
 dc.l $6f722e20
 dc.l $55742065
 dc.l $6c656d65
 dc.l $6e74756d
 dc.l $2065726f
 dc.l $73207175
 dc.l $69732070
 dc.l $75727573
 dc.l $2070756c
 dc.l $76696e61
 dc.l $722c2065
 dc.l $74206665
 dc.l $726d656e
 dc.l $74756d20
 dc.l $65737420
 dc.l $7363656c
 dc.l $65726973
 dc.l $7175652e
 dc.l $20517569
 dc.l $73717565
 dc.l $20766172
 dc.l $69757320
 dc.l $70726574
 dc.l $69756d20
 dc.l $696d7065
 dc.l $72646965
 dc.l $742e0d0d
 dc.l $4d616563
 dc.l $656e6173
 dc.l $2074696e
 dc.l $63696475
 dc.l $6e742075
 dc.l $74207361
 dc.l $7069656e
 dc.l $20757420
 dc.l $6c6f626f
 dc.l $72746973
 dc.l $2e20416c
 dc.l $69717561
 dc.l $6d206572
 dc.l $61742076
 dc.l $6f6c7574
 dc.l $7061742e
 dc.l $20537573
 dc.l $70656e64
 dc.l $69737365
 dc.l $20766172
 dc.l $69757320
 dc.l $73656d20
 dc.l $6e696268
 dc.l $2c206120
 dc.l $7363656c
 dc.l $65726973
 dc.l $71756520
 dc.l $73656d20
 dc.l $76756c70
 dc.l $75746174
 dc.l $65206174
 dc.l $2e205574
 dc.l $206c6f62
 dc.l $6f727469
 dc.l $73206d6f
 dc.l $6c6c6973
 dc.l $206f7263
 dc.l $692c2071
 dc.l $75697320
 dc.l $74656d70
 dc.l $6f722074
 dc.l $656c6c75
 dc.l $73206c6f
 dc.l $626f7274
 dc.l $6973206e
 dc.l $65632e20
 dc.l $43726173
 dc.l $20657569
 dc.l $736d6f64
 dc.l $20696d70
 dc.l $65726469
 dc.l $6574206e
 dc.l $69736920
 dc.l $6574206c
 dc.l $75637475
 dc.l $732e204d
 dc.l $61656365
 dc.l $6e617320
 dc.l $61742073
 dc.l $61706965
 dc.l $6e206163
 dc.l $20707572
 dc.l $75732065
 dc.l $6c656966
 dc.l $656e6420
 dc.l $706f7274
 dc.l $7469746f
 dc.l $722e204e
 dc.l $756e6320
 dc.l $76656c20
 dc.l $756c7472
 dc.l $69636573
 dc.l $2074656c
 dc.l $6c75732c
 dc.l $206e6f6e
 dc.l $20636f6d
 dc.l $6d6f646f
 dc.l $206f7263
 dc.l $692e2053
 dc.l $75737065
 dc.l $6e646973
 dc.l $73652076
 dc.l $656e656e
 dc.l $61746973
 dc.l $2076656c
 dc.l $20747572
 dc.l $70697320
 dc.l $6f726e61
 dc.l $72652073
 dc.l $656d7065
 dc.l $722e2044
 dc.l $6f6e6563
 dc.l $20617563
 dc.l $746f7220
 dc.l $61756775
 dc.l $65206574
 dc.l $20736f64
 dc.l $616c6573
 dc.l $20766568
 dc.l $6963756c
 dc.l $612e2051
 dc.l $75697371
 dc.l $75652063
 dc.l $6f6e6469
 dc.l $6d656e74
 dc.l $756d2061
 dc.l $75677565
 dc.l $20736974
 dc.l $20616d65
 dc.l $74207469
 dc.l $6e636964
 dc.l $756e7420
 dc.l $6665726d
 dc.l $656e7475
 dc.l $6d2e2050
 dc.l $656c6c65
 dc.l $6e746573
 dc.l $71756520
 dc.l $68616269
 dc.l $74616e74
 dc.l $206d6f72
 dc.l $62692074
 dc.l $72697374
 dc.l $69717565
 dc.l $2073656e
 dc.l $65637475
 dc.l $73206574
 dc.l $206e6574
 dc.l $75732065
 dc.l $74206d61
 dc.l $6c657375
 dc.l $61646120
 dc.l $66616d65
 dc.l $73206163
 dc.l $20747572
 dc.l $70697320
 dc.l $65676573
 dc.l $7461732e
 dc.l $204d6f72
 dc.l $62692074
 dc.l $72697374
 dc.l $69717565
 dc.l $20766573
 dc.l $74696275
 dc.l $6c756d20
 dc.l $696e7465
 dc.l $7264756d
 dc.l $2e0d0d4d
 dc.l $61656365
 dc.l $6e617320
 dc.l $6469676e
 dc.l $69737369
 dc.l $6d206572
 dc.l $6f732074
 dc.l $6f72746f
 dc.l $722c2061
 dc.l $6320656c
 dc.l $656d656e
 dc.l $74756d20
 dc.l $72697375
 dc.l $73206669
 dc.l $6e696275
 dc.l $73206567
 dc.l $65742e20
 dc.l $50726165
 dc.l $73656e74
 dc.l $20757420
 dc.l $6e696268
 dc.l $206e6571
 dc.l $75652e20
 dc.l $4e756c6c
 dc.l $61206c65
 dc.l $6f206970
 dc.l $73756d2c
 dc.l $20656666
 dc.l $69636974
 dc.l $75722065
 dc.l $7420756c
 dc.l $74726963
 dc.l $65732071
 dc.l $7569732c
 dc.l $20626c61
 dc.l $6e646974
 dc.l $2061206e
 dc.l $756e632e
 dc.l $204e756e
 dc.l $63206461
 dc.l $70696275
 dc.l $73207665
 dc.l $73746962
 dc.l $756c756d
 dc.l $2076656e
 dc.l $656e6174
 dc.l $69732e20
 dc.l $4d6f7262
 dc.l $69207175
 dc.l $616d2061
 dc.l $7263752c
 dc.l $20616363
 dc.l $756d7361
 dc.l $6e207665
 dc.l $6c207068
 dc.l $61726574
 dc.l $72612069
 dc.l $642c206f
 dc.l $726e6172
 dc.l $65206120
 dc.l $6475692e
 dc.l $20416c69
 dc.l $7175616d
 dc.l $20657261
 dc.l $7420766f
 dc.l $6c757470
 dc.l $61742e20
 dc.l $416c6971
 dc.l $75616d20
 dc.l $65726174
 dc.l $20766f6c
 dc.l $75747061
 dc.l $742e204d
 dc.l $6f726269
 dc.l $20657420
 dc.l $72686f6e
 dc.l $63757320
 dc.l $6573742e
 dc.l $20446f6e
 dc.l $65632070
 dc.l $68617265
 dc.l $74726120
 dc.l $6e657175
 dc.l $65206575
 dc.l $206d6173
 dc.l $7361206c
 dc.l $6f626f72
 dc.l $74697320
 dc.l $656c6569
 dc.l $66656e64
 dc.l $2e204e75
 dc.l $6c6c6120
 dc.l $69642073
 dc.l $656d2071
 dc.l $75697320
 dc.l $69707375
 dc.l $6d206175
 dc.l $63746f72
 dc.l $2076756c
 dc.l $70757461
 dc.l $74652e20
 dc.l $50656c6c
 dc.l $656e7465
 dc.l $73717565
 dc.l $20686162
 dc.l $6974616e
 dc.l $74206d6f
 dc.l $72626920
 dc.l $74726973
 dc.l $74697175
 dc.l $65207365
 dc.l $6e656374
 dc.l $75732065
 dc.l $74206e65
 dc.l $74757320
 dc.l $6574206d
 dc.l $616c6573
 dc.l $75616461
 dc.l $2066616d
 dc.l $65732061
 dc.l $63207475
 dc.l $72706973
 dc.l $20656765
 dc.l $73746173
 dc.l $2e205175
 dc.l $69737175
 dc.l $65207574
 dc.l $20636f6e
 dc.l $73657175
 dc.l $61742061
 dc.l $7263752e
 dc.l $204e756c
 dc.l $6c612073
 dc.l $69742061
 dc.l $6d657420
 dc.l $64756920
 dc.l $6e6f6e20
 dc.l $6f64696f
 dc.l $2070656c
 dc.l $6c656e74
 dc.l $65737175
 dc.l $65207472
 dc.l $69737469
 dc.l $7175652e
 dc.l $0d0d446f
 dc.l $6e656320
 dc.l $66656c69
 dc.l $7320746f
 dc.l $72746f72
 dc.l $2c206c61
 dc.l $63696e69
 dc.l $61206574
 dc.l $2074696e
 dc.l $63696475
 dc.l $6e742075
 dc.l $742c2070
 dc.l $656c6c65
 dc.l $6e746573
 dc.l $71756520
 dc.l $6e656320
 dc.l $6e756c6c
 dc.l $612e2056
 dc.l $6976616d
 dc.l $75732073
 dc.l $63656c65
 dc.l $72697371
 dc.l $75652076
 dc.l $65686963
 dc.l $756c6120
 dc.l $6c696775
 dc.l $6c612c20
 dc.l $73697420
 dc.l $616d6574
 dc.l $2074696e
 dc.l $63696475
 dc.l $6e742073
 dc.l $61706965
 dc.l $6e20656c
 dc.l $65696665
 dc.l $6e642076
 dc.l $6f6c7574
 dc.l $7061742e
 dc.l $20507261
 dc.l $6573656e
 dc.l $74206d61
 dc.l $78696d75
 dc.l $73206475
 dc.l $69206574
 dc.l $206e6973
 dc.l $69207375
 dc.l $73636970
 dc.l $69742070
 dc.l $756c7669
 dc.l $6e61722e
 dc.l $2050656c
 dc.l $6c656e74
 dc.l $65737175
 dc.l $65206861
 dc.l $62697461
 dc.l $6e74206d
 dc.l $6f726269
 dc.l $20747269
 dc.l $73746971
 dc.l $75652073
 dc.l $656e6563
 dc.l $74757320
 dc.l $6574206e
 dc.l $65747573
 dc.l $20657420
 dc.l $6d616c65
 dc.l $73756164
 dc.l $61206661
 dc.l $6d657320
 dc.l $61632074
 dc.l $75727069
 dc.l $73206567
 dc.l $65737461
 dc.l $732e204e
 dc.l $756e6320
 dc.l $696e2074
 dc.l $656c6c75
 dc.l $73206572
 dc.l $61742e20
 dc.l $4d616563
 dc.l $656e6173
 dc.l $20616363
 dc.l $756d7361
 dc.l $6e206e65
 dc.l $71756520
 dc.l $73697420
 dc.l $616d6574
 dc.l $206e6973
 dc.l $6c206661
 dc.l $63696c69
 dc.l $7369732c
 dc.l $20656765
 dc.l $7420756c
 dc.l $74726963
 dc.l $6573206e
 dc.l $756e6320
 dc.l $70686172
 dc.l $65747261
 dc.l $2e205669
 dc.l $76616d75
 dc.l $73206574
 dc.l $206e6973
 dc.l $69206574
 dc.l $206c6962
 dc.l $65726f20
 dc.l $70726574
 dc.l $69756d20
 dc.l $636f6d6d
 dc.l $6f646f2e
 dc.l $20537573
 dc.l $70656e64
 dc.l $69737365
 dc.l $20696e20
 dc.l $766f6c75
 dc.l $74706174
 dc.l $206d692c
 dc.l $20766974
 dc.l $61652074
 dc.l $696e6369
 dc.l $64756e74
 dc.l $20746f72
 dc.l $746f722e
 dc.l $20536564
 dc.l $2076656c
 dc.l $206c6563
 dc.l $74757320
 dc.l $65726f73
 dc.l $2e20446f
 dc.l $6e656320
 dc.l $736f6c6c
 dc.l $69636974
 dc.l $7564696e
 dc.l $20736365
 dc.l $6c657269
 dc.l $73717565
 dc.l $206c6f72
 dc.l $656d2c20
 dc.l $65676574
 dc.l $2074656d
 dc.l $70757320
 dc.l $7175616d
 dc.l $20727574
 dc.l $72756d20
 dc.l $75742e0d
 dc.l $0d416c69
 dc.l $7175616d
 dc.l $20766976
 dc.l $65727261
 dc.l $2070656c
 dc.l $6c656e74
 dc.l $65737175
 dc.l $65206970
 dc.l $73756d20
 dc.l $706f7375
 dc.l $65726520
 dc.l $656c656d
 dc.l $656e7475
 dc.l $6d2e0000



 ends 

main: link.w A5,#0
 movem.l a0/d0-d1/d4,-(sp)
 move.l #-68,d0
 bsr.w _stkcheck
 moveq #0,d4
 bra.s L00028
L00016 move.l d4,d0
 lsl.l #2,d0
 movea.l #0,a0
 adda.l a6,a0
 move.l d4,(a0,d0.l)
 addq.l #1,d4
L00028 cmpi.l #10000,d4
 bcs.s L00016
 movea.l #0,a0
 adda.l a6,a0
 move.l a0,d1
 lea.l L0004e(pc),a0
 move.l a0,d0
 bsr.w printf
 movem.l -12(a5),a0/d1/d4
 unlk A5
 rts 
L0004e addq.w #1,-(a5)
 dc.w $6d6f
 moveq #101,d2
 dc.w $2073
 moveq #114,d2
 bvs.s L000c8
 beq.s L00096
 move.l -(a5),d0
 dc.w $7300

 ends 

