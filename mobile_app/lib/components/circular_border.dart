import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/painting.dart';
import 'package:quiver/collection.dart';
import 'package:sleep_well/helpers/enums.dart';

Future<ui.Image> load(String asset) async {
  ByteData data = await rootBundle.load(asset);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
  ui.FrameInfo fi = await codec.getNextFrame();
  return fi.image;
}

class CircularBorder extends StatefulWidget {
  final double size;
  final double width;
  final Widget icon;
  final CenterInfo centerInfo;

  const CircularBorder(
      {Key key, this.size = 70, this.width = 7.0, this.icon, this.centerInfo});

  @override
  createState() => new CircularBorderState(
      size: size, key: key, width: width, icon: icon, centerInfo: centerInfo);
}

class CircularBorderState extends State<CircularBorder> {
  final double size;
  final double width;
  final Widget icon;
  final CenterInfo centerInfo;
  ui.Image svgRoot;

  CircularBorderState(
      {Key key, this.size, this.width, this.icon, this.centerInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 55)),
          icon == null ? Container() : icon,
          CustomPaint(
            size: Size(size, size),
            foregroundPainter: new MyPainter(
                width: width, centerInfo: centerInfo, svgRoot: svgRoot),
          ),
          Padding(padding: EdgeInsets.only(bottom: 55)),
        ],
      ),
    );
  }

  loadSvg() async {
    String _ghost;
    if (centerInfo.percent == null) {
      _ghost = "assets/ghost_grey.png";
    } else if (centerInfo.percent < 35) {
      _ghost = "assets/ghost_red.png";
    } else if (centerInfo.percent < 70) {
      _ghost = "assets/ghost_yellow.png";
    } else {
      _ghost = "assets/ghost.png";
    }
    var tmp = await load(_ghost);
    setState(() => svgRoot = tmp);
  }

  @override
  initState() {
    super.initState();
    loadSvg();
  }
}

class CenterInfo {
  final String timeAsleep;
  final String when;
  final int percent;

  CenterInfo({this.percent, this.timeAsleep, this.when});
}

const Color _strokeColor = Color(0xff979797);
const Color _innerBackColor = Color(0xffE08E79);
final Paint _backgroundPaint = Paint()
  ..color = _innerBackColor
  ..strokeWidth = 24.0
  ..strokeJoin = StrokeJoin.round;

