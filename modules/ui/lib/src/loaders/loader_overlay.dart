import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../ui.dart';

class LoaderOverlay extends StatelessWidget {
  const LoaderOverlay._({
    this.message,
    this.messageWidget,
  });

  final String? message;
  final Widget? messageWidget;

  static void show(BuildContext context, {String? message, Widget? messageWidget}) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      useSafeArea: false,
      barrierColor: Colors.transparent,
      builder: (context) => LoaderOverlay._(
        message: message,
        messageWidget: messageWidget,
      ),
    );
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
              SvgPicture.asset('logo/logo_light.svg', height: 100, package: 'assets'),
              const Gap.vertical(Spacing.l),
            ],
            const LoaderAnimation(),
            if (message != null || messageWidget != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: messageWidget ??
                    Text(
                      message!,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
              ),
          ],
        ),
      ),
    );
  }
}