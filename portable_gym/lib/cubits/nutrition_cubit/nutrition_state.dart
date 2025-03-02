part of 'nutrition_cubit.dart';

@immutable
abstract class NutritionState {}

class NutritionInitial extends NutritionState {}
class ChangeCurrentPlaneState extends NutritionState {}
class ChangeCurrentMealTypeState extends NutritionState {}
class ChangeMealTypeCheckBoxesValues extends NutritionState {}
class SetRecipeAttributes extends NutritionState {}
class ClearRecipeAttributes extends NutritionState {}
class SetFoodMainElement extends NutritionState {}
class ClearFoodMainElement extends NutritionState {}
class SetDailyRecipeCategoryAttributes extends NutritionState {}

class GetNutritionUserDocIdLoadingState extends NutritionState {}
class GetNutritionUserDocIdSuccessState extends NutritionState {}
class GetNutritionUserDocIdErrorState   extends NutritionState {}

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

class AddNewFoodMainElementLoadingState extends NutritionState {}
class AddNewFoodMainElementSuccessState extends NutritionState {}
class AddNewFoodMainElementErrorState extends NutritionState {}

class EditFoodMainElementLoadingState extends NutritionState {}
class EditFoodMainElementSuccessState extends NutritionState {}
class EditFoodMainElementErrorState extends NutritionState {}

class GetFoodMainElementLoadingState extends NutritionState {}
class GetFoodMainElementSuccessState extends NutritionState {}
class GetFoodMainElementErrorState extends NutritionState {}

class DeleteFoodMainElementLoadingState extends NutritionState {}
class DeleteFoodMainElementSuccessState extends NutritionState {}
class DeleteFoodMainElementErrorState extends NutritionState {}

class EditDailyRecipeCardLoadingState extends NutritionState {}
class EditDailyRecipeCardSuccessState extends NutritionState {}
class EditDailyRecipeCardErrorState extends NutritionState {}

class GetDailyRecipeCardLoadingState extends NutritionState {}
class GetDailyRecipeCardSuccessState extends NutritionState {}
class GetDailyRecipeCardErrorState extends NutritionState {}

class AddDailyRecipeLoadingState extends NutritionState {}
class AddDailyRecipeSuccessState extends NutritionState {}
class AddDailyRecipeErrorState extends NutritionState {}

class GetDailyRecipesLoadingState extends NutritionState {}
class GetDailyRecipesSuccessState extends NutritionState {}
class GetDailyRecipesErrorState extends NutritionState {}

class GetAllMealPlanRequestsLoadingState extends NutritionState {}
class GetAllMealPlanRequestsSuccessState extends NutritionState {}
class GetAllMealPlanRequestsErrorState extends NutritionState {}

class HasMealPlanLoadingState extends NutritionState {}
class HasMealPlanSuccessState extends NutritionState {}
class HasMealPlanErrorState extends NutritionState {}

class CreateMealPlanLoadingState extends NutritionState {}
class CreateMealPlanSuccessState extends NutritionState {}
class CreateMealPlanErrorState extends NutritionState {}

class DeleteMealPlanRequestLoadingState extends NutritionState {}
class DeleteMealPlanRequestSuccessState extends NutritionState {}
class DeleteMealPlanRequestErrorState extends NutritionState {}

class GetMealPlanLoadingState extends NutritionState {}
class GetMealPlanSuccessState extends NutritionState {}
class GetMealPlanErrorState extends NutritionState {}

class AddMealPlanBreakfastState extends NutritionState {}
class AddMealPlanLunchState extends NutritionState {}
class AddMealPlanDinnerState extends NutritionState {}
class AddMealPlanSnacksState extends NutritionState {}

class DeleteMealPlanBreakfastState extends NutritionState {}
class DeleteMealPlanLunchState extends NutritionState {}
class DeleteMealPlanDinnerState extends NutritionState {}
class DeleteMealPlanSnacksState extends NutritionState {}

