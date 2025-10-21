import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../models/loading_sentences.dart';
import '../use_cases/get_loading_sentences_use_case.dart';

class SortingLoading extends StatefulWidget {
  const SortingLoading({super.key});

  @override
  State<SortingLoading> createState() => _SortingLoadingState();
}

class _SortingLoadingState extends State<SortingLoading> with SingleTickerProviderStateMixin {
  static const int _duration = 2;
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StreamBuilder<LoadingSentences>(
      stream: GetIt.I<GetLoadingSentencesUseCase>()(),
      builder: (context, loadingSentences) {
        if (!loadingSentences.hasData) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildMagicalIcon(theme),
                const Gap.vertical(Spacing.xl),
                CircularProgressIndicator(
                  strokeWidth: 3,
                  color: theme.colorScheme.primary,
                ),
              ],
            ),
          );
        }
        final sentences =
            loadingSentences.data?.sentences ??
            [
              {
                'en': 'You are being sorted...',
                'it': 'Stai venendo smistato...',
              },
            ];
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.xl,
            vertical: Spacing.xxl,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildMagicalIcon(theme),
              const Gap.vertical(Spacing.xxl),
              StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: _duration), (_) => Random().nextInt(sentences.length)),
                builder: (context, snapshot) {
                  final sentenceText = sentences[snapshot.data ?? 0][LocaleSettings.currentLocale.languageCode]!;
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 600),
                    switchInCurve: Curves.easeInOut,
                    switchOutCurve: Curves.easeInOut,
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.2),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: AppCard(
                      key: ValueKey('sentence_${snapshot.data ?? 0}'),
                      style: AppCardStyle.bordered,
                      child: Text(
                        sentenceText,
                        style: theme.textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
              const Gap.vertical(Spacing.xl),
              _buildLoadingIndicator(theme),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMagicalIcon(ThemeData theme) {
    return AnimatedBuilder(
      animation: _rotationController,
      builder: (context, child) {
        return Transform.rotate(
          angle: _rotationController.value * 2 * pi,
          child: Container(
            padding: const EdgeInsets.all(Spacing.l),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.tertiary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withValues(alpha: 0.4),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Icon(
              Icons.auto_awesome,
              size: 48,
              color: theme.colorScheme.onPrimary,
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingIndicator(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => AnimatedBuilder(
          animation: _rotationController,
          builder: (context, child) {
            final delay = index * 0.2;
            final value = (_rotationController.value + delay) % 1.0;
            final scale = 0.5 + (sin(value * 2 * pi) * 0.5 + 0.5) * 0.5;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.xs),
              child: Transform.scale(
                scale: scale,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.colorScheme.primary,
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.primary.withValues(alpha: 0.5),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
