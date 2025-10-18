part of 'app_theme.dart';

ProgressIndicatorThemeData _progressIndicatorThemeData(ColorScheme colorScheme) => const ProgressIndicatorThemeData(
  strokeCap: StrokeCap.round,
  strokeWidth: 6,
  constraints: BoxConstraints(
    minHeight: 24,
    minWidth: 24,
  ),
);
