import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../state/management_cubit.dart';

class ReportScheduleDelay extends StatelessWidget {
  const ReportScheduleDelay(this.navigateToScheduleDelayReporting, {super.key});

  final VoidCallback navigateToScheduleDelayReporting;

  Widget _buildDelayMessage(BuildContext context, int delay) {
    return Text.rich(
      TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(text: '${t.staff.schedule_delay.current_reported_delay.prefix} '),
          TextSpan(
            text: t.staff.schedule_delay.current_reported_delay.delay_unit(delay: delay),
            style: context
                .getTextTheme(TextThemeType.monospace)
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
          ),
          TextSpan(text: t.staff.schedule_delay.current_reported_delay.suffix),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ManagementCubit, ManagementState, int>(
      selector: (state) {
        return state is ManagementLoaded ? state.maxRoomDelay : 0;
      },
      builder: (context, roomDelay) {
        return AppCard(
          style: AppCardStyle.normal,
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.staff.schedule_delay.label,
                style: context.getTextTheme(TextThemeType.monospace).titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Gap.vertical(Spacing.m),

              if (roomDelay > 0)
                AppChip(
                  customColor: appColors.googleRed,
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
                  child: Expanded(
                    child: _buildDelayMessage(context, roomDelay),
                  ),
                ),

              if (roomDelay == 0)
                AppChip(
                  customColor: appColors.googleGreen,
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
                  child: Expanded(child: Text(t.staff.schedule_delay.no_reported_delay, textAlign: TextAlign.center)),
                ),
              const Gap.vertical(Spacing.m),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(onPressed: navigateToScheduleDelayReporting, child: Text(t.staff.schedule_delay.button.label)),
              ),
            ],
          ),
        );
      },
    );
  }
}
