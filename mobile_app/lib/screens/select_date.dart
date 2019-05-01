import 'package:flutter/material.dart';
import 'package:sleep_well/components/scaffold.dart';
import "package:intl/intl.dart";

class SelectDate extends StatefulWidget {
  SelectDate({Key key}) : super(key: key);

  _SelectDateState createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  DateTime _dateTime;
  DateTime _timeOfDay = new DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _timeOfDay,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _dateTime) {
      print('date selected: ${_dateTime.toString()}');
      setState(() {
        _dateTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
        title: Text(
          "Add Sleep Session",
          textAlign: TextAlign.justify,
          style: TextStyle(
            fontFamily: 'Comfortaa',
            color: Color(0xFF382E21),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Save",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  color: Color(0xFF382E21),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
        body: new Container(
          child: new Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  _dateTime == null
                      ? "Please select a date"
                      : "Date selected: ${DateFormat('EEEE').format(_dateTime)}, ${DateFormat('MMM').format(_dateTime)} ${_dateTime.day}", //Select Date
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
              ),
              RaisedButton(
                  child: new Text("Select Date"),
                  onPressed: () => _selectDate(context)),
            ],
          ),
        ));
  }
}
