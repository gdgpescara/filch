import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../dependency_injection/dependency_injection.dart';
import '../../../i18n/strings.g.dart';
import 'state/profile_cubit.dart';
import 'widgets/user_picture.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => injector()..init(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
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
                  UserPicture(imageUrl: state.user?.photoURL, house: state.house),
                  const SizedBox(height: 20),
                  Text(state.user?.email ?? '', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 20),
                  Expanded(
                    child: QrImageView(
                      data: state.user?.uid ?? '',
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
