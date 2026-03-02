import 'package:flutter/widgets.dart';
import '../foundations/theme/tau_theme.dart';

/// TAU NEUE avatar component with tactical terminal aesthetic.
///
/// User/entity avatar with image, initials, or icon fallback.
/// Supports multiple sizes and shapes.
///
/// Example:
/// ```dart
/// TauAvatar(
///   initials: 'JD',
///   size: TauAvatarSize.medium,
/// )
/// ```
class TauAvatar extends StatelessWidget {
  const TauAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.icon,
    this.size = TauAvatarSize.medium,
    this.shape = TauAvatarShape.circle,
  });

  /// Image URL for avatar.
  final String? imageUrl;

  /// Initials to display (e.g., 'JD').
  final String? initials;

  /// Icon widget to display.
  final Widget? icon;

  /// Size of the avatar.
  final TauAvatarSize size;

  /// Shape of the avatar.
  final TauAvatarShape shape;

  @override
  Widget build(BuildContext context) {
    final colors = TauTheme.colorsOf(context);
    final typography = TauTheme.typographyOf(context);

    final sizeValue = size == TauAvatarSize.small
        ? 32.0
        : size == TauAvatarSize.medium
            ? 40.0
            : 48.0;

    final fontSize = size == TauAvatarSize.small
        ? 12.0
        : size == TauAvatarSize.medium
            ? 14.0
            : 16.0;

    final iconSize = size == TauAvatarSize.small
        ? 16.0
        : size == TauAvatarSize.medium
            ? 20.0
            : 24.0;

    Widget content;
    if (imageUrl != null) {
      content = Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          // Fallback to initials or icon
          return _buildFallback(colors, typography, fontSize, iconSize);
        },
      );
    } else {
      content = _buildFallback(colors, typography, fontSize, iconSize);
    }

    return Container(
      width: sizeValue,
      height: sizeValue,
      decoration: BoxDecoration(
        color: colors.surfaceElevated,
        border: Border.all(
          color: colors.borderSubtle,
          width: 1.0,
        ),
        shape: shape == TauAvatarShape.circle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: shape == TauAvatarShape.square ? BorderRadius.circular(6.0) : null,
      ),
      child: ClipRRect(
        borderRadius: shape == TauAvatarShape.circle
            ? BorderRadius.circular(sizeValue / 2)
            : BorderRadius.circular(6.0),
        child: content,
      ),
    );
  }

  Widget _buildFallback(
    dynamic colors,
    dynamic typography,
    double fontSize,
    double iconSize,
  ) {
    if (initials != null) {
      return Center(
        child: Text(
          initials!,
          style: typography.labelMono.copyWith(
            color: colors.textOnDark,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    } else if (icon != null) {
      return Center(
        child: IconTheme(
          data: IconThemeData(
            color: colors.textMuted,
            size: iconSize,
          ),
          child: icon!,
        ),
      );
    } else {
      // Default icon
      return Center(
        child: Icon(
          const IconData(0xe7fd, fontFamily: 'MaterialIcons'), // person
          color: colors.textMuted,
          size: iconSize,
        ),
      );
    }
  }
}

/// Size options for avatar.
enum TauAvatarSize {
  small,
  medium,
  large,
}

/// Shape options for avatar.
enum TauAvatarShape {
  circle,
  square,
}
