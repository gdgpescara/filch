# UI Package

UI components package providing reusable widgets, theme management, and design system components for the Filch application.

## Theme Management

### AppTheme

Centralized theme configuration supporting light and dark modes.

```dart
class AppTheme {
  static ThemeData lightTheme;     // Light theme configuration
  static ThemeData darkTheme;      // Dark theme configuration
  static ColorScheme lightColors;  // Light color scheme
  static ColorScheme darkColors;   // Dark color scheme
}
```

### Colors

Brand color palette:

```dart
class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF1976D2);
  static const Color primaryDark = Color(0xFF1565C0);
  static const Color accent = Color(0xFFFF5722);
  
  // Semantic colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  
  // Neutral colors
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF212121);
}
```

### Typography

Text styles following Material Design guidelines:

```dart
class AppTextStyles {
  static const TextStyle headline1;    // 32px, Bold
  static const TextStyle headline2;    // 28px, Bold  
  static const TextStyle headline3;    // 24px, SemiBold
  static const TextStyle body1;        // 16px, Regular
  static const TextStyle body2;        // 14px, Regular
  static const TextStyle caption;      // 12px, Regular
  static const TextStyle button;       // 14px, Medium
}
```

## Core Components

### Buttons

#### PrimaryButton

Main action button with consistent styling.

```dart
PrimaryButton(
  text: 'Continue',
  onPressed: () => handleAction(),
  isLoading: false,
  isEnabled: true,
  icon: Icons.arrow_forward,
)
```

#### SecondaryButton

Secondary action button.

```dart
SecondaryButton(
  text: 'Cancel',
  onPressed: () => goBack(),
  variant: ButtonVariant.outlined,
)
```

#### IconButton

Custom icon button with consistent styling.

```dart
AppIconButton(
  icon: Icons.settings,
  onPressed: () => openSettings(),
  size: IconButtonSize.medium,
)
```

### Cards

#### InfoCard

Information display card.

```dart
InfoCard(
  title: 'Quest Details',
  content: 'Complete this challenge to earn points',
  icon: Icons.info,
  actions: [
    CardAction(text: 'Start', onTap: () => startQuest()),
  ],
)
```

#### StatsCard

Statistics display card.

```dart
StatsCard(
  title: 'Total Points',
  value: '1,250',
  subtitle: '+50 today',
  icon: Icons.trending_up,
  color: AppColors.success,
)
```

#### QuestCard

Quest information card.

```dart
QuestCard(
  quest: quest,
  onTap: () => openQuest(quest),
  showProgress: true,
  showPoints: true,
)
```

### Input Components

#### AppTextField

Styled text input field.

```dart
AppTextField(
  label: 'Email',
  placeholder: 'Enter your email',
  validator: (value) => validateEmail(value),
  textInputType: TextInputType.emailAddress,
  prefixIcon: Icons.email,
)
```

#### AppDropdown

Dropdown selection component.

```dart
AppDropdown<String>(
  label: 'Select Option',
  value: selectedValue,
  items: options,
  onChanged: (value) => updateSelection(value),
)
```

#### AppCheckbox

Custom checkbox component.

```dart
AppCheckbox(
  value: isChecked,
  onChanged: (value) => toggleCheck(value),
  label: 'Accept terms',
)
```

### Navigation

#### AppBottomNavigation

Bottom navigation bar with consistent styling.

```dart
AppBottomNavigation(
  currentIndex: currentIndex,
  onTap: (index) => navigateToPage(index),
  items: [
    BottomNavItem(icon: Icons.home, label: 'Home'),
    BottomNavItem(icon: Icons.list, label: 'Quests'),
    BottomNavItem(icon: Icons.leaderboard, label: 'Ranking'),
    BottomNavItem(icon: Icons.person, label: 'Profile'),
  ],
)
```

#### AppAppBar

Custom app bar with consistent styling.

```dart
AppAppBar(
  title: 'Quest Details',
  showBackButton: true,
  actions: [
    AppBarAction(icon: Icons.share, onTap: () => shareQuest()),
  ],
)
```

### Feedback Components

#### LoadingWidget

Loading indicator with optional message.

```dart
LoadingWidget(
  message: 'Loading quests...',
  size: LoadingSize.medium,
)
```

#### ErrorWidget

Error display component.

```dart
AppErrorWidget(
  message: 'Failed to load data',
  onRetry: () => retryAction(),
  showRetryButton: true,
)
```

#### EmptyStateWidget

Empty state display.

```dart
EmptyStateWidget(
  title: 'No Quests Available',
  subtitle: 'Check back later for new challenges',
  icon: Icons.search,
  action: EmptyStateAction(
    text: 'Refresh',
    onTap: () => refresh(),
  ),
)
```

#### SuccessWidget

Success feedback component.

```dart
SuccessWidget(
  title: 'Quest Completed!',
  message: 'You earned 100 points',
  icon: Icons.check_circle,
  onContinue: () => goToDashboard(),
)
```

### Layout Components

#### AppScaffold

