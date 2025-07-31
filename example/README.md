# 🖨️ Argox Printer Example

> 📱 **Interactive Flutter Demo for Argox Label Printers**
>
> A comprehensive example application demonstrating all the powerful features of the `argox_printer` plugin, from basic text printing to advanced barcode generation and real-world label creation.

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)](https://www.microsoft.com/windows)

## 🌟 What This Example Demonstrates

This example app showcases the complete capabilities of the Argox printer integration:

### ✨ **Core Features**
- 🔗 **Printer Connection Management** - USB, Serial, Network, and File output
- 📝 **Text Printing** - Built-in fonts, TrueType fonts, and text formatting
- 📊 **Barcode Generation** - 1D and 2D barcodes (QR, PDF417, DataMatrix, etc.)
- 🖼️ **Graphics & Drawing** - Images, boxes, lines, and custom graphics
- ⚙️ **Printer Configuration** - Darkness, speed, units, sensors, and more
- 🔍 **USB Discovery** - Automatic detection of connected Argox printers

### 🎯 **Real-World Examples**
- **Product Labels** with QR codes and pricing
- **Shipping Labels** with tracking barcodes
- **Serial Number Labels** with auto-increment
- **Asset Tags** with DataMatrix codes
- **Custom Forms** with mixed content

## 🚀 Quick Start

### Prerequisites

- **Windows 10/11** (32-bit or 64-bit)
- **Flutter 3.0+** installed
- **Argox printer** (physical or emulated)
- **Visual Studio 2019/2022** (for Windows development)

### Installation & Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/saviobatista/argox_printer.git
   cd argox_printer/example
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the example**:
   ```bash
   flutter run -d windows
   ```

## 🎮 How to Use the Example

### 🖥️ Application Interface

The example app provides an intuitive interface with several demonstration modes:

#### **🏠 Main Screen**
- **Print Button** - Execute a sample print job
- **Settings Panel** - Configure printer connection and settings
- **Examples Menu** - Access different printing scenarios

#### **📋 Available Print Examples**

| Example | Description | What You'll Learn |
|---------|-------------|-------------------|
| **Basic Text** | Simple text printing | Font selection, positioning, scaling |
| **Product Label** | Complete product label | QR codes, barcodes, layout design |
| **Shipping Label** | Professional shipping label | Address formatting, tracking codes |
| **Serial Numbers** | Batch serial number printing | Auto-increment, batch processing |
| **Graphics Demo** | Image and drawing showcase | BMP loading, boxes, lines |

### 🔧 Configuration Options

The example allows you to test different configurations:

```dart
// Connection Types
🔸 File Output (testing)    → Creates .log files
🔸 USB Connection          → Auto-detects USB printers  
🔸 Network Connection      → TCP/IP printers
🔸 Serial Connection       → COM port printers
```

## 📁 Project Structure

```
example/
├── 📱 lib/
│   ├── main.dart              # Main application entry point
│   ├── 🖨️ printer_service.dart  # Printer service abstraction
│   ├── 🎨 ui/
│   │   ├── home_screen.dart   # Main interface
│   │   ├── settings_page.dart # Configuration UI
│   │   └── examples_page.dart # Example gallery
│   ├── 📄 models/
│   │   ├── label_data.dart    # Label data structures
│   │   └── print_settings.dart # Printer settings
│   └── 🧰 utils/
│       ├── printer_helper.dart # Helper functions
│       └── constants.dart     # App constants
├── 📦 assets/
│   ├── images/               # Sample images for testing
│   └── fonts/               # Custom fonts (if any)
├── 🪟 windows/              # Windows-specific files
└── 📚 README.md             # This file
```

## 💻 Code Examples

### Basic Print Job

```dart
void printBasicLabel() async {
  final printer = ArgoxPPLA();
  
  try {
    // Connect to printer (file output for testing)
    printer.A_CreatePrn(0, 'basic_label.log');
    
    // Configure printer
    printer.A_Set_Unit('m');        // Metric units
    printer.A_Set_Darkness(12);     // Medium darkness
    printer.A_Clear_Memory();       // Clear printer memory
    
    // Print content
    printer.A_Prn_Text(10, 10, 1, 2, 0, 1, 1, 'N', 0, 'Hello Argox!');
    printer.A_Prn_Barcode(10, 40, 1, 'A', 2, 6, 30, 'N', 0, 'DEMO123');
    
    // Execute and close
    printer.A_Print_Out(1, 1, 1, 1);
    printer.A_ClosePrn();
    
    showSnackBar('✅ Print job completed successfully!');
    
  } catch (e) {
    showSnackBar('❌ Print failed: $e');
  }
}
```

### Product Label with QR Code

```dart
void printProductLabel(ProductData product) {
  final printer = ArgoxPPLA();
  
  try {
    printer.A_CreatePrn(0, 'product_${product.sku}.log');
    printer.A_Set_Unit('m');
    printer.A_Set_Darkness(14);
    printer.A_Clear_Memory();
    
    // Border
    printer.A_Draw_Box('N', 5, 5, 250, 120, 2, 2);
    
    // Product name (large font)
    printer.A_Prn_Text_TrueType(
      15, 15, 18, 'Arial', 1, 700, 0, 0, 0,
      'title', product.name, 1
    );
    
    // SKU barcode
    printer.A_Prn_Barcode(15, 45, 1, 'E', 2, 2, 25, 'N', 0, product.sku);
    printer.A_Prn_Text(15, 75, 1, 1, 0, 1, 1, 'N', 0, 'SKU: ${product.sku}');
    
    // Price
    printer.A_Prn_Text(15, 90, 1, 2, 0, 1, 1, 'N', 0, 
      'Price: \$${product.price.toStringAsFixed(2)}');
    
    // QR code with product info
    String qrData = 'Name: ${product.name}\n'
                   'SKU: ${product.sku}\n'
                   'Price: \$${product.price.toStringAsFixed(2)}';
    printer.A_Bar2d_QR_A(180, 45, 1, 3, 3, 'N', 0, qrData);
    
    printer.A_Print_Out(1, 1, 1, 1);
    printer.A_ClosePrn();
    
  } catch (e) {
    print('Product label failed: $e');
  }
}
```

### USB Printer Discovery

```dart
Future<List<String>> discoverUSBPrinters() async {
  final printer = ArgoxPPLA();
  List<String> printers = [];
  
  try {
    int bufferLen = printer.A_GetUSBBufferLen();
    
    if (bufferLen > 0) {
      String usbData = printer.A_EnumUSB();
      printers = usbData.split('\r\n').where((p) => p.isNotEmpty).toList();
      
      print('📱 Found ${printers.length} USB printer(s):');
      for (int i = 0; i < printers.length; i++) {
        print('  ${i + 1}. ${printers[i]}');
      }
    } else {
      print('🔍 No USB printers detected');
    }
  } catch (e) {
    print('❌ USB discovery failed: $e');
  }
  
  return printers;
}
```

## 🧪 Testing & Development

### Running Tests

```bash
# Run all tests
flutter test

# Run specific test files
flutter test test/printer_service_test.dart
```

### Debug Mode

The example includes comprehensive debugging features:

- **Print Preview** - See what will be printed before sending
- **Command Logging** - View all PPLA commands being sent
- **Error Details** - Detailed error messages with suggestions
- **Performance Metrics** - Print job timing information

### File Output Testing

When no physical printer is available:

```dart
// Enable file output mode
printer.A_CreatePrn(0, 'debug_output.log');

// The generated file will contain PPLA commands like:
// m
// qB  
// L
// D12
// 121100000100010Hello World
// >01
// ^01
// Q0001
// E
```

## 🛠️ Customization

### Adding New Examples

1. **Create a new example function**:
   ```dart
   void printCustomLabel() {
     // Your custom printing logic here
   }
   ```

2. **Add to the examples menu**:
   ```dart
   examples.add(PrintExample(
     title: 'Custom Label',
     description: 'Your custom label description',
     function: printCustomLabel,
     icon: Icons.custom_icon,
   ));
   ```

3. **Update the UI**:
   ```dart
   ListTile(
     leading: Icon(example.icon),
     title: Text(example.title),
     subtitle: Text(example.description),
     onTap: () => example.function(),
   )
   ```

### Configuration Options

The example supports various customization options:

```dart
class PrintSettings {
  int darkness = 12;        // Print darkness (0-20)
  String units = 'm';       // 'm' for metric, 'n' for inches
  String speed = 'E';       // Print speed (A-K)
  int copies = 1;           // Number of copies
  bool debugMode = false;   // Enable debug logging
  
  // Connection settings
  ConnectionType connectionType = ConnectionType.file;
  String? networkAddress;
  int? usbPort;
  String? serialPort;
}
```

## 📚 Learning Resources

### 🎓 **For Beginners**
- Start with the **Basic Text** example
- Read the inline code comments
- Experiment with different parameters

### 🔧 **For Developers**
- Study the **Product Label** implementation
- Check the **USB Discovery** code
- Review error handling patterns

### 🏢 **For Integration**
- Examine the **Service Architecture**
- Look at the **Settings Management**
- Study the **Error Recovery** mechanisms

## 🐛 Troubleshooting

### Common Issues

| Problem | Solution |
|---------|----------|
| 🔌 **No printer detected** | Check USB connection and drivers |
| 📄 **Print job fails** | Verify printer paper and ribbon |
| 🖥️ **App crashes** | Check DLL files in project folder |
| 🔗 **Connection timeout** | Try different connection type |
| 📱 **Build fails** | Ensure Windows development setup |

### Debug Commands

```dart
// Check DLL version
String version = printer.A_Get_DLL_Version(0);
print('DLL Version: $version');

// Test printer response
try {
  printer.A_CreatePrn(0, 'test.log');
  print('✅ Printer connection successful');
} catch (e) {
  print('❌ Connection failed: $e');
}
```

## 🤝 Contributing

We welcome contributions to improve this example! Here's how:

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/awesome-example`
3. **Add your example** with proper documentation
4. **Test thoroughly** on Windows
5. **Submit a pull request**

### Example Contribution Ideas

- 🏥 **Medical Label** example
- 📦 **Inventory Tag** example  
- 🎫 **Event Ticket** example
- 📋 **Asset Management** example
- 🏭 **Industrial Label** example

## 📞 Support & Resources

- 📖 **Full Documentation**: [DOCUMENTATION.md](../DOCUMENTATION.md)
- 🐛 **Report Issues**: [GitHub Issues](https://github.com/saviobatista/argox_printer/issues)
- 💬 **Ask Questions**: [GitHub Discussions](https://github.com/saviobatista/argox_printer/discussions)
- 📚 **Package Page**: [pub.dev/packages/argox_printer](https://pub.dev/packages/argox_printer)

---

**Made with ❤️ for the Flutter community**

*This example demonstrates the power and flexibility of the argox_printer plugin. Start with the basic examples and work your way up to complex, real-world implementations!*
