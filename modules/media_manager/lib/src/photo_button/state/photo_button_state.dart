part of 'photo_button_cubit.dart';

sealed class PhotoButtonState extends Equatable {
  const PhotoButtonState();
}

final class PhotoButtonInitial extends PhotoButtonState {
  const PhotoButtonInitial();
  @override
  List<Object> get props => [];
}

final class TakingPhoto extends PhotoButtonState {
  const TakingPhoto();
  @override
  List<Object> get props => [];
}

final class PhotoTaken extends PhotoButtonState {
  const PhotoTaken(this.file);

  final File file;

  @override
  List<Object> get props => [file];
}
