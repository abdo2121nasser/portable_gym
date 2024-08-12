import 'package:flutter/cupertino.dart';
import 'package:portable_gym/resourses/managers_files/string_manager.dart';

import '../setting_models/meal_plan_question_model.dart';

class MealPlanRequestModel {
  final List<MealPlanQuestionModel> questions;
  final String userDocId;
  final String docId;
  final String userNickName;

  MealPlanRequestModel(
      {required this.questions,
      required this.userDocId,
      required this.docId,
      required this.userNickName});
  factory MealPlanRequestModel.fromJson({
    required Map<String, dynamic> json,
    required String docId,
  }) {
    return MealPlanRequestModel(
      questions: List<MealPlanQuestionModel>.from(
        json[StringManager.mealPlanData].map(
          (x) => MealPlanQuestionModel.fromJson(json: x, docId: ''),
        ),
      ),
      userDocId: json[StringManager.userDocId],
      docId: docId,
      userNickName: json[StringManager.userNickName],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      StringManager.mealPlanData: List<dynamic>.from(questions.map((x) => x.toJson())),
      StringManager.userDocId: userDocId,
      StringManager.userNickName: userNickName,
    };
  }
  // LanguageClassQuestions getLanguageClass({required context,required MealPlanQuestionModel model}) {
  //   return Localizations.localeOf(context).toString() == 'ar'
  //       ? model.arabic
  //       : model.english;
  // }
}
