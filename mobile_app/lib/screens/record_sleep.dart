import 'package:flutter/material.dart';
import 'package:sleep_well/components/scaffold.dart';
import "package:intl/intl.dart";
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:sleep_well/components/select_symptoms.dart';
import 'package:sleep_well/components/yes_or_no.dart';
import 'package:sleep_well/helpers/enums.dart';
import 'package:sleep_well/models/symptoms.dart';

class RecordSleep extends StatefulWidget {
  RecordSleep({Key key}) : super(key: key);

  _RecordSleepState createState() => _RecordSleepState();
}

class _RecordSleepState extends State<RecordSleep> {
  DateTime _dateTime = new DateTime.now();
  double _value = 0.0;
  Duration _duration = new Duration(hours: 8, minutes: 00);
  bool didYouHadSymptoms;
  RecordingModel recording = RecordingModel();

  @override
  initState() {
    super.initState();
    recording.date = _dateTime.microsecondsSinceEpoch;
    recording.duration = _duration.inSeconds;
    recording.rating = 0;
  }

  void setSymptomsToYes() {
    this.setState(() => didYouHadSymptoms = true);
  }

  void setSymptomsToNo() {
    this.setState(() => didYouHadSymptoms = false);
  }

  void setHeadaceSymptoms() {
    if (recording.headace != null && recording.headace == 1) {
      this.setState(() => recording.headace = 0);
      return;
    }
    this.setState(() => recording.headace = 1);
  }

  void setNightmaresSymptoms() {
    if (recording.nightmares != null && recording.nightmares == 1) {
      this.setState(() => recording.nightmares = 0);
      return;
    }
    this.setState(() => recording.nightmares = 1);
  }

  void setFreezingSymptoms() {
    if (recording.freezing != null && recording.freezing == 1) {
      this.setState(() => recording.freezing = 0);
      return;
    }
    this.setState(() => recording.freezing = 1);
  }

  void setSweatingSymptoms() {
    if (recording.sweating != null && recording.sweating == 1) {
      this.setState(() => recording.sweating = 0);
      return;
    }
    this.setState(() => recording.sweating = 1);
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != _dateTime) {
      setState(() {
        _dateTime = picked;
        recording.date = picked.microsecondsSinceEpoch;
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    Duration resultingDuration = await showDurationPicker(
      context: context,
      initialTime: new Duration(hours: 7, minutes: 45),
    );
    if (resultingDuration == null) {
      return;
    }
    setState(() {
      _duration = resultingDuration;
      recording.duration = resultingDuration.inSeconds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
        title: Text(
          "Add Sleep Session",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Comfortaa',
            color: AppBlackColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: FlatButton(
                child: Text(
                  "Save",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    color: AppBlackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // padding: EdgeInsets.only(right: 4),
                onPressed: () async {
                  await recording.create();
                  Navigator.pushNamed(context, '/');
                },
              ),
            ),
          )
        ],
        body: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  _dateTime == null
                      ? "Select a date"
                      : "${DateFormat('EEEE').format(_dateTime)}, ${DateFormat('MMM').format(_dateTime)} ${_dateTime.day}", //Select Date
                  style: TextStyle(
                    fontFamily: 'Comfortaa',
                    color: AppBlackColor,
                    fontSize: 18,
                  ),
                ),
                leading: Icon(
                  Icons.calendar_today,
                  color: AppBlackColor,
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
                    color: AppBlackColor,
                    fontSize: 18,
                  ),
                ),
                leading: Icon(
                  Icons.timer,
                  color: AppBlackColor,
                ),
                onTap: () => _selectTime(context),
              ),
              Divider(height: 20),
              Title(
                text: "How did you sleep last night?",
              ),
              FlutterSlider(
                min: 0.0,
                max: 100.0,
                values: [_value],
                handlerHeight: 30.0,
                onDragCompleted: (handlerIndex, lowerValue, upperValue) => {
                      setState(() {
                        recording.rating = lowerValue;
                      })
                    },
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
                          color: SecondayBackgroundColor,
                        ),
                      ),
                    )),
                trackBar: FlutterSliderTrackBar(
                  activeTrackBarColor: SecondayBackgroundColor,
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
                        color: AppBlackColor,
                        fontSize: 18,
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
                        color: AppBlackColor,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 20),
              didYouHadSymptoms != null && didYouHadSymptoms
                  ? Title(
                      text: "Please select your symptoms",
                    )
                  : Title(
                      text: "Did you have any symptoms?",
                    ),
              //QuestionThing(),
              didYouHadSymptoms != null && didYouHadSymptoms
                  ? RecordSymptoms(
                      model: recording,
                      onHeadachePress: setHeadaceSymptoms,
                      onFreezingPress: setFreezingSymptoms,
                      onNightmaresPress: setNightmaresSymptoms,
                      onSweatingPress: setSweatingSymptoms,
                    )
                  : YesOrNo(
                      yesPress: setSymptomsToYes,
                      yes: didYouHadSymptoms != null && didYouHadSymptoms,
                      noPress: setSymptomsToNo,
                      no: didYouHadSymptoms != null && !didYouHadSymptoms),
              Divider(height: 20),
              ListTile(
                title: TextField(
                  autocorrect: true,
                  onChanged: (String change) => {
                        this.setState(() => {recording.notes = change})
                      },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter a dream note...',
                  ),
                ),
                leading: Icon(
                  Icons.chat_bubble_outline,
                  color: AppBlackColor,
                ),
              )
            ],
          ),
        ));
  }
}

final TextStyle _titleStyle = TextStyle(
  fontFamily: 'Comfortaa',
  color: AppBlackColor,
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

class Title extends StatelessWidget {
  final String text;
  const Title({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(text, textAlign: TextAlign.center, style: _titleStyle));
  }
}
