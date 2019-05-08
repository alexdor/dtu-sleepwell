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
                    },
                    shape: RoundedRectangleBorder(),
                  ),
                ],
              ),
              Divider(),
              new Row(
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
              Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    child: new charts.ScatterPlotChart(seriesList,
                        animate: animate,
                        behaviors: [
                          new charts.SeriesLegend(
                            position: charts.BehaviorPosition.bottom,
                            horizontalFirst: true,
                            desiredMaxRows: 2,
                            cellPadding:
                                new EdgeInsets.only(right: 10.0, bottom: 20.0),
                            entryTextStyle: charts.TextStyleSpec(
                                color: charts.Color.black, fontSize: 11),
                          ),

                          ///
                          new charts.RangeAnnotation([
                            new charts.RangeAnnotationSegment(
                                15, 20, charts.RangeAnnotationAxisType.measure,
                                startLabel: 'Monday',
                                endLabel: 'Tuesday',
                                labelAnchor: charts.AnnotationLabelAnchor.end,
                                color: charts.MaterialPalette.gray.shade300)
                          ],
                              defaultLabelPosition:
                                  charts.AnnotationLabelPosition.margin)
                        ]),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  /// Create series list with multiple series
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final goodData = [
      new LinearSales(27, 10, 18.0),
      new LinearSales(20, 9, 15.0),
      new LinearSales(30, 13, 10.0),
      new LinearSales(15, 11, 12.0),
    ];

    final avgData = [
      new LinearSales(29, 18, 14.0),
      new LinearSales(10, 5, 10.0),
    ];

    final badData = [
      new LinearSales(49, 20, 10.0),
    ];

    return [
      new charts.Series<LinearSales, int>(
          id: 'Good',
          colorFn: (LinearSales sales, _) =>
              charts.MaterialPalette.green.shadeDefault,
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.revenueShare,
          radiusPxFn: (LinearSales sales, _) => sales.radius,
          data: goodData),
      new charts.Series<LinearSales, int>(
          id: 'Average',
          colorFn: (LinearSales sales, _) =>
              charts.MaterialPalette.yellow.shadeDefault,
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.revenueShare,
          radiusPxFn: (LinearSales sales, _) => sales.radius,
          data: avgData),
      new charts.Series<LinearSales, int>(
          id: 'Bad',
          colorFn: (LinearSales sales, _) =>
              charts.MaterialPalette.red.shadeDefault,
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.revenueShare,
          radiusPxFn: (LinearSales sales, _) => sales.radius,
          data: badData),
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final double revenueShare;
  final double radius;

  LinearSales(this.year, this.revenueShare, this.radius);
}
