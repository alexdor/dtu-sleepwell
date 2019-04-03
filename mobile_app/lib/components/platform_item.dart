import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleep_well/helpers/platform_widget.dart';

class ItemWidget extends PlatformWidget<Widget, Widget> {
  final Widget child;

  ItemWidget({this.child});

  @override
  Widget createAndroidWidget(BuildContext context) => new Card(
        child: child,
      );
  @override
  Widget createIosWidget(BuildContext context) => child;
}
