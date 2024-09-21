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

  List<List<BodyCategoryModel>> bodyCategoryModels = List<List<BodyCategoryModel>>.generate(3, (index) => []);
  BodyCategoryModel? dailyDodyCategoryModel;
  List<TrainingModel> trainingModels = [];

  // DateTime trainingPeriod = DateTime(0, 0, 0, 0, 0, 0);
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
  TextEditingController trainingStartPeriodController = TextEditingController();
  TextEditingController trainingEndPeriodController = TextEditingController();

  TextEditingController trainingVideoLinkController = TextEditingController();
  bool trainingIsPaid = false;

  //----------------------------------------------------------------------------
  TextEditingController bodyCategoryEnglishTitleController =
      TextEditingController();
  TextEditingController bodyCategoryEnglishNumberOfExercisesController =
      TextEditingController();
  // TextEditingController bodyCategoryEnglishCaloriesController =
  //     TextEditingController();
  TextEditingController bodyCategoryImageLinkController =
      TextEditingController();
  TextEditingController bodyCategoryDownloadFilesLinkController =
      TextEditingController();
  TextEditingController bodyCategoryArabicTitleController =
      TextEditingController();
  TextEditingController bodyCategoryArabicNumberOfExercisesController =
      TextEditingController();
  // TextEditingController bodyCategoryArabicCaloriesController =
  //     TextEditingController();

