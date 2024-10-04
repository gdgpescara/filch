import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:quests/quests.dart';
import 'package:ui/ui.dart';

import 'state/assignment_cubit.dart';
import 'widgets/assign_points_button.dart';
import 'widgets/scanned_items.dart';
import 'widgets/scanner_widget.dart';

class AssignmentPage extends StatelessWidget {
  const AssignmentPage({
    super.key,
    required this.args,
  });

  final AssignmentPageArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AssignmentCubit>(
      create: (context) => GetIt.I(),
      child: BlocListener<AssignmentCubit, AssignmentState>(
        listener: (context, state) {
          switch (state) {
            case Assigning():
              LoaderOverlay.show(context, message: t.staff.point_assignment.page.assigning);
              break;
            case AssignFailure():
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(t.staff.point_assignment.page.error),
                  backgroundColor: context.appColors.error.seed,
                ),
              );
              break;
            case Assigned():
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(t.staff.point_assignment.page.success),
                  backgroundColor: context.appColors.success.seed,
                ),
              );
              break;
            default:
              break;
          }
        },
        child: Background(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            extendBody: true,
            appBar: AppBar(
              title: Text(t.staff.point_assignment.page.title),
            ),
            body: const SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 24),
                  ScannerWidget(),
                  SizedBox(height: 20),
                  ScannedItems(),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(20),
              child: AssignPointsButton(args: args),
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class AssignmentPageArgs {
  const AssignmentPageArgs.points(this.points)
      : quest = null,
        type = PointsTypeEnum.staff;

  const AssignmentPageArgs.quest({this.quest, this.points}) : type = PointsTypeEnum.quest;

  final int? points;
  final String? quest;
  final PointsTypeEnum type;
}
