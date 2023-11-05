import 'package:flutter/material.dart';

import '../../../common_functionalities/models/house.dart';

class HouseRankingLogo extends StatelessWidget {
  const HouseRankingLogo(this.house, this.position, this.isUserHouse, {super.key});

  final House house;
  final int position;
  final bool isUserHouse;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 100,
      child: Stack(
        children: [
          if (isUserHouse)
            Center(
              child: Container(
                width: 100 - (position * 10).toDouble(),
                height: 100 - (position * 10).toDouble(),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(.7),
                      blurRadius: 40,
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
}
