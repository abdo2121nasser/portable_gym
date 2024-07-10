part of 'nutrition_cubit.dart';

@immutable
abstract class NutritionState {}

class NutritionInitial extends NutritionState {}
class ChangeCurrentPlaneState extends NutritionState {}
class ChangeCurrentMealTypeState extends NutritionState {}
class ChangeMealTypeCheckBoxesValues extends NutritionState {}

class AddNewRecipeLoadingState extends NutritionState {}
class AddNewRecipeSuccessState extends NutritionState {}
class AddNewRecipeErrorState extends NutritionState {}

