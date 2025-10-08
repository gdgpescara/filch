part of 'app_theme.dart';

/// google yellow
const _googleYellow = CustomColor(
  seed: Color(0xfff4b400),
  value: Color(0xffdcbe0f),
  light: ColorFamily(
    color: Color(0xff6e5e00),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xffe5c61d),
    onColorContainer: Color(0xff403600),
  ),
  dark: ColorFamily(
    color: Color(0xffffe259),
    onColor: Color(0xff393000),
    colorContainer: Color(0xffd5b800),
    onColorContainer: Color(0xff352c00),
  ),
);

/// google red
const _googleRed = CustomColor(
  seed: Color(0xffdb4437),
  value: Color(0xffd34f00),
  light: ColorFamily(
    color: Color(0xff8d3200),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xffca4b00),
    onColorContainer: Color(0xffffffff),
  ),
  dark: ColorFamily(
    color: Color(0xffffb598),
    onColor: Color(0xff591d00),
    colorContainer: Color(0xffc54900),
    onColorContainer: Color(0xffffffff),
  ),
);

/// google green
const _googleGreen = CustomColor(
  seed: Color(0xff0f9d58),
  value: Color(0xff0f9d58),
  light: ColorFamily(
    color: Color(0xff005d31),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xff008649),
    onColorContainer: Color(0xffffffff),
  ),
  dark: ColorFamily(
    color: Color(0xff64dd91),
    onColor: Color(0xff00391c),
    colorContainer: Color(0xff008649),
    onColorContainer: Color(0xffffffff),
  ),
);

/// google blue
const _googleBlue = CustomColor(
  seed: Color(0xff3089ff),
  value: Color(0xff3089ff),
  light: ColorFamily(
    color: Color(0xff1e5ba8),
    onColor: Color(0xfffcfbff),
    colorContainer: Color(0xff5ba2ff),
    onColorContainer: Color(0xff060404),
  ),
  dark: ColorFamily(
    color: Color(0xff7db4ff),
    onColor: Color(0xff060404),
    colorContainer: Color(0xff2470d9),
    onColorContainer: Color(0xfffcfbff),
  ),
);

/// success
const _success = CustomColor(
  seed: Color(0xff36d399),
  value: Color(0xff36d399),
  light: ColorFamily(
    color: Color(0xff006c4a),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xff44dda2),
    onColorContainer: Color(0xff003d28),
  ),
  dark: ColorFamily(
    color: Color(0xff64f7ba),
    onColor: Color(0xff003825),
    colorContainer: Color(0xff2bcc93),
    onColorContainer: Color(0xff00301f),
  ),
);

/// warning
const _warning = CustomColor(
  seed: Color(0xffff9800),
  value: Color(0xffff9800),
  light: ColorFamily(
    color: Color(0xff8f4e00),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xffffb951),
    onColorContainer: Color(0xff5d3200),
  ),
  dark: ColorFamily(
    color: Color(0xffffcc7a),
    onColor: Color(0xff4a2800),
    colorContainer: Color(0xfff09000),
    onColorContainer: Color(0xff1f1100),
  ),
);

/// error
const _error = CustomColor(
  seed: Color(0xffe53935),
  value: Color(0xffe53935),
  light: ColorFamily(
    color: Color(0xffb71c1c),
    onColor: Color(0xffffffff),
    colorContainer: Color(0xffef5350),
    onColorContainer: Color(0xff3e0000),
  ),
  dark: ColorFamily(
    color: Color(0xffffb3b3),
    onColor: Color(0xff680003),
    colorContainer: Color(0xffd32f2f),
    onColorContainer: Color(0xff1a0000),
  ),
);

/// app yellow
const _appYellow = CustomColor(
  seed: Color(0xFFF4FF61),
  value: Color(0xFFF4FF61),
  light: ColorFamily(
    color: Color(0xFF6E5E00),
    onColor: Color(0xFFFFFFFF),
    colorContainer: Color(0xFFE5C61D),
    onColorContainer: Color(0xFF403600),
  ),
  dark: ColorFamily(
    color: Color(0xFFFFE259),
    onColor: Color(0xFF393000),
    colorContainer: Color(0xFFD5B800),
    onColorContainer: Color(0xFF352C00),
  ),
);

/// gold medal
const _gold = CustomColor(
  seed: Color(0xFFFFD700),
  value: Color(0xFFFFD700),
  light: ColorFamily(
    color: Color(0xFF8B6914),
    onColor: Color(0xFFFFFFFF),
    colorContainer: Color(0xFFFFD700),
    onColorContainer: Color(0xFF2A1800),
  ),
  dark: ColorFamily(
    color: Color(0xFFFFE082),
    onColor: Color(0xFF2A1800),
    colorContainer: Color(0xFFFFD700),
    onColorContainer: Color(0xFF2A1800),
  ),
);

/// silver medal
const _silver = CustomColor(
  seed: Color(0xFFC0C0C0),
  value: Color(0xFFC0C0C0),
  light: ColorFamily(
    color: Color(0xFF6E6E6E),
    onColor: Color(0xFFFFFFFF),
    colorContainer: Color(0xFFC0C0C0),
    onColorContainer: Color(0xFF1C1C1C),
  ),
  dark: ColorFamily(
    color: Color(0xFFE0E0E0),
    onColor: Color(0xFF1C1C1C),
    colorContainer: Color(0xFFC0C0C0),
    onColorContainer: Color(0xFF1C1C1C),
  ),
);

