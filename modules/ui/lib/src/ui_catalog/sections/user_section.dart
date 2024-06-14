import 'package:flutter/material.dart';

import '../../../ui.dart';
import '../../user/user_picture.dart';

class UserSection extends StatelessWidget {
  const UserSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Heading(text: 'User Section'),
        Gap.vertical(Spacing.m),
        SubHeading(text: 'User picture'),
        Gap.vertical(Spacing.s),
        UserPicture(badgeName: 'dashclaw'),
      ],
    );
  }
}
