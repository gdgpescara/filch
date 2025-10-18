import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../models/loading_sentences.dart';
import '../use_cases/get_loading_sentences_use_case.dart';

class SortingLoading extends StatelessWidget {
  const SortingLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LoadingSentences>(
      stream: GetIt.I<GetLoadingSentencesUseCase>()(),
      builder: (context, loadingSentences) {
        if (!loadingSentences.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final sentences =
            loadingSentences.data?.sentences ??
            [
              {
                'en': 'You are being sorted...',
                'it': 'Stai venendo smistato...',
              },
            ];
        return StreamBuilder<int>(
          stream: Stream.periodic(const Duration(seconds: 5), (_) => Random().nextInt(sentences.length)),
          builder: (context, snapshot) {
            final child = Text(
              sentences[snapshot.data ?? 0][LocaleSettings.currentLocale.languageCode]!,
              style: context.textTheme.titleLarge,
              textAlign: TextAlign.center,
            );
            return Padding(
              padding: const EdgeInsets.all(24),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 2000),
                child: Center(key: ValueKey('${snapshot.data ?? 0}'), child: child),
              ),
            );
          },
        );
      },
    );
  }
}
