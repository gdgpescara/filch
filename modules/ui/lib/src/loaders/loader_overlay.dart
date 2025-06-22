import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';

import '../../ui.dart';

bool _isShowing = false;

class LoaderOverlay extends StatelessWidget {
  const LoaderOverlay._({this.message, this.messageWidget});

  final String? message;
  final Widget? messageWidget;

  static void show(BuildContext context, {String? message, Widget? messageWidget}) {
    if (_isShowing) {
      throw Exception('LoaderOverlay is already showing');
    }
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      useSafeArea: false,
      barrierColor: Colors.transparent,
      builder: (context) => LoaderOverlay._(message: message, messageWidget: messageWidget),
    );
    _isShowing = true;
  }

  static void hide(BuildContext context) {
    Navigator.pop(context);
    _isShowing = false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: BlurContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (message == null && messageWidget == null) ...[
              Image.asset('logo/logo.png', package: 'assets', height: 100, semanticLabel: t.devfest2024.semantic.logo),
              const Gap.vertical(Spacing.l),
            ],
            const LoaderAnimation(),
            const Gap.vertical(Spacing.l),
            if (message != null || messageWidget != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child:
                    messageWidget ??
                    Text(message!, style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
              ),
          ],
        ),
      ),
    );
  }
}
