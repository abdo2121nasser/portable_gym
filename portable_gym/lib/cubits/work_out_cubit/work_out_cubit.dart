import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/work_out_block/tab_bar_view_blocks/english_body_category_tab_bar_view_block.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/work_out_block/tab_bar_view_blocks/english_training_tab_bar_view_block.dart';
import 'package:portable_gym/resourses/managers_files/string_manager.dart';
import 'package:portable_gym/resourses/models/work_out_models/body_category_model.dart';
import 'package:portable_gym/resourses/models/work_out_models/training_model.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/home_screen_blocks/work_out_block/tab_bar_view_blocks/arabic_body_category_tab_bar_view_block.dart';
import '../../resourses/blocks/home_screen_blocks/work_out_block/tab_bar_view_blocks/arabic_training_tab_bar_view_block.dart';
import '../../resourses/managers_files/toast_massage_manager.dart';

part 'work_out_state.dart';

class WorkOutCubit extends Cubit<WorkOutState> {
  WorkOutCubit() : super(WorkOutInitial());

  static WorkOutCubit get(context) => BlocProvider.of(context);

  List<BodyCategoryModel> bodyCategoryModel = [];
  BodyCategoryModel? dailyDodyCategoryModel;
  List<TrainingModel> trainingModel = [];

  DateTime trainingPeriod = DateTime(0, 0, 0, 0, 0, 0);
  DateTime bodyCategoryTotalTime = DateTime(0, 0, 0, 0, 0, 0);
  int currentLevel = 0;

  //--------------------------------------------------------------------------------------

  List<String> trainingEnglishLables = [
    StringManager.trainingEnglishLableName,
    StringManager.trainingEnglishLableNumberOfRepetation,
    StringManager.trainingEnglishLableNumberOfRounds,
    StringManager.trainingEnglishLablePriority,
    StringManager.trainingEnglishLableInstruction,
    StringManager.trainingEnglishLableVideoLink,
  ];
  List<String> trainingArabicLables = [
    StringManager.trainingArabicLableName,
    StringManager.trainingArabicLableNumberOfRepetation,
    StringManager.trainingArabicLableNumberOfRounds,
    StringManager.trainingArabicLablePriority,
    StringManager.trainingArabicLableInstruction,
    StringManager.trainingArabicLableVideoLink,
  ];
  //---------------------------------------
  List<String> bodyCategoryEnglishLables = [
    StringManager.bodyCategoryEnglishLableTitle,
    StringManager.bodyCategoryEnglishLableCalories,
    StringManager.bodyCategoryEnglishLableNumberOfExercises,
    StringManager.bodyCategoryLableImageLink
  ];
  List<String> bodyCategoryArabicLables = [
    StringManager.bodyCategoryArabicLableTitle,
    StringManager.bodyCategoryArabicLableCalories,
    StringManager.bodyCategoryArabicLableNumberOfExercises,
  ];
  TextEditingController trainingEnglishNameController = TextEditingController();
  TextEditingController trainingEnglishNumberOfReputationController =
      TextEditingController();
  TextEditingController trainingEnglishNumberOfRoundsController =
      TextEditingController();
  TextEditingController trainingPriorityController = TextEditingController();
  TextEditingController trainingEnglishInstructionController =
      TextEditingController();

  TextEditingController trainingArabicNameController = TextEditingController();
  TextEditingController trainingArabicNumberOfReputationController =
      TextEditingController();
  TextEditingController trainingArabicNumberOfRoundsController =
      TextEditingController();

  TextEditingController trainingArabicInstructionController =
      TextEditingController();

  TextEditingController trainingVideoLinkController = TextEditingController();
  bool trainingIsPaid=false;

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

