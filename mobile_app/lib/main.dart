import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleep_well/screens/home_screen.dart';
import 'package:sleep_well/screens/month_viz.dart';
import 'package:sleep_well/screens/onboarding_screen.dart';
import 'package:sleep_well/screens/select_date.dart';
import 'package:sleep_well/screens/settings.dart';
import 'package:sleep_well/screens/sleepdiary_screen.dart';
import 'package:sleep_well/screens/week_viz.dart';

import 'models/settings.dart';

void main() async {
  var s = await settings();
  return runApp(SleepWell(showIntro: s.showIntro));
}

class SleepWell extends StatelessWidget {
  final int showIntro;

  SleepWell({this.showIntro});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sleep Well',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      initialRoute: showIntro == 1 ? '/intro' : '/',
      routes: {
        '/intro': (context) => OnBoardingPage(),
        '/date': (context) => SelectDate(),
        '/': (context) => MyHomePage(),
        '/diary': (context) => SleepDiary(),
        '/settings': (context) => Settings(),
        '/monthdata': (context) => MonthViz.withSampleData(),
        '/weekdata': (context) => WeekViz.withSampleData(),
      },
    );
  }
}
