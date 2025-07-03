part of 'app_theme.dart';

TextTheme _textTheme(TextTheme textTheme) => GoogleFonts.openSansTextTheme(textTheme);

TextTheme _themeSpecificTextTheme(TextTheme textTheme) => GoogleFonts.orbitronTextTheme(textTheme);

TextTheme _monospaceTextTheme(TextTheme textTheme) => GoogleFonts.jetBrainsMonoTextTheme(textTheme);

enum TextThemeType { normal, themeSpecific, monospace }

extension GetTextTheme on ThemeData {
  TextTheme getTextTheme([TextThemeType type = TextThemeType.normal]) => switch (type) {
    TextThemeType.themeSpecific => _themeSpecificTextTheme(textTheme),
    TextThemeType.monospace => _monospaceTextTheme(textTheme),
    TextThemeType.normal => _textTheme(textTheme),
  };
}
