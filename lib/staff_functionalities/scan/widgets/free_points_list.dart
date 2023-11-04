import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_functionalities/models/assignable_points.dart';
import '../../../common_functionalities/widgets/app_card.dart';
import '../../../i18n/strings.g.dart';
import '../../assignment/assignment_page.dart';
import '../state/scan_cubit.dart';

class FreePointsList extends StatelessWidget {
  const FreePointsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ScanCubit, ScanState, List<AssignablePoints>>(
      selector: (state) => state is ScanLoaded ? state.points : [],
      builder: (context, points) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.point_assignment.free_points.label,
              style: GoogleFonts.jetBrainsMono(fontSize: Theme.of(context).textTheme.titleMedium?.fontSize),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              children: points.map(_ItemWidget.new).toList(),
            ),
          ],
        );
      },
    );
  }
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget(this.item, {super.key});

  final AssignablePoints item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        AssignmentPage.routeName,
        arguments: AssignmentPageArgs.points(item.points),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: AppCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.points.toString(),
                style: GoogleFonts.jetBrainsMono(
                  fontSize: Theme.of(context).textTheme.displaySmall?.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(item.description[LocaleSettings.currentLocale.languageCode] ?? ' - '),
            ],
          ),
        ),
      ),
    );
  }
}
