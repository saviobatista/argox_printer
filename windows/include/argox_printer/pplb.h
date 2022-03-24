int B_Bar2d_Maxi(int x, int y, int cl, int cc, int pc, char* data);
int B_Bar2d_PDF417(int x, int y, int w, int v, int s, int c, int px,
						 int py, int r, int l, int t, int o, char* data);
int B_Bar2d_PDF417_N(int x, int y, int w, int h, char* pParameter,
						 char* data);
int B_Bar2d_DataMatrix(int x, int y, int r, int l, int h, int v, char* data);
void B_ClosePrn(void);
int B_CreatePrn(int selection, char* filename);
int B_Del_Form(char formname[10]);
int B_Del_Pcx(char pcxname[10]);
int B_Draw_Box(int x, int y, int thickness, int hor_dots, int ver_dots);
int B_Draw_Line(char mode, int x, int y, int hor_dots, int ver_dots);
int B_Error_Reporting(char option);
char* B_Get_DLL_Version(int nShowMessage);
int B_Get_DLL_VersionA(int nShowMessage);
int B_Get_Graphic_ColorBMP(int x, int y, char* filename);
int B_Get_Graphic_ColorBMPEx(int x, int y, int nWidth, int nHeight, 
						 int rotate, char* id_name, char* filename);
int B_Get_Graphic_ColorBMP_HBitmap(int x, int y, int nWidth, int nHeight, 
						 int rotate, char* id_name, char* hbm);
int B_Get_Pcx(int x, int y, char* filename);
int B_Initial_Setting(int Type, char* Source);
int B_WriteData(int IsImmediate, char* pbuf, int length);
int B_ReadData(char* pbuf, int length, int dwTimeoutms);
int B_Load_Pcx(int x, int y, char pcxname[10]);
int B_Open_ChineseFont(char* path);
int B_Print_Form(int labset, int copies, char form_out[10], char* var);
int B_Print_MCopy(int labset, int copies);
int B_Print_Out(int labset);
int B_Prn_Barcode(int x, int y, int ori, char type[4], int narrow, 
						 int width, int height, char human, char* data);
void B_Prn_Configuration(void);
int B_Prn_Text(int x, int y, int ori, int font, int hor_factor,
						 int ver_factor, char mode, char* data);
int B_Prn_Text_Chinese(int x, int y, int fonttype, char* id_name,
						 char* data);
int B_Prn_Text_TrueType(int x, int y, int FSize, char* FType, int Fspin,
						 int FWeight, int FItalic, int FUnline, int FStrikeOut, char* id_name,
						 char* data);
int B_Prn_Text_TrueType_W(int x, int y, int FHeight, int FWidth,
						 char* FType, int Fspin, int FWeight, int FItalic, int FUnline,
						 int FStrikeOut, char* id_name, char* data);
int B_Select_Option(int object);
int B_Select_Option2(int object, int p);
int B_Select_Symbol(int num_bit, int symbol, int country);
int B_Select_Symbol2(int num_bit, char symbol[2], int country);
int B_Set_Backfeed(char option);
int B_Set_Backfeed_Offset(int offset);
int B_Set_CutPeel_Offset(int offset);
int B_Set_BMPSave(int nSave, char* pstrBMPFName);
int B_Set_Darkness(int darkness);
int B_Set_DebugDialog(int nEnable);
int B_Set_Direction(char direction);
int B_Set_Form(char* formfile);
int B_Set_Labgap(int lablength, int gaplength);
int B_Set_Labwidth(int labwidth);
int B_Set_Originpoint(int hor, int ver);
int B_Set_Prncomport(int baud, char parity, int data, int stop);
int B_Set_Prncomport_PC(int nBaudRate, int nByteSize, int nParity,
						 int nStopBits, int nDsr, int nCts, int nXonXoff);
int B_Set_Speed(int speed);
int B_Set_ProcessDlg(int nShow);
int B_Set_ErrorDlg(int nShow);
int B_GetUSBBufferLen(void);
int B_EnumUSB(char *buf);
int B_CreateUSBPort(int nPort);
int B_ResetPrinter(void);
int B_GetPrinterResponse(char *buf, int nMax);
int B_TFeedMode(int nMode);
int B_TFeedTest(void);
int B_CreatePort(int nPortType, int nPort, char* filename);
int B_Execute_Form(char form_out[10], char* var);
int B_Bar2d_QR(int x, int y, int model, int scl, char error, char dinput,
						 int c, int d, int p, char* data);
int B_GetNetPrinterBufferLen(void);
int B_EnumNetPrinter(char *buf);
int B_CreateNetPort(int nPort);
int B_Prn_Text_TrueType_Uni(int x, int y, int FSize, char* FType,
						 int Fspin, int FWeight, int FItalic, int FUnline, int FStrikeOut,
						 char* id_name, char* data, int format);
int B_Prn_Text_TrueType_UniB(int x, int y, int FSize, char* FType,
						 int Fspin, int FWeight, int FItalic, int FUnline, int FStrikeOut,
						 char* id_name, char* data, int format);										
int B_GetUSBDeviceInfo(int nPort, char *pDeviceName, int *pDeviceNameLen,
						 char *pDevicePath, int *pDevicePathLen);
int B_Set_EncryptionKey(char encryptionKey[16]);
int B_Check_EncryptionKey(char decodeKey[8], char encryptionKey[16], 
						 int dwTimeoutms);
void B_Set_CommTimeout(int ReadTotalTimeoutConstant, int WriteTotalTimeoutConstant);
void B_Get_CommTimeout(int *ReadTotalTimeoutConstant, int *WriteTotalTimeoutConstant);
void B_Set_LabelForSmartPrint(int lablength, int gaplength);