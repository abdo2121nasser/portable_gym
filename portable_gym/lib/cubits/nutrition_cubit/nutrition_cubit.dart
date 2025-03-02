// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:my_coach/resourses/blocks/home_screen_blocks/nutrition_blocks/body_block/meal_plane_body_block.dart';
import 'package:my_coach/resourses/blocks/home_screen_blocks/nutrition_blocks/tab_bar_views/english_recipe_tab_bar_block.dart';
import 'package:my_coach/resourses/managers_files/string_manager.dart';
import 'package:my_coach/resourses/models/nutrition_models/meal_plan_requests_model.dart';
import 'package:my_coach/resourses/models/nutrition_models/recipe_model.dart';
import '../../generated/l10n.dart';
import '../../resourses/blocks/home_screen_blocks/nutrition_blocks/body_block/meal_idea_body_block.dart';
import '../../resourses/blocks/home_screen_blocks/nutrition_blocks/tab_bar_views/arabic_daily_recipe_category_block.dart';
import '../../resourses/blocks/home_screen_blocks/nutrition_blocks/tab_bar_views/arabic_food_main_element_tab_bar_block.dart';
import '../../resourses/blocks/home_screen_blocks/nutrition_blocks/tab_bar_views/arabic_recipe_tab_bar_block.dart';
import '../../resourses/blocks/home_screen_blocks/nutrition_blocks/tab_bar_views/english_daily_recipe_category_block.dart';
import '../../resourses/blocks/home_screen_blocks/nutrition_blocks/tab_bar_views/english_food_main_element_tab_bar_block.dart';
import '../../resourses/managers_files/toast_massage_manager.dart';
import '../../resourses/models/nutrition_models/daily_recipe_card_model.dart';
import '../../resourses/models/nutrition_models/food_element_model.dart';
import '../../resourses/models/nutrition_models/meal_plan_model.dart';

part 'nutrition_state.dart';

class NutritionCubit extends Cubit<NutritionState> {
  NutritionCubit() : super(NutritionInitial()) {
    getUserDocId();
  }
  static NutritionCubit get(context) => BlocProvider.of(context);

  List<List<RecipeModel>> recipeModels =
      List<List<RecipeModel>>.generate(4, (index) => []);
  List<RecipeModel> breakfastMealPlanRecipeModels = [];
  List<RecipeModel> dinnerMealPlanRecipeModels = [];
  List<RecipeModel> lunchMealPlanRecipeModels = [];
  List<RecipeModel> snacksMealPlanRecipeModels = [];
  List<FoodElementModel> foodElementModels = [];
  DailyRecipeCardModel? dailyRecipeCardModel;
  List<MealPlanRequestModel> requestsModels = [];
  MealPlanModel? mealPlanModel;
  List<Widget> planBodies = [
    const MealPlaneBodyBlock(),
    const MealIdeaBodyBlock()
  ];
  List<bool> mealTypeCheckBoxes = [
    false,
    false,
    false,
    false,
  ];
  int currentPlane = 0;
  int currentMealType = 0;
  bool hasMealPlan = false;
  late String userDocId;
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
  //----------------------------------------------------------------------------
  TextEditingController englishMainElementTitleController =
      TextEditingController();
  TextEditingController englishMainElementDescriptionController =
      TextEditingController();
  TextEditingController arabicMainElementTitleController =
      TextEditingController();
  TextEditingController arabicMainElementDescriptionController =
      TextEditingController();
  //----------------------------------------------------------------------------
  TextEditingController englishDailyRecipeCategoryNameController =
      TextEditingController();
  TextEditingController englishDailyRecipeCategoryCaloriesController =
      TextEditingController();
  TextEditingController arabicDailyRecipeCategoryNameController =
      TextEditingController();
  TextEditingController arabicDailyRecipeCategoryCaloriesController =
      TextEditingController();
  TextEditingController dailyRecipeCategoryImageLinkController =
      TextEditingController();

