import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/full_input_block.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/work_out_block/tab_bar_view_blocks/english_body_category_tab_bar_view_block.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/work_out_block/tab_bar_view_blocks/english_training_tab_bar_view_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/string_manager.dart';
import 'package:portable_gym/resourses/models/work_out_models/body_category_model.dart';
import 'package:portable_gym/resourses/services/google_drive_service/google_drive_sevice.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/home_screen_blocks/work_out_block/tab_bar_view_blocks/arabic_body_category_tab_bar_view_block.dart';
import '../../resourses/blocks/home_screen_blocks/work_out_block/tab_bar_view_blocks/arabic_training_tab_bar_view_block.dart';
import '../../resourses/managers_files/toast_messege_manager.dart';

part 'work_out_state.dart';

class WorkOutCubit extends Cubit<WorkOutState> {
  WorkOutCubit() : super(WorkOutInitial());

  static WorkOutCubit get(context) => BlocProvider.of(context);

  List<BodyCategoryModel> bodyCategoryModel = [];

  DateTime trainingPeriod = DateTime(0, 0, 0, 0, 0, 0);
  DateTime bodyCategoryTotalTime = DateTime(0, 0, 0, 0, 0, 0);

  //--------------------------------------------------------------------------------------
  TabBarView TrainingTabBarView = TabBarView(children: [
    EnglishTrainingTabBarViewBlock(),
    ArabicTrainingTabBarViewBlock()
  ]);
  TabBarView BodyCategoryTabBarView = TabBarView(children: [
    EnglishBodyCategoryTabBarViewBlock(),
    ArabicBodyCategoryTabBarViewBlock()
  ]);
  List<String> trainingEnglishLables = [
    StringManager.trainingEnglishLableName,
    StringManager.trainingEnglishLableLevel,
    StringManager.trainingEnglishLableNumberOfRepetation,
    StringManager.trainingEnglishLableRoundNumber,
    StringManager.trainingEnglishLableInstruction,
    StringManager.trainingEnglishLableVideoLink,
  ];
  List<String> trainingArabicLables = [
    StringManager.trainingArabicLableName,
    StringManager.trainingArabicLableLevel,
    StringManager.trainingArabicLableNumberOfRepetation,
    StringManager.trainingArabicLableRoundNumber,
    StringManager.trainingArabicLableInstruction,
    StringManager.trainingArabicLableVideoLink,
  ];
  List<String> bodyCategoryEnglishLables = [
    StringManager.bodyCategoryEnglishLableTitle,
    StringManager.bodyCategoryEnglishLableKcalories,
    StringManager.bodyCategoryEnglishLableNumberOfExercises,
    StringManager.bodyCategoryLableImageLink
  ];
  List<String> bodyCategoryArabicLables = [
    StringManager.bodyCategoryArabicLableTitle,
    StringManager.bodyCategoryArabicLableCalories,
    StringManager.bodyCategoryArabicLableNumberOfExercises,
  ];
  TextEditingController trainingEnglishNameController = TextEditingController();
  TextEditingController trainingEnglishLevelController =
      TextEditingController();
  TextEditingController trainingEnglishNumberOfRepetationController =
      TextEditingController();
  TextEditingController trainingEnglishRoundNumberController =
      TextEditingController();
  TextEditingController trainingEnglishInstructionController =
      TextEditingController();

  TextEditingController trainingArabicNameController = TextEditingController();
  TextEditingController trainingArabicLevelController = TextEditingController();
  TextEditingController trainingArabicNumberOfRepetationController =
      TextEditingController();
  TextEditingController trainingArabicRoundNumberController =
      TextEditingController();
  TextEditingController trainingArabicInstructionController =
      TextEditingController();

  TextEditingController trainingVideoLinkController = TextEditingController();

  //-----------------------------------------------------------------------------
  TextEditingController bodyCategoryEnglishTitleController =
      TextEditingController();
  TextEditingController bodyCategoryEnglishNumberOfExercisesController =
      TextEditingController();
  TextEditingController bodyCategoryEnglishCaloriesController =
      TextEditingController();
  TextEditingController bodyCategoryImageLinkController =
      TextEditingController();
  TextEditingController bodyCategoryArabicTitleController =
      TextEditingController();
  TextEditingController bodyCategoryArabicNumberOfExercisesController =
      TextEditingController();
  TextEditingController bodyCategoryArabicCaloriesController =
      TextEditingController();

//---------------------------------------------------------------------------------------------------

  getCategoryLabels({required int index, required context}) {
    List<String> lables = [
      S.of(context).beginner,
      S.of(context).intermediate,
      S.of(context).advanced,
    ];
    return lables[index];
  }

