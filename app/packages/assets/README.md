# Assets Package

Static assets package containing fonts, images, icons, and other media resources used across the Filch application.

## Package Structure

### Images

Application images and graphics:
  
- **backgrounds/** - Background images
  - `gradient_bg.png` - Main gradient background
  - `pattern_bg.png` - Pattern background for cards
  
- **illustrations/** - Illustration graphics
  - `quest_complete.png` - Quest completion illustration
  - `empty_state.png` - Empty state illustration
  - `error_state.png` - Error state illustration
  - `sorting_ceremony.png` - Sorting ceremony illustration

- **icons/** - Custom app icons
  - `quest_icon.png` - Quest icon
  - `points_icon.png` - Points icon
  - `ranking_icon.png` - Ranking icon
  - `house_icons/` - House-specific icons
    - `pytherin.png` - Pytherin house icon
    - `kerasdor.png` - Kerasdor house icon
    - `dashclaw.png` - Dashclaw house icon
    - `gopherpuff.png` - Gopherpuff house icon

- **avatars/** - Default avatar images
  - `default_avatar.png` - Default user avatar
  - `staff_avatar.png` - Default staff avatar

### Fonts

Custom fonts for the application:

- **Roboto/** - Primary font family
  - `Roboto-Regular.ttf`
  - `Roboto-Medium.ttf`
  - `Roboto-Bold.ttf`
  - `Roboto-Light.ttf`

- **Poppins/** - Secondary font family
  - `Poppins-Regular.ttf`
  - `Poppins-SemiBold.ttf`
  - `Poppins-Bold.ttf`

### Animations

Lottie animation files:

- **lottie/** - Animation assets
  - `loading.json` - Loading animation
  - `success.json` - Success animation
  - `error.json` - Error animation
  - `confetti.json` - Celebration animation
  - `sorting_hat.json` - Sorting ceremony animation

### Audio

Sound effects and audio files:

- **sounds/** - Sound effects
  - `quest_complete.mp3` - Quest completion sound
  - `notification.mp3` - Notification sound
  - `button_tap.mp3` - Button tap sound
  - `success.mp3` - Success sound
  - `error.mp3` - Error sound

### Configuration

Asset configuration and manifest files:

- `pubspec.yaml` - Package configuration
- `asset_manifest.dart` - Generated asset paths

## Asset Constants

### Image Paths

```dart
class AppImages {
  // Logos
  static const String filchLogo = 'packages/assets/images/logos/filch_logo.png';
  static const String filchLogoWhite = 'packages/assets/images/logos/filch_logo_white.png';
  static const String devfestLogo = 'packages/assets/images/logos/devfest_logo.png';
  
  // Backgrounds
  static const String gradientBg = 'packages/assets/images/backgrounds/gradient_bg.png';
  static const String patternBg = 'packages/assets/images/backgrounds/pattern_bg.png';
  
  // Illustrations
  static const String questComplete = 'packages/assets/images/illustrations/quest_complete.png';
  static const String emptyState = 'packages/assets/images/illustrations/empty_state.png';
  static const String errorState = 'packages/assets/images/illustrations/error_state.png';
  static const String sortingCeremony = 'packages/assets/images/illustrations/sorting_ceremony.png';
  
  // House Icons
  static const String pytherin = 'packages/assets/images/icons/house_icons/pytherin.png';
  static const String kerasdor = 'packages/assets/images/icons/house_icons/kerasdor.png';
  static const String dashclaw = 'packages/assets/images/icons/house_icons/dashclaw.png';
  static const String gopherpuff = 'packages/assets/images/icons/house_icons/gopherpuff.png';
  
  // Avatars
  static const String defaultAvatar = 'packages/assets/images/avatars/default_avatar.png';
  static const String staffAvatar = 'packages/assets/images/avatars/staff_avatar.png';
}
```

### Font Families

```dart
class AppFonts {
  static const String roboto = 'Roboto';
  static const String poppins = 'Poppins';
}
```

### Animation Paths

```dart
class AppAnimations {
  static const String loading = 'packages/assets/animations/lottie/loading.json';
  static const String success = 'packages/assets/animations/lottie/success.json';
  static const String error = 'packages/assets/animations/lottie/error.json';
  static const String confetti = 'packages/assets/animations/lottie/confetti.json';
  static const String sortingHat = 'packages/assets/animations/lottie/sorting_hat.json';
}
```

### Sound Paths

```dart
class AppSounds {
  static const String questComplete = 'packages/assets/sounds/quest_complete.mp3';
  static const String notification = 'packages/assets/sounds/notification.mp3';
  static const String buttonTap = 'packages/assets/sounds/button_tap.mp3';
  static const String success = 'packages/assets/sounds/success.mp3';
  static const String error = 'packages/assets/sounds/error.mp3';
}
```

## Usage

### Loading Images

```dart
import 'package:assets/assets.dart';

// Using Image widget
Image.asset(AppImages.filchLogo)

// Using decoration
Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage(AppImages.gradientBg),
      fit: BoxFit.cover,
    ),
  ),
)

// Using NetworkImage with fallback
FadeInImage.assetNetwork(
  placeholder: AppImages.defaultAvatar,
  image: user.photoURL ?? '',
  fit: BoxFit.cover,
)
```

### Using Fonts

```dart
Text(
  'Hello World',
  style: TextStyle(
    fontFamily: AppFonts.roboto,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
)
```

### Loading Animations

```dart
import 'package:lottie/lottie.dart';

Lottie.asset(
  AppAnimations.loading,
  width: 100,
  height: 100,
  repeat: true,
)
```

### Playing Sounds

```dart
import 'package:audioplayers/audioplayers.dart';

final player = AudioPlayer();
await player.play(AssetSource(AppSounds.questComplete));
```

## Asset Optimization

### Image Optimization

- **PNG files**: Optimized with pngquant
- **JPG files**: Compressed with quality 85-90%
- **Multiple densities**: 1x, 2x, 3x variants provided
- **SVG support**: Vector graphics for scalable icons

### Font Optimization

- **Subset fonts**: Only include necessary character sets
- **Web fonts**: Optimized for Flutter web
- **Font display**: Uses font-display: swap for better performance

### Animation Optimization

- **Lottie files**: Optimized for smaller file sizes
- **Frame rate**: Adjusted for smooth performance
- **Preloading**: Critical animations preloaded

## Asset Guidelines

### Image Guidelines

1. **Naming Convention**
   - Use snake_case for file names
   - Include size suffix for variants (e.g., `icon_24.png`)
   - Use descriptive names

2. **File Formats**
   - PNG for images with transparency
   - JPG for photos and complex images
   - SVG for simple icons and illustrations

3. **Sizes**
   - Provide 1x, 2x, 3x density variants
   - Use appropriate resolutions for target platforms

### Font Guidelines

1. **Font Selection**
   - Ensure licenses allow commercial use
   - Test readability across different sizes
   - Consider loading performance

2. **Font Loading**
   - Preload critical fonts
   - Use font fallbacks
   - Optimize font file sizes

### Animation Guidelines

1. **Performance**
   - Keep file sizes under 500KB
   - Optimize frame rates (30fps max)
   - Use appropriate compression

2. **Design**
   - Follow Material Design motion principles
   - Ensure animations enhance UX
   - Provide reduced motion options

## Code Generation

### Asset Generation

The package uses code generation to create type-safe asset references:

```bash
dart run build_runner build
```

This generates:

- `lib/src/generated/assets.gen.dart` - Type-safe asset references
- Asset constant classes
- Helper methods for asset loading

### Generated Usage

```dart
// Generated asset references
Assets.images.logos.filchLogo // Returns asset path
Assets.fonts.roboto // Returns font family name
Assets.animations.loading // Returns animation path
```

## Dependencies

- `flutter` - Core Flutter framework
- `lottie` - Lottie animation support
- `flutter_svg` - SVG image support

## Exported Assets

All assets are exported through the main library file and can be imported as:

```dart
import 'package:assets/assets.dart';
```

This provides access to:

- `AppImages` - Image asset paths
- `AppFonts` - Font family names
- `AppAnimations` - Animation asset paths
- `AppSounds` - Sound asset paths
- Generated asset classes (if using code generation)

## Asset Management

### Adding New Assets

1. Place asset files in appropriate directories
2. Update `pubspec.yaml` asset declarations
3. Add constants to relevant classes
4. Run code generation if applicable
5. Update documentation

### Asset Versioning

- Version assets when making breaking changes
- Use semantic versioning for the package
- Maintain backward compatibility when possible

### Performance Considerations

- Monitor asset bundle size
- Use asset variants for different screen densities
- Implement lazy loading for non-critical assets
- Consider using network images for large assets
