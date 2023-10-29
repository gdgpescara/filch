import 'package:flutter/material.dart';

import '../../_shared/models/house.dart';

class HouseRankingLogo extends StatelessWidget {
  const HouseRankingLogo(this.house, this.position, {super.key});

  final House house;
  final int position;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 100,
      child: Stack(
        children: [
          Center(
            child: Container(
              width: 100 - (position * 10).toDouble(),
              height: 100 - (position * 10).toDouble(),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: _shadowColorByPosition,
                    blurRadius: 40,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Image.asset(
              width: 100 - (position * 10).toDouble(),
              height: 100 - (position * 10).toDouble(),
              'assets/images/houses/${house.id}.png',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Color get _shadowColorByPosition {
    switch (position) {
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.grey;
      case 3:
        return Colors.brown;
      default:
        return Colors.transparent;
    }
  }
}
