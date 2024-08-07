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

  TextEditingController englishTitle=TextEditingController();
  TextEditingController englishQuestion=TextEditingController();
  TextEditingController arabicTitle=TextEditingController();
  TextEditingController arabicQuestion=TextEditingController();



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
  getQuestionsTabBarViews(){
    return TabBarView(children:
      [
      EnglishQuestionTabBarView(lables: const [
        StringManager.englishQuestionTitle,
        StringManager.englishQuestionsQuestion,
      ],
      controllers: [englishTitle,englishQuestion],
      ),
      ArabicQuestionTabBarView(lables: const [
        StringManager.arabicQuestionTitle,
        StringManager.arabicQuestionsQuestion,
      ],
        controllers: [arabicTitle,arabicQuestion],
      )
    ]);
  }

  settingNavigation({required int index,required context}) {
    switch (index) {
      case 0:
        Get.to( MealPlanQuestionScreen(settCubit: SettingCubit.get(context),));
        break;
      case 1:
        Get.to(const ForgetPasswordScreen());
        break;
    }
  }

  setQuestionModelAttributes({required MealPlanQuestionModel model}){
  }

   addQuestion() async {
     // var data = FirebaseFirestore.instance
     //     .collection(StringManager.collectionQuestionsOfMealPlan);
     //  await  data.add()
     //     .then((value) {
     //
     // }).catchError((error){
     //
     // });
   }


}
