import 'package:flutter/material.dart';

import '../../../../i18n/strings.g.dart';

class ArchivedQuestsRetrieveError extends StatelessWidget {
  const ArchivedQuestsRetrieveError({super.key, required this.onTryAgain});

  final VoidCallback onTryAgain;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onTryAgain,
        child: Text(t.commons.buttons.try_again),
      ),
    );
  }
}