Consistent scaffold wrapper.

```dart
AppScaffold(
  title: 'Dashboard',
  body: dashboardContent,
  bottomNavigationBar: bottomNav,
  floatingActionButton: fab,
)
```

#### ContentContainer

Content container with consistent padding.

```dart
ContentContainer(
  child: Column(children: widgets),
  padding: EdgeInsets.all(16),
)
```

#### SectionHeader

Section header component.

```dart
SectionHeader(
  title: 'Active Quests',
  subtitle: 'Complete these challenges',
  action: HeaderAction(
    text: 'View All',
    onTap: () => viewAllQuests(),
  ),
)
```

### Specialized Widgets

#### UserAvatar

User profile avatar with fallback.

```dart
UserAvatar(
  imageUrl: user.photoURL,
  displayName: user.displayName,
  size: AvatarSize.large,
  showOnlineBadge: true,
)
```

#### PointsDisplay

Points display component.

```dart
PointsDisplay(
  points: 1250,
  showAnimation: true,
  variant: PointsVariant.large,
)
```

#### RankingItem

Ranking list item component.

```dart
RankingItem(
  user: user,
  position: 5,
  points: 950,
  onTap: () => viewProfile(user),
)
```

#### QuestTimer

Quest countdown timer.

```dart
QuestTimer(
  endTime: quest.endTime,
  onTimeUp: () => handleTimeUp(),
  showWarning: true,
)
```

#### ProgressIndicator

Custom progress indicator.

```dart
AppProgressIndicator(
  progress: 0.6,
  color: AppColors.primary,
  showPercentage: true,
  height: 8,
)
```

## Responsive Design

### Breakpoints

```dart
class Breakpoints {
  static const double mobile = 600;
  static const double tablet = 900;
  static const double desktop = 1200;
}
```

### ResponsiveBuilder

Responsive layout builder.

```dart
ResponsiveBuilder(
  mobile: (context) => MobileLayout(),
  tablet: (context) => TabletLayout(),
  desktop: (context) => DesktopLayout(),
)
```

## Animation & Transitions

### Custom Animations

- **FadeInAnimation** - Fade in transition
- **SlideInAnimation** - Slide in transition
- **ScaleAnimation** - Scale transition
- **RotationAnimation** - Rotation transition

### Page Transitions

```dart
PageTransition.slideInFromRight(
  child: NextPage(),
  duration: Duration(milliseconds: 300),
)
```

## Icons & Images

### Custom Icons

```dart
class AppIcons {
  static const IconData quest = Icons.assignment;
  static const IconData points = Icons.star;
  static const IconData ranking = Icons.leaderboard;
  static const IconData achievement = Icons.emoji_events;
}
```

### Image Components

#### AppImage

Image component with loading and error states.

```dart
AppImage(
  imageUrl: imageUrl,
  width: 200,
  height: 150,
  fit: BoxFit.cover,
  placeholder: LoadingWidget(),
  errorWidget: ErrorImageWidget(),
)
```

#### AppNetworkImage

Network image with caching.

```dart
AppNetworkImage(
  url: imageUrl,
  cacheKey: 'user_avatar_123',
  fadeInDuration: Duration(milliseconds: 300),
)
```

## Features

### Implemented Functionality

- Comprehensive design system
- Responsive design support
- Dark/light theme support
- Custom animations and transitions
- Accessibility support
- Consistent spacing and typography
- Reusable component library
- Custom icons and imagery

### Exported Functionality

- Theme configuration
- Core UI components (buttons, cards, inputs)
- Navigation components
- Feedback components (loading, error, success)
- Layout components
- Specialized app-specific widgets
- Animation utilities
- Responsive design helpers

### Design System

- Color palette with semantic colors
- Typography scale
- Spacing system (8px grid)
- Component variants and sizes
- Consistent interaction patterns
- Accessibility guidelines

## Dependencies

- `flutter` - Core Flutter framework
- `google_fonts` - Custom fonts
- `cached_network_image` - Image caching
- `lottie` - Lottie animations
- `flutter_svg` - SVG support

## Usage

```dart
import 'package:ui/ui.dart';

// Apply theme
MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  home: HomePage(),
)

// Use components
Column(
  children: [
    AppAppBar(title: 'Dashboard'),
    ContentContainer(
      child: Column(
        children: [
          SectionHeader(title: 'Active Quests'),
          QuestCard(quest: currentQuest),
          PrimaryButton(
            text: 'Start Quest',
            onPressed: () => startQuest(),
          ),
        ],
      ),
    ),
  ],
)

// Responsive design
ResponsiveBuilder(
  mobile: (context) => MobileQuestCard(quest),
  tablet: (context) => TabletQuestCard(quest),
)

// Custom styling
Container(
  padding: AppSpacing.medium,
  decoration: BoxDecoration(
    color: AppColors.surface,
    borderRadius: AppBorderRadius.medium,
  ),
  child: Text(
    'Quest Description',
    style: AppTextStyles.body1,
  ),
)
```
