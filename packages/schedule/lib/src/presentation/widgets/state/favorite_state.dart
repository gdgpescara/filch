import 'package:equatable/equatable.dart';

class FavoriteState extends Equatable {
  const FavoriteState({this.isFavorite = false});

  final bool isFavorite;

  @override
  List<Object?> get props => [isFavorite];
}

class FavoriteLoading extends FavoriteState {
  const FavoriteLoading({super.isFavorite});
}

sealed class FavoriteToggleState extends FavoriteState {
  const FavoriteToggleState({super.isFavorite});
}

class FavoriteToggleLoading extends FavoriteToggleState {
  const FavoriteToggleLoading({super.isFavorite});
}

class FavoriteToggleSuccess extends FavoriteToggleState {
  const FavoriteToggleSuccess({super.isFavorite});
}

class FavoriteToggleError extends FavoriteToggleState {
  const FavoriteToggleError({super.isFavorite});
}
