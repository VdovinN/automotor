import 'package:automotor/screen/onboarding/onboarding_page.dart';
import 'package:automotor/screen/splash/component/body.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  static String routeName = "/splash";

  @override
  Widget build(BuildContext context) {
    _showOnBoarding(context);
    return Body();
  }

  _showOnBoarding(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, OnBoardingPage.routeName);
    });
  }
}
