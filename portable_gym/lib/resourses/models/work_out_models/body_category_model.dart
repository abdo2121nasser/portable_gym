
import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/string_manager.dart';

class BodyCategoryModel {
  final English? english;
  final Arabic? arabic;
  final String? level;
  final String? imageLink;
  final int? hour;
  final int? minute;
  final int? second;
  final String? docId;

  BodyCategoryModel({
    required this.english,
    required this.arabic,
    required this.level,
    required this.imageLink,
    required this.hour,
    required this.minute,
    required this.second,
    required this.docId
  });

  factory BodyCategoryModel.fromJson({required Map<String, dynamic> json,required String docId}) {
    return BodyCategoryModel(
      level: json[StringManager.bodyCategoryLevel],
      imageLink: json[StringManager.bodyCategoryImageLink],
      hour: json[StringManager.bodyCategoryTotalTimeHour],
      minute: json[StringManager.bodyCategoryTotalTimeMinute],
      second: json[StringManager.bodyCategoryTotalTimeSecond],
      english: English.fromJson(json: json),
      arabic: Arabic.fromJson(json: json),
      docId: docId
    );
  }

  LanguageClass getLanguageClass(context) {
    return  Localizations.localeOf(context).toString() == 'ar' ? arabic! : english!;
  }


}

abstract class LanguageClass {
  final String? title;
  final String? calories;
  final String? numberOfExercises;

  LanguageClass({
    required this.title,
    required this.calories,
    required this.numberOfExercises,
  });
}

class English extends LanguageClass {
  English({
    required String? title,
    required String? calories,
    required String? numberOfExercises,
  }) : super(title: title, calories: calories, numberOfExercises: numberOfExercises);

  factory English.fromJson({required Map<String, dynamic> json}) {
    return English(
      title: json[StringManager.bodyCategoryEnglishTitle],
      calories: json[StringManager.bodyCategoryEnglishCalories],
      numberOfExercises: json[StringManager.bodyCategoryEnglishNumberOfExercises],
    );
  }
}

class Arabic extends LanguageClass {
  Arabic({
    required String? title,
    required String? calories,
    required String? numberOfExercises,
  }) : super(title: title, calories: calories, numberOfExercises: numberOfExercises);

  factory Arabic.fromJson({required Map<String, dynamic> json}) {
    return Arabic(
      title: json[StringManager.bodyCategoryArabicTitle],
      calories: json[StringManager.bodyCategoryArabicCalories],
      numberOfExercises: json[StringManager.bodyCategoryArabicNumberOfExercises],
    );
  }
}
