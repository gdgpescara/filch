import 'package:flutter/material.dart';
import 'package:user/user.dart';

import '../../widgets/gradient_background.dart';

class AllPointsPage extends StatelessWidget {
  const AllPointsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return UserPointsPage(backGroundBuilder: ({required child}) => GradientBackground(child: child));
  }
}