  List<TextEditingController> getTrainingEnglishControllers() {
    List<TextEditingController> controllers = [
      trainingEnglishNameController,
      trainingEnglishLevelController,
      trainingEnglishNumberOfRepetationController,
      trainingEnglishRoundNumberController,
      trainingEnglishInstructionController,
      trainingVideoLinkController
    ];
    return controllers;
  }

  List<TextEditingController> getTrainingArabicControllers() {
    List<TextEditingController> controllers = [
      trainingArabicNameController,
      trainingArabicLevelController,
      trainingArabicNumberOfRepetationController,
      trainingArabicRoundNumberController,
      trainingArabicInstructionController,
      trainingVideoLinkController
    ];
    return controllers;
  }

  getEnglishBodyCategoryControllers({required int index}) {
    List<TextEditingController> controllers = [
      bodyCategoryEnglishTitleController,
      bodyCategoryEnglishNumberOfExercisesController,
      bodyCategoryEnglishCaloriesController,
      bodyCategoryImageLinkController,
    ];
    return controllers[index];
  }

  getArabicBodyCategoryControllers({required int index}) {
    List<TextEditingController> controllers = [
      bodyCategoryArabicTitleController,
      bodyCategoryArabicNumberOfExercisesController,
      bodyCategoryArabicCaloriesController,
    ];
    return controllers[index];
  }

  setTrainingPeriod({required DateTime date}) {
    trainingPeriod = date;
    emit(SetTrainingPeriod());
  }

  setBodyCategoryTotalTime({required DateTime date}) {
    bodyCategoryTotalTime = date;
    emit(SetBodyCategoryTotalTime());
  }

//------------------------------------------------------------------------------
  bool validateAddTraining() {
    if (trainingEnglishNameController.text.isEmpty) {
      getToastMessage(
        message: 'the english name field is empty',
      );
      return false;
    } else if (trainingArabicNameController.text.isEmpty) {
      getToastMessage(
        message: 'the arabic name field is empty',
      );
      return false;
    } else if (trainingEnglishLevelController.text.isEmpty) {
      getToastMessage(
        message: 'the english level field is empty',
      );
      return false;
    } else if (trainingArabicLevelController.text.isEmpty) {
      getToastMessage(
        message: 'the arabic level field is empty',
      );
      return false;
    } else if (trainingEnglishNumberOfRepetationController.text.isEmpty) {
      getToastMessage(
        message: 'the english number of reputation field is empty',
      );
      return false;
    } else if (trainingArabicNumberOfRepetationController.text.isEmpty) {
      getToastMessage(
        message: 'the arabic number of reputation field is empty',
      );
      return false;
    } else if (trainingEnglishRoundNumberController.text.isEmpty) {
      getToastMessage(
        message: 'the english round number field is empty',
      );
      return false;
    } else if (trainingArabicRoundNumberController.text.isEmpty) {
      getToastMessage(
        message: 'the arabic round number field is empty',
      );
      return false;
    } else if (trainingEnglishInstructionController.text.isEmpty) {
      getToastMessage(
        message: 'the english instruction field is empty',
      );
      return false;
    } else if (trainingArabicInstructionController.text.isEmpty) {
      getToastMessage(
        message: 'the arabic instruction field is empty',
      );
      return false;
    } else if (trainingVideoLinkController.text.isEmpty) {
      getToastMessage(
        message: 'the video link field is empty',
      );
      return false;
    } else if (trainingPeriod.second == 0 &&
        trainingPeriod.minute == 0 &&
        trainingPeriod.hour == 0) {
      getToastMessage(
        message: 'the training period is not set',
      );
      return false;
    } else {
      return true;
    }
  }

  addNewTraining() async {
    emit(AddNewTrainingLoadingState());
    CollectionReference data = FirebaseFirestore.instance
        .collection(StringManager.collectionTrainings);
    await data.add({
      StringManager.trainingEnglishName: trainingEnglishNameController.text,
      StringManager.trainingEnglishLevel: trainingEnglishLevelController.text,
      StringManager.trainingEnglishNumberOfReputation:
          trainingEnglishNumberOfRepetationController.text,
      StringManager.trainingEnglishRoundNumber:
          trainingEnglishRoundNumberController.text,
      StringManager.trainingEnglishInstruction:
          trainingEnglishInstructionController.text,
      StringManager.trainingArabicName: trainingArabicNameController.text,
      StringManager.trainingArabicLevel: trainingArabicLevelController.text,
      StringManager.trainingArabicNumberOfReputation:
          trainingArabicNumberOfRepetationController.text,
      StringManager.trainingArabicRoundNumber:
          trainingArabicRoundNumberController.text,
      StringManager.trainingArabicInstruction:
          trainingArabicInstructionController.text,
      StringManager.trainingVideoLink: trainingVideoLinkController.text,
      StringManager.trainingHourPeriod: trainingPeriod.hour,
      StringManager.trainingMinutePeriod: trainingPeriod.minute,
      StringManager.trainingSecondPeriod: trainingPeriod.second,
    }).then((value) {
      emit(AddNewTrainingSuccessState());
    }).catchError((error) {
      emit(AddNewTrainingErrorState());
      getToastMessage(
        message: 'a problem has happened',
      );
      print(error);
    });
  }