  getUserDocId() async {
    emit(GetNutritionUserDocIdLoadingState());
    await const FlutterSecureStorage()
        .read(key: StringManager.userDocId)
        .then((value) {
      userDocId = value!;
      getHasMealPlan();
      emit(GetNutritionUserDocIdSuccessState());
    }).catchError((error) {
      emit(GetNutritionUserDocIdErrorState());
      debugPrint(error.toString());
    });
  }

  TabBarView getFoodMainElementTabBarViews(
      {required NutritionCubit nutritionCubit}) {
    return TabBarView(children: [
      EnglishFoodMainElementTabBarBlock(nutCubit: nutritionCubit),
      ArabicFoodMainElementTabBarBlock(
        nutCubit: nutritionCubit,
      )
    ]);
  }

  TabBarView getRecipeTabBarViews({required NutritionCubit nutritionCubit}) {
    return TabBarView(children: [
      EnglishRecipeTabBarBlock(nutCubit: nutritionCubit),
      ArabicRecipeTabBarBlock(
        nutCubit: nutritionCubit,
      )
    ]);
  }

  TabBarView getDailyRecipeCategoryTabBarViews(
      {required NutritionCubit nutritionCubit}) {
    return TabBarView(children: [
      EnglishDailyRecipeCategoryBlock(nutCubit: nutritionCubit),
      ArabicDailyRecipeCategoryBlock(
        nutCubit: nutritionCubit,
      )
    ]);
  }

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

