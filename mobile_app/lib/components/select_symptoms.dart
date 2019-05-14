import 'package:flutter/material.dart';
import 'package:sleep_well/components/app_button.dart';
import 'package:sleep_well/models/symptoms.dart';

class RecordSymptoms extends StatelessWidget {
  final RecordingModel model;
  final Function onHeadachePress;
  final Function onFreezingPress;
  final Function onSweatingPress;
  final Function onNightmaresPress;

  const RecordSymptoms(
      {Key key,
      this.model,
      this.onHeadachePress,
      this.onFreezingPress,
      this.onSweatingPress,
      this.onNightmaresPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width * 2 / 5;
    return new Container(
        child: new Column(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          AppButton(
            active: model.headace != null && model.headace == 1,
            text: "Headache",
            width: _width,
            onPress: onHeadachePress,
          ),
          AppButton(
            active: model.nightmares != null && model.nightmares == 1,
            text: "Nightmares",
            width: _width,
            onPress: onNightmaresPress,
          ),
        ],
      ),
      Row(
        children: <Widget>[
          AppButton(
            active: model.freezing != null && model.freezing == 1,
            text: "Freezing",
            width: _width,
            onPress: onFreezingPress,
          ),
          AppButton(
            active: model.sweating != null && model.sweating == 1,
            text: "Sweating",
            width: _width,
            onPress: onSweatingPress,
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      )
    ]));
  }
}
