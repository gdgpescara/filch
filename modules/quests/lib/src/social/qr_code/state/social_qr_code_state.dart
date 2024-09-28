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
  const SocialQrCodeSaved(this.isCorrect, this.points);

  final bool isCorrect;
  final int points;

  @override
  List<Object> get props => [points];
}

class SocialQrCodeFailure extends SocialQrCodeState {
  const SocialQrCodeFailure();

  @override
  List<Object> get props => [];
}
