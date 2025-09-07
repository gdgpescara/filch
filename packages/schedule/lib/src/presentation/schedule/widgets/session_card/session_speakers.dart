import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../../../../models/models.dart';

class SessionSpeakers extends StatelessWidget {
  const SessionSpeakers({
    super.key,
    required this.speakers,
  });

  final List<Speaker> speakers;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Speaker${speakers.length > 1 ? 's' : ''}',
          style: context.textTheme.bodyMedium,
        ),
        const SizedBox(height: Spacing.s),
        ...speakers.map((speaker) => _buildSpeakerRow(context, speaker)),
      ],
    );
  }

  Widget _buildSpeakerRow(BuildContext context, Speaker speaker) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.s),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: speaker.profilePicture.isNotEmpty ? NetworkImage(speaker.profilePicture) : null,
            child: speaker.profilePicture.isEmpty ? Text(speaker.name[0]) : null,
          ),
          const SizedBox(width: Spacing.s),

          // Nome speaker
          Expanded(child: Text(speaker.name)),
        ],
      ),
    );
  }
}
