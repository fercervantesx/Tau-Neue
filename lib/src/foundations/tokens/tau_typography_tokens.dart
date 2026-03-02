import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// TAU NEUE tactical terminal typography token system.
///
/// Three distinct font families for different content types:
/// - Serif (Libre Caslon Display) for elegant titles and headers
/// - Monospace (IBM Plex Mono) for body text and data displays
/// - Wide/Extended (Zen Dots) for action buttons and emphasis
class TauTypographyTokens extends ThemeExtension<TauTypographyTokens> {
  const TauTypographyTokens({
    required this.titleSerif,
    required this.headingSerif,
    required this.bodyMono,
    required this.dataMono,
    required this.labelMono,
    required this.buttonWide,
  });

  // SERIF STYLES - Elegant titles and headers

  /// Large serif titles (e.g., "ONI").
  /// Classical elegant aesthetic for main headings.
  final TextStyle titleSerif;

  /// Section headers with serif font.
  /// For card headers and subheadings.
  final TextStyle headingSerif;

  // MONOSPACE STYLES - Body text and data

  /// Monospace body text for paragraphs.
  /// Terminal-style readable content.
  final TextStyle bodyMono;

  /// Monospace data display for technical information.
  /// System logs, timestamps, coordinates.
  final TextStyle dataMono;

  /// Monospace labels with tighter tracking for UI elements.
  /// Compact display (e.g., "AGENT", "CONTRACTS").
  final TextStyle labelMono;

  // WIDE/EXTENDED STYLES - Action buttons and emphasis

  /// Wide/extended bold text for prominent action buttons.
  /// Stretched aesthetic (e.g., "PURCHASE", "INITIALIZE").
  final TextStyle buttonWide;

  /// Standard typography preset using Google Fonts.
  static final TauTypographyTokens standard = TauTypographyTokens(
    // Serif - Elegant titles (Libre Caslon Display)
    titleSerif: GoogleFonts.libreCaslonDisplay(
      fontWeight: FontWeight.w700,
      fontSize: 32.0,
      height: 1.1,
      letterSpacing: 0.0,
    ),
    headingSerif: GoogleFonts.libreCaslonDisplay(
      fontWeight: FontWeight.w600,
      fontSize: 20.0,
      height: 1.2,
      letterSpacing: 0.0,
    ),

    // Monospace - Body and data (IBM Plex Mono)
    bodyMono: GoogleFonts.ibmPlexMono(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
      height: 1.5,
      letterSpacing: 0.0,
    ),
    dataMono: GoogleFonts.ibmPlexMono(
      fontWeight: FontWeight.w500,
      fontSize: 12.0,
      height: 1.3,
      letterSpacing: 0.0,
    ),
    labelMono: GoogleFonts.ibmPlexMono(
      fontWeight: FontWeight.w700,
      fontSize: 11.0,
      height: 1.2,
      letterSpacing: -1.0, // Tighter tracking for compact UI labels
    ),

    // Wide/Extended - Action buttons (Zen Dots)
    buttonWide: GoogleFonts.zenDots(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
      height: 1.2,
      letterSpacing: 1.0,
    ),
  );

  @override
  TauTypographyTokens copyWith({
    TextStyle? titleSerif,
    TextStyle? headingSerif,
    TextStyle? bodyMono,
    TextStyle? dataMono,
    TextStyle? labelMono,
    TextStyle? buttonWide,
  }) {
    return TauTypographyTokens(
      titleSerif: titleSerif ?? this.titleSerif,
      headingSerif: headingSerif ?? this.headingSerif,
      bodyMono: bodyMono ?? this.bodyMono,
      dataMono: dataMono ?? this.dataMono,
      labelMono: labelMono ?? this.labelMono,
      buttonWide: buttonWide ?? this.buttonWide,
    );
  }

  @override
  TauTypographyTokens lerp(
      ThemeExtension<TauTypographyTokens>? other, double t) {
    if (other is! TauTypographyTokens) {
      return this;
    }
    return TauTypographyTokens(
      titleSerif: TextStyle.lerp(titleSerif, other.titleSerif, t)!,
      headingSerif: TextStyle.lerp(headingSerif, other.headingSerif, t)!,
      bodyMono: TextStyle.lerp(bodyMono, other.bodyMono, t)!,
      dataMono: TextStyle.lerp(dataMono, other.dataMono, t)!,
      labelMono: TextStyle.lerp(labelMono, other.labelMono, t)!,
      buttonWide: TextStyle.lerp(buttonWide, other.buttonWide, t)!,
    );
  }
}
