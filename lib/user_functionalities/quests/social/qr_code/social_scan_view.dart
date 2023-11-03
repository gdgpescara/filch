import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../common_functionalities/use_cases/assign_points_use_case.dart';
import '../../../../common_functionalities/widgets/app_card.dart';
import '../../../../dependency_injection/dependency_injection.dart';
import '../../../../i18n/strings.g.dart';
import '../../commons/quest_description_widget.dart';
import '../../current_quest/state/current_quest_cubit.dart';
class SocialScanView extends StatelessWidget {
  const SocialScanView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentQuestCubit, CurrentQuestState>(
      buildWhen: (previous, current) => current is CurrentQuestLoaded,
      builder: (context, currentQuestState) {
        currentQuestState as CurrentQuestLoaded;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QuestDescriptionWidget(activeQuest: currentQuestState.activeQuest),
            const SizedBox(height: 20),
            AppCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _scanView(context, currentQuestState),
                  const SizedBox(height: 10),
                  Text(t.active_quest.quiz.hint),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _scanView(BuildContext context, CurrentQuestLoaded currentQuestState) {
    return SizedBox.square(
      dimension: 200,
      child: MobileScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
          formats: [BarcodeFormat.qrCode],
        ),
        startDelay: true,
        onDetect: (capture) {
          final barcodes = capture.barcodes;
          if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
            // injector<AssignPointsUseCase>()(
            //       points: currentQuestState.activeQuest.quest.points,
            //       barcodes.first.rawValue!,
            //     );
          }
        },
      ),
    );
  }
}
