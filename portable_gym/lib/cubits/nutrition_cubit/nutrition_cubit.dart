

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/nutrition_blocks/body_block/meal_plane_body_block.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/nutrition_blocks/food_main_element_block.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/nutrition_blocks/tab_bar_views/english_recipe_tab_bar_block.dart';
import 'package:portable_gym/resourses/managers_files/string_manager.dart';
import 'package:portable_gym/resourses/models/nutrition_models/recipe_model.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/home_screen_blocks/nutrition_blocks/body_block/meal_idea_body_block.dart';
import '../../resourses/blocks/home_screen_blocks/nutrition_blocks/tab_bar_views/arabic_food_main_element_tab_bar_block.dart';
import '../../resourses/blocks/home_screen_blocks/nutrition_blocks/tab_bar_views/arabic_recipe_tab_bar_block.dart';
import '../../resourses/blocks/home_screen_blocks/nutrition_blocks/tab_bar_views/english_food_main_element_tab_bar_block.dart';
import '../../resourses/managers_files/toast_messege_manager.dart';
import '../../resourses/models/nutrition_models/food_element_model.dart';

part 'nutrition_state.dart';

class NutritionCubit extends Cubit<NutritionState> {
  NutritionCubit() : super(NutritionInitial());
  static NutritionCubit get(context) => BlocProvider.of(context);

  List<RecipeModel> recipeModels = [];
  List<FoodElementModel> foodElementModels=[];

  TabBarView recipeTabBarViews = TabBarView(
      children: [EnglishRecipeTabBarBlock(), ArabicRecipeTabBarBlock()]);
  TabBarView foodMainElementTabBarViews = TabBarView(children: [
    EnglishFoodMainElementTabBarBlock(),
    ArabicFoodMainElementTabBarBlock()
  ]);

  List<Widget> planBodies = [MealPlaneBodyBlock(), MealIdeaBodyBlock()];
  List<bool> mealTypeCheckBoxes = [
    false,
    false,
    false,
    false,
    false,
  ];
  int currentPlane = 0;
  int currentMealType = 0;

  TextEditingController englishNameController = TextEditingController();
  TextEditingController englishCaloriesController = TextEditingController();
  TextEditingController englishProteinController = TextEditingController();
  TextEditingController englishCarbohydratesController =
      TextEditingController();
  TextEditingController englishAdvantageController = TextEditingController();

  TextEditingController arabicNameController = TextEditingController();
  TextEditingController arabicCaloriesController = TextEditingController();
  TextEditingController arabicProteinController = TextEditingController();
  TextEditingController arabicCarbohydratesController = TextEditingController();
  TextEditingController arabicAdvantageController = TextEditingController();

  TextEditingController imageLinkController = TextEditingController();
  //-----------------------------------------------------------------------------
  TextEditingController englishMainElementTitleController = TextEditingController();
  TextEditingController englishMainElementDescriptionController = TextEditingController();
  TextEditingController arabicMainElementTitleController = TextEditingController();
  TextEditingController arabicMainElementDescriptionController = TextEditingController();



  getMealPlaneLabel({context}) {
    List<String> lables = [
      S.of(context).mealPlan,
      S.of(context).mealIdea,
    ];
    return lables;
  }

  changeCurrentPlane({required int index}) {
    currentPlane = index;
    emit(ChangeCurrentPlaneState());
  }

  getMealTypeLables({required context}) {
    return <String>[
      S.of(context).breakfast,
      S.of(context).lunch,
      S.of(context).dinner,
      S.of(context).snacks,
    ];
  }

  changeCurrentMealType({required int index}) {
    currentMealType = index;
    emit(ChangeCurrentMealTypeState());
    getFilteredRecipes();
  }

  List<TextEditingController> getEnglishRecipeControllers() {
    return [
      englishNameController,
      englishCaloriesController,
      englishProteinController,
      englishCarbohydratesController,
      englishAdvantageController,
      imageLinkController,
    ];
  }

  List<TextEditingController> getArabicRecipeControllers() {
    return [
      arabicNameController,
      arabicCaloriesController,
      arabicProteinController,
      arabicCarbohydratesController,
      arabicAdvantageController,
      imageLinkController
    ];
  }

  List<String> getEnglishRecipeLables() {
    return [
      StringManager.englishRecipeNameLable,
      StringManager.englishRecipeCaloriesLable,
      StringManager.englishRecipeProteinLable,
      StringManager.englishRecipeCarbohydratesLable,
      StringManager.englishRecipeAdvantageLable,
      StringManager.englishRecipeImageLinkLable,
    ];
  }

