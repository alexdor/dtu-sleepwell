import 'package:flutter/material.dart';
import 'package:sleep_well/components/scaffold.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DataViz extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DataViz(this.seriesList, {this.animate});

  factory DataViz.withSampleData() {
    return new DataViz(
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
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.all(25.0),
                        child: new Icon(Icons.arrow_left)),
                    Container(
                        margin: EdgeInsets.all(25.0),
                        child: Text(
                          "April",
                          style: TextStyle(
                              color: Color(0xFF382E21), fontSize: 22.0),
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
                  child: new charts.BarChart(
                    seriesList,
                    animate: animate,
                    barGroupingType: charts.BarGroupingType.groupedStacked,
                    defaultRenderer: new charts.BarRendererConfig(),
                    behaviors: [
                      new charts.SeriesLegend(
                          position: charts.BehaviorPosition.end,
                          horizontalFirst: true,
                          desiredMaxRows: 2,
                          cellPadding:
                              new EdgeInsets.only(right: 4.0, bottom: 4.0),
                          entryTextStyle: charts.TextStyleSpec(
                              color: charts.Color.black, fontSize: 11))
                    ],
                  ),
                )
              ])
            ])));
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesDataA = [
      new OrdinalSales('Week 1', 15),
      new OrdinalSales('Week 2', 15),
      new OrdinalSales('Week 3', 15),
      new OrdinalSales('Week 4', 15),
    ];

    final tableSalesDataA = [
      new OrdinalSales('Week 1', 29),
      new OrdinalSales('Week 2', 30),
      new OrdinalSales('Week 3', 29),
      new OrdinalSales('Week 4', 31),
    ];

    final desktopSalesDataB = [
      new OrdinalSales('Week 1', 50),
      new OrdinalSales('Week 2', 50),
      new OrdinalSales('Week 3', 50),
      new OrdinalSales('Week 4', 50),
    ];

    final tableSalesDataB = [
      new OrdinalSales('Week 1', 54),
      new OrdinalSales('Week 2', 51),
      new OrdinalSales('Week 3', 48),
      new OrdinalSales('Week 4', 55),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Ideal Temperature',
        seriesCategory: 'A',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesDataA,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        fillColorFn: (_, __) =>
            charts.MaterialPalette.green.shadeDefault.lighter,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Collected Temperature',
        seriesCategory: 'A',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesDataA,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Ideal Humidity',
        seriesCategory: 'B',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesDataB,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        fillColorFn: (_, __) =>
            charts.MaterialPalette.blue.shadeDefault.lighter,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Collected Humidity',
        seriesCategory: 'B',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesDataB,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      ),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
