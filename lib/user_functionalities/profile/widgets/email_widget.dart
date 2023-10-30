import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_functionalities/user/use_cases/get_signed_user_use_case.dart';
import '../../../common_functionalities/widgets/app_card.dart';
import '../../../dependency_injection/dependency_injection.dart';

class EmailWidget extends StatelessWidget {
  const EmailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'email:',
            textAlign: TextAlign.left,
            style: GoogleFonts.jetBrainsMono(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10, width: double.infinity),
          Text(
            injector<GetSignedUserUseCase>()()?.email ?? '',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
