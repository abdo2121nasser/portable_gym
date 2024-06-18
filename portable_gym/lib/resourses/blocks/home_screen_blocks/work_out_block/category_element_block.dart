import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../../managers_files/color_manager.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';



class CategoryElementBlock extends StatelessWidget {
      final String lable;

      CategoryElementBlock({required this.lable});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppRadiusSize.s12),
      decoration: BoxDecoration(
        borderRadius:  BorderRadius.circular(AppRadiusSize.s22),
         color: ColorManager.kWhiteColor
      ),
      child:  Text(
         lable,
        textAlign: TextAlign.center,
        style: getMeduimStyle(
            fontSize: FontSize.s16,
            color: ColorManager.kBlackColor,
            fontFamily: FontFamily.kLeagueSpartanFont),
      ),

    );
  }
}
