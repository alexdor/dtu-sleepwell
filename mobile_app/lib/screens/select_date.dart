import 'package:flutter/material.dart';
import 'package:sleep_well/components/scaffold.dart';
import "package:intl/intl.dart";
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:sleep_well/screens/selectSymptoms.dart';
import 'package:sleep_well/screens/symptomsQuestion.dart';

class SelectDate extends StatefulWidget {
  SelectDate({Key key}) : super(key: key);

  _SelectDateState createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  DateTime _dateTime = new DateTime.now();
  double _value = 0.0;
  Duration _duration = new Duration(hours: 8, minutes: 00);

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _dateTime) {
      print('Date ${_dateTime.toString()}');
      setState(() {
        _dateTime = picked;
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    Duration resultingDuration = await showDurationPicker(
      context: context,
      initialTime: new Duration(hours: 7, minutes: 45),
    );
    setState(() {});
    setState(() {
      _duration = resultingDuration;
    });
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
                      ? "Select a date"
                      : "${DateFormat('EEEE').format(_dateTime)}, ${DateFormat('MMM').format(_dateTime)} ${_dateTime.day}", //Select Date
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
                onTap: () => _selectDate(context),
              ),
              ListTile(
                title: Text(
                  _duration == null
                      ? "Select Time"
                      //: "${_duration.inHours} : ${_duration.inMinutes}", //Select Date
                      : "${_duration.toString().substring(0, 4)}h",
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    color: Color(0xFF382E21),
                    fontSize: 20.0,
                  ),
                ),
                leading: Icon(
                  Icons.timer,
                  color: Color(0xFF382E21),
                ),
                onTap: () => _selectTime(context),
              ),
              Divider(),
              Text(
                "How did you sleep last night?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Comfortaa',
                  color: Color(0xFF382E21),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FlutterSlider(
                min: 0.0,
                max: 20.0,
                values: [_value],
                handlerHeight: 30.0,
                tooltip: FlutterSliderTooltip(
                  //dissable the number above the slider
                  disabled: true,
                ),
                handler: FlutterSliderHandler(
                    decoration: new BoxDecoration(),
                    child: Material(
                      type: MaterialType.transparency,
                      child: Container(
                        //padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.brightness_1,
                          color: Color(0xFFE08E79),
                        ),
                      ),
                    )),
                trackBar: FlutterSliderTrackBar(
                  activeTrackBarColor: Color(0xFFE08E79),
                  //activeTrackBarHeight: 5,
                  inactiveTrackBarColor: Colors.grey.withOpacity(0.5),
                ),
              ),
              Container(
                child: Row(
                  //mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                  children: <Widget>[
                    Text(
                      "Bad",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        color: Color(0xFF382E21),
                        fontSize: 20.0,
                      ),
                    ),
                    IconButton(
                      icon: Icon(null, size: 0.5),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(null, size: 0.5),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(null, size: 0.5),
                      onPressed: () {},
                    ),
                    Text(
                      "Good",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        color: Color(0xFF382E21),
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              ListTile(
                title: Text(
                  "Did you have any symptoms?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    color: Color(0xFF382E21),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              //QuestionThing(),
              QuestionTSelectSymptoms(),
              Divider(),
              ListTile(
                title: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter a dream note...',
                  ),
                ),
                leading: Icon(
                  Icons.chat_bubble_outline,
                  color: Color(0xFF382E21),
                ),
              )
            ],
          ),
        ));
  }
}