  processOfAddingTraining() {
    if (validateAddTraining()) {
      addNewTraining();
    }
  }

//------------------------------------------------------------------------------
  bool validateAddBodyCategory() {
    if (bodyCategoryEnglishTitleController.text.isEmpty) {
      getToastMessage(
        message: 'the English title field is empty',
      );
      return false;
    } else if (bodyCategoryEnglishCaloriesController.text.isEmpty) {
      getToastMessage(
        message: 'the english calories field is empty',
      );
      return false;
    } else if (bodyCategoryImageLinkController.text.isEmpty) {
      getToastMessage(
        message: 'the image link field is empty',
      );
      return false;
    } else if (bodyCategoryEnglishNumberOfExercisesController.text.isEmpty) {
      getToastMessage(
        message: 'the english number of exercises field is empty',
      );
      return false;
    } else if (bodyCategoryArabicTitleController.text.isEmpty) {
      getToastMessage(
        message: 'the arabic title field is empty',
      );
      return false;
    } else if (bodyCategoryArabicCaloriesController.text.isEmpty) {
      getToastMessage(
        message: 'the arabic calories field is empty',
      );
      return false;
    } else if (bodyCategoryArabicNumberOfExercisesController.text.isEmpty) {
      getToastMessage(
        message: 'the arabic number of exercises field is empty',
      );
      return false;
    } else if (bodyCategoryTotalTime.second == 0 &&
        bodyCategoryTotalTime.minute == 0 &&
        bodyCategoryTotalTime.hour == 0) {
      getToastMessage(
        message: 'the total time is not set time',
      );
      return false;
    } else
      return true;
  }

  clearBodyCategoryAttributes() {
    bodyCategoryEnglishTitleController.clear();
    bodyCategoryEnglishNumberOfExercisesController.clear();
    bodyCategoryEnglishCaloriesController.clear();
    bodyCategoryImageLinkController.clear();
    bodyCategoryArabicTitleController.clear();
    bodyCategoryArabicNumberOfExercisesController.clear();
    bodyCategoryArabicCaloriesController.clear();
    bodyCategoryTotalTime = DateTime(0, 0, 0, 0, 0, 0);
  }

  addNewBodyCategory() async {
    emit(AddNewBodyCategoryLoadingState());
    CollectionReference data = FirebaseFirestore.instance
        .collection(StringManager.collectionBodyCategory);
    await data.add({
      StringManager.bodyCategoryEnglishTitle:
          bodyCategoryEnglishTitleController.text,
      StringManager.bodyCategoryEnglishCalories:
          bodyCategoryEnglishCaloriesController.text,
      StringManager.bodyCategoryEnglishNumberOfExercises:
          bodyCategoryEnglishNumberOfExercisesController.text,

      StringManager.bodyCategoryArabicTitle:
          bodyCategoryArabicTitleController.text,
      StringManager.bodyCategoryArabicCalories:
          bodyCategoryArabicCaloriesController.text,
      StringManager.bodyCategoryArabicNumberOfExercises:
          bodyCategoryArabicNumberOfExercisesController.text,

      StringManager.bodyCategoryImageLink: bodyCategoryImageLinkController.text,
      StringManager.bodyCategoryLevel: 'beginner',
      //todo fix this to the filter of levels
      StringManager.bodyCategoryTotalTimeHour: bodyCategoryTotalTime.hour,
      StringManager.bodyCategoryTotalTimeMinute: bodyCategoryTotalTime.minute,
      StringManager.bodyCategoryTotalTimeSecond: bodyCategoryTotalTime.second,
    }).then((value) {
      emit(AddNewBodyCategorySuccessState());
      getToastMessage(
        message: 'successfully added',
      );
    }).catchError((error) {
      getToastMessage(
        message: 'an error has happened',
      );
      emit(AddNewBodyCategoryErrorState());
      print(error.toString());
    });
    Get.back();
  }

  processOfAddingBodyCategory() {
    if (validateAddBodyCategory()) {
      addNewBodyCategory();
      clearBodyCategoryAttributes();
    }
  }

  getBodyCategories() {
    bodyCategoryModel.clear();
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionBodyCategory)
        .orderBy(StringManager.bodyCategoryEnglishTitle);
    emit(GetBodyCategoryLoadingState());
    data.get().then((value) {
      value.docs.forEach((element) {
        bodyCategoryModel.add(BodyCategoryModel.fromJson(json: element.data()));
      });
      emit(GetBodyCategorySuccessState());
    }).catchError((error) {
      emit(GetBodyCategoryErrorState());
      print(error);
    });
  }
}
