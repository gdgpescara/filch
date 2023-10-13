import 'package:flutter/material.dart';

class SortingCeremonyPage extends StatelessWidget {
  const SortingCeremonyPage({super.key});

  static const routeName = 'sorting_ceremony';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: const Scaffold(
        body: Center(
          child: Text('Sorting Ceremony'),
        ),
      ),
    );
  }
}
