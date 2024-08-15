import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/profile_cubit/profile_cubit.dart';
import 'package:portable_gym/cubits/setting_cubit/setting_cubit.dart';
import 'package:portable_gym/cubits/setting_cubit/setting_cubit.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../resourses/blocks/general_blocks/general_app_bar_block.dart';
import '../../../../../resourses/blocks/general_blocks/general_button_block.dart';
import '../../../../../resourses/blocks/home_screen_blocks/nutrition_blocks/list_questions_with_choices_block.dart';
import '../../../../../resourses/managers_files/color_manager.dart';
import '../../../../../resourses/managers_files/font_manager.dart';
import '../../../../../resourses/managers_files/style_manager.dart';

class MealPlanCreationScreen extends StatelessWidget {
  final String userNickName;
  const MealPlanCreationScreen({super.key,required this.userNickName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingCubit()..getAllQuestions(),
  child: BlocConsumer<SettingCubit, SettingState>(
      listener: (context, state) {},
      builder: (context, state) {
        var settCubit = SettingCubit.get(context);
        return Scaffold(
          appBar: GeneralAppBarBlock(
            title: S.of(context).mealPlan,
          ),
          body: Column(
            children: [
              ListOfQuestionsWithChoicesBlock(
                model: settCubit.questionsModel,
                isClientView: true,
              ),
              GeneralButtonBlock(
                  lable: S.of(context).create,
                  function: () {
                    settCubit.createMealPlanRequestProcess(nickName: userNickName,context: context);
                  },
                  backgroundColor: ColorManager.kPurpleColor,
                  textStyle: getMediumStyle(
                      fontSize: FontSize.s20,
                      color: ColorManager.kWhiteColor,
                      fontFamily: FontFamily.kPoppinsFont))
            ],
          ),
        );
      },
    ),
);
  }
}
