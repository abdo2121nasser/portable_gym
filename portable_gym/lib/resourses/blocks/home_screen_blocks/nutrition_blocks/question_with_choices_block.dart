import 'package:flutter/material.dart';

import '../../../managers_files/color_manager.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';
import '../../../managers_files/values_manager.dart';
import '../../general_blocks/check_box_block.dart';

class QuestionWithChoicesBlock extends StatelessWidget {
  final String title;
  final String question;
  final List<String> choicesText;
  final List<bool>? choicesValues;
  final bool isClientView;
  const QuestionWithChoicesBlock({super.key,
     required this.title,
     required this.question,
required this.choicesText,
     this.choicesValues,
     required this.isClientView});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: AppVerticalSize.s10),
          child: Row(
            children: [
              Text(
                title,
                style: getMediumStyle(
                    fontSize: FontSize.s24,
                    color: ColorManager.kLimeGreenColor,
                    fontFamily: FontFamily.kPoppinsFont),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Text(
              question,
              style: getMediumStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.kWhiteColor,
                  fontFamily: FontFamily.kPoppinsFont),
            ),
          ],
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
          itemBuilder: (context, index) => CheckBoxBlock(
            value: choicesValues?[index],
            checkBoxFunction: (f) {},
            lable: choicesText[index],
            borderColor: ColorManager.kWhiteColor,
            textStyle: getLightStyle(
                fontSize: FontSize.s16,
                color: ColorManager.kWhiteColor,
                fontFamily: FontFamily.kLeagueSpartanFont),
            isSqecialCheckBox: !isClientView,
          ),
          itemCount: choicesText.length,
        )
      ],
    );
  }
}
