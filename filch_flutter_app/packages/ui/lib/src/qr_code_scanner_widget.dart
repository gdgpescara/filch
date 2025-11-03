import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../ui.dart';

class QrCodeScannerWidget extends StatelessWidget {
  const QrCodeScannerWidget({super.key, required this.onDetect});

  final ValueChanged<BarcodeCapture> onDetect;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.65,
      height: MediaQuery.sizeOf(context).width * 0.65,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(RadiusSize.m), color: Colors.white),
      child: MobileScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
          formats: [BarcodeFormat.qrCode],
        ),
        onDetect: onDetect,
      ),
    );
  }
}
