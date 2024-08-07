import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/nutrition_blocks/question_with_choices_block.dart';

import '../../../../generated/l10n.dart';
import '../../../managers_files/color_manager.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';
import '../../../managers_files/values_manager.dart';
import '../../general_blocks/general_button_block.dart';

class ListOfQuestionsWithChoicesBlock extends StatelessWidget {
  final List<String> titles;
  final List<String> questions;
  final List<String> choicesText;
  final List<bool>? choicesValues;
  final bool isClientView;

  const ListOfQuestionsWithChoicesBlock({
      required this.titles,
      required this.questions,
      required this.choicesText,
       this.choicesValues,
      this.isClientView=true,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s14),
          itemBuilder: (context, index) => index == titles.length
              ? GeneralButtonBlock(
                  lable: S.of(context).create,
                  function: () {},
                  backgroundColor: ColorManager.kPurpleColor,
                  textStyle: getMediumStyle(
                      fontSize: FontSize.s20,
                      color: ColorManager.kWhiteColor,
                      fontFamily: FontFamily.kPoppinsFont))
              :  QuestionWithChoicesBlock(
            title: titles[index],
            question: questions[index],
            choicesText: choicesText,
            choicesValues: choicesValues==null?null:choicesValues,
            isClientView: isClientView,
          ),
          separatorBuilder: (context, index) => const SizedBox(
                height: 5,
              ),
          itemCount:titles.length+1),
    );
  }
}
