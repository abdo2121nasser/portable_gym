import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/string_manager.dart';
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/nutrition_screens/food_main_element_screen.dart';

class FoodElementModel {
  final English english;
  final Arabic arabic;
  final String docId;

  FoodElementModel(
      {required this.english, required this.arabic, required this.docId});
  factory FoodElementModel.fromJson({required Map<String, dynamic> json,required String docId}) {
    return FoodElementModel(
        english: English.fromJson(json: json),
        arabic: Arabic.fromJson(json: json),
    docId: docId
    );
  }

  LanguageClass getLanguageClass(context) {
    return Localizations.localeOf(context).toString() == 'ar'
        ? arabic
        : english;
  }
}

abstract class LanguageClass {
  final String? title;
  final String? description;

  LanguageClass({
    required this.title,
    required this.description,
  });
}

class English extends LanguageClass {
  English({
    required String title,
    required String description,
  }) : super(title: title, description: description);

  factory English.fromJson({required Map<String, dynamic> json}) {
    return English(
        title: json[StringManager.englishFoodMainElementTitle],
        description: json[StringManager.englishFoodMainElementDescription]);
  }
}

class Arabic extends LanguageClass {
  Arabic({
    required String title,
    required String description,
  }) : super(title: title, description: description);
  factory Arabic.fromJson({required Map<String, dynamic> json}) {
    return Arabic(
        title: json[StringManager.arabicFoodMainElementTitle],
        description: json[StringManager.arabicFoodMainElementDescription]);
  }
}
