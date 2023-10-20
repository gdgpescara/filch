import 'package:flutter/cupertino.dart';
import 'package:rive/rive.dart';

class LoaderAnimation extends StatelessWidget {
  const LoaderAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 295,
      width: 20,
      child: RiveAnimation.asset(
        'assets/animations/loader.riv',
        animations: ['bounce'],
        fit: BoxFit.cover,
      ),
    );
  }
}
