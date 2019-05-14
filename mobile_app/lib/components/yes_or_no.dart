import 'package:flutter/material.dart';
import 'package:sleep_well/components/app_button.dart';

class YesOrNo extends StatelessWidget {
  final Function yesPress;
  final bool yes;
  final Function noPress;
  final bool no;

  const YesOrNo({Key key, this.no, this.noPress, this.yes, this.yesPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width * 2 / 5;
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        AppButton(
          text: 'Yes',
          width: _width,
          onPress: yesPress,
          active: yes,
        ),
        AppButton(
          text: 'No',
          width: _width,
          onPress: noPress,
          active: no,
        )
      ],
    );
  }
}
