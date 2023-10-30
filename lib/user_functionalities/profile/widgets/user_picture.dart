import 'package:flutter/material.dart';

class UserPicture extends StatelessWidget {
  const UserPicture({super.key, this.imageUrl, this.house});

  final String? imageUrl;
  final String? house;

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
                  color: Theme.of(context).colorScheme.onSurface,
                  width: 2,
                ),
              ),
              child: imageUrl != null ? Image.network(imageUrl ?? '') : const Icon(Icons.person_rounded, size: 50),
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
                child: house != null
                    ? Image.asset(
                        'assets/images/houses/$house.png',
                        fit: BoxFit.contain,
                      )
                    : const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