final TextStyle _textStyle = new TextStyle(
  color: _strokeColor,
  fontFamily: 'Comfortaa',
);
final String rawSvg = '''
    <svg width="40" height="40" viewBox="0 0 40 40" fill="none"
  xmlns="http://www.w3.org/2000/svg">
  <path d="M14.9791 12.3854C12.5107 12.3854 10.5026 14.3936 10.5026 16.8619C10.5026 19.3303 12.5108 21.3385 14.9791 21.3385C17.4475 21.3385 19.4557 19.3303 19.4557 16.8619C19.4557 14.3936 17.4476 12.3854 14.9791 12.3854ZM16.8619 18.0338C16.2151 18.0338 15.6901 17.5087 15.6901 16.8619C15.6901 16.2151 16.2151 15.6901 16.8619 15.6901C17.5087 15.6901 18.0338 16.2151 18.0338 16.8619C18.0338 17.5087 17.5087 18.0338 16.8619 18.0338Z" fill="#82CCC8"/>
  <path d="M31.2135 12.3854C28.7451 12.3854 26.7369 14.3936 26.7369 16.8619C26.7369 19.3303 28.7451 21.3385 31.2135 21.3385C33.6819 21.3385 35.6901 19.3303 35.6901 16.8619C35.6901 14.3936 33.6819 12.3854 31.2135 12.3854ZM33.0963 18.0338C32.4495 18.0338 31.9244 17.5087 31.9244 16.8619C31.9244 16.2151 32.4495 15.6901 33.0963 15.6901C33.7431 15.6901 34.2682 16.2151 34.2682 16.8619C34.2682 17.5087 33.7431 18.0338 33.0963 18.0338Z" fill="#82CCC8"/>
  <path d="M31.2135 23.6823C27.4528 23.6823 24.3932 20.6227 24.3932 16.862C24.3932 13.1012 27.4528 10.0416 31.2135 10.0416C33.189 10.0416 34.9706 10.8862 36.2174 12.2327C34.2028 5.17211 27.6974 0 20 0C10.6895 0 3.13806 7.56117 3.13806 16.862V35.6901C3.13806 38.0666 5.0715 40 7.44798 40C9.82447 40 11.7579 38.0666 11.7579 35.6901C11.7579 34.6059 12.6399 33.7239 13.7241 33.7239C14.8082 33.7239 15.6902 34.6059 15.6902 35.6901C15.6901 38.0666 17.6235 40 20 40C22.3765 40 24.3099 38.0666 24.3099 35.6901C24.3099 34.6059 25.192 33.7239 26.2761 33.7239C27.3602 33.7239 28.2423 34.6059 28.2423 35.6901C28.2423 38.0666 30.1757 40 32.5522 40C34.9287 40 36.8621 38.0666 36.8621 35.6901V20.6805C35.6344 22.4905 33.5606 23.6823 31.2135 23.6823ZM14.9792 23.6823C11.2184 23.6823 8.15884 20.6227 8.15884 16.862C8.15884 13.1012 11.2185 10.0416 14.9792 10.0416C18.7399 10.0416 21.7995 13.1012 21.7995 16.862C21.7995 20.6227 18.7399 23.6823 14.9792 23.6823Z" fill="#82CCC8"/>
</svg>

    ''';
// final Paint _centeBackground = new
// ..strokeWidth = 24.0
// ..style = PaintingStyle.stroke

class MyPainter extends CustomPainter {
  double width;
  CenterInfo centerInfo;
  final ui.Image svgRoot;

