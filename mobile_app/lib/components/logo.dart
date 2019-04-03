import 'package:flutter/cupertino.dart';

class Logo extends StatelessWidget {
  Logo({Key key}) : super(key: key);
  Widget _imageWidget(String imageAsset) => Image.asset(
        imageAsset,
        fit: BoxFit.cover,
      );

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width * 0.7;
    double maxHeight = MediaQuery.of(context).size.height * 0.7;
    return Container(
        child: new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: <Widget>[
              _imageWidget('assets/logo.png'),
              Text("Sleepwell"),
            ],
          ),
        )
      ],
    ));
  }
}
