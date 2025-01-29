import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pet_adoption/navigation/app_navigation_service.dart';
import 'package:pet_adoption/navigation/app_routes.dart';
import 'package:pet_adoption/state/theme_notifier.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final appNavigationService = AppNavigationService();
  final ThemeNotifier themeNotifier = ThemeNotifier();
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeNotifier,
      builder: (context, child) {
        return MaterialApp(
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
              PointerDeviceKind.stylus,
              PointerDeviceKind.unknown
            },
          ),
          navigatorKey: appNavigationService.myNavigatorKey,
          title: 'Multilingual App',
          theme: themeNotifier.themeData,
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppRoutes.generateRoute,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}
