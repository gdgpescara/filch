import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common_functionalities/widgets/app_card.dart';
import '../../common_functionalities/widgets/dark_map_container.dart';
import '../../common_functionalities/widgets/loader_animation.dart';
import '../../dependency_injection/dependency_injection.dart';
import '../../i18n/strings.g.dart';
import 'state/winner_house_cubit.dart';

class WinningView extends StatefulWidget {
  const WinningView({super.key});

  @override
  State<WinningView> createState() => _WinningViewState();
}

class _WinningViewState extends State<WinningView> {
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
                      WinnerHouseLoading() =>
                        const Center(child: LoaderAnimation()),
                      WinnerHouseFailure() =>
                        Center(child: Text(t.commons.errors.generic_retry)),
                      WinnerHouseLoaded() => const WinnerHouseViewContent(),
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
  const WinnerHouseViewContent({super.key});

  @override
  State<WinnerHouseViewContent> createState() => _WinnerHouseViewContentState();
}

class _WinnerHouseViewContentState extends State<WinnerHouseViewContent> {
  final _confettiController =
      ConfettiController(duration: const Duration(seconds: 2));

  @override
  void initState() {
    _confettiController.play();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 32,
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/houses/dashclaw.png',
                      width: MediaQuery.sizeOf(
                            context,
                          ).width /
                          1.5,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Points: ${Random().nextInt(10000)}',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList.builder(
              itemCount: 100,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: AppCard(
                    child: Row(
                      children: [
                        const CircleAvatar(radius: 20),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            'Username',
                            style: GoogleFonts.jetBrainsMono(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '${Random().nextInt(10000)} pt',
                          style: GoogleFonts.jetBrainsMono(),
                        ),
                      ],
                    ),
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
  const ConfettiThrower({required this.controller, super.key});
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
