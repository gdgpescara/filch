import 'package:flutter/material.dart';

import '../../../models/session.dart';

class SessionCard extends StatelessWidget {
  const SessionCard({
    super.key,
    required this.session,
    required this.onTap,
    required this.onFavoriteToggle,
    required this.isFavorite,
  });

  final Session session;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Speaker avatar
              CircleAvatar(
                radius: 24,
                backgroundImage: session.speakers.isNotEmpty
                    ? NetworkImage(session.speakers.first.profilePicture)
                    : null,
                backgroundColor: Colors.grey[300],
                child: session.speakers.isEmpty ? const Icon(Icons.person, color: Colors.grey) : null,
              ),
              const SizedBox(width: 16),

              // Session details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Session title
                    Text(
                      session.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Room and duration
                    Text(
                      '${session.room.name} • ${session.duration.inMinutes} min',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Speaker name
                    if (session.speakers.isNotEmpty)
                      Text(
                        session.speakers.first.fullName,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                      ),
                  ],
                ),
              ),

              // Favorite button
              IconButton(
                onPressed: onFavoriteToggle,
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
