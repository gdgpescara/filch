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
    return AppCard(
      style: AppCardStyle.normal,
      child: QrImageView(
        data: _buildData,
        size: dimension,
        backgroundColor: context.colorScheme.surface,
        dataModuleStyle: QrDataModuleStyle(
          dataModuleShape: QrDataModuleShape.square,
          color: context.colorScheme.onSurface,
        ),
      ),
    );
  }
}
