import 'package:flutter/material.dart';

import '../../../i18n/strings.g.dart';

class SortingSuccess extends StatelessWidget {
  const SortingSuccess({super.key, required this.house});

  final String house;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        t.sorting_ceremony.assigned(house: house),
        style: Theme.of(context).textTheme.displayLarge,
        textAlign: TextAlign.center,
      ),
    );
  }
}