  List<String> getArabicRecipeLables() {
    return [
      StringManager.arabicRecipeNameLable,
      StringManager.arabicRecipeCaloriesLable,
      StringManager.arabicRecipeProteinLable,
      StringManager.arabicRecipeCarbohydratesLable,
      StringManager.arabicRecipeAdvantageLable,
      StringManager.arabicRecipeImageLinkLable,
    ];
  }

  changeMealTypeCheckBoxesValues({required int index, required bool value}) {
    mealTypeCheckBoxes[index] = value;
    emit(ChangeMealTypeCheckBoxesValues());
  }

  List<String> getEnglishMealTypeCheckBoxesLables() {
    return [
      StringManager.englishBreakFastLable,
      StringManager.englishLunchLable,
      StringManager.englishDinnerLable,
      StringManager.englishSnackesLable,
    ];
  }

  List<String> getArabicMealTypeCheckBoxesLables() {
    return [
      StringManager.arabicBreakFastLable,
      StringManager.arabicLunchLable,
      StringManager.arabicDinnerLable,
      StringManager.arabicSnackesLable,
    ];
  }

//---------------------------------------------------------------------------
  String getFilterKey() {
    switch (currentMealType) {
      case 0:
        return StringManager.englishBreakFastLable;
      case 1:
        return StringManager.englishLunchLable;
      case 2:
        return StringManager.englishDinnerLable;
      default:
        return StringManager.englishSnackesLable;
    }
  }

  bool isValidRecipe() {
    if (englishNameController.text.isEmpty) {
      getToastMessage(
        message: 'the english name field is empty',
      );
      return false;
    } else if (arabicNameController.text.isEmpty) {
      getToastMessage(
        message: 'the arabic name field is empty',
      );
      return false;
    } else if (englishCaloriesController.text.isEmpty) {
      getToastMessage(
        message: 'the english calories field is empty',
      );
      return false;
    } else if (arabicCaloriesController.text.isEmpty) {
      getToastMessage(
        message: 'the arabic calories field is empty',
      );
      return false;
    } else if (englishProteinController.text.isEmpty) {
      getToastMessage(
        message: 'the english protein field is empty',
      );
      return false;
    } else if (arabicProteinController.text.isEmpty) {
      getToastMessage(
        message: 'the arabic protein field is empty',
      );
      return false;
    } else if (englishCarbohydratesController.text.isEmpty) {
      getToastMessage(
        message: 'the english carbohydrates field is empty',
      );
      return false;
    } else if (arabicCarbohydratesController.text.isEmpty) {
      getToastMessage(
        message: 'the arabic carbohydrates field is empty',
      );
      return false;
    } else if (englishAdvantageController.text.isEmpty) {
      getToastMessage(
        message: 'the english advantage field is empty',
      );
      return false;
    } else if (arabicAdvantageController.text.isEmpty) {
      getToastMessage(
        message: 'the arabic advantage field is empty',
      );
      return false;
    } else if (imageLinkController.text.isEmpty) {
      getToastMessage(
        message: 'the image link field is empty',
      );
      return false;
    } else if (!mealTypeCheckBoxes.contains(true)) {
      getToastMessage(
        message: 'you should choose at least on type of meal',
      );
      return false;
    } else {
      return true;
    }
  }

  clearRecipeAttributes() {
    englishNameController.clear();
    englishCaloriesController.clear();
    englishProteinController.clear();
    englishCarbohydratesController.clear();
    englishAdvantageController.clear();
    arabicNameController.clear();
    arabicCaloriesController.clear();
    arabicProteinController.clear();
    arabicCarbohydratesController.clear();
    arabicAdvantageController.clear();
    imageLinkController.clear();
    mealTypeCheckBoxes.fillRange(0, mealTypeCheckBoxes.length - 1, false);
    emit(ClearRecipeAttributes());
  }

