import 'package:flutter/material.dart';

import '../../../managers_files/color_manager.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';
import '../../../managers_files/values_manager.dart';
import '../../general_blocks/check_box_block.dart';






class QuestionWithChoicesBlock extends StatelessWidget {
  const QuestionWithChoicesBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  EdgeInsets.symmetric(vertical: AppVerticalSize.s10),
          child: Text(
            'Dietary Preferences',
            style: getMediumStyle(
                fontSize: FontSize.s24,
                color:ColorManager.kLimeGreenColor,
                fontFamily: FontFamily.kPoppinsFont),
          ),
        ) ,
        Text(
          'What are your dietary preferences?',
          style: getMediumStyle(
              fontSize: FontSize.s14,
              color:ColorManager.kWhiteColor,
              fontFamily: FontFamily.kPoppinsFont),
        ),

        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: AppVerticalSize.s14),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // mainAxisExtent: 140,
              crossAxisSpacing: 0,
              childAspectRatio: (2.5 / 0.3),
              mainAxisSpacing: 15),
          itemBuilder: (context, index) =>  CheckBoxBlock(value: false, function: (f){}, lable: 'Vegetarian',
    borderColor: ColorManager.kWhiteColor,
    textStyle: getLightStyle(
    fontSize: FontSize.s16,
    color: ColorManager.kWhiteColor,
    fontFamily: FontFamily.kLeagueSpartanFont),),
          itemCount:7,
        )
      ],
    );
  }
}
