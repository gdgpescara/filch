import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import '../../ui.dart';

class UserPicture extends StatelessWidget {
  const UserPicture({super.key, this.imageUrl, this.badgeImageName});

  final String? imageUrl;
  final String? badgeImageName;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: SizedBox.square(
        dimension: 130,
        child: Stack(
          alignment: Alignment.center,
          children: [
            DecoratedBox(
              decoration: OuterShadowDecoration(
                color: context.colorScheme.primary,
                radius: BorderRadius.circular(RadiusSize.m),
                blurRadius: 5,
              ),
              child: Container(
                width: 100,
                height: 100,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(RadiusSize.m))),
                child:
                    imageUrl != null
                        ? Image.network(imageUrl ?? '', fit: BoxFit.cover, semanticLabel: t.common.user.image.semantic)
                        : const Icon(Icons.person_rounded, size: 50),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 60,
                height: 60,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child:
                    badgeImageName != null
                        ? Image.asset('profile_badges/$badgeImageName.png', package: 'assets', fit: BoxFit.contain)
                        : const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
