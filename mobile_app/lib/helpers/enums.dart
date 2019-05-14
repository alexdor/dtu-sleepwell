import 'dart:ui';
import 'package:flutter/material.dart';

const Color AppBlackColor = Color(0xFF382E21);
const Color AppBlueColor = Color(0xFF446EB6);
const Color BackgroundColor = Color(0xFFF4E6D4);
const Color SecondaryBackgroundColor = Color(0xffE08E79);

const double BadUpperLimit = 35;
const double GoodUpperLimit = 70;

final DefaultFontFamily = new TextStyle(
  fontFamily: 'Comfortaa',
);

final FootnoteStyle =
    new TextStyle(color: Colors.grey, fontFamily: 'Comfortaa');

const APIURL = 'https://sleep-well.cdrproject.com/';

enum VisualizationTypes { MONTH, WEEK }
