import 'package:flutter/material.dart';
import 'package:sleep_well/components/scaffold.dart';
import "package:intl/intl.dart";
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';

class SelectDate extends StatefulWidget {
  SelectDate({Key key}) : super(key: key);

  _SelectDateState createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> {
  DateTime _dateTime = new DateTime.now();
  double _value = 0.0;
  Duration _duration = Duration(hours: 0, minutes: 0);

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
      initialTime: new Duration(minutes: 30),
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
                      : "${_duration.toString()}", //Select Date
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
              ListTile(
                title: Text(
                  "How did you sleep last night?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    color: Color(0xFF382E21),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "Bad",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    color: Color(0xFF382E21),
                    fontSize: 20.0,
                  ),
                ),
              ),
              FlutterSlider(
                min: 0.0,
                max: 20.0,
                values: [_value],
                handler: FlutterSliderHandler(
                    decoration: BoxDecoration(),
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
                  activeTrackBarHeight: 5,
                  inactiveTrackBarColor: Colors.grey.withOpacity(0.5),
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
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RawMaterialButton(
                    fillColor: Color(0xFF789CE9),
                    splashColor: Colors.orangeAccent,
                    child: Padding(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            width: 100.0,
                          ),
                          Text(
                            'Yes',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Comfortaa',
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(10.0),
                    ),
                    elevation: 3.0,
                    onPressed: () {
                      //Navigator.push(
                      //context,
                      //MaterialPageRoute(builder: (context) => SecondIntroPage()),
                      //);
                    },
                    shape: StadiumBorder(),
                  ),
                  RawMaterialButton(
                    fillColor: Color(0xFF789CE9),
                    splashColor: Colors.orangeAccent,
                    child: Padding(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            width: 100.0,
                          ),
                          Text(
                            'No',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Comfortaa',
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(10.0),
                    ),
                    elevation: 3.0,
                    onPressed: () {
                      //Navigator.push(
                      //context,
                      //MaterialPageRoute(builder: (context) => SecondIntroPage()),
                      //);
                    },
                    shape: StadiumBorder(),
                  ),
                ],
              ),
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
