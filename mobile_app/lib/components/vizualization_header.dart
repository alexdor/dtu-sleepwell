import 'package:flutter/material.dart';
import 'package:sleep_well/components/app_button.dart';
import 'package:sleep_well/helpers/enums.dart';

final _padding = EdgeInsets.symmetric(horizontal: 25, vertical: 10);

class VizualizationHeader extends StatelessWidget {
  final VisualizationTypes vizType;
  const VizualizationHeader({Key key, this.vizType = VisualizationTypes.MONTH})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          AppButton(
              fillColor: AppBlueColor,
              text: 'Week',
              padding: _padding,
              onPress: () {
                if (vizType == VisualizationTypes.MONTH) {
                  Navigator.pushNamed(context, '/weekdata');
                }
              }),
          AppButton(
              fillColor: AppBlueColor,
              text: 'Month',
              padding: _padding,
              onPress: () {
                if (vizType == VisualizationTypes.WEEK) {
                  Navigator.pushNamed(context, '/monthdata');
                }
              }),
        ],
      ),
      Divider(),
      // new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      //   Container(
      //       margin: EdgeInsets.all(25.0), child: new Icon(Icons.arrow_left)),
      //   Container(
      //       margin: EdgeInsets.all(25.0),
      //       child: Text(
      //         "April 1 - April 7",
      //         style: TextStyle(color: AppBlackColor, fontSize: 18.0),
      //       )),
      //   Container(
      //       margin: EdgeInsets.all(25.0), child: new Icon(Icons.arrow_right)),
      // ]),
      // Divider()
    ]);
  }
}