  changeCurrentMealType({required int index, bool isDailyRecipe = false}) {
    currentMealType = index;
    emit(ChangeCurrentMealTypeState());
    getFilteredRecipes(isDailyRecipe: isDailyRecipe, reload: true);
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

  bool isValidRecipe(BuildContext context) {
    if (englishNameController.text.isEmpty) {
      getToastMessage(
          message: S.of(context).englishNameFieldIsEmpty, );
      return false;
    } else if (arabicNameController.text.isEmpty) {
      getToastMessage(
          message: S.of(context).arabicNameFieldIsEmpty, );
      return false;
    } else if (englishCaloriesController.text.isEmpty) {
      getToastMessage(
          message: S.of(context).englishCaloriesFieldIsEmpty, );
      return false;
    } else if (arabicCaloriesController.text.isEmpty) {
      getToastMessage(
          message: S.of(context).arabicCaloriesFieldIsEmpty, );
      return false;
    } else if (englishProteinController.text.isEmpty) {
      getToastMessage(
          message: S.of(context).englishProteinFieldIsEmpty, );
      return false;
    } else if (arabicProteinController.text.isEmpty) {
      getToastMessage(
          message: S.of(context).arabicProteinFieldIsEmpty, );
      return false;
    } else if (englishCarbohydratesController.text.isEmpty) {
      getToastMessage(
          message: S.of(context).englishCarbohydratesFieldIsEmpty, );
      return false;
    } else if (arabicCarbohydratesController.text.isEmpty) {
      getToastMessage(
          message: S.of(context).arabicCarbohydratesFieldIsEmpty, );
      return false;
    } else if (englishAdvantageController.text.isEmpty) {
      getToastMessage(
          message: S.of(context).englishAdvantageFieldIsEmpty, );
      return false;
    } else if (arabicAdvantageController.text.isEmpty) {
      getToastMessage(
          message: S.of(context).arabicAdvantageFieldIsEmpty, );
      return false;
    } else if (imageLinkController.text.isEmpty) {
      getToastMessage(
          message: S.of(context).imageLinkFieldIsEmpty, );
      return false;
    } else if (!mealTypeCheckBoxes.contains(true)) {
      getToastMessage(
          message: S.of(context).mealTypeOptionsAreEmpty, );
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

  Map<String, dynamic> getRecipeModelMap() {
    return RecipeModel(
      english: EnglishRecipeModel(
          name: englishNameController.text,
          calories: englishCaloriesController.text,
          protein: englishProteinController.text,
          carbohydrates: englishCarbohydratesController.text,
          advantage: englishAdvantageController.text),
      arabic: ArabicRecipeModel(
          name: arabicNameController.text,
          calories: arabicCaloriesController.text,
          protein: arabicProteinController.text,
          carbohydrates: arabicCarbohydratesController.text,
          advantage: arabicAdvantageController.text),
      docId: '',
      imageLink: imageLinkController.text,
      isBreakfast: mealTypeCheckBoxes[0],
      isLunch: mealTypeCheckBoxes[1],
      isDinner: mealTypeCheckBoxes[2],
      isSnacks: mealTypeCheckBoxes[3],
    ).toJson();
  }

  addNewRecipe(
      {bool isDailyRecipe = false, required BuildContext context}) async {
    CollectionReference data = FirebaseFirestore.instance.collection(
        isDailyRecipe
            ? StringManager.collectionDailyRecipe
            : StringManager.collectionRecipes);
    emit(AddNewRecipeLoadingState());
    await data.add(getRecipeModelMap()).then((value) {
      emit(AddNewRecipeSuccessState());
      getToastMessage(message: S.of(context).success, );
    }).catchError((error) {
      emit(AddNewRecipeErrorState());
      getToastMessage(message: S.of(context).somethingWentWrong, );
      debugPrint(error.toString());
    });
    getFilteredRecipes(reload: true);
    clearRecipeAttributes();
    Get.back();
  }

  editRecipe(
      {required String docId,
      bool isDailyRecipe = false,
      required BuildContext context}) async {
    var data = FirebaseFirestore.instance
        .collection(isDailyRecipe
            ? StringManager.collectionDailyRecipe
            : StringManager.collectionRecipes)
        .doc(docId);
    emit(EditRecipeLoadingState());
    await data.update(getRecipeModelMap()).then((value) {
      emit(EditRecipeSuccessState());
      getToastMessage(message: S.of(context).success, );
      getFilteredRecipes(reload: true);
    }).catchError((error) {
      emit(EditRecipeErrorState());
      getToastMessage(message: S.of(context).somethingWentWrong, );
      debugPrint(error.toString());
    });
    Get.back();
  }

  deleteRecipe(
      {required String docId,
      bool isDailyRecipe = false,
      required BuildContext context}) async {
    emit(DeleteRecipeLoadingState());
    CollectionReference data = FirebaseFirestore.instance.collection(
        isDailyRecipe
            ? StringManager.collectionDailyRecipe
            : StringManager.collectionRecipes);
    await data.doc(docId).delete().then((value) {
      emit(DeleteRecipeSuccessState());
      getFilteredRecipes(reload: true);

      getToastMessage(message: S.of(context).success, );
    }).catchError((error) {
      emit(DeleteRecipeErrorState());
      debugPrint(error.toString());
      getToastMessage(message: S.of(context).somethingWentWrong, );
    });
  }

  getFilteredRecipes({bool isDailyRecipe = false, bool reload = false}) async {
    if (recipeModels[currentMealType].isNotEmpty &&
        isDailyRecipe == false &&
        !reload) return;
    var data = FirebaseFirestore.instance
        .collection(isDailyRecipe
            ? StringManager.collectionDailyRecipe
            : StringManager.collectionRecipes)
        .where(getFilterKey(), isEqualTo: true);
    emit(GetFilteredRecipesLoadingState());
    await data.get().then((value) {
      value.docs.forEach((element) {
        recipeModels[currentMealType]
            .add(RecipeModel.fromJson(json: element.data(), docId: element.id));
      });

      emit(GetFilteredRecipesSuccessState());
    }).catchError((error) {
      emit(GetFilteredRecipesErrorState());
      debugPrint(error.toString());
    });
  }

  processOfAddRecipes(
      {bool isDailyRecipe = false, required BuildContext context}) {
    if (isValidRecipe(context)) {
      addNewRecipe(isDailyRecipe: isDailyRecipe, context: context);
    }
  }

  //------------------------------------daily recipe----------------------
  setDailyRecipeCategoryAttributes() {
    englishDailyRecipeCategoryNameController.text =
        dailyRecipeCardModel!.english.name!;
    englishDailyRecipeCategoryCaloriesController.text =
        dailyRecipeCardModel!.english.calories!;
    arabicDailyRecipeCategoryNameController.text =
        dailyRecipeCardModel!.arabic.name!;
    arabicDailyRecipeCategoryCaloriesController.text =
        dailyRecipeCardModel!.arabic.calories!;
    dailyRecipeCategoryImageLinkController.text =
        dailyRecipeCardModel!.imageLink;
    emit(SetDailyRecipeCategoryAttributes());
  }

  Map<String, dynamic> getDailyRecipeCategoryMap() {
    return DailyRecipeCardModel(
            english: DailyRecipeCardEnglish(
                name: englishDailyRecipeCategoryNameController.text,
                calories: englishDailyRecipeCategoryCaloriesController.text),
            arabic: DailyRecipeCardArabic(
                name: arabicDailyRecipeCategoryNameController.text,
                calories: arabicDailyRecipeCategoryCaloriesController.text),
            imageLink: dailyRecipeCategoryImageLinkController.text)
        .toJson();
  }

  editDailyRecipeCategory() {
    emit(EditDailyRecipeCardLoadingState());
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionDailyRecipe)
        .doc(StringManager.dailyRecipeStaticDocId);
    data.update(getDailyRecipeCategoryMap()).then((value) {
      emit(EditDailyRecipeCardLoadingState());
      getDailyRecipeCategory(hasAccess: true);
    }).catchError((error) {
      emit(EditDailyRecipeCardLoadingState());
      debugPrint(error.toString());
    });
    Get.back();
  }

  getDailyRecipeCategory({required bool hasAccess}) async {
    if (!hasAccess) return;
    emit(GetDailyRecipeCardLoadingState());
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionDailyRecipe)
        .doc(StringManager.dailyRecipeStaticDocId);
    await data.get().then((value) {
      dailyRecipeCardModel = DailyRecipeCardModel.fromJson(json: value.data()!);
      emit(GetDailyRecipeCardSuccessState());
    }).catchError((error) {
      emit(GetDailyRecipeCardErrorState());
      debugPrint(error.toString());
    });
  }

//---------------------------------------------------------------------------
  setFoodMainElementAttributes({required FoodElementModel model}) {
    englishMainElementTitleController.text = model.english.title!;
    englishMainElementDescriptionController.text = model.english.description!;
    arabicMainElementTitleController.text = model.arabic.title!;
    arabicMainElementDescriptionController.text = model.arabic.description!;
    emit(SetFoodMainElement());
  }

  clearFoodMainElementAttributes() {
    englishMainElementTitleController.clear();
    englishMainElementDescriptionController.clear();
    arabicMainElementTitleController.clear();
    arabicMainElementDescriptionController.clear();
    emit(ClearFoodMainElement());
  }

  Map<String, dynamic> getFoodMainElementModelMap() {
    return FoodElementModel(
            english: EnglishFoodElementModel(
              title: englishMainElementTitleController.text,
              description: englishMainElementDescriptionController.text,
            ),
            arabic: ArabicFoodElementModel(
                title: arabicMainElementTitleController.text,
                description: arabicMainElementDescriptionController.text),
            docId: '')
        .toJson();
  }

  addNewFoodMainElement(BuildContext context) async {
    CollectionReference data = FirebaseFirestore.instance
        .collection(StringManager.collectionFoodMainElement);
    emit(AddNewFoodMainElementLoadingState());
    await data.add(getFoodMainElementModelMap()).then((value) {
      emit(AddNewFoodMainElementSuccessState());
      getFoodMainElement();
      getToastMessage(message: S.of(context).success, );
    }).catchError((error) {
      emit(AddNewFoodMainElementErrorState());
      getToastMessage(message: S.of(context).somethingWentWrong, );
      debugPrint(error.toString());
    });
    clearFoodMainElementAttributes();
    Get.back();
  }

  editFoodMainElement({required String docId,required BuildContext context}) async {
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionFoodMainElement)
        .doc(docId);
    emit(EditFoodMainElementLoadingState());
    await data.update(getFoodMainElementModelMap()).then((value) {
      emit(EditFoodMainElementSuccessState());
      getFoodMainElement();
      getToastMessage(
          message: S.of(context).success,
          
      );
    }).catchError((error) {
      emit(EditFoodMainElementErrorState());
      getToastMessage(
          message: S.of(context).somethingWentWrong,
          
      );
      debugPrint(error.toString());
    });
    clearFoodMainElementAttributes();
    Get.back();
  }

