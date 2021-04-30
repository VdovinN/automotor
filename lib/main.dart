import 'package:automotor/screen/splash/splash_page.dart';
import 'package:automotor/util/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AutoMotorApp());
}

class AutoMotorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "AutoMotor",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: SplashPage.routeName,
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
