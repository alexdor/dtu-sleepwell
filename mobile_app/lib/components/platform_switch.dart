import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleep_well/helpers/platform_widget.dart';

class PlatformSwitch extends PlatformWidget<CupertinoSwitch, Switch> {
  final onChanged;
  final value;

  PlatformSwitch({this.onChanged, this.value});

  @override
  Switch createAndroidWidget(BuildContext context) {
    return new Switch(
      onChanged: onChanged,
      value: value,
    );
  }

  @override
  CupertinoSwitch createIosWidget(BuildContext context) {
    return new CupertinoSwitch(
      onChanged: onChanged,
      value: value,
    );
  }
}
