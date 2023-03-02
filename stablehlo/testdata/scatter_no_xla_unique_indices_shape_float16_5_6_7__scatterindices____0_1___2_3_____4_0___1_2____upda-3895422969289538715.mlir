// RUN: diff <(stablehlo-opt %s.0_9_0.bc --vhlo-to-version=target=current --vhlo-legalize-to-stablehlo) <(stablehlo-opt %s)
// RUN: diff <(stablehlo-opt %s --stablehlo-legalize-to-vhlo --vhlo-to-version=target=current -emit-bytecode | stablehlo-opt --vhlo-legalize-to-stablehlo) <(stablehlo-opt %s)

module @jit_testcase {
  func.func public @main() -> tensor<i1> {
    %0 = stablehlo.constant dense<[[[0, 1], [2, 3]], [[4, 0], [1, 2]]]> : tensor<2x2x2xi32>
    %1:2 = call @inputs() : () -> (tensor<5x6x7xf16>, tensor<5x2x2xf16>)
    %2 = call @expected() : () -> tensor<5x6x7xf16>
    %3 = "stablehlo.scatter"(%1#0, %0, %1#1) ({
    ^bb0(%arg0: tensor<f16>, %arg1: tensor<f16>):
      stablehlo.return %arg1 : tensor<f16>
    }) {scatter_dimension_numbers = #stablehlo.scatter<update_window_dims = [0], inserted_window_dims = [1, 2], scatter_dims_to_operand_dims = [1, 2], index_vector_dim = 2>, unique_indices = true} : (tensor<5x6x7xf16>, tensor<2x2x2xi32>, tensor<5x2x2xf16>) -> tensor<5x6x7xf16>
    %4 = stablehlo.custom_call @check.eq(%3, %2) : (tensor<5x6x7xf16>, tensor<5x6x7xf16>) -> tensor<i1>
    return %4 : tensor<i1>
  }
  func.func private @inputs() -> (tensor<5x6x7xf16>, tensor<5x2x2xf16>) {
    %0 = stablehlo.constant dense<"0x08C3593C9036033E57BC3943704112C2B3BA1542BAC0FBC3393AEEBE45BDFCB0B3400CAA0CC059C4134067B92C3FE3C013C018445CC487BC49C4B937CB3D1AB304C1AAB5F43E53BAEE3CD93A38BF6FC3F8B92FA89D3DF9413544ADAE08BD0F45BE4508C2BEC25AC12B3269B869C6C5BCC0411FC11B393733BA2CEBBAD5C1D7C2E3C575A2FE3CB63CECC47BBD01BC8640AF3CA3B4763EDDAB9FBE8D448E357FBC83BD7644493E01C29CC3F53C803CFBC6FC42E3BB0C3CA6321C3D883D9FAD66C092C39A405440ADC6C5430F4500BD9BC5F9428035E5435AC55E3F28BD51BEB4C474C012C53F3570C2FCBB7DC0BABDE2BE2DB8AE429540CCC03846334586BF823FC1ADB3AADCB36F41F5307940374037444040D0C002C4AB2C273880BC25C5D6BFC8C066467C3CDCBF3D449A41BEB67FBF63C29EC2B74254C239BACEC564C0374406C4B1BDCC397FBF0139913364BD8CC5D93FBEBE74C607C206BCC74527432BBD30BE51C02143CFC12B45B9BE26B701C0B9ACE5B88040B1C1CDC44BBEF5C295BE463FB0C0E0348AC128C06A3B49C3E2C408C3293FACC015C01DC05CB447418F42B34648BE"> : tensor<5x6x7xf16>
    %1 = stablehlo.constant dense<[[[3.226560e+00, 2.421880e+00], [-2.982420e+00, -4.363280e+00]], [[3.190920e-01, -3.050780e+00], [-6.010740e-01, 2.490230e+00]], [[1.918950e+00, 2.917480e-01], [2.932130e-01, -4.222660e+00]], [[2.552730e+00, -9.345700e-01], [2.306640e+00, -3.745120e-01]], [[7.910150e+00, -3.066410e+00], [-6.894530e-01, 6.921880e+00]]]> : tensor<5x2x2xf16>
    return %0, %1 : tensor<5x6x7xf16>, tensor<5x2x2xf16>
  }
  func.func private @expected() -> tensor<5x6x7xf16> {
    %0 = stablehlo.constant dense<"0x08C374429036033E57BC3943704112C2B3BA5DC4BAC0FBC3393AEEBE45BDFCB0B340D8400CC059C4134067B92C3FE3C013C018445CC487BCF7C1B937CB3D1AB304C1AAB5F43E53BAEE3CD93A38BF6FC3F8B92FA89D3D1B353544ADAE08BD0F45BE4508C2BEC2FB402B3269B869C6C5BCC0411FC11B391AC2BA2CEBBAD5C1D7C2E3C575A2FE3CB63CECC47BBDCFB88640AF3CA3B4763EDDAB9FBE8D448E357FBC83BD7644493E01C29CC3AD3F803CFBC6FC42E3BB0C3CA6321C3D39C49FAD66C092C39A405440ADC6C543AB3400BD9BC5F9428035E5435AC55E3F28BD51BEB4C4B13412C53F3570C2FCBB7DC0BABDE2BE2DB8AE429540CCC03846334586BF1B41C1ADB3AADCB36F41F53079403740FEB54040D0C002C4AB2C273880BC25C57ABBC8C066467C3CDCBF3D449A41BEB67FBF63C29EC29D4054C239BACEC564C0374406C4B1BDCC397FBF0139913364BD8CC5D93FE94774C607C206BCC74527432BBD30BEEC462143CFC12B45B9BE26B701C0B9AC22C28040B1C1CDC44BBEF5C295BE463FB0C0E0348AC184B96A3B49C3E2C408C3293FACC015C01DC05CB447418F42B34648BE"> : tensor<5x6x7xf16>
    return %0 : tensor<5x6x7xf16>
  }
}
