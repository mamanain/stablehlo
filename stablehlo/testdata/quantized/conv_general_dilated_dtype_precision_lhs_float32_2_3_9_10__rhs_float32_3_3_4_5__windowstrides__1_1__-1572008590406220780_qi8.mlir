// RUN: stablehlo-translate --interpret -split-input-file %s

module attributes {jax.uses_shape_polymorphism = true} {
  func.func @main() -> tensor<i1> {
    %cst = stablehlo.constant dense<"0xD5A24340FD4E7D40E870E740AE20753F19DF723F3AD299BF120B8D3FE2023CC0780994C0BF5C66BF1DAEB03E342BDCBDF16C873FAD16BC40A3E4763F641F8D3D0C20C93FC28F02401293DF404211673FF611C9BFE217F2C04ACC57C0BE7C24C0CC21CDC02F9AB0C086D52FBF391414C058188EC029C44DC031E47DC0845AABBED1BC3C3DA2DABF3F40654F3F9B440AC0F4F49EC03F8BE9BF14E362BFA7270740013684C0B79E9A3E657A594031EE9C3EC3282EC0E32EC940D4E14C40F8417C40F3706C3EEB958CBF4903B03F060B884022CA3640CDB2F53FBA3C2B3FCF3791401800BCBEFC96C1C06A4C1E401A816F404123B5BF3907BBBF627DEA3F7C73A73FC7EBB5BFAA53E63F7F3ADFC0ACEA973EFFD635C095CD1E40D73A90404A3B5040AEDF91C0B69911BF9B1108C018B75EBF8A9465BDA36739404F7848BF05EC653FD32B553F25DDAD40FCC6763DAFD12C3F1829863F8263AF3D7E05873F5261F73F6F85313F727F1C401E7077403BE8B6C0672D44405F23B83F60F10EBF3D8A33C059741DC0AA53FC3E741A99408632DE3EAF9CAA40252401BEB1E3BABE0081A540064613405D3C64C0325E0C3FFF5A6040EA1CD8BFE7004E409C481CC09D341F40DE99BCC0C706A93F1DB36E40E34128C06BCFA0C0A49877BF493B9D3F12C304C0B46D19C0ED795240D7412BC0263505C07EEDE640EDC048C0E80905BFBEABA2C0D2E53D3FA95EA7BF76BD2A4024587A403FEE03C07CC3BABFE609B9BFD4CA614011080FC0A528C33F54C376BE2FDA2F3F291298BF328B09408BE57440FF85414093E9B03FDC8DECBF451C1BC0D127243D79B8CB3F15E1893F9CEB0C40009A1240FD5185BD197FADBFAEF6FBBF6E3F7C40B49F21C0738DBC40319ECF3F1930DC40774A2BC06F1C92C0DFE439409D417740CA6FBD3EAF4707C06375B440B620C03F49263440262675C05C4F3F40104FB53F9FE3D53FE6CCFA3FB5F4B5C06A5683C04D264D403F45A2403BA544408A0E2DC0DC931E3F518589BF802DA3408A544AC0F4874CC0C6DE8A400AAAD53EF4DF0B405696A3C0F02072C072BA6E40F4E13FC02BF986C0DDC446C022D80BC0E82CE6BF49525F406CAC583FD563C63FA42C94407F658C407BB528C07CA9563FE5DB76BE2AB37C3D530E0EC196CE34C0F17B14402F6E87C01B7E7440A59A5D40C801BC409C89903FAE200B40468D0340E429B140E886993F7A2BB9BCFA5B2FBF99B48B40BBAC8C3F55BE8940CDA68DC062082440C5F792C0974DD73F632AF83F27D90140B41AA23FB9199FBFD668404019EBAD4001F6AE3DF22B0BC057D701C0E70586BF3D41B9BF383D86BFA2A382402CB993BE62E98FC0217280409F8813406A2E84C032EBC0BF0BE186C0DC540E3F67C40A408E992BC0E5659DC07FBAF83FAA2FC9C0E0AF56404E0E7E3F3A357CC09BA1903D4E991F4037AF37C09470FCBFD3B91CBEB41C6B409979634073553D40C5E489C036B7E3BFC892963FE10ADF3EEEF70C40EDC54BC03CC518C0424EAC3EFAA23C3D56E8CD40DF77CD3F0FB80CC0AFCA583DDF9099BE70CE2B4032E823C0445A59403C6BA63EB22C133F0E050EBF883ED7C00F5997BF9F92503F06729E401D96A040ABE3A5BF8F22DEC00E4A21BFF921743FFDAC9140B4410640AA2FE4BF19C169BF1BC63ABE04F69740667100C13B0A34C0661F8BBEA965B440AB082A40DA58984016223D400063D23F513ACFBEA0270040126811401D42543F367A3B4077703CC01DEE22C0EEAF963D11C88F3F43BAF6BE08CB76C0A3CAE34070D28640A82610BE3BF3723E6CD573BF7041F3BE73E9B43EC479303FC68F62C0CD8C02C000EC7E3EA3661EC08053A640FE40FC3FC076834085C63EBF9D7703C027111841C53E6BC0CA00174050FBC63FA06C0CC0B78AF73F3110453E4843D5BED6FB44C0CBC6DFBF2C7671BF29EB10C09A8EFB3FF21DDDC0D6FF293FD56D2BBF3377474075337AC09D121BC00BE8034122076F4047A8764037638940E7E8AC3F9C865B40FA7BC4C0B794F13FC2B92140FA855940811C04403FD559BEC06963C088EAF7BFDAAA233F640203C0CDC87440DE6306C0808244C0F02935C0430E21C07825B1C02EA3923F4E0B2340FC89DD3E4FFE8940147F70401BCB22BF415CCC3FFBE6C0BFB50A89BF5E8D80BF55714FC046098CBF090A9840D5551340DE179340CCAF8440E4F39F40886206C0BFE39DC0AC9FD8BF2A456740569D04409C9A8AC08B32664069F745C0D0F3CDBF9E7C474094850240E37F58BE865DE340C91D81404D7998BF71518E3F0BD50DBE7A35B5C0DDEEF33FE337983F5F33B440618AA63D210905BF196FBC3F3B9B9C3F601345C0F8B5D8BF84469AC0A9BD97BE34604BC0B833FDBFFA40D5BFE72B9BC0F68D0B40ACB03BC055B932C03308B840844B1B409D4CDBC025C751BF626213403511463E04EA2440183E253FB351F6BF822098BFB647E5401648223F1CBEB9BD221FA040452F63403A747EC0808F073F1DEF5B3F17D4BB3F18A094C01DB512C0524EB1409E26914010CA42401E3BA6BF16BB9D3F22B13940A88BCA3F27D92B401F3FEB3F3105953E3E82B23E32699140A7ABA040FF51903FFAAB31BFD5BDBA3F8402803F8729264058D041BDDA2ED3BF85414440AFF279C0CF0DB440C30F413E13D57CC0BD4753C0E625A8C0134770C0604791BE0FFAEEBDABA7164085A1C6BFCE2EDBC03A591C407E2F784093C727C03DF0B13FD85B86BF457FFE3F0E42224048EAA23F3082593FAD27AAC07D731740BDCF8EC0A18E1640AA213640B0EED03E0AE0A24093F2FD3F615F9CBF71EEFA3D1D532DC015028F40CE14A5C0E6F794C097F4453F3D6DE1BDF39043BFA53E1440AC2C0CC1D7F5FABFAF41A4BF5A7BD43FC5D93FC0A1136AC0CB1C3E403369F1BFFEDF81BCD5FFE13FF1DD8EBF2CF1213F75B480C03FDDCF408D68E1BFED3653C0C60F8140B5FB753F3B501DC0239A99C0273546C0F3028C40FB0B2BC02A161340F2B92CC07CEBBFBFB13706405BA62EC0E200A2C05AE2A03FFF4585C0"> : tensor<2x3x9x10xf32>
    %cst_0 = stablehlo.constant dense<"0x955C0FC0510EDABF3C6FE33F8B715840AD9EB5C03A0FD63FA6AF604051131FC01E9CA940FBEA72C0256C0FC0A614C2402ACA76BE386EE33F6B9B5DC08A7D1BC0377C833F910BE2C0A8658540899E693F03B9973FFB5B86BFDFB778C082207940A7B29CBEFD2CA4BFDA4945BF58D232BF03A83F3FD8524C3F0E20A83F81F501C0D9808AC0CC6FC4BFCC7C38C09940F33F2E44953FD56AFD3F07E91140B41ABBC06548D63F41ED9EBF62BE0BC09FA1AC3FEE60F13F5D4CA93F9212E13FB6ED07C0B568083F60342AC058D10C40667392C0A8F2C3BFDFD0DFBFB2AB5F3F61EC14BF5F4C1340BB0883402A6995BF1AE1CA3FFFA069C075556FC0B8769940E55399C08B638DC0F57A4740C059614035DDA8409A32ACBF6EC1FE3F83B70A40E6103EC031328B3FC64ECA3FAEFF7D401164E7BF3EE47E3F0DC15DC0C48D05C04970953D659983C00C83C83FFD8EB4404CA2CDBFE30D6D3FAF1B54BE9B4118400B42B04046F180BF108FC3C0EEBE363FFD12B74022DADC3B316283C090564840221E1C407533763EE08C08C0246A753F062B12C0DA69423FC2828B40540DB1BF1A370141D296A3C0E2F210C06094ED3E92BC8BBF09DF13C0C6A8D1BDF0E08240E47A78400B44D8BE6C092440572D8ABFA7EDA8409DE6AFBFE30B00C0B174D7BFE480E73F2E7205C0FFBB8140FB46F03FC5B652C0F5EF30C0F8C8CAC0049E9DBFA80931C0B84766402BA0B83EFCF68640513A71407F9587C0B45F0A40472F62C00B104DC0CA67DEBEEB4FA4BEF44312C0A55494C0A8BDEABF837D3C40A64C68BF553EF9BF528087C041A3703FCB031A40B9BA573E03BEADBFF8EC8440A3A043BFA559E9BFD18457C079C1BA4055F80BBF1879953E496B0FC06619034056208D40DAD443C01C517D40AA607EC0E950F73F7503C3C00CB259BF32EEF63CE3D42B4097BC74BF576534BFF91B4A3F05D46CC08D3E17400AEBB3409A41673D750762BF784B9B401949EBBFB12E5AC00F4412C0B67E53C0"> : tensor<3x3x4x5xf32>
    %cst_1 = stablehlo.constant dense<"0xBF2874418B6547414A774B4185195D41D6581D4112FB2E4105D05F41C89A534112FB2E41106834411D938341CEE63D41FEF07A419C4986410FD53941CEE63D410CAF444192442C4180CD72419BB68B41001770411747194109894F4183F367413CF78641BF287441C1BB6E4112FB2E41C89A5341848662415DEE844102AA6A4183F3674109894F410D423F41C89A5341956A21410A1C4A4183F367419BB60B410CAF4441D6581D4149E4504109894F414E303B4191B13141D6581D418F1E3741C4E163414D9D404108F65441CBC048410FD53941D97E12411D938341BC027F41FF837541CEE63D414E303B41C89A5341B987944143986641C92D4E41FF8375411068344108F654413D4C7C4106635A4109894F41439866414A77CB408AD24C4197FD1B415DEE04415AC80F41BC02FF40CEE6BD400FD539419C490641D97E12415DEE044153E92A41BE95F9401D9303410A1C4A41D97E124157A21A4150C3B540DE370241DCA407414E303B41D10C33410D423F41D6581D411C0009419890164185195D41560F2041D97E12415DEE04418DF841410D423F41FF83754109894F4149E4D0404398E6409C4906419EDC00411A6D8E41989096418DF84141C60759419C498641BE95794109894F41FE2E804183F367413FDF76413E8A814181606D4150C33541BF2874418DF8414198901641BF287441C89A534191B1314187AC57410FD539418AD24C4147515641BE957941CEE6BD4006635A41439866419A23114185195D41C60759419A231141C5745E41C1BB6E41138E294108F65441C4E1634147515641C6075941DE37024146BE5B4150C33541BE95794149E450415DEE844140727141CBC04841DCA487415DEE844147515641C4E1634153E92A418DF84141FF83754105D05F41D10C33411521244149E450419A2311414C0A464141056C41583515418DF84141CBC048419A23114105D05F413D4C7C411D9303411521244149E4504119DA1341442B61410A1C4A415DEE0441D3322841560F20419A2311415835154191B13141D3322841DCA40741547C2541DE370241883F52414C0A4641560F2041CF7938415B5B0A4149E4D040D29F2D411C000941D97E124194D726413D4CFC40CC534341DB110D411A6D0E4194D72641D3322841D97E1241C4E1E3409BB60B41174719414E30BB40BC02FF40CEE6BD40C574DE401A6D0E4119DA1341"> : tensor<2x3x6x6xf32>
    %0 = stablehlo.uniform_quantize %cst_0 : (tensor<3x3x4x5xf32>) -> tensor<3x3x4x5x!quant.uniform<i8:f32, 0.0039212212843053483:-128>>
    %1 = stablehlo.uniform_quantize %cst : (tensor<2x3x9x10xf32>) -> tensor<2x3x9x10x!quant.uniform<i8:f32, 0.0039215482917486456:-128>>
    %2 = stablehlo.transpose %1, dims = [0, 2, 3, 1] : (tensor<2x3x9x10x!quant.uniform<i8:f32, 0.0039215482917486456:-128>>) -> tensor<2x9x10x3x!quant.uniform<i8:f32, 0.0039215482917486456:-128>>
    %3 = stablehlo.transpose %0, dims = [2, 3, 1, 0] : (tensor<3x3x4x5x!quant.uniform<i8:f32, 0.0039212212843053483:-128>>) -> tensor<4x5x3x3x!quant.uniform<i8:f32, 0.0039212212843053483:-128>>
    %4 = stablehlo.convolution(%2, %3) dim_numbers = [b, 0, 1, f]x[0, 1, i, o]->[b, 0, 1, f], window = {} {batch_group_count = 1 : i64, feature_group_count = 1 : i64} : (tensor<2x9x10x3x!quant.uniform<i8:f32, 0.0039215482917486456:-128>>, tensor<4x5x3x3x!quant.uniform<i8:f32, 0.0039212212843053483:-128>>) -> tensor<2x6x6x3x!quant.uniform<i32:f32, 1.537725862903607E-5>>
    %5 = stablehlo.uniform_quantize %4 : (tensor<2x6x6x3x!quant.uniform<i32:f32, 1.537725862903607E-5>>) -> tensor<2x6x6x3x!quant.uniform<i8:f32, 0.084777487960516234:-128>>
    %6 = stablehlo.transpose %5, dims = [0, 3, 1, 2] : (tensor<2x6x6x3x!quant.uniform<i8:f32, 0.084777487960516234:-128>>) -> tensor<2x3x6x6x!quant.uniform<i8:f32, 0.084777487960516234:-128>>
    %7 = stablehlo.uniform_dequantize %6 : (tensor<2x3x6x6x!quant.uniform<i8:f32, 0.084777487960516234:-128>>) -> tensor<2x3x6x6xf32>
    %8 = stablehlo.custom_call @check.eq(%cst_1, %7) : (tensor<2x3x6x6xf32>, tensor<2x3x6x6xf32>) -> tensor<i1>
    return %8 : tensor<i1>
  }
}