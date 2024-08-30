import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:portable_gym/app_root/app_root.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/cubits/profile_cubit/profile_cubit.dart';
import 'package:portable_gym/resourses/managers_files/toast_massage_manager.dart';
import 'package:portable_gym/resourses/models/nutrition_models/meal_plan_requests_model.dart';
import 'package:portable_gym/screens/app_bar_screens/setting_screen/questions_screen.dart';
import 'package:portable_gym/screens/authentication_screens/forget_password_screen.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/profile_blocks/settings_blocks/setting_tab_bar_views/arabic_question_tab_bar_view.dart';
import '../../resourses/blocks/profile_blocks/settings_blocks/setting_tab_bar_views/english_question_tab_bar_view.dart';
import '../../resourses/managers_files/string_manager.dart';
import '../../resourses/models/setting_models/question_model.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());
  static SettingCubit get(context) => BlocProvider.of(context);
 bool isLoadingButton=false;
  List<QuestionModel> questionModels = [];

  TextEditingController englishTitle = TextEditingController();
  TextEditingController englishQuestion = TextEditingController();
  TextEditingController arabicTitle = TextEditingController();
  TextEditingController arabicQuestion = TextEditingController();
  TextEditingController englishAnswer = TextEditingController();
  TextEditingController arabicAnswer = TextEditingController();

  Future<String> getUserDocId() async {
    return await const FlutterSecureStorage()
        .read(key: StringManager.userDocId)
        .then((value) {
      return value!;
    }).catchError((error) {
      debugPrint(error);
    });
  }

  changeLoadingButton(){
    isLoadingButton=!isLoadingButton;
    emit(ChangeLoadingButtonState());
  }


  getSettingOptionsLables({
    required context,
  }) {
    return [
      if (ProfileCubit.get(context).profileModel!.isClient == false)
        S.of(context).changeMealPlanQuestions,
      if (ProfileCubit.get(context).profileModel!.isClient == false)
        S.of(context).changeSetUpQuestions,
      S.of(context).resetPassword,
    ];
  }

  getSettingOptionsIcons({required context}) {
    return [
      if (ProfileCubit.get(context).profileModel!.isClient == false)
        Icons.question_mark_outlined,
      if (ProfileCubit.get(context).profileModel!.isClient == false)
        Icons.person_pin,
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

  settingNavigation({required int index, required context}) {
    if (ProfileCubit.get(context).profileModel!.isClient) {
      index += 2;
    }
    switch (index) {
      case 0:
        Get.to(QuestionScreen(
          settCubit: SettingCubit.get(context),
          collection: StringManager.collectionQuestionsOfMealPlan,
        ));
        break;
      case 1:
        Get.to(QuestionScreen(
          settCubit: SettingCubit.get(context),
          collection: StringManager.collectionQuestionsOfProfile,
        ));
        break;
      case 2:
        Get.to(const ForgetPasswordScreen());
        break;
    }
  }

  changeAnswerValue(
      {required questionIndex, required int answerIndex, required bool value}) {
    for (int i = 0;
        i < questionModels[questionIndex].english.answers.length;
        i++) {
      questionModels[questionIndex].english.answers[i].value = false;
      questionModels[questionIndex].arabic.answers[i].value = false;
    }
    questionModels[questionIndex].english.answers[answerIndex].value = value;
    questionModels[questionIndex].arabic.answers[answerIndex].value = value;
    emit(ChangeAnswerValueState());
  }

  QuestionModel? getQuestionModelQuestionFromControllers(
      {QuestionModel? model,
      bool isAddAnswer = false,
      bool isEditAnswer = false,
      bool isEditQuestion = false,
      int answerIndex = 0}) {
    if (model == null) {
      //add question
      return QuestionModel(
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
        ..arabic.answers.add(Answer(text: arabicAnswer.text, value: false));
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

  setControllersWithModel({required QuestionModel model, int? index}) {
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

  addQuestion({required String collection}) async {
    QuestionModel model = getQuestionModelQuestionFromControllers()!;
    var data = FirebaseFirestore.instance.collection(collection);
    emit(AddQuestionLoadingState());
    Get.back();
    await data.add(model.toJson()).then((value) {
      emit(AddQuestionSuccessState());
      getAllQuestions(collection: collection);
    }).catchError((error) {
      emit(AddQuestionErrorState());
      debugPrint(error);
    });
  }

  editQuestion(
      {required QuestionModel model, required String collection}) async {
    model = getQuestionModelQuestionFromControllers(
        model: model, isEditQuestion: true)!;
    var data =
        FirebaseFirestore.instance.collection(collection).doc(model.docId);
    emit(EditQuestionLoadingState());
    Get.back();
    await data.update(model.toJson()).then((value) {
      emit(EditQuestionSuccessState());
      getAllQuestions(collection: collection);
    }).catchError((error) {
      emit(EditQuestionErrorState());
      debugPrint(error);
    });
  }

  deleteQuestion(
      {required QuestionModel model, required String collection}) async {
    var data =
        FirebaseFirestore.instance.collection(collection).doc(model.docId);
    emit(DeleteQuestionLoadingState());
    Get.back();
    await data.delete().then((value) {
      emit(DeleteQuestionSuccessState());
      getAllQuestions(collection: collection);
    }).catchError((error) {
      emit(DeleteQuestionErrorState());
      debugPrint(error);
    });
  }

  getAllQuestions({required String collection}) async {
    questionModels.clear();
    emit(GetQuestionsLoadingState());
    var data = FirebaseFirestore.instance.collection(collection);
    await data.get().then((value) {
      value.docs.forEach((element) {
        questionModels.add(
            QuestionModel.fromJson(json: element.data(), docId: element.id));
      });
      emit(GetQuestionsSuccessState());
    }).catchError((error) {
      emit(GetQuestionsErrorState());
      debugPrint(error);
    });
  }

  addAnswer({required QuestionModel model, required String collection}) async {
    model = getQuestionModelQuestionFromControllers(
        model: model, isAddAnswer: true)!;
    var data =
        FirebaseFirestore.instance.collection(collection).doc(model.docId);
    emit(AddAnswerLoadingState());
    Get.back();
    await data.update(model.toJson()).then((value) {
      emit(AddAnswerSuccessState());
      getAllQuestions(collection: collection);
    }).catchError((error) {
      emit(AddAnswerErrorState());
      debugPrint(error);
    });
  }

  editAnswer(
      {required QuestionModel model,
      required int index,
      required String collection}) async {
    model = getQuestionModelQuestionFromControllers(
        model: model, answerIndex: index, isEditAnswer: true)!;
    var data =
        FirebaseFirestore.instance.collection(collection).doc(model.docId);
    emit(EditAnswerLoadingState());
    Get.back();
    await data.update(model.toJson()).then((value) {
      emit(EditAnswerSuccessState());
      getAllQuestions(collection: collection);
    }).catchError((error) {
      emit(EditAnswerErrorState());
      debugPrint(error);
    });
  }

  deleteAnswer(
      {required QuestionModel model,
      required int index,
      required String collection}) async {
    model.english.answers.removeAt(index);
    var data =
        FirebaseFirestore.instance.collection(collection).doc(model.docId);
    emit(DeleteAnswerLoadingState());
    Get.back();
    await data.update(model.toJson()).then((value) {
      emit(DeleteAnswerSuccessState());
      getAllQuestions(collection: collection);
    }).catchError((error) {
      emit(DeleteAnswerErrorState());
      debugPrint(error);
    });
  }
  //-------------------------------trainer side---------------------------------

  bool validateRequests() {
    bool valid = false;
    for (int i = 0; i < questionModels.length; i++) {
      questionModels[i].english.answers.forEach((element) {
        if (element.value == true) {
          valid = true;
          return;
        }
      });
      if (valid == true) {
        valid = false;
      } else {
        return false;
      }
    }
    return true;
  }

  Map<String, dynamic> getMealPlanRequestMap(
      {required String userDocId, required String nickName}) {
    return MealPlanRequestModel(
            questions: questionModels,
            userDocId: userDocId,
            docId: userDocId,
            requestDate: DateTime.now(),
            userNickName: nickName)
        .toJson();
  }

  createMealPlanRequest({required String nickName, required context}) async {
    String userDocId = await getUserDocId();
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionMealPlansRequests);
    emit(CreateMealPlanRequestLoadingState());
    await data
        .add(getMealPlanRequestMap(userDocId: userDocId, nickName: nickName))
        .then((value) {
      emit(CreateMealPlanRequestSuccessState());
      getToastMessage(message: S.of(context).success);
    }).catchError((error) {
      emit(CreateMealPlanRequestErrorState());
      debugPrint(error);
    });
    Get.back();
    Get.back();
  }

  createMealPlanRequestProcess({required String nickName, required context}) {
    if (validateRequests()) {
      createMealPlanRequest(nickName: nickName, context: context);
    } else {
      getToastMessage(message: S.of(context).mealPlanRequestsErrorMassage);
    }
  }
//-----------------------profile settings-----------------------------------
  setQuestionsWithAnswers({required List<QuestionModel> models}) async {
    questionModels.clear();
    questionModels = models;
    emit(SetQuestionsAnswersState());
  }
}
