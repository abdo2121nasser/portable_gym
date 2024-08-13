import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/general_button_block.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/nutrition_blocks/body_block/meal_selection_screen.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/nutrition_blocks/question_with_answer_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:portable_gym/resourses/models/setting_models/meal_plan_question_model.dart';

import '../../../../../cubits/nutrition_cubit/nutrition_cubit.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../resourses/blocks/general_blocks/general_app_bar_block.dart';
import '../../../../../resourses/managers_files/font_manager.dart';
import '../../../../../resourses/managers_files/style_manager.dart';

class AnswersOfQuestionsScreen extends StatelessWidget {
  final List<MealPlanQuestionModel> model;
  final NutritionCubit nutCubit;


  const AnswersOfQuestionsScreen({super.key, required this.model,required this.nutCubit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GeneralAppBarBlock(
        title: S.of(context).questions,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s22),
                itemBuilder: (context, index) =>
                    QuestionWithAnswer(
                    title:
                        model[index].getLanguageClass(context).title,
                    question: model[index].getLanguageClass(context).question,
                    answer: getTheOnlyTrueAnswer(answers: model[index].getLanguageClass(context).answers)!
                )

                ,
                separatorBuilder: (context, index) => SizedBox(
                      height: AppVerticalSize.s5,
                    ),
                itemCount: model.length),
          ),
          GeneralButtonBlock(lable: S.of(context).create,
              function:(){
            Get.to(MealSelectionScreen(nutCubit: nutCubit,));
              },
              backgroundColor: ColorManager.kPurpleColor,
              textStyle:  getMediumStyle(
                  fontSize: FontSize.s20,
                  color: ColorManager.kWhiteColor,
                  fontFamily: FontFamily.kPoppinsFont))
        ],
      ),
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
