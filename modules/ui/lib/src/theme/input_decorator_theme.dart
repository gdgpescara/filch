part of 'app_theme.dart';

InputDecorationTheme _inputDecorationTheme(ColorScheme colorScheme) => InputDecorationTheme(
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RadiusSize.m),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RadiusSize.m),
        borderSide: BorderSide(color: colorScheme.secondary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RadiusSize.m),
        borderSide: BorderSide(color: colorScheme.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RadiusSize.m),
        borderSide: BorderSide(color: _extendedColor.error.seed),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RadiusSize.m),
        borderSide: BorderSide(color: _extendedColor.error.seed),
      ),
      errorStyle: GoogleFonts.jetBrainsMono(
        color: _extendedColor.error.seed,
      ),
      labelStyle: GoogleFonts.openSans(
        color: colorScheme.secondary,
      ),
    );
