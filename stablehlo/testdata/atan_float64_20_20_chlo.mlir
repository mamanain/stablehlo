// RUN: stablehlo-opt --chlo-pre-serialization-pipeline -inline %s | stablehlo-translate --interpret
// RUN: stablehlo-opt --chlo-pre-serialization-pipeline %s | stablehlo-translate --serialize --target=current | stablehlo-translate --deserialize | stablehlo-opt > %t.0
// RUN: stablehlo-opt --chlo-pre-serialization-pipeline %s > %t.1
// RUN: diff %t.0 %t.1

module @jit_main attributes {mhlo.num_partitions = 1 : i32, mhlo.num_replicas = 1 : i32} {
  func.func public @main() -> (tensor<20x20xf64> {jax.result_info = "", mhlo.layout_mode = "default"}) {
    %0 = call @inputs() : () -> tensor<20x20xf64>
    %1 = call @expected() : () -> tensor<20x20xf64>
    %2 = chlo.atan %0 : tensor<20x20xf64> -> tensor<20x20xf64>
    stablehlo.custom_call @check.expect_close(%2, %1) {has_side_effect = true} : (tensor<20x20xf64>, tensor<20x20xf64>) -> ()
    return %2 : tensor<20x20xf64>
  }
  func.func private @inputs() -> (tensor<20x20xf64> {mhlo.layout_mode = "default"}) {
    %cst = stablehlo.constant dense<"0xD2FB6E744DCAE0BF7CB17DA9E53F11C0F823FB66D00917C0E43A99E83670FD3F4B06F58DF79210C02E7F7B0E0EEF15C096EF651744A7FB3FE8F365DD0B90FCBFFE3972DAE88B09C046C4D1C45DAF04C0FC7C92B270F0ED3F12A08CE27A13134076F4B75B3577FBBF28E0613EDE2412400071F9BBEE990DC0CCA6358C817E02C058E9530518EF0840E41DAA5222A0F63F167DB8DB8230FDBFDC7C2DF548840A40F25506923CC51640C6B2AF2392DA15C006C80514860AF4BF1028D3D5D0EA05C050F0E9F5288510C03EFE3DFFA46B164057BDE17146A5EEBF62538B4B5D260840527A2F0433E7F13F71B3624F7187C43F6FF8E3CBE8B4E0BFA5DFDF30B34EBDBF90F2BC88686AF83F3BC73CCB4F9CEEBF2E1483B5CF0FDF3FE80A2C0390271540070A507EE5620640D4C03496FDD7E7BF827888CCDE371440F66A6E4C394EE9BF374F2E7AF1BC12C01F23F0A0EC0CFB3F48DE316744FDF1BF4B302C09B2F3F5BFD96A5523AEBDF33FBE6DC8E1E47BFD3F284265EA7997F8BF1C369C28CB84E93FF45C3D2D35AB13C021C7BD525464D73F22FE5215583EF4BFA21A4A35B3600DC0CA0F176C2E80F5BF3678498CB10DF83F101514B0174D07C0D93D1B487117E0BF8F13005C719006C0BD652E051679FA3F70727E005912DCBFCE544FF088860140F8FE2B075802104040A17A122D37EABFFEE1A14D26D304C04803FA0B339BE4BF541BE5B00A67FCBF186BF52714831D40C03257277A5612C0400D922CEE9A0740CB442A199F06C93FDC5D4E4EC326F43F9C6443AE9D6EF8BFF2BDC03F49A6E3BF86AED7A9837C09C0404F4B52BF5DFFBF12C501E6A20A1340FDC6D89DE263F5BF5857818ED0DE10C0A0EB86279D81FC3F49D3782B411DE2BF0645B0004B8601C049006ED30CFDDCBF659F92E1B62F1C40249C79142C09EEBF7D22E396F5B4F33FF0B806A22F18DC3FCC1DDE8CBA87D2BF977F0E1C4B0EE03F749DBF2734BFEDBF50BE713DAB4508C048E6122A05471DC090F59456BB89E43F0FD8F9F4A6C60FC0C073D74BB02DFB3FD66576FA5BA4D43F6261EF9516CCF6BF3718EF259D6CCFBF57FCB405521F03C0E817D5E774280BC05473C4386179FEBF1A4F6D00BED6E43FC2CCA827BBD4F6BFC307534F7BFD09C0AC5F6C0FD4F60A40CB89B92DB2900D404E92D4FF709D0940FCFC1814B14AF8BFEE1EE9786F3906C0E1F05DBBA904F8BFE8B7677CAD6FF7BF6094C66EF750C9BF82521267A27A0D4074ADD79F1FF7C7BFD69310C7A0EE0CC040E38CF3EF6CF13F90AB52344A92D4BF049CDAEF3E400CC076A8ADA775E510C015CCF7CE1D7200C0E98E218952E2D53F9CAF2050E2860B406AD8C872C5C8EA3F08D44BFE2E900C40B270D447B0960CC0CDE53C5FCAD8D2BFA6ACD403B0CAE33FF94512CA816CDDBF06DEC53FA754FF3F7E123193ED5C9BBF5EE7425D9B02064058593B8D677E034010D68F205B0DDABFCDA64C2D09290FC0E8FB267D9B7318C06BA5AD2530F6F33F2A7106E72057E5BF6EC955734A46E4BF8E1089E9C1190BC00CC40534E2B401C00F83DAFD52F2014093CC93CE68FBD2BF62450D3880A4F7BF1EBCAA2AFD7304C0564219B1D50FD8BFD53DA9D0A280F6BFDE85269D578EB0BF868C62078FD005C07617E505E026F0BF709CD45B0AA3DB3F1AC7DC3222B504C0ADFC4402D87CEA3F48EC2E930EAEFD3F00B539B0D669EA3F0257B487FB7709C05CD6DD94A300F83F21F0842321C9F9BF238182D9ECFFDBBF36CE32A90C47F0BFC0DB1CD6038B1BC0EB0C991E08AEE83F68D04E3BF2E20AC061BC35D6F8EDC7BF92C1ECE286BA0240D90BB578039DE1BFBAE830C5990CD0BFAFC0B0D3A4FEE73F4A384C878CB900C0940E26B4DD1213C05802FBE5A14803C0FAA6DD651E111540867D0790D5A715409442810B5FD2DE3F89E83C9863C302C01880987567A60D402660F20C9F000B40C0DCDD63595CFF3F8734FA259B00F63FD4C70146D73305C021DC9F8523C9F33F28A94ABEA4EFFF3F104B116C38DA0DC00D3812E6A29718403ECBB9E8A241F2BFE088D7ED86BBFCBFAD3A22FB38DD1040A674784A0A00EB3FE8D26DBAE30CE9BF6D8F6C88C40F0040F25734A8D6CFE6BF3675A3F4F703ECBFFBA398974A3103C07A2B931BE7A9EABFE044BDFDE4C820C00367B1182A1D03C06C0B361A4A5C074088C4B9147776CB3FD65D5F7FD40DEE3F7C87A3E310AF1A4068EF1DAF4C2AF63F46525B3BF8EBF03FCC74A3162DD4DA3F21A15CF235A912C05E7925FE605DF03F63FB596EE85004C0DC447B123B30DC3F158A09C70BA3F63FF4441B7F9BDC06C05C13014F888011C01A06C0BB77B4E1BF2C032DB36045D0BF670B02A55CF8034096345DFD998715404A4BA3965B8EFC3F640B1A1F832701C0B70A43F547C6F83F786E38E38E720D4046D53095DDA72040EEAF0FAC082A13C0C2AEF51146AEFEBF760A2B34CF89D93F00B07333D84DE5BFD03E7B8ABDE808403016DC789D4FE1BF8E31CCE91B200740D728A8200798F33F334A8636BED8A9BF0F38758A6FF910C0DCA1F8C4758D02C04B329D00684316408E1B649AF5690340D42A0E5EC303FCBF3065D742665A154031EABD64030FF73F1449864F322701408C04BB0DA0B80D406CEC8490CC161B406066E307456FF23F16ACC71501E5FC3FF4D655815ED60840605D9C41A687D8BFF9B075E584431A407FCA4FA161B7FE3FA7699D2CBA390C40A65C707FEBFFD23F6D98A900C022F43FCC9A380B0A059D3F110742B7CFBAFE3F82F995191CAC14C02652D590DAACF93F238125BB4B440040149FF4059B8C0740FDE7EC2C803CDDBFA88AB1897B13E53FBE863CE927A30A400D30CD9BDEB90BC0C6546C832F3E13C07490EDD237AFEEBFB6D745B639CFFEBF138282A375AD06401C49BCD3BE5ADF3FE651E0299FD905C0985DE6F37B650F40CCB86657347E18C0EA14357CD4C002C0CC2BB8366EB9D8BF043AA1A1A6C5E0BF82AF55632309FA3F5C3FC8FC226709C007D60B360CA106C0E0ADCC7F2D340AC08983599B729E02C097852DAE5F5C0E40E4E10DB4865FF8BF1021AA29BFBAE73FC8B7772508530FC0BA19CF25177DD63F8B0F6C94C70E02C09DF09BDA5E5601401AB87B313FE10BC00037B859B2E2D0BFA8219B787631CBBFEE242CE097B31740D877170BC619FF3F44CF325FB74CD6BFECDD242D6084EB3FBB5D13620914E23FFDBB9F81E29105401AE5EF1E446FF83F62BDC6F9E6951AC0157216469843E9BF76BBEF516C979ABFA92A7844307206C06A93D740A33F00C048353C45A39E1240422732AF621C19C078C57E36080E08407A88205FBB7A0E40E4055B0391D325C06A33DCF1BA54F2BF5056155823D70DC03A5D921B45DA0A40F8995D0994710940F18FE2B6142DE13F85661E2C93A1F23F8D46918468CB22402EDB23CE6C51D6BFE761CF3003A7E43F246C44C68E36FDBF100D717636D20740FDEA257E4B0D1340301FE822EDC701C0E0C12334306512C09E23FB415804F53FB9229F55F4D206C0D4C749887B58EABF446B0F668CC311C01F44326AC7BB02C0DE8BFF7683ADF43F9BF50D22E0C7D4BF69D787DACA420440143E65819DCC06C01215BBBF6506DBBF8C89DAA8D46F18C04469CA4650220AC0CD3589BD8A1AF2BFFB9D6A06DB2A1440169F97C2AFACD63FF7F0B129144D00C09677FA34257A1A40F4F645EA73BCFB3FB86A2E28BE700040A89A6AC54044004058F801F34AF104C06F5736BAC0D904C0EA36497A7242004052AAFB5AF2ACE0BF0475B3CD5CC5FABF87685DE07934F83F528DD5F9D48FF7BFAE6802A4E6AC0E40EF5E3CFE2436E2BF3B97C7D0ADF40340CEB12AC193DBCD3FD0112A02C79009C08A7AD0D0AC73F8BF288147E2F7AE0A40A4F931019B0CEB3F02B5E92EEF07F6BF9274F4627BAD15407899F0CCA621D8BFC43A8BE2EE81E2BFCB781F5729D102C0C05816EDD1421A40787F7D266399EEBFAC7513BCEB1F0FC0640433F50C881BC0D01379350C11DABF90F696CB45C305C07EAD62E11D41FC3F1E804970C9290840E8A88382891BEA3F92604121FF9804C0C60C31191C00EE3F78089E558B041BC0270D81E60A530840D5C76FAF905D2040F53A228C8407EDBF2BD3188C9B5D01C0B05DCEEF9A4B084032F0E28BA77815C0DE6CB0297DBEE93FE63F4B5B0DD7F83F5D9A780F9BE30C403AC93D0227FAE4BF7A4037A0BAFFE53F2A2D339490C0DF3FF89947DED72F1540D3090C96D82F05C074B12D1E6090F9BFB790EA3A9F7504C006D371292D8813C0147A641F3A1A10C0444812CEBFA2E63FA22B5304D97818C02EB15D88A5B0E8BF2FDF404967BEF6BF852882FD5C8A05C01D35559CD6E1F33F78C23DB04DBEC63F1ECFD67FB1A9C43FB4F1E9A75871FC3F8894E53888CBECBF3DFDBE58EA5E02C06868ACBAFB12F2BF20919F993AADF73FD074D6EBE3B5F53FCA98E8B24C130CC0D3DE7AD8FA7E0A4062DFF707379FDA3FB6659724CAF0E5BFF81F98FEE1501040"> : tensor<20x20xf64>
    return %cst : tensor<20x20xf64>
  }
  func.func private @expected() -> (tensor<20x20xf64> {mhlo.layout_mode = "default"}) {
    %cst = stablehlo.constant dense<"0xD6E5E529E1ECDEBF7C1D4685A87CF5BFD5A341BBD661F6BF7D0A7DF0CD2AF13F256386CEFF57F5BF1BA21E63203FF6BFC62873F282BDF03FF6D853A27CF6F0BF462C4BB7EC46F4BF1EDE123F6A3AF3BF2F498BB18611E83F0520911C5FD3F53FBAB4A89565B1F0BF381D867C33A9F53F0C96DDE4D4E8F4BFD363CC70BB99F2BF9B2758494A2AF43F7CA0F36EA191EE3FF083F2A82E1CF1BFA50047B9CD71F43F9522B553B859F63F8CAFD4D87A3CF6BF828D8267B0B4ECBF1C6AA57A7388F3BF0141E63CF354F5BF00EC6E79D44EF63FC3A6BF1AE670E8BF329116B3B803F43FCF4959B659EDEA3FFCF6635E105BC43F019DD1274BCBDEBFB27AC69A2D2EBDBF8F240245C0B3EF3F87309D89386CE8BF3113768720EBDC3F52C782238724F63F3DF4B4A029A4F33FF2A2681CE57DE4BFA4966FA9F401F63FCBFF015B4F69E5BF62CFC5938AC4F5BF21E328FF2896F03FF319C170E500EBBFFCAD4EB7561CEEBF7D1BFE035078EC3FAAA763F4762DF13FEC6BF5B3B1CEEFBF140DC875C68AE53F64104F8B31ECF5BFF842D322326DD63F90070E0BC9DCECBF194CCB28FCE0F4BF9B66134519CBEDBF3B3522C2757BEF3F80B40B1759D7F3BF837A9613DED1DDBF853E22FB67AEF3BFE1BBE7903A6FF03FA295748B5374DABFCC4189A3F647F23F414087B01937F53FF53C56CEA9F6E5BFC414272BAC43F3BF8AE72E5FB34EE2BF9A95C5B2A6ECF0BFFDDDC7492EFAF63F93264A444EB2F5BF600D2BEF92E7F33F9CDC5FA2CFB6C83FEB1F93BC99CAEC3F7930782B47B6EFBF27C22DE9369FE1BF64566A3F2B44F4BF438AF2ABE895F1BFA3EBF60AE1D1F53F904747A8DCB6EDBF323044946B68F5BF98E951D808F3F03FA8C17B00AF7BE0BFB0510347E147F2BF517B5C8A1E38DBBFEE99115790E0F63F20E317B9B11EE8BF305E25E96371EC3F1802AEDB3879DA3F715620277709D2BF0890688241C3DD3FBE08505431F7E7BFF4A4486BE209F4BFC2803A27D0F5F6BF6D217C565742E23FE9787EF2C12FF5BFCDDEED519F9EF03F74CF088EC5F7D33F30BF53FCC9AEEEBF9324842C99D0CEBFA59DD5F403CBF2BFBC69BB159A8CF4BF68FE7E5DAB65F1BFD4F92EB3A678E23F148BC4EA7CB4EEBFAFFF00F6E45AF4BF241EF4D99F84F43F491585A092E7F43F62C3036A0C4AF43FD13B2650A0A0EFBF875CBD24B69AF3BFF6756D0AEA75EFBF3ADFBF95C418EFBF98B83C5E63FEC8BF6C3AEDE98DE4F43F5F32E4FCE7B0C7BF458BDC6202D1F4BFD2F1E5C1247FEA3FE6EA614B66E7D3BFD56AAD22AFB7F4BFD4A1B937D569F5BF10222CDF87E3F1BFE6151E3B1F16D53F8832EAA47E9BF43FE6EA4DD1074DE63FF655ECAF6EC3F43FAAFC18C060C4F4BFA738F67E2854D2BF0EBE24AC98B9E13F4FBB04985D94DBBF2FBFDC8A0794F13F82BAC4EE425B9BBF8FE0083E068EF33FA2BF0271E1E6F23F04F1FE29C3BDD8BFFA4553839E1CF5BFAD51A65ECE89F6BF54921194D1A4EC3F77E992F728D2E2BFC88C2BA16512E2BF34226E01408AF4BFD7CC8D04D057F2BFA081637E696CF23F99227209FF73D2BF19F8B641273AEFBF207D57A1CF2AF3BF79BF9A0CFA03D7BFBB5FDF9C8D7CEEBFDEFB17B87288B0BF7F173D634082F3BF0A7E3A46AC48E9BF1F47B6CCBE16DA3F04A48A18EA3BF3BF2A82A1AE2D20E63F9D8C376FD138F13F2BDCC838E314E63F359CEA015B43F4BFE51C087B7073EF3FD7F7DF983D3FF0BF82DAE9B0DE64DABF6869BE266B68E9BF1F633AB142D3F6BF3B661578CF05E53F2241B0186681F4BF8E2E2B6E10A8C7BF6E88531074ACF23F7FD43072E919E0BF13846EE92C73CFBFEEF1CA6DB196E43F747AFE6D7FFEF1BF09F0ECA044D3F5BFAB08061C3CD7F2BF2C7C949F6A21F63FCF161ECED735F63F0B92B3BF53B9DC3F6E89B21E2FAFF2BFD7E274DF86EAF43FE5CBA8F83486F43FD9AD9EC19E95F13F1822659B4825EE3FCF4E0A70275CF3BF127484CF6281EC3F7EF46EC89AB3F13F78FE5FCC83F1F4BF355623988A8DF63FEC4744CCCA3CEBBF10E1623ED300F1BF032491C61468F53FE7370A3C6C6DE63F00D4FEFDF440E5BF7FA1893A2BBDF13F7BA7457667D1E3BFFA12AF0AE702E7BFCE18CB3A5AD0F2BFE5242859D83AE6BF060D89BA353CF7BFFAC7DA785FCAF2BF478658AF8BDAF33F165AA7FA780DCB3F43E6E5772B21E83F47A07BF883C0F63F5DE732E4FC41EE3F383C3CE44807EA3F39D091499867D93FBA0B307416C1F5BF695182E74D7EE93F380834677221F3BF4C1E50FF5E8DDA3F3981C34A9293EE3F2F90BD0C38BFF3BFB457CBA8AB89F5BF4547370CE42BE0BF6068076DECDDCFBFF97D0F5F5109F33FDA52EDB39031F63F29387B5E15F6F03F9894CAAE9B26F2BFD3A85BE763EAEF3F27471FFD71E3F43FC6CA16897B38F73F9E3D6A8427D7F5BF4EB9ABF90971F1BF0CD3FF6F994CD83F5EA3CF07BBCBE2BF2C02BD651A29F43FDDF17DB28BBCDFBF00FA5F01CCCDF33FC43EE871525AEC3FFEF4728121D3A9BF479D7B130E6EF5BF431E35106F9EF2BFC37A02BCD449F63F4FC05945F7E0F23F6EE64E377CD4F0BF071D21F27B2BF63F7B5D95F59FDAEE3FD30649CF7E26F23F682DD988FEECF43F3BC6504780C9F63F897AD3CB3864EB3FAF8CEABC990AF13F359AC397A825F43FFF1BAC04B36CD7BFA7B8AAD2E9B6F63F2C1CE409FC72F13F8FCE162AB7B6F43F06B0E3482478D23FE42A20EC7EC7EC3F438C45260D039D3F8D54E360B773F13F91FDD93C1913F6BFE13F601D5B37F03F802B83E8D6D1F13F180B3DB49DE4F33F0CB25715B16CDBBF8AEF4FB728A3E23F531CADE3EE76F43F92CA554F62A3F4BF747DA19781DAF5BF08A59CFE1476E8BF8C0A49B10F78F1BF7B0F0E90DBB4F33FE6D31387AA27DD3FDB257BAE6584F3BFADB42ADB0A24F53F9DC370BBE88AF6BF7C194A7C65AEF2BFCB02B6580F98D7BFF8F93B3795E5DEBF5149F317E950F03F8A3CBA9A5240F4BF47731CE71AB2F3BF623F63914A64F4BF994C14A4BEA3F2BF1987CEFAAE02F53FAFB9D25B34ADEFBF547C6F100F6BE43F07F6B09CC921F5BF0A60E42249A0D53FE7C5EB30CC75F2BFFA5CCB263437F23F6B22E6E767A9F4BFA61F233F6382D0BF0FA2AC767ACBCABF698677E22B75F63F5CEFCB65C787F13FE23EE6313075D5BFCE7BD7B91CBAE63FCD0E7B03B374E03F3D60E8683E73F33F1192FC12ABB6EF3F21106B9F4BBEF6BF7DE0FE31C462E5BFECC18CBFE4959ABF1043CA309EA7F3BFA8225BFE05D0F1BFA6AD7FD939BFF53F5FCBB9A3F39AF6BFFB527A63E4FEF33F6718E06E9C06F53FBD219AC3B3ABF7BF0EC518E4574DEBBF5A440B041AF1F4BF06ECD35FFC7FF43F337522463442F43F5AFFE2090587DF3F22123CF72F8FEB3F6E4600C5BE6FF73F1CCEB5076379D5BFEB12A8AD0B57E23F6569F911941DF1BF812C6149DFF2F33F3CA3F80954D2F53F2D1D99203F5EF2BF33F68E6DF8B4F5BFD9624D6E8871ED3F3D3A51161CBDF3BFB9B50DCF8D0AE6BFBE813E65CA96F5BFDF0FEBF5D6ACF2BF69D243522831ED3FB268C6C7EB17D4BF3C9573E9A51DF33FFFA3F69FB8BBF3BF2D8180614392D9BFDCA689836989F6BF8ED52BD53C61F4BF0F3FF414AA1AEBBF27629074FDFFF53FCA6C33C59CCAD53FD222713C41D5F1BFA12455EBD3BBF63F482AE83AD0C2F03F01841D4201E3F13F30529CA3D2D1F13FB667CB22634BF3BFF925E8785E45F3BF5697F87F1ED1F13F24D29C38C6BEDEBFB46F49427883F0BFFF837D2F2693EF3FEA653645232DEFBF91346B110A0DF53F35DD6042828EE0BF4601CA724C08F33F92F6B6F84C55CD3FB056B725CB47F4BFB25B502E50B9EFBF4ECE0C7AE278F43F39B748D2C174E63F610E7E55592AEEBF96BC936B9636F63F5EC1BEDA9413D7BF5DE8CD3B87C7E0BFA422562F69B3F2BFC377A697D9B6F63FE1DA788AB16AE8BF1BF9EB9C7D1BF5BFA49C87F703D3F6BFA6A730D7EDC0D8BF59C5D54B187FF3BF107C31997AE3F03F029B64E36504F43FF50C32D718E6E53F3E4328809234F3BFF19A73ABDF19E83F89FD685EF0C7F6BF3E671914800CF43F5C4DAAD5E22FF73FFB57D7F38B93E7BFFE25C3BABD39F2BF1D0A18FD0B0BF43FEB3C69AA902FF6BFE27381F3EBADE53F3A6FEF873EF4EF3FE63614FF70CFF43FAB6407A57791E2BF0DCDEC00C145E33FA64CE15F9379DD3F7FC84768AB25F63FF1B00A5F285BF3BFE37FDA7B5D2FF0BF6C95AD8B3E2BF3BF310A2A4597E6F5BF9D0B51E9AE3CF5BFF1AA7B0F6EB3E33FCA67D81D5A8AF6BF6CCBA7257307E5BFF9BBCF09BEA5EEBFDB458E2B6C71F3BF4C91E02EDC94EC3F4483C6982A82C63FE6FF8845737CC43FB59C187D21EFF03F91905C518572E7BFFA66FE96B78FF2BF17990F550714EBBFFAB3659AA13FEF3FBB57BBDC24F1ED3F2BC55DE6F8B0F4BF48ED6BF4EA70F43FBC5822647F3AD93F56E129B7993BE3BF10FA30A73B49F53F"> : tensor<20x20xf64>
    return %cst : tensor<20x20xf64>
  }
}