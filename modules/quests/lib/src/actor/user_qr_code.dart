import 'dart:convert';

import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ui/ui.dart';

class UserQrCode extends StatelessWidget {
  const UserQrCode({super.key, this.dimension = 200});

  final double dimension;

  String get _buildData {
    final user = GetIt.I<GetSignedUserUseCase>()();
    if (user == null) {
      return '';
    }
    return jsonEncode({
      'uid': user.uid,
      'displayName': user.displayName,
      'email': user.email,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension,
      child: QrImageView(
        data: _buildData,
        dataModuleStyle: QrDataModuleStyle(
          dataModuleShape: QrDataModuleShape.square,
          color: context.colorScheme.onSurface,
        ),
        eyeStyle: QrEyeStyle(
          color: context.colorScheme.onSurface,
          eyeShape: QrEyeShape.square,
        ),
      ),
    );
  }
}
