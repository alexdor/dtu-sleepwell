import 'package:flutter/cupertino.dart';

class Error extends StatelessWidget {
  final String error;
  const Error({Key key, this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Error: $error");
  }
}
