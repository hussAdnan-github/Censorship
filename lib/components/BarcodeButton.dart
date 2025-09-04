import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class ScanBarcodeButton extends StatelessWidget {
  final void Function(String) onScanCompleted;

  const ScanBarcodeButton({super.key, required this.onScanCompleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          colors: [Color(0xFF1976D2), Color(0xFF42A5F5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        icon: const Icon(Icons.qr_code_scanner, size: 28, color: Colors.white),
        label: const Text(
          "مسح الباركود",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        onPressed: () async {
          // فتح صفحة المسح
          String scannedCode = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SimpleBarcodeScannerPage(),
            ),
          );

          if (scannedCode.isNotEmpty) {
            onScanCompleted(scannedCode);
          }
        },
      ),
    );
  }
}
