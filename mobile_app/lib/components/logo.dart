import 'package:flutter/cupertino.dart';

class Logo extends StatelessWidget {
  Logo({Key key}) : super(key: key);
  Widget _imageWidget(String imageAsset) => Image.asset(imageAsset);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: new Column(
      children: <Widget>[_imageWidget('assets/logo.png'), Text("Sleepwell")],
    ));
  }
}
