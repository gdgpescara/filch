part of 'app_theme.dart';

BottomSheetThemeData _bottomSheetTheme(ColorScheme colorScheme) {
  return BottomSheetThemeData(
    backgroundColor: colorScheme.surface,
    modalBarrierColor: colorScheme.tertiary.withOpacity(.2),
    shadowColor: colorScheme.primary,
  );
}
