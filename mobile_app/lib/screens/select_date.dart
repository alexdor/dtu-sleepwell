import 'package:flutter/material.dart';
import 'package:sleep_well/components/scaffold.dart';

class SelectDate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
        body: new Container(
      child: new Column(
        children: <Widget>[
          ListTile(
            title: Text(
              "Select Date",
              style: TextStyle(
                fontFamily: 'Comfortaa',
                color: Color(0xFF382E21),
                fontSize: 20.0,
              ),
            ),
            leading: Icon(
              Icons.calendar_today,
              color: Color(0xFF382E21),
            ),
          )
        ],
      ),
    ));
  }
}
