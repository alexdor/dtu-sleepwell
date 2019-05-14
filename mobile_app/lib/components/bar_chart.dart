import 'package:flutter/cupertino.dart';
import 'package:sleep_well/models/api_response.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  BarChart(this.seriesList, {this.animate});

  factory BarChart.withDataTransform(List<ApiResponse> data) {
    return new BarChart(
      _transformData(data),
      animate: false,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
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
                position: charts.BehaviorPosition.bottom,
                horizontalFirst: true,
                desiredMaxRows: 2,
                cellPadding: new EdgeInsets.only(right: 20.0, bottom: 15.0),
                entryTextStyle: charts.TextStyleSpec(
                    color: charts.Color.black, fontSize: 11))
          ],
        ),
      )
    ]);
  }

  /// Create series list with multiple series
  static List<charts.Series<RoomRecording, String>> _transformData(
      List<ApiResponse> data) {
    if (data == null || data.length < 1) {
      return [
        new charts.Series<RoomRecording, String>(
            id: 'Ideal °C',
            seriesCategory: 'A',
            domainFn: (RoomRecording value, _) => value.timestamp,
            measureFn: (RoomRecording value, _) => value.value,
            colorFn: (_, __) => charts.Color.fromHex(code: "#E47465"),
            data: <RoomRecording>[])
      ];
    }
    List<RoomRecording> idealTempData = [];

    List<RoomRecording> idealHumData = [];

    List<RoomRecording> tempData = [];

    List<RoomRecording> humData = [];
    for (var i = 0; i < data.length; i++) {
      if (data[i].humidity == 0 && data[i].temp == 0) {
        continue;
      }
      String _week = 'Week $i';
      idealHumData.add(new RoomRecording(_week, 50));
      idealTempData.add(new RoomRecording(_week, 15));

      humData.add(new RoomRecording(_week, data[i].humidity));
      tempData.add(new RoomRecording(_week, data[i].temp));
    }

    return [
      new charts.Series<RoomRecording, String>(
        id: 'Ideal °C',
        seriesCategory: 'A',
        domainFn: (RoomRecording value, _) => value.timestamp,
        measureFn: (RoomRecording value, _) => value.value,
        data: idealTempData,
        colorFn: (_, __) => charts.Color.fromHex(code: "#E47465"),
      ),
      new charts.Series<RoomRecording, String>(
        id: '°C',
        seriesCategory: 'A',
        domainFn: (RoomRecording recording, _) => recording.timestamp,
        measureFn: (RoomRecording recording, _) => recording.value,
        data: tempData,
        colorFn: (_, __) => charts.Color.fromHex(code: "#82CCC8"),
      ),
      new charts.Series<RoomRecording, String>(
          id: 'Ideal g/m3',
          seriesCategory: 'B',
          domainFn: (RoomRecording recording, _) => recording.timestamp,
          measureFn: (RoomRecording recording, _) => recording.value,
          data: idealHumData,
          colorFn: (_, __) => charts.Color.fromHex(code: "#F28890")),
      new charts.Series<RoomRecording, String>(
        id: 'g/m3',
        seriesCategory: 'B',
        domainFn: (RoomRecording recording, _) => recording.timestamp,
        measureFn: (RoomRecording recording, _) => recording.value,
        data: humData,
        colorFn: (_, __) => charts.Color.fromHex(code: "#FED587"),
      ),
    ];
  }
}

class RoomRecording {
  final String timestamp;
  final double value;

  RoomRecording(this.timestamp, this.value);
}
