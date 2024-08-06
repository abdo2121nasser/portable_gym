import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/check_box_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../resourses/blocks/general_blocks/general_app_bar_block.dart';
import '../../../../../resourses/blocks/general_blocks/general_button_block.dart';
import '../../../../../resourses/blocks/home_screen_blocks/nutrition_blocks/question_with_choices_block.dart';
import '../../../../../resourses/managers_files/font_manager.dart';
import '../../../../../resourses/managers_files/style_manager.dart';

class MealPlanCreationScreen extends StatelessWidget {
  MealPlanCreationScreen({super.key});
  GroupController controller = GroupController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBarBlock(
        title: S.of(context).mealPlan,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                    horizontal: AppHorizontalSize.s14),
                itemBuilder: (context, index) =>
                    index==(7+1)-1?GeneralButtonBlock(
                        lable: S.of(context).create,
                        function: () {

                        },
                        backgroundColor: ColorManager.kPurpleColor,
                        textStyle: getMediumStyle(
                            fontSize: FontSize.s20,
                            color: ColorManager.kWhiteColor,
                            fontFamily: FontFamily.kPoppinsFont)):
                    const QuestionWithChoicesBlock(),
                separatorBuilder: (context, index) => const SizedBox(height: 5,),
                itemCount: 7+1),
          ),

        ],
      ),
    );
  }
}
