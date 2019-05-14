import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sleep_well/components/circular_border.dart';
import 'package:sleep_well/components/loading.dart';
import 'package:sleep_well/components/scaffold.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:sleep_well/helpers/enums.dart';
import 'package:sleep_well/helpers/helpers.dart';
import 'package:http/http.dart' as http;
import 'package:sleep_well/models/symptoms.dart';

const TextStyle _bottomTextStyle =
    TextStyle(fontSize: 24, fontFamily: 'Comfortaa', color: Color(0xff789CE9));
const TextStyle _bottomTextStyleSmall =
    TextStyle(fontSize: 12, fontFamily: 'Comfortaa', color: AppBlackColor);

String _getDay(int date) {
  if (date == null) {
    return "No availiable data";
  }
  final time = DateTime.fromMicrosecondsSinceEpoch(date);
  final now = DateTime.now();
  final days = now.difference(time).inDays;
  switch (days) {
    case 0:
      return "Last Night";
    case 1:
      return "Previous Night";
    default:
      return "$days days ago";
  }
}

charts.Color _getColor(double percent) {
  if (percent == null) {
    return charts.Color.transparent;
  } else if (percent < BadUpperLimit) {
    return charts.Color.fromHex(code: "#F28890");
  } else if (percent < GoodUpperLimit) {
    return charts.Color.fromHex(code: "#FFD93B");
  }
  return charts.Color.fromHex(code: "#82CCC8");
}

final AssetImage _assetsImage = new AssetImage('assets/Logo_with_text.png');

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String humidity;
  String temp;
  RecordingModel model;
  Timer timer;

  @override
  void initState() {
    super.initState();

    fetchModel();
    fetchData();
    timer = Timer.periodic(Duration(minutes: 2), (Timer t) => fetchData());
  }

  void fetchData() async {
    try {
      var response = await http.get("$APIURL/data");
      if (response.statusCode != 200) {
        setState(() {
          humidity = "Network error";
          temp = "Network error";
        });
        return;
      }
      Map<String, dynamic> body = jsonDecode(response.body);
      setState(() {
        humidity = body['humidity'].toStringAsFixed(2);
        temp = body['temp'].toStringAsFixed(2);
      });
    } catch (e) {
      print(e);
      setState(() {
        humidity = "Network error";
        temp = "Network error";
      });
    }
  }

  void fetchModel() async {
    RecordingModel tmp = await lastSymptom();
    if (tmp == null) {
      tmp = RecordingModel();
    }
    setState(() {
      model = tmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      body: new SingleChildScrollView(
          child: Center(
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05)),
            new Image(
              image: _assetsImage,
              width: MediaQuery.of(context).size.width / 2,
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.08)),
            model == null
                ? Loading()
                : CircularBorder(
                    centerInfo: CenterInfo(
                        percent: model.rating,
                        timeAsleep: getSeconds(model.duration),
                        when: _getDay(model.date)),
                    size: MediaQuery.of(context).size.width * 3 / 4,
                    icon: DonutPieChart.percent(model.rating),
                  ),
            Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.05)),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Current sleep enviroment",
                      style: TextStyle(
                          fontSize: 20,
                          color: AppBlackColor,
                          fontFamily: 'Comfortaa'),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.03),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text("${temp == null ? 'loading' : temp + '\u2103'}",
                            style: _bottomTextStyle),
                        Text("Temprature", style: _bottomTextStyleSmall)
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text("${humidity == null ? 'loading' : humidity + '%'}",
                            style: _bottomTextStyle),
                        Text("Humidity", style: _bottomTextStyleSmall)
                      ],
                    )
                  ],
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
            )
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      )),
      hideAppBar: true,
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}

class DonutPieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DonutPieChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory DonutPieChart.percent(double percent) {
    return new DonutPieChart(
      _createPercentData(percent),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        // Configure the width of the pie slices to 60px. The remaining space in
        // the chart will be left as a hole in the center.
        defaultRenderer: new charts.ArcRendererConfig(arcWidth: 10));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<PercentPoints, double>> _createPercentData(
      double percent) {
    if (percent == null) {
      return [
        new charts.Series<PercentPoints, double>(
            id: 'Percent',
            domainFn: (PercentPoints point, _) => point.id,
            measureFn: (PercentPoints point, _) => point.value,
            data: [new PercentPoints(0, 0)],
            colorFn: (PercentPoints point, int i) =>
                i == 1 ? charts.Color.transparent : _getColor(point.value))
      ];
    }
    final data = [
      new PercentPoints(0, percent),
      new PercentPoints(1, 100 - percent),
    ];

    return [
      new charts.Series<PercentPoints, double>(
          id: 'Percent',
          domainFn: (PercentPoints point, _) => point.id,
          measureFn: (PercentPoints point, _) => point.value,
          data: data,
          colorFn: (PercentPoints point, int i) =>
              i == 1 ? charts.Color.transparent : _getColor(point.value))
    ];
  }
}

/// Sample linear data type.
class PercentPoints {
  final double id;
  final double value;

  PercentPoints(this.id, this.value);
}
