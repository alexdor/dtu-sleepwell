import 'package:flutter/material.dart';
import 'package:sleep_well/components/circular_border.dart';
import 'package:sleep_well/components/scaffold.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:sleep_well/helpers/enums.dart';

const TextStyle _bottomTextStyle =
    TextStyle(fontSize: 24, fontFamily: 'Comfortaa', color: Color(0xff789CE9));
const TextStyle _bottomTextStyleSmall =
    TextStyle(fontSize: 12, fontFamily: 'Comfortaa', color: AppBlackColor);

class MyHomePage extends StatelessWidget {
  var _assetsImage = new AssetImage('assets/Logo_with_text.png');
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
            CircularBorder(
              centerInfo: CenterInfo(
                  percent: 25, timeAsleep: "8h 00m", when: "Last night"),
              size: MediaQuery.of(context).size.width * 3 / 4,
              icon: DonutPieChart.withSampleData(),
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
                      "Last night's sleep enviroment",
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
                        Text("15\u2103", style: _bottomTextStyle),
                        Text("Temprature", style: _bottomTextStyleSmall)
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text("25%", style: _bottomTextStyle),
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
}

class DonutPieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DonutPieChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory DonutPieChart.withSampleData() {
    return new DonutPieChart(
      _createSampleData(),
      // Disable animations for image tests.
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
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 100),
      new LinearSales(1, 75),
      new LinearSales(2, 25),
      new LinearSales(3, 5),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
