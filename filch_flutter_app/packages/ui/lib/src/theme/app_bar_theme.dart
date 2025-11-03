part of 'app_theme.dart';

AppBarTheme _appBarTheme(ThemeData theme) => AppBarTheme(
  backgroundColor: theme.colorScheme.surface,
  foregroundColor: theme.colorScheme.onSurface,
  elevation: 0,
  centerTitle: true,
  titleTextStyle: GoogleFonts.poppins(
    fontSize: theme.textTheme.titleLarge?.fontSize,
    color: theme.colorScheme.onSurface,
  ),
  actionsPadding: const EdgeInsets.only(right: Spacing.s),
);
