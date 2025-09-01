part of 'app_theme.dart';

AppBarTheme _appBarTheme(ThemeData theme) => AppBarTheme(
  backgroundColor: Colors.transparent,
  shadowColor: Colors.transparent,
  elevation: 0,
  centerTitle: true,
  titleTextStyle: GoogleFonts.openSans(fontSize: theme.textTheme.titleLarge?.fontSize),
);
