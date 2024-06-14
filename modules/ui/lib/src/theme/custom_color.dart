part of 'app_theme.dart';

const success = Color(0xFF36D399);
const warning = Color(0xFFFBBD23);
const error = Color(0xFFF87272);
const logodark = Color(0xFF0C4F29);
const logolight = Color(0xFF258450);

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
  sourceLogodark: Color(0xFF0C4F29),
  logodark: Color(0xFF0C4F29),
  onLogodark: Color(0xFFFFFFFF),
  logodarkContainer: Color(0xFF9BF6B2),
  onLogodarkContainer: Color(0xFF00210D),
  sourceLogolight: Color(0xFF258450),
  logolight: Color(0xFF006D3C),
  onLogolight: Color(0xFFFFFFFF),
  logolightContainer: Color(0xFF97F7B6),
  onLogolightContainer: Color(0xFF00210F),
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
  sourceLogodark: Color(0xFF0C4F29),
  logodark: Color(0xFF80D998),
  onLogodark: Color(0xFF00391A),
  logodarkContainer: Color(0xFF005229),
  onLogodarkContainer: Color(0xFF9BF6B2),
  sourceLogolight: Color(0xFF258450),
  logolight: Color(0xFF7CDA9C),
  onLogolight: Color(0xFF00391D),
  logolightContainer: Color(0xFF00522C),
  onLogolightContainer: Color(0xFF97F7B6),
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
    required this.sourceLogodark,
    required this.logodark,
    required this.onLogodark,
    required this.logodarkContainer,
    required this.onLogodarkContainer,
    required this.sourceLogolight,
    required this.logolight,
    required this.onLogolight,
    required this.logolightContainer,
    required this.onLogolightContainer,
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
  final Color? sourceLogodark;
  final Color? logodark;
  final Color? onLogodark;
  final Color? logodarkContainer;
  final Color? onLogodarkContainer;
  final Color? sourceLogolight;
  final Color? logolight;
  final Color? onLogolight;
  final Color? logolightContainer;
  final Color? onLogolightContainer;

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
    Color? sourceLogodark,
    Color? logodark,
    Color? onLogodark,
    Color? logodarkContainer,
    Color? onLogodarkContainer,
    Color? sourceLogolight,
    Color? logolight,
    Color? onLogolight,
    Color? logolightContainer,
    Color? onLogolightContainer,
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
      sourceLogodark: sourceLogodark ?? this.sourceLogodark,
      logodark: logodark ?? this.logodark,
      onLogodark: onLogodark ?? this.onLogodark,
      logodarkContainer: logodarkContainer ?? this.logodarkContainer,
      onLogodarkContainer: onLogodarkContainer ?? this.onLogodarkContainer,
      sourceLogolight: sourceLogolight ?? this.sourceLogolight,
      logolight: logolight ?? this.logolight,
      onLogolight: onLogolight ?? this.onLogolight,
      logolightContainer: logolightContainer ?? this.logolightContainer,
      onLogolightContainer: onLogolightContainer ?? this.onLogolightContainer,
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
      sourceLogodark: Color.lerp(sourceLogodark, other.sourceLogodark, t),
      logodark: Color.lerp(logodark, other.logodark, t),
      onLogodark: Color.lerp(onLogodark, other.onLogodark, t),
      logodarkContainer: Color.lerp(logodarkContainer, other.logodarkContainer, t),
      onLogodarkContainer: Color.lerp(onLogodarkContainer, other.onLogodarkContainer, t),
      sourceLogolight: Color.lerp(sourceLogolight, other.sourceLogolight, t),
      logolight: Color.lerp(logolight, other.logolight, t),
      onLogolight: Color.lerp(onLogolight, other.onLogolight, t),
      logolightContainer: Color.lerp(logolightContainer, other.logolightContainer, t),
      onLogolightContainer: Color.lerp(onLogolightContainer, other.onLogolightContainer, t),
    );
  }

  /// Returns an instance of [CustomColors] in which the following custom
  /// colors are harmonized with [dynamic]'s [ColorScheme.primary].
  ///
  /// See also:
  ///   * <https://m3.material.io/styles/color/the-color-system/custom-colors#harmonization>
  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith();
  }
}
