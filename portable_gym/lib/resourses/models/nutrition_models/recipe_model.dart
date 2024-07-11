
import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/google_drive_function_manager.dart';
import 'package:portable_gym/resourses/managers_files/string_manager.dart';
import 'package:portable_gym/resourses/models/nutrition_models/food_element_model.dart';

class RecipeModel {
  final English english;
  final Arabic arabic;
  final String docId;
  final String imageLink;
  final bool isBreakfast;
  final bool isLunch;
  final bool isDinner;
  final bool isSnacks;

  RecipeModel({
    required this.english,
    required this.arabic,
    required this.docId,
    required this.imageLink,
    required this.isBreakfast,
    required this.isLunch,
    required this.isDinner,
    required this.isSnacks,
  });
  factory RecipeModel.fromJson({required Map<String, dynamic> json,required String docId}) {
    return RecipeModel(
      english: English.fromJson(json: json),
      arabic: Arabic.fromJson(json: json),
      docId: docId,
      imageLink: convertGoogleDriveLinkToStreamable( json[StringManager.recipesImageLink]),
      isBreakfast: json[StringManager.englishBreakFastLable],
      isLunch: json[StringManager.englishLunchLable],
      isDinner: json[StringManager.englishDinnerLable],
      isSnacks: json[StringManager.englishSnackesLable],
    );
  }
  LanguageClass getLanguageClass(context) {
    return  Localizations.localeOf(context).toString() == 'ar' ? arabic : english;
  }
}

abstract class LanguageClass {
  final String name;
  final String protein;
  final String calories;
  final String carbohydrates;
  final String advantage;

  LanguageClass({
    required this.name,
    required this.protein,
    required this.calories,
    required this.carbohydrates,
    required this.advantage,
  });
}

class English extends LanguageClass {
  English({
    required String name,
    required String protein,
    required String calories,
    required String carbohydrates,
    required String advantage,
  }) : super(
          name: name,
          protein: protein,
          calories: calories,
          carbohydrates: carbohydrates,
          advantage: advantage,
        );

  factory English.fromJson({required Map<String, dynamic> json}) {
    return English(
      name: json[StringManager.recipesEnglishName],
      //
      protein: json[StringManager.recipesEnglishProtein],
      calories: json[StringManager.recipesEnglishCalories],
      carbohydrates: json[StringManager.recipesEnglishCarbohydrates],
      advantage: json[StringManager.recipesEnglishAdvantage],
    );
  }
}

class Arabic extends LanguageClass {
  Arabic({
    required String name,
    required String protein,
    required String calories,
    required String carbohydrates,
    required String advantage,
  }) : super(
          name: name,
          protein: protein,
          calories: calories,
          carbohydrates: carbohydrates,
          advantage: advantage,
        );
  factory Arabic.fromJson({required Map<String, dynamic> json}) {
    return Arabic(
      name: json[StringManager.recipesArabicName],
      protein: json[StringManager.recipesArabicProtein],
      calories: json[StringManager.recipesArabicCalories],
      carbohydrates: json[StringManager.recipesArabicCarbohydrates],
      advantage: json[StringManager.recipesArabicAdvantage],
    );
  }
}
