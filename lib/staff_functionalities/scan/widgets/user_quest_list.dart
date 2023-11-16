import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_functionalities/widgets/app_card.dart';
import '../../../i18n/strings.g.dart';
import '../../../user_functionalities/quests/models/quest.dart';
import '../../assignment/assignment_page.dart';
import '../state/scan_cubit.dart';

class UserQuestList extends StatelessWidget {
  const UserQuestList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ScanCubit, ScanState, List<Quest>>(
      selector: (state) => state is ScanLoaded ? state.quests : [],
      builder: (context, quests) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.point_assignment.user_quests.label,
              style: GoogleFonts.jetBrainsMono(
                fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: quests.map(_ItemWidget.new).toList(),
            ),
          ],
        );
      },
    );
  }
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget(this.item, {super.key});

  final Quest item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        AssignmentPage.routeName,
        arguments: AssignmentPageArgs.quest(points: item.points, quest: item.id),
      ),
      child: AppCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.points.toString(),
              style: GoogleFonts.jetBrainsMono(fontSize: Theme.of(context).textTheme.displaySmall?.fontSize),
            ),
            Text(item.description[LocaleSettings.currentLocale.languageCode] ?? ' - '),
          ],
        ),
      ),
    );
  }
}