  setRecipeAttributes({required RecipeModel model}) {
    englishNameController.text = model.english.name!;
    englishCaloriesController.text = model.english.calories!;
    englishProteinController.text = model.english.protein!;
    englishCarbohydratesController.text = model.english.carbohydrates!;
    englishAdvantageController.text = model.english.advantage!;
    arabicNameController.text = model.arabic.name!;
    arabicCaloriesController.text = model.arabic.calories!;
    arabicProteinController.text = model.arabic.protein!;
    arabicCarbohydratesController.text = model.arabic.carbohydrates!;
    arabicAdvantageController.text = model.arabic.advantage!;
    imageLinkController.text = model.imageLink;
    mealTypeCheckBoxes[0] = model.isBreakfast;
    mealTypeCheckBoxes[1] = model.isLunch;
    mealTypeCheckBoxes[2] = model.isDinner;
    mealTypeCheckBoxes[3] = model.isSnacks;
    emit(SetRecipeAttributes());
  }

  addNewRecipe() async {
    CollectionReference data =
        FirebaseFirestore.instance.collection(StringManager.collectionRecipes);
    emit(AddNewRecipeLoadingState());
    await data.add({
      StringManager.recipesEnglishName: englishNameController.text,
      StringManager.recipesEnglishCalories: englishCaloriesController.text,
      StringManager.recipesEnglishProtein: englishProteinController.text,
      StringManager.recipesEnglishCarbohydrates:
          englishCarbohydratesController.text,
      StringManager.recipesEnglishAdvantage: englishAdvantageController.text,
      StringManager.recipesArabicName: arabicNameController.text,
      StringManager.recipesArabicCalories: arabicCaloriesController.text,
      StringManager.recipesArabicProtein: arabicProteinController.text,
      StringManager.recipesArabicCarbohydrates:
          arabicCarbohydratesController.text,
      StringManager.recipesArabicAdvantage: arabicAdvantageController.text,
      StringManager.recipesImageLink: imageLinkController.text,
      StringManager.englishBreakFastLable: mealTypeCheckBoxes[0],
      StringManager.englishLunchLable: mealTypeCheckBoxes[1],
      StringManager.englishDinnerLable: mealTypeCheckBoxes[2],
      StringManager.englishSnackesLable: mealTypeCheckBoxes[3],
    }).then((value) {
      emit(AddNewRecipeSuccessState());
      getToastMessage(
        message: 'added successfully',
      );
    }).catchError((error) {
      emit(AddNewRecipeErrorState());
      getToastMessage(
        message: 'a problem has happened',
      );
      debugPrint(error);
    });
    getFilteredRecipes();
    clearRecipeAttributes();
    Get.back();
  }

  editRecipe({required String docId}) async {
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionRecipes)
        .doc(docId);
    emit(EditRecipeLoadingState());
    await data.update({
      StringManager.recipesEnglishName: englishNameController.text,
      StringManager.recipesEnglishCalories: englishCaloriesController.text,
      StringManager.recipesEnglishProtein: englishProteinController.text,
      StringManager.recipesEnglishCarbohydrates:
          englishCarbohydratesController.text,
      StringManager.recipesEnglishAdvantage: englishAdvantageController.text,
      StringManager.recipesArabicName: arabicNameController.text,
      StringManager.recipesArabicCalories: arabicCaloriesController.text,
      StringManager.recipesArabicProtein: arabicProteinController.text,
      StringManager.recipesArabicCarbohydrates:
          arabicCarbohydratesController.text,
      StringManager.recipesArabicAdvantage: arabicAdvantageController.text,
      StringManager.recipesImageLink: imageLinkController.text,
      StringManager.englishBreakFastLable: mealTypeCheckBoxes[0],
      StringManager.englishLunchLable: mealTypeCheckBoxes[1],
      StringManager.englishDinnerLable: mealTypeCheckBoxes[2],
      StringManager.englishSnackesLable: mealTypeCheckBoxes[3],
    }).then((value) {
      emit(EditRecipeSuccessState());
      getToastMessage(
        message: 'edited successfully',
      );
      getFilteredRecipes();
    }).catchError((error) {
      emit(EditRecipeErrorState());
      getToastMessage(
        message: 'a problem has happened',
      );
      debugPrint(error);
    });
    Get.back();
  }

  deleteRecipe({required String docId,}) async {
    emit(DeleteRecipeLoadingState());
    CollectionReference data =
        FirebaseFirestore.instance.collection(StringManager.collectionRecipes);
    await data.doc(docId).delete().then((value) {
      emit(DeleteRecipeSuccessState());
      getFilteredRecipes();

      getToastMessage(
        message: 'deleted successfully',
      );
    }).catchError((error) {
      emit(DeleteRecipeErrorState());
      print(error);
      getToastMessage(
        message: 'a problem has happened',
      );
    });
  }

  getFilteredRecipes() async {
    recipeModels.clear();
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionRecipes)
        .where(getFilterKey(), isEqualTo: true);
    emit(GetFilteredRecipesLoadingState());
    await data.get().then((value) {
      value.docs.forEach((element) {
        recipeModels
            .add(RecipeModel.fromJson(json: element.data(), docId: element.id));
      });

      emit(GetFilteredRecipesSuccessState());
    }).catchError((error) {
      emit(GetFilteredRecipesErrorState());
      debugPrint(error.toString());
    });
  }

  processOfAddRecipes() {
    if (isValidRecipe()) {
      addNewRecipe();
    }
  }
