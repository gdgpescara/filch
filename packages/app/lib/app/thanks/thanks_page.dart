import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

class ThanksPage extends StatelessWidget {
  const ThanksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Spacing.l),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Logo(),
              const Gap.vertical(Spacing.xl),
              AppCard(
                style: AppCardStyle.bordered,
                borderColor: context.colorScheme.secondary,
                child: Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: context.textTheme.bodyLarge?.copyWith(
                          height: 1.5,
                          color: context.colorScheme.onSurface,
                        ),
                        children: [
                          TextSpan(
                            text: '🎉 ',
                            style: context.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w900),
                          ),
                          TextSpan(
                            text: t.devfest2024.thanks.title,
                            style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900),
                          ),
                          TextSpan(
                            text: t.devfest2024.thanks.subtitle,
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                              color: context.colorScheme.onSurface.withValues(alpha: 0.5),
                            ),
                          ),
                          TextSpan(
                            text: '\n\n',
                            style: context.textTheme.bodyLarge?.copyWith(fontStyle: FontStyle.italic),
                          ),
                          TextSpan(
                            text: t.devfest2024.thanks.see_you_soon_prefix,
                            style: context.textTheme.bodyLarge,
                          ),
                          TextSpan(
                            text: t.devfest2024.thanks.see_you_soon_bold,
                            style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: t.devfest2024.thanks.see_you_soon_suffix,
                            style: context.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    const Gap.vertical(Spacing.m),
                    // Decorative icons row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _DecorativeIcon(
                          icon: Icons.favorite,
                          color: appColors.googleRed.seed,
                        ),
                        _DecorativeIcon(
                          icon: Icons.handshake,
                          color: appColors.googleBlue.seed,
                        ),
                        _DecorativeIcon(
                          icon: Icons.group,
                          color: appColors.googleGreen.seed,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Gap.vertical(Spacing.m),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 50,
                ),
                child: Image.asset(
                  'logo/gdg_logo_full.png',
                  package: 'assets',
                  semanticLabel: t.devfest2024.semantic.logo,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DecorativeIcon extends StatelessWidget {
  const _DecorativeIcon({
    required this.icon,
    required this.color,
  });

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.1),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Icon(
        icon,
        color: color,
        size: 18,
      ),
    );
  }
}
