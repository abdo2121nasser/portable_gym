part of 'nutrition_cubit.dart';

@immutable
abstract class NutritionState {}

class NutritionInitial extends NutritionState {}
class ChangeCurrentPlaneState extends NutritionState {}
class ChangeCurrentMealTypeState extends NutritionState {}
class ChangeMealTypeCheckBoxesValues extends NutritionState {}
class SetRecipeAttributes extends NutritionState {}

class AddNewRecipeLoadingState extends NutritionState {}
class AddNewRecipeSuccessState extends NutritionState {}
class AddNewRecipeErrorState extends NutritionState {}

class EditRecipeLoadingState extends NutritionState {}
class EditRecipeSuccessState extends NutritionState {}
class EditRecipeErrorState extends NutritionState {}

class DeleteRecipeLoadingState extends NutritionState {}
class DeleteRecipeSuccessState extends NutritionState {}
class DeleteRecipeErrorState extends NutritionState {}

class GetFilteredRecipesLoadingState extends NutritionState {}
class GetFilteredRecipesSuccessState extends NutritionState {}
class GetFilteredRecipesErrorState extends NutritionState {}

