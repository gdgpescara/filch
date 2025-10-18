import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:mobile_scanner/mobile_scanner.dart';

import '../state/assignment_cubit.dart';

class ScannerWidget extends StatelessWidget {
  const ScannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.65,
      height: MediaQuery.sizeOf(context).width * 0.65,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
      child: MobileScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
          formats: [BarcodeFormat.qrCode],
        ),
        onDetect: (barcodes) {
          final scannedBarcodes = barcodes.barcodes.map((e) => e.rawValue).whereType<String>().toList();
          // if (scannedBarcodes.isNotEmpty) {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //       content: Text('QR code scanned correctly, you can continue to scan or proceed.'),
          //       duration: Duration(seconds: 2),
          //     ),
          //   );
          // }
          context.read<AssignmentCubit>().onQrCodesScanned(scannedBarcodes);
        },
      ),
    );
  }
}
