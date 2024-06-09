
   import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/font_manager.dart';

getToastMessage({required String message})
   {
     Fluttertoast.showToast(
         msg: message,
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.BOTTOM,
         timeInSecForIosWeb: 1,
         textColor: ColorManager.kWhiteColor,
         backgroundColor: ColorManager.kPurpleColor,
         fontSize: FontSize.s16
     );
   }