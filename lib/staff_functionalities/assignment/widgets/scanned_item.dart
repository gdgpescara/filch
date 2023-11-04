import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../common_functionalities/widgets/app_card.dart';
import '../../../common_functionalities/widgets/label_value.dart';
import '../../../i18n/strings.g.dart';

class ScannedItem extends StatelessWidget {
  const ScannedItem(this.value, {super.key});

  final String value;

  @override
  Widget build(BuildContext context) {
    final data = jsonDecode(value) as Map<String, dynamic>;
    return AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelValue(
            label: t.profile.user_info.name.label,
            value: data['displayName'] as String?,
          ),
        ],
      ),
    );
  }
}