  deleteFoodMainElement({required String docId,required BuildContext context}) async {
    foodElementModels.clear();
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionFoodMainElement)
        .doc(docId);
    emit(DeleteFoodMainElementLoadingState());
    await data.delete().then((value) {
      emit(DeleteFoodMainElementSuccessState());
      getToastMessage(
          message: S.of(context).success,
          
      );
      getFoodMainElement();
    }).catchError((error) {
      emit(DeleteFoodMainElementErrorState());
      debugPrint(error.toString());
      getToastMessage(
          message: S.of(context).somethingWentWrong,
          
      );
    });
  }

  getFoodMainElement() async {
    foodElementModels.clear();
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionFoodMainElement);
    emit(GetFoodMainElementLoadingState());
    await data.get().then((value) {
      value.docs.forEach((element) {
        foodElementModels.add(
            FoodElementModel.fromJson(json: element.data(), docId: element.id));
      });

      emit(GetFoodMainElementSuccessState());
    }).catchError((error) {
      emit(GetFoodMainElementErrorState());
      debugPrint(error.toString());
    });
  }

//-----------------------------meal plan---------------------------------------
  Map<String, dynamic> getMealPlanMap() {
    List<Map<String, dynamic>> breakfast = [];
    List<Map<String, dynamic>> lunch = [];
    List<Map<String, dynamic>> dinner = [];
    List<Map<String, dynamic>> snacks = [];
    breakfastMealPlanRecipeModels.forEach((element) {
      breakfast.add(element.toJson());
    });
    lunchMealPlanRecipeModels.forEach((element) {
      lunch.add(element.toJson());
    });
    dinnerMealPlanRecipeModels.forEach((element) {
      dinner.add(element.toJson());
    });
    snacksMealPlanRecipeModels.forEach((element) {
      snacks.add(element.toJson());
    });

    Map<String, dynamic> map;
    map = {
      StringManager.mealPlanData: {
        StringManager.breakfastMealPlan: breakfast,
        StringManager.lunchMealPlan: lunch,
        StringManager.dinnerMealPlan: dinner,
        StringManager.snacksMealPlan: snacks,
      }
    };
    return map;
  }

  void getHasMealPlan() async {
    emit(HasMealPlanLoadingState());
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionUserProfiles)
        .doc(userDocId);
    await data.get().then((value) {
      hasMealPlan = value.data()!.containsKey(StringManager.mealPlanData);
      emit(HasMealPlanSuccessState());
      if (hasMealPlan) {
        getUserMealPlan();
      }
    }).catchError((error) {
      emit(HasMealPlanErrorState());
      debugPrint(error.toString());
    });
  }

  Future<bool> hasMealPlanRequest() async {
    try {
      var data = await FirebaseFirestore.instance
          .collection(StringManager.collectionMealPlansRequests)
          .where(StringManager.userDocId, isEqualTo: userDocId)
          .get();
      return data.docs.isNotEmpty;
    } catch (error) {
      debugPrint('Error checking meal plan request: $error');
      return false;
    }
  }

  void addMealPlanRecipe({required RecipeModel model}) {
    switch (currentMealType) {
      case 0:
        breakfastMealPlanRecipeModels.add(model);
        emit(AddMealPlanBreakfastState());
        return;
      case 1:
        lunchMealPlanRecipeModels.add(model);
        emit(AddMealPlanLunchState());
        return;
      case 2:
        dinnerMealPlanRecipeModels.add(model);
        emit(AddMealPlanDinnerState());
        return;
      case 3:
        snacksMealPlanRecipeModels.add(model);
        emit(AddMealPlanSnacksState());
        return;
    }
  }

  void deleteMealPlanRecipe({required RecipeModel model}) {
    switch (currentMealType) {
      case 0:
        breakfastMealPlanRecipeModels.remove(model);
        emit(DeleteMealPlanBreakfastState());
        return;
      case 1:
        lunchMealPlanRecipeModels.remove(model);
        emit(DeleteMealPlanLunchState());
        return;
      case 2:
        dinnerMealPlanRecipeModels.remove(model);
        emit(DeleteMealPlanDinnerState());
        return;
      case 3:
        snacksMealPlanRecipeModels.remove(model);
        emit(DeleteMealPlanSnacksState());
        return;
    }
  }

  bool isMealPlanRecipeSelected({required RecipeModel model}) {
    switch (currentMealType) {
      case 0:
        for (int i = 0; i < breakfastMealPlanRecipeModels.length; i++) {
          if (breakfastMealPlanRecipeModels[i].docId == model.docId) {
            return true;
          }
        }
        return false;

      case 1:
        for (int i = 0; i < lunchMealPlanRecipeModels.length; i++) {
          if (lunchMealPlanRecipeModels[i].docId == model.docId) {
            return true;
          }
        }
        return false;
      case 2:
        for (int i = 0; i < dinnerMealPlanRecipeModels.length; i++) {
          if (dinnerMealPlanRecipeModels[i].docId == model.docId) {
            return true;
          }
        }
        return false;
      default:
        for (int i = 0; i < snacksMealPlanRecipeModels.length; i++) {
          if (snacksMealPlanRecipeModels[i].docId == model.docId) {
            return true;
          }
        }
        return false;
    }
  }

  getAllMealPlanRequests() async {
    requestsModels.clear();
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionMealPlansRequests)
        .orderBy(StringManager.mealPlanRequestDate);
    emit(GetAllMealPlanRequestsLoadingState());
    await data.get().then((value) {
      value.docs.forEach((element) {
        requestsModels.add(MealPlanRequestModel.fromJson(
            json: element.data(), docId: element.id));
      });
      emit(GetAllMealPlanRequestsSuccessState());
    }).catchError((error) {
      emit(GetAllMealPlanRequestsErrorState());
      debugPrint(error.toString());
    });
  }

  createMealPlan({
    required String requestDocId,
    required String clientDocId,
  }) async {
    emit(CreateMealPlanLoadingState());
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionUserProfiles)
        .doc(clientDocId);
    await data.update(getMealPlanMap()).then((value) {
      emit(CreateMealPlanSuccessState());
      deleteRequest(requestDocId: requestDocId);
      Get.back();
      Get.back();
    }).catchError((error) {
      emit(CreateMealPlanErrorState());
      debugPrint(error.toString());
    });
  }

  deleteRequest({required String requestDocId}) {
    emit(DeleteMealPlanRequestLoadingState());
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionMealPlansRequests)
        .doc(requestDocId);
    data.delete().then((value) {
      emit(DeleteMealPlanRequestSuccessState());
      getAllMealPlanRequests();
    }).catchError((error) {
      emit(DeleteMealPlanRequestErrorState());
      debugPrint(error.toString());
    });
  }

  getUserMealPlan() async {
    emit(GetMealPlanLoadingState());
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionUserProfiles)
        .doc(userDocId);
    await data.get().then((value) {
      mealPlanModel = MealPlanModel.fromJson(value.data()!);
      emit(GetMealPlanSuccessState());
    }).catchError((error) {
      emit(GetMealPlanErrorState());
      debugPrint(error.toString());
    });
  }
}
