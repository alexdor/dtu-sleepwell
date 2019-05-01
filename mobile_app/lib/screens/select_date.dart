import 'package:flutter/material.dart';
import 'package:sleep_well/components/scaffold.dart';

class SelectDate extends StatefulWidget {
  SelectDate({Key key}) : super(key: key);

  _SelectDateState createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  DateTime _dateTime;
  TimeOfDay _timeOfDay = new TimeOfDay.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2019));
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
                      : "'date selected: ${_dateTime.toString()}'", //Select Date
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
                  onPressed: () {
                    Text("text");
                    //_dateTime = new DateTime.now();
                    //_selectDate(context);
                  }),
            ],
          ),
        ));
  }
}
