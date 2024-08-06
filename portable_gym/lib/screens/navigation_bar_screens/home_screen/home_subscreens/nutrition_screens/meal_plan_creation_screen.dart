import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/check_box_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../resourses/blocks/general_blocks/general_app_bar_block.dart';
import '../../../../../resourses/managers_files/font_manager.dart';
import '../../../../../resourses/managers_files/style_manager.dart';



class MealPlanCreationScreen extends StatelessWidget {
   MealPlanCreationScreen({super.key});
  GroupController controller=GroupController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBarBlock(title:S.of(context).mealPlan,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dietary Preferences',
              style: getMediumStyle(
                  fontSize: FontSize.s20,
                  color:ColorManager.kLimeGreenColor,
                  fontFamily: FontFamily.kPoppinsFont),
            ) ,
            Text(
              'What are your dietary preferences?',
              style: getMediumStyle(
                  fontSize: FontSize.s14,
                  color:ColorManager.kWhiteColor,
                  fontFamily: FontFamily.kPoppinsFont),
            ),
            CheckBoxBlock(value: true, function: (f){}, lable: 'Vegetarian',
              textStyle: getLightStyle(
                fontSize: FontSize.s14,
                color: ColorManager.kWhiteColor,
                fontFamily: FontFamily.kLeagueSpartanFont),)
            ],
        ),
      ),
    );
  }
}
