import 'package:flutter_test/flutter_test.dart';
import 'package:argox_printer/argox_printer.dart';

void main() {
  test('All features test', () {
    /// Expect DLL Version to be 4.11 as this used in development
    expect(A_Get_DLL_VersionA(0), 411);
  });
}
