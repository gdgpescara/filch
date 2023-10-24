import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../dependency_injection/dependency_injection.dart';
import '../../use_cases/get_signed_user_use_case.dart';

class UserQrCode extends StatelessWidget {
  const UserQrCode({super.key, this.dimension = 250});

  final double dimension;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension,
      child: QrImageView(
        data: injector<GetSignedUserUseCase>()()?.uid ?? '',
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
