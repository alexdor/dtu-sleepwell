import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleep_well/helpers/enums.dart';

const Color buttonActiveColor = Color(0xFF789CE9);

class AppButton extends StatelessWidget {
  final Color fillColor;
  final Color activeColor;
  final String text;
  final bool active;
  final double width;
  final Function onPress;

  const AppButton(
      {Key key,
      this.active,
      this.activeColor = AppBlueColor,
      this.fillColor = buttonActiveColor,
      this.text,
      this.width,
      this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: active != null && active ? activeColor : fillColor,
      splashColor: Colors.orangeAccent,
      child: Padding(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: width,
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Comfortaa',
                fontSize: 18,
              ),
            ),
          ],
        ),
        padding: EdgeInsets.all(10.0),
      ),
      elevation: 3.0,
      onPressed: () {
        onPress();
      },
      shape: StadiumBorder(),
    );
  }
}
