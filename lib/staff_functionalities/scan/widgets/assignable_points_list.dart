import 'package:flutter/material.dart';

import '../../../common_functionalities/models/assignable_points.dart';
import '../../assignment/assignment_page.dart';

class AssignablePointsList extends StatelessWidget {
  const AssignablePointsList({
    super.key,
    required this.points,
  });

  final List<AssignablePoints> points;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: points.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(points[index].points.toString()),
        subtitle: Text(points[index].description),
        onTap: () => Navigator.pushNamed(context, AssignmentPage.routeName),
      ),
    );
  }
}
