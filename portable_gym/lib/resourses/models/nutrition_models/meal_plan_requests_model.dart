import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:portable_gym/resourses/managers_files/string_manager.dart';

import '../setting_models/question_model.dart';

class MealPlanRequestModel {
  final List<QuestionModel> questions;
  final String userDocId;
  final String docId;
  final String userNickName;
  final DateTime requestDate;

  MealPlanRequestModel(
      {required this.questions,
      required this.userDocId,
      required this.docId,
      required this.requestDate,
      required this.userNickName});
  factory MealPlanRequestModel.fromJson({
    required Map<String, dynamic> json,
    required String docId,
  }) {
    return MealPlanRequestModel(
      questions: List<QuestionModel>.from(
        json[StringManager.mealPlanData].map(
          (x) => QuestionModel.fromJson(json: x, docId: ''),
        ),
      ),
      userDocId: json[StringManager.userDocId],
      docId: docId,
      requestDate:
          (json[StringManager.mealPlanRequestDate] as Timestamp).toDate(),
      userNickName: json[StringManager.userNickName],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      StringManager.mealPlanData:
          List<dynamic>.from(questions.map((x) => x.toJson())),
      StringManager.userDocId: userDocId,
      StringManager.userNickName: userNickName,
      StringManager.mealPlanRequestDate: Timestamp.fromDate(requestDate)
    };
  }
  // LanguageClassQuestions getLanguageClass({required context,required MealPlanQuestionModel model}) {
  //   return Localizations.localeOf(context).toString() == 'ar'
  //       ? model.arabic
  //       : model.english;
  // }
}
