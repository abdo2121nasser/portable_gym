
import 'package:flutter/material.dart';
import 'package:my_coach/resourses/managers_files/google_drive_function_manager.dart';
import 'package:my_coach/resourses/managers_files/string_manager.dart';
import 'package:my_coach/resourses/models/nutrition_models/food_element_model.dart';

class DailyRecipeCardModel {
  final DailyRecipeCardEnglish english;
  final DailyRecipeCardArabic arabic;
  final String imageLink;


  DailyRecipeCardModel({
    required this.english,
    required this.arabic,
    required this.imageLink,

  });
  DailyRecipeCardLanguageClass getLanguageClass(context) {
    return  Localizations.localeOf(context).toString() == 'ar' ? arabic : english;
  }
  factory DailyRecipeCardModel.fromJson({required Map<String, dynamic> json}) {
    return DailyRecipeCardModel(
      english: DailyRecipeCardEnglish.fromJson(json: json),
      arabic: DailyRecipeCardArabic.fromJson(json: json),
      imageLink:convertGoogleDriveLinkToStreamable( json[StringManager.recipesImageLink]),

    );
  }
  Map<String, dynamic> toJson(){
    return {
      StringManager.recipesEnglishName:english.name,
      StringManager.recipesEnglishCalories:english.calories,
      StringManager.recipesArabicName:arabic.name,
      StringManager.recipesArabicCalories:arabic.calories,
      StringManager.recipesImageLink:imageLink
    };

  }

}

abstract class DailyRecipeCardLanguageClass {
  final String? name;
  final String? calories;


  DailyRecipeCardLanguageClass({
    required this.name,
    required this.calories,

  });
}

class DailyRecipeCardEnglish extends DailyRecipeCardLanguageClass {
  DailyRecipeCardEnglish({
    required String name,
    required String calories,

  }) : super(
    name: name,
    calories: calories,

  );

  factory DailyRecipeCardEnglish.fromJson({required Map<String, dynamic> json}) {
    return DailyRecipeCardEnglish(
      name: json[StringManager.recipesEnglishName],
      calories: json[StringManager.recipesEnglishCalories],

    );
  }
}

class DailyRecipeCardArabic extends DailyRecipeCardLanguageClass {
  DailyRecipeCardArabic({
    required String name,
    required String calories,

  }) : super(
    name: name,
    calories: calories,

  );
  factory DailyRecipeCardArabic.fromJson({required Map<String, dynamic> json}) {
    return DailyRecipeCardArabic(
      name: json[StringManager.recipesArabicName],
      calories: json[StringManager.recipesArabicCalories],

    );
  }
}
