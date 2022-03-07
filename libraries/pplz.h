int	Z_Bar2d_Maxi(int x, int y, int nMode, int nSymbol, int nTotal,
						 int nClass, int nCountry, char* cZipCode1, char* cZipCode2,
						 char* data, int increase);
int	Z_Bar2d_PDF417(int x, int y, int o, int h, int s, int c, int r, int t,
						 int narrow, char* data, int increase);
int	Z_Bar2d_DataMatrix(int x, int y, int o, int h, int c, int r,
						 char* data, int increase);						 
void	Z_ClosePrn(void);
int	Z_CreatePrn(int selection, char* filename);
int	Z_Set_FlashMemory(int Status);
void	Z_Set_Format_New(char* FormatName);
int	Z_Del_Format(int memory, char* formatname);
int	Z_Del_Graphic(int memory, char* graphicname);
int	Z_Draw_Box(int x, int y, int width, int height, int thickness);
int	Z_Draw_Line(int x, int y, int width, int height);
char*	Z_Get_DLL_Version(int nShowMessage);
int	Z_Get_DLL_VersionA(int nShowMessage);
int	Z_Get_Graphic_ColorBMP(int x, int y, int mem_mode, char* filename);
int	Z_Get_Graphic_ColorBMPEx(int x, int y, int nWidth, int nHeight,
						 int rotate, int mem_mode, char* id_name, char* filename);
int	Z_Get_Graphic_ColorBMP_HBitmap(int x, int y, int nWidth, int nHeight,
						 int rotate, int mem_mode, char* id_name, char* hbm);
int	Z_Initial_Setting(int Type, char* Source);
int	Z_WriteData(int IsImmediate, char* pbuf, int len);
int	Z_ReadData(char* pbuf, int length, int dwTimeoutms);
int	Z_Load_Graphic(int x, int y, int memory, char* graphic_name,
						 int horizontal, int vertical);
int	Z_Open_ChineseFont(char* path);
int	Z_Print_Form(int copies, int labset, int mem_mode, char* form_out);
int	Z_Print_Out(int sets, int copies);
int	Z_Prn_Barcode(int x, int y, int ori, int narrow, int width, int height,
						 char type, int increase, char* data, char human1, char human2,
						 char human3, char human4, char human5);
int	Z_Prn_Text(int x, int y, int ori, char font, int height, int width,
						 int numeric, char* data);
int	Z_Prn_Text_Chinese(int x, int y, int fonttype, char* id_name,
						 char* data, int mem_mode);
int	Z_Prn_Text_TrueType(int x, int y, int FSize, char* FType, int Fspin,
						 int FWeight, int FItalic, int FUnline, int FStrikeOut, char* id_name,
						 char* data, int mem_mode);
int	Z_Prn_Text_TrueType_W(int x, int y, int FHeight, int FWidth,
						 char* FType, int Fspin, int FWeight, int FItalic, int FUnline,
						 int FStrikeOut, char* id_name, char* data, int mem_mode);
void	Z_Clear_Memory(void);
void	Z_Clear_MemoryEx(int nMode);
int	Z_Set_Backfeed(int nDistance);
int	Z_Set_Darkness(int darkness);
int	Z_Set_DebugDialog(int nEnable);
int	Z_Set_Label(int Length);
int	Z_Set_Mode(char mode);
int	Z_Set_Origin(int y);
int	Z_Set_Paper(char mode);
int	Z_Set_Prncomport(int baud, int parity, int data, int stop);
int	Z_Set_Prncomport_PC(int nBaudRate, int nByteSize, int nParity,
						 int nStopBits, int nDsr, int nCts, int nXonXoff);
void	Z_Set_Reset(void);
int	Z_Set_Speed(int print);
int	Z_Set_TPH(char mode);
int	Z_Set_Unit(char Unit);
int	Z_Set_Gap(int nPatern, int nGap);
int	Z_Set_ProcessDlg(int nShow);
int	Z_Set_ErrorDlg(int nShow);
int	Z_Bar2d_QRCode(int x, int y, int nModel, int nMagni, int nErr_Cor,
						 int nInput, char* data, int increase);
int	Z_Set_PrintWidth(int nDotwidth);
int	Z_Print_OutQuality(int nTotal, int sets, int copies, int nPause);
int	Z_GetUSBBufferLen(void);
int	Z_EnumUSB(char *buf);
int	Z_CreateUSBPort(int nPort);
int	Z_CreatePort(int nPortType, int nPort, char* filename);
int	Z_Set_Mirror(char direction);
int	Z_Bar2d_RSS(int x, int y, char ori, int rtype, int mag, int height,
						 int seg, char* data1, char* data2);
int	Z_GetNetPrinterBufferLen(void);
int	Z_EnumNetPrinter(char *buf);
int	Z_CreateNetPort(int nPort);
int	Z_Prn_Text_TrueType_Uni(int x, int y, int FSize, char* FType,
						 int Fspin, int FWeight, int FItalic, int FUnline, int FStrikeOut,
						 char* id_name, char* data, int format, int mem_mode);
int	Z_Prn_Text_TrueType_UniB(int x, int y, int FSize, char* FType,
						 int Fspin, int FWeight, int FItalic, int FUnline, int FStrikeOut,
						 char* id_name, char* data, int format, int mem_mode);
int	Z_GetUSBDeviceInfo(int nPort, char *pDeviceName, int *pDeviceNameLen, 
						 char *pDevicePath, int *pDevicePathLen);
int	Z_Set_EncryptionKey(char* encryptionKey);
int	Z_Check_EncryptionKey(char* decodeKey, char* encryptionKey, 
						 int dwTimeoutms);
void	Z_Set_CommTimeout(int ReadTotalTimeoutConstant, int WriteTotalTimeoutConstant);
void	Z_Get_CommTimeout(int *ReadTotalTimeoutConstant, int *WriteTotalTimeoutConstant);
void	Z_Set_LabelForSmartPrint(int lablength, int gaplength);