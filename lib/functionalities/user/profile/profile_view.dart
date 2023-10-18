import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../dependency_injection/dependency_injection.dart';
import '../../../i18n/strings.g.dart';
import 'state/profile_cubit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => injector(),
      child: BlocSelector<ProfileCubit, ProfileState, User>(
        selector: (state) {
          return state.user!;
        },
        builder: (context, user) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: context.read<ProfileCubit>().signOut,
                      child: Text(t.commons.buttons.sign_out.toUpperCase()),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 100,
                    height: 100,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onSurface,
                        width: 2,
                      ),
                    ),
                    child: user.photoURL != null
                        ? Image.network(user.photoURL ?? '')
                        : const Icon(Icons.person_rounded, size: 50),
                  ),
                  const SizedBox(height: 20),
                  Text(user.email ?? '', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 20),
                  Expanded(
                    child: QrImageView(
                      data: user.uid,
                      dataModuleStyle: QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.square,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      eyeStyle: QrEyeStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        eyeShape: QrEyeShape.square,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