 TabBarView getTrainingTabBarView({required WorkOutCubit workOutCubit}){
    return TabBarView(children: [
      EnglishTrainingTabBarViewBlock(workCubit: workOutCubit),
      ArabicTrainingTabBarViewBlock(workCubit: workOutCubit,)
    ]);
  }
  TabBarView getBodyCategoryTabBarView({required WorkOutCubit workOutCubit}){
   return TabBarView(children: [
     EnglishBodyCategoryTabBarViewBlock(workCubit: workOutCubit),
     ArabicBodyCategoryTabBarViewBlock(workCubit: workOutCubit,)
   ]);
  }

  getLevelLabels({ required context}) {
    List<String> lables = [
      S.of(context).beginner,
      S.of(context).intermediate,
      S.of(context).advanced,
    ];
    return lables;
  }

  changeCurrentLevel({required int newLevel}) {
    currentLevel = newLevel;
    emit(ChangeCurrentLevelState());
    getBodyCategories();
  }

  List<TextEditingController> getTrainingEnglishControllers() {
    return [
      trainingEnglishNameController,
      trainingEnglishNumberOfReputationController,
      trainingEnglishNumberOfRoundsController,
      trainingPriorityController,
      trainingEnglishInstructionController,
      trainingVideoLinkController
    ];
  }

  List<TextEditingController> getTrainingArabicControllers() {
    return [
      trainingArabicNameController,
      trainingArabicNumberOfReputationController,
      trainingArabicNumberOfRoundsController,
      trainingPriorityController,
      trainingArabicInstructionController,
      trainingVideoLinkController
    ];
  }

  getEnglishBodyCategoryControllers({required int index}) {
    List<TextEditingController> controllers = [
      bodyCategoryEnglishTitleController,
      bodyCategoryEnglishCaloriesController,
      bodyCategoryEnglishNumberOfExercisesController,
      bodyCategoryImageLinkController,
    ];
    return controllers[index];
  }

  getArabicBodyCategoryControllers({required int index}) {
    List<TextEditingController> controllers = [
      bodyCategoryArabicTitleController,
      bodyCategoryArabicCaloriesController,
      bodyCategoryArabicNumberOfExercisesController,
    ];
    return controllers[index];
  }

