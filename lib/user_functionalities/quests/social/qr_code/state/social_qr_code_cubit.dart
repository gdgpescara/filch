import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../common_functionalities/error_handling/future_extension.dart';
import '../../../../../common_functionalities/user/use_cases/get_signed_user_house_use_case.dart';
import '../../../models/active_quest.dart';
import '../../../use_cases/social_quest_registration_use_case.dart';

part 'social_qr_code_state.dart';

@injectable
class SocialQrCodeCubit extends Cubit<SocialQrCodeState> {
  SocialQrCodeCubit(
    this._socialQuestRegistrationUseCase,
    this._getSignedUserHouseUseCase,
  ) : super(const SocialQrCodeInitial());

  final SocialQuestRegistrationUseCase _socialQuestRegistrationUseCase;

  final GetSignedUserHouseUseCase _getSignedUserHouseUseCase;

  void onScan(ActiveQuest activeQuest, String qrCode) {
    _socialQuestRegistrationUseCase(
      functionUrl: activeQuest.quest.verificationFunction!,
      payload: {
        'points': activeQuest.quest.points,
        'scannedValue': qrCode,
      },
    ).actions(
      progress: () => emit(const SocialQrCodeLoading()),
      success: (result) async => emit(
        SocialQrCodeSaved(
          result,
          activeQuest.quest.points,
          await _getSignedUserHouseUseCase(),
        ),
      ),
      failure: (_) => emit(const SocialQrCodeFailure()),
    );
  }
}
