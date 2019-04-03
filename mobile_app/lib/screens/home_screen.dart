import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleep_well/components/logo.dart';
import 'package:sleep_well/components/platform_scaffold.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _logo = new Logo();

  @override
  Widget build(BuildContext context) {
    return new PlatformScaffold(
      title: "Sleepwell",
      child: _logo,
    );
  }
}
