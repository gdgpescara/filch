//@GeneratedMicroModule;MediaManagerPackageModule;package:media_manager/src/di/injection.module.dart
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i687;
import 'dart:io' as _i497;

import 'package:auth/auth.dart' as _i662;
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:image_picker/image_picker.dart' as _i183;
import 'package:injectable/injectable.dart' as _i526;
import 'package:media_manager/media_manager.dart' as _i914;
import 'package:media_manager/src/photo_button/state/photo_button_cubit.dart' as _i855;
import 'package:media_manager/src/use_cases/add_photo_to_upload_queue_use_case.dart' as _i5;
import 'package:media_manager/src/use_cases/move_file_in_app_directory_use_case.dart' as _i989;
import 'package:media_manager/src/use_cases/take_photo_use_case.dart' as _i709;
import 'package:media_manager/src/use_cases/upload_community_quest_photo_use_case.dart' as _i60;
import 'package:media_manager/src/use_cases/upload_queue_executor_use_case.dart' as _i334;

class MediaManagerPackageModule extends _i526.MicroPackageModule {
  // initializes the registration of main-scope dependencies inside of GetIt
  @override
  _i687.FutureOr<void> init(_i526.GetItHelper gh) {
    gh.lazySingleton<_i989.MoveFileUseCase>(() => _i989.MoveFileUseCase());
    gh.lazySingleton<_i709.TakePhotoUseCase>(() => _i709.TakePhotoUseCase(gh<_i183.ImagePicker>()));
    gh.lazySingleton<_i5.AddPhotoToUploadQueueUseCase>(
      () => _i5.AddPhotoToUploadQueueUseCase(
        gh<_i974.FirebaseFirestore>(),
        gh<_i662.GetSignedUserUseCase>(),
      ),
    );
    gh.lazySingleton<_i60.UploadCommunityQuestPhotoUseCase>(
      () => _i60.UploadCommunityQuestPhotoUseCase(gh<_i457.Reference>()),
    );
    gh.factory<_i855.PhotoButtonCubit>(
      () => _i855.PhotoButtonCubit(
        gh<_i709.TakePhotoUseCase>(),
        gh<_i989.MoveFileUseCase>(),
        gh<_i5.AddPhotoToUploadQueueUseCase>(),
        gh<_i497.Directory>(instanceName: 'documentDirectory'),
      ),
    );
    gh.lazySingleton<_i334.UploadQueueExecutorUseCase>(
      () => _i334.UploadQueueExecutorUseCase(
        gh<_i974.FirebaseFirestore>(),
        gh<_i662.GetSignedUserUseCase>(),
        gh<_i914.UploadCommunityQuestPhotoUseCase>(),
      ),
    );
  }
}
