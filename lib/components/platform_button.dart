import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleep_well/helpers/platform_widget.dart';

class PlatformButton extends PlatformWidget<CupertinoButton, RaisedButton> {
  final VoidCallback onPressed;
  final Widget child;

  PlatformButton({this.child, this.onPressed});

  @override
  RaisedButton createAndroidWidget(BuildContext context) {
    return new RaisedButton(
      child: child,
      onPressed: onPressed,
    );
  }

  @override
  CupertinoButton createIosWidget(BuildContext context) {
    return new CupertinoButton(
      child: child,
      onPressed: onPressed,
      color: Colors.blue,
    );
  }
}
