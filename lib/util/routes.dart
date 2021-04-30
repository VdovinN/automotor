import 'package:automotor/screen/onboarding/onboarding_page.dart';
import 'package:automotor/screen/splash/splash_page.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  SplashPage.routeName: (context) => SplashPage(),
  OnBoardingPage.routeName: (context) => OnBoardingPage(),
};
