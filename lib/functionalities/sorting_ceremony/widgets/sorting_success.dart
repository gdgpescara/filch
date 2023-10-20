import 'package:flutter/material.dart';

import '../../../i18n/strings.g.dart';

class SortingSuccess extends StatelessWidget {
  const SortingSuccess({super.key, required this.house});

  final String house;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/houses/$house.png',
        height: 200,
        width: 200,
        semanticLabel: t.sorting_ceremony.assigned(house: house),
      ),
    );
  }
}
