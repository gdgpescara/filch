import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../models/active_quest.dart';
import 'state/social_qr_code_cubit.dart';

class SocialQrCodeScan extends StatelessWidget {
  const SocialQrCodeScan({super.key, required this.activeQuest});

  final ActiveQuest activeQuest;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 200,
      child: MobileScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
          formats: [BarcodeFormat.qrCode],
        ),
        onDetect: (capture) {
          final barcodes = capture.barcodes;
          if (barcodes.isNotEmpty &&
              barcodes.first.rawValue != null &&
              activeQuest.quest.verificationFunction != null) {
            context.read<SocialQrCodeCubit>().onScan(activeQuest, barcodes.first.rawValue!);
          }
        },
      ),
    );
  }
}
