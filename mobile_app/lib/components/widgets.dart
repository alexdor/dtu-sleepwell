import 'package:flutter/material.dart';
import 'package:sleep_well/helpers/enums.dart';

class Text2PageSecond extends StatelessWidget {
  Widget build(BuildContext context) {
    return new Center(
        child: new Text(
      'Our application tracks temperature and humidity to help you have refreshing mornings.',
      style: TextStyle(
        fontFamily: 'Comfortaa',
        color: AppBlackColor,
        fontSize: 20.0,
        fontStyle: FontStyle.italic,
      ),
      textAlign: TextAlign.center,
    ));
  }
}

class FirstIntroScreenImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var assetsImage = new AssetImage('assets/Logo_with_text.png');
    var image = new Image(
      image: assetsImage,
      width: 297.0,
      height: 151.0,
    );
    return new Container(
      child: image,
    );
  }
}

class SecondIntroScreenImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var assetsImage = new AssetImage(
        'assets/temperature.png'); //Problem with the temperature.png image
    var image = new Image(
      image: assetsImage,
      width: 297.0,
      height: 200.0,
    );
    return new Container(
      child: image,
    );
  }
}

class ThirdIntroScreenImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var assetsImage = new AssetImage(
        'assets/sleep2.png'); //Problem with the temperature.png image
    var image = new Image(
      image: assetsImage,
      width: 297.0,
      height: 403.0,
    );
    return new Container(
      child: image,
    );
  }
}

class ForthIntroScreenImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var assetsImage = new AssetImage(
        'assets/unplugged.png'); //Problem with the temperature.png image
    var image = new Image(
      image: assetsImage,
      width: 297.0,
      height: 250.0,
    );
    return new Container(
      child: image,
    );
  }
}

class FifthIntroScreenImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var assetsImage = new AssetImage(
        'assets/goal2.png'); //Problem with the temperature.png image
    var image = new Image(
      image: assetsImage,
      width: 297.0,
      height: 274.0,
    );
    return new Container(
      child: image,
    );
  }
}

class GetStartedButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Color(0xFFF47D30),
      splashColor: Colors.orangeAccent,
      child: Padding(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 180.0,
            ),
            Text(
              'Get Started',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Comfortaa',
                fontSize: 24.0,
              ),
            ),
          ],
        ),
        padding: EdgeInsets.all(15.0),
      ),
      elevation: 5.0,
      onPressed: () {
        //Navigator.push(
        //context,
        //MaterialPageRoute(builder: (context) => SecondIntroPage()),
        //);
      },
      shape: StadiumBorder(),
    );
  }
}
