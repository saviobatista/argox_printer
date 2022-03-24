int A_Bar2d_Maxi (int x, int y, int primary, int secondary, int country,
						 int service, char mode, int numeric, char* data);
int A_Bar2d_Maxi_Ori (int x, int y, int ori, int primary, int secondary,
						 int country, int service, char mode, int numeric, char* data);
int A_Bar2d_PDF417 (int x, int y, int narrow, int width, char normal,
						 int security, int aspect, int row, int column, char mode, int numeric,
						 char* data);
int A_Bar2d_PDF417_Ori (int x, int y, int ori, int narrow, int width,
						 char normal, int security, int aspect, int row, int column, char mode,
						 int numeric, char* data);
int A_Bar2d_DataMatrix (int x, int y, int rotation, int hor_mul,
						 int ver_mul, int ECC, int data_format, int num_rows, int num_col,
						 char mode, int numeric, char* data);
void A_Clear_Memory (void);
void A_ClosePrn (void);
int A_CreatePrn (int selection, char* filename);
int A_Del_Graphic (int mem_mode, char graphic[10]);
int A_Draw_Box (char mode, int x, int y, int width, int height, int top,
						 int side);
int A_Draw_Line (char mode, int x, int y, int width, int height);
void A_Feed_Label (void);
char* A_Get_DLL_Version (int nShowMessage);
int A_Get_DLL_VersionA (int nShowMessage);
int A_Get_Graphic (int x, int y, int mem_mode, char format, char* filename);
int A_Get_Graphic_ColorBMP (int x, int y, int mem_mode, char format,
						 char* filename);
int A_Get_Graphic_ColorBMPEx (int x, int y, int nWidth, int nHeight,
						 int rotate, int mem_mode,char format, char* id_name, char* filename);
int A_Get_Graphic_ColorBMP_HBitmap (int x, int y, int nWidth, int nHeight,
						 int rotate, int mem_mode,char format, char* id_name, int hbm);
int A_Initial_Setting (int Type, char* Source);
int A_WriteData (int IsImmediate, char* pbuf, int length);
int A_ReadData (char* pbuf, int length, int dwTimeoutms);
int A_Load_Graphic (int x, int y, char graphic_name[10]);
int A_Open_ChineseFont (char* path);
int A_Print_Form (int width, int height, int copies, int amount,
						 char* form_name);
int A_Print_Out (int width, int height, int copies, int amount);
int A_Prn_Barcode (int x, int y, int ori, char type, int narrow, int width,
						 int height, char mode, int numeric, char* data);
int A_Prn_Text (int x, int y, int ori, int font, int type, int hor_factor,
						 int ver_factor, char mode, int numeric, char* data);
int A_Prn_Text_Chinese (int x, int y, int fonttype, char* id_name,
						 char* data, int mem_mode);
int A_Prn_Text_TrueType (int x, int y, int FSize, char* FType, int Fspin,
						 int FWeight, int FItalic, int FUnline, int FStrikeOut, char* id_name,
						 char* data, int mem_mode);
int A_Prn_Text_TrueType_W (int x, int y, int FHeight, int FWidth,
						 char* FType, int Fspin, int FWeight, int FItalic, int FUnline,
						 int FStrikeOut, char* id_name, char* data, int mem_mode);
int A_Set_Backfeed (int back);
int A_Set_BMPSave (int nSave, char* pstrBMPFName);
int A_Set_Cutting (int cutting);
int A_Set_Darkness (int heat);
int A_Set_DebugDialog (int nEnable);
int A_Set_Feed (char rate);
int A_Set_Form (char* formfile, char* form_name, int mem_mode);
int A_Set_Margin (int position, int margin);
int A_Set_Prncomport (int baud, int parity, int data, int stop);
int A_Set_Prncomport_PC (int nBaudRate, int nByteSize, int nParity,
						 int nStopBits, int nDsr, int nCts, int nXonXoff);
int A_Set_Sensor_Mode (char type, int continuous);
int A_Set_Speed (char speed);
int A_Set_Syssetting (int transfer, int cut_peel, int length, int zero,
						 int pause);
int A_Set_Unit (char unit);
int A_Set_Gap (int gap);
int A_Set_Logic (int logic);
int A_Set_ProcessDlg (int nShow);
int A_Set_ErrorDlg (int nShow);
int A_Set_LabelVer (int centiInch);
int A_GetUSBBufferLen (void);
int A_EnumUSB (char *buf);
int A_CreateUSBPort (int nPort);
int A_CreatePort (int nPortType, int nPort, char* filename);
void A_Clear_MemoryEx (int nMode);
void A_Set_Mirror (void);
int A_Bar2d_RSS (int x, int y, int ori, int ratio, int height, char rtype,
						 int mult, int seg, char* data1, char* data2);
int A_Bar2d_QR_M (int x, int y, int ori, char mult, int value, int model,
						 char error, int mask, char dinput, char mode, int numeric, char* data);
int A_Bar2d_QR_A (int x, int y, int ori, char mult, int value, char mode,
						 int numeric, char* data);
int A_GetNetPrinterBufferLen (void);
int A_EnumNetPrinter (char *buf);
int A_CreateNetPort (int nPort);
int A_Prn_Text_TrueType_Uni (int x, int y, int FSize, char* FType,
						 int Fspin, int FWeight, int FItalic, int FUnline, int FStrikeOut,
						 char* id_name, char* data, int format, int mem_mode);
int A_Prn_Text_TrueType_UniB (int x, int y, int FSize, char* FType, 
						 int Fspin, int FWeight, int FItalic, int FUnline, int FStrikeOut,
						 char* id_name, char* data, int format, int mem_mode);
int A_GetUSBDeviceInfo (int nPort, char *pDeviceName, int *pDeviceNameLen,
						 char *pDevicePath, int *pDevicePathLen);
int A_Set_EncryptionKey (char encryptionKey[16]);
int A_Check_EncryptionKey (char decodeKey[8], char encryptionKey[16], 
						 int dwTimeoutms);
void A_Set_CommTimeout (int ReadTotalTimeoutConstant, int WriteTotalTimeoutConstant);
void A_Get_CommTimeout (int *ReadTotalTimeoutConstant, int *WriteTotalTimeoutConstant);
void A_Set_LabelForSmartPrint (int lablength, int gaplength);