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
    return ListView(
      children: [
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: points.length,
            itemBuilder: (context, index) => SizedBox(
              width: 150,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(
                  AssignmentPage.routeName,
                  arguments: points[index].points,
                ),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(points[index].points.toString()),
                      Text(points[index].description),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: points.length,
            itemBuilder: (context, index) => SizedBox(
              width: 150,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(
                  AssignmentPage.routeName,
                  arguments: points[index].points,
                ),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(points[index].points.toString()),
                      Text(points[index].description),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
