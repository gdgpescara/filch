import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';


class LoaderAnimation extends StatelessWidget {
  const LoaderAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: t.common.semantics.loading,
      child: const CircularProgressIndicator(),
    );
  }
}
