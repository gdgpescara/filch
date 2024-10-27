import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../media_manager.dart';
import '../../use_cases/add_photo_to_upload_queue_use_case.dart';
import '../../use_cases/move_file_in_app_directory_use_case.dart';
import '../../use_cases/take_photo_use_case.dart';

part 'photo_button_state.dart';

@injectable
class PhotoButtonCubit extends Cubit<PhotoButtonState> {
  PhotoButtonCubit(
    this._takePhotoUseCase,
    this._moveFileUseCase,
    this._addPhotoToUploadQueueUseCase,
      @Named('documentDirectory') this._documentDirectory,
  ) : super(const PhotoButtonInitial());

  final Directory _documentDirectory;
  final TakePhotoUseCase _takePhotoUseCase;
  final MoveFileUseCase _moveFileUseCase;
  final AddPhotoToUploadQueueUseCase _addPhotoToUploadQueueUseCase;

  void takePhoto(PhotoType photoType) {
    _takePhotoUseCase().when(
      progress: () => emit(const TakingPhoto()),
      success: (file) {
        if (file != null) {
          _processPhoto(file, photoType);
          emit(PhotoTaken(file));
        } else {
          emit(const PhotoButtonInitial());
        }
      },
      failure: (_) => emit(const PhotoButtonInitial()),
    );
  }

  Future<void> _processPhoto(File file, PhotoType photoType) async {
    final destination = '${_documentDirectory.path}/${photoType.directoryName}';
    final newPath = await _moveFileUseCase(srcPath: file.path, destDir: destination, fileName: file.name);
    await _addPhotoToUploadQueueUseCase(newPath, photoType);
  }
}
