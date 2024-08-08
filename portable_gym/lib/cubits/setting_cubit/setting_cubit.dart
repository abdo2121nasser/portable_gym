import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:portable_gym/screens/app_bar_screens/setting_screen/meal_plan_questions_screen.dart';
import 'package:portable_gym/screens/authentication_screens/forget_password.dart';

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

  settingNavigation({required int index, required context}) {
    switch (index) {
      case 0:
        Get.to(MealPlanQuestionScreen(
          settCubit: SettingCubit.get(context),
        ));
        break;
      case 1:
        Get.to(const ForgetPasswordScreen());
        break;
    }
  }

  MealPlanQuestionModel getQuestionModelQuestionFromControllers({MealPlanQuestionModel? model,bool isAddAnswer=true}) {
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
    } else if (isAddAnswer) {
      // add answer
      return MealPlanQuestionModel(
          english: EnglishQuestion(
              title: model.english.title,
              question: model.english.question,
              answers: model.english.answers
                ..add(Answer(text: englishAnswer.text, value: false))),
          arabic: ArabicQuestion(
              title: arabicTitle.text,
              question: arabicQuestion.text,
              answers: model.arabic.answers
                ..add(Answer(text: arabicAnswer.text, value: false))),
          docId: model.docId);
    } else {
      //edit question
      return MealPlanQuestionModel(
          english: EnglishQuestion(
              title: englishTitle.text,
              question: englishQuestion.text,
              answers: model.english.answers),
          arabic: ArabicQuestion(
              title: arabicTitle.text,
              question: arabicQuestion.text,
              answers: model.arabic.answers),
          docId: model.docId);
    }
  }

  setControllersWithModel({MealPlanQuestionModel? model, Answer? answer}) {
    if (model != null) {
      englishTitle.text = model.english.title;
      englishQuestion.text = model.english.question;
      arabicTitle.text = model.arabic.title;
      arabicQuestion.text = model.arabic.question;
    } else {
      englishAnswer.text = answer!.text;
      arabicAnswer.text = answer.text;
    }
    emit(SetControllersWithModelState());
  }

  addQuestion() async {
    MealPlanQuestionModel model = getQuestionModelQuestionFromControllers();
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
    model = getQuestionModelQuestionFromControllers(model: model,isAddAnswer: false);
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
    model = getQuestionModelQuestionFromControllers(model: model,isAddAnswer: false);
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
}
