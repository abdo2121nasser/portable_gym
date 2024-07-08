import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../../managers_files/color_manager.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';



class ElementCategoryBlock extends StatelessWidget {
      final String lable;
      final Color color;


      ElementCategoryBlock({required this.lable,required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s12,vertical: AppVerticalSize.s14),
      decoration: BoxDecoration(
        borderRadius:  BorderRadius.circular(AppRadiusSize.s22),
         color:color
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
