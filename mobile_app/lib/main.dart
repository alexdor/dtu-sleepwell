import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleep_well/screens/home_screen.dart';
import 'package:sleep_well/screens/onboarding_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sleep Well',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      initialRoute: '/intro',
      routes: {
        '/intro': (context) => OnBoardingPage(),
        '/': (context) => MyHomePage()
      },
    );
  }
}
