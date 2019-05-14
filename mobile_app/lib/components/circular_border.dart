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
    } else if (centerInfo.percent < BadUpperLimit) {
      _ghost = "assets/ghost_red.png";
    } else if (centerInfo.percent < GoodUpperLimit) {
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
  final double percent;

  CenterInfo({this.percent, this.timeAsleep, this.when});
}

const Color _strokeColor = Color(0xff979797);
final Paint _backgroundPaint = Paint()
  ..color = SecondaryBackgroundColor
  ..strokeWidth = 24.0
  ..strokeJoin = StrokeJoin.round;

final TextStyle _textStyle = new TextStyle(
  color: _strokeColor,
  fontFamily: 'Comfortaa',
);

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
    for (var count = 0; count < 10; count++) {
      var i = count * 36;
      var x = size.width / 2 + radius * cos(i);
      var y = size.height / 2 + radius * sin(i);
      var xLineEnd = x + 10 * cos(i);
      var yLineEnd = y + 10 * sin(i);
      String text;
      switch (count) {
        case 0:
          text = "25";
          break;
        case 1:
          text = "100";
          xLineEnd = x - 100 * cos(i);
          break;
        case 2:
          text = "75";
          yLineEnd = y + 50 * cos(i);
          xLineEnd = x + 15 * cos(i);
          break;
        case 3:
          text = "50";
          xLineEnd = x - 165 * cos(i);
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
        text: centerInfo.percent == null ? "" : "Time Asleep");
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
      _lastLine = "";
    } else if (centerInfo.percent < 35) {
      _lastLine = "${centerInfo.percent}% Bad";
    } else if (centerInfo.percent < 70) {
      _lastLine = "${centerInfo.percent}% Good";
    } else {
      _lastLine = "${centerInfo.percent}% Excellent";
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
