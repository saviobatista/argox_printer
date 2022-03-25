import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:argox_printer_example/main.dart';

void main() {
  testWidgets('Trigger app click', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    // Tap button to start printer
    await tester.tap(find.byType(Icon));
    // After click button should print (generate printer log file)
    assert(File('test\\output.log').existsSync());
  });
}
