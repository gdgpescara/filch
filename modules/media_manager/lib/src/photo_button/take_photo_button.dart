import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

import '../../media_manager.dart';
import 'state/photo_button_cubit.dart';

class TakePhotoButton extends StatelessWidget {
  const TakePhotoButton({
    super.key,
    required this.onPhotoTaken,
    required this.photoType,
  });

  final VoidCallback onPhotoTaken;
  final PhotoType photoType;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhotoButtonCubit>(
      create: (context) => GetIt.I(),
      child: BlocConsumer<PhotoButtonCubit, PhotoButtonState>(
        listener: (context, state) {
          if (state is PhotoTaken) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  t.media_manager.take_picture.success,
                  style: context
                      .getTextTheme()
                      .bodyMedium
                      ?.copyWith(color: appColors.success.brightnessColor(context).onColorContainer),
                ),
                backgroundColor: appColors.success.seed,
                duration: const Duration(seconds: 15),
              ),
            );
            onPhotoTaken();
          }
        },
        builder: (context, state) {
          return ElevatedButton(
            onPressed: () => context.read<PhotoButtonCubit>().takePhoto(photoType),
            child: switch (state) {
              TakingPhoto() => const LoaderAnimation(),
              _ => Text(t.media_manager.take_picture.button),
            },
          );
        },
      ),
    );
  }
}
