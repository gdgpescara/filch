part of 'app_theme.dart';

/// Custom indicator for TabBar using trapezoidal shape
class TrapezoidTabIndicator extends Decoration {
  const TrapezoidTabIndicator({required this.color});

  final Color color;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _TrapezoidPainter(color);
  }
}

class _TrapezoidPainter extends BoxPainter {
  _TrapezoidPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    // Create a rect that surrounds the entire tab content (like a button)
    final rect = Rect.fromLTWH(
      offset.dx + 4, // Small margin from left
      offset.dy + 4, // Small margin from top
      configuration.size!.width - 8, // Account for margins
      configuration.size!.height - 8, // Account for margins
    );

    // Use the existing TrapezoidButtonClipper for consistency
    final clipper = TappableAreaClipper();
    final path = clipper.getClip(rect.size);
    
    // Translate the path to the correct position
    final translatedPath = path.shift(rect.topLeft);

    final paint = Paint()
      ..color = color.withValues(alpha: 0.15) // Semi-transparent background
      ..style = PaintingStyle.fill;

    canvas.drawPath(translatedPath, paint);
  }
}

// Primary TabBar theme with trapezoidal indicator
TabBarThemeData primaryTabBarTheme(ColorScheme colorScheme) => TabBarThemeData(
  labelColor: colorScheme.secondary,
  unselectedLabelColor: colorScheme.onSurface.withValues(alpha: 0.6),
  labelStyle: GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    fontSize: 14,
  ),
  unselectedLabelStyle: GoogleFonts.poppins(
    fontWeight: FontWeight.normal,
    fontSize: 14,
  ),
  indicator: TrapezoidTabIndicator(color: colorScheme.secondary),
  indicatorSize: TabBarIndicatorSize.tab,
  labelPadding: const EdgeInsets.only(left: Spacing.s, right: Spacing.s, top: Spacing.s),
  overlayColor: WidgetStateProperty.all(colorScheme.secondary.withValues(alpha: 0.12)),
);

// Secondary TabBar theme with standard underline indicator
TabBarThemeData secondaryTabBarTheme(ColorScheme colorScheme) => TabBarThemeData(
  labelColor: colorScheme.secondary,
  unselectedLabelColor: colorScheme.onSurface.withValues(alpha: 0.6),
  labelStyle: GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    fontSize: 14,
  ),
  unselectedLabelStyle: GoogleFonts.poppins(
    fontWeight: FontWeight.normal,
    fontSize: 14,
  ),
  indicator: UnderlineTabIndicator(
    borderSide: BorderSide(
      color: colorScheme.secondary,
      width: 2,
    ),
  ),
  indicatorSize: TabBarIndicatorSize.label,
  labelPadding: const EdgeInsets.symmetric(horizontal: Spacing.s),
  overlayColor: WidgetStateProperty.all(colorScheme.secondary.withValues(alpha: 0.12)),
);

// Default TabBar theme (uses primary style)
TabBarThemeData _tabBarTheme(ColorScheme colorScheme) => TabBarThemeData(
  labelColor: colorScheme.secondary,
  unselectedLabelColor: colorScheme.onSurface.withValues(alpha: 0.6),
  labelStyle: GoogleFonts.poppins(
    fontWeight: FontWeight.bold,
    fontSize: 14,
  ),
  unselectedLabelStyle: GoogleFonts.poppins(
    fontWeight: FontWeight.normal,
    fontSize: 14,
  ),
  indicator: TrapezoidTabIndicator(color: colorScheme.secondary),
  indicatorSize: TabBarIndicatorSize.tab,
  labelPadding: const EdgeInsets.symmetric(horizontal: Spacing.s, vertical: Spacing.xs),
  overlayColor: WidgetStateProperty.all(colorScheme.secondary.withValues(alpha: 0.12)),
);
