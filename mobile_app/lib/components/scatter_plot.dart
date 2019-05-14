import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:sleep_well/helpers/enums.dart';
import 'package:sleep_well/models/api_response.dart';
import 'package:sleep_well/models/symptoms.dart';

class ScatterPlot extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  const ScatterPlot({Key key, this.seriesList, this.animate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      child:
          new charts.ScatterPlotChart(seriesList, animate: animate, behaviors: [
        new charts.SeriesLegend(
          position: charts.BehaviorPosition.bottom,
          horizontalFirst: true,
          desiredMaxRows: 2,
          cellPadding: new EdgeInsets.only(right: 10.0, bottom: 20.0),
          entryTextStyle:
              charts.TextStyleSpec(color: charts.Color.black, fontSize: 11),
        ),

        ///
        new charts.RangeAnnotation([
          new charts.RangeAnnotationSegment(
              15, 20, charts.RangeAnnotationAxisType.measure,
              startLabel: 'Monday',
              endLabel: 'Tuesday',
              labelAnchor: charts.AnnotationLabelAnchor.end,
              color: charts.MaterialPalette.gray.shade300)
        ], defaultLabelPosition: charts.AnnotationLabelPosition.margin)
      ]),
    );
  }

  factory ScatterPlot.withDataTransform(
      List<ApiResponse> data, List<RecordingModel> recordings) {
    return new ScatterPlot(
      seriesList: _withDataTransform(data, recordings),
      animate: false,
    );
  }

  static _withDataTransform(
      List<ApiResponse> data, List<RecordingModel> recordings) {
    List<ScatterPoint> goodData = [];

    List<ScatterPoint> badData = [];

    List<ScatterPoint> unknownData = [];

    List<ScatterPoint> avgData = [];
    for (var i = 0; i < data.length; i++) {
      ApiResponse point = data[i];
      if (point.humidity == 0 && point.temp == 0) {
        continue;
      }
      final _date = DateTime.parse(point.timestamp);
      //  _date.microsecondsSinceEpoch
      final startTime = DateTime(_date.year, _date.month, _date.day, 00, 00);
      final endTime =
          DateTime(_date.year, _date.month, _date.day, 23, 59, 99, 99);

      bool found = false;
      if (recordings != null && recordings.length > 0) {
        for (RecordingModel item in recordings) {
          if (item == null || item.date == null) {
            continue;
          }
          final t = DateTime.fromMicrosecondsSinceEpoch(item.date);
          if (t.isAfter(startTime) && t.isBefore(endTime)) {
            found = true;
            if (item.rating == null) {
              unknownData.add(ScatterPoint(
                  point.temp,
                  point.humidity,
                  item.duration == null ? 1 : item.duration,
                  charts.Color.fromHex(code: "#979797")));
            } else if (item.rating < BadUpperLimit) {
              badData.add(ScatterPoint(point.temp, point.humidity,
                  item.duration, charts.Color.fromHex(code: "#F28890")));
            } else if (item.rating < GoodUpperLimit) {
              avgData.add(ScatterPoint(point.temp, point.humidity,
                  item.duration, charts.Color.fromHex(code: "#FFD93B")));
            } else {
              goodData.add(ScatterPoint(point.temp, point.humidity,
                  item.duration, charts.Color.fromHex(code: "#82CCC8")));
            }
            break;
          }
        }
      }

      if (!found) {
        unknownData.add(ScatterPoint(point.temp, point.humidity, 10000,
            charts.Color.fromHex(code: "#979797")));
      }
    }

    List<charts.Series<ScatterPoint, double>> chart = [];
    if (goodData.length > 0) {
      chart.add(_buildBubble('Good', goodData));
    }
    if (avgData.length > 0) {
      chart.add(_buildBubble('Average', avgData));
    }
    if (badData.length > 0) {
      chart.add(
        _buildBubble('Bad', badData),
      );
    }
    if (unknownData.length > 0) {
      chart.add(_buildBubble('Unknown', unknownData));
    }

    return chart;
  }
}

class ScatterPoint {
  final double temp;
  final double hum;
  final int radius;
  final charts.Color color;

  ScatterPoint(this.temp, this.hum, this.radius, this.color);
}

charts.Series<ScatterPoint, double> _buildBubble(
    String id, List<ScatterPoint> data) {
  return new charts.Series<ScatterPoint, double>(
      id: id,
      colorFn: (ScatterPoint point, _) => point.color,
      domainFn: (ScatterPoint point, _) => point.hum,
      measureFn: (ScatterPoint point, _) => point.temp,
      radiusPxFn: (ScatterPoint point, _) => point.radius / 1000.0,
      data: data);
}
