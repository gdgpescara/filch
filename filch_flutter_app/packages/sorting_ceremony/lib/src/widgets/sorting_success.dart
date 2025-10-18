import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';


class SortingSuccess extends StatefulWidget {
  const SortingSuccess({super.key, required this.team});

  final Team team;

  @override
  State<SortingSuccess> createState() => _SortingSuccessState();
}

class _SortingSuccessState extends State<SortingSuccess> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: Stream.periodic(const Duration(seconds: 2), (v) => v),
      builder: (context, snapshot) {
        final child = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if ((snapshot.data ?? 0) < 2)
              Text(
                widget.team.claim[LocaleSettings.currentLocale.languageCode] ?? '',
                style: context.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            if ((snapshot.data ?? 0) >= 2) ...[const SizedBox(height: 20), _teamLogo()],
          ],
        );
        return Padding(
          padding: const EdgeInsets.all(24),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 1500),
            child: Center(key: ValueKey('${snapshot.data ?? 0}'), child: child),
          ),
        );
      },
    );
  }

  Widget _teamLogo() {
    return Semantics(
      label: widget.team.name,
      child: CachedNetworkImage(
        imageUrl: widget.team.imageUrl,
        height: 200,
        width: 200,
      ),
    );
  }
}
