part of 'app_theme.dart';

BottomSheetThemeData _bottomSheetTheme(ColorScheme colorScheme) {
  return BottomSheetThemeData(
    backgroundColor: colorScheme.surface,
    modalBarrierColor: colorScheme.tertiary.withValues(alpha: .2),
    shadowColor: colorScheme.primary,
  );
}
