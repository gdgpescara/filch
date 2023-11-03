import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_functionalities/user/use_cases/get_signed_user_use_case.dart';
import '../../../common_functionalities/widgets/app_card.dart';
import '../../../dependency_injection/dependency_injection.dart';
import '../../../i18n/strings.g.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.profile.user_info.name.label,
            textAlign: TextAlign.left,
            style: GoogleFonts.jetBrainsMono(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10, width: double.infinity),
          Text(
            injector<GetSignedUserUseCase>()()?.displayName ?? ' - ',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 20),
          Text(
            t.profile.user_info.email.label,
            textAlign: TextAlign.left,
            style: GoogleFonts.jetBrainsMono(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10, width: double.infinity),
          Text(
            injector<GetSignedUserUseCase>()()?.email ?? ' - ',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
