import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:ui/ui.dart';

import '../../../models/models.dart';
import '../../widgets/session_progress.dart';
import 'info_row.dart';

class SessionDetailInfo extends StatelessWidget {
  const SessionDetailInfo({
    super.key,
    required this.session,
  });

  final Session session;

  @override
  Widget build(BuildContext context) {
    final dateFormatter = GetIt.I<DateFormat>(instanceName: DateFormatType.onlyTime);
    final dayFormatter = GetIt.I<DateFormat>(instanceName: DateFormatType.onlyDate);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (session.room.name.isNotEmpty) ...[
          InfoRow(
            icon: FontAwesomeIcons.locationDot,
            label: 'Sala',
            value: session.room.name,
          ),
          const SizedBox(height: Spacing.s),
        ],
        InfoRow(
          icon: FontAwesomeIcons.calendar,
          label: 'Data',
          value: dayFormatter.format(session.startsAt),
        ),
        const SizedBox(height: Spacing.s),
        InfoRow(
          icon: FontAwesomeIcons.clock,
          label: 'Orario',
          value:
              '${dateFormatter.format(session.startsAt)} • ${dateFormatter.format(session.endsAt)} (${session.duration.inMinutes} min)',
        ),
        const SizedBox(height: Spacing.m),
        if (session.isCurrentlyRunning)
          SessionProgress(session: session)
        else
          AppChip(text: _statusLabel, color: _statusColor),
      ],
    );
  }

  String get _statusLabel {
    if (session.isUpcoming) {
      return 'inizierà tra ${session.startsAt.difference(DateTime.now()).inMinutes} min';
    }
    return 'Terminata';
  }

  CustomColor get _statusColor {
    if (session.isUpcoming) {
      return appColors.googleBlue;
    }
    return appColors.googleRed;
  }
}
