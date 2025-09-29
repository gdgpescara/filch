import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:intl/intl.dart';
import 'package:ui/ui.dart';

import '../../../models/models.dart';
import '../../widgets/session_progress.dart';
import 'info_row.dart';

class SessionDetailInfo extends StatelessWidget {
  const SessionDetailInfo({
    super.key,
    required this.session,
    required this.delay,
  });

  final Session session;
  final int delay;

  @override
  Widget build(BuildContext context) {
    final dateFormatter = GetIt.I<DateFormat>(instanceName: DateFormatType.onlyTime);
    final dayFormatter = GetIt.I<DateFormat>(instanceName: DateFormatType.onlyDate);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (session.room?.name.isNotEmpty ?? false) ...[
          InfoRow(
            icon: FontAwesomeIcons.locationDot,
            label: t.schedule.sessions.session_detail.room_label,
            value: session.room!.name,
          ),
          const Gap.vertical(Spacing.s),
        ],
        InfoRow(
          icon: FontAwesomeIcons.calendar,
          label: t.schedule.sessions.session_detail.date_label,
          value: dayFormatter.format(session.startsAt),
        ),
        const Gap.vertical(Spacing.s),
        InfoRow(
          icon: FontAwesomeIcons.clock,
          label: t.schedule.sessions.session_detail.time_label,
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${dateFormatter.format(session.startsAt)} • ${dateFormatter.format(session.endsAt)}',
                    style: context.textTheme.bodyMedium?.copyWith(
                      decoration: delay > 0 ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  if (delay > 0)
                    Text(
                      '${dateFormatter.format(session.realStartsAt)} • ${dateFormatter.format(session.realEndsAt)}',
                      style: context.textTheme.bodyMedium?.copyWith(color: appColors.googleRed.seed),
                    ),
                ],
              ),
              const SizedBox(width: Spacing.s),
              Text(
                t.schedule.sessions.session_detail.duration_minutes(minutes: session.duration.inMinutes),
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const Gap.vertical(Spacing.m),
        if (session.isCurrentlyRunning)
          SessionProgress(
            sessionDuration: session.duration,
            startsAt: session.startsAt,
            endsAt: session.endsAt,
          )
        else
          AppChip(text: _statusLabel(session.startsAt), customColor: _statusColor),
      ],
    );
  }

  String _statusLabel(DateTime startAt) {
    if (session.isUpcoming) {
      return t.schedule.sessions.session_detail.status_upcoming(minutes: startAt.difference(DateTime.now()).inMinutes);
    }
    return t.schedule.sessions.session_detail.status_ended;
  }

  CustomColor get _statusColor {
    if (session.isUpcoming) {
      return appColors.googleBlue;
    }
    return appColors.googleRed;
  }
}
