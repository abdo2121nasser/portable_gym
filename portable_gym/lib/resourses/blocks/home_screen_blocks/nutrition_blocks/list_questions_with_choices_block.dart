import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/nutrition_blocks/question_with_choices_block.dart';
import 'package:portable_gym/resourses/models/setting_models/meal_plan_question_model.dart';

import '../../../../generated/l10n.dart';
import '../../../managers_files/color_manager.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';
import '../../../managers_files/values_manager.dart';
import '../../general_blocks/general_button_block.dart';

class ListOfQuestionsWithChoicesBlock extends StatelessWidget {
 final List<MealPlanQuestionModel> model;
  final bool isClientView;

  const ListOfQuestionsWithChoicesBlock({
     required this.model,
      this.isClientView=true,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s14),
          itemBuilder: (context, index) =>

          QuestionWithChoicesBlock(
            title: model[index].getLanguageClass(context).title,
            question: model[index].getLanguageClass(context).question,
       answers:  model[index].getLanguageClass(context).answers,
            isClientView: isClientView,
          ),
          separatorBuilder: (context, index) => SizedBox(
                height: AppHorizontalSize.s5,
              ),
          itemCount:model.length),
    );
  }
}
