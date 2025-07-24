import 'package:flutter/material.dart';

class Query {
  static double _screenWidth = 0;
  static double _screenHeight = 0;

  static void init(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
  }

  static double kaliWidth(double multiplier) {
    return _screenWidth * multiplier;
  }

  static double kaliHeight(double multiplier) {
    return _screenHeight * multiplier;
  }

  static double bagiWidth(double divider) {
    return _screenWidth / divider;
  }

  static double bagiHeight(double divider) {
    return _screenHeight / divider;
  }
}