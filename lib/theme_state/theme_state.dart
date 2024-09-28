part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  const ThemeState({this.seedColor = pinkColor});

  final Color seedColor;

  ThemeState copyWith({
    Color? seedColor,
  }) {
    return ThemeState(
      seedColor: seedColor ?? this.seedColor,
    );
  }

  @override
  List<Object> get props => [seedColor];
}
