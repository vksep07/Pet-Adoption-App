import 'package:flutter/material.dart';
import 'package:pet_adoption/navigation/app_navigation_service.dart';

class AppTextStyle {
  static BuildContext get context => AppNavigationService().currentContext;

  static TextStyle displayLarge() {
    return Theme.of(context).textTheme.displayLarge!;
  }

  static TextStyle displayMedium() {
    return Theme.of(context).textTheme.displayMedium!;
  }

  static TextStyle displaySmall() {
    return Theme.of(context).textTheme.displaySmall!;
  }

  static TextStyle headlineLarge() {
    return Theme.of(context).textTheme.headlineLarge!;
  }

  static TextStyle headlineMedium() {
    return Theme.of(context).textTheme.headlineMedium!;
  }

  static TextStyle headlineSmall() {
    return Theme.of(context).textTheme.headlineSmall!;
  }

  static TextStyle titleLarge() {
    return Theme.of(context).textTheme.titleLarge!;
  }

  static TextStyle titleMedium() {
    return Theme.of(context).textTheme.titleMedium!;
  }

  static TextStyle titleSmall() {
    return Theme.of(context).textTheme.titleSmall!;
  }

  static TextStyle bodyLarge() {
    return Theme.of(context).textTheme.bodyLarge!;
  }

  static TextStyle bodyMedium() {
    return Theme.of(context).textTheme.bodyMedium!;
  }

  static TextStyle bodySmall() {
    return Theme.of(context).textTheme.bodySmall!;
  }

  // Custom font styles
  static TextStyle customHeader() {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto', // Replace with your custom font
      color: Theme.of(context).primaryColor,
    );
  }

  static TextStyle customBody() {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      fontFamily: 'Roboto', // Replace with your custom font
      color: Theme.of(context).textTheme.bodyMedium!.color,
    );
  }

  static TextStyle customButtonText() {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto', // Replace with your custom font
      color: Colors.white,
    );
  }
}
