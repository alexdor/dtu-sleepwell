import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sleep_well/components/loading.dart';
import 'package:sleep_well/components/scaffold.dart';
import 'package:sleep_well/helpers/enums.dart';
import 'package:sleep_well/helpers/helpers.dart';
import 'package:sleep_well/models/symptoms.dart';

class SleepDiary extends StatefulWidget {
  SleepDiary({Key key}) : super(key: key);

  _SleepDiaryState createState() => _SleepDiaryState();
}

String _getDay(int date) {
  DateTime time = DateTime.fromMicrosecondsSinceEpoch(date);
  return DateFormat('EEE, MMM dd').format(time);
}

class _SleepDiaryState extends State<SleepDiary> {
  List<RecordingModel> data;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    var tmp = await symptoms();
    print(tmp);
    setState(() {
      data = tmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    double _pad = MediaQuery.of(context).size.width * 0.05;
    return ScreenScaffold(
      title: Text("Sleep Diary"),
      body: new Container(
          child: ListView(
              shrinkWrap: true,
              children: (data == null)
                  ? <Widget>[Loading()]
                  : <Widget>[
                      Divider(),
                      Wrap(
                          children: data
                              .map((f) => _SleepDiaryRow(
                                    date: "${_getDay(f.date)}",
                                    pad: _pad,
                                    duration: "${getSeconds(f.duration)}in",
                                    percent: f.rating,
                                  ))
                              .toList())
                    ]

              // <Widget>[
              //     Divider(),
              //     Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: <Widget>[
              //           Container(
              //               margin: EdgeInsets.all(_pad),
              //               child: Image.asset('assets/moon_yellow.png')),
              //           Container(
              //               margin: EdgeInsets.all(_pad),
              //               child: Text(
              //                 "Sat, Apr 6",
              //                 style: TextStyle(
              //                     color: AppBlackColor, fontSize: 18.0),
              //               )),
              //           Container(
              //               margin: EdgeInsets.all(_pad),
              //               child: Text(
              //                 "6h 45min",
              //                 style: TextStyle(
              //                     color: AppBlackColor, fontSize: 16.0),
              //               )),
              //         ]),
              //     Divider(),
              //     _SleepDiaryRow(
              //         date: "Mon, Apr 8",
              //         duration: "1h 20m",
              //         pad: _pad,
              //         percent: 50.0),
              //     Divider(),
              //     Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: <Widget>[
              //           Container(
              //               margin: EdgeInsets.all(_pad),
              //               child: Image.asset('assets/moon_blue.png')),
              //           Container(
              //               margin: EdgeInsets.all(_pad),
              //               child: Text(
              //                 "Mon, Apr 8",
              //                 style: TextStyle(
              //                     color: AppBlackColor, fontSize: 18.0),
              //               )),
              //           Container(
              //               margin: EdgeInsets.all(_pad),
              //               child: Text(
              //                 "8h 15min",
              //                 style: TextStyle(
              //                     color: AppBlackColor, fontSize: 16.0),
              //               )),
              //         ]),
              //     Divider(),
              )),
    );
  }
}

const _dateTextStyle = TextStyle(color: AppBlackColor, fontSize: 18.0);
const _durationTextStyle = TextStyle(color: AppBlackColor, fontSize: 16.0);

class _SleepDiaryRow extends StatelessWidget {
  final double pad;
  final double percent;
  final String date;
  final String duration;

  const _SleepDiaryRow(
      {Key key, this.pad, this.percent, this.date, this.duration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _image = 'assets/moon_blue.png';
    if (percent == null) {
      _image = 'assets/moon_grey.png';
    } else if (percent < BadUpperLimit) {
      _image = 'assets/moon_rose.png';
    } else if (percent < GoodUpperLimit) {
      _image = 'assets/moon_yellow.png';
    }

    return Wrap(children: <Widget>[
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
        Container(margin: EdgeInsets.all(pad), child: Image.asset(_image)),
        Container(
            margin: EdgeInsets.all(pad),
            child: Text(
              date,
              style: _dateTextStyle,
            )),
        Container(
            margin: EdgeInsets.all(pad),
            child: Text(
              duration,
              style: _durationTextStyle,
            )),
      ]),
      Divider(),
    ]);
  }
}
