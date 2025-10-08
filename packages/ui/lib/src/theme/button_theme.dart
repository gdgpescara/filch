part of 'app_theme.dart';

/// Custom shape for buttons using the trapezoidal clipper
class TrapezoidButtonShape extends OutlinedBorder {
  const TrapezoidButtonShape({super.side = BorderSide.none});

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(side.width);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    final innerRect = Rect.fromLTRB(
      rect.left + side.width,
      rect.top + side.width,
      rect.right - side.width,
      rect.bottom - side.width,
    );
    return TappableAreaClipper().getClip(innerRect.size);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return TappableAreaClipper().getClip(rect.size);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    if (side.style != BorderStyle.none && side.width > 0) {
      final paint = Paint()
        ..color = side.color
        ..strokeWidth = side.width
        ..style = PaintingStyle.stroke;

      final path = getOuterPath(rect, textDirection: textDirection);
      canvas.drawPath(path, paint);
    }
  }

  @override
  ShapeBorder scale(double t) => TrapezoidButtonShape(side: side.scale(t));

  @override
  OutlinedBorder copyWith({BorderSide? side}) => TrapezoidButtonShape(side: side ?? this.side);
}

ElevatedButtonThemeData _elevatedButtonThemeData(ColorScheme colorScheme) => ElevatedButtonThemeData(
  style: ButtonStyle(
    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(RadiusSize.m))),
    enableFeedback: true,
    tapTargetSize: MaterialTapTargetSize.padded,
    backgroundColor: WidgetStateProperty.resolveWith((colorStates) {
      if (colorStates.contains(WidgetState.disabled)) {
        return colorScheme.tertiaryContainer;
      }
      return colorScheme.primary;
    }),
    textStyle: WidgetStateProperty.all(
      GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
      ),
    ),
    minimumSize: WidgetStateProperty.all(const Size(kMinInteractiveDimension, kMinInteractiveDimension)),
  ),
);

TextButtonThemeData _textButtonThemeData(ColorScheme colorScheme) => TextButtonThemeData(
  style: ButtonStyle(
    enableFeedback: true,
    tapTargetSize: MaterialTapTargetSize.padded,
    foregroundColor: WidgetStateProperty.resolveWith((colorStates) {
      if (colorStates.contains(WidgetState.disabled)) {
        return colorScheme.tertiaryContainer;
      }
      return colorScheme.primary;
    }),
    textStyle: WidgetStateProperty.all(
      GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
      ),
    ),
    minimumSize: WidgetStateProperty.all(const Size(kMinInteractiveDimension, kMinInteractiveDimension)),
  ),
);

OutlinedButtonThemeData _outlinedButtonThemeData(ColorScheme colorScheme) => OutlinedButtonThemeData(
  style: ButtonStyle(
    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(RadiusSize.m))),
    enableFeedback: true,
    tapTargetSize: MaterialTapTargetSize.padded,
    side: WidgetStateProperty.all(BorderSide(color: colorScheme.primary)),
    backgroundColor: WidgetStateProperty.resolveWith((colorStates) {
      if (colorStates.contains(WidgetState.disabled)) {
        return colorScheme.tertiaryContainer.withValues(alpha: 0.40);
      }
      return colorScheme.tertiaryContainer.withValues(alpha: 0.40);
    }),
    foregroundColor: WidgetStateProperty.all(colorScheme.primary),
    textStyle: WidgetStateProperty.all(
      GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
      ),
    ),
    minimumSize: WidgetStateProperty.all(const Size(kMinInteractiveDimension, kMinInteractiveDimension)),
  ),
);

FilledButtonThemeData _filledButtonThemeData(ColorScheme colorScheme) => FilledButtonThemeData(
  style: ButtonStyle(
    shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(RadiusSize.m))),
    enableFeedback: true,
    tapTargetSize: MaterialTapTargetSize.padded,
    backgroundColor: WidgetStateProperty.resolveWith((colorStates) {
      if (colorStates.contains(WidgetState.disabled)) {
        return colorScheme.tertiaryContainer;
      }
      return colorScheme.primary;
    }),
    textStyle: WidgetStateProperty.all(
      GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
      ),
    ),
    minimumSize: WidgetStateProperty.all(const Size(kMinInteractiveDimension, kMinInteractiveDimension)),
  ),
);
