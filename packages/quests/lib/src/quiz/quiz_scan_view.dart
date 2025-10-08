import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:ui/ui.dart';

import '../commons/active_quest/quest_description_widget.dart';
import '../current_quest/state/current_quest_cubit.dart';
import 'state/quiz_cubit.dart';

class QuizScanView extends StatelessWidget {
  const QuizScanView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentQuestCubit, CurrentQuestState>(
      buildWhen: (previous, current) => current is CurrentQuestLoaded,
      builder: (context, currentQuestState) {
        currentQuestState as CurrentQuestLoaded;
        if (currentQuestState.activeQuest.quest.qrCode == null) {
          context.read<QuizCubit>().setQuizActive();
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QuestDescriptionWidget(activeQuest: currentQuestState.activeQuest),
            const SizedBox(height: 20),
            AppCard(
              style: AppCardStyle.bordered,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _scanView(context, currentQuestState),
                  const SizedBox(height: 10),
                  Text(t.quests.active_quest.quiz.hint),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _scanView(BuildContext context, CurrentQuestLoaded currentQuestState) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(RadiusSize.m),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(RadiusSize.m),
        child: MobileScanner(
          controller: MobileScannerController(
            detectionSpeed: DetectionSpeed.noDuplicates,
            formats: [BarcodeFormat.qrCode],
          ),
          onDetect: (capture) {
            final barcodes = capture.barcodes;
            if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
              context.read<QuizCubit>().activateQuiz(currentQuestState.activeQuest.quest, barcodes.first.rawValue!);
            }
          },
        ),
      ),
    );
  }
}
