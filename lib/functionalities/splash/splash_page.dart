import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dependency_injection/dependency_injection.dart';
import '../_shared/widgets/loader_animation.dart';
import '../_shared/widgets/logo.dart';
import '../home/home_page.dart';
import '../sign_in/sign_in_page.dart';
import '../sorting_ceremony/sorting_ceremony_page.dart';
import 'state/splash_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const routeName = 'splash';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (context) => injector()..init(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) async {
          switch (state) {
            case UserLoggedOut():
              await Navigator.of(context).pushNamed<void>(SignInPage.routeName);
              if (mounted) {
                await context.read<SplashCubit>().init();
              }
              break;
            case UserNeedSortingCeremony():
              if (mounted) {
                await Navigator.of(context).pushNamed<void>(SortingCeremonyPage.routeName);
                if (mounted) {
                  await context.read<SplashCubit>().init();
                }
              }
              break;
            case AppCanRun():
              if (mounted) {
                await Navigator.of(context).pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
              }
              break;
            case SplashLoading():
              break;
          }
        },
        child: Scaffold(
          body: DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/old_map_light.png'),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Logo.dark(),
                const SizedBox(height: 16),
                const LoaderAnimation(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
