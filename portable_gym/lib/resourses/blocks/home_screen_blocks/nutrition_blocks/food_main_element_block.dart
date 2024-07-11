import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';




class FoodMainElementBlock extends StatelessWidget {
  final String title;
  final String content;

  FoodMainElementBlock({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s14,
      vertical: AppVerticalSize.s14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadiusSize.s22),
        border: Border.all(width: AppHorizontalSize.s1_5,color: ColorManager.kWhiteColor)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: AppVerticalSize.s30,
            width: AppHorizontalSize.s150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                   title,
                    style: getSemiBoldStyle(
                        fontSize: FontSize.s20,
                        color: ColorManager.kLimeGreenColor,
                        fontFamily: FontFamily.kPoppinsFont),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: AppVerticalSize.s10,),
      SizedBox(
        height: AppVerticalSize.s44,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                 content,
                  style: getMeduimStyle(
                      fontSize: FontSize.s12,
                      color: ColorManager.kWhiteColor,
                      fontFamily: FontFamily.kPoppinsFont),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
        ],
      ),
    );
  }
}
