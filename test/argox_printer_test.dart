import 'package:flutter_test/flutter_test.dart';
import 'package:argox_printer/argox_printer.dart';

void main() {
  test('All features test', () {
    // Expect DLL Version to be 4.11 as this used in development
    expect(aGetDllVersion(0), 411);
    // open port.
    int nLen, ret, sw;
    String ver, pbuf = '';
    String strmsg;
    // String szSavePath = '';
    String szSaveFile = 'printer.log';
    String sznop1 = "nop_front\r\n";
    String sznop2 = "nop_middle\r\n";

    // dll version.
    ver = aGetDllVersion(0);

    // search port.
    nLen = aGetUsbBufferLen() + 1;
    strmsg = 'DLL $ver';
    if (nLen > 1) {
      String buf1 = '', buf2 = '';
      int len1 = 128, len2 = 128;
      aEnumUsb(pbuf);
      aGetUsbDeviceInfo(1, buf1, len1, buf2, len2);
      sw = 1;
      if (sw == 1) {
        ret = aCreatePrn(12, buf2); // open usb.
      } else {
        ret =
            aCreateUsbPort(1); // must call A_GetUSBBufferLen() function fisrt.
      }
      if (0 != ret) {
        strmsg += "Open USB fail!";
      } else {
        strmsg += "Open USB:\r\nDevice name: ";
        strmsg += buf1;
        strmsg += "\r\nDevice path: ";
        strmsg += buf2;
        //sw = 2;
        if (2 == sw) {
          //get printer status.
          aWriteData(1, "\x01\x46\r\n", 4); //<SOH>F
          ret = aReadData(pbuf, 2, 1000);
        }
      }
    } else {
      //TODO: Mkdir
      ret = aCreatePrn(0, szSaveFile); // open file.
      strmsg += "Open ";
      strmsg += szSaveFile;
      if (0 != ret) {
        strmsg += " file fail!";
      } else {
        strmsg += " file succeed!";
      }
    }
    // print(strmsg);
    if (0 != ret) return;

    // sample setting.
    aSetDebugDialog(1);
    aSetUnit('n');
    aSetSysSetting(1, 0, 0, 0, 0);
    aSetDarkness(8);
    aDelGraphic(1, "*"); // delete all picture.
    aClearMemory(); // clear memory.
    aWriteData(0, sznop2, sznop2.length);
    aWriteData(1, sznop1, sznop1.length);
    //When using standard label, and the printer is Intelli Print mode or Smart Print mode,
    //When calling this function and giving the correct label information,
    //the immediate print function will be enabled according to the label length setting.
    aSetLabelForSmartPrint(
        254 * 3, 30); //label information: length= 3 * 25.4 mm, gap= 3 mm.

    //draw box.
    aDrawBox('A', 10, 10, 380, 280, 4, 4);
    aDrawLine('A', 200, 10, 4, 280);

    //print text, true type text.
    aPrnText(20, 30, 1, 2, 0, 1, 1, 'N', 2, "PPLA Lib Example");
    aPrnTextTrueType(20, 60, 30, "Arial", 1, 400, 0, 0, 0, "AA",
        "TrueType Font", 1); //save in ram.
    aPrnTextTrueTypeW(20, 90, 20, 20, "Times New Roman", 1, 400, 0, 0, 0, "AB",
        "TT_W: �h�r������", 1);
    aPrnTextTrueTypeUni(20, 120, 30, "Times New Roman", 1, 400, 0, 0, 0, "AC",
        "TT_Uni: �h�r������", 1, 1); //UTF-16
    pbuf = "\xFF\xFETT_UniB: �h�r������";
    aPrnTextTrueTypeUniB(20, 150, 30, "Times New Roman", 1, 400, 0, 0, 0, "AD",
        pbuf, 0, 1); //Byte Order Mark.

    //barcode.
    aPrnBarcode(220, 60, 1, 'A', 0, 0, 20, 'B', 1, "1234");
    aBar2dQrA(220, 100, 1, '3', 10, 'N', 0, "QR CODE");

    //picture.
    aGetGraphicColorBmp(220, 150, 1, 'B', "bb.bmp"); // Color bmp file to ram.
    aGetGraphicColorBmpEx(
        220, 170, 200, 150, 2, 1, 'B', "bb1", "bb.bmp"); //180 angle.
    //TODO: Discover and test how to deal with HBITMAP C++ data type
    //HANDLE himage = LoadImage(NULL,"bb.bmp",IMAGE_BITMAP,0,0,LR_LOADFROMFILE);
    //aGetGraphicColorBmpHBitmap(300, 150, 250, 80, 1, 1, 'B', "bb2", (HBITMAP)himage);//90 angle.
    // if (himage)
    //   DeleteObject(himage);

    // output.
    aPrintOut(1, 1, 2, 1); // copy 2.

    // close port.
    aClosePrn();
  });
}