//---------------------------------------------------------------------------------------------------

  getBodyCategoryEnglishLables({bool hasFileDownloadField=false}) {
    return [
      StringManager.bodyCategoryEnglishLableTitle,
      StringManager.bodyCategoryEnglishLableCalories,
      StringManager.bodyCategoryEnglishLableNumberOfExercises,
      StringManager.bodyCategoryLableImageLink,
      StringManager.bodyCategoryLableDownloadFilesLink,
    ];
  }

  getBodyCategoryArabicLables({bool hasFileDownloadField=false}) {
    return [
      StringManager.bodyCategoryArabicLableTitle,
      StringManager.bodyCategoryArabicLableCalories,
      StringManager.bodyCategoryArabicLableNumberOfExercises,
    ];
  }

  TabBarView getTrainingTabBarView({required WorkOutCubit workOutCubit}) {
    return TabBarView(children: [
      EnglishTrainingTabBarViewBlock(workCubit: workOutCubit),
      ArabicTrainingTabBarViewBlock(
        workCubit: workOutCubit,
      )
    ]);
  }

  TabBarView getBodyCategoryTabBarView({required WorkOutCubit workOutCubit,bool isDailyBodyCategory=false}) {
    return TabBarView(children: [
      EnglishBodyCategoryTabBarViewBlock(workCubit: workOutCubit,isDailyBodyCategory: isDailyBodyCategory),
      ArabicBodyCategoryTabBarViewBlock(
        workCubit: workOutCubit,
        isDailyBodyCategory: isDailyBodyCategory,
      )
    ]);
  }

  getLevelLabels({required context}) {
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

  List<TextEditingController> getEnglishBodyCategoryControllers({bool hasFileDownloadField=false}) {
   return [
      bodyCategoryEnglishTitleController,
      // bodyCategoryEnglishCaloriesController,
      bodyCategoryEnglishNumberOfExercisesController,
      bodyCategoryImageLinkController,
     if(hasFileDownloadField)
     bodyCategoryDownloadFilesLinkController
    ];
  }

  List<TextEditingController> getArabicBodyCategoryControllers() {
   return  [
      bodyCategoryArabicTitleController,
      // bodyCategoryArabicCaloriesController,
      bodyCategoryArabicNumberOfExercisesController,
    ];

  }

  // setTrainingPeriod({required DateTime date}) {
  //   trainingPeriod = date;
  //   emit(SetTrainingPeriod());
  // }

  setTrainingIsPaid({required bool value}) {
    trainingIsPaid = value;
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
    }
    // else if (trainingPeriod.second == 0 &&
    //     trainingPeriod.minute == 0 &&
    //     trainingPeriod.hour == 0) {
    //   getToastMessage(
    //     message: 'the training period is not set',
    //   );
    //   return false;
    // }
    else {
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
   // trainingPeriod = DateTime(0, 0, 0, 0, 0, 0);
    trainingIsPaid = false;
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
    trainingArabicNumberOfRoundsController.text = model.arabic!.numberOfRounds!;
    trainingArabicInstructionController.text = model.arabic!.instructions!;
    trainingPriorityController.text = model.priority.toString();
    trainingVideoLinkController.text = model.videoLink!;
    trainingEndPeriodController.text=model.endPeriod!;
    trainingStartPeriodController.text=model.startPeriod!;
    trainingIsPaid = model.isPaid!;
    emit(SetTrainingControllersState());
  }

  Map<String, dynamic> getTrainingModelMap({required String bodyCategory}) {
    var map=TrainingModel(
        english: TrainingEnglish(
            name: trainingEnglishNameController.text,
            numberOfReputation:
            trainingEnglishNumberOfReputationController.text,
            numberOfRounds: trainingEnglishNumberOfRoundsController.text,
            instructions: trainingEnglishInstructionController.text),
        arabic: TrainingArabic(
            name: trainingArabicNameController.text,
            numberOfReputation:
            trainingArabicNumberOfReputationController.text,
            numberOfRounds: trainingArabicNumberOfRoundsController.text,
            instructions: trainingArabicInstructionController.text),
        level: getBodyCategoryLevelString(currentLevelIndex: currentLevel),
        bodyCategory: bodyCategory,
        videoLink: trainingVideoLinkController.text,
        priority: int.parse(trainingPriorityController.text),
        startPeriod: trainingStartPeriodController.text,
        endPeriod: trainingEndPeriodController.text,
        isPaid: trainingIsPaid,
        docId: '')
        .toJson();
    print(map);
    return  map;
  }

  addNewTraining(
      {required String bodyCategory, bool isDailyCategory = false}) async {
    emit(AddNewTrainingLoadingState());
    CollectionReference data = FirebaseFirestore.instance.collection(
        isDailyCategory
            ? StringManager.collectionDailyBodyCategory
            : StringManager.collectionTrainings);
    await data
        .add(getTrainingModelMap(bodyCategory: bodyCategory))
        .then((value) {
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
//   {
//   StringManager.trainingEnglishName: trainingEnglishNameController.text,
//   StringManager.trainingEnglishNumberOfReputation:
//   trainingEnglishNumberOfReputationController.text,
//   StringManager.trainingEnglishNumberOfRounds:
//   trainingEnglishNumberOfRoundsController.text,
//   StringManager.trainingEnglishInstruction:
//   trainingEnglishInstructionController.text,
//   StringManager.trainingArabicName: trainingArabicNameController.text,
//   StringManager.trainingArabicNumberOfReputation:
//   trainingArabicNumberOfReputationController.text,
//   StringManager.trainingArabicNumberOfRounds:
//   trainingArabicNumberOfRoundsController.text,
//   StringManager.trainingArabicInstruction:
//   trainingArabicInstructionController.text,
//   StringManager.trainingVideoLink: trainingVideoLinkController.text,
//   StringManager.trainingLevel:
//   getBodyCategoryLevelString(currentLevelIndex: currentLevel),
//   StringManager.trainingBodyCategory: bodyCategory,
//   StringManager.trainingPriority:
//   int.parse(trainingPriorityController.text),
//   StringManager.trainingHourPeriod:   trainingPeriod.hour,
//   StringManager.trainingMinutePeriod: trainingPeriod.minute,
//   StringManager.trainingSecondPeriod: trainingPeriod.second,
//   StringManager.trainingIsPaid: trainingIsPaid,
// }

  editTraining(
      {required String docId,
      required String bodyCategory,
      bool isDailyCategory = false}) async {
    emit(EditTrainingLoadingState());
    CollectionReference data = FirebaseFirestore.instance.collection(
        isDailyCategory
            ? StringManager.collectionDailyBodyCategory
            : StringManager.collectionTrainings);
    await data
        .doc(docId)
        .update(getTrainingModelMap(bodyCategory: bodyCategory))
        .then((value) {
      emit(EditTrainingSuccessState());

      getTraining(bodyCategory: bodyCategory, isDailyCategory: isDailyCategory);
    }).catchError((error) {
      emit(EditTrainingErrorState());
      print(error.toString());
    });
    Get.back();
  }

  deleteTraining(
      {required String docId,
      required String bodyCategory,
      required isDailyTraining}) async {
    emit(DeleteTrainingLoadingState());
    CollectionReference data = FirebaseFirestore.instance.collection(
        isDailyTraining
            ? StringManager.collectionDailyBodyCategory
            : StringManager.collectionTrainings);
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
    if (validateAddTraining()||true) {
      addNewTraining(
          bodyCategory: bodyCategory, isDailyCategory: isDailyCategory);
    }
  }

  getTraining(
      {required String bodyCategory, bool isDailyCategory = false}) async {
    trainingModels.clear();
    var data;
    if (isDailyCategory) {
      data = FirebaseFirestore.instance
          .collection(StringManager.collectionDailyBodyCategory);
    } else {
      data = FirebaseFirestore.instance
          .collection(StringManager.collectionTrainings)
          .where(
            StringManager.trainingBodyCategory,
            isEqualTo: bodyCategory,
          );
    }

    emit(GetTrainingLoadingState());
    await data
        .where(StringManager.bodyCategoryLevel,
            isEqualTo:
                getBodyCategoryLevelString(currentLevelIndex: currentLevel))
        .orderBy(StringManager.trainingPriority)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        trainingModels.add(
            TrainingModel.fromJson(json: element.data(), docId: element.id));
      });
      emit(GetTrainingSuccessState());
    }).catchError((error) {
      emit(GetTrainingErrorState());
      print(error);
    });
  }

  Future<TrainingModel> getTrainingUsingDocId(
      {required String trainingDocId}) async {
    TrainingModel specificTraining;
    emit(GetTrainingUsingDocIdLoadingState());
    return await FirebaseFirestore.instance
        .collection(StringManager.collectionTrainings)
        .doc(trainingDocId)
        .get()
        .then((value) {
      emit(GetTrainingUsingDocIdSuccessState());
      return specificTraining =
          TrainingModel.fromJson(json: value.data()!, docId: value.id);
    }).catchError((error) {
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
    }
    // else if (bodyCategoryEnglishCaloriesController.text.isEmpty) {
    //   getToastMessage(
    //     message: 'the english calories field is empty',
    //   );
    //   return false;
    // }
    else if (bodyCategoryImageLinkController.text.isEmpty) {
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
    }
    // else if (bodyCategoryArabicCaloriesController.text.isEmpty) {
    //   getToastMessage(
    //     message: 'the arabic calories field is empty',
    //   );
    //   return false;
    // }
    else if (bodyCategoryArabicNumberOfExercisesController.text.isEmpty) {
      getToastMessage(
        message: 'the arabic number of exercises field is empty',
      );
      return false;
    } else if (bodyCategoryTotalTime.second == 0 &&
        bodyCategoryTotalTime.minute == 0 &&
        bodyCategoryTotalTime.hour == 0) {
      getToastMessage(
        message: 'the total time is not set',
      );
      return false;
    } else
      return true;
  }

  clearBodyCategoryAttributes() {
    bodyCategoryEnglishTitleController.clear();
    bodyCategoryEnglishNumberOfExercisesController.clear();
    // bodyCategoryEnglishCaloriesController.clear();
    bodyCategoryImageLinkController.clear();
    bodyCategoryDownloadFilesLinkController.clear();
    bodyCategoryArabicTitleController.clear();
    bodyCategoryArabicNumberOfExercisesController.clear();
    // bodyCategoryArabicCaloriesController.clear();
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
    } else {
      return levels[currentLevelIndex];
    }
  }

  setBodyCategoryAttributes({required BodyCategoryModel model}) {
    bodyCategoryEnglishTitleController.text = model.english!.title!;
    bodyCategoryEnglishNumberOfExercisesController.text =
        model.english!.numberOfExercises!;
 //   bodyCategoryEnglishCaloriesController.text = model.english!.calories!;
    bodyCategoryImageLinkController.text = model.imageLink!;
    if(model.downloadFileLink!=null) {
      bodyCategoryDownloadFilesLinkController.text=model.downloadFileLink!;
    }
    bodyCategoryArabicTitleController.text = model.arabic!.title!;
    bodyCategoryArabicNumberOfExercisesController.text =
        model.arabic!.numberOfExercises!;
  //  bodyCategoryArabicCaloriesController.text = model.arabic!.calories!;
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

  Map<String, dynamic> getBodyCategoryMap({required bool isAddFunction,bool isDailyBodyCategory=false}) {
    return BodyCategoryModel(
            english: BodyCategoryEnglish(
                title: bodyCategoryEnglishTitleController.text,
              //  calories: bodyCategoryEnglishCaloriesController.text,
                numberOfExercises:
                    bodyCategoryEnglishNumberOfExercisesController.text),
            arabic: BodyCategoryArabic(
                title: bodyCategoryArabicTitleController.text,
              //  calories: bodyCategoryArabicCaloriesController.text,
                numberOfExercises:
                    bodyCategoryArabicNumberOfExercisesController.text),
            imageLink: bodyCategoryImageLinkController.text,
            downloadFileLink: bodyCategoryDownloadFilesLinkController.text,
            level: getBodyCategoryLevelString(currentLevelIndex: currentLevel),
            hour: bodyCategoryTotalTime.hour,
            minute: bodyCategoryTotalTime.minute,
            second: bodyCategoryTotalTime.second,
            docId: '')
        .toJson(
            isAddFunction: isAddFunction,
            isDailyBodyCategory: isDailyBodyCategory,
            bodyCategoryLevel:
                getBodyCategoryLevelString(currentLevelIndex: currentLevel));
  }

  addNewBodyCategory() async {
    emit(AddNewBodyCategoryLoadingState());
    CollectionReference data = FirebaseFirestore.instance
        .collection(StringManager.collectionBodyCategory);
    await data.add(getBodyCategoryMap(isAddFunction: true)).then((value) {
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

  // StringManager.bodyCategoryEnglishTitle:
  // bodyCategoryEnglishTitleController.text,
  // StringManager.bodyCategoryEnglishCalories:
  // bodyCategoryEnglishCaloriesController.text,
  // StringManager.bodyCategoryEnglishNumberOfExercises:
  // bodyCategoryEnglishNumberOfExercisesController.text,
  // StringManager.bodyCategoryArabicTitle:
  // bodyCategoryArabicTitleController.text,
  // StringManager.bodyCategoryArabicCalories:
  // bodyCategoryArabicCaloriesController.text,
  // StringManager.bodyCategoryArabicNumberOfExercises:
  // bodyCategoryArabicNumberOfExercisesController.text,
  // StringManager.bodyCategoryImageLink: bodyCategoryImageLinkController.text,
  // StringManager.bodyCategoryLevel:
  // getBodyCategoryLevelString(currentLevelIndex: currentLevel),
  // StringManager.bodyCategoryTotalTimeHour:   bodyCategoryTotalTime.hour,
  // StringManager.bodyCategoryTotalTimeMinute: bodyCategoryTotalTime.minute,
  // StringManager.bodyCategoryTotalTimeSecond: bodyCategoryTotalTime.second,
  editBodyCategory({required String docId, bool isDailyCategory = false}) {
    emit(EditBodyCategoryLoadingState());
    CollectionReference data = FirebaseFirestore.instance.collection(
        isDailyCategory
            ? StringManager.collectionDailyBodyCategory
            : StringManager.collectionBodyCategory);
    data
        .doc(docId)
        .update(getBodyCategoryMap(isAddFunction: false,isDailyBodyCategory: isDailyCategory))
        .then((value) {
      emit(EditBodyCategorySuccessState());
      getToastMessage(
        message: 'the category has been edited',
      );
      if (isDailyCategory) {
        getDailyBodyCategoryCard(hasAccess: true);
      } else {
        getBodyCategories(reload: true);
      }
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
      getBodyCategories(reload: true);
    }
  }

  processOfDeletingBodyCategory(
      {required String docId, required String bodyCategory}) async {
    await getTraining(bodyCategory: bodyCategory);
    trainingModels.forEach((element) async {
      await deleteTraining(
          docId: element.docId!,
          bodyCategory: bodyCategory,
          isDailyTraining: false);
    });
    await deleteBodyCategory(docId: docId);
    await getBodyCategories(reload: true);
  }

  getBodyCategories({bool reload=false}) async {
    if(bodyCategoryModels[currentLevel].isNotEmpty && !reload) {
      return;
    }
    bodyCategoryModels[currentLevel].clear();
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionBodyCategory)
        .where(StringManager.bodyCategoryLevel,
            isEqualTo:
                getBodyCategoryLevelString(currentLevelIndex: currentLevel))
        .orderBy(StringManager.bodyCategoryEnglishTitle);
    emit(GetBodyCategoryLoadingState());
    await data.get().then((value) {
      value.docs.forEach((element) {
        bodyCategoryModels[currentLevel].add(BodyCategoryModel.fromJson(
            json: element.data(), docId: element.id));
      });
      emit(GetBodyCategorySuccessState());
    }).catchError((error) {
      emit(GetBodyCategoryErrorState());
      debugPrint(error.toString());
    });
  }

  getDailyBodyCategoryCard({required bool hasAccess}) async {
    if(hasAccess==false) return;
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionDailyBodyCategory)
        .where(StringManager.dailyBodyCategoryCardInformation, isEqualTo: true);
    emit(GetDailyBodyCategoryLoadingState());
    await data.get().then((value) {
      dailyDodyCategoryModel = BodyCategoryModel.fromJson(
          json: value.docs.first.data(), docId: value.docs.first.id);
      emit(GetDailyBodyCategorySuccessState());
    }).catchError((error) {
      emit(GetDailyBodyCategoryErrorState());
      print(error);
    });
  }
}
