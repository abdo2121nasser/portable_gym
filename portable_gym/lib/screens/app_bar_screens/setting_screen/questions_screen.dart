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
import '../../../resourses/managers_files/string_manager.dart';
import '../../../resourses/managers_files/style_manager.dart';

class QuestionScreen extends StatelessWidget {
  final SettingCubit settCubit;
  final String collection;

  const QuestionScreen(
      {super.key, required this.settCubit, required this.collection});

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
      value: settCubit
        ..getAllQuestions(
            collection: collection),
      child: BlocConsumer<SettingCubit, SettingState>(
        listener: (context, state) {},
        builder: (context, state) {
          var settCubit = SettingCubit.get(context);
          return Scaffold(
            appBar: GeneralAppBarBlock(
              title: S.of(context).questions,
            ),
            body: Column(
              children: [
                isLoadingState(state)
                    ? const Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            color: ColorManager.kPurpleColor,
                          ),
                        ),
                      )
                    : ListOfQuestionsWithChoicesBlock(
                        model: settCubit.questionModels,
                        collection: collection,
                        addChoiceFunction: (model) {
                          settCubit.clearControllers();
                          showAlertQuestionBox(
                              context: context,
                              tabBar: questionsTabBar,
                              tabBarView: settCubit.getQuestionsTabBarViews(
                                  isQuestion: false),
                              firstButtonFunction: () {
                                settCubit.addAnswer(
                                    model: model,
                                    collection: collection);
                              },
                              title: S.of(context).questions,
                              firstButtonLable: S.of(context).add,
                              isSingleButton: true);
                        },
                        isClientView: false,
                      ),
                GeneralButtonBlock(
                    lable: S.of(context).add,
                    function: () {
                      settCubit.clearControllers();
                      showAlertQuestionBox(
                          context: context,
                          tabBar: questionsTabBar,
                          tabBarView: settCubit.getQuestionsTabBarViews(
                              isQuestion: true),
                          firstButtonFunction: () {
                            settCubit.addQuestion(
                                collection: collection);
                          },
                          title: S.of(context).questions,
                          firstButtonLable: S.of(context).add,
                          isSingleButton: true);
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

  bool isLoadingState(SettingState state) {
    return state is AddQuestionLoadingState ||
        state is EditQuestionLoadingState ||
        state is DeleteQuestionLoadingState ||
        state is AddAnswerLoadingState ||
        state is EditAnswerLoadingState ||
        state is DeleteAnswerLoadingState ||
        state is GetQuestionsLoadingState;
  }
}
