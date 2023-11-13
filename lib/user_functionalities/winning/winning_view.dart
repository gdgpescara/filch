import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common_functionalities/models/house_detail.dart';
import '../../common_functionalities/widgets/app_card.dart';
import '../../common_functionalities/widgets/dark_map_container.dart';
import '../../common_functionalities/widgets/loader_animation.dart';
import '../../dependency_injection/dependency_injection.dart';
import '../../i18n/strings.g.dart';
import 'state/winner_house_cubit.dart';

class WinningView extends StatelessWidget {
  const WinningView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DarkMapContainer(
          child: BlocProvider<WinnerHouseCubit>(
            create: (_) => injector()..loadHouse(),
            child: Builder(
              builder: (context) {
                return BlocBuilder<WinnerHouseCubit, WinnerHouseState>(
                  builder: (context, state) {
                    return switch (state) {
                      WinnerHouseLoading() => const Center(child: LoaderAnimation()),
                      WinnerHouseFailure() => Center(child: Text(t.commons.errors.generic_retry)),
                      WinnerHouseLoaded() => WinnerHouseViewContent(house: state.house),
                    };
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class WinnerHouseViewContent extends StatefulWidget {
  const WinnerHouseViewContent({
    super.key,
    required this.house,
  });

  final HouseDetail house;

  @override
  State<WinnerHouseViewContent> createState() => _WinnerHouseViewContentState();
}

class _WinnerHouseViewContentState extends State<WinnerHouseViewContent> {
  final _confettiController = ConfettiController(duration: const Duration(seconds: 2));

  @override
  void initState() {
    super.initState();
    _confettiController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.only(
            top: 32,
            right: 16,
            bottom: 16,
            left: 16,
          ),
          children: [
            Center(
              child: Image.asset(
                'assets/images/houses/${widget.house.id}.png',
                width: MediaQuery.sizeOf(context).width / 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Points: ${widget.house.points}',
                style: GoogleFonts.jetBrainsMono(fontSize: 30),
              ),
            ),
            const SizedBox(height: 32),
            ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemCount: widget.house.members.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final member = widget.house.members[index];
                return AppCard(
                  child: Row(
                    children: [
                      const CircleAvatar(radius: 20),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          member.displayName ?? member.email,
                          style: GoogleFonts.jetBrainsMono(fontSize: 20),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '${member.points ?? 0} pt',
                        style: GoogleFonts.jetBrainsMono(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ConfettiThrower(controller: _confettiController),
                ConfettiThrower(controller: _confettiController),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }
}

class ConfettiThrower extends StatelessWidget {
  const ConfettiThrower({
    required this.controller,
    super.key,
  });

  final ConfettiController controller;

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      maximumSize: const Size(20, 10),
      minimumSize: const Size(10, 5),
      confettiController: controller,
      numberOfParticles: 200,
      maxBlastForce: 150,
      minBlastForce: 70,
      blastDirectionality: BlastDirectionality.explosive,
    );
  }
}
