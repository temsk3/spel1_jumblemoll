import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app_colors.dart';
import 'app_text_theme.dart';
import 'color_schemes.g.dart';

final appThemeModeProvider =
    StateNotifierProvider<StateController<ThemeMode>, ThemeMode>(
  (ref) => StateController(ThemeMode.system),
);

final appThemeProvider = Provider<AppTheme>(
  (ref) {
    final mode = ref.watch(appThemeModeProvider);
    switch (mode) {
      case ThemeMode.dark:
        return AppTheme.dark();
      case ThemeMode.light:
      default:
        return AppTheme.light();
    }
  },
);

class AppTheme {
  AppTheme({
    required this.mode,
    required this.data,
    required this.textTheme,
    required this.appColors,
  });

  factory AppTheme.light() {
    const mode = ThemeMode.light;
    final appColors = AppColors.light();
    final themeData = ThemeData.light().copyWith(
      // useMaterial3: true,
      colorScheme: lightColorScheme,
      brightness: Brightness.light,
      scaffoldBackgroundColor: appColors.background,
      textTheme: GoogleFonts.notoSansTextTheme(ThemeData.light().textTheme),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: appColors.error,
        behavior: SnackBarBehavior.floating,
      ),
      // tabBarTheme: TabBarTheme(
      //   indicator: BoxDecoration(
      //     border: Border(
      //       bottom: BorderSide(
      //         color: appColors.onPrimaryContainer,
      //         width: 2.5,
      //       ),
      //     ),
      //   ),
      // ),
      tabBarTheme: TabBarTheme(
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: appColors.onPrimary,
              width: 2.5,
            ),
          ),
        ),
      ),
      // primaryColor: appColors.surface,
      primaryColor: appColors.primary,
      // primaryTextTheme:
      //     GoogleFonts.notoSansTextTheme(ThemeData.light().textTheme),
      // dialogTheme:
      //     DialogTheme(titleTextStyle: TextStyle(color: appColors.onPrimary)),
      backgroundColor: appColors.background,
    );
    return AppTheme(
      mode: mode,
      data: themeData,
      textTheme: AppTextTheme(),
      appColors: appColors,
    );
  }

  factory AppTheme.dark() {
    const mode = ThemeMode.dark;
    final appColors = AppColors.dark();
    final themeData = ThemeData.dark().copyWith(
      // useMaterial3: true,
      colorScheme: darkColorScheme,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: appColors.background,
      textTheme: GoogleFonts.notoSansTextTheme(ThemeData.dark().textTheme),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: appColors.error,
        behavior: SnackBarBehavior.floating,
      ),
      // tabBarTheme: TabBarTheme(
      //   indicator: BoxDecoration(
      //     border: Border(
      //       bottom: BorderSide(
      //         color: appColors.onPrimaryContainer,
      //         width: 2.5,
      //       ),
      //     ),
      //   ),
      // ),
      tabBarTheme: TabBarTheme(
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: appColors.onPrimary,
              width: 2.5,
            ),
          ),
        ),
      ),
      // primaryColor: appColors.surface,
      primaryColor: appColors.primary,
      // primaryTextTheme:
      //     GoogleFonts.notoSansTextTheme(ThemeData.dark().textTheme),
      // dialogTheme:
      //     DialogTheme(titleTextStyle: TextStyle(color: appColors.onPrimary)),
      backgroundColor: appColors.background,
    );
    return AppTheme(
      mode: mode,
      data: themeData,
      textTheme: AppTextTheme(),
      appColors: appColors,
    );
  }

  final ThemeMode mode;
  final ThemeData data;
  final AppTextTheme textTheme;
  final AppColors appColors;
}
