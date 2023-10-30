import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../i18n/strings.g.dart';
import '../../../common_functionalities/models/house.dart';
import '../../../common_functionalities/widgets/app_card.dart';
import 'house_ranking_logo.dart';

class HousesRankingCard extends StatelessWidget {
  const HousesRankingCard({super.key, required this.house, required this.position, required this.isUserHouse});

  final House house;
  final int position;
  final bool isUserHouse;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      borderColor: isUserHouse ? Theme.of(context).colorScheme.onSurface : null,
      child: Row(
        children: [
          HouseRankingLogo(house, position),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  house.id.toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    text: t.house_ranking.points.label(n: house.points),
                    style: GoogleFonts.jetBrainsMono(),
                    children: [
                      TextSpan(
                        text: '${house.points}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
