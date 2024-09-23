import 'package:flutter/material.dart';
import 'package:my_coach/resourses/managers_files/google_drive_function_manager.dart';
import 'package:my_coach/resourses/managers_files/string_manager.dart';
import 'package:my_coach/resourses/models/nutrition_models/food_element_model.dart';

class RecipeModel {
  final EnglishRecipeModel english;
  final ArabicRecipeModel arabic;
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
  factory RecipeModel.fromJson(
      {required Map<String, dynamic> json, required String docId}) {
    return RecipeModel(
      english: EnglishRecipeModel.fromJson(json: json),
      arabic: ArabicRecipeModel.fromJson(json: json),
      docId: docId,
      imageLink: convertGoogleDriveLinkToStreamable(
          json[StringManager.recipesImageLink]),
      isBreakfast: json[StringManager.englishBreakFastLable],
      isLunch: json[StringManager.englishLunchLable],
      isDinner: json[StringManager.englishDinnerLable],
      isSnacks: json[StringManager.englishSnackesLable],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      StringManager.recipesEnglishName: english.name,
      StringManager.recipesEnglishCalories: english.calories,
      StringManager.recipesEnglishProtein: english.protein,
      StringManager.recipesEnglishCarbohydrates: english.carbohydrates,
      StringManager.recipesEnglishAdvantage: english.advantage,
      StringManager.recipesArabicName: arabic.name,
      StringManager.recipesArabicCalories: arabic.calories,
      StringManager.recipesArabicProtein: arabic.protein,
      StringManager.recipesArabicCarbohydrates: arabic.carbohydrates,
      StringManager.recipesArabicAdvantage: arabic.advantage,
      StringManager.recipesImageLink: imageLink,
      StringManager.englishBreakFastLable: isBreakfast,
      StringManager.englishLunchLable: isLunch,
      StringManager.englishDinnerLable: isDinner,
      StringManager.englishSnackesLable: isSnacks,
    };
  }

  LanguageClassRecipeModel getLanguageClass(context) {
    return Localizations.localeOf(context).toString() == 'ar'
        ? arabic
        : english;
  }
}

abstract class LanguageClassRecipeModel {
  final String? name;
  final String? protein;
  final String? calories;
  final String? carbohydrates;
  final String? advantage;

  LanguageClassRecipeModel({
    required this.name,
    required this.protein,
    required this.calories,
    required this.carbohydrates,
    required this.advantage,
  });
}

class EnglishRecipeModel extends LanguageClassRecipeModel {
  EnglishRecipeModel({
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

  factory EnglishRecipeModel.fromJson({required Map<String, dynamic> json}) {
    return EnglishRecipeModel(
      name: json[StringManager.recipesEnglishName],
      //
      protein: json[StringManager.recipesEnglishProtein],
      calories: json[StringManager.recipesEnglishCalories],
      carbohydrates: json[StringManager.recipesEnglishCarbohydrates],
      advantage: json[StringManager.recipesEnglishAdvantage],
    );
  }
}

class ArabicRecipeModel extends LanguageClassRecipeModel {
  ArabicRecipeModel({
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
  factory ArabicRecipeModel.fromJson({required Map<String, dynamic> json}) {
    return ArabicRecipeModel(
      name: json[StringManager.recipesArabicName],
      protein: json[StringManager.recipesArabicProtein],
      calories: json[StringManager.recipesArabicCalories],
      carbohydrates: json[StringManager.recipesArabicCarbohydrates],
      advantage: json[StringManager.recipesArabicAdvantage],
    );
  }
}
