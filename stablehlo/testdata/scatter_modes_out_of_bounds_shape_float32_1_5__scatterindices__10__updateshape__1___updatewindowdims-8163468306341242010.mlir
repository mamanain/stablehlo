// RUN: diff <(stablehlo-opt %s.0_9_0.bc --vhlo-to-version=target=current --vhlo-legalize-to-stablehlo) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-opt %s --stablehlo-legalize-to-vhlo --vhlo-to-version=target=current -emit-bytecode | stablehlo-opt --vhlo-legalize-to-stablehlo) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = stablehlo.constant dense<10> : tensor<1xi32>
    %1:2 = call @inputs() : () -> (tensor<1x5xf32>, tensor<1xf32>)
    %2 = call @expected() : () -> tensor<1x5xf32>
    %3 = "stablehlo.scatter"(%1#0, %0, %1#1) ({
    ^bb0(%arg0: tensor<f32>, %arg1: tensor<f32>):
      stablehlo.return %arg1 : tensor<f32>
    }) {scatter_dimension_numbers = #stablehlo.scatter<update_window_dims = [0], inserted_window_dims = [1], scatter_dims_to_operand_dims = [1]>} : (tensor<1x5xf32>, tensor<1xi32>, tensor<1xf32>) -> tensor<1x5xf32>
    %4 = stablehlo.custom_call @check.eq(%3, %2) : (tensor<1x5xf32>, tensor<1x5xf32>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<1x5xf32>, tensor<1xf32>) {
    %0 = stablehlo.constant dense<[[1.83234084, 2.41569352, -0.631965577, 1.64114237, -4.04743576]]> : tensor<1x5xf32>
    %1 = stablehlo.constant dense<0.115922198> : tensor<1xf32>
    return %0, %1 : tensor<1x5xf32>, tensor<1xf32>
  }
  func.func private @expected() -> tensor<1x5xf32> {
    %0 = stablehlo.constant dense<[[1.83234084, 2.41569352, -0.631965577, 1.64114237, -4.04743576]]> : tensor<1x5xf32>
    return %0 : tensor<1x5xf32>
  }
}
