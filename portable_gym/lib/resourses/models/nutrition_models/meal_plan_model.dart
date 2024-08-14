import 'package:portable_gym/resourses/models/nutrition_models/recipe_model.dart';

import '../../managers_files/string_manager.dart';

class MealPlanModel {

  List<RecipeModel> breakfast = [];
  List<RecipeModel> dinner = [];
  List<RecipeModel> lunch = [];
  List<RecipeModel> snacks = [];
  MealPlanModel({
    required this.breakfast,
    required this.dinner,
    required this.lunch,
    required this.snacks,
  });
  factory MealPlanModel.fromJson(Map<String, dynamic> json) {
    json=json[StringManager.mealPlanData];
    return MealPlanModel(
        breakfast: List<RecipeModel>.from(
          json[StringManager.breakfastMealPlan].map(
            (x) => RecipeModel.fromJson(json: x, docId: ''),
          ),
        ),
        dinner:
            List<RecipeModel>.from(json[StringManager.dinnerMealPlan].map(
          (x) => RecipeModel.fromJson(json: x, docId: ''),
        )),
        lunch: List<RecipeModel>.from(json[StringManager.lunchMealPlan].map(
          (x) => RecipeModel.fromJson(json: x, docId: ''),
        )),
        snacks: List<RecipeModel>.from(
          json[StringManager.snacksMealPlan].map(
            (x) => RecipeModel.fromJson(json: x, docId: ''),
          ),
        ));
  }
}


