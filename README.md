Flutter package throught FFI for using Argox Label Printer

## Features

- Complete integration with Argox Label Printers

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
const like = 'sample';
```

## Table of Error Codes

WINPPLA DLL Error Code List:
===============================================================================
1000 ->                              Print out failed.
2001 -> A_Bar2d_Maxi()               The argument is error.
2002 -> A_Bar2d_Maxi()               The data argument must be numeric.
2003 -> A_Bar2d_Maxi()               The data argument must be numeric.
2004 -> A_Bar2d_Maxi()               The argument is error.
2005 -> A_Bar2d_DataMatrix()         The argument is error.
2006 -> A_Bar2d_DataMatrix()         The data argument must be numeric.
2007 -> A_Bar2d_DataMatrix()         The argument is error.
2021 -> A_Bar2d_PDF417()             The argument is error.
2022 -> A_Bar2d_PDF417()             The argument is error.
2023 -> A_Bar2d_PDF417()             The argument is error.
2024 -> A_Bar2d_PDF417()             The data argument must be numeric.
2025 -> A_Bar2d_PDF417()             The data argument must be numeric.
2026 -> A_Bar2d_PDF417()             The argument is error.
2041 -> A_CreatePrn()                The argument is error.
2042 -> A_CreatePrn()                Memory allocation Fail.
        A_CreatePort()
2045 -> A_CreatePrn()                Memory allocation Fail.
        A_CreatePort()
2061 -> A_Del_Graphic()              The argument is error.
2081 -> A_Draw_Box()                 The argument is error.
2082 -> A_Draw_Box()                 The argument is error.
2101 -> A_Draw_Diagonal()            The argument is error.
2121 -> A_Draw_Ellipse()             The argument is error.
2141 -> A_Draw_Line()                The argument is error.
2142 -> A_Draw_Line()                The argument is error.
2161 -> A_Get_Graphic()              The argument is error.
2162 -> A_Get_Graphic()              File open failed.
2163 -> A_Get_Graphic()              The argument is error.
2164 -> A_Get_Graphic()              Memory allocation Fail.
2181 -> A_Get_Graphic_ColorBMP()     The argument is error.
        A_Get_Graphic_ColorBMPEx()
        A_Get_Graphic_ColorBMP_HBitmap()
2182 -> A_Get_Graphic_ColorBMP()     The argument is error.
        A_Get_Graphic_ColorBMPEx()
        A_Get_Graphic_ColorBMP_HBitmap()
2201 -> A_Get_Graphic_ColorBMP_Mem() The argument is error.
2202 -> A_Get_Graphic_ColorBMP_Mem() The argument is error.
2221 -> A_Initial_Setting()          The argument is error.
2222 -> A_Initial_Setting()          File open failed.
2223 -> A_Initial_Setting()          Memory allocation Fail.
2241 -> A_Load_Graphic()             The argument is error.
2261 -> A_Open_ChineseFont()         The argument is error.
2262 -> A_Open_ChineseFont()         STDFONT1.15 file open failed.
2263 -> A_Open_ChineseFont()         STDFONTS.15 file open failed.
2264 -> A_Open_ChineseFont()         SPCFONT.15 file open failed.
2265 -> A_Open_ChineseFont()         SPCFSUPP.15 file open failed.
2266 -> A_Open_ChineseFont()         STDFONT.24 file open failed.
2267 -> A_Open_ChineseFont()         SPCFONT.24 file open failed.
2268 -> A_Open_ChineseFont()         SPCFSUPP.24 file open failed.
2281 -> A_Print_Form()               The argument is error.
2282 -> A_Print_Form()               Two ',' of form_name argument cann't link together.
2301 -> A_Print_Out()                The argument is error.
2341 -> A_Prn_Barcode()              The argument is error.
2342 -> A_Prn_Barcode()              The data argument for UPC-A must be numeric.
2343 -> A_Prn_Barcode()              A string of Barcode UPC-A must be 11 characters in length.
2344 -> A_Prn_Barcode()              The data argument for UPC-E must be numeric.
2345 -> A_Prn_Barcode()              A string of Barcode UPC-E must be 6 characters in length.
2346 -> A_Prn_Barcode()              The data argument for I25 must be numeric.
2347 -> A_Prn_Barcode()              The data argument for EAN-13 must be numeric.
2348 -> A_Prn_Barcode()              A string of Barcode EAN-13 must be 12 characters in length.
2349 -> A_Prn_Barcode()              The data argument for EAN-8 must be numeric.
2350 -> A_Prn_Barcode()              A string of Barcode EAN-8 must be 7 characters in length.
2351 -> A_Prn_Barcode()              The data argument for I25 must be numeric.
2352 -> A_Prn_Barcode()              The data argument for PLESSEY must be numeric.
2353 -> A_Prn_Barcode()              A string of Barcode PLESSEY must be 14 characters in length.
2354 -> A_Prn_Barcode()              The data argument for I25 must be numeric.
2355 -> A_Prn_Barcode()              The data argument for UPC2 must be numeric.
2356 -> A_Prn_Barcode()              A string of Barcode UPC2 must be 2 characters in length.
2357 -> A_Prn_Barcode()              The data argument for UPC5 must be numeric.
2358 -> A_Prn_Barcode()              A string of Barcode UPC5 must be 5 characters in length.
2359 -> A_Prn_Barcode()              The data argument for POSTNET must be numeric.
2360 -> A_Prn_Barcode()              The data argument for UCC/EAN Code 128 must be numeric.
2361 -> A_Prn_Barcode()              A string of Barcode UCC/EAN Code 128 must be 19 characters in length.
2362 -> A_Prn_Barcode()              The data argument for UCC/EAN Code 128 K-MART must be numeric.
2363 -> A_Prn_Barcode()              A string of Barcode UCC/EAN Code 128 K-MART must be 18 characters in length.
2364 -> A_Prn_Barcode()              The data argument for UCC/EAN Code 128 Random weight must be numeric.
2365 -> A_Prn_Barcode()              The data argument for FIM must be numeric.
2366 -> A_Prn_Barcode()              A string of Barcode FIM must be 1 characters in length.
2367 -> A_Prn_Barcode()              The argument is error.
2368 -> A_Prn_Barcode()              The data argument must be numeric.
2369 -> A_Prn_Barcode()              The data argument must be numeric.
2370 -> A_Prn_Barcode()              The argument is error.
2381 -> A_Prn_Text()                 The argument is error.
2382 -> A_Prn_Text()                 The data argument must be numeric.
2383 -> A_Prn_Text()                 The data argument must be numeric.
2384 -> A_Prn_Text()                 The argument is error.
2385 -> A_Make_SoftFont()            The argument is error.
2401 -> A_Prn_Text_Chinese()         The argument is error.
2421 -> A_Prn_Text_TrueType()        The argument is error.
        A_Prn_Text_TrueType_W()
        A_Prn_Text_TrueType_Uni()
        A_Prn_Text_TrueType_UniB()
2441 -> A_Set_Backfeed()             The argument is error.
2461 -> A_Set_Cutting()              The argument is error.
2481 -> A_Set_Darkness()             The argument is error.
2501 -> A_Set_Feed()                 The argument is error.
2521 -> A_Set_Form()                 The argument is error.
2522 -> A_Set_Form()                 File open failed.
2523 -> A_Set_Form()                 Memory allocation Fail.
2541 -> A_Set_FlashMemory()          The argument is error.
2561 -> A_Set_Margin()               The argument is error.
2581 -> A_Set_Prncomport()           The argument is error.
2601 -> A_Set_Prncomport_PC()        The argument is error.
2621 -> A_Set_Sensor_Mode()          The argument is error.
2622 -> A_Set_Sensor_Mode()          The argument is error.
2641 -> A_Set_Speed()                The argument is error.
2661 -> A_Set_Syssetting()           The argument is error.
2662 -> A_Set_Syssetting()           The argument is error.
2663 -> A_Set_Syssetting()           The argument is error.
2664 -> A_Set_Syssetting()           The argument is error.
2665 -> A_Set_Syssetting()           The argument is error.
2670 -> A_Set_LabelVer()             The argument is error.
2681 -> A_Set_Unit()                 The argument is error.
2685 -> A_Set_DebugDialog()          The argument is error.
2687 -> A_Set_BMPSave()              The argument is error.
2689 -> A_Set_Logic                  The argument is error.
2690 -> A_Set_Gap()                  The argument is error.
2701 -> A_Bar2d_RSS()                The argument is error.
2721 -> A_Bar2d_QR_M()               The argument is error.
2722 -> A_Bar2d_QR_M()               The data argument must be numeric.
2723 -> A_Bar2d_QR_M()               The argument is error.
2731 -> A_Bar2d_QR_A()               The argument is error.
2732 -> A_Bar2d_QR_A()               The data argument must be numeric.
2733 -> A_Bar2d_QR_A()               The argument is error.
2740 -> A_WriteData()                The argument is error.
2741 -> A_Set_EncryptionKey()        The argument is error.
2742 -> A_Check_EncryptionKey()      The argument is error.
2743 -> A_Check_EncryptionKey()      Read data error.
2744 -> A_Check_EncryptionKey()      Check encryption key error.
2745 -> A_Set_LabelForSmartPrint()   The argument is error.

3000 -> The default printer DC is created failed.
3001 -> The printer DC is created failed.
3010 -> The font file is error.
3020 -> The argument is error.
3021 -> The argument is error.
3030 -> The argument is error.
3031 -> The brush object is created failed.
3032 -> The pen object is created failed.
3040 -> Error opening file.
3041 -> Error reading file.
3042 -> Not a recognised BMP format file.
3043 -> Memory allocation fail.
3044 -> Error reading file.
3045 -> OS/2 style BMPs Not Supported.
3046 -> Memory allocation fail.
3047 -> Error reading file.
3048 -> Error reading file.
3049 -> Error reading file.
3065 -> The DC object is created failed.
3070 -> Memory allocation fail.

4001 -> No USB Printer Connect.
4002 -> The USB port number is over connect USB port.
4003 -> No Net Printer Connect.
4004 -> The net port number is over connect net port.

WINPORT DLL Error Code List:
===============================================================================
101  -> The outport open failed.
102  -> Specify the outport is out of range.
103  -> The output dialog is created failed.
104  -> The serial port is not opened.
105  -> The outport is not opened.
106  -> The parallel port is opened failed.
107  -> The serial port is opened failed.
108  -> The Baud rate is out of range.
109  -> The data length is out of range.
110  -> The Parity bits is out of range.
111  -> The stop bits is out of range.
112  -> The serial port set to fail.
113  -> Cancel the file output.
114  -> Open the file failed.
116  -> Can not find the specified open the pipe name, Please reconfirm name.
117  -> Open the pipe failed.
118  -> The USB printer does not exist.
119  -> Specified USB outport can not be found.
120  -> Specified network address of the open failed.