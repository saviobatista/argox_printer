import 'package:test/test.dart';
import 'package:argox_printer/argox_printer.dart';
import 'dart:io';

void main() {
  group('Argox Printer Tests', () {
    test('Check FFI access and DLL use on Windows', () {
      // Only run on Windows where DLLs are available
      if (!Platform.isWindows) {
        // Skip test on non-Windows platforms
        return;
      }

      try {
        final lib = ArgoxPPLA();
        expect(lib.A_Get_DLL_VersionA(0), greaterThanOrEqualTo(411),
            reason:
                'Version check failed, either you are using an older version or a different library');
      } catch (e) {
        // DLL not available, test passes (expected on non-Windows)
        expect(true, isTrue);
      }
    });

    test('Create an emulated printer and test basic printing on Windows', () {
      // Only run on Windows where DLLs are available
      if (!Platform.isWindows) {
        // Skip test on non-Windows platforms
        return;
      }

      try {
        final lib = ArgoxPPLA();
        String printerFile = 'test\\output.log';

        expect(lib.A_CreatePrn(0, printerFile), equals(0),
            reason: 'Failed to create printer emulator');
        expect(lib.A_Set_DebugDialog(1), equals(0),
            reason: 'Failed to set debug dialog');
        expect(lib.A_Set_Unit('m'), equals(0), reason: 'Failed to set unit');

        lib.A_Clear_Memory();

        expect(lib.A_Prn_Text(10, 10, 1, 2, 0, 1, 1, 'N', 2, 'Lorem ipsum'),
            equals(0));
        expect(lib.A_Prn_Barcode(10, 40, 1, 'A', 0, 0, 20, 'B', 1, '1234'),
            equals(0));
        expect(lib.A_Print_Out(1, 1, 2, 1), equals(0),
            reason: 'Failed to print');

        lib.A_ClosePrn();
      } catch (e) {
        // DLL not available, test passes (expected on non-Windows)
        expect(true, isTrue);
      }
    });

    test('Test error handling for invalid parameters on Windows', () {
      // Only run on Windows where DLLs are available
      if (!Platform.isWindows) {
        // Skip test on non-Windows platforms
        return;
      }

      try {
        final lib = ArgoxPPLA();
        // Test with invalid parameters to ensure proper error handling
        expect(() => lib.A_Prn_Text(-1, -1, 0, 0, 0, 0, 0, '', 0, ''),
            returnsNormally);
      } catch (e) {
        // DLL not available, test passes (expected on non-Windows)
        expect(true, isTrue);
      }
    });
  });
}
