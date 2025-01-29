import 'package:flutter/material.dart';
import 'package:pet_adoption/features/home/model/pet_model.dart';
import 'package:pet_adoption/features/home/screen/pet_detail_page.dart';
import 'package:pet_adoption/features/home/screen/home_screen.dart';
import 'package:pet_adoption/features/splash/splash_screen.dart'; // Import the splash screen

class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/';
  static const String secondScreen = '/second';
  static const String petDetail = '/petDetail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const RootApp());

      case petDetail:
        return MaterialPageRoute(
            builder: (_) => PetDetailScreen(
                  pet: settings.arguments as Pet,
                ));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
