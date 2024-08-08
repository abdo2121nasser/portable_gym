import 'package:flutter/material.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../resourses/blocks/general_blocks/general_app_bar_block.dart';
import '../../../../../resourses/blocks/general_blocks/general_button_block.dart';
import '../../../../../resourses/blocks/home_screen_blocks/nutrition_blocks/list_questions_with_choices_block.dart';
import '../../../../../resourses/managers_files/color_manager.dart';
import '../../../../../resourses/managers_files/font_manager.dart';
import '../../../../../resourses/managers_files/style_manager.dart';

class MealPlanCreationScreen extends StatelessWidget {
  const MealPlanCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBarBlock(
        title: S.of(context).mealPlan,
      ),
      body:  Column(
        children: [
          // ListOfQuestionsWithChoicesBlock(
          //   titles: ['Dietary Preferences','fdjhfd'],
          //   questions: ['What are your dietary preferences?','dfs'],
          //   choicesText: [['Vegetarian'],['dfdf','djdk']],
          //   choicesValues: [[true],[false,true]],
          //   isClientView: true,
          // ),
          GeneralButtonBlock(
              lable: S.of(context).create,
              function: () {},
              backgroundColor: ColorManager.kPurpleColor,
              textStyle: getMediumStyle(
                  fontSize: FontSize.s20,
                  color: ColorManager.kWhiteColor,
                  fontFamily: FontFamily.kPoppinsFont))

        ],
      ),
    );
  }
}
