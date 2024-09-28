import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

class SortingFailure extends StatelessWidget {
  const SortingFailure({super.key, required this.failure});

  final String failure;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        t.common.errors.generic,
        style: context.textTheme.titleLarge,
        textAlign: TextAlign.center,
      ),
    );
  }
}
