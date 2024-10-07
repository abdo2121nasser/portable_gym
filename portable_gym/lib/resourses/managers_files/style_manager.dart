import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(bool textOverflow, double fontSize, Color color,
    String fontFamily, FontWeight fontWeight) {
  return TextStyle(

      overflow:textOverflow? TextOverflow.ellipsis:null,
      color: color,
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight);
}

// bold font
TextStyle getBoldStyle(
    {required double fontSize,
    required Color color,
    bool textOverflow=false,
    required String fontFamily}) {
  return _getTextStyle(
      textOverflow, fontSize, color, fontFamily, FontWeightManager.bold);
}

// regular font
TextStyle getRegularStyle(
    {required double fontSize,
    required Color color,
      bool textOverflow=false,
    required String fontFamily}) {
  return _getTextStyle(
      textOverflow, fontSize, color, fontFamily, FontWeightManager.regular);
}

// light font
TextStyle getLightStyle(
    {required double fontSize,
    required Color color,
      bool textOverflow=false,
    required String fontFamily}) {
  return _getTextStyle(
      textOverflow, fontSize, color, fontFamily, FontWeightManager.light);
}

// thin font
TextStyle getThinStyle(
    {required double fontSize,
    required Color color,
      bool textOverflow=false,
    required String fontFamily}) {
  return _getTextStyle(
      textOverflow, fontSize, color, fontFamily, FontWeightManager.thin);
}

// medium font
TextStyle getMediumStyle(
    {required double fontSize,
    required Color color,
      bool textOverflow=false,
    required String fontFamily}) {
  return _getTextStyle(
      textOverflow, fontSize, color, fontFamily, FontWeightManager.medium);
}

// semiBold font
TextStyle getSemiBoldStyle(
    {required double fontSize,
    required Color color,
      bool textOverflow=false,
    required String fontFamily}) {
  return _getTextStyle(
      textOverflow, fontSize, color, fontFamily, FontWeightManager.semiBold);
}
