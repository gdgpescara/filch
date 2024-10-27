import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

class ScannedItem extends StatelessWidget {
  const ScannedItem(this.value, {super.key});

  final String value;

  @override
  Widget build(BuildContext context) {
    final data = jsonDecode(value) as Map<String, dynamic>;
    return AppCard(
      style: AppCardStyle.normal,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelValue(
            label: t.user.profile.user_info.name.label,
            value: data['displayName'] as String?,
          ),
        ],
      ),
    );
  }
}
