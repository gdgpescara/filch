import 'package:flutter/material.dart';

import '../../../i18n/strings.g.dart';

class SortingFailure extends StatelessWidget {
  const SortingFailure({super.key, required this.failure});

  final String failure;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        t.commons.errors.generic,
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.center,
      ),
    );
  }
}
