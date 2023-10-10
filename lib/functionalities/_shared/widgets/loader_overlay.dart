import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'blur_container.dart';
import 'loader_animation.dart';

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

  // static void dark(BuildContext context, {String? message, Widget? messageWidget}) {
  //   showDialog<void>(
  //     context: context,
  //     barrierDismissible: false,
  //     useSafeArea: false,
  //     barrierColor: Colors.black.withOpacity(.8),
  //     builder: (context) => LoaderOverlay._(
  //       message: message,
  //       messageWidget: messageWidget,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlurContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (message != null || messageWidget != null) ...[
              SvgPicture.asset('assets/images/logo.svg', height: 50),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: messageWidget ??
                    Text(
                      message!,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
              ),
            ],
            const LoaderAnimation(),
          ],
        ),
      ),
    );
  }
}
