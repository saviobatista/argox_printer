import 'package:flutter/material.dart';
import 'package:argox_printer/argox_printer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ArgoxPPLA _printer = ArgoxPPLA();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Printer sample'),
        ),
        body: Center(
          child: TextButton(
            child: const Icon(Icons.print),
            onPressed: () {
              try {
                _printer.A_CreatePrn(0, 'test\\output.log');
                _printer.A_Set_DebugDialog(1);
                _printer.A_Set_Unit('m');
                _printer.A_Clear_Memory();
                _printer.A_Prn_Text(
                    10, 10, 1, 2, 0, 1, 1, 'N', 2, 'Lorem ipsum');
                _printer.A_Prn_Barcode(
                    10, 40, 1, 'A', 0, 0, 20, 'B', 1, '1234');
                _printer.A_Print_Out(1, 1, 2, 1);
                _printer.A_ClosePrn();
              } on ArgoxException {
                print('Error occured');
              }
            },
          ),
        ),
      ),
    );
  }
}
