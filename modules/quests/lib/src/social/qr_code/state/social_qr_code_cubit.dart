import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../models/active_quest.dart';
import '../../../use_cases/social_quest_registration_use_case.dart';

part 'social_qr_code_state.dart';

@injectable
class SocialQrCodeCubit extends SafeEmitterCubit<SocialQrCodeState> {
  SocialQrCodeCubit(
    this._socialQuestRegistrationUseCase,
  ) : super(const SocialQrCodeInitial());

  final SocialQuestRegistrationUseCase _socialQuestRegistrationUseCase;

  void onScan(ActiveQuest activeQuest, String qrCode) {
    _socialQuestRegistrationUseCase(
      functionUrl: activeQuest.quest.verificationFunction!,
      payload: {
        'points': activeQuest.quest.points,
        'scannedValue': qrCode,
      },
    ).when(
      progress: () => emit(const SocialQrCodeLoading()),
      success: (result) async => emit(
        SocialQrCodeSaved(
          result,
          activeQuest.quest.points,
        ),
      ),
      failure: (_) => emit(const SocialQrCodeFailure()),
    );
  }
}
