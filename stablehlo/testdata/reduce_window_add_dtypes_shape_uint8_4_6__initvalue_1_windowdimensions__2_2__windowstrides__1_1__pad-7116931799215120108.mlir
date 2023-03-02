// RUN: diff <(stablehlo-opt %s.0_9_0.bc --vhlo-to-version=target=current --vhlo-legalize-to-stablehlo) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-opt %s --stablehlo-legalize-to-vhlo --vhlo-to-version=target=current -emit-bytecode | stablehlo-opt --vhlo-legalize-to-stablehlo) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = call @inputs() : () -> tensor<4x6xui8>
    %1 = call @expected() : () -> tensor<3x5xui8>
    %2 = stablehlo.constant dense<1> : tensor<ui8>
    %3 = "stablehlo.reduce_window"(%0, %2) ({
    ^bb0(%arg0: tensor<ui8>, %arg1: tensor<ui8>):
      %5 = stablehlo.add %arg0, %arg1 : tensor<ui8>
      stablehlo.return %5 : tensor<ui8>
    }) {window_dimensions = dense<2> : tensor<2xi64>} : (tensor<4x6xui8>, tensor<ui8>) -> tensor<3x5xui8>
    %4 = stablehlo.custom_call @check.eq(%3, %1) : (tensor<3x5xui8>, tensor<3x5xui8>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> tensor<4x6xui8> {
    %0 = stablehlo.constant dense<[[0, 4, 1, 0, 3, 4], [0, 0, 2, 0, 7, 0], [1, 1, 0, 2, 0, 0], [2, 2, 1, 0, 3, 2]]> : tensor<4x6xui8>
    return %0 : tensor<4x6xui8>
  }
  func.func private @expected() -> tensor<3x5xui8> {
    %0 = stablehlo.constant dense<[[5, 8, 4, 11, 15], [3, 4, 5, 10, 8], [7, 5, 4, 6, 6]]> : tensor<3x5xui8>
    return %0 : tensor<3x5xui8>
  }
}
