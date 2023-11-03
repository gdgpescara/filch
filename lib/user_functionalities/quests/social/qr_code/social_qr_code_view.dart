import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slang/builder/utils/string_extensions.dart';

import '../../../../common_functionalities/widgets/app_card.dart';
import '../../../../common_functionalities/widgets/loader_animation.dart';
import '../../../../dependency_injection/dependency_injection.dart';
import '../../../../i18n/strings.g.dart';
import '../../../../theme/app_theme.dart';
import '../../current_quest/state/current_quest_cubit.dart';
import 'social_qr_code_scan.dart';
import 'state/social_qr_code_cubit.dart';

class SocialQrCodeView extends StatelessWidget {
  const SocialQrCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SocialQrCodeCubit>(
      create: (context) => injector(),
      child: BlocBuilder<CurrentQuestCubit, CurrentQuestState>(
        buildWhen: (previous, current) => current is CurrentQuestLoaded,
        builder: (context, currentQuestState) {
          currentQuestState as CurrentQuestLoaded;
          return BlocConsumer<SocialQrCodeCubit, SocialQrCodeState>(
            listener: (context, state) {
              switch (state) {
                case SocialQrCodeSaved():
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        state.isCorrect
                            ? t.active_quest.social.qr_code.correct(n: state.points, house: state.house.capitalize())
                            : t.active_quest.social.qr_code.incorrect(house: state.house.capitalize()),
                      ),
                      backgroundColor: state.isCorrect
                          ? Theme.of(context).extension<CustomColors>()?.success
                          : Theme.of(context).extension<CustomColors>()?.error,
                    ),
                  );
                  break;
                case SocialQrCodeFailure():
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(t.commons.errors.generic_retry),
                      backgroundColor: Theme.of(context).extension<CustomColors>()?.error,
                    ),
                  );
                  break;
                default:
                  break;
              }
            },
            builder: (context, state) {
              return AppCard(
                child: switch (state) {
                  SocialQrCodeLoading() => const LoaderAnimation(),
                  _ => SocialQrCodeScan(activeQuest: currentQuestState.activeQuest),
                },
              );
            },
          );
        },
      ),
    );
  }
}
