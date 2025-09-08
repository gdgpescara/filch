import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ui/ui.dart';

import '../../models/models.dart';

class SessionTags extends StatelessWidget {
  const SessionTags({
    super.key,
    required this.session,
  });

  final Session session;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: Spacing.xs,
      runSpacing: Spacing.xs,
      children: [
        if (session.language.name.isNotEmpty)
          AppChip(
            text: session.language.name,
            icon: FontAwesomeIcons.language,
            color: appColors.googleGreen,
          ),
        if (session.sessionFormat.name.isNotEmpty)
          AppChip(
            text: session.sessionFormat.name,
            icon: FontAwesomeIcons.box,
            color: appColors.googleBlue,
          ),
        if (session.level.name.isNotEmpty)
          AppChip(
            text: session.level.name,
            icon: FontAwesomeIcons.signal,
            color: appColors.googleRed,
          ),
        if (session.tags.isNotEmpty)
          ...session.tags.map((tag) {
            return AppChip(
              text: tag.name,
              color: appColors.googleYellow,
            );
          }),
      ],
    );
  }
}
