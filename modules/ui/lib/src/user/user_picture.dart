import 'package:flutter/material.dart';

import '../../ui.dart';

class UserPicture extends StatelessWidget {
  const UserPicture({super.key, this.imageUrl, this.badgeName});

  final String? imageUrl;
  final String? badgeName;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: SizedBox.square(
        dimension: 130,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: context.colorScheme.onSurface,
                  width: 2,
                ),
              ),
              child: imageUrl != null
                  ? Image.network(imageUrl ?? '', fit: BoxFit.cover)
                  : const Icon(Icons.person_rounded, size: 50),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 60,
                height: 60,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: badgeName != null
                    ? Image.asset('profile_badges/$badgeName.png', package: 'assets', fit: BoxFit.contain)
                    : const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
