// RUN: diff <(stablehlo-opt %s.0_9_0.bc --vhlo-to-version=target=current --vhlo-legalize-to-stablehlo) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-opt %s --stablehlo-legalize-to-vhlo --vhlo-to-version=target=current -emit-bytecode | stablehlo-opt --vhlo-legalize-to-stablehlo) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = stablehlo.constant dense<[[[0], [1]], [[2], [3]]]> : tensor<2x2x1xi32>
    %1:2 = call @inputs() : () -> (tensor<5x6x7xbf16>, tensor<5x2x2x7xbf16>)
    %2 = call @expected() : () -> tensor<5x6x7xbf16>
    %3 = "stablehlo.scatter"(%1#0, %0, %1#1) ({
    ^bb0(%arg0: tensor<bf16>, %arg1: tensor<bf16>):
      %5 = stablehlo.minimum %arg0, %arg1 : tensor<bf16>
      stablehlo.return %5 : tensor<bf16>
    }) {scatter_dimension_numbers = #stablehlo.scatter<update_window_dims = [0, 3], inserted_window_dims = [1], scatter_dims_to_operand_dims = [1], index_vector_dim = 2>, unique_indices = true} : (tensor<5x6x7xbf16>, tensor<2x2x1xi32>, tensor<5x2x2x7xbf16>) -> tensor<5x6x7xbf16>
    %4 = stablehlo.custom_call @check.eq(%3, %2) : (tensor<5x6x7xbf16>, tensor<5x6x7xbf16>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<5x6x7xbf16>, tensor<5x2x2x7xbf16>) {
    %0 = stablehlo.constant dense<"0xD73E03C0193F73BF21C05440753E9E3FFE3E1CC16AC0B540DD4097C00FC007C025C0B0BC3DC01240A3C00EC04B3F854009C06AC0FCBE4DBF9BBF2A3F74BF50C04CC058BF013E8640E7BEEEC07B40F5BF20BE9A40D03F2F3F25C093C08A401DBEE63FE9C046C0243F8D3FE5C093C00DC064BC11BF4BC022C02840A1C031408EC0A24094404CBFD640343F98C007C0FE3F2B3F18C08C40B5BF5D3D0ABFD2BF0040FEBFB6BF4840B740BCBF80BFA23FE0C09440D4BF0E3F71C0E0BF9EBF72C0FABEA3C00B3F65BE0AC080BFAABFBC3F82C02A402D409F3F10C0ADC0983F31C07C40E8C000C11AC08BC07240BBC0B3408C3F473F2DBFAABF094086BF87C0B9BFD03F30C04BC07B409640C5BF2CC0433C82C0BDBE05BF15C0143F99C012C0BBBE1F40F8BEDFBF044048401FC028C0EFBEAB3FFFC085401B4092C08E40B2409B40C440DFBF70C0723F6E4030BFB140E4BFB2C09B40813F9140383F0D40903F8CBFA8C02E40814091BF1940CC4007BE7DC029BF30408640D83FC4BF6D402B4034C0273E2840C23F49C0F33E514008C04E4001C19ABE3CBE253E6440F43ECEBF3ABFCE3E4EBF1740"> : tensor<5x6x7xbf16>
    %1 = stablehlo.constant dense<"0xBE3F14C0CC3F73BE6CC08CC0BCBE0C408CBF1E40823F6CC00040A53DA83F62C092C03540464021BDA9BF703F733FA8BF1E40C14026C0CC3F0C40ED40D63F79BF1AC0184032BEAEC02E3F87C09CBE1ABF34401DBFBF3EB4BF8DC0BABFAD401AC014BD4540C43F3BC0DA3DB0BEC23F81C005C1EFBE3DC067C06DC0EF3FE3BF2DBE9E3FACBF113FBDC01AC1523F32408BBDE6BEB3C0D6BFCE3F6BC099BF86BFBE40D240A33FE1BF2ABD89BF58C0C83FA64062BFCA3FDB3FC7409DC09C402DC074402BC0A23FBB3FA03D8EBE17401440CE3F84C04DC074BF4C40A1C03D40594036C01F3F0FC032407CBE2C4083BE4E40004004BB3FBE443F1C3F474057BF2640AB40D54027C090C0053E9C3ED3C0DDC01B4078BF7AC0EAC0C33D"> : tensor<5x2x2x7xbf16>
    return %0, %1 : tensor<5x6x7xbf16>, tensor<5x2x2x7xbf16>
  }
  func.func private @expected() -> tensor<5x6x7xbf16> {
    %0 = stablehlo.constant dense<"0xD73E14C0193F73BF6CC08CC0BCBE9E3F8CBF1CC16AC06CC0004097C00FC062C092C0B0BC3DC021BDA3C00EC04B3FA8BF09C06AC026C04DBF9BBF2A3F74BF50C04CC058BF013E8640E7BEEEC07B40F5BF20BE9A40D03F2F3F25C093C01AC01DBE32BEE9C046C087C09CBEE5C093C00DC064BCB4BF8DC022C02840A1C014BD8EC0C43F3BC04CBFB0BE343F98C007C0FE3F2B3F18C08C40B5BF5D3D0ABFD2BF0040FEBFB6BF4840B74005C180BF3DC0E0C06DC0D4BFE3BF71C0E0BFACBF72C0BDC01AC10B3F65BE0AC080BFB3C0D6BF82C06BC099BF86BF10C0ADC0983F31C02ABDE8C000C11AC08BC07240BBC0B3408C3F473F2DBFAABF094086BF87C0B9BF58C030C04BC062BFCA3FC5BF2CC09DC082C02DC005BF2BC0143F99C012C0BBBE1740F8BEDFBF84C04DC01FC028C0A1C0AB3FFFC036C01B4092C08E40B2409B40C440DFBF70C0723F6E4030BFB140E4BFB2C01F3F0FC032407CBE0D4083BE8CBFA8C004BB3FBE91BF1C3F474057BF7DC029BF304027C090C0C4BF9C3ED3C0DDC0273E78BF7AC0EAC0C33D514008C04E4001C19ABE3CBE253E6440F43ECEBF3ABFCE3E4EBF1740"> : tensor<5x6x7xbf16>
    return %0 : tensor<5x6x7xbf16>
  }
}
