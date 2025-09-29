import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:i18n/i18n.dart';

import '../../ui.dart';

/// A reusable error view widget that displays an error message with a retry button.
///
/// This widget provides a consistent error UI across the app with:
/// - An error icon
/// - A title message
/// - The specific error details
/// - A retry button with callback
class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    this.error,
    this.onRetry,
    this.title,
    this.retryText,
  });

  /// The error message to display
  final String? error;

  /// Callback function to execute when retry button is pressed
  final VoidCallback? onRetry;

  /// Optional title text. If not provided, uses the default translation
  final String? title;

  /// Optional retry button text. If not provided, uses the default translation
  final String? retryText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(Spacing.xl),
        children: [
          Icon(
            FontAwesomeIcons.faceSadCry,
            size: 64,
            color: context.colorScheme.error,
          ),
          const SizedBox(height: Spacing.l),
          Text(
            title ?? t.common.errors.generic,
            style: context.textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          if (error != null) ...[
            Text(
              error!,
              style: context.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
          if (onRetry != null) ...[
            const SizedBox(height: Spacing.xl),
            TextButton(
              onPressed: onRetry,
              child: Text(retryText ?? t.common.buttons.try_again),
            ),
          ],
        ],
      ),
    );
  }
}
