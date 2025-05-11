import 'package:flutter/material.dart';
import 'package:gamraka/core/app_colors.dart';
import 'package:gamraka/core/app_functions.dart';
import 'package:gamraka/core/cache_helper.dart';
import 'package:gamraka/screens/navbar/navbar_screen.dart';
import 'package:gamraka/screens/welcome/stepper_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      if (context.mounted) {
        context.offToPage(
          CacheHelper.isLogin() ? NavbarScreen() : StepperScreen(),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(child: Image.asset('assets/gifs/splash.gif')),
    );
  }
}