//---------------------------------------------------------------------------
  setFoodMainElementAttributes({required FoodElementModel model}) {
    englishMainElementTitleController.text=model.english.title!;
    englishMainElementDescriptionController.text=model.english.description!;
    arabicMainElementTitleController.text=model.arabic.title!;
    arabicMainElementDescriptionController.text=model.arabic.description!;
    emit(SetFoodMainElement());
  }
  clearFoodMainElementAttributes() {
    englishMainElementTitleController.clear();
    englishMainElementDescriptionController.clear();
    arabicMainElementTitleController.clear();
    arabicMainElementDescriptionController.clear();
    emit(ClearFoodMainElement());
  }

  addNewFoodMainElement() async {
    CollectionReference data =
    FirebaseFirestore.instance.collection(StringManager.collectionFoodMainElement);
    emit(AddNewFoodMainElementLoadingState());
    await data.add({
      StringManager.englishFoodMainElementTitle:englishMainElementTitleController.text,
      StringManager.englishFoodMainElementDescription:englishMainElementDescriptionController.text,
      StringManager.arabicFoodMainElementTitle:arabicMainElementTitleController.text,
      StringManager.arabicFoodMainElementDescription:arabicMainElementDescriptionController.text
    }).then((value) {
      emit(AddNewFoodMainElementSuccessState());
      getFoodMainElement();
      getToastMessage(
        message: 'added successfully',
      );
    }).catchError((error) {
      emit(AddNewFoodMainElementErrorState());
      getToastMessage(
        message: 'a problem has happened',
      );
      debugPrint(error);
    });
    clearFoodMainElementAttributes();
    Get.back();
  }

  editFoodMainElement({required String docId}) async {
    var data =
    FirebaseFirestore.instance.collection(StringManager.collectionFoodMainElement).doc(docId);
    emit(EditFoodMainElementLoadingState());
    await data.update({
      StringManager.englishFoodMainElementTitle:englishMainElementTitleController.text,
      StringManager.englishFoodMainElementDescription:englishMainElementDescriptionController.text,
      StringManager.arabicFoodMainElementTitle:arabicMainElementTitleController.text,
      StringManager.arabicFoodMainElementDescription:arabicMainElementDescriptionController.text
    }).then((value) {
      emit(EditFoodMainElementSuccessState());
      getFoodMainElement();
      getToastMessage(
        message: 'added successfully',
      );
    }).catchError((error) {
      emit(EditFoodMainElementErrorState());
      getToastMessage(
        message: 'a problem has happened',
      );
      debugPrint(error);
    });
    clearFoodMainElementAttributes();
    Get.back();
  }
  deleteFoodMainElement({required String docId}) async {
foodElementModels.clear();
var data = FirebaseFirestore.instance
        .collection(StringManager.collectionFoodMainElement) .doc(docId);
emit(DeleteFoodMainElementLoadingState());
    await data.delete().then((value) {
      emit(DeleteFoodMainElementSuccessState());
      getToastMessage(
        message: 'deleted successfully',
      );
      getFoodMainElement();
    }).catchError((error) {
      emit(DeleteFoodMainElementErrorState());
      debugPrint(error.toString());
      getToastMessage(
        message: 'a problem has happened',
      );
    });
  }
  getFoodMainElement() async {
foodElementModels.clear();
var data = FirebaseFirestore.instance
        .collection(StringManager.collectionFoodMainElement) ;
emit(GetFoodMainElementLoadingState());
    await data.get().then((value) {
      value.docs.forEach((element) {
        foodElementModels
            .add(FoodElementModel.fromJson(json: element.data(), docId: element.id));
      });

      emit(GetFoodMainElementSuccessState());
    }).catchError((error) {
      emit(GetFoodMainElementErrorState());
      debugPrint(error.toString());
    });
  }



}
