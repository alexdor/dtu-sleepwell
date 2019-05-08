import 'package:flutter/material.dart';
import 'package:sleep_well/components/scaffold.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DataViz2 extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DataViz2(this.seriesList, {this.animate});

  factory DataViz2.withSampleData() {
    return new DataViz2(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }
  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
        title: Text("Statistics"),
        body: new Container(
            child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(left: 24.0, right: 24.0),
                children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RawMaterialButton(
                    fillColor: Color(0xFF446EB6),
                    splashColor: Colors.blueGrey,
                    child: Padding(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            width: 100.0,
                          ),
                          Text(
                            'Week',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Comfortaa',
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(10.0),
                    ),
                    elevation: 3.0,
                    onPressed: () {
                      Navigator.pushNamed(context, '/weekdata');
                      //Navigator.push(
                      //context,
                      //MaterialPageRoute(builder: (context) => SecondIntroPage()),
                      //);
                    },
                    shape: RoundedRectangleBorder(),
                  ),
                  RawMaterialButton(
                    fillColor: Color(0xFF446EB6),
                    splashColor: Colors.blueGrey,
                    child: Padding(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            width: 100.0,
                          ),
                          Text(
                            'Month',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Comfortaa',
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(10.0),
                    ),
                    elevation: 3.0,
                    onPressed: () {
                      Navigator.pushNamed(context, '/monthdata');
                      //Navigator.push(
                      //context,
                      //MaterialPageRoute(builder: (context) => SecondIntroPage()),
                      //);
                    },
                    shape: RoundedRectangleBorder(),
                  ),
                ],
              ),
              Divider(),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.all(25.0),
                        child: new Icon(Icons.arrow_left)),
                    Container(
                        margin: EdgeInsets.all(25.0),
                        child: Text(
                          "April 1 - April 7",
                          style: TextStyle(
                              color: Color(0xFF382E21), fontSize: 18.0),
                        )),
                    Container(
                        margin: EdgeInsets.all(25.0),
                        child: new Icon(Icons.arrow_right)),
                  ]),
              Divider(),
              Column(children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  child: new charts.ScatterPlotChart(
                    seriesList,
                    animate: animate,
                    behaviors: [
                      new charts.SeriesLegend(
                          position: charts.BehaviorPosition.bottom,
                          horizontalFirst: true,
                          desiredMaxRows: 2,
                          cellPadding:
                              new EdgeInsets.only(right: 20.0, bottom: 15.0),
                          entryTextStyle: charts.TextStyleSpec(
                              color: charts.Color.black, fontSize: 11))
                    ],
                  ),
                )
              ]),
            ])));
  }

  /// Create series list with multiple series
  static List<charts.Series<DailyCollection, String>> _createSampleData() {
    final goodData = [
      new DailyCollection('Monday', 0, 0),
      new DailyCollection('Tuesday', 10, 18.0),
      new DailyCollection('Wednesday', 0, 0),
      new DailyCollection('Thursday', 0, 0),
      new DailyCollection('Friday', 9, 15.0),
      new DailyCollection('Saturday', 13, 10.0),
      new DailyCollection('Sunday', 11, 12.0),
    ];

    final avgData = [
      new DailyCollection('Monday', 18, 14.0),
      new DailyCollection('Tuesday', 0, 0),
      new DailyCollection('Wednesday', 0, 0),
      new DailyCollection('Thursday', 5, 10.0),
      new DailyCollection('Friday', 0, 0),
      new DailyCollection('Saturday', 0, 0),
      new DailyCollection('Sunday', 0, 0),
    ];

    final badData = [
      new DailyCollection('Monday', 0, 0),
      new DailyCollection('Tuesday', 0, 0),
      new DailyCollection('Wednesday', 20, 10.0),
      new DailyCollection('Thursday', 0, 0),
      new DailyCollection('Friday', 0, 0),
      new DailyCollection('Saturday', 0, 0),
      new DailyCollection('Sunday', 0, 0),
    ];

    return [
      new charts.Series<DailyCollection, String>(
          id: 'Good',
          colorFn: (DailyCollection sales, _) =>
              charts.MaterialPalette.green.shadeDefault,
          domainFn: (DailyCollection sales, _) => sales.day,
          measureFn: (DailyCollection sales, _) => sales.temperature,
          radiusPxFn: (DailyCollection sales, _) => sales.radius,
          data: goodData),
      new charts.Series<DailyCollection, String>(
          id: 'Average',
          colorFn: (DailyCollection sales, _) =>
              charts.MaterialPalette.yellow.shadeDefault,
          domainFn: (DailyCollection sales, _) => sales.day,
          measureFn: (DailyCollection sales, _) => sales.temperature,
          radiusPxFn: (DailyCollection sales, _) => sales.radius,
          data: avgData),
      new charts.Series<DailyCollection, String>(
          id: 'Bad',
          colorFn: (DailyCollection sales, _) =>
              charts.MaterialPalette.red.shadeDefault,
          domainFn: (DailyCollection sales, _) => sales.day,
          measureFn: (DailyCollection sales, _) => sales.temperature,
          radiusPxFn: (DailyCollection sales, _) => sales.radius,
          data: badData),
    ];
  }
}

/// Sample linear data type.
class DailyCollection {
  final String day;
  final double temperature;
  final double radius;

  DailyCollection(this.day, this.temperature, this.radius);
}
