part of 'app_theme.dart';

NavigationBarThemeData _navigationBarTheme(ColorScheme colorScheme) => NavigationBarThemeData(
  backgroundColor: colorScheme.surface,
  indicatorColor: colorScheme.secondaryContainer,
  iconTheme: WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.selected)) {
      return IconThemeData(color: colorScheme.secondary);
    }
    return IconThemeData(color: colorScheme.onSurface.withValues(alpha: 0.6));
  }),
  labelTextStyle: WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.selected)) {
      return TextStyle(color: colorScheme.secondary, fontWeight: FontWeight.bold);
    }
    return TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.6), fontWeight: FontWeight.normal);
  }),
);
