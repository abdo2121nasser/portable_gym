import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:portable_gym/screens/app_bar_screens/setting_screen/meal_plan_questions_screen.dart';
import 'package:portable_gym/screens/authentication_screens/forget_password.dart';

import '../../generated/l10n.dart';
import '../../resourses/models/setting_models/meal_plan_question_model.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(SettingInitial());
  static SettingCubit get(context) => BlocProvider.of(context);

  List<MealPlanQuestionModel> questionsModel = [];

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

  settingNavigation({required int index}) {
    switch (index) {
      case 0:
        Get.to(const MealPlanQuestionScreen());
        break;
      case 1:
        Get.to(const ForgetPasswordScreen());
        break;
    }
  }



}
