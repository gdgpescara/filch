import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common_functionalities/models/house_detail.dart';
import 'confetti_animation_container.dart';
import 'member_item.dart';

class WinnerHouseViewContent extends StatelessWidget {
  const WinnerHouseViewContent({
    super.key,
    required this.house,
  });

  final HouseDetail house;

  @override
  Widget build(BuildContext context) {
    return ConfettiAnimationContainer(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Image.asset(
              'assets/images/houses/${house.id}.png',
              width: MediaQuery.sizeOf(context).width * 0.5,
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              house.points.toString(),
              style: GoogleFonts.jetBrainsMono(fontSize: Theme.of(context).textTheme.displayMedium?.fontSize),
            ),
          ),
          const SizedBox(height: 32),
          ListView.separated(
            shrinkWrap: true,
            primary: false,
            itemCount: house.members.length,
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) => MemberItem(house.members[index], position: index + 1),
          ),
        ],
      ),
    );
  }
}
