

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/style_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import 'font_manager.dart';




ThemeData getAppTheme()
{
  return ThemeData(
      scaffoldBackgroundColor: ColorManager.kBlackColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s16, vertical:  AppVerticalSize.s5),
      hintStyle: getRegularStyle(fontSize: FontSize.s20, color: ColorManager.kBlackColor, fontFamily: FontFamily.kLeagueSpartanFont),
      labelStyle: getRegularStyle(fontSize: FontSize.s20, color: ColorManager.kBlackColor, fontFamily: FontFamily.kLeagueSpartanFont),
      //error style
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(AppRadiusSize.s16))
      ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
       //     borderSide: const BorderSide(color: ColorManager.kPurpleColor),
    borderRadius: BorderRadius.all(Radius.circular(AppRadiusSize.s16))
  )
    ),
      // buttonTheme: ButtonThemeData(
      // shape:StadiumBorder()
  //)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style:ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadiusSize.s22),
              side: BorderSide(color: ColorManager.kWhiteColor,width: FontSize.s1)
        )
      )
    )




  );
}