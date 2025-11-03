import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../state/management_cubit.dart';

class ReportScheduleDelay extends StatelessWidget {
  const ReportScheduleDelay(this.navigateToScheduleDelayReporting, {super.key});

  final VoidCallback navigateToScheduleDelayReporting;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ManagementCubit, ManagementState, int>(
      selector: (state) {
        return state is ManagementLoaded ? state.maxRoomDelay : 0;
      },
      builder: (context, roomDelay) {
        return AppCard(
          style: AppCardStyle.normal,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.staff.schedule_delay.label,
                style: context.getTextTheme(TextThemeType.monospace).titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              if (roomDelay > 0) _buildDelayMessage(context, roomDelay),
              if (roomDelay == 0)
                Text(
                  t.staff.schedule_delay.no_reported_delay,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: appColors.googleGreen.seed,
                  ),
                ),
              const Gap.vertical(Spacing.m),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: navigateToScheduleDelayReporting,
                  child: Text(t.staff.schedule_delay.button.label),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDelayMessage(BuildContext context, int delay) {
    return Text.rich(
      TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(text: t.staff.schedule_delay.current_reported_delay.prefix),
          TextSpan(
            text: t.staff.schedule_delay.current_reported_delay.delay_unit(delay: delay),
            style: context
                .getTextTheme(TextThemeType.monospace)
                .bodyLarge
                ?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: appColors.googleRed.seed,
                  decoration: TextDecoration.underline,
                  decorationColor: appColors.googleRed.seed,
                ),
          ),
          TextSpan(text: t.staff.schedule_delay.current_reported_delay.suffix),
        ],
      ),
    );
  }
}
