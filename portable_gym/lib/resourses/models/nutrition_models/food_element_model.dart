import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/string_manager.dart';
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/nutrition_screens/food_main_element_screen.dart';

class FoodElementModel {
  final EnglishFoodElementModel english;
  final ArabicFoodElementModel arabic;
  final String docId;

  FoodElementModel(
      {required this.english, required this.arabic, required this.docId});
  factory FoodElementModel.fromJson({required Map<String, dynamic> json,required String docId}) {
    return FoodElementModel(
        english: EnglishFoodElementModel.fromJson(json: json),
        arabic: ArabicFoodElementModel.fromJson(json: json),
    docId: docId
    );
  }
  Map<String, dynamic> toJson() {
    return {
      StringManager.englishFoodMainElementTitle:
      english.title,
      StringManager.englishFoodMainElementDescription:
      english.description,
      StringManager.arabicFoodMainElementTitle:
      arabic.title,
      StringManager.arabicFoodMainElementDescription:
      arabic.description
    };
  }
  LanguageClassFoodElementModel getLanguageClass(context) {
    return Localizations.localeOf(context).toString() == 'ar'
        ? arabic
        : english;
  }
}

abstract class LanguageClassFoodElementModel {
  final String? title;
  final String? description;

  LanguageClassFoodElementModel({
    required this.title,
    required this.description,
  });
}

class EnglishFoodElementModel extends LanguageClassFoodElementModel {
  EnglishFoodElementModel({
    required String title,
    required String description,
  }) : super(title: title, description: description);

  factory EnglishFoodElementModel.fromJson({required Map<String, dynamic> json}) {
    return EnglishFoodElementModel(
        title: json[StringManager.englishFoodMainElementTitle],
        description: json[StringManager.englishFoodMainElementDescription]);
  }
}

class ArabicFoodElementModel extends LanguageClassFoodElementModel {
  ArabicFoodElementModel({
    required String title,
    required String description,
  }) : super(title: title, description: description);
  factory ArabicFoodElementModel.fromJson({required Map<String, dynamic> json}) {
    return ArabicFoodElementModel(
        title: json[StringManager.arabicFoodMainElementTitle],
        description: json[StringManager.arabicFoodMainElementDescription]);
  }
}
