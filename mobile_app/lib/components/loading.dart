import 'package:flutter/cupertino.dart';
import 'package:sleep_well/helpers/enums.dart';

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      child: Text("Loading", style: DefaultFontFamily),
      padding: EdgeInsets.all(10),
    ));
  }
}
