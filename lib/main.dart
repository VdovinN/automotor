import 'package:automotor/screen/onboarding/onboarding_page.dart';
import 'package:automotor/util/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AutoMotorApp());
}

class AutoMotorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.grey),
        primarySwatch: Colors.red,
      ),
      initialRoute: OnBoardingPage.routeName,
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
