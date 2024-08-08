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

  getQuestionsTabBarViews() {
    return TabBarView(children: [
      EnglishQuestionTabBarView(
        lables: const [
          StringManager.englishQuestionTitleLable,
          StringManager.englishQuestionsQuestionLable,
        ],
        controllers: [englishTitle, englishQuestion],
      ),
      ArabicQuestionTabBarView(
        lables: const [
          StringManager.arabicQuestionTitleLable,
          StringManager.arabicQuestionsQuestionLable,
        ],
        controllers: [arabicTitle, arabicQuestion],
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

  MealPlanQuestionModel getQuestionModelQuestionFromControllers() {
    return MealPlanQuestionModel(
        english: EnglishQuestion(
          title: englishTitle.text,
          question: englishQuestion.text,
          answers: []
        ),
        arabic: ArabicQuestion(
          title: arabicTitle.text,
          question: arabicQuestion.text,
          answers: []
        ));
  }

  addQuestion() async {
    MealPlanQuestionModel model=getQuestionModelQuestionFromControllers();
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionQuestionsOfMealPlan);
    emit(AddQuestionLoadingState());
     await  data.add(model.toJson())
        .then((value) {
       emit(AddQuestionSuccessState());
       getAllQuestions();
    }).catchError((error){
       emit(AddQuestionErrorState());
       debugPrint(error);
    });
     Get.back();
  }
  getAllQuestions() async {
    questionsModel.clear();
    emit(GetQuestionsLoadingState());
    var data = FirebaseFirestore.instance
        .collection(StringManager.collectionQuestionsOfMealPlan);
    await  data.get()
        .then((value) {
          value.docs.forEach((element) {
            questionsModel.add(MealPlanQuestionModel.fromJson(json: element.data()));
          });
      emit(GetQuestionsSuccessState());
    }).catchError((error){
      emit(GetQuestionsErrorState());
      debugPrint(error);
    });
  }
}
