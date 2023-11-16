import 'package:flutter/material.dart';

import '../../../i18n/strings.g.dart';

class SortingSuccess extends StatefulWidget {
  const SortingSuccess({super.key, required this.house});

  final String house;

  @override
  State<SortingSuccess> createState() => _SortingSuccessState();
}

class _SortingSuccessState extends State<SortingSuccess> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: Stream.periodic(const Duration(seconds: 2), (_) => _),
      builder: (context, snapshot) {
        final child = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if ((snapshot.data ?? 0) < 2)
              Text(
                t.sorting_ceremony.assignment[widget.house]!,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            if ((snapshot.data ?? 0) >= 2) ...[
              const SizedBox(height: 20),
              _houseLogo(),
            ],
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

  Image _houseLogo() {
    return Image.asset(
      'assets/images/houses/${widget.house}.png',
      height: 200,
      width: 200,
      semanticLabel: t.sorting_ceremony.assigned(house: widget.house),
    );
  }
}