  setTrainingPeriod({required DateTime date}) {
    trainingPeriod = date;
    emit(SetTrainingPeriod());
  }
  setTrainingIsPaid({required bool value})
  {
    trainingIsPaid=value;
    emit(SetTrainingIsPaid());
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
    } else if (trainingEnglishNumberOfReputationController.text.isEmpty) {
      getToastMessage(
        message: 'the english number of reputation field is empty',
      );
      return false;
    } else if (trainingArabicNumberOfReputationController.text.isEmpty) {
      getToastMessage(
        message: 'the arabic number of reputation field is empty',
      );
      return false;
    } else if (trainingEnglishNumberOfRoundsController.text.isEmpty) {
      getToastMessage(
        message: 'the english number of round field is empty',
      );
      return false;
    } else if (trainingArabicNumberOfRoundsController.text.isEmpty) {
      getToastMessage(
        message: 'the arabic number of round field is empty',
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

  clearTrainingAttributes() {
    trainingEnglishNameController.clear();
    trainingEnglishNumberOfReputationController.clear();
    trainingEnglishNumberOfRoundsController.clear();
    trainingEnglishInstructionController.clear();
    trainingArabicNameController.clear();
    trainingArabicNumberOfReputationController.clear();
    trainingArabicNumberOfRoundsController.clear();
    trainingArabicInstructionController.clear();
    trainingPriorityController.clear();
    trainingVideoLinkController.clear();
    trainingPeriod = DateTime(0, 0, 0, 0, 0, 0);
    trainingIsPaid=false;
    emit(ClearTrainingControllersState());
  }

  setTrainingAttributes({required TrainingModel model}) {
    trainingEnglishNameController.text = model.english!.name!;
    trainingEnglishNumberOfReputationController.text =
        model.english!.numberOfReputation!;
    trainingEnglishNumberOfRoundsController.text =
        model.english!.numberOfRounds!;

    trainingEnglishInstructionController.text = model.english!.instructions!;
    trainingArabicNameController.text = model.arabic!.name!;
    trainingArabicNumberOfReputationController.text =
        model.arabic!.numberOfReputation!;
    trainingArabicNumberOfRoundsController.text =
        model.arabic!.numberOfRounds!;
    trainingArabicInstructionController.text = model.arabic!.instructions!;
    trainingPriorityController.text = model.priority.toString();
    trainingVideoLinkController.text = model.videoLink!;
    trainingPeriod =
        DateTime(0, 0, 0, model.hour!, model.minute!, model.second!);
    trainingIsPaid=model.isPaid!;
    emit(SetTrainingControllersState());
  }

  addNewTraining(
      {required String bodyCategory, bool isDailyCategory = false}) async {
    emit(AddNewTrainingLoadingState());
    CollectionReference data = FirebaseFirestore.instance
        .collection(StringManager.collectionTrainings);
    await data.add({
      StringManager.trainingEnglishName: trainingEnglishNameController.text,
      StringManager.trainingEnglishNumberOfReputation:
          trainingEnglishNumberOfReputationController.text,
      StringManager.trainingEnglishNumberOfRounds:
          trainingEnglishNumberOfRoundsController.text,
      StringManager.trainingEnglishInstruction:
          trainingEnglishInstructionController.text,
      StringManager.trainingArabicName: trainingArabicNameController.text,
      StringManager.trainingArabicNumberOfReputation:
          trainingArabicNumberOfReputationController.text,
      StringManager.trainingArabicNumberOfRounds:
          trainingArabicNumberOfRoundsController.text,
      StringManager.trainingArabicInstruction:
          trainingArabicInstructionController.text,
      StringManager.trainingVideoLink: trainingVideoLinkController.text,
      StringManager.trainingLevel:
          getBodyCategoryLevelString(currentLevelIndex: currentLevel),
      StringManager.trainingBodyCategory: bodyCategory,
      StringManager.trainingPriority:
          int.parse(trainingPriorityController.text),
      StringManager.trainingHourPeriod: trainingPeriod.hour,
      StringManager.trainingMinutePeriod: trainingPeriod.minute,
      StringManager.trainingSecondPeriod: trainingPeriod.second,
      StringManager.trainingIsPaid:trainingIsPaid,
      StringManager.isDailyTraining:isDailyCategory

    }).then((value) {
      emit(AddNewTrainingSuccessState());
      getToastMessage(
        message: 'added successfully',
      );
    }).catchError((error) {
      emit(AddNewTrainingErrorState());
      getToastMessage(
        message: 'a problem has happened',
      );
      print(error);
    });
    getTraining(bodyCategory: bodyCategory);
     Get.back();
  }

  editTraining({required String docId, required String bodyCategory}) async {
    emit(EditTrainingLoadingState());
    CollectionReference data = FirebaseFirestore.instance
        .collection(StringManager.collectionTrainings);
    await data.doc(docId).update({
      StringManager.trainingEnglishName: trainingEnglishNameController.text,
      StringManager.trainingEnglishNumberOfReputation:
          trainingEnglishNumberOfReputationController.text,
      StringManager.trainingEnglishInstruction:
          trainingEnglishInstructionController.text,
      StringManager.trainingArabicName: trainingArabicNameController.text,
      StringManager.trainingArabicNumberOfReputation:
          trainingArabicNumberOfReputationController.text,
      StringManager.trainingArabicInstruction:
          trainingArabicInstructionController.text,
      StringManager.trainingVideoLink: trainingVideoLinkController.text,
      StringManager.trainingPriority:
          int.parse(trainingPriorityController.text),
      StringManager.trainingHourPeriod: trainingPeriod.hour,
      StringManager.trainingMinutePeriod: trainingPeriod.minute,
      StringManager.trainingSecondPeriod: trainingPeriod.second,
      StringManager.trainingIsPaid:trainingIsPaid
    }).then((value) {
      emit(EditTrainingSuccessState());

      getTraining(bodyCategory: bodyCategory);
    }).catchError((error) {
      emit(EditTrainingErrorState());
      print(error.toString());
    });
    Get.back();

  }

  deleteTraining({required String docId, required String bodyCategory}) async {
    emit(DeleteTrainingLoadingState());
    CollectionReference data = FirebaseFirestore.instance
        .collection(StringManager.collectionTrainings);
    await data.doc(docId).delete().then((value) {
      emit(DeleteTrainingSuccessState());
      getToastMessage(
        message: 'deleted successfully',
      );
      getTraining(bodyCategory: bodyCategory);
    }).catchError((error) {
      emit(DeleteTrainingErrorState());
      print(error);
      getToastMessage(
        message: 'a problem has happened',
      );
    });
  }

  processOfAddingTraining({
    required String bodyCategory,
    bool isDailyCategory = false,
  }) {
    if (validateAddTraining()) {
      addNewTraining(
          bodyCategory: bodyCategory, isDailyCategory: isDailyCategory);
    }
  }

  getTraining({required String bodyCategory, bool isDailyCategory = false}) async {
    trainingModel.clear();
    var data;
    if (isDailyCategory) {
      data = FirebaseFirestore.instance
          .collection(StringManager.collectionTrainings).where(StringManager.isDailyTraining, isEqualTo: true);
    } else {
      data = FirebaseFirestore.instance
          .collection(StringManager.collectionTrainings)
          .where(
            StringManager.trainingBodyCategory,
            isEqualTo: bodyCategory,
          )
          .where(StringManager.bodyCategoryLevel,
              isEqualTo:
                  getBodyCategoryLevelString(currentLevelIndex: currentLevel))
          .orderBy(StringManager.trainingPriority);
    }

    emit(GetTrainingLoadingState());
    await data.get().then((value) {
      value.docs.forEach((element) {
        trainingModel.add(
            TrainingModel.fromJson(json: element.data(), docId: element.id));
      });
      emit(GetTrainingSuccessState());
    }).catchError((error) {
      emit(GetTrainingErrorState());
      print(error);
    });
  }
 Future<TrainingModel>  getTrainingUsingDocId({required String trainingDocId}) async {
   TrainingModel specificTraining;
   emit(GetTrainingUsingDocIdLoadingState());
 return await  FirebaseFirestore.instance
        .collection(StringManager.collectionTrainings).doc(trainingDocId).get().then((value) {
   emit(GetTrainingUsingDocIdSuccessState());
   return  specificTraining=TrainingModel.fromJson(json: value.data()!, docId: value.id);

  }).catchError((error){
    emit(GetTrainingUsingDocIdErrorState());
    debugPrint(error);

  });

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
    emit(ClearBodyCategoryControllersState());
  }

  getBodyCategoryLevelString(
      {required int currentLevelIndex, bool isLable = false, context}) {
    List<String> levels = [
      StringManager.bodyCategoryLevelBeginner,
      StringManager.bodyCategoryLevelIntermediate,
      StringManager.bodyCategoryLevelAdvanced,
    ];

    if (isLable) {
      List<String> lableLevels = [
        S.of(context).beginner,
        S.of(context).intermediate,
        S.of(context).advanced,
      ];
      return lableLevels[currentLevelIndex];
    } else
      return levels[currentLevelIndex];
  }

  setBodyCategoryAttributes({required BodyCategoryModel model}) {
    bodyCategoryEnglishTitleController.text = model.english!.title!;
    bodyCategoryEnglishNumberOfExercisesController.text =
        model.english!.numberOfExercises!;
    bodyCategoryEnglishCaloriesController.text = model.english!.calories!;
    bodyCategoryImageLinkController.text = model.imageLink!;
    bodyCategoryArabicTitleController.text = model.arabic!.title!;
    bodyCategoryArabicNumberOfExercisesController.text =
        model.arabic!.numberOfExercises!;
    bodyCategoryArabicCaloriesController.text = model.arabic!.calories!;
    bodyCategoryTotalTime = DateTime(
      0,
      0,
      0,
      model.hour!,
      model.minute!,
      model.second!,
    );
    emit(SetBodyCategoryControllersState());
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
      StringManager.bodyCategoryLevel:
          getBodyCategoryLevelString(currentLevelIndex: currentLevel),
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

  editBodyCategory({required String docId, bool isDailyCategory = false}) {
    emit(EditBodyCategoryLoadingState());
    CollectionReference data = FirebaseFirestore.instance
        .collection(StringManager.collectionBodyCategory);
    data.doc(docId).update({
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
      StringManager.bodyCategoryTotalTimeHour: bodyCategoryTotalTime.hour,
      StringManager.bodyCategoryTotalTimeMinute: bodyCategoryTotalTime.minute,
      StringManager.bodyCategoryTotalTimeSecond: bodyCategoryTotalTime.second,
    }).then((value) {
      emit(EditBodyCategorySuccessState());
      getToastMessage(
        message: 'the category has been edited',
      );
      if (isDailyCategory)
        getDailyBodyCategory();
      else
        getBodyCategories();
    }).catchError((error) {
      emit(EditBodyCategoryErrorState());
      print(error.toString());
      getToastMessage(
        message: 'a problem has happened',
      );
    });
    Get.back();
  }

  deleteBodyCategory({required String docId}) async {
    emit(deleteBodyCategoryLoadingState());
    CollectionReference data = FirebaseFirestore.instance
        .collection(StringManager.collectionBodyCategory);
    await data.doc(docId).delete().then((value) {
      emit(deleteBodyCategorySuccessState());
      getToastMessage(message: 'the category has been deleted');
    }).catchError((error) {
      emit(deleteBodyCategoryErrorState());

      print(error);
      getToastMessage(message: 'an error has happened');
    });
  }

  processOfAddingBodyCategory() {
    if (validateAddBodyCategory()) {
      addNewBodyCategory();
      getBodyCategories();
    }
  }

  processOfDeletingBodyCategory(
      {required String docId, required String bodyCategory}) async {
    await getTraining(bodyCategory: bodyCategory);
    trainingModel.forEach((element) async {
      await deleteTraining(docId: element.docId!, bodyCategory: bodyCategory);
    });
    await deleteBodyCategory(docId: docId);
    await getBodyCategories();
  }

  getBodyCategories() async {
    bodyCategoryModel.clear();
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionBodyCategory)
        .where(StringManager.bodyCategoryLevel,
            isEqualTo:
                getBodyCategoryLevelString(currentLevelIndex: currentLevel))
        .orderBy(StringManager.bodyCategoryEnglishTitle);
    emit(GetBodyCategoryLoadingState());
    await data.get().then((value) {
      value.docs.forEach((element) {
        //handling not receiving the daily category
        if (element.data()[StringManager.isDailyCategory] == null) {
          bodyCategoryModel.add(BodyCategoryModel.fromJson(
              json: element.data(), docId: element.id));
        }
      });
      emit(GetBodyCategorySuccessState());
    }).catchError((error) {
      emit(GetBodyCategoryErrorState());
      print(error);
    });
  }

  getDailyBodyCategory() async {
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionBodyCategory)
        .where(StringManager.isDailyCategory, isEqualTo: true)
        .orderBy(StringManager.bodyCategoryEnglishTitle);
    emit(GetDailyBodyCategoryLoadingState());
    await data.get().then((value) {
      dailyDodyCategoryModel = BodyCategoryModel.fromJson(
          json: value.docs[0].data(), docId: value.docs[0].id);

      emit(GetDailyBodyCategorySuccessState());
    }).catchError((error) {
      emit(GetDailyBodyCategoryErrorState());
      print(error);
    });
  }
}
