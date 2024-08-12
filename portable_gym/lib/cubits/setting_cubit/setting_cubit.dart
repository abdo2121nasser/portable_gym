import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:portable_gym/screens/app_bar_screens/setting_screen/meal_plan_questions_screen.dart';
import 'package:portable_gym/screens/authentication_screens/forget_password_screen.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/profile_blocks/settings_blocks/setting_tab_bar_views/arabic_question_tab_bar_view.dart';
import '../../resourses/blocks/profile_blocks/settings_blocks/setting_tab_bar_views/english_question_tab_bar_view.dart';
import '../../resourses/managers_files/string_manager.dart';
import '../../resourses/models/setting_models/meal_plan_question_model.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());
  static SettingCubit get(context) => BlocProvider.of(context);

  List<MealPlanQuestionModel> questionsModel = [];

  TextEditingController englishTitle = TextEditingController();
  TextEditingController englishQuestion = TextEditingController();
  TextEditingController arabicTitle = TextEditingController();
  TextEditingController arabicQuestion = TextEditingController();
  TextEditingController englishAnswer = TextEditingController();
  TextEditingController arabicAnswer = TextEditingController();

 Future<String> getUserDocId() async {
    // emit(GetUserDocIdLoadingState());
   return await const FlutterSecureStorage()
        .read(key: StringManager.userDocId)
        .then((value) {
     return value!;
      // emit(GetUserDocIdSuccessState());
    }).catchError((error) {
      // emit(GetUserDocIdErrorState());
      debugPrint(error);
    });
  }

  getSettingOptionsLables({
    required context,
  }) {
    return [
      S.of(context).changeMealPlanQuestions,
      S.of(context).resetPassword,
    ];
  }

  getSettingOptionsIcons() {
    return [
      Icons.person,
      Icons.lock_reset_outlined,
    ];
  }

  TabBarView getQuestionsTabBarViews({required bool isQuestion}) {
    return TabBarView(children: [
      EnglishQuestionTabBarView(
        lables: isQuestion
            ? const [
                StringManager.englishQuestionTitleLable,
                StringManager.englishQuestionsQuestionLable,
              ]
            : [
                StringManager.englishQuestionsAnswerLable,
              ],
        controllers:
            isQuestion ? [englishTitle, englishQuestion] : [englishAnswer],
      ),
      ArabicQuestionTabBarView(
        lables: isQuestion
            ? const [
                StringManager.arabicQuestionTitleLable,
                StringManager.arabicQuestionsQuestionLable,
              ]
            : [
                StringManager.arabicQuestionsAnswerLable,
              ],
        controllers:
            isQuestion ? [arabicTitle, arabicQuestion] : [arabicAnswer],
      )
    ]);
  }

  settingNavigation({
    required int index,
    required context
  }) {
    switch (index) {
      case 0:
        //there was a context here to pass the setting cubit
        Get.to(MealPlanQuestionScreen(
          settCubit: SettingCubit.get(context),
        ));
        break;
      case 1:
        Get.to(const ForgetPasswordScreen());
        break;
    }
  }

  changeAnswerValue({required questionIndex, required int answerIndex, required bool value}) {
    for (int i = 0;
        i < questionsModel[questionIndex].english.answers.length;
        i++) {
      questionsModel[questionIndex].english.answers[i].value = false;
      questionsModel[questionIndex].arabic.answers[i].value = false;
    }
    questionsModel[questionIndex].english.answers[answerIndex].value = value;
    questionsModel[questionIndex].arabic.answers[answerIndex].value = value;
    emit(ChangeAnswerValueState());
  }

  MealPlanQuestionModel? getQuestionModelQuestionFromControllers(
      {MealPlanQuestionModel? model,
      bool isAddAnswer = false,
      bool isEditAnswer = false,
      bool isEditQuestion = false,
      int answerIndex = 0}) {
    if (model == null) {
      //add question
      return MealPlanQuestionModel(
          english: EnglishQuestion(
              title: englishTitle.text,
              question: englishQuestion.text,
              answers: []),
          arabic: ArabicQuestion(
              title: arabicTitle.text,
              question: arabicQuestion.text,
              answers: []),
          docId: '');
    }
    if (isAddAnswer) {
      // add answer
      return model
        ..english.answers.add(Answer(text: englishAnswer.text, value: false))
        ..arabic.answers.add(Answer(text: englishAnswer.text, value: false));
    }
    if (isEditQuestion) {
      //edit question
      model.english.title = englishTitle.text;
      model.english.question = englishQuestion.text;
      model.arabic.title = arabicTitle.text;
      model.arabic.question = arabicQuestion.text;
      return model;
    }
    if (isEditAnswer) {
      model.english.answers[answerIndex].text = englishAnswer.text;
      model.arabic.answers[answerIndex].text = arabicAnswer.text;
      return model;
    }
  }

  setControllersWithModel({required MealPlanQuestionModel model, int? index}) {
    if (index == null) {
      englishTitle.text = model.english.title;
      englishQuestion.text = model.english.question;
      arabicTitle.text = model.arabic.title;
      arabicQuestion.text = model.arabic.question;
    } else {
      englishAnswer.text = model.english.answers[index].text;
      arabicAnswer.text = model.arabic.answers[index].text;
    }
    emit(SetControllersWithModelState());
  }

  clearControllers() {
    englishTitle.clear();
    englishQuestion.clear();
    arabicTitle.clear();
    arabicQuestion.clear();
    englishAnswer.clear();
    arabicAnswer.clear();
  }

  addQuestion() async {
    MealPlanQuestionModel model = getQuestionModelQuestionFromControllers()!;
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionQuestionsOfMealPlan);
    emit(AddQuestionLoadingState());
    Get.back();
    await data.add(model.toJson()).then((value) {
      emit(AddQuestionSuccessState());
      getAllQuestions();
    }).catchError((error) {
      emit(AddQuestionErrorState());
      debugPrint(error);
    });
  }

  editQuestion({required MealPlanQuestionModel model}) async {
    model = getQuestionModelQuestionFromControllers(
        model: model, isEditQuestion: true)!;
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionQuestionsOfMealPlan)
        .doc(model.docId);
    emit(EditQuestionLoadingState());
    Get.back();
    await data.update(model.toJson()).then((value) {
      emit(EditQuestionSuccessState());
      getAllQuestions();
    }).catchError((error) {
      emit(EditQuestionErrorState());
      debugPrint(error);
    });
  }

  deleteQuestion({required MealPlanQuestionModel model}) async {
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionQuestionsOfMealPlan)
        .doc(model.docId);
    emit(DeleteQuestionLoadingState());
    Get.back();
    await data.delete().then((value) {
      emit(DeleteQuestionSuccessState());
      getAllQuestions();
    }).catchError((error) {
      emit(DeleteQuestionErrorState());
      debugPrint(error);
    });
  }

  getAllQuestions() async {
    questionsModel.clear();
    emit(GetQuestionsLoadingState());
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionQuestionsOfMealPlan);
    await data.get().then((value) {
      value.docs.forEach((element) {
        questionsModel.add(MealPlanQuestionModel.fromJson(
            json: element.data(), docId: element.id));
      });
      emit(GetQuestionsSuccessState());
    }).catchError((error) {
      emit(GetQuestionsErrorState());
      debugPrint(error);
    });
  }

  addAnswer({required MealPlanQuestionModel model}) async {
    model = getQuestionModelQuestionFromControllers(
        model: model, isAddAnswer: true)!;
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionQuestionsOfMealPlan)
        .doc(model.docId);
    emit(AddAnswerLoadingState());
    Get.back();
    await data.update(model.toJson()).then((value) {
      emit(AddAnswerSuccessState());
      getAllQuestions();
    }).catchError((error) {
      emit(AddAnswerErrorState());
      debugPrint(error);
    });
  }

  editAnswer({required MealPlanQuestionModel model, required int index}) async {
    model = getQuestionModelQuestionFromControllers(
        model: model, answerIndex: index, isEditAnswer: true)!;
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionQuestionsOfMealPlan)
        .doc(model.docId);
    emit(EditAnswerLoadingState());
    Get.back();
    await data.update(model.toJson()).then((value) {
      emit(EditAnswerSuccessState());
      getAllQuestions();
    }).catchError((error) {
      emit(EditAnswerErrorState());
      debugPrint(error);
    });
  }

  deleteAnswer({required MealPlanQuestionModel model, required int index}) async {
    model.english.answers.removeAt(index);
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionQuestionsOfMealPlan)
        .doc(model.docId);
    emit(DeleteAnswerLoadingState());
    Get.back();
    await data.update(model.toJson()).then((value) {
      emit(DeleteAnswerSuccessState());
      getAllQuestions();
    }).catchError((error) {
      emit(DeleteAnswerErrorState());
      debugPrint(error);
    });
  }
  //-------------------------------trainer side---------------------------------

  Map<String,dynamic> getMealPlanRequestMap({required String userDocId,required String nickName}){
    List<Map<String,dynamic>> questions=[];
    questionsModel.forEach((element) {
      questions.add(element.toJson());
    });
  Map<String,dynamic> map;
  map={
    StringManager.mealPlanData: questions,
    StringManager.userDocId:userDocId,
    StringManager.userNickName:nickName
  };
  return map;

  }

  createMealPlan({required String nickName}) async {
    String userDocId=await getUserDocId();
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionMealPlansRequests);
    emit(CreateMealPlanLoadingState());
    await data.add(
        getMealPlanRequestMap(userDocId: userDocId,nickName: nickName)
    ).then((value) {
      emit(CreateMealPlanSuccessState());
    }).catchError((error) {
      emit(CreateMealPlanErrorState());
      debugPrint(error);
    });
    Get.back();
  }




}
