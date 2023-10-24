import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../_shared/widgets/app_card.dart';
import '../../../../_shared/widgets/loader_animation.dart';
import '../../state/current_quest_cubit.dart';
import 'state/quiz_cubit.dart';

class QuizScanView extends StatelessWidget {
  const QuizScanView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentQuestCubit, CurrentQuestState>(
      buildWhen: (previous, current) => current is CurrentQuestLoaded,
      builder: (context, currentQuestState) {
        currentQuestState as CurrentQuestLoaded;
        return BlocBuilder<QuizCubit, QuizState>(
          builder: (context, state) {
            final Widget child;
            if (state is QuizNeedActivation) {
              child = SizedBox.square(
                dimension: 250,
                child: MobileScanner(
                  controller: MobileScannerController(
                    detectionSpeed: DetectionSpeed.noDuplicates,
                    formats: [BarcodeFormat.qrCode],
                  ),
                  startDelay: true,
                  onDetect: (capture) {
                    final barcodes = capture.barcodes;
                    if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
                      context.read<QuizCubit>().activateQuiz(
                            currentQuestState.activeQuest.quest,
                            barcodes.first.rawValue!,
                          );
                    }
                  },
                ),
              );
            } else {
              child = const LoaderAnimation();
            }
            return AppCard(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 800),
                child: child,
              ),
            );
          },
        );
      },
    );
  }
}
