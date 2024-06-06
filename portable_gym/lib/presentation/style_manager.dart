import 'dart:ui';

import 'package:portable_gym/presentation/font_manager.dart';


TextStyle _getTextStyle(double fontSize, Color color, String fontFamily,FontWeight fontWeight)
{
  return TextStyle(color: color, fontSize: fontSize,fontFamily: fontFamily, fontWeight: fontWeight);
}

// bold font
TextStyle getBoldStyle({required double fontSize, required Color color,required String fontFamily})
{
  return _getTextStyle(fontSize, color, fontFamily ,FontWeightManager.bold);
}

// regular font
TextStyle getRegularStyle({required double fontsize, required Color color,required String fontFamily})
{
  return _getTextStyle(fontsize, color, fontFamily ,FontWeightManager.regular);
}

// light font
TextStyle getLightStyle({required double fontSize, required Color color,required String fontFamily})
{
  return _getTextStyle(fontSize, color, fontFamily ,FontWeightManager.light);
}


// thin font
TextStyle getThinStyle({required double fontSize, required Color color,required String fontFamily})
{
  return _getTextStyle(fontSize, color, fontFamily ,FontWeightManager.thin);
}


// medium font
TextStyle getMeduimStyle({required double fontSize, required Color color,required String fontFamily})
{
  return _getTextStyle(fontSize, color, fontFamily ,FontWeightManager.medium);
}


// semiBold font
TextStyle getSemiBoldStyle({required double fontSize, required Color color,required String fontFamily})
{
  return _getTextStyle(fontSize, color, fontFamily ,FontWeightManager.semiBold);
}
