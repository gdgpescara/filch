import 'package:flutter/material.dart';
import 'package:routefly/routefly.dart';
import 'package:sorting_ceremony/sorting_ceremony.dart' as sorting_ceremony;

import '../../application.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return sorting_ceremony.SortingCeremonyPage(onDone: () => Routefly.navigate(routePaths.path));
  }
}
