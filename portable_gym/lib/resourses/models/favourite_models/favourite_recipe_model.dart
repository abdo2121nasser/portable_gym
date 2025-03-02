
import 'package:flutter/material.dart';
import 'package:my_coach/resourses/managers_files/google_drive_function_manager.dart';
import 'package:my_coach/resourses/managers_files/string_manager.dart';
import 'package:my_coach/resourses/models/nutrition_models/recipe_model.dart';

class FavouriteRecipeModel {
  final EnglishRecipeModel english;
  final ArabicRecipeModel arabic;
  final String docId;
  final String recipeDocId;
  final String imageLink;



  FavouriteRecipeModel({
    required this.english,
    required this.arabic,
    required this.docId,
    required this.recipeDocId,
    required this.imageLink,

  });
  factory FavouriteRecipeModel.fromJson({required Map<String, dynamic> json,required String docId}) {
    return FavouriteRecipeModel(
      english: EnglishRecipeModel.fromJson(json: json),
      arabic: ArabicRecipeModel.fromJson(json: json),
      docId: docId,
      recipeDocId: json[StringManager.recipeDocId],
      imageLink:convertGoogleDriveLinkToStreamable( json[StringManager.recipesImageLink]),
    );
  }
  LanguageClassRecipeModel getLanguageClass(context) {
    return  Localizations.localeOf(context).toString() == 'ar' ? arabic : english;
  }
}


