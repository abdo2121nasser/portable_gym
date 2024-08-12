import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/nutrition_blocks/question_with_answer_block.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:portable_gym/resourses/models/nutrition_models/meal_plan_requests_model.dart';
import 'package:portable_gym/resourses/models/setting_models/meal_plan_question_model.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../resourses/blocks/general_blocks/general_app_bar_block.dart';

class AnswersOfQuestionsScreen extends StatelessWidget {
  final List<MealPlanQuestionModel> model;

  const AnswersOfQuestionsScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBarBlock(
        title: S.of(context).questions,
      ),
      body: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s22),
          itemBuilder: (context, index) => QuestionWithAnswer(
              title:
                  model[index].getLanguageClass(context).title,
              question: model[index].getLanguageClass(context).question,
              answer: getTheOnlyTrueAnswer(answers: model[index].getLanguageClass(context).answers)!
          ),
          separatorBuilder: (context, index) => SizedBox(
                height: AppVerticalSize.s5,
              ),
          itemCount: model.length),
    );
  }

 String getTheOnlyTrueAnswer({required List<Answer> answers}){
 for(int i=0;i<answers.length;i++){
   if(answers[i].value==true)
   {
     return answers[i].text;
   }
 }
 return "no selected choice";
  }

}
