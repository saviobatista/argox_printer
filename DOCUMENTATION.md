# Argox Printer - Complete API Documentation

> 📚 **Comprehensive Flutter/Dart API Reference for Argox Label Printers**
> 
> This documentation covers all 100+ functions available in the PPLA driver for complete printer control.

## 📖 Table of Contents

- [🚀 Quick Start Guide](#-quick-start-guide)
- [🔗 Connection Management](#-connection-management)
- [📝 Text & Font Functions](#-text--font-functions)
- [📊 Barcode & 2D Code Functions](#-barcode--2d-code-functions)
- [🖼️ Graphics & Drawing Functions](#️-graphics--drawing-functions)
- [⚙️ Configuration Functions](#️-configuration-functions)
- [🔧 System & Utility Functions](#-system--utility-functions)
- [❌ Error Codes Reference](#-error-codes-reference)
- [💡 Common Use Cases](#-common-use-cases)

---

## 🚀 Quick Start Guide

### Basic Workflow

Every print job follows this basic pattern:

```dart
import 'package:argox_printer/argox_printer.dart';

final printer = ArgoxPPLA();

// 1. Connect to printer
printer.A_CreatePrn(0, 'output.log'); // File output for testing

// 2. Configure settings
printer.A_Set_Unit('m');              // Metric units
printer.A_Set_Darkness(12);           // Print darkness
printer.A_Clear_Memory();             // Clear printer memory

// 3. Add content (text, barcodes, graphics)
printer.A_Prn_Text(10, 10, 1, 2, 0, 1, 1, 'N', 0, 'Hello World');

// 4. Execute print job
printer.A_Print_Out(1, 1, 1, 1);     // Print 1 copy

// 5. Close connection
printer.A_ClosePrn();
```

### Function Categories Overview

| Category | Function Count | Purpose |
|----------|----------------|---------|
| **Connection** | 8 functions | Establish and manage printer connections |
| **Text/Fonts** | 6 functions | Print text with various fonts and styles |
| **Barcodes** | 10 functions | Generate 1D and 2D barcodes |
| **Graphics** | 12 functions | Handle images and drawing operations |
| **Configuration** | 25 functions | Configure printer settings and behavior |
| **System** | 15+ functions | System utilities and information |

---

## 🔗 Connection Management

### Core Connection Functions

#### `A_CreatePrn(selection, filename)`
**Purpose**: Initialize printer connection

**Parameters**:
- `selection` (int): Connection type
  - `0` = File output
  - `1-3` = LPT1-3 (parallel)
  - `4-6` = COM1-3 (serial)
  - `11` = USB by index
  - `12` = USB by device path
  - `13` = Network TCP/IP
- `filename` (String): Connection-specific parameter

**Dart Example**:
```dart
// File output (for testing)
printer.A_CreatePrn(0, 'test_output.log');

// USB connection
printer.A_CreatePrn(11, '1'); // First USB printer

// Network connection
printer.A_CreatePrn(13, '192.168.1.100'); // Default port 9100
printer.A_CreatePrn(13, '192.168.1.100:8080'); // Custom port
```

**Returns**: `0` on success, error code on failure

#### `A_CreateUSBPort(nPort)`
**Purpose**: Connect to USB printer by port number

**Dart Example**:
```dart
// Check for USB printers first
int bufferLen = printer.A_GetUSBBufferLen();
if (bufferLen > 0) {
  printer.A_CreateUSBPort(1); // Connect to first USB printer
}
```

#### `A_CreateNetPort(nPort)`
**Purpose**: Connect to network printer

**Dart Example**:
```dart
// Check for network printers first
int bufferLen = printer.A_GetNetPrinterBufferLen();
if (bufferLen > 0) {
  printer.A_CreateNetPort(1); // Connect to first network printer
}
```

#### `A_ClosePrn()`
**Purpose**: Close printer connection

**Dart Example**:
```dart
printer.A_ClosePrn(); // Always call this when done
```

### USB & Network Discovery

#### `A_EnumUSB()`
**Purpose**: Enumerate available USB printers

**Dart Example**:
```dart
try {
  int bufferLen = printer.A_GetUSBBufferLen();
  if (bufferLen > 0) {
    String usbPrinters = printer.A_EnumUSB();
    print('Available USB printers: $usbPrinters');
    // Output format: "A-200\r\nR-400ZIP" (separated by \r\n)
  }
} catch (e) {
  print('No USB printers found');
}
```

---

## 📝 Text & Font Functions

### Basic Text Printing

#### `A_Prn_Text(x, y, orientation, font, type, h_scale, v_scale, mode, numeric, data)`
**Purpose**: Print text using built-in fonts

**Parameters**:
- `x, y` (int): Position coordinates
- `orientation` (int): Rotation (1=0°, 2=90°, 3=180°, 4=270°)
- `font` (int): Font type (0-12)
- `type` (int): Font variant
- `h_scale, v_scale` (int): Scale factors (1-24)
- `mode` (String): Auto-increment mode ('A', 'B', 'C', 'D', 'M', 'N')
- `numeric` (int): Auto-increment value (0-99)
- `data` (String): Text to print

**Dart Example**:
```dart
// Simple text
printer.A_Prn_Text(10, 10, 1, 2, 0, 1, 1, 'N', 0, 'Product Name');

// Large rotated text
printer.A_Prn_Text(50, 50, 2, 4, 0, 2, 3, 'N', 0, 'URGENT');

// Auto-incrementing serial numbers
printer.A_Prn_Text(10, 100, 1, 1, 0, 1, 1, 'A', 1, '000001');
```

### Font Types & Sizes

| Font ID | Description | Sizes Available |
|---------|-------------|-----------------|
| 0-8 | Built-in bitmap fonts | Fixed size |
| 9 | ASD smooth fonts | 4pt, 6pt, 8pt, 10pt, 12pt, 14pt, 18pt |
| 11 | Courier fonts | Various symbol sets |
| 12 | Font board selection | Hardware dependent |

### Text Modes

| Mode | Description | Use Case |
|------|-------------|----------|
| 'N' | Normal | Static text |
| 'A' | Auto-increment numeric | Serial numbers |
| 'B' | Auto-increment alphanumeric | Batch codes |
| 'C' | Auto-decrement numeric | Countdown |
| 'D' | Auto-decrement alphanumeric | Reverse sequence |
| 'M' | Mirror mode | Mirrored text |

---

## 📊 Barcode & 2D Code Functions

### 1D Barcodes

#### `A_Prn_Barcode(x, y, orientation, type, narrow, wide, height, mode, numeric, data)`
**Purpose**: Generate 1D barcodes

**Common Barcode Types**:
- `'A'` = Code 39 (alphanumeric)
- `'E'` = Code 128 (full ASCII)
- `'B'` = UPC-A (12 digits)
- `'C'` = UPC-E (6 digits)
- `'F'` = EAN-13 (12+1 digits)
- `'G'` = EAN-8 (7+1 digits)

**Dart Example**:
```dart
// Code 39 barcode
printer.A_Prn_Barcode(10, 50, 1, 'A', 2, 6, 40, 'N', 0, 'ABC123');

// Code 128 barcode
printer.A_Prn_Barcode(10, 100, 1, 'E', 2, 2, 50, 'N', 0, 'Hello World');

// UPC-A barcode (requires 11 digits + check digit)
printer.A_Prn_Barcode(10, 150, 1, 'B', 2, 2, 60, 'N', 0, '12345678901');
```

### 2D Codes

#### `A_Bar2d_QR_A(x, y, orientation, multiplier, value, mode, numeric, data)`
**Purpose**: Generate QR codes (automatic format)

**Dart Example**:
```dart
// Simple QR code
printer.A_Bar2d_QR_A(100, 50, 1, 3, 3, 'N', 0, 'https://example.com');

// QR code with product info
String productInfo = 'Product: ABC\nSKU: 12345\nPrice: \$19.99';
printer.A_Bar2d_QR_A(150, 100, 1, 4, 3, 'N', 0, productInfo);
```

#### `A_Bar2d_PDF417(x, y, narrow, width, normal, security, aspect, row, column, mode, numeric, data)`
**Purpose**: Generate PDF417 2D barcodes

**Dart Example**:
```dart
// PDF417 with automatic sizing
printer.A_Bar2d_PDF417(50, 200, 2, 2, 'F', 0, 0, 0, 0, 'N', 0, 'PDF417 Data');
```

#### `A_Bar2d_DataMatrix(x, y, rotation, h_mult, v_mult, ecc, format, rows, cols, mode, numeric, data)`
**Purpose**: Generate DataMatrix codes

**Dart Example**:
```dart
// Standard DataMatrix
printer.A_Bar2d_DataMatrix(200, 50, 1, 4, 4, 200, 0, 16, 16, 'N', 0, 'DataMatrix');
```

---

## 🖼️ Graphics & Drawing Functions

### Image Functions

#### `A_Get_Graphic(x, y, memMode, format, filename)`
**Purpose**: Load and print image files

**Supported Formats**:
- `'B'` = BMP (flipped)
- `'b'` = BMP (normal)
- `'P'` = PCX (flipped)
- `'p'` = PCX (normal)

**Dart Example**:
```dart
// Load BMP image
printer.A_Get_Graphic(50, 50, 1, 'B', 'logo.bmp');
```

#### `A_Draw_Box(mode, x, y, width, height, top, side)`
**Purpose**: Draw rectangular boxes

**Dart Example**:
```dart
// Simple border box
printer.A_Draw_Box('N', 10, 10, 200, 100, 2, 2);
```

#### `A_Draw_Line(mode, x, y, width, height)`
**Purpose**: Draw lines

**Dart Example**:
```dart
// Horizontal line
printer.A_Draw_Line('N', 10, 50, 200, 2);
```

---

## ⚙️ Configuration Functions

### Print Settings

#### `A_Set_Darkness(heat)`
**Purpose**: Set print darkness/heating level

**Parameters**: `heat` (int): 0-20, default 10

**Dart Example**:
```dart
printer.A_Set_Darkness(15); // Higher for darker prints
```

#### `A_Set_Speed(speed)`
**Purpose**: Set print speed

**Speed Options**: 'A' (1.0 ips) to 'K' (6.0 ips)

**Dart Example**:
```dart
printer.A_Set_Speed('E'); // 3.0 ips
```

#### `A_Set_Unit(unit)`
**Purpose**: Set measurement units

**Dart Example**:
```dart
printer.A_Set_Unit('m'); // Metric
printer.A_Set_Unit('n'); // Inches
```

### Paper & Sensor Settings

#### `A_Set_Sensor_Mode(type, continuous)`
**Purpose**: Configure paper sensor

**Dart Example**:
```dart
// Gap sensor (default)
printer.A_Set_Sensor_Mode('e', 0);

// Black mark sensor
printer.A_Set_Sensor_Mode('r', 0);

// Continuous paper (300 = 3 inches)
printer.A_Set_Sensor_Mode('c', 300);
```

#### `A_Clear_Memory()`
**Purpose**: Clear printer's flash memory

**Dart Example**:
```dart
printer.A_Clear_Memory(); // Clear before each job
```

---

## 🔧 System & Utility Functions

### Version & Information

#### `A_Get_DLL_Version(showDialog)`
**Purpose**: Get DLL version string

**Dart Example**:
```dart
String version = printer.A_Get_DLL_Version(0); // No dialog
print('DLL Version: $version');
```

#### `A_Print_Out(width, height, copies, amount)`
**Purpose**: Execute the print job

**Parameters**:
- `width` (int): 1 or 2
- `height` (int): 1, 2, or 3
- `copies` (int): 1-9999
- `amount` (int): 1-99

**Dart Example**:
```dart
// Print 5 copies
printer.A_Print_Out(1, 1, 5, 1);
```

---

## ❌ Error Codes Reference

### Common Error Codes

| Code | Description | Solution |
|------|-------------|----------|
| 0 | Success | Operation completed successfully |
| 1000 | Print out failed | Check printer connection and status |
| 2041 | Memory allocation failed | Reduce data size or clear memory |
| 2301 | Invalid arguments | Check parameter values |
| 4001 | No USB printer connected | Verify USB connection |
| 4003 | No network printer connected | Check network settings |

### Error Handling Example

```dart
try {
  int result = printer.A_Print_Out(1, 1, 1, 1);
  if (result == 0) {
    print('Print successful');
  } else {
    print('Print failed with code: $result');
  }
} on ArgoxException catch (e) {
  print('Argox error: ${e.code} - $e');
} catch (e) {
  print('Unexpected error: $e');
}
```

---

## 💡 Common Use Cases

### Product Label with QR Code

```dart
void printProductLabel(String name, String sku, double price) {
  final printer = ArgoxPPLA();
  
  try {
    // Setup
    printer.A_CreatePrn(0, 'product_$sku.log');
    printer.A_Set_Unit('m');
    printer.A_Set_Darkness(12);
    printer.A_Clear_Memory();
    
    // Border
    printer.A_Draw_Box('N', 5, 5, 240, 150, 2, 2);
    
    // Title
    printer.A_Prn_Text(15, 15, 1, 3, 0, 2, 2, 'N', 0, name);
    
    // SKU barcode
    printer.A_Prn_Barcode(15, 50, 1, 'E', 2, 2, 30, 'N', 0, sku);
    printer.A_Prn_Text(15, 85, 1, 1, 0, 1, 1, 'N', 0, 'SKU: $sku');
    
    // Price
    printer.A_Prn_Text(15, 105, 1, 2, 0, 1, 1, 'N', 0, 
      'Price: \$${price.toStringAsFixed(2)}');
    
    // QR Code
    String qrData = 'Name: $name\nSKU: $sku\nPrice: \$${price.toStringAsFixed(2)}';
    printer.A_Bar2d_QR_A(160, 50, 1, 3, 3, 'N', 0, qrData);
    
    // Print
    printer.A_Print_Out(1, 1, 1, 1);
    printer.A_ClosePrn();
    
  } catch (e) {
    print('Failed to print product label: $e');
  }
}
```

### Batch Serial Number Labels

```dart
void printSerialLabels(String prefix, int startNum, int count) {
  final printer = ArgoxPPLA();
  
  try {
    printer.A_CreatePrn(0, 'serial_batch.log');
    printer.A_Set_Unit('m');
    printer.A_Set_Darkness(12);
    printer.A_Clear_Memory();
    
    // Use auto-increment for efficient batch printing
    String startSerial = '$prefix${startNum.toString().padLeft(6, '0')}';
    
    // Title
    printer.A_Prn_Text(10, 10, 1, 2, 0, 1, 1, 'N', 0, 'SERIAL NUMBER');
    
    // Auto-incrementing serial number
    printer.A_Prn_Text(10, 35, 1, 3, 0, 1, 1, 'A', 1, startSerial);
    
    // Barcode with auto-increment
    printer.A_Prn_Barcode(10, 65, 1, 'E', 2, 2, 30, 'A', 1, startSerial);
    
    // Print batch (will auto-increment for each label)
    printer.A_Print_Out(1, 1, count, 1);
    printer.A_ClosePrn();
    
    print('Printed $count serial labels starting from $startSerial');
    
  } catch (e) {
    print('Failed to print serial labels: $e');
  }
}
```

---

## 📞 Support & Resources

- **GitHub Repository**: [argox_printer](https://github.com/saviobatista/argox_printer)
- **Issues & Bug Reports**: [GitHub Issues](https://github.com/saviobatista/argox_printer/issues)
- **API Questions**: [GitHub Discussions](https://github.com/saviobatista/argox_printer/discussions)

---

*This documentation is continuously updated. For the most current information, please check the GitHub repository.*