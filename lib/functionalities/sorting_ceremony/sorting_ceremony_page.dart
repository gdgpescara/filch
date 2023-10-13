import 'package:flutter/material.dart';

import '../../dependency_injection/dependency_injection.dart';
import '../user/domain/use_cases/sign_out_use_case.dart';

class SortingCeremonyPage extends StatelessWidget {
  const SortingCeremonyPage({super.key});

  static const routeName = 'sorting_ceremony';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Column(
          children: [
            const Text('SortingCeremonyPage'),
            const Spacer(),
            ElevatedButton(
              onPressed: injector<SignOutUseCase>(),
              child: const Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
