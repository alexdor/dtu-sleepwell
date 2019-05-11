import 'package:flutter/material.dart';
import 'package:sleep_well/helpers/enums.dart';

class QuestionTSelectSymptoms extends StatefulWidget {
  QuestionTSelectSymptoms({Key key}) : super(key: key);

  _QuestionTSelectSymptoms createState() => _QuestionTSelectSymptoms();
}

class _QuestionTSelectSymptoms extends State<QuestionTSelectSymptoms> {
  Color _myColorHeadache = Color(0xFF789CE9);
  Color _myColorNightmares = Color(0xFF789CE9);
  Color _myColorFreezing = Color(0xFF789CE9);
  Color _myColorSweating = Color(0xFF789CE9);
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width * 2 / 5;
    return new Container(
      child: new Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RawMaterialButton(
                fillColor: _myColorHeadache,
                splashColor: Colors.orangeAccent,
                child: Padding(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: _width,
                      ),
                      Text(
                        'Headache',
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
                  setState(() {
                    if (_myColorHeadache == Color(0xFF789CE9)) {
                      _myColorHeadache = AppBlueColor;
                    } else {
                      _myColorHeadache = Color(0xFF789CE9);
                    }
                  });
                },
                shape: StadiumBorder(),
              ),

              ///here
              RawMaterialButton(
                fillColor: _myColorNightmares,
                splashColor: Colors.orangeAccent,
                child: Padding(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: _width,
                      ),
                      Text(
                        'Nightmares',
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
                  setState(() {
                    if (_myColorNightmares == Color(0xFF789CE9)) {
                      _myColorNightmares = AppBlueColor;
                    } else {
                      _myColorNightmares = Color(0xFF789CE9);
                    }
                  });
                },
                shape: StadiumBorder(),
              ),
            ],
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RawMaterialButton(
                fillColor: _myColorFreezing,
                splashColor: Colors.orangeAccent,
                child: Padding(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: _width,
                      ),
                      Text(
                        'Freezing',
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
                  setState(() {
                    if (_myColorFreezing == Color(0xFF789CE9)) {
                      _myColorFreezing = AppBlueColor;
                    } else {
                      _myColorFreezing = Color(0xFF789CE9);
                    }
                  });
                },
                shape: StadiumBorder(),
              ),

              ///here
              RawMaterialButton(
                fillColor: _myColorSweating,
                splashColor: Colors.orangeAccent,
                child: Padding(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: _width,
                      ),
                      Text(
                        'Sweating',
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
                  setState(() {
                    if (_myColorSweating == Color(0xFF789CE9)) {
                      _myColorSweating = AppBlueColor;
                    } else {
                      _myColorSweating = Color(0xFF789CE9);
                    }
                  });
                },
                shape: StadiumBorder(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
