part of 'app_theme.dart';

BottomNavigationBarThemeData _bottomNavigationBarTheme(ColorScheme colorScheme) {
  return BottomNavigationBarThemeData(
    backgroundColor: colorScheme.surface,
    selectedItemColor: colorScheme.primary,
    unselectedItemColor: colorScheme.onSurface.withValues(alpha: 0.6),
    showSelectedLabels: true,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
    elevation: 8,
  );
}
