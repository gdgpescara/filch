//@GeneratedMicroModule;QuestsPackageModule;package:quests/src/di/injection.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;

import 'package:auth/auth.dart' as _i662;
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:cloud_functions/cloud_functions.dart' as _i809;
import 'package:core/core.dart' as _i494;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:injectable/injectable.dart' as _i526;
import 'package:quests/quests.dart' as _i177;
import 'package:quests/src/current_quest/state/current_quest_cubit.dart'
    as _i80;
import 'package:quests/src/quiz/state/quiz_cubit.dart' as _i437;
import 'package:quests/src/ranking/state/ranking_cubit.dart' as _i96;
import 'package:quests/src/social/qr_code/state/social_qr_code_cubit.dart'
    as _i606;
import 'package:quests/src/use_cases/assign_points_use_case.dart' as _i615;
import 'package:quests/src/use_cases/assign_t_shirt_use_case.dart' as _i358;
import 'package:quests/src/use_cases/can_request_for_quest_use_case.dart'
    as _i384;
import 'package:quests/src/use_cases/get_assignable_points_use_case.dart'
    as _i650;
import 'package:quests/src/use_cases/get_ranking_use_case.dart' as _i251;
import 'package:quests/src/use_cases/get_signed_user_active_quest_use_case.dart'
    as _i954;
import 'package:quests/src/use_cases/get_signed_user_points_use_case.dart'
    as _i35;
import 'package:quests/src/use_cases/get_signed_user_quests_use_case.dart'
    as _i814;
import 'package:quests/src/use_cases/get_your_ranking_position_use_case.dart'
    as _i57;
import 'package:quests/src/use_cases/get_your_ranking_use_case.dart' as _i843;
import 'package:quests/src/use_cases/give_up_quest_use_case.dart' as _i616;
import 'package:quests/src/use_cases/is_ranking_freezed_use_case.dart' as _i792;
import 'package:quests/src/use_cases/search_for_quest_use_case.dart' as _i1056;
import 'package:quests/src/use_cases/social_quest_registration_use_case.dart'
    as _i806;
import 'package:quests/src/use_cases/submit_answer_use_case.dart' as _i216;
import 'package:quests/src/use_cases/validate_quiz_qr_code_use_case.dart'
    as _i25;

class QuestsPackageModule extends _i526.MicroPackageModule {
// initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.lazySingleton<_i25.ValidateQuizQrCodeUseCase>(
        () => _i25.ValidateQuizQrCodeUseCase());
    gh.lazySingleton<_i792.IsRankingFreezedUseCase>(() =>
        _i792.IsRankingFreezedUseCase(gh<_i494.GetFeatureFlagsUseCase>()));
    gh.lazySingleton<_i384.CanRequestForQuestUseCase>(() =>
        _i384.CanRequestForQuestUseCase(gh<_i494.GetFeatureFlagsUseCase>()));
    gh.lazySingleton<_i814.GetSignedUserQuestsUseCase>(
        () => _i814.GetSignedUserQuestsUseCase(
              gh<_i974.FirebaseFirestore>(),
              gh<_i662.GetSignedUserUseCase>(),
            ));
    gh.lazySingleton<_i35.GetSignedUserPointsUseCase>(
        () => _i35.GetSignedUserPointsUseCase(
              gh<_i974.FirebaseFirestore>(),
              gh<_i662.GetSignedUserUseCase>(),
            ));
    gh.lazySingleton<_i57.GetYourRankingPositionUseCase>(
        () => _i57.GetYourRankingPositionUseCase(
              gh<_i974.FirebaseFirestore>(),
              gh<_i662.GetSignedUserUseCase>(),
            ));
    gh.lazySingleton<_i251.GetRankingUseCase>(
        () => _i251.GetRankingUseCase(gh<_i974.FirebaseFirestore>()));
    gh.lazySingleton<_i650.GetAssignablePointsUseCase>(
        () => _i650.GetAssignablePointsUseCase(gh<_i974.FirebaseFirestore>()));
    gh.lazySingleton<_i615.AssignPointsUseCase>(
        () => _i615.AssignPointsUseCase(gh<_i809.FirebaseFunctions>()));
    gh.lazySingleton<_i806.SocialQuestRegistrationUseCase>(() =>
        _i806.SocialQuestRegistrationUseCase(gh<_i809.FirebaseFunctions>()));
    gh.lazySingleton<_i358.AssignTShirtUseCase>(
        () => _i358.AssignTShirtUseCase(gh<_i809.FirebaseFunctions>()));
    gh.lazySingleton<_i616.GiveUpQuestUseCase>(
        () => _i616.GiveUpQuestUseCase(gh<_i809.FirebaseFunctions>()));
    gh.lazySingleton<_i216.SubmitAnswerUseCase>(
        () => _i216.SubmitAnswerUseCase(gh<_i809.FirebaseFunctions>()));
    gh.lazySingleton<_i954.GetSignedUserActiveQuestUseCase>(
        () => _i954.GetSignedUserActiveQuestUseCase(
              gh<_i974.FirebaseFirestore>(),
              gh<_i59.FirebaseAuth>(),
            ));
    gh.lazySingleton<_i843.GetYourRankingUseCase>(
        () => _i843.GetYourRankingUseCase(
              gh<_i974.FirebaseFirestore>(),
              gh<_i662.GetSignedUserUseCase>(),
              gh<_i662.IsStaffUserUseCase>(),
            ));
    gh.lazySingleton<_i1056.SearchForQuestUseCase>(
        () => _i1056.SearchForQuestUseCase(
              gh<_i809.FirebaseFunctions>(),
              gh<_i954.GetSignedUserActiveQuestUseCase>(),
            ));
    gh.factory<_i606.SocialQrCodeCubit>(() =>
        _i606.SocialQrCodeCubit(gh<_i806.SocialQuestRegistrationUseCase>()));
    gh.factory<_i437.QuizCubit>(() => _i437.QuizCubit(
          gh<_i25.ValidateQuizQrCodeUseCase>(),
          gh<_i216.SubmitAnswerUseCase>(),
        ));
    gh.factory<_i80.CurrentQuestCubit>(() => _i80.CurrentQuestCubit(
          gh<_i662.GetSignedUserUseCase>(),
          gh<_i954.GetSignedUserActiveQuestUseCase>(),
          gh<_i1056.SearchForQuestUseCase>(),
          gh<_i384.CanRequestForQuestUseCase>(),
          gh<_i616.GiveUpQuestUseCase>(),
        ));
    gh.factory<_i96.RankingCubit>(() => _i96.RankingCubit(
          gh<_i662.GetSignedUserUseCase>(),
          gh<_i177.GetRankingUseCase>(),
          gh<_i177.GetYourRankingUseCase>(),
          gh<_i177.GetYourRankingPositionUseCase>(),
          gh<_i177.IsRankingFreezedUseCase>(),
        ));
  }
}
