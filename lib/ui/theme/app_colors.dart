import 'package:flutter/material.dart';

class AppColors {
  const AppColors({
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.errorContainer,
    required this.onError,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.onInverseSurface,
    required this.inverseSurface,
    required this.inversePrimary,
    required this.shadow,
    // required this.primary,
    // required this.primaryVariant,
    // required this.onPrimary,
    // required this.secondary,
    // required this.secondaryVariant,
    // required this.onSecondary,
    // required this.background,
    // required this.onBackground,
    // required this.surface,
    // required this.onSurface,
    // required this.error,
    // required this.onError,
  });

  factory AppColors.light() {
    return const AppColors(
      primary: Color(0xFF96416A),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFFFD8E6),
      onPrimaryContainer: Color(0xFF3D0024),
      secondary: Color(0xFF735761),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFFED9E5),
      onSecondaryContainer: Color(0xFF2A151E),
      tertiary: Color(0xFF7E5538),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFFFDCC6),
      onTertiaryContainer: Color(0xFF301400),
      error: Color(0xFFBA1A1A),
      errorContainer: Color(0xFFFFDAD6),
      onError: Color(0xFFFFFFFF),
      onErrorContainer: Color(0xFF410002),
      background: Color(0xFFFFFBFF),
      onBackground: Color(0xFF1F1A1C),
      surface: Color(0xFFFFFBFF),
      onSurface: Color(0xFF1F1A1C),
      surfaceVariant: Color(0xFFF1DEE3),
      onSurfaceVariant: Color(0xFF504348),
      outline: Color(0xFF837378),
      onInverseSurface: Color(0xFFFAEEF0),
      inverseSurface: Color(0xFF352F31),
      inversePrimary: Color(0xFFFFB0D0),
      shadow: Color(0xFF000000),
      // primary: Color(0xFFFEDBD0),
      // primaryVariant: Color(0xFF442C2E),
      // onPrimary: Color(0xFF442C2E),
      // secondary: Color(0xFFFEEAE6),
      // secondaryVariant: Color(0xFF442C2E),
      // onSecondary: Color(0xFF442C2E),
      // background: Color(0xFFFFFFFF),
      // onBackground: Color(0xFF442C2E),
      // surface: Color(0xFFFFFBFA),
      // onSurface: Color(0xFF442C2E),
      // error: Color(0xFFC5032B),
      // onError: Color(0xFFFFFBFA),
    );
  }

  factory AppColors.dark() {
    return const AppColors(
      primary: Color(0xFFFFB0D0),
      onPrimary: Color(0xFF5C113A),
      primaryContainer: Color(0xFF792951),
      onPrimaryContainer: Color(0xFFFFD8E6),
      secondary: Color(0xFFE1BDC9),
      onSecondary: Color(0xFF412A33),
      secondaryContainer: Color(0xFF593F4A),
      onSecondaryContainer: Color(0xFFFED9E5),
      tertiary: Color(0xFFF1BB97),
      onTertiary: Color(0xFF49280F),
      tertiaryContainer: Color(0xFF633E23),
      onTertiaryContainer: Color(0xFFFFDCC6),
      error: Color(0xFFFFB4AB),
      errorContainer: Color(0xFF93000A),
      onError: Color(0xFF690005),
      onErrorContainer: Color(0xFFFFDAD6),
      background: Color(0xFF1F1A1C),
      onBackground: Color(0xFFEBE0E2),
      surface: Color(0xFF1F1A1C),
      onSurface: Color(0xFFEBE0E2),
      surfaceVariant: Color(0xFF504348),
      onSurfaceVariant: Color(0xFFD4C2C7),
      outline: Color(0xFF9D8C91),
      onInverseSurface: Color(0xFF1F1A1C),
      inverseSurface: Color(0xFFEBE0E2),
      inversePrimary: Color(0xFF96416A),
      shadow: Color(0xFF000000),
      // primary: Color(0xFFFEDBD0),
      // primaryVariant: Color(0xFF442C2E),
      // onPrimary: Color(0xFF442C2E),
      // secondary: Color(0xFFFEEAE6),
      // secondaryVariant: Color(0xFF442C2E),
      // onSecondary: Color(0xFF442C2E),
      // background: Color(0xFFFFFFFF),
      // onBackground: Color(0xFF442C2E),
      // surface: Color(0xFFFFFBFA),
      // onSurface: Color(0xFF442C2E),
      // error: Color(0xFFC5032B),
      // onError: Color(0xFFFFFBFA),
    );
  }

  /// Material Colors https://material.io/design/color/the-color-system.html#color-theme-creation
  // final Color primary;
  // final Color primaryVariant;
  // final Color onPrimary;
  // final Color secondary;
  // final Color secondaryVariant;
  // final Color onSecondary;
  // final Color background;
  // final Color onBackground;
  // final Color surface;
  // final Color onSurface;
  // final Color error;
  // final Color onError;
  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color errorContainer;
  final Color onError;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color onInverseSurface;
  final Color inverseSurface;
  final Color inversePrimary;
  final Color shadow;
}
