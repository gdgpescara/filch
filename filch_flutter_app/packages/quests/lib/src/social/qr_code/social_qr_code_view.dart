import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../../current_quest/state/current_quest_cubit.dart';
import 'social_qr_code_scan.dart';
import 'state/social_qr_code_cubit.dart';

class SocialQrCodeView extends StatelessWidget {
  const SocialQrCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SocialQrCodeCubit>(
      create: (context) => GetIt.I(),
      child: BlocBuilder<CurrentQuestCubit, CurrentQuestState>(
        buildWhen: (previous, current) => current is CurrentQuestLoaded,
        builder: (context, currentQuestState) {
          currentQuestState as CurrentQuestLoaded;
          return BlocConsumer<SocialQrCodeCubit, SocialQrCodeState>(
            listener: (context, state) {
              switch (state) {
                case SocialQrCodeSaved():
                  final resultMessage = state.result[LocaleSettings.currentLocale.languageCode];
                  if(resultMessage != null) {
                    showDialog<void>(
                      context: context,
                      builder: (dialogContext) =>
                          AlertDialog(
                            content: Text(resultMessage),
                            actions: [
                              FilledButton(
                                onPressed: () => Navigator.of(dialogContext).pop(),
                                child: Text(t.common.buttons.ok),
                              ),
                            ],
                          ),
                    );
                  }
                  break;
                case SocialQrCodeFailure():
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(t.common.errors.generic_retry), backgroundColor: appColors.error.seed),
                  );
                  break;
                default:
                  break;
              }
            },
            builder: (context, state) {
              return AppCard(
                style: AppCardStyle.normal,
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
