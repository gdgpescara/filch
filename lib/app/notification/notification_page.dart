import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:routefly/routefly.dart';
import 'package:ui/ui.dart';

// ignore: strict_raw_type
Route routeBuilder(BuildContext context, RouteSettings settings) {
  return Routefly.defaultRouteBuilder(
    context,
    settings,
    NotificationPage(notification: settings.arguments! as RemoteNotification),
  );
}

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key, required this.notification});

  final RemoteNotification notification;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Background(
        child: Center(
          child: AppCard(
            style: AppCardStyle.normal,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.common.notifications.title,
                  style: context.getTextTheme(TextThemeType.themeSpecific).titleMedium,
                ),
                const Gap.vertical(Spacing.xxl),
                Text(
                  notification.title ?? '',
                  style: context.getTextTheme().bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Gap.vertical(Spacing.s),
                Text(notification.body ?? ''),
                const Gap.vertical(Spacing.l),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () => Routefly.pop<void>(context), child: Text(t.common.buttons.ok)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
