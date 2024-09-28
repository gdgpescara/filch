import 'dart:math';

import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

class SortingLoading extends StatelessWidget {
  const SortingLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: Stream.periodic(const Duration(seconds: 5), (_) => Random().nextInt(t.sorting_ceremony.loading.length)),
      builder: (context, snapshot) {
        final child = Text(
          t.sorting_ceremony.loading[snapshot.data ?? 0],
          style: context.textTheme.titleLarge,
          textAlign: TextAlign.center,
        );
        return Padding(
          padding: const EdgeInsets.all(24),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 2000),
            child: Center(key: ValueKey('${snapshot.data ?? 0}'), child: child),
          ),
        );
      },
    );
  }
}