  MyPainter({this.width, this.centerInfo, this.svgRoot});
  @override
  paint(Canvas canvas, Size size) {
    double radius = min(size.width / 2.2, size.height / 2.2);
    var paint = Paint();
    paint.color = _strokeColor;

    paint.strokeWidth = 2;
    for (var i = 0.0; i <= 360; i += 2 * pi / 35) {
      var x = size.width / 2 + radius * cos(i);
      var y = size.height / 2 + radius * sin(i);
      var xLineEnd = x + 10 * cos(i);
      var yLineEnd = y + 10 * sin(i);
      canvas.drawLine(Offset(x, y), Offset(xLineEnd, yLineEnd), paint);
    }
    for (var count = 0; count <= 10; count++) {
      var i = count * 36;
      var x = size.width / 2 + radius * cos(i);
      var y = size.height / 2 + radius * sin(i);
      var xLineEnd = x + 10 * cos(i);
      var yLineEnd = y + 10 * sin(i);
      String text;
      switch (count) {
        case 1:
          text = "100";
          xLineEnd = x - 75 * cos(i);
          break;
        case 2:
          text = "75";
          yLineEnd = y + 22 * cos(i);
          xLineEnd = x + 15 * cos(i);
          break;
        case 3:
          text = "50";
          xLineEnd = x - 105 * cos(i);
          yLineEnd = y + 42 * cos(i);
          break;
        case 6:
          text = "67.5";
          break;
        case 7:
          text = "37.5";
          xLineEnd = x + 10 * cos(i);
          yLineEnd = y + 22 * cos(i);
          break;
        case 8:
          text = "17.5";
          xLineEnd = x + 80 * cos(i);
          yLineEnd = y + 40 * cos(i);
          break;
        case 9:
          text = "87.5";
          xLineEnd = x + 1 * cos(i);
          yLineEnd = y + 40 * cos(i);
          break;
      }

      if (text == null) {
        continue;
      }

      TextSpan span = new TextSpan(style: _textStyle, text: text);
      TextPainter tp =
          new TextPainter(text: span, textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(
          canvas,
          new Offset(xLineEnd + (15 * cos(i)) - tp.width / 2,
              yLineEnd + (15 * sin(i)) - tp.height / 2));
    }
    if (centerInfo == null) {
      return;
    }

    // Hours of sleep
    Offset center = new Offset(size.width / 2, size.height / 2);
    TextSpan span = new TextSpan(
        style: new TextStyle(
            color: AppBlackColor, fontFamily: 'Comfortaa', fontSize: 20),
        text: centerInfo.timeAsleep);
    TextPainter tp =
        new TextPainter(text: span, textDirection: TextDirection.ltr);
    tp.layout();
    Offset offset =
        new Offset(center.dx - tp.width / 2, center.dy - tp.height * 2);
    tp.paint(canvas, offset);

    // Time Asleep
    span = new TextSpan(
        style: new TextStyle(
            color: AppBlackColor, fontFamily: 'Comfortaa', fontSize: 10),
        text: "Time Asleep");
    TextPainter tpAsleep =
        new TextPainter(text: span, textDirection: TextDirection.ltr);
    tpAsleep.layout();
    offset = new Offset(
        center.dx - tpAsleep.width / 2, offset.dy + tpAsleep.height + 10);
    tpAsleep.paint(canvas, offset);

    // Last night
    span = new TextSpan(
        style: new TextStyle(
            color: Colors.white,
            fontFamily: 'Comfortaa',
            letterSpacing: 1,
            background: _backgroundPaint),
        text: "  ${centerInfo.when}  ");
    tp = new TextPainter(text: span, textDirection: TextDirection.ltr);
    tp.layout();
    offset = new Offset(center.dx - tp.width / 2, center.dy);
    tp.paint(canvas, offset);

    // Last line
    String _lastLine;
    if (centerInfo.percent == null) {
      _lastLine = "No data";
    } else if (centerInfo.percent < 35) {
      _lastLine = "${centerInfo.percent}% Bad";
    } else if (centerInfo.percent < 70) {
      _lastLine = "${centerInfo.percent}% Good";
    } else {
      _lastLine = "${centerInfo.percent}% Excelent";
    }

    span = new TextSpan(
        style: new TextStyle(
          color: AppBlackColor,
          fontFamily: 'Comfortaa',
        ),
        text: _lastLine);
    tp = new TextPainter(text: span, textDirection: TextDirection.ltr);
    tp.layout();
    offset = new Offset(center.dx - tp.width / 2, offset.dy + tp.height + 10);
    tp.paint(canvas, offset);

    if (svgRoot == null) {
      return;
    }
    // final SvgPicture svg = new SvgPicture.asset(
    //   'ghost.svg',
    // );
    // Size s = Size(20, 20);
    // svgRoot.scaleCanvasToViewBox(canvas, s);
    Rect _r = Offset(-999, -999) & Size(-999.0, -999.0);

    // svgRoot.clipCanvasToViewBox(canvas);
    // svgRoot.draw(canvas, ColorFilter.linearToSrgbGamma(), _r);
    // ui.Image _image = ;

    canvas.drawImage(
        svgRoot,
        Offset(center.dx - svgRoot.width / 2, offset.dy + svgRoot.height / 2),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class TextLayoutCache {
  final LruMap<TextSpan, TextPainter> _cache;
  final TextDirection textDirection;

  TextLayoutCache(this.textDirection, int maximumSize)
      : _cache = LruMap<TextSpan, TextPainter>(maximumSize: maximumSize);

  TextPainter getOrPerformLayout(TextSpan text) {
    final cachedPainter = _cache[text];
    if (cachedPainter != null) {
      return cachedPainter;
    } else {
      return _performAndCacheLayout(text);
    }
  }

  TextPainter _performAndCacheLayout(TextSpan text) {
    final textPainter = TextPainter(text: text, textDirection: textDirection);
    textPainter.layout();

    _cache[text] = textPainter;

    return textPainter;
  }
}
