import 'package:flutter/material.dart';
import 'package:sleep_well/components/scaffold.dart';

class SleepDiary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      title: Text("Sleep Diary"),
      body: new Container(
          child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Container(
                  margin: EdgeInsets.all(25.0),
                  child: new Icon(Icons.arrow_left)),
              Container(
                  margin: EdgeInsets.all(25.0),
                  child: Text(
                    "April",
                    style: TextStyle(color: Color(0xFF382E21), fontSize: 22.0),
                  )),
              Container(
                  margin: EdgeInsets.all(25.0),
                  child: new Icon(Icons.arrow_right)),
            ]),
            Divider(),
            Row(children: <Widget>[
              Container(
                  margin: EdgeInsets.all(25.0),
                  child: Image.asset('assets/moon_yellow.png')),
              Container(
                  margin: EdgeInsets.all(25.0),
                  child: Text(
                    "Sat, Apr 6",
                    style: TextStyle(color: Color(0xFF382E21), fontSize: 18.0),
                  )),
              Container(
                  margin: EdgeInsets.all(25.0),
                  child: Text(
                    "6h 45min",
                    style: TextStyle(color: Color(0xFF382E21), fontSize: 16.0),
                  )),
            ]),
            Divider(),
            Row(children: <Widget>[
              Container(
                  margin: EdgeInsets.all(25.0),
                  child: Image.asset('assets/moon_rose.png')),
              Container(
                  margin: EdgeInsets.all(25.0),
                  child: Text(
                    "Sun, Apr 7",
                    style: TextStyle(color: Color(0xFF382E21), fontSize: 18.0),
                  )),
              Container(
                  margin: EdgeInsets.all(25.0),
                  child: Text(
                    "5h 10min",
                    style: TextStyle(color: Color(0xFF382E21), fontSize: 16.0),
                  )),
            ]),
            Divider(),
            Row(children: <Widget>[
              Container(
                  margin: EdgeInsets.all(25.0),
                  child: Image.asset('assets/moon_blue.png')),
              Container(
                  margin: EdgeInsets.all(25.0),
                  child: Text(
                    "Mon, Apr 8",
                    style: TextStyle(color: Color(0xFF382E21), fontSize: 18.0),
                  )),
              Container(
                  margin: EdgeInsets.all(25.0),
                  child: Text(
                    "8h 15min",
                    style: TextStyle(color: Color(0xFF382E21), fontSize: 16.0),
                  )),
            ])
          ])),
    );
  }
}
