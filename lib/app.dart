import 'package:device_preview/device_preview.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:sizer/sizer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../ui/routes/app_route.gr.dart';
import '../ui/theme/app_theme.dart';

class MyApp extends HookConsumerWidget {
  MyApp({Key? key}) : super(key: key);
  final firebaseinitializerProvider = FutureProvider<FirebaseApp>((ref) async {
    return await Firebase.initializeApp();
  });

  final _appRouter = AppRouter();
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final themeMode = ref.watch(appThemeModeProvider);
    final appRouter = useMemoized(() => _appRouter);
    final initialize = ref.watch(firebaseinitializerProvider);

    return ResponsiveSizer(
      builder: (context, orientation, screenType) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        theme: theme.data,
        darkTheme: AppTheme.dark().data,
        themeMode: themeMode,
        locale: DevicePreview.locale(context),
        localizationsDelegates: L10n.localizationsDelegates,
        supportedLocales: L10n.supportedLocales,
        routerDelegate: appRouter.delegate(
          navigatorObservers: () => [
            FirebaseAnalyticsObserver(analytics: analytics),
          ],
        ),
        routeInformationParser: appRouter.defaultRouteParser(),
      ),
    );
  }
}
