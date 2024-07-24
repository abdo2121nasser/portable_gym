import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';




class FoodMainElementBlock extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback deleteFunction;

  FoodMainElementBlock({required this.title, required this.content,required this.deleteFunction});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s30,
          vertical: AppVerticalSize.s10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadiusSize.s22),
            border: Border.all(width: AppHorizontalSize.s1_5,color: ColorManager.kWhiteColor)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
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
Align(
    alignment: Alignment.topRight,
    child: Padding(
      padding:  EdgeInsets.symmetric(horizontal: AppHorizontalSize.s5,vertical: AppVerticalSize.s14),
      child: InkWell(
          onTap: deleteFunction,
          child: Icon(Icons.delete,color: ColorManager.kRed,)),
    ))
      ],
    );
  }
}
