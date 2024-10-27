import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:quests/quests.dart';
import 'package:ui/ui.dart';

import '../community/take_picture_bottom_sheet.dart';
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
        listener: (context, state) async {
          switch (state) {
            case Assigning():
              LoaderOverlay.show(context, message: t.staff.point_assignment.page.assigning);
              break;
            case AssignFailure():
              LoaderOverlay.hide(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(t.staff.point_assignment.page.error),
                  backgroundColor: appColors.error.seed,
                ),
              );
              break;
            case Assigned():
              LoaderOverlay.hide(context);
              Navigator.pop(context);
              if (args.questType == QuestTypeEnum.community) {
                await showModalBottomSheet<void>(
                  context: context,
                  builder: (context) => const TakePictureBottomSheet(),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(t.staff.point_assignment.page.success),
                    backgroundColor: appColors.success.seed,
                  ),
                );
              }
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
                  SizedBox(height: Spacing.xl),
                  ScannerWidget(),
                  SizedBox(height: Spacing.l),
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
      : questId = null,
        questType = null,
        type = PointsTypeEnum.staff;

  const AssignmentPageArgs.quest({
    this.questId,
    required this.questType,
    required this.points,
  }) : type = PointsTypeEnum.quest;

  final int points;
  final String? questId;
  final QuestTypeEnum? questType;
  final PointsTypeEnum type;
}
