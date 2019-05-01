import 'package:flutter/material.dart';

class PageDecoration {
  /// Background page color
  ///
  /// @Default `Colors.white`
  final Color pageColor;

  /// Progress indicator color
  ///
  /// @Default `Colors.blue`
  final Color progressColor;

  /// Progress indicator size
  ///
  /// @Default `Size.fromRadius(5.0)`
  final Size progressSize;

  /// TextStyle for title
  ///
  /// @Default style `fontSize: 20.0, fontWeight: FontWeight.bold`
  final TextStyle titleTextStyle;

  /// TextStyle for title
  ///
  /// @Default style `fontSize: 18.0, fontWeight: FontWeight.normal`
  final TextStyle bodyTextStyle;

  /// BoxDecoration for page
  final BoxDecoration boxDecoration;

  /// Flex ratio of the image
  final int imageFlex;

  /// Flex ratio of the body
  final int bodyFlex;
  const PageDecoration({
    this.pageColor = const Color(0xFFF4E6D4),
    this.progressColor = const Color(0xFFF47D30),//Colors.lightBlue,
    this.progressSize = const Size.fromRadius(10.0),
    this.titleTextStyle = const TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      color: Color(0xFF382E21),
      fontFamily: 'Comfortaa',
    ),
        textAlign: TextAlign.center,
    this.bodyTextStyle = const TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.normal,
      fontFamily: 'Comfortaa',
      color: Color(0xFF382E21),
      fontStyle: FontStyle.italic,
    ),
    this.boxDecoration,
    this.imageFlex = 1,
    this.bodyFlex = 1,
  }) : assert(pageColor == null || boxDecoration == null,
            'Cannot provide both a Color and a BoxDecoration\n');
}
