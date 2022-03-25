import 'package:flutter_test/flutter_test.dart';
import 'package:argox_printer/argox_printer.dart';

void main() {
  /// PPLA driver initialization, will load the DLL files
  final ArgoxPPLA lib = ArgoxPPLA();

  /// This test check if
  test('Check FFI access and DLL use', () async {
    assert(lib.A_Get_DLL_VersionA(0) >= 411,
        'Version check failed, either you are using an older version or and different library');
  });

  /// Even without a printer you can test and see if this resource works
  test('Create an emulated printer and test basic printing', () {
    /// Output result, you can check if command were sent by dll checking this
    /// file content, follows what you should expect in this test:
    /// m
    /// qB
    /// L
    /// D11
    /// 121100000100010Lorem ipsum
    /// 1A00020004000101234
    /// >01
    /// ^01
    /// Q0002
    /// E
    ///

    String printerFile = 'test\\output.log';
    assert(0 == lib.A_CreatePrn(0, printerFile),
        'Fail to create printer emulator');
    assert(0 == lib.A_Set_DebugDialog(1), 'Fail to set debug dialog');
    assert(0 == lib.A_Set_Unit('m'), 'Fail to set unit');
    lib.A_Clear_Memory();
    assert(0 == lib.A_Prn_Text(10, 10, 1, 2, 0, 1, 1, 'N', 2, 'Lorem ipsum'));
    assert(0 == lib.A_Prn_Barcode(10, 40, 1, 'A', 0, 0, 20, 'B', 1, '1234'));
    assert(0 == lib.A_Print_Out(1, 1, 2, 1), 'Fail to print');
    lib.A_ClosePrn();
  });
}
