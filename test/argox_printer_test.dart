import 'package:flutter_test/flutter_test.dart';
import 'package:argox_printer/argox_printer.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final lib = ArgoxPPLA();
  setUp(() {});

  test('getPlatformVersion', () async {
    final v = lib.A_Get_DLL_Version(1);
  });
}
