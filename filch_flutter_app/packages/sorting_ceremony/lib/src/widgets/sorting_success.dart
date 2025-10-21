import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../../sorting_ceremony.dart';

class SortingSuccess extends StatefulWidget {
  const SortingSuccess({super.key, required this.team});

  final Team team;

  @override
  State<SortingSuccess> createState() => _SortingSuccessState();
}

class _SortingSuccessState extends State<SortingSuccess> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = LocaleSettings.currentLocale.languageCode;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        bottom: false,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.l,
              vertical: Spacing.xl,
            ),
            children: [
              _teamLogo(),
              const Gap.vertical(Spacing.l),
              Text(
                widget.team.name[locale] ?? '',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                widget.team.claim[locale] ?? '',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const Gap.vertical(Spacing.m),
              AppCard(
                style: AppCardStyle.bordered,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 20,
                          color: theme.colorScheme.primary,
                        ),
                        const Gap.horizontal(Spacing.s),
                        Text(
                          t.sorting_ceremony.about_us,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    const Gap.vertical(Spacing.m),
                    Text(
                      widget.team.description[locale] ?? '',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap.vertical(Spacing.xxl),
              ElevatedButton.icon(
                onPressed: context.read<SortingCeremonyCubit>().exitCeremony,
                icon: const Icon(Icons.check_circle_outline),
                label: Text(t.common.buttons.continue_next),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: Spacing.m,
                    horizontal: Spacing.xl,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(RadiusSize.l),
                  ),
                ),
              ),
              const Gap.vertical(Spacing.l),
            ],
          ),
        ),
      ),
    );
  }

  Widget _teamLogo() {
    return StreamBuilder<int>(
      stream: Stream.periodic(const Duration(seconds: 2), (v) => v),
      builder: (context, snapshot) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 1500),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          child: Semantics(
            key: ValueKey<int>(snapshot.data ?? 0),
            label: widget.team.name[LocaleSettings.currentLocale.languageCode] ?? '',
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(RadiusSize.l),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(RadiusSize.l),
                child: CachedNetworkImage(
                  imageUrl: widget.team.imageUrl,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 200,
                    width: 200,
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
