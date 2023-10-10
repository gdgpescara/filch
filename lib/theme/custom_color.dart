part of 'app_theme.dart';

const success = Color(0xFF36D399);
const warning = Color(0xFFFBBD23);
const error = Color(0xFFF87272);

CustomColors lightCustomColors = const CustomColors(
  sourceSuccess: Color(0xFF36D399),
  success: Color(0xFF006C4A),
  onSuccess: Color(0xFFFFFFFF),
  successContainer: Color(0xFF69FCBE),
  onSuccessContainer: Color(0xFF002114),
  sourceWarning: Color(0xFFFBBD23),
  warning: Color(0xFF7A5900),
  onWarning: Color(0xFFFFFFFF),
  warningContainer: Color(0xFFFFDEA2),
  onWarningContainer: Color(0xFF261900),
  sourceError: Color(0xFFF87272),
  error: Color(0xFFA8363A),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFFFDAD8),
  onErrorContainer: Color(0xFF410007),
);

CustomColors darkCustomColors = const CustomColors(
  sourceSuccess: Color(0xFF36D399),
  success: Color(0xFF47DFA4),
  onSuccess: Color(0xFF003825),
  successContainer: Color(0xFF005137),
  onSuccessContainer: Color(0xFF69FCBE),
  sourceWarning: Color(0xFFFBBD23),
  warning: Color(0xFFFABC22),
  onWarning: Color(0xFF402D00),
  warningContainer: Color(0xFF5C4200),
  onWarningContainer: Color(0xFFFFDEA2),
  sourceError: Color(0xFFF87272),
  error: Color(0xFFFFB3B0),
  onError: Color(0xFF670311),
  errorContainer: Color(0xFF871E25),
  onErrorContainer: Color(0xFFFFDAD8),
);

/// Defines a set of custom colors, each comprised of 4 complementary tones.
///
/// See also:
///   * <https://m3.material.io/styles/color/the-color-system/custom-colors>
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.sourceSuccess,
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.sourceWarning,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.sourceError,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
  });

  final Color? sourceSuccess;
  final Color? success;
  final Color? onSuccess;
  final Color? successContainer;
  final Color? onSuccessContainer;
  final Color? sourceWarning;
  final Color? warning;
  final Color? onWarning;
  final Color? warningContainer;
  final Color? onWarningContainer;
  final Color? sourceError;
  final Color? error;
  final Color? onError;
  final Color? errorContainer;
  final Color? onErrorContainer;

  @override
  CustomColors copyWith({
    Color? sourceSuccess,
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? onSuccessContainer,
    Color? sourceWarning,
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? onWarningContainer,
    Color? sourceError,
    Color? error,
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
  }) {
    return CustomColors(
      sourceSuccess: sourceSuccess ?? this.sourceSuccess,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      successContainer: successContainer ?? this.successContainer,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
      sourceWarning: sourceWarning ?? this.sourceWarning,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
      sourceError: sourceError ?? this.sourceError,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      errorContainer: errorContainer ?? this.errorContainer,
      onErrorContainer: onErrorContainer ?? this.onErrorContainer,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      sourceSuccess: Color.lerp(sourceSuccess, other.sourceSuccess, t),
      success: Color.lerp(success, other.success, t),
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t),
      successContainer: Color.lerp(successContainer, other.successContainer, t),
      onSuccessContainer: Color.lerp(onSuccessContainer, other.onSuccessContainer, t),
      sourceWarning: Color.lerp(sourceWarning, other.sourceWarning, t),
      warning: Color.lerp(warning, other.warning, t),
      onWarning: Color.lerp(onWarning, other.onWarning, t),
      warningContainer: Color.lerp(warningContainer, other.warningContainer, t),
      onWarningContainer: Color.lerp(onWarningContainer, other.onWarningContainer, t),
      sourceError: Color.lerp(sourceError, other.sourceError, t),
      error: Color.lerp(error, other.error, t),
      onError: Color.lerp(onError, other.onError, t),
      errorContainer: Color.lerp(errorContainer, other.errorContainer, t),
      onErrorContainer: Color.lerp(onErrorContainer, other.onErrorContainer, t),
    );
  }
}
