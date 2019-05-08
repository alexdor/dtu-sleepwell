import 'package:flutter/material.dart';

class QuestionThing extends StatelessWidget {
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        RawMaterialButton(
          fillColor: Color(0xFF789CE9),
          splashColor: Colors.orangeAccent,
          child: Padding(
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: 100.0,
                ),
                Text(
                  'Yes',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Comfortaa',
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            padding: EdgeInsets.all(10.0),
          ),
          elevation: 3.0,
          onPressed: () {
            //Navigator.push(
            //context,
            //MaterialPageRoute(builder: (context) => SecondIntroPage()),
            //);
          },
          shape: StadiumBorder(),
        ),
        RawMaterialButton(
          fillColor: Color(0xFF789CE9),
          splashColor: Colors.orangeAccent,
          child: Padding(
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: 100.0,
                ),
                Text(
                  'No',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Comfortaa',
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
            padding: EdgeInsets.all(10.0),
          ),
          elevation: 3.0,
          onPressed: () {
            //Navigator.push(
            //context,
            //MaterialPageRoute(builder: (context) => SecondIntroPage()),
            //);
          },
          shape: StadiumBorder(),
        ),
      ],
    );
  }
}
