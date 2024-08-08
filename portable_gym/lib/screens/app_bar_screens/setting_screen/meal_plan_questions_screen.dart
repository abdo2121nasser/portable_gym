import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/setting_cubit/setting_cubit.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/general_app_bar_block.dart';
import 'package:portable_gym/resourses/managers_files/alert_box_manager.dart';

import '../../../generated/l10n.dart';
import '../../../resourses/blocks/general_blocks/general_button_block.dart';
import '../../../resourses/blocks/home_screen_blocks/nutrition_blocks/list_questions_with_choices_block.dart';
import '../../../resourses/managers_files/color_manager.dart';
import '../../../resourses/managers_files/font_manager.dart';
import '../../../resourses/managers_files/style_manager.dart';



class MealPlanQuestionScreen extends StatelessWidget {
  final SettingCubit settCubit;

  const MealPlanQuestionScreen({super.key, required this.settCubit});
  
  @override
  Widget build(BuildContext context) {
    final TabBar questionsTabBar = TabBar(
      tabs: [
        Tab(text: S.of(context).englishWord),
        Tab(text: S.of(context).arabicWord)
      ],
      indicatorColor: Colors.blue,
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
    );

    return BlocProvider.value(
      value:settCubit..getAllQuestions(),
  child: BlocConsumer<SettingCubit, SettingState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    return Scaffold(
appBar: GeneralAppBarBlock(title: S.of(context).questions,),
      body:   Column(
        children: [
          state is GetQuestionsLoadingState? const Expanded(
            child: Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(color: ColorManager.kPurpleColor,),),
          ):
           ListOfQuestionsWithChoicesBlock(
         model: settCubit.questionsModel,
            isClientView: false,
          ),
          GeneralButtonBlock(
              lable: S.of(context).add,
              function: () {
                showAlertQuestionBox(
                    context: context,
                    tabBar: questionsTabBar,
                    tabBarView: settCubit.getQuestionsTabBarViews(),
                    firstButtonFunction: (){
                      settCubit.addQuestion();
                    },
                  secondButtonFunction: (){},
                    title: S.of(context).questions,
                    firstButtonLable: S.of(context).add,
                  secondButtonLable: S.of(context).delete

                );
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
