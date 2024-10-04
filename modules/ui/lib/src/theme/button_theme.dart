part of 'app_theme.dart';

ElevatedButtonThemeData _elevatedButtonThemeData(ColorScheme colorScheme) => ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RadiusSize.m),
          ),
        ),
        enableFeedback: true,
        tapTargetSize: MaterialTapTargetSize.padded,
        backgroundColor: WidgetStateProperty.all(colorScheme.primaryContainer),
        foregroundColor: WidgetStateProperty.all(colorScheme.onPrimaryContainer),
        textStyle: WidgetStateProperty.all(GoogleFonts.openSans(fontWeight: FontWeight.bold)),
        minimumSize: WidgetStateProperty.all(const Size(kMinInteractiveDimension, kMinInteractiveDimension)),
      ),
    );

TextButtonThemeData _textButtonThemeData(ColorScheme colorScheme) => TextButtonThemeData(
      style: ButtonStyle(
        enableFeedback: true,
        tapTargetSize: MaterialTapTargetSize.padded,
        foregroundColor: WidgetStateProperty.all(colorScheme.primaryContainer),
        textStyle: WidgetStateProperty.all(GoogleFonts.openSans(fontWeight: FontWeight.bold)),
        minimumSize: WidgetStateProperty.all(const Size(kMinInteractiveDimension, kMinInteractiveDimension)),
      ),
    );

OutlinedButtonThemeData _outlinedButtonThemeData(ColorScheme colorScheme) => OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RadiusSize.m),
          ),
        ),
        enableFeedback: true,
        tapTargetSize: MaterialTapTargetSize.padded,
        side: WidgetStateProperty.all(BorderSide(color: colorScheme.primaryContainer)),
        textStyle: WidgetStateProperty.all(GoogleFonts.openSans(fontWeight: FontWeight.bold)),
        minimumSize: WidgetStateProperty.all(const Size(kMinInteractiveDimension, kMinInteractiveDimension)),
      ),
    );
