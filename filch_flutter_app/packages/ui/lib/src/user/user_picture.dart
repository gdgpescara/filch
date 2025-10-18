import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import '../../ui.dart';

class UserPicture extends StatelessWidget {
  const UserPicture({super.key, this.imageUrl, this.teamImageUrl});

  final String? imageUrl;
  final String? teamImageUrl;

  static const double _totalSize = 140;
  static const double _borderSize = 110;
  static const double _borderWidth = 3;
  static const double _badgeSize = 65;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: SizedBox.square(
        dimension: _totalSize,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _buildGradientBorder(context),
            if (teamImageUrl != null) _buildBadge(context),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientBorder(BuildContext context) {
    return Container(
      width: _borderSize,
      height: _borderSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: SweepGradient(
          colors: [
            appColors.googleBlue.seed,
            appColors.googleRed.seed,
            appColors.googleYellow.seed,
            appColors.googleGreen.seed,
            appColors.googleBlue.seed,
          ],
          stops: const [0.0, 0.25, 0.50, 0.75, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: appColors.googleBlue.seed.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(_borderWidth),
        child: _buildProfileImage(context),
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.colorScheme.surface,
      ),
      child: imageUrl != null
          ? Semantics(
              label: t.common.user.image.semantic,
              child: CachedNetworkImage(
                imageUrl: imageUrl!,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => _buildPlaceholder(context),
              ),
            )
          : _buildPlaceholder(context),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    return ColoredBox(
      color: context.colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.person_rounded,
        size: 50,
        color: context.colorScheme.onSurface.withValues(alpha: 0.5),
      ),
    );
  }

  Widget _buildBadge(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: Container(
        width: _badgeSize,
        height: _badgeSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.colorScheme.surface,
          border: Border.all(
            color: context.colorScheme.outline.withValues(alpha: 0.2),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.shadow.withValues(alpha: 0.15),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: ClipOval(
            child: ExcludeSemantics(
              child: CachedNetworkImage(
                imageUrl: teamImageUrl!,
                fit: BoxFit.contain,
                errorWidget: (context, error, stackTrace) => Icon(
                  Icons.star_rounded,
                  color: context.colorScheme.primary,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
