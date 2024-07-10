import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/nutrition_blocks/body_block/meal_plane_body_block.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/nutrition_blocks/tab_bar_views/english_recipe_tab_bar_block.dart';
import 'package:portable_gym/resourses/managers_files/string_manager.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/home_screen_blocks/nutrition_blocks/body_block/meal_idea_body_block.dart';
import '../../resourses/blocks/home_screen_blocks/nutrition_blocks/tab_bar_views/arabic_recipe_tab_bar_block.dart';
import '../../resourses/managers_files/toast_messege_manager.dart';

part 'nutrition_state.dart';

class NutritionCubit extends Cubit<NutritionState> {
  NutritionCubit() : super(NutritionInitial());
  static NutritionCubit get(context) => BlocProvider.of(context);
  TabBarView recipeTabBarViews = TabBarView(
      children: [EnglishRecipeTabBarBlock(), ArabicRecipeTabBarBlock()]);

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
    }
    else {
      return true;
    }
  }
  clearAttributes()
  {
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
    mealTypeCheckBoxes.fillRange(0, mealTypeCheckBoxes.length-1,false);
    
  }

  addNewRecipe() async {
    clearAttributes();
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
      print(error);
    });
    Get.back();
  }
  processOfAddRecipes() {
    if(isValidRecipe())
      {
        addNewRecipe();
      }

  }
//---------------------------------------------------------------------------
}
