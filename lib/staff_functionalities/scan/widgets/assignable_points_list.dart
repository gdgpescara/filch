import 'package:flutter/material.dart';

import '../../../common_functionalities/models/assignable_points.dart';
import '../../../user_functionalities/quests/models/quest.dart';
import '../../assignment/assignment_page.dart';

class AssignablePointsList extends StatelessWidget {
  const AssignablePointsList({
    super.key,
    required this.points,
    required this.quests,
  });

  final List<AssignablePoints> points;
  final List<Quest> quests;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Selezione punti'),
        const SizedBox(height: 8),
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
                  arguments: AssignmentPageArgs.points(points[index].points),
                ),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
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
        ),
        const SizedBox(height: 24),
        const Text('Selezione quest'),
        const SizedBox(height: 8),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: quests.length,
            itemBuilder: (context, index) => SizedBox(
              width: 150,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(
                  AssignmentPage.routeName,
                  arguments: AssignmentPageArgs.quest(quests[index].id),
                ),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(quests[index].points.toString()),
                        Text(quests[index].description['it'] ?? ''),
                      ],
                    ),
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
