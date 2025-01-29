import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pet_adoption/common/constants/app_colors.dart';
import 'package:pet_adoption/common/constants/app_images.dart';
import 'package:pet_adoption/common/constants/extensions.dart';
import 'package:pet_adoption/common/constants/spacing.dart';
import 'package:pet_adoption/navigation/app_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final double imageSize = 150;
  AppLocalizations get _appLocalizations => AppLocalizations.of(context)!;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      navigateToHome();
    });
  }

  void navigateToHome() {
    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary, // Adjust background color as needed
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppImages.footPrint,
              height: imageSize,
              width: imageSize,
              color: Colors.white,
            ),
            AppSpacing.space30.heightBox,
            Column(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: _appLocalizations.connectTo,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: AppSpacing.space32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' ${_appLocalizations.meet}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: AppSpacing.space32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                AppSpacing.space10.heightBox,
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${_appLocalizations.your} ',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: AppSpacing.space32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: _appLocalizations.bestFriends,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: AppSpacing.space32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
