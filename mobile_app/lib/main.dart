import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleep_well/helpers/enums.dart';
import 'package:sleep_well/screens/home_screen.dart';
import 'package:sleep_well/screens/onboarding_screen.dart';
import 'package:sleep_well/screens/record_sleep.dart';
import 'package:sleep_well/screens/settings.dart';
import 'package:sleep_well/screens/sleepdiary_screen.dart';
import 'package:sleep_well/screens/visualization_screen.dart';

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
      debugShowCheckedModeBanner: false,
      title: 'Sleep Well',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      initialRoute: showIntro == 1 ? '/intro' : '/',
      routes: {
        '/intro': (context) => OnBoardingPage(),
        '/date': (context) => RecordSleep(),
        '/': (context) => HomePage(),
        '/diary': (context) => SleepDiary(),
        '/settings': (context) => Settings(),
        '/monthdata': (context) => VisualizationScreen(
              type: VisualizationTypes.MONTH,
            ),
        '/weekdata': (context) => VisualizationScreen(
              type: VisualizationTypes.WEEK,
            ),
      },
    );
  }
}
