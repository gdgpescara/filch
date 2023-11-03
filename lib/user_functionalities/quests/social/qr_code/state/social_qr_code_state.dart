part of 'social_qr_code_cubit.dart';

sealed class SocialQrCodeState extends Equatable {
  const SocialQrCodeState();
}

class SocialQrCodeInitial extends SocialQrCodeState {
  const SocialQrCodeInitial();

  @override
  List<Object> get props => [];
}

class SocialQrCodeLoading extends SocialQrCodeState {
  const SocialQrCodeLoading();

  @override
  List<Object> get props => [];
}

class SocialQrCodeSaved extends SocialQrCodeState {
  const SocialQrCodeSaved(this.isCorrect, this.points, this.house);

  final bool isCorrect;
  final int points;
  final String house;

  @override
  List<Object> get props => [points, house];
}

class SocialQrCodeFailure extends SocialQrCodeState {
  const SocialQrCodeFailure();

  @override
  List<Object> get props => [];
}
