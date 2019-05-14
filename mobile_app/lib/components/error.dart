import 'package:flutter/cupertino.dart';
import 'package:sleep_well/helpers/enums.dart';

class ErrorSleepWell extends StatelessWidget {
  final String error;
  const ErrorSleepWell({Key key, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      child: Text("Error: $error", style: DefaultFontFamily),
      padding: EdgeInsets.all(10),
    ));
  }
}
