import 'package:flutter/material.dart';

import '../../../managers_files/color_manager.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';
import '../../../managers_files/values_manager.dart';



class QuestionWithAnswer extends StatelessWidget {
 final String title;
 final String question;
 final String answer;

 const QuestionWithAnswer({super.key, required this.title,required this.question,required this.answer});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
        title,
          style: getMediumStyle(
              fontSize: FontSize.s24,
              color: ColorManager.kLimeGreenColor,
              fontFamily: FontFamily.kPoppinsFont),
        ),
        Text(
       question,
          style: getMediumStyle(
              fontSize: FontSize.s14,
              color: ColorManager.kWhiteColor,
              fontFamily: FontFamily.kPoppinsFont),
        ),
        Text(
      answer,
          style:getLightStyle(
              fontSize: FontSize.s16,
              color: ColorManager.kWhiteColor,
              fontFamily: FontFamily.kLeagueSpartanFont),
        ),
      ],
    );
  }
}
