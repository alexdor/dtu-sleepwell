import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sleep_well/components/bar_chart.dart';
import 'package:sleep_well/components/loading.dart';
import 'package:sleep_well/components/error.dart';
import 'package:sleep_well/components/scaffold.dart';
import 'package:sleep_well/components/scatter_plot.dart';
import 'package:sleep_well/components/vizualization_header.dart';
import 'package:sleep_well/helpers/enums.dart';
import 'package:http/http.dart' as http;
import 'package:sleep_well/models/api_response.dart';
import 'package:sleep_well/models/symptoms.dart';

class VizualizationScreen extends StatefulWidget {
  final VisualizationTypes type;
  VizualizationScreen({Key key, this.type}) : super(key: key);

  _VizualizationScreenState createState() => _VizualizationScreenState(type);
}

class _VizualizationScreenState extends State<VizualizationScreen> {
  List<ApiResponse> data;
  final VisualizationTypes type;
  List<RecordingModel> recording;
  String error;
  bool loading = true;

  _VizualizationScreenState(this.type);

  @override
  void initState() {
    super.initState();
    fetchData();
    if (type == VisualizationTypes.WEEK) {
      fetchSymptoms();
    }
  }

  void fetchSymptoms() async {
    DateTime now = new DateTime.now();
    DateTime start = now.subtract(new Duration(days: now.weekday));
    List<RecordingModel> tmp = await symptomsBetween(
        start.microsecondsSinceEpoch, now.microsecondsSinceEpoch);
    this.setState(() {
      recording = tmp;
    });
  }

  void fetchData() async {
    this.setState(() {
      error = null;
    });
    try {
      var response = await http.get(
          "$APIURL/duration?type=${type == VisualizationTypes.MONTH ? 'month' : 'week'}");
      if (response.statusCode != 200) {
        this.setState(() {
          error = "Network error";
          loading = false;
        });
        return;
      }
      List body = jsonDecode(response.body);
      List<ApiResponse> tmp =
          body.map((f) => new ApiResponse.fromJSON(f)).toList();

      this.setState(() {
        data = tmp;
        error = null;
        loading = false;
      });
    } catch (e) {
      print(e);
      this.setState(() {
        error = "Network error";
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
        title: Text("Statistics"),
        body: new Container(
            child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.08),
                children: <Widget>[
              VizualizationHeader(
                vizType: type,
              ),
              error != null ? Error(error: error) : Text(""),
              !loading && data != null
                  ? (type == VisualizationTypes.MONTH
                      ? BarChart.withDataTransform(data)
                      : recording != null
                          ? ScatterPlot.withDataTransform(data, recording)
                          : Loading())
                  : Loading()
            ])));
  }
}
