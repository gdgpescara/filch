import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../common_functionalities/user/use_cases/get_signed_user_use_case.dart';
import '../../../dependency_injection/dependency_injection.dart';

class UserQrCode extends StatelessWidget {
  const UserQrCode({super.key, this.dimension = 200});

  final double dimension;

  String get _buildData {
    final user = injector<GetSignedUserUseCase>()();
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
          color: Theme.of(context).colorScheme.onSurface,
        ),
        eyeStyle: QrEyeStyle(
          color: Theme.of(context).colorScheme.onSurface,
          eyeShape: QrEyeShape.square,
        ),
      ),
    );
  }
}
