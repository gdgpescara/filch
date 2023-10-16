import 'package:flutter/material.dart';

class SortingSuccess extends StatelessWidget {
  const SortingSuccess({super.key, required this.house});

  final String house;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('You are in $house'),
    );
  }
}
