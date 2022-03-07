/*
 * argox_printer
 * Created by Savio Batista
 * 
 * Copyright (c) 2021. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:path/path.dart';

//Internal helpers to load and configure library
String _red(String string) => '\x1B[31m$string\x1B[0m';
String _yellow(String string) => '\x1B[32m$string\x1B[0m';
DynamicLibrary _setupDll() {
  ///relative path to
  final String AssetsPackageDir = normalize(
      join('data', 'flutter_assets', 'packages', 'argox_printer', 'assets'));
  final String _exeDirPath = File(Platform.resolvedExecutable).parent.path;
  final String _packageAssetsDirPath = normalize(join(Directory.current.path,
      'assets')); //normalize(join(exeDirPath, assets_package_dir));

//PPLA Winppla.dll FullPath  destination
  final String _libDllDestFullPath =
      normalize(join(_exeDirPath, 'Winppla.dll'));
  final String _lib2DllDestFullPath =
      normalize(join(_exeDirPath, 'WinPort.dll'));
//PPLA Winppla.dll FullPath  source
  final String _libDllSourceFullPath =
      normalize(join(_packageAssetsDirPath, 'Winppla.dll'));
  final String _lib2DllSourceFullPath =
      normalize(join(_packageAssetsDirPath, 'WinPort.dll'));

  File(_libDllSourceFullPath).copySync(_libDllDestFullPath);
  File(_lib2DllSourceFullPath).copySync(_lib2DllDestFullPath);

  // LOAD DLL
  try {
    String _packageAssetsDirPath =
        normalize(join(Directory.current.path, 'assets'));
    String _printerLibraryPath =
        normalize(join(_packageAssetsDirPath, 'Winppla.dll'));
    print('WinPPLALibraryPath: $_printerLibraryPath');

    DynamicLibrary _library = DynamicLibrary.open(_printerLibraryPath);

    print(_yellow("WinPPLA successfully loaded"));
    return _library;
  } catch (e) {
    try {
      print(e);
      print(_red("Failed to load WinPPLA from library file, "
          "trying loading from system..."));

      DynamicLibrary _library = DynamicLibrary.open('Winppla.dll');

      print(_yellow("WinPPLA successfully loaded"));
      return _library;
    } catch (e) {
      print(e);
      print(_red("Fail to load WinPPLA."));
      return DynamicLibrary.process();
    }
  }
}

final DynamicLibrary _dll = _setupDll();
// *******************************************************************************
// A_Bar2d_Maxi()
// A_Bar2d_Maxi_Ori()
// ===============================================================================
// PURPOSE   Create the 2D barcode object - Maxicode.
// SYNTAX
//     int A_Bar2d_Maxi(int x, int y, int primary, int secondary,
//       int country, int service, char mode, int numeric, LPCTSTR data);
//     int A_Bar2d_Maxi_Ori(int x, int y, int ori, int primary, int secondary,
//       int country, int service, char mode, int numeric, LPCTSTR data);
// PARAMETER
//     x;
//       X coordinate.(100 = 1 inch)
//     y;
//       Y coordinate.(100 = 1 inch)
//     ori;
//       Orientation or print direction, 1:0�X�B2:90�X�B3:180�X�B4:270�X
//     primary;
//       A 5-digit primary zip code.
//     secondary;
//       A 4-digit secondary zip code.
//     country;
//       A 3-digit country code.
//     service;
//       A 3-digit service code.
//     mode;
//       Add function as follows:
//       +----+-------------------------------------+
//       |mode|           REMARK                    |
//       +----+-------------------------------------+
//       | A  |Make auto increment for numeric.     |
//       +----+-------------------------------------+
//       | B  |Make auto increment for alphanumeric.|
//       +----+-------------------------------------+
//       | C  |Make auto decrement for numeric.     |
//       +----+-------------------------------------+
//       | D  |Make auto decrement for alphanumeric.|
//       +----+-------------------------------------+
//       | T  |Change End character.                |
//       +----+-------------------------------------+
//       | N  |Disable.                             |
//       +----+-------------------------------------+
//     numeric;
//       Automatically increment or decrement the filed value. Value:0~99.
//       This field must exist When has add function.
//     data;
//       Data string. Up to 84 characters.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//     A_Bar2d_Maxi(100, 200, 32987, 444, 40, 55, 'N', 2, "TO 123");
//     A_Bar2d_Maxi_Ori(100, 200, 0, 32987, 444, 40, 55, 'N', 2, "TO 123");
// REMARK  The A_Bar2d_Maxi function can print a Maxi Code 2D Barcode.
// typedef int   (_stdcall *pfnA_Bar2d_Maxi)(int x, int y, int primary, int secondary, int country,
// 						 int service, char mode, int numeric, LPCTSTR data);
final A_Bar2d_Maxi = _dll.lookupFunction<
    Int64 Function(
  Int64 x,
  Int64 y,
  Int64 primary,
  Int64 secondary,
  Int64 country,
  Int64 service,
  Pointer<Utf8> mode,
  Int64 numeric,
  Pointer<Utf8> data,
),
    int Function(
  int x,
  int y,
  int primary,
  int secondary,
  int country,
  int service,
  Pointer<Utf8> mode,
  int numeric,
  Pointer<Utf8> data,
)>('A_Bar2d_Maxi');
// typedef int   (_stdcall *pfnA_Bar2d_Maxi_Ori)(int x, int y, int ori, int primary, int secondary,
// 						 int country, int service, char mode, int numeric, LPCTSTR data);
final A_Bar2d_Maxi_Ori = _dll.lookupFunction<
    Int64 Function(
  Int64 x,
  Int64 y,
  Int64 ori,
  Int64 primary,
  Int64 secondary,
  Int64 country,
  Int64 service,
  Pointer<Utf8> mode,
  Int64 numeric,
  Pointer<Utf8> data,
),
    int Function(
  int x,
  int y,
  int ori,
  int primary,
  int secondary,
  int country,
  int service,
  Pointer<Utf8> mode,
  int numeric,
  Pointer<Utf8> data,
)>('A_Bar2d_Maxi_Ori');
// *******************************************************************************
// A_Bar2d_PDF417()
// A_Bar2d_PDF417_Ori()
// ===============================================================================
// PURPOSE   Create the 2D barcode object - PDF-417.
// SYNTAX
//     int A_Bar2d_PDF417(int x, int y, int narrow, int width, char normal,
//       int security, int aspect, int row, int column, char mode, int numeric,
//       LPCTSTR data);
//     int A_Bar2d_PDF417_Ori(int x, int y, int ori, int narrow, int width, char normal,
//       int security, int aspect, int row, int column, char mode, int numeric,
//       LPCTSTR data);
// PARAMETER
//     x;
//       X coordinate.(100 = 1 inch)
//     y;
//       Y coordinate.(100 = 1 inch)
//     ori;
//       Orientation or print direction, 1:0�X�B2:90�X�B3:180�X�B4:270�X
//     narrow;
//       define the narrow bar width from 1 to 24.
//     width;
//       define the wide bar width from 1 to 24.
//     normal;
//       F: normal, T: truncated.
//     security;
//       0~8: security level.
//     aspect;
//       0~99: aspect ratio, 0 stands for 1:2.
//     row;
//       3~90: row number, 0 for best fit.
//     column;
//       1~30: column number,0 for best fit.
//     mode;
//       Add function as follows:
//       +----+-------------------------------------+
//       |mode|           REMARK                    |
//       +----+-------------------------------------+
//       | A  |Make auto increment for numeric.     |
//       +----+-------------------------------------+
//       | B  |Make auto increment for alphanumeric.|
//       +----+-------------------------------------+
//       | C  |Make auto decrement for numeric.     |
//       +----+-------------------------------------+
//       | D  |Make auto decrement for alphanumeric.|
//       +----+-------------------------------------+
//       | T  |Change End character.                |
//       +----+-------------------------------------+
//       | N  |Disable.                             |
//       +----+-------------------------------------+
//     numeric;
//       Automatically increment or decrement the filed value. Value:0~99.
//       This field must exist When has add function.
//       If mode is "T", the numeric is end character value(Decimal ASCII).
//     data;
//       Data string.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//     A_Bar2d_PDF417(260, 0, 0, 0, 'F', 0, 0, 10, 2, 'B', 1, "ARGOXINFO");
//     A_Bar2d_PDF417_Ori(260, 0, 0, 0, 'F', 0, 0, 10, 2, 'T', 0,
//       "ARGOXINFO\r\nData 12345\r\nData 555");
// REMARK  The A_Bar2d_PDF417 function can print a PDF-417 2D Barcode.
// typedef int   (_stdcall *pfnA_Bar2d_PDF417)(int x, int y, int narrow, int width, char normal,
// 						 int security, int aspect, int row, int column, char mode, int numeric,
// 						 LPCTSTR data);
final A_Bar2d_PDF417 = _dll.lookupFunction<
    Int64 Function(
  Int64 x,
  Int64 y,
  Int64 narrow,
  Int64 width,
  Pointer<Utf8> normal,
  Int64 security,
  Int64 aspect,
  Int64 row,
  Int64 column,
  Pointer<Utf8> mode,
  Int64 numeric,
  Pointer<Utf8> data,
),
    int Function(
  int x,
  int y,
  int narrow,
  int width,
  Pointer<Utf8> normal,
  int security,
  int aspect,
  int row,
  int column,
  Pointer<Utf8> mode,
  int numeric,
  Pointer<Utf8> data,
)>('A_Bar2d_PDF417');
// typedef int   (_stdcall *pfnA_Bar2d_PDF417_Ori)(int x, int y, int ori, int narrow, int width,
// 						 char normal, int security, int aspect, int row, int column, char mode,
// 						 int numeric, LPCTSTR data);
final A_Bar2d_PDF417_Ori = _dll.lookupFunction<
    Int64 Function(
  Int64 x,
  Int64 y,
  Int64 ori,
  Int64 narrow,
  Int64 width,
  Pointer<Utf8> normal,
  Int64 security,
  Int64 aspect,
  Int64 row,
  Int64 column,
  Pointer<Utf8> mode,
  Int64 numeric,
  Pointer<Utf8> data,
),
    int Function(
        int x,
        int y,
        int ori,
        int narrow,
        int width,
        Pointer<Utf8> normal,
        int security,
        int aspect,
        int row,
        int column,
        Pointer<Utf8> mode,
        int numeric,
        Pointer<Utf8> data)>('A_Bar2d_PDF417_Ori');
// *******************************************************************************
// A_Bar2d_DataMatrix()
// ===============================================================================
// PURPOSE   Create the 2D barcode object - DataMatrix.
// SYNTAX
//     int A_Bar2d_DataMatrix(int x, int y, int rotation, int hor_mul, int ver_mul,
//       int ECC, int data_format, int num_rows, int num_col, char mode, int numeric,
//       LPCTSTR data);
// PARAMETER
//     x;
//       X coordinate.(100 = 1 inch)
//     y;
//       Y coordinate.(100 = 1 inch)
//     rotation;
//       Orientation or print direction, 1:0�X�B2:90�X�B3:180�X�B4:270�X
//     hor_mul;
//       module size horizontal multiplier, value:1 ~ 24
//     ver_mul;
//       module size vertical multiplier, value:1 ~ 24
//     ECC;
//       error correction level; it must be fixed: 200
//     data_format;
//       data format. it must be fixed: 0
//     num_rows;
//       even number of rows, value:10,12,14,16,18,20,22,24,26,32,
//       36,40,44,,48,52,64,72,80,88,96,104,120,132,144
//     num_col;
//       even number of columns, value:10,12,14,16,18,20,22,24,26,32,
//       36,40,44,,48,52,64,72,80,88,96,104,120,132,144
//     mode;
//       Add function as follows:
//       +----+-------------------------------------+
//       |mode|           REMARK                    |
//       +----+-------------------------------------+
//       | A  |Make auto increment for numeric.     |
//       +----+-------------------------------------+
//       | B  |Make auto increment for alphanumeric.|
//       +----+-------------------------------------+
//       | C  |Make auto decrement for numeric.     |
//       +----+-------------------------------------+
//       | D  |Make auto decrement for alphanumeric.|
//       +----+-------------------------------------+
//       | T  |Change End character.                |
//       +----+-------------------------------------+
//       | N  |Disable.                             |
//       +----+-------------------------------------+
//     numeric;
//       Automatically increment or decrement the filed value. Value:0~99.
//       This field must exist When has add function.
//     data;
//       Data string.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//     A_Bar2d_DataMatrix(100, 100, 1, 8, 8, 200, 0, 24, 24, 'N', 2, "DATAMATRIX");
// REMARK  The A_Bar2d_DataMatrix function can print a DataMatrix 2D Barcode.
// typedef int   (_stdcall *pfnA_Bar2d_DataMatrix)(int x, int y, int rotation, int hor_mul,
// 						 int ver_mul, int ECC, int data_format, int num_rows, int num_col,
// 						 char mode, int numeric, LPCTSTR data);
//final int aBar2dDataMatrix = function(int x, int y, int rotation, int horMul, int verMul) {};
final A_Bar2d_DataMatrix = _dll.lookupFunction<
    Int64 Function(
  Int64 x,
  Int64 y,
  Int64 rotation,
  Int64 hor_mul,
  Int64 ver_mul,
  Int64 ecc,
  Int64 data_format,
  Int64 num_rows,
  Int64 num_col,
  Pointer<Utf8> mode,
  Int64 numeric,
  Pointer<Utf8> data,
),
    int Function(
  int x,
  int y,
  int rotation,
  int hor_mul,
  int ver_mul,
  int ecc,
  int data_format,
  int num_rows,
  int num_col,
  Pointer<Utf8> mode,
  int numeric,
  Pointer<Utf8> data,
)>('A_Bar2d_DataMatrix');
// *******************************************************************************
// A_Clear_Memory()
// ===============================================================================
// PURPOSE   Clear Flash memory.
// SYNTAX
//     void A_Clear_Memory(void);
// EXAMPLE
//     A_Clear_Memory();
// REMARK  The A_Clear_Memory function will clear all the graphics and soft fonts
//     which stored in the printers flash memory. Normally
//     this function is sent before the A_Print_Out(). Otherwise the graphics
//     and fonts will be accumulated, and cause memory overflow. When "memory
//     full" occurs, the printer will erase the first-in graphics or fonts.
//     To avoid memory full and save processing time, you may send this
//     function before the A_Print_Out().
// typedef void  (_stdcall *pfnA_Clear_Memory)(void);
final A_Clear_Memory =
    _dll.lookupFunction<Void Function(), void Function()>('A_Clear_Memory');
// *******************************************************************************
// A_ClosePrn()
// ===============================================================================
// PURPOSE   Stop printer operation.
// SYNTAX
//     void A_ClosePrn(void);
// EXAMPLE
//     A_ClosePrn();
// REMARK  The A_ClosePrn function will access the port that you choiced or close
//     file. The function must be performed after all commands placed.
// typedef void  (_stdcall *pfnA_ClosePrn)(void);
final A_ClosePrn =
    _dll.lookupFunction<Void Function(), void Function()>('A_ClosePrn');
// *******************************************************************************
// A_CreatePrn()
// ===============================================================================
// PURPOSE   Start PPLA Library opreation.
// SYNTAX
//     int A_CreatePrn(int selection, LPCTSTR filename);
// PARAMETER
//     selection;
//       To select the printer port.
//       0 -> print to file.
//       1 -> lpt1, 2 -> lpt2, 3 -> lpt3
//       4 -> com1, 5 -> com2, 6 -> com3
//       10 -> pipe, 11 -> USBXXX, 12 -> USB
//       13 -> LAN Client(TCP/IP)
//     filename;
//       When selection is 0, file name in current directory; full directory path.
//       When selection is 10, output path or Regedit(Device path).
//       When selection is 11, index of USB (count from 1).
//       When selection is 12, Regedit(Device path) of USB.
//       When selection is 13, IP address (TCP/IP port: 9100).
//         Port can be modified by adding information to IP address.
//         Ex: Set port as 80 -> 192.168.1.100:80)
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//     A_CreatePrn(1,NULL); or A_CreatePrn(0,"C:\\out.prn");
//     A_CreatePrn(10,"\\\\allen\\Label");  //share mode.
// REMARK  The A_CreatePrn() function will activate a valid printer port or
//     "print to file" path. This function must be performed before all commands.
//     A_CreatePrn(), A_CreateUSBPort(), A_CreateNetPort() and A_CreatePort()
//     must use one of it at once.
// typedef int   (_stdcall *pfnA_CreatePrn)(int selection, LPCTSTR filename);
final A_CreatePrn = _dll.lookupFunction<
    Int64 Function(Int64 selection, Pointer<Utf8> filename),
    int Function(int selection, Pointer<Utf8> filename)>('A_CreatePrn');
// *******************************************************************************
// A_Del_Graphic()
// ===============================================================================
// PURPOSE   Clean the stored "graphic data" in RAM or Flash memory.
// SYNTAX
//     int A_Del_Graphic(int mem_mode, char graphic[10]);
// PARAMETER
//     mem_mode;
//       Memory mode, 1 => RAM, 2 => Flash Memory
//     graphic;
//       Maximum 9 characters for the graghic data name.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//     A_Del_Graphic(1, "AA");
// REMARK  The A_Del_Graphic function will delete the graphics data which already
//     stored in printers RAM or flash memory. If certain gragics data was
//     deleted, it will not be retrieved and printed unless be reloaded.
// typedef int   (_stdcall *pfnA_Del_Graphic)(int mem_mode, char graphic[10]);
final A_Del_Graphic = _dll.lookupFunction<
    Int64 Function(Int64 mem_mode, Pointer<Utf8> graphic),
    int Function(int mem_mode, Pointer<Utf8> graphic)>('A_Del_Graphic');
// *******************************************************************************
// A_Draw_Box()
// ===============================================================================
// PURPOSE   Create a "box" object.
// SYNTAX
//     int A_Draw_Box(char mode, int x, int y, int width, int height, int top, int side);
// PARAMETER
//     mode;
//       Set logical OR or XOR operation. A for XOR, N for OR.
//     x;
//       X coordinate.
//     y;
//       Y coordinate.
//     width;
//       Specifies the width of box. 0 ~ 9999.
//     height;
//       Specifies the height of box. 0 ~ 9999.
//     top;
//       Specifies the thickness of top and bottom box edges. Value:0 ~ 9999.
//     side;
//       Specifies the thickness of side edges. Value:0 ~ 9999.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//     A_Draw_Box('N', 260, 30, 130, 105, 4, 4);
// REMARK  The A_Draw_Box function will draw a box by "OR" or "XOR" operation.
// typedef int   (_stdcall *pfnA_Draw_Box)(char mode, int x, int y, int width, int height, int top,
// 						 int side);
final A_Draw_Box = _dll.lookupFunction<
    Int64 Function(
  Pointer<Utf8> mode,
  Int64 x,
  Int64 y,
  Int64 width,
  Int64 height,
  Int64 top,
  Int64 side,
),
    int Function(
  Pointer<Utf8> mode,
  int x,
  int y,
  int width,
  int height,
  int top,
  int side,
)>('A_Draw_Box');
// *******************************************************************************
// A_Draw_Line()
// ===============================================================================
// PURPOSE   Create an "line" object.
// SYNTAX
//     int A_Draw_Line(char mode, int x, int y, int width, int height);
// PARAMETER
//     mode;
//       Set logical OR or XOR operation. A for XOR, N for OR.
//     x;
//       X coordinate.
//     y;
//       Y coordinate.
//     width;
//       Specifies the width of line from 0~9999.
//     height;
//       Specifies the height of line from 0~9999.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//     A_Draw_Line('A', 285, 77, 2, 30);
// REMARK  The Draw_Line function will draw a line by "OR" or "XOR" operation.
// typedef int   (_stdcall *pfnA_Draw_Line)(char mode, int x, int y, int width, int height);
final A_Draw_Line = _dll.lookupFunction<
    Int64 Function(
        Pointer<Utf8> mode, Int64 x, Int64 y, Int64 width, Int64 height),
    int Function(Pointer<Utf8> mode, int x, int y, int width,
        int height)>('A_Draw_Line');
// *******************************************************************************
// A_Feed_Label()
// ===============================================================================
// PURPOSE   Feed out one label from printer.
// SYNTAX
//     void A_Feed_Label(void);
// EXAMPLE
//     A_Feed_Label();
// REMARK  This function will feed out a label till its gap was detected. If the
//     paper is in continuous type, it will feed a prefixed length and
//     perform the same operation when pressing the "Feed" button.
// typedef void  (_stdcall *pfnA_Feed_Label)(void);
final A_Feed_Label =
    _dll.lookupFunction<Void Function(), void Function()>('A_Feed_Label');
// ******************************************************************************
// A_Get_DLL_Version()
// A_Get_DLL_VersionA()
// ==============================================================================
// PURPOSE   Get or show this verison for library.
// SYNTAX
//     char* A_Get_DLL_Version(int nShowMessage);
//     int A_Get_DLL_VersionA(int nShowMessage);
// PARAMETER
//     nShowMessage;
//       0 -> The message dailog isn't showed.
//       1 -> The message dailog is showed.
// RETURN
//     A_Get_DLL_Version();  Library verison string, if fail return NULL.
//     A_Get_DLL_VersionA();  return version value.
//                            MainVersion = (return version value) / 100.
//                            SubVersion = (return version value) % 100.
// EXAMPLE
//     int nVersion, nMainVersion, nSubVersion;
//     nVersion = A_Get_DLL_VersionA(1);
//     nMainVersion = nVersion / 100;
//     nSubVersion = nVersion % 100;
// REMARK  The A_Get_DLL_Version function is used to get or show this verison for
//     library.
//     Because the A_Get_DLL_Version() is return the string.
//     If using VB and VBA to develop, need to use RtlMoveMemory() to convert,
//     there is technical difficulty to using RtlMoveMemory().
//     If you use VB and VBA to develop propose not using this function,
//     please change to use A_Get_DLL_VersionA().
//     If you must use A_Get_DLL_Version(), please reference MSDN.
// typedef char* (_stdcall* pfnA_Get_DLL_Version)(int nShowMessage);
String aGetDllVersion(int nShowMessage) =>
    _aGetDllVersion(nShowMessage).toDartString();

final _aGetDllVersion = _dll.lookupFunction<
    Pointer<Utf8> Function(Int64 nShowMessage),
    Pointer<Utf8> Function(int nShowMessage)>('A_Get_DLL_Version');
// typedef int   (_stdcall *pfnA_Get_DLL_VersionA)(int nShowMessage);
final A_Get_DLL_VersionA = _dll.lookupFunction<
    Int64 Function(Int64 nShowMessage),
    int Function(int nShowMessage)>('A_Get_DLL_VersionA');
// *******************************************************************************
// A_Get_Graphic()
// ===============================================================================
// PURPOSE   Download graph data from PC into the printer's RAM or Flash memory,
//           the user must to know picture format, otherwise cannot be print.
//           The picture of BMP format that the print result will be inverted.
// SYNTAX
//     int A_Get_Graphic(int x, int y, int mem_mode, char format, LPCTSTR filename);
// PARAMETER
//     x;
//       X coordinate.
//     y;
//       Y coordinate.
//     mem_mode;
//       Memory mode, 1 => RAM, 2 => Flash Memory
//       Notice: The flash writing lifespan is limited, unless for special applications
//       that require store in Flash memory then recall in another procedure,
//       for general printing, it's strongly recommended that all graphics being download into RAM.
//     format;
//       Image file format.
//       +------+----------------------------+---------+
//       |format|Image File Format           |Direction|
//       +------+----------------------------+---------+
//       |  B   |1 and 8-bits BMP file format|flipped  |
//       +------+----------------------------+---------+
//       |  b   |1 and 8-bits BMP file format|         |
//       +------+----------------------------+---------+
//       |  I   |8-bits IMG file format      |flipped  |
//       +------+----------------------------+---------+
//       |  i   |8-bits IMG file format      |         |
//       +------+----------------------------+---------+
//       |  P   |8-bits PCX file format      |flipped  |
//       +------+----------------------------+---------+
//       |  p   |8-bits PCX file format      |         |
//       +------+----------------------------+---------+
//     filename;
//       File name of graphic data with path.
//       The format is XXXXXXXX.XXX or X:\\XXX\\XXX.XXX
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//     A_Get_Graphic(275, 50, 1, 'B', "bb.bmp");
// REMARK  The Get_Graphic function will store graphic object in RAM memory.
// typedef int   (_stdcall *pfnA_Get_Graphic)(int x, int y, int mem_mode, char format, LPCTSTR filename);
final A_Get_Graphic = _dll.lookupFunction<
    Int64 Function(
  Int64 x,
  Int64 y,
  Int64 mem_mode,
  Pointer<Utf8> format,
  Pointer<Utf8> filename,
),
    int Function(
  int x,
  int y,
  int mem_mode,
  Pointer<Utf8> format,
  Pointer<Utf8> filename,
)>('A_Get_Graphic');
// *******************************************************************************
// A_Get_Graphic_ColorBMP()
// A_Get_Graphic_ColorBMPEx()
// A_Get_Graphic_ColorBMP_HBitmap()
// ===============================================================================
// PURPOSE   To convert BMP image file to grayscale mode and store the graphics in
//     the printer's RAM or flash memory.
// SYNTAX
//     int A_Get_Graphic_ColorBMP(int x, int y, int mem_mode, char format,
//       LPCTSTR filename);
//     int A_Get_Graphic_ColorBMPEx(int x, int y, int nWidth, int nHeight,
//       int rotate, int mem_mode, char format, LPCTSTR id_name, LPCTSTR filename);
//     int A_Get_Graphic_ColorBMP_HBitmap(int x, int y, int nWidth, int nHeight,
//       int rotate, int mem_mode, char format, LPCTSTR id_name, HBITMAP hbm);
// PARAMETER
//     x;
//       X-coordinate.
//     y;
//       Y-coordinate.
//     nWidth;
//       This parameter specifies the width of the scaled graphics;
//       0 indicates original width.
//     nHeight;
//       This parameter specifies the height of the scaled graphics;
//       0 indicates original height.
//     rotate;
//       This parameter specifies the degree of rotation of the scaled graphics;
//       '0' is  0�X�A'1' is 90�X�B'2' is 180�X�A'3' is 270�X.
//     mem_mode;
//       Storage location, 1 => RAM, 2 => Flash Memory
//       Note: Flash memory has a limited lifetime. It is recommended that data
//       be stored in RAM unless it will be reused.
//     format;
//       Image file format.
//       +------+------------+---------+
//       |format|Image Format|Direction|
//       +------+------------+---------+
//       |  B   | BMP format |flipped  |
//       +------+------------+---------+
//       |  b   | BMP format |         |
//       +------+------------+---------+
//     id_name;
//       Provides a name to be stored in the printer for identification purposes;
//       can be call out graphic directly via the A_Load_Graphic() function.
//     filename;
//       Name of graphics file; may contain file path.
//       The format is as follows: XXXXXXXX.XXX or X:\\XXX\\XXX.XXX
//     hbm;
//       GDI HBITMAP Handle, which supports only the IMAGE_BITMAP format.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//     A_Get_Graphic_ColorBMP(30, 20, 1, 'B', "bb.bmp");
//     A_Get_Graphic_ColorBMPEx(30, 20, 200, 150, 2, 1, 'B', "bb1", "bb.bmp");//180 angle.
//     HANDLE himage = LoadImage(NULL,"bb.bmp",IMAGE_BITMAP,0,0,LR_LOADFROMFILE);
//     A_Get_Graphic_ColorBMP_HBitmap(30, 20, 250, 80, 1, 1, 'B', "bb2", (HBITMAP)himage);//90 angle.
// REMARK  You may provide a color BMP image file of any bit map to the
//     A_Get_Graphic_ColorBMP() function; it will automatically be converted to a
//     B&W grayscale image and sent to the printer for output.
//     The A_Get_Graphic_ColorBMPEx() and A_Get_Graphic_ColorBMP_HBitmap() functions
//     can be used to carry out zoom in, zoom out and rotation functions. They take
//     file names and GDI HBITMAP Handles as data sources.
// typedef int   (_stdcall *pfnA_Get_Graphic_ColorBMP)(int x, int y, int mem_mode, char format,
// 						 LPCTSTR filename);
// typedef int   (_stdcall *pfnA_Get_Graphic_ColorBMPEx)(int x, int y, int nWidth, int nHeight,
// 						 int rotate, int mem_mode,char format, LPCTSTR id_name, LPCTSTR filename);
// typedef int   (_stdcall *pfnA_Get_Graphic_ColorBMP_HBitmap)(int x, int y, int nWidth, int nHeight,
// 						 int rotate, int mem_mode,char format, LPCTSTR id_name, HBITMAP hbm);
final A_Get_Graphic_ColorBMP = _dll.lookupFunction<
    Int64 Function(
  Int64 x,
  Int64 y,
  Int64 mem_mode,
  Pointer<Utf8> format,
  Pointer<Utf8> filename,
),
    int Function(
  int x,
  int y,
  int mem_mode,
  Pointer<Utf8> format,
  Pointer<Utf8> filename,
)>('A_Get_Graphic_ColorBMP');
final A_Get_Graphic_ColorBMPEx = _dll.lookupFunction<
    Int64 Function(
  Int64 x,
  Int64 y,
  Int64 nWidth,
  Int64 nHeight,
  Int64 rotate,
  Int64 mem_code,
  Pointer<Utf8> format,
  Pointer<Utf8> id_name,
  Pointer<Utf8> filename,
),
    int Function(
  int x,
  int y,
  int nWidth,
  int nHeight,
  int rotate,
  int mem_code,
  Pointer<Utf8> format,
  Pointer<Utf8> id_name,
  Pointer<Utf8> filename,
)>('A_Get_Graphic_ColorBMPEx');
final A_Get_Graphic_ColorBMP_HBitmap = _dll.lookupFunction<
    Int64 Function(
  Int64 x,
  Int64 y,
  Int64 nWidth,
  Int64 nHeight,
  Int64 rotate,
  Int64 mem_mode,
  Pointer<Utf8> format,
  Pointer<Utf8> id_name,
  Pointer<Utf8> hbm, //TODO: Needs to check functionallity for mapping HBITMAP
),
    int Function(
  int x,
  int y,
  int nWidth,
  int nHeight,
  int rotate,
  int mem_mode,
  Pointer<Utf8> format,
  Pointer<Utf8> id_name,
  Pointer<Utf8> hbm,
)>('A_Get_Graphic_ColorBMP_HBitmap');
// *******************************************************************************
// A_Initial_Setting()
// ===============================================================================
// PURPOSE   Perform the initial paprameter setting (send the command code into
//       printer directly).
// SYNTAX
//     int A_Initial_Setting(int Type, LPCTSTR Source);
// PARAMETER
//     Type;
//       To choose type to input.
//       The value is 0 -> to import a string.
//       The value is 1 -> to import a file.
//     Source;
//       The data source is string or file name in path.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//     LPCTSTR aa = "122300001000200EXAMPLE\r\n";
//     A_Initial_Setting(0, aa);
//       or
//     A_Initial_Setting(1, "initfile.txt");
// REMARK  The A_Initial_Setting function is prescored to send some commands
//     defined by user. The function will send a string with some commands or
//     a file. The command should be placed after the A_Create_Prn() function.
// typedef int   (_stdcall *pfnA_Initial_Setting)(int Type, LPCTSTR Source);
final A_Initial_Setting = _dll.lookupFunction<
    Int64 Function(Int64 type, Pointer<Utf8> source),
    int Function(int type, Pointer<Utf8> source)>('A_Initial_Setting');
// *******************************************************************************
// A_WriteData()
// ===============================================================================
// PURPOSE   To output data immediately or send it to temporary area.
// SYNTAX
//     int A_WriteData(int IsImmediate, LPCTSTR pbuf, DWORD length);
// PARAMETER
//     IsImmediate;
//       1 that the data should be sent immediately, and only the data in pbuf should
//       be sent to the output port;
//       0 that the data is to be stored to the temporary area and will only be sent
//       when A_Print_Out() is called.
//     pbuf;
//       The data pointer to be sent.
//     length;
//       Length of pbuf data.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//     const char sznop1[] = "nop_front\r\n";
//     const char sznop2[] = "nop_middle\r\n";
//     A_WriteData(0, sznop2, (DWORD)strlen(sznop2));
//     A_WriteData(1, sznop1, (DWORD)strlen(sznop1));
// REMARK  Any controls, commands or data that you wish to send to the printer can
//     be sent via this function.
// typedef int   (_stdcall *pfnA_WriteData)(int IsImmediate, LPCTSTR pbuf, DWORD length);
final A_WriteData = _dll.lookupFunction<
    Int64 Function(
  Int64 isImmediate,
  Pointer<Utf8> pbuf,
  Uint32 length,
),
    int Function(
  int isImmediate,
  Pointer<Utf8> pbuf,
  int length,
)>('A_WriteData');
// *******************************************************************************
// A_ReadData()
// ===============================================================================
// PURPOSE   To retrieve data from the printer.
// SYNTAX
//     int A_ReadData(LPTSTR pbuf, DWORD length, DWORD dwTimeoutms);
// PARAMETER
//     pbuf;
//       Contains the pointer to the returned data. If it is a null pointer,
//       no data is written.
//     length;
//       Size of data to be read.
//     dwTimeoutms;
//       Time counter, i.e. maximum length of time allowed when reading data (unit: ms).
// RETURN
//     Size of data to be read.
// EXAMPLE
//     int ret;
//     char temp[10]={0};
//     A_WriteData(1, "\x01\x46\r\n", 4);//<SOH>F
//     ret = A_ReadData(temp, 2, 1000);//1 second.
// REMARK  This function is used to read the data returned from the printer, so
//     please check to see if the communication port being used has the ability to
//     return data. Use this function in conjunction with the A_WriteData() function
//     and refer to the ��Argox programmer's manual�� for additional information.
// typedef int   (_stdcall *pfnA_ReadData)(LPTSTR pbuf, DWORD length, DWORD dwTimeoutms);
final A_ReadData = _dll.lookupFunction<
    Int64 Function(
  Pointer<Utf8> pbuf,
  Uint32 length,
  Uint32 dwTimeoutms,
),
    int Function(
  Pointer<Utf8> pbuf,
  int length,
  int dwTimeoutms,
)>('A_ReadData');
// *******************************************************************************
// A_Load_Graphic()
// ===============================================================================
// PURPOSE   Acquire the graphic data which stored in the RAM or Flash memory.
// SYNTAX
//     int A_Load_Graphic(int x, int y, char graphic_name[10]);
// PARAMETER
//     x;
//       X coordinate.
//     y;
//       Y coordinate.
//     graphic_name;
//       Graph name with a maximum of 9 characters.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//     A_Load_Graphic(265, 35, "AB");
// REMARK  The A_Load_Graphic() function will print a graphic data which has been
//     downloaded into the printer.
// typedef int   (_stdcall *pfnA_Load_Graphic)(int x, int y, char graphic_name[10]);
final A_Load_Graphic = _dll.lookupFunction<
    Int64 Function(Int64 x, Int64 y, Pointer<Utf8> graphic_name),
    int Function(int x, int y, Pointer<Utf8> graphic_name)>('A_Load_Graphic');
// *******************************************************************************
// A_Open_ChineseFont()
// ===============================================================================
// PURPOSE   Open Chinese dot font file (16*15 and 24*24).
// SYNTAX
//     int A_Open_ChineseFont(char* path);
// PARAMETER
//     path;
//       The Chinese dot font file source path.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//     A_Open_ChineseFont("C:\\ET3");
// REMARK  The A_Open_ChineseFont function will open Chinese dot font file (16*15 �M 24*24).
//     And give Prn_Text_Chinese function to used.
// typedef int   (_stdcall *pfnA_Open_ChineseFont)(char* path);
final A_Open_ChineseFont = _dll.lookupFunction<Int64 Function(Pointer<Utf8>),
    int Function(Pointer<Utf8>)>('A_Open_ChineseFont');
// *******************************************************************************
// A_Print_Form()
// ===============================================================================
// PURPOSE   Perform printing function. And acquire the form data which stored
//       in RAM or Flash memory.
// SYNTAX
//     int A_Print_Form(int width, int height, int copies, int amount, LPTSTR form_name);
// PARAMETER
//     width;
//       Width - 1 or 2.
//     height;
//       Height - 1, 2 or 3.
//     copies;
//       Specifies the label quantity. Value:1 ~ 9999.
//     amount;
//       Specifies the number of labels which will be generated
//       before incrementing/decrementing the fields. Value:1 ~ 99.
//     form_name;
//       Input form's name. Use "," to differentiate string form.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//     A_Print_Form(1, 1, 1, 1, "demo");
// REMARK  The A_Print_Form function access data of all commands in the form.
//     First used A_set_form() to store a form in printer. The command have to
//     be placed after all commands. Befor A_ClosePrn(). The width and height
//     parameter is setting width and height pixel size. You can set the pixel
//     size except the smallest one by this function. Reducing the resolution
//     will causes the image pixel to be amplified and generate zigzag output
//     phenomenon. The amount parameter can be used to increment or decrement
//     field values more than one label which can be set only once during
//     label formatting mode.
// typedef int   (_stdcall *pfnA_Print_Form)(int width, int height, int copies, int amount,
// 						 LPTSTR form_name);
final A_Print_Form = _dll.lookupFunction<
    Int64 Function(
  Int64 width,
  Int64 height,
  Int64 copies,
  Int64 amount,
  Pointer<Utf8> form_name,
),
    int Function(
  int width,
  int height,
  int copies,
  int amount,
  Pointer<Utf8> form_name,
)>('A_Print_Form');
// *******************************************************************************
// A_Print_Out()
// ===============================================================================
// PURPOSE   Perform printing function.
// SYNTAX
//     int A_Print_Out(int width, int height, int copies, int amount);
// PARAMETER
//     width;
//       Width - 1 or 2.
//     height;
//       Height - 1, 2 or 3.
//     copies;
//       Specifes the label quantity. Value:1 ~ 9999.
//     amount;
//       Specifies the number of labels to be generated before incrementing/decrementing
//       the fields. Value:1 ~ 99.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//     A_Print_Out(1, 1, 3, 1);
// REMARK  The A_Print_Out function access data of all commands. This command has
//     to be placed after all function and before A_ClosePrn().The width and
//     height parameter is setting width and height pixel size. You can set
//     the pixel size except the smallest one by this function. Reducing the
//     resolution will causes the image pixel to be amplified and generate the
//     zigzag output. The amount parameter can be used to incrementing or
//     decrementing field values more than one label which can be set only
//     once during label formatting mode.
// typedef int   (_stdcall *pfnA_Print_Out)(int width, int height, int copies, int amount);
final A_Print_Out = _dll.lookupFunction<
    Int64 Function(Int64 width, Int64 height, Int64 copies, Int64 amount),
    int Function(int width, int height, int copies, int amount)>('A_Print_Out');
// *******************************************************************************
// A_Prn_Barcode()
// ===============================================================================
// PURPOSE   Create a "barcode" object.
// SYNTAX
//     int A_Prn_Barcode(int x, int y, int ori, char type, int narrow, int width,
//       int height, char mode, int numeric, LPTSTR data);
// PARAMETER
//     x;
//       X coordinate.
//     y;
//       Y coordinate.
//     ori;
//       Orientation or print direction, 1:0�X�B2:90�X�B3:180�X�B4:270�X
//     type;
//       Bar code type as follows:
//       +==========================================================================+
//       |Bar code    |Length    |Check|Type for|Type for   |Valid        |Bar ratio|
//       |            |          |sum  |readable|nonreadable|codes        |         |
//       |            |          |     |string  |string     |             |         |
//       +============+==========+=====+========+===========+=============+=========+
//       |Code 3 of 9 |variable  |no   |'A'     |'a'        |0~9,A~Z,$%*+-|2:1~     |
//       |            |          |     |        |           |./and space  |3:1      |
//       +------------+----------+-----+--------+-----------+-------------+---------+
//       |UPC-A       |12 digis  |yes  |'B'     |'b'        |0~9          |2:3:4    |
//       |            |(11+1)    |     |        |           |             |         |
//       +------------+----------+-----+--------+-----------+-------------+---------+
//       |UPC-E       |7 digits  |yes  |'C'     |'c'        |0~9          |2:3:4    |
//       |            |(6+1)     |     |        |           |             |         |
//       +------------+----------+-----+--------+-----------+-------------+---------+
//       |Interleaved |variable  |no   |'D'     |'d'        |0~9          |2:1~     |
//       |2 of 5 (I25)|          |     |        |           |             |3:1      |
//       +------------+----------+-----+--------+-----------+-------------+---------+
//       |Code 128    |variable  |yes  |'E'     |'e'        |form code 0  |2:3:4    |
//       |            |          |     |        |           |to 127(Note1)|         |
//       +------------+----------+-----+--------+-----------+-------------+---------+
//       |EAN-13      |13 digits |yes  |'F'     |'f'        |0~9          |2:3:4    |
//       |            |(12+1)    |     |        |           |             |         |
//       +------------+----------+-----+--------+-----------+-------------+---------+
//       |ENA-8       |8 digits  |yes  |'G'     |'g'        |0~9          |2:3:4    |
//       |            |(7+1)     |     |        |           |             |         |
//       +------------+----------+-----+--------+-----------+-------------+---------+
//       |HBIC        |variable  |yes  |'H'     |'h'        |0~9,A~Z,$%*+-|2:1~     |
//       |            |          |     |        |           |./and space  |3:1      |
//       +------------+----------+-----+--------+-----------+-------------+---------+
//       |Coda bar    |at least 3|no   |'I'     |'i'        |0~9,A~Z,$+-. |2:1~     |
//       |            |characters|     |        |           |And /        |3:1      |
//       +------------+----------+-----+--------+-----------+-------------+---------+
//       |Interleaved |variable  |yes  |'J'     |'j'        |0~9          |2:1~     |
//       |2 of 5 with +----------+     |        |           |             |3:1      |
//       |a modulo 10 checksum   |     |        |           |             |         |
//       +-----------------------+-----+--------+-----------+-------------+---------+
//       |Plessey     |1~14      |yes  |'K'     |'k'        |0~9          |2:1~     |
//       |            |digits    |     |        |           |             |3:1      |
//       +------------+----------+-----+--------+-----------+-------------+---------+
//       |Interleaved |variable  |yes  |'L'     |'l'        |0~9          |2:1~     |
//       |2 of 5 with +----------+-----+--------+-----------+             |3:1      |
//       |a modulo 10 checksum and shipping bearer bars     |             |         |
//       +------------+----------+-----+--------+-----------+-------------+---------+
//       |UPC2        |2 digits  |no   |'M'     |'m'        |0~9          |2:3:4    |
//       +------------+----------+-----+--------+-----------+-------------+---------+
//       |UPC5        |5 digits  |no   |'N'     |'n'        |0~9          |2:3:4    |
//       +------------+----------+-----+--------+-----------+-------------+---------+
//       |Code 93     |variable  |no   |'O'     |'o'        |0~9,A~Z,$%*+-|2:3:4    |
//       |            |          |     |        |           |./and space  |         |
//       +------------+----------+-----+--------+-----------+-------------+---------+
//       |Postnet     |variable  |yes  |not     |'p'        |0~9          |         |
//       |            |          |     |defined |           |             |         |
//       +------------+----------+-----+--------+-----------+-------------+---------+
//       |UCC/EAN Code|20 digits |yes  |'Q'     |'q'        |0~9          |2:3:4    |
//       |128         |(19+1)    |     |        |           |             |         |
//       +------------+----------+-----+--------+-----------+-------------+---------+
//       |UCC/EAN Code|18 digits |yes  |'R'     |'r'        |0~9          |2:3:4    |
//       |128 k-MART  |          |     |        |           |             |         |
//       +------------+----------+-----+--------+-----------+-------------+---------+
//       |UCC/EAN Code|variable  |yes  |'S'     |'s'        |0~9          |2:3:4    |
//       |128 Random  |          |     |        |           |             |         |
//       |weight      |          |     |        |           |             |         |
//       +------------+----------+-----+--------+-----------+-------------+---------+
//       |Telepen     |variable  |yes  |'T'     |'t'        |form code 0  |2:3:4    |
//       |            |          |     |        |           |to 127       |         |
//       +------------+----------+-----+--------+-----------+-------------+---------+
//       |FIM         |1         |no   |not     |'v'        |A,B,C and D  |         |
//       |            |character |     |defined |           |             |         |
//       +------------+----------+-----+--------+-----------+-------------+---------+
//       Note1: The Code 128 supports subsets A, B, and C. The default code subset is B;
//              otherwise, the first character (A, B, C) of the data field determines
//              the subset. So in order to prevent misjudgment, please additional
//              a character (A, B, C) before your data.
//              Example: subset = B
//                       barcode data = "Bar code"
//                       output = "BBar code"
//       Note: Please refer to the Argox PPLA Programmer Manual Section
//       "A10. PROGRAMMING EXAMPLES FOR BAR CODES"
//     narrow;
//       Define the narrow bar width from 0 ~ 24.
//     width;
//       Define the wide bar width from 0 ~ 24.
//       Note: The values of narrow and width must consult the proportion of bar ratio on forms.
//     height;
//       Bar code height. Value:0 ~ 999.
//     mode;
//       Add function as follows:
//       +----+-------------------------------------+
//       |mode|           REMARK                    |
//       +----+-------------------------------------+
//       | A  |Make auto increment for numeric.     |
//       +----+-------------------------------------+
//       | B  |Make auto increment for alphanumeric.|
//       +----+-------------------------------------+
//       | C  |Make auto decrement for numeric.     |
//       +----+-------------------------------------+
//       | D  |Make auto decrement for alphanumeric.|
//       +----+-------------------------------------+
//       | N  |Disable.                             |
//       +----+-------------------------------------+
//     numeric;
//       Automaticall increment or decrement the filed value. Value:0 ~ 99.
//       This field must exist When has add function.
//     data;
//       Data string.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//     A_Prn_Barcode(150, 20, 4, 'A', 0, 0, 20, 'B', 1, "ABCD");
// REMARK  The A_Prn_Barcode function can print a special Barcode�C
// typedef int   (_stdcall *pfnA_Prn_Barcode)(int x, int y, int ori, char type, int narrow, int width,
// 						 int height, char mode, int numeric, LPTSTR data);
final A_Prn_Barcode = _dll.lookupFunction<
    Int64 Function(
  Int64 x,
  Int64 y,
  Int64 ori,
  Pointer<Utf8> type,
  Int64 narrow,
  Int64 width,
  Int64 height,
  Pointer<Utf8> mode,
  Int64 numeric,
  Pointer<Utf8> data,
),
    int Function(
  int x,
  int y,
  int ori,
  Pointer<Utf8> type,
  int narrow,
  int width,
  int height,
  Pointer<Utf8> mode,
  int numeric,
  Pointer<Utf8> data,
)>('A_Prn_Barcode');
// *******************************************************************************
// A_Prn_Text()
// ===============================================================================
// PURPOSE   Create a "text" object.
// SYNTAX
//     int A_Prn_Text(int x, int y, int ori, int font, int type, int hor_factor,
//         int ver_factor, char mode, int numeric, LPCTSTR data);
// PARAMETER
//     x;
//       X coordinate.
//     y;
//       Y coordinate.
//     ori;
//       Orientation or print direction, 1:0�X�B2:90�X�B3:180�X�B4:270�X
//     font;
//       Font type as follows:
//       Note:Refer to the font tables in User's Manual.
//     type;
//       As follows:
//       +--------------+-----+---------------------------+
//       |font          |type |Font Type                  |
//       +--------------+-----+---------------------------+
//       |0,1,2,3,4,5,6,|0    |font 0~font 8 respectively.|
//       |7,8           |     |                           |
//       +--------------+-----+---------------------------+
//       |9             |0~7  |ASD smooth fonts.          |
//       |              |     |0:4points,  1:6points,     |
//       |              |     |2:8points,  3:10points,    |
//       |              |     |4:12points, 5:14points,    |
//       |              |     |6:18points.                |
//       +--------------+-----+---------------------------+
//       |9             |xxx  |PCL soft font.             |
//       |              |     |xxx : soft font ID with    |
//       |              |     |      3 digits             |
//       +--------------+-----+---------------------------+
//       |11            |0~7  |Courier fonts,(0 represents|
//       |              |     |symbol set)                |
//       |              |     |0:Roman-8,  1:ECMA-94,     |
//       |              |     |2:PC set,   3:PC set A,    |
//       |              |     |4:PC set B, 5:Legal,       |
//       |              |     |6:Greek,    7:Russian.     |
//       +--------------+-----+---------------------------+
//       |12            |0    |Font selection form font   |
//       |              |     |board.                     |
//       +--------------+-----+---------------------------+
//     hor_factor;
//       Horizontal scale factor.  Value:1 ~ 24
//     ver_factor;
//       Vertical scale factor.    Value:1 ~ 24
//     mode;
//       Add function as follows:
//       +----+-------------------------------------+
//       |mode|           REMARK                    |
//       +----+-------------------------------------+
//       | A  |Make auto increment for numeric.     |
//       +----+-------------------------------------+
//       | B  |Make auto increment for alphanumeric.|
//       +----+-------------------------------------+
//       | C  |Make auto decrement for numeric.     |
//       +----+-------------------------------------+
//       | D  |Make auto decrement for alphanumeric.|
//       +----+-------------------------------------+
//       | M  |Toggle the mirror mode.              |
//       +----+-------------------------------------+
//       | N  |Disable.                             |
//       +----+-------------------------------------+
//     numeric;
//       Automaticall increment or decrement the filed value. Value:0 ~ 99.
//       This field must exist When has add function.
//     data;
//       Data string.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//     A_Prn_Text(310, 35, 1, 9, 0, 1, 1, 'N', 2, "PPLA COMMAND");
// REMARK  The A_Prn_Text function can print a line text.
// typedef int   (_stdcall *pfnA_Prn_Text)(int x, int y, int ori, int font, int type, int hor_factor,
// 						 int ver_factor, char mode, int numeric, LPCTSTR data);
final A_Prn_Text = _dll.lookupFunction<
    Int64 Function(
  Int64 x,
  Int64 y,
  Int64 ori,
  Int64 font,
  Int64 type,
  Int64 hor_factor,
  Int64 ver_factor,
  Pointer<Utf8> mode,
  Int64 numeric,
  Pointer<Utf8> data,
),
    int Function(
  int x,
  int y,
  int ori,
  int font,
  int type,
  int hor_factor,
  int ver_factor,
  Pointer<Utf8> mode,
  int numeric,
  Pointer<Utf8> data,
)>('A_Prn_Text');
// *******************************************************************************
// A_Prn_Text_Chinese()
// ===============================================================================
// PURPOSE   Create a "text" object with Chinese dot font file (16*15 or 24*24).
// SYNTAX
//     int A_Prn_Text_Chinese(int x, int y, int fonttype, LPCTSTR id_name,
//       LPCTSTR data, int mem_mode);
// PARAMETER
//     x;
//       X coordinates.(dot)
//     y;
//       Y coordinates.(dot)
//     fonttype;
//       Select Chinese dot font file. 0 -> 16*15�B1 -> 24*24.
//     id_name;
//       To give a id name to store in printer after calling text by A_Load_Graphic().
//     data;
//       A text string.
//     mem_mode;
//       Memory mode, 1 => RAM, 2 => Flash Memory
//       Notice: The flash writing lifespan is limited, unless for special applications
//       that require store in Flash memory then recall in another procedure,
//       for general printing, it's strongly recommended that all graphics being download into RAM.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//     A_Open_ChineseFont("C:\\ET3");
//     A_Prn_Text_Chinese(100, 100, 0, "A01", "��a�Q�q���e�Ϣ�Ѣ�Ң�", 1);
final A_Prn_Text_Chinese = _dll.lookupFunction<
    Int64 Function(
  Int64 x,
  Int64 y,
  Int64 fonttype,
  Pointer<Utf8> id_name,
  Pointer<Utf8> data,
  Int64 mem_mode,
),
    int Function(
  int x,
  int y,
  int fonttype,
  Pointer<Utf8> id_name,
  Pointer<Utf8> data,
  int mem_mode,
)>('A_Prn_Text_Chinese');
// *******************************************************************************
// A_Prn_Text_TrueType()
// A_Prn_Text_TrueType_W()
// A_Prn_Text_TrueType_Uni()
// A_Prn_Text_TrueType_UniB()
// ===============================================================================
// PURPOSE   To print a line of text in TrueType font.
// SYNTAX
//   VC:
//     int A_Prn_Text_TrueType(int x, int y, int FSize, LPCTSTR FType, int Fspin,
//       int FWeight, int FItalic, int FUnline, int FStrikeOut, LPCTSTR id_name,
//       LPCTSTR data, int mem_mode);
//     int A_Prn_Text_TrueType_W(int x, int y, int FHeight, int FWidth, LPCTSTR FType,
//       int Fspin, int FWeight, int FItalic, int FUnline, int FStrikeOut,
//       LPCTSTR id_name, LPCTSTR data, int mem_mode);
//     int A_Prn_Text_TrueType_Uni(int x, int y, int FSize, LPCTSTR FType, int Fspin,
//       int FWeight, int FItalic, int FUnline, int FStrikeOut, LPCTSTR id_name,
//       LPCWSTR data, int format, int mem_mode);
//     int A_Prn_Text_TrueType_UniB(int x, int y, int FSize, LPCTSTR FType, int Fspin,
//       int FWeight, int FItalic, int FUnline, int FStrikeOut, LPCTSTR id_name,
//       LPCTSTR data, int format, int mem_mode);
//   VB: VBA:
//     Declare Function A_Prn_Text_TrueType(ByVal x As Long, ByVal y As Long, _
//       ByVal FSize As Long, ByVal FType As String, ByVal Fspin As Long, _
//       ByVal FWeight As Long, ByVal FItalic As Long, ByVal FUnline As Long, _
//       ByVal FStrikeOut As Long, ByVal id_name As String, ByVal data As String, _
//       ByVal mem_mode As Long) As Long
//     Declare Function A_Prn_Text_TrueType_W(ByVal x As Long, ByVal y As Long, _
//       ByVal FHeight As Long, ByVal FWidth As Long, ByVal FType As String, _
//       ByVal Fspin As Long, ByVal FWeight As Long, ByVal FItalic As Long, _
//       ByVal FUnline As Long, ByVal FStrikeOut As Long, ByVal id_name As String, _
//       ByVal data As String, ByVal mem_mode As Long) As Long
//     Declare Function A_Prn_Text_TrueType_Uni(ByVal x As Long, ByVal y As Long, _
//       ByVal FSize As Long, ByVal FType As String, ByVal Fspin As Long, _
//       ByVal FWeight As Long, ByVal FItalic As Long, ByVal FUnline As Long, _
//       ByVal FStrikeOut As Long, ByVal id_name As String, ByRef data As Byte, _
//       ByVal format As Long, ByVal mem_mode As Long) As Long
//     Declare Function A_Prn_Text_TrueType_UniB(ByVal x As Long, ByVal y As Long, _
//       ByVal FSize As Long, ByVal FType As String, ByVal Fspin As Long, _
//       ByVal FWeight As Long, ByVal FItalic As Long, ByVal FUnline As Long, _
//       ByVal FStrikeOut As Long, ByVal id_name As String, ByRef data As Byte, _
//       ByVal format As Long, ByVal mem_mode As Long) As Long
//   VB.net:
//     Declare Function A_Prn_Text_TrueType(ByVal x As Integer, ByVal y As Integer, _
//       ByVal FSize As Integer, ByVal FType As String, ByVal Fspin As Integer, _
//       ByVal FWeight As Integer, ByVal FItalic As Integer, ByVal FUnline As Integer, _
//       ByVal FStrikeOut As Integer, ByVal id_name As String, ByVal data As String, _
//       ByVal mem_mode As Integer) As Integer
//     Declare Function A_Prn_Text_TrueType_W(ByVal x As Integer, ByVal y As Integer, _
//       ByVal FHeight As Integer, ByVal FWidth As Integer, ByVal FType As String, _
//       ByVal Fspin As Integer, ByVal FWeight As Integer, ByVal FItalic As Integer, _
//       ByVal FUnline As Integer, ByVal FStrikeOut As Integer, ByVal id_name As String, _
//       ByVal data As String, ByVal mem_mode As Integer) As Integer
//     Declare Function A_Prn_Text_TrueType_Uni(ByVal x As Integer, ByVal y As Integer, _
//       ByVal FSize As Integer, ByVal FType As String, ByVal Fspin As Integer, _
//       ByVal FWeight As Integer, ByVal FItalic As Integer, ByVal FUnline As Integer, _
//       ByVal FStrikeOut As Integer, ByVal id_name As String, ByVal data As Byte(), _
//       ByVal format As Integer, ByVal mem_mode As Integer) As Integer
//     Declare Function A_Prn_Text_TrueType_UniB(ByVal x As Integer, ByVal y As Integer, _
//       ByVal FSize As Integer, ByVal FType As String, ByVal Fspin As Integer, _
//       ByVal FWeight As Integer, ByVal FItalic As Integer, ByVal FUnline As Integer, _
//       ByVal FStrikeOut As Integer, ByVal id_name As String, ByVal data As Byte(), _
//       ByVal format As Integer, ByVal mem_mode As Integer) As Integer
// PARAMETER
//     x;
//       X-coordinates.
//     y;
//       Y-coordinates.
//     FSize;
//       TrueType font size; unit: dot.
//     FHeight;
//       Font height, unit: dot.
//     FWidth;
//       Font width, unit: dot.
//     FType;
//       Name of TrueType font.
//     Fspin;
//       TrueType font rotation. 1 -> 0, 2 -> 90, 3 -> 180, 4 -> 270
//     FWeight;
//       TrueType font thickness.
//       0 and NULL is and  400 -> 400 Standard,
//       100 -> Extra fine, 200 -> Very fine,
//       300 -> Fine,       500 -> Normal,
//       600 -> Half-bold,  700 -> Bold,
//       800 -> Extra bold, 900 -> Boldface.
//     FItalic;
//       TrueType font set to Italic. 0 -> FALSE, 1 -> TRUE.
//     FUnline;
//       TrueType font set to underlined. 0 -> FALSE, 1 -> TRUE.
//     FStrikeOut;
//       TrueType font set to strikethrough. 0 -> FALSE, 1 -> TRUE.
//     id_name;
//       Provides a name to be stored in the printer for identification purposes;
//       can be call out graphic directly via the A_Load_Graphic() function.
//     data;
//       Text content.
//       For A_Prn_Text_TrueType_Uni() and A_Prn_Text_TrueType_UniB(), the encoding of input
//       data string should be in UTF-8, UTF-16, or in Unicode big endian format; the string
//       must be terminated with 0.
//     format;
//       Encoding scheme used to decode Unicode data.
//       0 -> Determined by the BOM (byte order mark) in the string header.
//       1 -> UTF-16.
//       2 -> Unicode big endian.
//       3 -> UTF-8.
//     mem_mode;
//       Storage location of graphics, 1 => RAM, 2 => Flash Memory
//       Note: Flash memory has a limited lifetime. It is recommended that data be stored in
//       RAM unless it will be reused.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//   VC:
//     char *ver, *pbuf = new char[128];
//     A_Prn_Text_TrueType(20, 60, 30, "Arial", 1, 400, 0, 0, 0, "AA",
//       "TrueType Font", 1);//save in ram.
//     A_Prn_Text_TrueType_W(20, 90, 20, 20, "Times New Roman", 1, 400, 0, 0, 0, "AB",
//       "TT_W: �h�r������", 1);
//     A_Prn_Text_TrueType_Uni(20, 120, 30, "Times New Roman", 1, 400, 0, 0, 0, "AC",
//       L"TT_Uni: �h�r������", 1, 1);//UTF-16
//     strcpy(pbuf, "\xFF\xFE");//UTF-16.
//     memcpy(&pbuf[2], (char *)L"TT_UniB: �h�r������", 15*2);//copy mutil byte.
//     A_Prn_Text_TrueType_UniB(20, 150, 30, "Times New Roman", 1, 400, 0, 0, 0, "AD",
//       pbuf, 0, 1);//Byte Order Mark.
//   VB: VBA:
//     Dim buff1(128) As Byte
//     Dim buff2() As Byte
//     Dim i As Integer
//     Call A_Prn_Text_TrueType(20, 60, 30, "Arial", 1, 400, 0, 0, 0, "AA", _
//       "TrueType Font", 1) 'save in ram.
//     Call A_Prn_Text_TrueType_W(20, 90, 20, 20, "Times New Roman", 1, 400, 0, 0, 0, _
//       "AB", "TT_W: �h�r������", 1)
//     buff2 = StrConv("TT_Uni: �h�r������", vbNarrow)
//     'Converts UNICODE(wide characters) to single-byte characters.
//     For i = LBound(buff2) To UBound(buff2)
//         buff1(i) = buff2(i)
//     Next i
//     buff1(26) = 0 'null.
//     buff1(27) = 0
//     Call A_Prn_Text_TrueType_Uni(20, 120, 30, "Times New Roman", 1, 400, 0, 0, 0, _
//       "AC", buff1(0), 1, 1) 'UTF-16
//     buff1(0) = 255 'UTF-16.
//     buff1(1) = 254
//     buff2 = StrConv("TT_UniB: �h�r������", vbNarrow)
//     'Converts UNICODE(wide characters) to single-byte characters.
//     For i = LBound(buff2) To UBound(buff2)
//         buff1(i + 2) = buff2(i)
//     Next i
//     buff1(30) = 0 'null.
//     buff1(31) = 0
//     Call A_Prn_Text_TrueType_UniB(20, 150, 30, "Times New Roman", 1, 400, 0, 0, 0, _
//       "AD", buff1(0), 0, 1) 'Byte Order Mark.
//   VB.net:
//     Dim pbuf(128) As Byte
//     Dim encUnicode = System.Text.Encoding.Unicode
//     Call A_Prn_Text_TrueType(20, 60, 30, "Arial", 1, 400, 0, 0, 0, "AA", _
//       "TrueType Font", 1) 'save in ram.
//     Call A_Prn_Text_TrueType_W(20, 90, 20, 20, "Times New Roman", 1, 400, 0, 0, 0, _
//       "AB", "TT_W: �h�r������", 1)
//     Call A_Prn_Text_TrueType_Uni(20, 120, 30, "Times New Roman", 1, 400, 0, 0, 0, _
//       "AC", encUnicode.GetBytes("TT_Uni: �h�r������"), 1, 1) 'UTF-16
//     pbuf(0) = 255 'UTF-16.
//     pbuf(1) = 254
//     encUnicode.GetBytes("TT_UniB: �h�r������", 0, 14, pbuf, 2) 'copy mutil byte.
//     pbuf(30) = 0 'null.
//     pbuf(31) = 0
//     Call A_Prn_Text_TrueType_UniB(20, 150, 30, "Times New Roman", 1, 400, 0, 0, 0, _
//       "AD", pbuf, 0, 1) 'Byte Order Mark
// REMARK  The A_Prn_Text_TrueType() function prints a line of text in TrueType font.
// typedef int   (_stdcall *pfnA_Prn_Text_TrueType)(int x, int y, int FSize, LPCTSTR FType, int Fspin,
// 						 int FWeight, int FItalic, int FUnline, int FStrikeOut, LPCTSTR id_name,
// 						 LPCTSTR data, int mem_mode);
// typedef int   (_stdcall *pfnA_Prn_Text_TrueType_Uni)(int x, int y, int FSize, LPCTSTR FType,
// 						 int Fspin, int FWeight, int FItalic, int FUnline, int FStrikeOut,
// 						 LPCTSTR id_name, LPCWSTR data, int format, int mem_mode);
// typedef int   (_stdcall *pfnA_Prn_Text_TrueType_W)(int x, int y, int FHeight, int FWidth,
// 						 LPCTSTR FType, int Fspin, int FWeight, int FItalic, int FUnline,
// 						 int FStrikeOut, LPCTSTR id_name, LPCTSTR data, int mem_mode);
final A_Prn_Text_TrueType = _dll.lookupFunction<
    Int64 Function(
  Int64 x,
  Int64 y,
  Int64 fSize,
  Pointer<Utf8> fType,
  Int64 fSpin,
  Int64 fWeight,
  Int64 fItalic,
  Int64 fUnline,
  Int64 fStrikeOut,
  Pointer<Utf8> id_name,
  Pointer<Utf8> data,
  Int64 mem_mode,
),
    int Function(
  int x,
  int y,
  int fSize,
  Pointer<Utf8> fType,
  int fSpin,
  int fWeight,
  int fItalic,
  int fUnline,
  int fStrikeOut,
  Pointer<Utf8> id_name,
  Pointer<Utf8> data,
  int mem_mode,
)>('A_Prn_Text_TrueType');
final A_Prn_Text_TrueType_W = _dll.lookupFunction<
    Int64 Function(
  Int64 x,
  Int64 y,
  Int64 fHeight,
  Int64 fWidth,
  Pointer<Utf8> fType,
  Int64 fSpin,
  Int64 fWeight,
  Int64 fItalic,
  Int64 fUnline,
  Int64 fStrikeOut,
  Pointer<Utf8> idName,
  Pointer<Utf8> data,
  Int64 memMode,
),
    int Function(
  int x,
  int y,
  int fHeight,
  int fWidth,
  Pointer<Utf8> fType,
  int fSpin,
  int fWeight,
  int fItalic,
  int fUnline,
  int fStrikeOut,
  Pointer<Utf8> idName,
  Pointer<Utf8> data,
  int memMode,
)>('A_Prn_Text_TrueType_W');
final A_Prn_Text_TrueType_Uni = _dll.lookupFunction<
    Int64 Function(
  Int64 x,
  Int64 y,
  Int64 fSize,
  Pointer<Utf8> fType,
  Int64 fSpin,
  Int64 fWeight,
  Int64 fItalic,
  Int64 fUnline,
  Int64 fStrikeOut,
  Pointer<Utf8> id_name,
  Pointer<Utf8> data,
  Int64 format,
  Int64 mem_mode,
),
    int Function(
  int x,
  int y,
  int fSize,
  Pointer<Utf8> fType,
  int fSpin,
  int fWeight,
  int fItalic,
  int fUnline,
  int fStrikeOut,
  Pointer<Utf8> id_name,
  Pointer<Utf8> data,
  int format,
  int mem_mode,
)>('A_Prn_Text_TrueType_Uni');
// typedef int   (_stdcall *pfnA_Prn_Text_TrueType_UniB)(int x, int y, int FSize, LPCTSTR FType,
// 						 int Fspin, int FWeight, int FItalic, int FUnline, int FStrikeOut,
// 						 LPCTSTR id_name, LPCTSTR data, int format, int mem_mode);
final A_Prn_Text_TrueType_UniB = _dll.lookupFunction<
    Int64 Function(
  Int64 x,
  Int64 y,
  Int64 fSize,
  Pointer<Utf8> fType,
  Int64 fSpin,
  Int64 fWeight,
  Int64 fItalic,
  Int64 fUnline,
  Int64 fStrikeOut,
  Pointer<Utf8> id_name,
  Pointer<Utf8> data,
  Int64 format,
  Int64 mem_mode,
),
    int Function(
  int x,
  int y,
  int fSize,
  Pointer<Utf8> fType,
  int fSpin,
  int fWeight,
  int fItalic,
  int fUnline,
  int fStrikeOut,
  Pointer<Utf8> id_name,
  Pointer<Utf8> data,
  int format,
  int mem_mode,
)>('A_Prn_Text_TrueType_UniB');
// *******************************************************************************
// A_Set_Backfeed()
// ===============================================================================
// PURPOSE   Setup the "back feed" function.
// SYNTAX
//   VC:
//     int A_Set_Backfeed(int back);
//   VB: VBA:
//     Declare Function A_Set_Backfeed(ByVal back As Long) As Long
//   VB.net:
//     Declare Function A_Set_Backfeed(ByVal back As Integer) As Integer
// PARAMETER
//     back;
//       Stop position. Value:220 ~ 999. The default is 220 in the printer.
//       Note: 1 = 0.01 inches.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//   VC:
//     A_Set_Backfeed(320);
//   VB: VBA: VB.net:
//     Call A_Set_Backfeed(320)
// REMARK  The A_Set_Backfeed() function enables the label to be fed a little bit
//     ahead after printing which user could tear it off easily. And the label
//     roll will be withdraw to proper position before the next label printed.
//     Back-feed will not be activated if the value less than 220. Under
//     multi-copy or countinuous printing, this command is vaild only for the
//     first label.
final A_Set_Backfeed =
    _dll.lookupFunction<Int64 Function(Int64 back), int Function(int back)>(
        'A_Set_Backfeed');
// *******************************************************************************
// A_Set_BMPSave()
// ===============================================================================
// PURPOSE   Save Image File.
// SYNTAX
//   VC:
//     int A_Set_BMPSave(int nSave, char *pstrBMPFName);
//   VB: VBA:
//     Declare Function A_Set_BMPSave(ByVal nSave As Long, _
//       ByVal pstrBMPFName As String) As Long
//   VB.net:
//     Declare Function A_Set_BMPSave(ByVal nSave As Integer, _
//       ByVal pstrBMPFName As String) As Integer
// PARAMETER
//     nSave;
//       1 -> Save Image. 0 -> Don't Save Image.
//     pstrBMPFName;
//       File Name.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//   VC:
//     A_Set_BMPSave(1, "C:\\TempBMP.bmp");
//   VB: VBA: VB.net:
//     Call A_Set_BMPSave(1, "C:\\TempBMP.bmp")
// REMARK  The A_Set_BMPSave function can decide to save image to file.
final A_Set_BMPSave = _dll.lookupFunction<
    Int64 Function(Int64 nSave, Pointer<Utf8> pstrBmpFName),
    int Function(
  int nSave,
  Pointer<Utf8> pstrBmpFName,
)>('A_Set_BMPSave');
// *******************************************************************************
// A_Set_Cutting()
// ===============================================================================
// PURPOSE   Setup the "cutting" function.
// SYNTAX
//   VC:
//     int A_Set_Cutting(int cutting);
//   VB: VBA:
//     Declare Function A_Set_Cutting(ByVal cutting As Long) As Long
//   VB.net:
//     Declare Function A_Set_Cutting(ByVal cutting As Integer) As Integer
// PARAMETER
//     cutting;
//       Specified count number of label to be cut. Value: 0 ~ 9999.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//   VC:
//     A_Set_Cutting(12);
//   VB: VBA: VB.net:
//     Call A_Set_Cutting(12)
// REMARK  The A_Set_Cutting function is available only when the cutter is
//     installed(Enable Cutter). Set "cutting" after the specified count number of labels.
final A_Set_Cutting = _dll.lookupFunction<Int64 Function(Int64 cutting),
    int Function(int cutting)>('A_Set_Cutting');
// *******************************************************************************
// A_Set_Darkness();
// ===============================================================================
// PURPOSE   Setup the "darkness" function (heating level).
// SYNTAX
//   VC:
//     int A_Set_Darkness(int heat);
//   VB: VBA:
//     Declare Function A_Set_Darkness(ByVal darkness As Long) As Long
//   VB.net:
//     Declare Function A_Set_Darkness(ByVal darkness As Integer) As Integer
// PARAMETER
//     heat;
//       Set heat value(0 ~ 20). Default value 10.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//   VC:
//     A_Set_Darkness(12);
//   VB: VBA: VB.net:
//     Call A_Set_Darkness(12)
// REMARK  Heat value will define the image's darkness. To get a printout with
//     better quality, you should consider following factors i.e. media material,
//     ribbon types(wax,semi-resin and resin) and image pattern itself.
final A_Set_Darkness =
    _dll.lookupFunction<Int64 Function(Int64 heat), int Function(int heat)>(
        'A_Set_Darkness');
// *******************************************************************************
// A_Set_DebugDialog()
// ===============================================================================
// PURPOSE   Enable Debug Message Dialog.
// SYNTAX
//   VC:
//     int A_Set_DebugDialog(int nEnable);
//   VB: VBA:
//     Declare Function A_Set_DebugDialog(ByVal nEnable As Long) As Long
//   VB:
//     Declare Function A_Set_DebugDialog(ByVal nEnable As Integer) As Integer
// PARAMETER
//     nEnable;
//       1 -> Enable. 0 -> Disable.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//   VC:
//     A_Set_DebugDialog(1);
//   VB: VBA: VB.net:
//     Call A_Set_DebugDialog(1)
// REMARK  The A_Set_DebugDialog function set debug message dialog.
final A_Set_DebugDialog = _dll.lookupFunction<Int64 Function(Int64 nEnable),
    int Function(int nEnable)>('A_Set_DebugDialog');
// *******************************************************************************
// A_Set_Feed()
// ===============================================================================
// PURPOSE   Feed out one label from printer.
// SYNTAX
//   VC:
//     int A_Set_Feed(char rate);
//   VB: VBA:
//     Declare Function A_Set_Feed(ByVal rate As Byte) As Long
//   VB.net:
//     Declare Function A_Set_Feed(ByVal rate As Byte) As Integer
// PARAMETER
//     rate;
//       Set feed speed as follows:(A~K)
//       +---+-------+---+-------+---+-------+---+-------+---+-------+---+-------+
//       | A |1.0 ips| B |1.5 ips| C |2.0 ips| D |2.5 ips| E |3.0 ips| F |3.5 ips|
//       +---+-------+---+-------+---+-------+---+-------+---+-------+---+-------+
//       | G |4.0 ips| H |4.5 ips| I |5.0 ips| J |5.5 ips| K |6.0 ips|   |       |
//       +---+-------+---+-------+---+-------+---+-------+---+-------+---+-------+
//       +----------+-----------+
//       |  Printer |Speed Range|
//       +----------+-----------+
//       |OS-214/204|    A~E    |
//       +----------+-----------+
//       |  OS-314  |    A~C    |
//       +----------+-----------+
//       |  X-1000  |    A~G    |
//       +----------+-----------+
//       |  X-2000  |    A~I    |
//       +----------+-----------+
//       |  X-3000  |    A~K    |
//       +----------+-----------+
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//   VC:
//     A_Set_Feed('E');
//   VB: VBA: VB.net:
//     Call A_Set_Feed(Asc("E"))
// REMARK  The A_Set_Feed function will define the feed speed. Every time you
//     press the button or send Feed_Label function, the motor speed will
//     follow the parameter.
final A_Set_Feed = _dll.lookupFunction<Int64 Function(Pointer<Utf8> rate),
    int Function(Pointer<Utf8> rate)>('A_Set_Feed');
// *******************************************************************************
// A_Set_Form()
// ===============================================================================
// PURPOSE   Download a form from PC into printers RAM or Flash memory.
// SYNTAX
//   VC:
//     int A_Set_Form(LPCTSTR formfile, LPCTSTR form_name, int mem_mode);
//   VB: VBA:
//     Declare Function A_Set_Form(ByVal formfile As String, ByVal form_name As String, _
//       ByVal mem_mode As Long) As Long
//   VB.net:
//     Declare Function A_Set_Form(ByVal formfile As String, ByVal form_name As String, _
//       ByVal mem_mode As Integer) As Integer
// PARAMETER
//     formfile;
//       File path for form.
//     form_name;
//       The form name is stored in printer.
//     mem_mode;
//       Memory mode, 1 => RAM, 2 => Flash Memory
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//   VC:
//     A_Set_Form("demo.prn", "demo", 1);
//   VB: VBA: VB.net:
//     Call A_Set_Form("demo.prn", "demo", 1)
// REMARK  The A_Set_Form function activates a form store sequence to be printed.
//     The function is used befor Print_Form().
final A_Set_Form = _dll.lookupFunction<
    Int64 Function(
  Pointer<Utf8> formfile,
  Pointer<Utf8> form_name,
  Int64 mem_mode,
),
    int Function(
  Pointer<Utf8> formfile,
  Pointer<Utf8> form_name,
  int mem_mode,
)>('A_Set_Form');
// *******************************************************************************
// A_Set_Margin()
// ===============================================================================
// PURPOSE   Setup the top and left margin.
// SYNTAX
//   VC:
//     int A_Set_Margin(int position, int margin);
//   VB: VBA:
//     Declare Function A_Set_Margin(ByVal position As Long, _
//       ByVal margin As Long) As Long
//   VB.net:
//     Declare Function A_Set_Margin(ByVal position As Integer, _
//       ByVal margin As Integer) As Integer
// PARAMETER
//     position;
//       Set start print position.Value 0 ~ 9999.
//       Format: 220 + position.(100 = one inch)
//     margin;
//       Set left margin.Value 0 ~ 9999. (100 = 1 inch)
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//   VC:
//     A_Set_Margin(100, 100);
//   VB: VBA: VB.net:
//     Call A_Set_Margin(100, 100)
// REMARK  The A_Set_Margin function used to set the offset value for initial
//     printing position and sets the left margin or column offset. The
//     default 220 makes the leading end of label under the TPH(print head)
//     line. You may change it to meet the specific paper and margin settings.
//     Different margin value will makes image to shift left or right.
final A_Set_Margin = _dll.lookupFunction<
    Int64 Function(Int64 position, Int64 margin),
    int Function(int position, int margin)>('A_Set_Margin');
// *******************************************************************************
// A_Set_Prncomport()
// ===============================================================================
// PURPOSE   Setup the serial port for printer.
// SYNTAX
//   VC:
//     int A_Set_Prncomport(int baud, int parity, int data, int stop);
//   VB: VBA:
//     Declare Function A_Set_Prncomport(ByVal baud As Long, ByVal parity As Long, _
//       ByVal data As Long, ByVal sstop As Long) As Long
//   VB.net:
//     Declare Function A_Set_Prncomport(ByVal baud As Integer, ByVal parity As Integer, _
//       ByVal data As Integer, ByVal sstop As Integer) As Integer
// PARAMETER
//     baud;
//       Baud, List:
//       0 -> 9600, 1 -> 600
//       2 -> 2400, 3 -> 19200
//       4 -> 4800, 5 -> 38400
//       6 -> 1200, 7 -> 9600
//       8 -> 57600, 9 -> 115200
//     parity;
//       Parity, List:
//       0 -> none parity
//       1 -> even parity
//       2 -> odd  parity
//     data;
//       Data bit number:
//       7 -> 7-bit data
//       8 -> 8-bit data
//     stop;
//       Stop bit number:
//       1 -> 1 stop bit
//       2 -> 2 stop bits
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//   VC:
//     A_Set_Prncomport(0, 0, 8, 1);
//   VB: VBA: VB.net:
//     Call A_Set_Prncomport(0, 0, 8, 1)
// REMARK  The fuction of A_Set_Prncomport is to setup the value of printer
//     serial Port. For successful communication between PC and Printer, this
//     value should be commanded in accrodance with the setting value of PC.
//     Besides, this command should be set before A_Print_Out() executed.
// typedef int   (_stdcall *pfnA_Set_Prncomport)(int baud, int parity, int data, int stop);
final A_Set_Prncomport = _dll.lookupFunction<
    Int64 Function(Int64 baud, Int64 parity, Int64 data, Int64 stop),
    int Function(int baud, int parity, int data, int stop)>('A_Set_Prncomport');
// *******************************************************************************
// A_Set_Prncomport_PC()
// ===============================================================================
// PURPOSE   Setup the serial port for PC.
// SYNTAX
//   VC:
//     int A_Set_Prncomport_PC(int nBaudRate, int nByteSize, int nParity, int nStopBits,
//       int nDsr, int nCts, int nXonXoff);
//   VB: VBA:
//     Declare Function A_Set_Prncomport_PC(ByVal nBaudRate As Long, _
//       ByVal nByteSize As Long, ByVal nParity As Long, ByVal nStopBits As Long, _
//       ByVal nDsr As Long, ByVal nCts As Long, ByVal nXonXoff As Long) As Long
//   VB.net:
//     Declare Function A_Set_Prncomport_PC(ByVal nBaudRate As Integer, _
//       ByVal nByteSize As Integer, ByVal nParity As Integer, ByVal nStopBits As Integer, _
//       ByVal nDsr As Integer, ByVal nCts As Integer, ByVal nXonXoff As Integer) As Integer
// PARAMETER
//     nBaudRate;
//       Baud rate:
//       1 -> 110     9 -> 19200
//       2 -> 300    10 -> 38400
//       3 -> 600    11 -> 56000
//       4 -> 1200   12 -> 57600
//       5 -> 2400   13 -> 115200
//       6 -> 4800   14 -> 128000
//       7 -> 9600   15 -> 256000
//       8 -> 14400   0 -> 9600
//     nByteSize;
//       Data bit number:
//       0 -> 7-bit data
//       7 -> 7-bit data
//       8 -> 8-bit data
//     nParity;
//       Parity:
//       0 -> none parity
//       1 -> even parity
//       2 -> odd  parity
//     nStopBits;
//       Stop bit number:
//       0 -> 1 stop bit
//       1 -> 1 stop bit
//       2 -> 2 stop bits
//     nDsr;
//       Setup hardware flow control
//       1 -> DTR CONTROL HANDSHAKE;
//       0 -> DTR CONTROL ENABLE;
//     nCts;
//       Setup hardware flow control
//       1 -> RTS CONTROL HANDSHAKE;
//       0 -> RTS CONTROL ENABLE;
//     nXonXoff;
//       Setup software flow control
//       0 -> Enable;
//       1 -> Disable;
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//   VC:
//     A_Set_Prncomport_PC(0, 0, 0, 0, 0, 0, 0);
//   VB: VBA: VB.net:
//     Call A_Set_Prncomport_PC(0, 0, 0, 0, 0, 0, 0)
// REMARK  The fuction of A_Set_Prncomport_PC is to setup the value of PC serial
//     Port. For successful communication between PC and Printer, this value
//     should be commanded in accrodance with the setting value of printer.
//     Besides, this command should be set before A_Print_Out() executed.
// typedef int   (_stdcall *pfnA_Set_Prncomport_PC)(int nBaudRate, int nByteSize, int nParity,
// 						 int nStopBits, int nDsr, int nCts, int nXonXoff);
final A_Set_Prncomport_PC = _dll.lookupFunction<
    Int64 Function(
  Int64 nBaudRate,
  Int64 nByteSize,
  Int64 nParity,
  Int64 nStopBits,
  Int64 nDsr,
  Int64 nCts,
  Int64 nXonXoff,
),
    int Function(
  int nBaudRate,
  int nByteSize,
  int nParity,
  int nStopBits,
  int nDsr,
  int nCts,
  int nXonXoff,
)>('A_Set_Prncomport_PC');
// *******************************************************************************
// A_Set_Sensor_Mode()
// ===============================================================================
// PURPOSE   Setup the "sensoring" mode (gap, black mark, continuous).
// SYNTAX
//   VC:
//     int A_Set_Sensor_Mode(char type, int continuous);
//   VB: VBA:
//     Declare Function A_Set_Sensor_Mode(ByVal ttype As Byte, _
//       ByVal continuous As Long) As Long
//   VB.net:
//     Declare Function A_Set_Sensor_Mode(ByVal ttype As Byte, _
//       ByVal continuous As Integer) As Integer
// PARAMETER
//     type;
//     continuous;
//       +----+-----------+---------------------------------+
//       |TYPE|continuous |REMARK                           |
//       +----+-----------+---------------------------------+
//       | e  |  0        |Select edge sensor (Default)     |
//       +----+-----------+---------------------------------+
//       | r  |  0        |Select reflective sensor for gap |
//       +----+-----------+---------------------------------+
//       | c  |0~9999 inch|Set continuous paper type        |
//       +----+-----------+---------------------------------+
//       (100 = 1 inch)
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//   VC:
//     A_Set_Sensor_Mode('c', 300);
//   VB: VBA: VB.net:
//     Call A_Set_Sensor_Mode(Asc("c"),300)
// REMARK  Use "e" (see-through sensoring) for gap media .
//     Use "r" (reflective sensoring) for black mark media.
//     Use "c" for continuous media.
// typedef int   (_stdcall *pfnA_Set_Sensor_Mode)(char type, int continuous);
final A_Set_Sensor_Mode = _dll.lookupFunction<
    Int64 Function(Pointer<Utf8> type, Int64 continuous),
    int Function(Pointer<Utf8> type, int continuous)>('A_Set_Sensor_Mode');
// *******************************************************************************
// A_Set_Speed()
// ===============================================================================
// PURPOSE   Setup the "print speed".
// SYNTAX
//   VC:
//     int A_Set_Speed(char speed);
//   VB: VBA:
//     Declare Function A_Set_Speed(ByVal speed As Byte) As Long
//   VB.net:
//     Declare Function A_Set_Speed(ByVal speed As Byte) As Integer
// PARAMETER
//     speed;
//       Set print speed as follows:(A~K)
//       +---+-------+---+-------+---+-------+---+-------+---+-------+---+-------+
//       | A |1.0 ips| B |1.5 ips| C |2.0 ips| D |2.5 ips| E |3.0 ips| F |3.5 ips|
//       +---+-------+---+-------+---+-------+---+-------+---+-------+---+-------+
//       | G |4.0 ips| H |4.5 ips| I |5.0 ips| J |5.5 ips| K |6.0 ips| L |7.0 ips|
//       +---+-------+---+-------+---+-------+---+-------+---+-------+---+-------+
//       +----------+-----------+
//       |  Printer |Speed Range|
//       +----------+-----------+
//       |OS-214/204|    A~E    |
//       +----------+-----------+
//       |  OS-314  |    A~C    |
//       +----------+-----------+
//       |  X-1000  |    A~G    |
//       +----------+-----------+
//       |  X-2000  |    A~I    |
//       +----------+-----------+
//       |  X-3000  |    A~L    |
//       +----------+-----------+
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//   VC:
//     A_Set_Speed('E');
//   VB: VBA: VB.net:
//     Call A_Set_Speed(Asc("E"))
// REMARK  The A_Set_Speed function can control print speed.
// typedef int   (_stdcall *pfnA_Set_Speed)(char speed);
final A_Set_Speed = _dll.lookupFunction<Int64 Function(Pointer<Utf8> speed),
    int Function(Pointer<Utf8> speed)>('A_Set_Speed');
// *******************************************************************************
// A_Set_Syssetting()
// ===============================================================================
// PURPOSE   Other function setup e.g. printing type, cutter and dispenser
//       configuration, label length, slash zero mark, pause function ....
// SYNTAX
//   VC:
//     int A_Set_Syssetting(int transfer, int cut_peel, int length, int zero, int pause);
//   VB: VBA:
//     Declare Function A_Set_Syssetting(ByVal transfer As Long, ByVal cut_peel As Long, _
//       ByVal Length As Long, ByVal zero As Long, ByVal pause As Long) As Long
//   VB.net:
//     Declare Function A_Set_Syssetting(ByVal transfer As Integer, _
//       ByVal cut_peel As Integer, ByVal Length As Integer, ByVal zero As Integer, _
//       ByVal pause As Integer) As Integer
// PARAMETER
//     transfer;
//       Set transfer type as follows:
//       +----------+------------------+
//       | transfer | REMARK           |
//       +----------+------------------+
//       |    0     | Disabel          |
//       +----------+------------------+
//       |    1     | Direct thermal   |
//       +----------+------------------+
//       |    2     | Thermal transfer |
//       +----------+------------------+
//     cut_peel;
//       Set cutter and dispenser configuration as follows:
//       +----------+-----------------------------+
//       | cut_peel | REMARK                      |
//       +----------+-----------------------------+
//       |    9     | Disable                     |
//       +----------+-----------------------------+
//       |    0     | No cutter and peel function |
//       +----------+-----------------------------+
//       |    1     | Cutter engaged              |
//       +----------+-----------------------------+
//       |    4     | Peel engaged                |
//       +----------+-----------------------------+
//     length;
//       Set maximum label length.(1~1200)
//       You set '0' is disable.(100 = 1 inch)
//     zero;
//       Change slash zero to normal zero.
//       '0' is disable.
//       '1' makes you use the normal zero.
//     pause;
//       Set pause for each printed label as follows:
//       +-------+-------------+
//       | pause | REMARK      |
//       +-------+-------------+
//       |   0   | Disabel     |
//       +-------+-------------+
//       |   1   | Set pause   |
//       +-------+-------------+
//       |   2   | Cancel pause|
//       +-------+-------------+
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//   VC:
//     A_Set_Syssetting(2, 0, 1200, 1, 2);
//   VB: VBA: VB.net:
//     Call A_Set_Syssetting(2, 0, 1200, 1, 2)
// REMARK  The A_Set_Syssetting function is importance for the configuration.
// typedef int   (_stdcall *pfnA_Set_Syssetting)(int transfer, int cut_peel, int length, int zero,
// 						 int pause);
final A_Set_Syssetting = _dll.lookupFunction<
    Int64 Function(
  Int64 transfer,
  Int64 cut_peel,
  Int64 length,
  Int64 zero,
  Int64 pause,
),
    int Function(
  int transfer,
  int cut_peel,
  int length,
  int zero,
  int pause,
)>('A_Set_Syssetting');
// *******************************************************************************
// A_Set_Unit()
// ===============================================================================
// PURPOSE   Setup measurement unit (metric or inches).
// SYNTAX
//   VC:
//     int A_Set_Unit(char unit);
//   VB: VBA:
//     Declare Function A_Set_Unit(ByVal unit As Byte) As Long
//   VB.net:
//     Declare Function A_Set_Unit(ByVal unit As Byte) As Integer
// PARAMETER
//     unit;
//       The value of unit as follows:
//       +------+---------------------------+
//       | unit | REMARK                    |
//       +------+---------------------------+
//       |  m   | Set measurement in metric |
//       +------+---------------------------+
//       |  n   | Set measurement in inches |
//       +------+---------------------------+
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//   VC:
//     A_Set_Unit('n');
//   VB: VBA: VB.net:
//     Call A_Set_Unit(Asc("n"))
// REMARK  The A_Set_Unit function is used to set measurement in metric or inches.
// typedef int   (_stdcall *pfnA_Set_Unit)(char unit);
final A_Set_Unit = _dll.lookupFunction<Int64 Function(Pointer<Utf8> unit),
    int Function(Pointer<Utf8> unit)>('A_Set_Unit');
// *******************************************************************************
// A_Set_Gap()
// ===============================================================================
// PURPOSE   Setup the gap length.
// SYNTAX
//   VC:
//     int A_Set_Gap(int gap);
//   VB: VBA:
//     Declare Function A_Set_Gap(ByVal gap As Long) As Long
//   VB.net:
//     Declare Function A_Set_Gap(ByVal gap As Integer) As Integer
// PARAMETER
//     gap;
//       Range: 0 ~ 36 mm.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//   VC:
//     A_Set_Gap(0);
//   VB: VBA: VB.net:
//     Call A_Set_Gap(0)
// REMARK  The A_Set_Gap function is used to set the distance of gap.
// typedef int   (_stdcall *pfnA_Set_Gap)(int gap);
final A_Set_Gap =
    _dll.lookupFunction<Int64 Function(Int64 gap), int Function(int gap)>(
        'A_Set_Gap');
// *******************************************************************************
// A_Set_Logic()
// ===============================================================================
// PURPOSE   Set logic image printing mode.
// SYNTAX
//   VC:
//     int A_Set_Logic(int Logic);
//   VB: VBA:
//     Declare Function A_Set_Logic(ByVal Logic As Long) As Long
//   VB.net:
//     Declare Function A_Set_Logic(ByVal Logic As Integer) As Integer
// PARAMETER
//     Logic;
//       0:Printer default.
//       1:Logical XOR.
//       2:Logical OR.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//   VC:
//     A_Set_Logic(1);
//   VB: VBA: VB.net:
//     Call A_Set_Logic(1)
// REMARK  The A_Set_Logic function is used to set logic image printing mode.
// typedef int   (_stdcall *pfnA_Set_Logic)(int logic);
final A_Set_Logic =
    _dll.lookupFunction<Int64 Function(Int64 logic), int Function(int logic)>(
        'A_Set_Logic');
// *******************************************************************************
// A_Set_ProcessDlg()
// ===============================================================================
// PURPOSE   Enable or disable printing task transmission process bar.
// SYNTAX
//   VC:
//     int A_Set_ProcessDlg(int nShow);
//   VB: VBA:
//     Declare Function A_Set_ProcessDlg(ByVal nShow As Long) As Long
//   VB.net:
//     Declare Function A_Set_ProcessDlg(ByVal nShow As Integer) As Integer
// PARAMETER
//     nShow;
//       0 -> disable;
//       1 -> enable.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//   VC:
//     A_Set_ProcessDlg(1);
//   VB: VBA: VB.net:
//     Call A_Set_ProcessDlg(1)
// REMARK  The A_Set_ProcessDlg function is used to disable or enable the Process
//     bar Dialog.
// typedef int   (_stdcall *pfnA_Set_ProcessDlg)(int nShow);
final A_Set_ProgressDlg =
    _dll.lookupFunction<Int64 Function(Int64 nShow), int Function(int nShow)>(
        'A_Set_ProccessDlg');
// *******************************************************************************
// A_Set_ErrorDlg()
// ===============================================================================
// PURPOSE   Enable or disable retry inquiry dialog when transmitting fail.
// SYNTAX
//   VC:
//     int A_Set_ErrorDlg(int nShow);
//   VB: VBA:
//     Declare Function A_Set_ErrorDlg(ByVal nShow As Long) As Long
//   VB.net:
//     Declare Function A_Set_ErrorDlg(ByVal nShow As Integer) As Integer
// PARAMETER
//     nShow;
//       0 -> disable.
//       1 -> enable.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//   VC:
//     A_Set_ErrorDlg(1);
//   VB: VBA: VB.net:
//     Call A_Set_ErrorDlg(1)
// REMARK  The A_Set_ErrorDlg function is used to disable or enable retry inquiry
//     dialog when transmitting fail.
// typedef int   (_stdcall *pfnA_Set_ErrorDlg)(int nShow);
final A_Set_ErrorDlg =
    _dll.lookupFunction<Int64 Function(Int64 nShow), int Function(int nShow)>(
        'A_Set_ErrorDlg');
// *******************************************************************************
// A_Set_LabelVer()
// ===============================================================================
// PURPOSE   Set the Vertical Center. (For R400)
// PARAMETER
//     centiInch;
//       Label Width; unit : 0.01 Inch.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//     A_Set_LabelVer(400);
// REMARK  The A_Set_LabelVer function is used to set the Vertical Center for
//     R400.
// typedef int   (_stdcall *pfnA_Set_LabelVer)(int centiInch);
final A_Set_LabelVer = _dll.lookupFunction<Int64 Function(Int64 centiInch),
    int Function(int centiInch)>('A_Set_LabelVer');
// *******************************************************************************
// A_Clear_MemoryEx()
// ===============================================================================
// PURPOSE   Clear resident memory - RAM or Flash memory.
// PARAMETER
//     nMode;
//       0 --> Printer Default
//       1 --> RAM
//       2 --> Flash
// EXAMPLE
//     A_Clear_MemoryEx(1);
// REMARK  The A_Clear_MemoryEx function will clear all the graphics and soft fonts
//     which stored in the printers memory(RAM or flash memory). Normally
//     this function is sent before the A_Print_Out(). Otherwise the graphics
//     and fonts will be accumulated, and cause memory overflow. When "memory
//     full" occurs, the printer will erase the first-in graphics or fonts.
//     To avoid memory full and save processing time, you may send this
//     function before the A_Print_Out().
// typedef void  (_stdcall *pfnA_Clear_MemoryEx)(int nMode);
final A_Clear_MemoryEx =
    _dll.lookupFunction<Void Function(Int64 nMode), void Function(int nMode)>(
        'A_Clear_MemoryEx');
// *******************************************************************************
// A_GetUSBBufferLen()
// A_EnumUSB()
// ===============================================================================
// PURPOSE   To retrieve the device name and data length of USB Printer.
// PARAMETER
//     buf;
//       Stores USB Printer data.
// RETURN
//     A_GetUSBBufferLen();  returns the length of USB Printer data.
//     A_EnumUSB();  0 -> OK.
//     Reference AW-Error.txt file.
// Example
//   VC:
//     char *pbuf;
//     int nLen = A_GetUSBBufferLen() + 1;
//     if (nLen > 1) {
//       pbuf = (char *)new char[nLen];
//       A_EnumUSB(pbuf);
//     }
//   VB: VBA:
//     Dim nLen As Long
//     Dim pbuf As String
//     nLen = A_GetUSBBufferLen() + 1
//     If nLen > 1 Then
//       pbuf = Space(128)
//       Call A_EnumUSB(pbuf)
//     End If
//   VB.net:
//     Dim nLen As Integer
//     Dim pbuf(128) As Byte
//     nLen = A_GetUSBBufferLen() + 1
//     If nLen > 1 Then
//       Call A_EnumUSB(pbuf)
//     End If
// REMARK  These two functions are designed to be used together. First, use
//     A_GetUSBBufferLen() to retrieve the data length of the USB port. Then,
//     allocate memory to A_EnumUSB() to store the USB port data. The data from
//     USB port is split by ("0x0d0x0a"). For example, if the data is
//     A-200(0x0d)(0x0a)R-400ZIP, then USB1 is connected to A-200 and USB2 is
//     connected to R-400Zip.
// typedef int   (_stdcall *pfnA_GetUSBBufferLen)(void);
final A_GetUSBBufferLen =
    _dll.lookupFunction<Int64 Function(), int Function()>('A_GetUSBBufferLen');
// typedef int   (_stdcall *pfnA_EnumUSB)(char *buf);
final A_EnumUSB = _dll.lookupFunction<Int64 Function(Pointer<Utf8> buf),
    int Function(Pointer<Utf8> buf)>('A_EnumUSB');
// *******************************************************************************
// A_CreateUSBPort()
// A_CreateNetPort()
// ===============================================================================
// PURPOSE   Start PPLA Library opreation.
//         Before using A_CreateUSBPort(), to call A_GetUSBBufferLen() first,
//         This is for with A_EnumUSB() and A_GetUSBDeviceInfo() synchronization.
//         Before using A_CreateNetPort(), to call A_GetNetPrinterBufferLen() first,
//         This is for with A_EnumNetPrinter() synchronization.
// SYNTAX
//     int A_CreateUSBPort(int nPort);
//     int A_CreateNetPort(int nPort);
// PARAMETER
//     nPort;
//       USB and LAN port, the nPort count from 1.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//     int nLen;
//     nLen = A_GetUSBBufferLen();
//     if (nLen) {
//       A_CreateUSBPort(1);
//     }
//     nLen = A_GetNetPrinterBufferLen();
//     if (nLen) {
//       A_CreateNetPort(1);
//     }
// REMARK  The A_CreateUSBPort() and A_CreateNetPort() function
//     will activate a valid printer port or "print to file" path. This
//     function must be performed before all commands.
//     A_CreatePrn(), A_CreateUSBPort(), A_CreateNetPort() and A_CreatePort()
//     must use one of it at once.
// typedef int   (_stdcall *pfnA_CreateUSBPort)(int nPort);
final A_CreateUSBPort =
    _dll.lookupFunction<Int64 Function(Int64 nPort), int Function(int nPort)>(
        'A_CreateUSBPort');
// typedef int   (_stdcall *pfnA_CreateNetPort)(int nPort);
final A_CreateNetPort =
    _dll.lookupFunction<Int64 Function(Int64 nPort), int Function(int nPort)>(
        'A_CreateNetPort');
// *******************************************************************************
// A_CreatePort()
// ===============================================================================
// PURPOSE   Start PPLA Library opreation.
// SYNTAX
//     int A_CreatePort(int nPortType, int nPort, String filename);
// PARAMETER
//     nPortType;
//       To select port type.
//       0 -> file.
//       1 -> Serial port.
//       2 -> Parallel prot
//       4 -> USB port
//       5 -> LAN port
//       6 -> USB port
//     nPort;
//       To select the printer port number.
//       If nPortType is 1, 1 -> com1, 2 -> com2, ......
//     filename;
//       When nPortType is 0, path of file.
//       When nPortType is 4, index of USB (count from 1).
//       When nPortType is 5, IP address (TCP/IP port: 9100).
//       When nPortType is 6, device path of USB.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//     A_CreatePort(1, 1, NULL);
//     A_CreatePort(0, 0, "C:\\out.prn");
//     A_CreatePort(5, 0, "192.168.1.3");
// REMARK  The A_CreatePort() function will activate a valid printer port or
//     "print to file" path. This function must be performed before all commands.
//     A_CreatePrn(), A_CreateUSBPort(), A_CreateNetPort() and A_CreatePort()
//     must use one of it at once.
// typedef int   (_stdcall *pfnA_CreatePort)(int nPortType, int nPort, LPCTSTR filename);
final A_CreatePort = _dll.lookupFunction<
    Int64 Function(
  Int64 nPortType,
  Int64 nPort,
  Pointer<Utf8> filename,
),
    int Function(
  int nPortType,
  int nPort,
  Pointer<Utf8> filename,
)>('A_CreatePort');
// *******************************************************************************
// A_Set_Mirror()
// ===============================================================================
// PURPOSE   Open or close mirror mode.
// SYNTAX
//     void A_Set_Mirror(void);
// EXAMPLE
//     A_Set_Mirror();
// REMARK  The A_Set_Mirror function can start mirror mode and the printing functions
//     following it will print text, barcodes, or pictures reversely. Mirror
//     mode will be closed if A_Set_Mirror function is called again in the
//     same program and the printing function following the second one will be
//     printed normally. It can be called repeatedly in one program to decide
//     which printing functions use mirror mode.
// typedef void  (_stdcall *pfnA_Set_Mirror)(void);
final A_Set_Mirror =
    _dll.lookupFunction<Void Function(), void Function()>('A_Set_Mirror');
// *******************************************************************************
// A_Bar2d_RSS()
// ===============================================================================
// PURPOSE   Create the 2D barcode object - RSS.
// SYNTAX
//     int A_Bar2d_RSS(int x, int y, int ori, int ratio, int height, char rtype,
//       int mult, int seg, LPCTSTR data1, LPCTSTR data2);
// PARAMETER
//     x;
//       X coordinate.(100 = 1 inch)
//     y;
//       Y coordinate.(100 = 1 inch)
//     ori;
//       Orientation or print direction. 1:0�X�B2:90�X�B3:180�X�B4:270�X
//     ratio;
//       Bar narrow and width ratio. Value: 1~9 (Default value: 2)
//     height;
//       Barcode height.
//       The standard minimum height multiplier(default value):
//       RSS-14                      -> 33 pixels
//       RSS Limited                 -> 10 pixels
//       RSS Stacked                 -> 13 pixels
//       RSS Truncated               -> 13 pixels
//       RSS Stacked Omnidirectional -> 69 pixels
//       RSS Expanded                -> 34 pixels
//     rtype;
//       RSS type.
//       R -> RSS-14
//       L -> RSS Limited
//       S -> RSS Stacked
//       T -> RSS Truncated
//       D -> RSS Stacked Omnidirectional
//       E -> RSS Expanded
//     mult;
//       Pixel multiplier. Value: 1~9 (Default value: 1)
//     seg;
//       Segments per row. Only work in RSS Expanded.
//       Values: 2~22(even only); Default value: 22
//     data1;
//       Numeric data.
//     data2;
//       2D data.
//     PS:
//       1.'height' = 0 => actual barcode height = 'default' * 'ratio' * 'mult'
//         'height' = other value => actual barcode height = 'height'
//       2. The unit of barcode height is set by the ��<STX>n�� or ��STX>m�� command.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//     A_Bar2d_RSS(100, 100, 1, 2, 33, 'R', 1, 4, "1234567890", "RSS code");
// REMARK  The A_Bar2d_RSS function is used to print RSS barcode.
// typedef int   (_stdcall *pfnA_Bar2d_RSS)(int x, int y, int ori, int ratio, int height, char rtype,
// 						 int mult, int seg, LPCTSTR data1, LPCTSTR data2);
final A_Bar2d_RSS = _dll.lookupFunction<
    Int64 Function(
  Int64 x,
  Int64 y,
  Int64 ori,
  Int64 ratio,
  Int64 height,
  Pointer<Utf8> rtype,
  Int64 mult,
  Int64 seg,
  Pointer<Utf8> data1,
  Pointer<Utf8> data2,
),
    int Function(
  int x,
  int y,
  int ori,
  int ratio,
  int height,
  Pointer<Utf8> rtype,
  int mult,
  int seg,
  Pointer<Utf8> data1,
  Pointer<Utf8> data2,
)>('A_Bar2d_RSS');
// *******************************************************************************
// A_Bar2d_QR_M()
// A_Bar2d_QR_A()
// ===============================================================================
// PURPOSE   Create the 2D barcode object - QR code.
// SYNTAX
//     int A_Bar2d_QR_M(int x, int y, int ori, char mult, int value, int model,
//       char error, int mask, char dinput, char mode, int numeric, LPCTSTR data);
//     int A_Bar2d_QR_A(int x, int y, int ori, char mult, int value, char mode,
//       int numeric, LPCTSTR data);
// PARAMETER
//     x;
//       X coordinate.
//     y;
//       Y coordinate.
//     ori;
//       Orientation or print direction. 1:0�X�B2:90�X�B3:180�X�B4:270�X
//     mult;
//       Horizontal and vertical multiplier for module size. Value: 1~9, A~Z, a~z
//     value;
//       Value:000~999
//     mode;
//       Add function as follows:
//       +----+-------------------------------------+
//       |mode|           REMARK                    |
//       +----+-------------------------------------+
//       | A  |Make auto increment for numeric.     |
//       +----+-------------------------------------+
//       | B  |Make auto increment for alphanumeric.|
//       +----+-------------------------------------+
//       | C  |Make auto decrement for numeric.     |
//       +----+-------------------------------------+
//       | D  |Make auto decrement for alphanumeric.|
//       +----+-------------------------------------+
//       | N  |Disable.                             |
//       +----+-------------------------------------+
//     numeric;
//       Automaticall increment or decrement the filed value. Value: 0 ~ 99
//     data;
//       data string
//       Manual format only:(If the values of varibles is error, printer will print in default values.)
//     model;
//       QR Code model number. Values: 1,2 (Default value: 2)
//     error;
//       Error correction level.(effective when "dinput" is set correctly)
//       H = Ultra reliability level (30%)
//       Q = High reliability level (25%)
//       M = Standard reliability level (15%)
//       L = High density level (7%)
//       (Default value: M)
//     mask;
//       Mask number.(effective when "error" and "dinput" are set correctly)
//       0~7 = Mask 0~Mask 7
//       8 = No mask
//       (Default value: Automatic selection)
//     dinput;
//       Data input mode.(effective when "error" is set correctly)
//       A = Automatic setting, ASCII
//       a = Automatic, hex-ASCII
//       M = Manual setting, ASCII
//       m = Manual, hex-ASCII
//       (Default value: A)
//       NOTE:In manual mode, the initial of data string must be the following value.
//       N = Numeric data
//       A = Alphanumeric data
//       Bxxxx = For 8-bit byte mode. "xxxx" indicates the number of characters.
//               (A Simple or Traditional Chinese word is 2 characters)
//       K=Kanji data
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//     A_Bar2d_QR_M(100, 100, 4, '6', 10, 2, 'M', 1, 'A', 'A', 4, "N123456");
//     A_Bar2d_QR_A(100, 100, 4, '6', 10, 'A', 4, "123456");
// REMARK  The A_Bar2d_QR_M and A_Bar2d_QR_A function are used to print QR barcode.
// typedef int   (_stdcall *pfnA_Bar2d_QR_M)(int x, int y, int ori, char mult, int value, int model,
// 						 char error, int mask, char dinput, char mode, int numeric, LPCTSTR data);
final A_Bar2d_QR_M = _dll.lookupFunction<
    Int64 Function(
  Int64 x,
  Int64 y,
  Int64 ori,
  Pointer<Utf8> mult,
  Int64 value,
  Int64 model,
  Pointer<Utf8> error,
  Int64 mask,
  Pointer<Utf8> dinput,
  Pointer<Utf8> mode,
  Int64 numeric,
  Pointer<Utf8> data,
),
    int Function(
  int x,
  int y,
  int ori,
  Pointer<Utf8> mult,
  int value,
  int model,
  Pointer<Utf8> error,
  int mask,
  Pointer<Utf8> dinput,
  Pointer<Utf8> mode,
  int numeric,
  Pointer<Utf8> data,
)>('A_Bar2d_QR_M');
// typedef int   (_stdcall *pfnA_Bar2d_QR_A)(int x, int y, int ori, char mult, int value, char mode,
// 						 int numeric, LPCTSTR data);
final A_Bar2d_QR_A = _dll.lookupFunction<
    Int64 Function(
  Int64 x,
  Int64 y,
  Int64 ori,
  Pointer<Utf8> mult,
  Int64 value,
  Pointer<Utf8> mode,
  Int64 numeric,
  Pointer<Utf8> data,
),
    int Function(
  int x,
  int y,
  int ori,
  Pointer<Utf8> mult,
  int value,
  Pointer<Utf8> mode,
  int numeric,
  Pointer<Utf8> data,
)>('A_Bar2d_QR_A');
// *******************************************************************************
// A_GetNetPrinterBufferLen()
// A_EnumNetPrinter()
// ===============================================================================
// PURPOSE   To retrieve the device name and length of Net Printer..
// SYNTAX
//     int A_GetNetPrinterBufferLen(void);
//     int A_EnumNetPrinter(String buf);
// PARAMETER
//     buf;
//       Stores USB Printer data.
// RETURN
//     A_GetNetPrinterBufferLen();  returns the length of USB data.
//     A_EnumNetPrinter();  0 -> OK.
//     Reference AW-Error.txt file.
// Example
//     char *pbuf;
//     int nLen = A_GetNetPrinterBufferLen() + 1;
//     if (nLen > 1) {
//       pbuf = (char *)new char[nLen];
//       A_EnumNetPrinter(pbuf);
//     }
// REMARK  These two functions are designed to be used together. First, call
//     A_GetNetPrinterBufferLen() to retrieve the data length of Net Printer.
//     Then, allocate memory to A_EnumNetPrinter() to store Net Printer data.
//     The data from Net Printer is split by ("0x0d0x0a"). For example, if the data is
//     NetPrinter:192.168.1.2(0x0d)(0x0a)NetPrinter:192.168.1.25, then
//     NetPrinter1 is connected to NetPrinter:192.168.1.2 and
//     NetPrinter2 is connected to NetPrinter:192.168.1.25.
// typedef int   (_stdcall *pfnA_GetNetPrinterBufferLen)(void);
final A_GetNetPrinterBufferLen =
    _dll.lookupFunction<Int64 Function(), int Function()>(
        'A_GetNetPrinterBufferLen');
// typedef int   (_stdcall *pfnA_EnumNetPrinter)(char *buf);
final A_EnumNetPrinter = _dll.lookupFunction<Int64 Function(Pointer<Utf8> buf),
    int Function(Pointer<Utf8> buf)>('A_EnumNetPrinter');
// *******************************************************************************
// A_GetUSBDeviceInfo()
// ===============================================================================
// PURPOSE   To retrieve the device name and device path of USB Printer.
// SYNTAX
//     int A_GetUSBDeviceInfo(int nPort, char *pDeviceName, int *pDeviceNameLen,
//       char *pDevicePath, int *pDevicePathLen);
// PARAMETER�G
//     nPort;
//       Specifies the USB printer from which data is to be retrieved; begins with 1.
//     pDeviceName;
//       Name of USB printer device; if the input is a null pointer, no data will be written.
//     pDeviceNameLen;
//       When calling this function it is necessary to supply the length of temporary
//       storage of pDeviceName; when used as an output parameter it returns
//       the length of the device name.
//     pDevicePath;
//       Name of USB printer device; if the input is a null pointer, no data will be written.
//     pDevicePathLen;
//       When calling this function it is necessary to supply the length of temporary
//       storage of pDevicePath; when used as an output parameter it returns
//       the length of the device name.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// Example
//     char buf1[128]={0}, buf2[128]={0};
//     int nLen1=128, nLen2=128, nlen;
//     nlen = A_GetUSBBufferLen() + 1;
//     if (nlen > 1) {
//       A_GetUSBDeviceInfo(1, buf1, &nLen1, buf2, &nLen2);
//       A_CreatePrn(12, buf2); //or A_CreatePort(6, 0, buf2);
//     }
// REMARK  This function first calls A_GetUSBBufferLen() to obtain the data length
//     of the USB printer. Then A_GetUSBDeviceInfo() is called to retrieve relevant
//     information about the USB printer.
//     The data stored in pDevicePath is the path of the USB device and can be used
//     in A_CreatePrn() and A_CreatePort() to create the USB device.
// typedef int   (_stdcall *pfnA_GetUSBDeviceInfo)(int nPort, char *pDeviceName, int *pDeviceNameLen,
// 						 char *pDevicePath, int *pDevicePathLen);
final A_GetUSBDeviceInfo = _dll.lookupFunction<
    Int64 Function(
  Int64 nPort,
  Pointer<Utf8> pDeviceName,
  Int64 pDeviceNameLen,
  Pointer<Utf8> pDevicePath,
  Int64 pDevicePathLen,
),
    int Function(
  int nPort,
  Pointer<Utf8> pDeviceName,
  int pDeviceNameLen,
  Pointer<Utf8> pDevicePath,
  int pDevicePathLen,
)>('A_GetUSBDeviceInfo');
// *******************************************************************************
// A_Set_EncryptionKey()
// ===============================================================================
// Function: Set the encryption key.
// Syntax:
//     int A_Set_EncryptionKey(char encryptionKey[16]);
// Parameters:
//     encryptionKey;
//       The encryption key, the key needs 16 chars and the range from 0x21 to 0x7E.
// RETURN:
//     0 -> OK.
//     Reference AW-Error.txt file.
// Example:
//     A_Set_EncryptionKey("key-123456789000");
// REMARK  This function is used to set the encryption key value, and send data immediate,
//     and store in printer.
// typedef int   (_stdcall *pfnA_Set_EncryptionKey)(char encryptionKey[16]);
final A_Set_EncryptationKey = _dll.lookupFunction<
    Int64 Function(Pointer<Utf8> encryptionKey),
    int Function(Pointer<Utf8> encryptionKey)>('A_Set_EncryptationKey');
// *******************************************************************************
// A_Check_EncryptionKey()
// ===============================================================================
// Function�G  Check the encryption key correctness.
// Syntax�G
//     int A_Check_EncryptionKey(char decodeKey[8], char encryptionKey[16], DWORD dwTimeoutms);
// Parameters�G
//     decodeKey;
//       The decode key, the key needs 8 chars and the range from 0x21 to 0x7E.
//     encryptionKey;
//       The encryption key, the key needs 16 chars and the range from 0x21 to 0x7E.
//     dwTimeoutms;
//       This is timeout time. The max times to receive data, unit is ms.
// RETURN�G
//     0 -> OK.
//     Reference AW-Error.txt file.
// Example�G
//     int ret;
//     ret = A_Check_EncryptionKey("test-par", "key-123456789000", 1000);//1 second.
// REMARK  This function is used to check the encryption key correctness. After send
//     the decodeKey string to printer, and calculate with the encryption key in printer
//     then return the result. Then to compare with that calculate with the decodeKey and
//     encryptionKey string is the same.
// typedef int   (_stdcall *pfnA_Check_EncryptionKey)(char decodeKey[8], char encryptionKey[16],
// 						 DWORD dwTimeoutms);
final A_Check_EncryptationKey = _dll.lookupFunction<
    Int64 Function(Pointer<Utf8> decodekey, Pointer<Utf8> encryptationKey,
        Int32 dwTimeoutms),
    int Function(Pointer<Utf8> decodekey, Pointer<Utf8> encryptationKey,
        int dwTimeoutms)>('A_Check_EncryptationKey');
// *******************************************************************************
// A_Set_CommTimeout()
// ===============================================================================
// PURPOSE   Set communication time.
// SYNTAX
//     void A_Set_CommTimeout(int ReadTotalTimeoutConstant, int WriteTotalTimeoutConstant);
// PARAMETER
//     ReadTotalTimeoutConstant;
//       read timeout; unit : 1 ms. -1 is infinite.
//     WriteTotalTimeoutConstant;
//       write timeout; unit : 1 ms. -1 is infinite.
// EXAMPLE
//     A_Set_CommTimeout(0, -1);
//     A_CreatePrn(11, NULL); //USB
// REMARK  The fuction of A_Set_CommTimeout is to setting read/write timeout.
//     If you want to use this command, this command should be set before A_CreatePrn() executed.
// typedef void  (_stdcall *pfnA_Set_CommTimeout)(int ReadTotalTimeoutConstant, int WriteTotalTimeoutConstant);
final A_Set_CommTimeout = _dll.lookupFunction<
    Void Function(
        Int32 readTotalTimeoutConstant, Int32 writeTotalTimeoutConstant),
    void Function(int readTotalTimeoutConstant,
        int writeTotalTimeoutConstant)>('A_Set_CommTimeout');
// *******************************************************************************
// A_Get_CommTimeout()
// ===============================================================================
// PURPOSE   Get communication time.
// SYNTAX
//     void A_Get_CommTimeout(int *ReadTotalTimeoutConstant, int *WriteTotalTimeoutConstant);
// PARAMETER
//     ReadTotalTimeoutConstant;
//       read timeout; unit : 1 ms. -1 is infinite.
//     WriteTotalTimeoutConstant;
//       write timeout; unit : 1 ms. -1 is infinite.
// EXAMPLE
//     int ReadTotalTimeoutConstant, WriteTotalTimeoutConstant;
//     A_Get_CommTimeout(&ReadTotalTimeoutConstant, &WriteTotalTimeoutConstant);
// typedef void  (_stdcall *pfnA_Get_CommTimeout)(int *ReadTotalTimeoutConstant, int *WriteTotalTimeoutConstant);
final A_Get_CommTimeout = _dll.lookupFunction<
    Void Function(
        Int32 readTotalTimeoutConstant, Int32 writeTotalTimeoutConstant),
    void Function(int readTotalTimeoutConstant,
        int writeTotalTimeoutConstant)>('A_Get_CommTimeout');
// *******************************************************************************
// A_Set_LabelForSmartPrint()
// ===============================================================================
// PURPOSE   Set the information needed for Smart Print.
// SYNTAX
//     int A_Set_LabelForSmartPrint(int lablength, int gaplength);
// PARAMETER
//     lablength;
//       Label length. Unit : 0.1 mm.
//     gaplength;
//       Gap length. Unit : 0.1 mm.
// RETURN
//     0 -> OK.
//     Reference AW-Error.txt file.
// EXAMPLE
//     A_Set_LabelForSmartPrint(762, 30);
// REMARK  This A_Set_LabelForSmartPrint function is used to set
//     the label length and GAP length information required for Smart Print.
// typedef void  (_stdcall *pfnA_Set_LabelForSmartPrint)(int lablength, int gaplength);
final A_Set_LabelForSmartPrint = _dll.lookupFunction<
    Void Function(Int64 lablength, Int64 gaplength),
    void Function(int lablength, int gaplength)>('A_Set_LabelFormSmartPrint');
