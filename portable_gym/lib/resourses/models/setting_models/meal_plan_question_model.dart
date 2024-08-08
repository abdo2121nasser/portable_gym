import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/string_manager.dart';

class MealPlanQuestionModel {
   EnglishQuestion english;
   ArabicQuestion arabic;
   final String docId;

  MealPlanQuestionModel({
    required this.english,
    required this.arabic,
    required this.docId
  });

  factory MealPlanQuestionModel.fromJson({required Map<String, dynamic> json,required String docId}) {
    return MealPlanQuestionModel(
      english:
          EnglishQuestion.fromJson(json: json[StringManager.englishMealPlanQuestion]),
      arabic:
          ArabicQuestion.fromJson(json: json[StringManager.arabicMealPlanQuestion]),
      docId: docId
    );
  }

  Map<String, dynamic> toJson() {
    return {
      StringManager.englishMealPlanQuestion: english.toJson(),
      StringManager.arabicMealPlanQuestion: arabic.toJson(),
    };
  }

  LanguageClassQuestions getLanguageClass(context) {
    return Localizations.localeOf(context).toString() == 'ar'
        ? arabic
        : english;
  }
}

class Answer {
   String text;
   bool value;

  Answer({
    required this.text,
    required this.value,
  });

  factory Answer.fromJson({required Map<String, dynamic> json}) {
    return Answer(
      text: json[StringManager.questionsText],
      value: json[StringManager.questionsValue],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      StringManager.questionsText: text,
      StringManager.questionsValue: value,
    };
  }
}

abstract class LanguageClassQuestions {
   String title;
   String question;
   List<Answer> answers;

  LanguageClassQuestions({
    required this.title,
    required this.question,
    required this.answers,
  });

  // factory LanguageClassQuestions.fromJson({required Map<String, dynamic> json}) {
  //   return json.containsKey(StringManager.englishMealPlanQuestion)
  //       ? EnglishQuestion.fromJson(json[StringManager.englishMealPlanQuestion])
  //       : ArabicQuestion.fromJson(json[StringManager.arabicMealPlanQuestion]);
  // }

  Map<String, dynamic> toJson();
}

class EnglishQuestion extends LanguageClassQuestions {
  EnglishQuestion({
    required String title,
    required String question,
    required List<Answer> answers,
  }) : super(title: title, question: question, answers: answers);

  factory EnglishQuestion.fromJson({required Map<String, dynamic> json}) {
    return EnglishQuestion(
      title: json[StringManager.questionsTitle],
      question: json[StringManager.questionsQuestion],
      answers: List<Answer>.from(
          json[StringManager.questionsAnswer].map((x) => Answer.fromJson(json: x))),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      StringManager.questionsTitle: title,
      StringManager.questionsQuestion: question,
      StringManager.questionsAnswer:
          List<dynamic>.from(answers.map((x) => x.toJson())),
    };
  }
}

class ArabicQuestion extends LanguageClassQuestions {
  ArabicQuestion({
    required String title,
    required String question,
    required List<Answer> answers,
  }) : super(title: title, question: question, answers: answers);

  factory ArabicQuestion.fromJson({required Map<String, dynamic> json}) {
    return ArabicQuestion(
      title: json[StringManager.questionsTitle],
      question: json[StringManager.questionsQuestion],
      answers: List<Answer>.from(
          json[StringManager.questionsAnswer].map((x) => Answer.fromJson(json: x))),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      StringManager.questionsTitle: title,
      StringManager.questionsQuestion: question,
      StringManager.questionsAnswer:
          List<dynamic>.from(answers.map((x) => x.toJson())),
    };
  }
}
