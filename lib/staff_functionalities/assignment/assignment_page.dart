import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common_functionalities/models/points_type_enum.dart';
import '../../common_functionalities/widgets/dark_map_container.dart';
import '../../common_functionalities/widgets/loader_overlay.dart';
import '../../dependency_injection/dependency_injection.dart';
import '../../i18n/strings.g.dart';
import '../../theme/app_theme.dart';
import 'state/assignment_cubit.dart';
import 'widgets/assign_points_button.dart';
import 'widgets/scanned_items.dart';
import 'widgets/scanner_widget.dart';

class AssignmentPage extends StatelessWidget {
  const AssignmentPage({
    super.key,
    required this.args,
  });

  static const routeName = 'assignment';

  final AssignmentPageArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AssignmentCubit>(
      create: (context) => injector(),
      child: BlocListener<AssignmentCubit, AssignmentState>(
        listener: (context, state) {
          switch (state) {
            case Assigning():
              LoaderOverlay.show(context, message: t.point_assignment.page.assigning);
              break;
            case AssignFailure():
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(t.point_assignment.page.error),
                  backgroundColor: Theme.of(context).extension<CustomColors>()?.error,
                ),
              );
              break;
            case Assigned():
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(t.point_assignment.page.success),
                  backgroundColor: Theme.of(context).extension<CustomColors>()?.success,
                ),
              );
              break;
            default:
              break;
          }
        },
        child: DarkMapContainer(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            extendBody: true,
            appBar: AppBar(
              title: Text(t.point_assignment.page.title),
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
