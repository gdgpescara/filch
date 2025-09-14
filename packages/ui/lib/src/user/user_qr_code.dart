import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../ui.dart';

class UserQrCode extends StatelessWidget {
  const UserQrCode({super.key, this.dimension = 200, this.user});

  final User? user;
  final double dimension;

  String get _buildData {
    if (user == null) {
      return '';
    }
    return jsonEncode({'uid': user!.uid, 'displayName': user!.displayName, 'email': user!.email});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: dimension + (dimension * 0.1),
      child: Stack(
        children: [
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: SvgPicture.asset('images/lines.svg', package: 'assets', excludeFromSemantics: true),
          // ),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox.square(
              dimension: dimension,
              child: QrImageView(
                data: _buildData,
                backgroundColor: context.colorScheme.surface,
                dataModuleStyle: QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.square,
                  color: context.colorScheme.onSurface,
                ),
                eyeStyle: QrEyeStyle(color: context.colorScheme.onSurface, eyeShape: QrEyeShape.square),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