/// bronze medal
const _bronze = CustomColor(
  seed: Color(0xFFCD7F32),
  value: Color(0xFFCD7F32),
  light: ColorFamily(
    color: Color(0xFF8B4513),
    onColor: Color(0xFFFFFFFF),
    colorContainer: Color(0xFFCD7F32),
    onColorContainer: Color(0xFF2A1400),
  ),
  dark: ColorFamily(
    color: Color(0xFFE6A85C),
    onColor: Color(0xFF2A1400),
    colorContainer: Color(0xFFCD7F32),
    onColorContainer: Color(0xFF2A1400),
  ),
);

const _extendedColor = ExtendedColor(
  googleYellow: _googleYellow,
  googleRed: _googleRed,
  googleGreen: _googleGreen,
  googleBlue: _googleBlue,
  success: _success,
  warning: _warning,
  error: _error,
  appYellow: _appYellow,
  gold: _gold,
  silver: _silver,
  bronze: _bronze,
);

class ExtendedColor extends ThemeExtension<CustomColor> {
  const ExtendedColor({
    required this.googleYellow,
    required this.googleRed,
    required this.googleGreen,
    required this.googleBlue,
    required this.success,
    required this.warning,
    required this.error,
    required this.appYellow,
    required this.gold,
    required this.silver,
    required this.bronze,
  });

  final CustomColor googleYellow;
  final CustomColor googleRed;
  final CustomColor googleGreen;
  final CustomColor googleBlue;
  final CustomColor success;
  final CustomColor warning;
  final CustomColor error;
  final CustomColor appYellow;
  final CustomColor gold;
  final CustomColor silver;
  final CustomColor bronze;

  @override
  ThemeExtension<CustomColor> copyWith({
    CustomColor? googleYellow,
    CustomColor? googleRed,
    CustomColor? googleGreen,
    CustomColor? googleBlue,
    CustomColor? success,
    CustomColor? warning,
    CustomColor? error,
    CustomColor? appYellow,
    CustomColor? gold,
    CustomColor? silver,
    CustomColor? bronze,
  }) {
    return ExtendedColor(
      googleYellow: googleYellow ?? this.googleYellow,
      googleRed: googleRed ?? this.googleRed,
      googleGreen: googleGreen ?? this.googleGreen,
      googleBlue: googleBlue ?? this.googleBlue,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      appYellow: appYellow ?? this.appYellow,
      gold: gold ?? this.gold,
      silver: silver ?? this.silver,
      bronze: bronze ?? this.bronze,
    );
  }

  @override
  ThemeExtension<CustomColor> lerp(covariant ThemeExtension<CustomColor>? other, double t) {
    if (other is! ExtendedColor) {
      return this;
    }
    return ExtendedColor(
      googleYellow: googleYellow.lerp(other.googleYellow, t),
      googleRed: googleRed.lerp(other.googleRed, t),
      googleGreen: googleGreen.lerp(other.googleGreen, t),
      googleBlue: googleBlue.lerp(other.googleBlue, t),
      success: success.lerp(other.success, t),
      warning: warning.lerp(other.warning, t),
      error: error.lerp(other.error, t),
      appYellow: appYellow.lerp(other.appYellow, t),
      gold: gold.lerp(other.gold, t),
      silver: silver.lerp(other.silver, t),
      bronze: bronze.lerp(other.bronze, t),
    );
  }
}

class CustomColor extends ThemeExtension<CustomColor> {
  const CustomColor({required this.seed, required this.value, required ColorFamily light, required ColorFamily dark})
    : _light = light,
      _dark = dark;

  final Color seed;
  final Color value;
  final ColorFamily _light;
  final ColorFamily _dark;

  ColorFamily brightnessColor(BuildContext context) => context.brightness == Brightness.light ? _light : _dark;

  @override
  ThemeExtension<CustomColor> copyWith({Color? seed, Color? value, ColorFamily? light, ColorFamily? dark}) {
    return CustomColor(
      seed: seed ?? this.seed,
      value: value ?? this.value,
      light: light ?? _light,
      dark: dark ?? _dark,
    );
  }

  @override
  CustomColor lerp(covariant ThemeExtension<CustomColor>? other, double t) {
    if (other is! CustomColor) {
      return this;
    }
    return CustomColor(
      seed: Color.lerp(seed, other.seed, t)!,
      value: Color.lerp(value, other.value, t)!,
      light: _light.lerp(other._light, t),
      dark: _dark.lerp(other._dark, t),
    );
  }
}

class ColorFamily extends ThemeExtension<ColorFamily> {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;

  @override
  ThemeExtension<ColorFamily> copyWith({Color? color, Color? onColor, Color? colorContainer, Color? onColorContainer}) {
    return ColorFamily(
      color: color ?? this.color,
      onColor: onColor ?? this.onColor,
      colorContainer: colorContainer ?? this.colorContainer,
      onColorContainer: onColorContainer ?? this.onColorContainer,
    );
  }

  @override
  ColorFamily lerp(covariant ThemeExtension<ColorFamily>? other, double t) {
    if (other is! ColorFamily) {
      return this;
    }
    return ColorFamily(
      color: Color.lerp(color, other.color, t)!,
      onColor: Color.lerp(onColor, other.onColor, t)!,
      colorContainer: Color.lerp(colorContainer, other.colorContainer, t)!,
      onColorContainer: Color.lerp(onColorContainer, other.onColorContainer, t)!,
    );
  }
}
