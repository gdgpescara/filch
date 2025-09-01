import 'package:flutter/cupertino.dart';
import 'package:i18n/i18n.dart';

import '../../ui.dart';

class LoaderAnimation extends StatelessWidget {
  const LoaderAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: t.common.semantics.loading,
      child: CupertinoActivityIndicator(color: context.colorScheme.primary),
    );
  }
}
