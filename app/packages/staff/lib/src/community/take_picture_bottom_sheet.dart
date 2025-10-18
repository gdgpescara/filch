import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:media_manager/media_manager.dart';
import 'package:ui/ui.dart';

class TakePictureBottomSheet extends StatelessWidget {
  const TakePictureBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(Spacing.l),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.staff.take_picture.title,
                style: context.getTextTheme().titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: Spacing.m, width: double.infinity),
              Text(t.staff.take_picture.instructions, style: context.getTextTheme().bodyMedium),
              const SizedBox(height: Spacing.xl),
              TakePhotoButton(onPhotoTaken: () => Navigator.pop(context), photoType: PhotoType.communityQuest),
              const SizedBox(height: Spacing.xl),
            ],
          ),
        );
      },
    );
  }
}
