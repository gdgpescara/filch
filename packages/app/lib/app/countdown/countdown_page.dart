import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import 'widgets/delorean_clock.dart';

class CountdownPage extends StatelessWidget {
  const CountdownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(Spacing.xl),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DeloreanClock(
                color: const Color(0xFFDB4437),
                date: DateTime(2024, 11, 8, 9),
                label: t.devfest2024.delorean_clock.destination_time,
              ),
              const Gap.vertical(Spacing.xl),
              StreamBuilder(
                stream: Stream<void>.periodic(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  return DeloreanClock(
                    color: const Color(0xFF0F9D58),
                    date: DateTime.now(),
                    label: t.devfest2024.delorean_clock.present_time,
                  );
                },
              ),
              const Gap.vertical(Spacing.xl),
              DeloreanClock(
                color: const Color(0xFFF4B400),
                date: DateTime(2023, 11, 19, 14),
                label: t.devfest2024.delorean_clock.last_time_departed,
              ),
              const Gap.vertical(Spacing.xxl),
              const Logo(),
            ],
          ),
        ),
      ),
    );
  }
}
