import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/profile_cubit/profile_cubit.dart';
import 'package:portable_gym/cubits/setting_cubit/setting_cubit.dart';
import 'package:portable_gym/cubits/setting_cubit/setting_cubit.dart';
import 'package:portable_gym/resourses/models/profile_models/profile_model.dart';

import '../../../../../cubits/set_up_cubit/set_up_cubit.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../resourses/blocks/general_blocks/general_app_bar_block.dart';
import '../../../../../resourses/blocks/general_blocks/general_button_block.dart';
import '../../../../../resourses/blocks/home_screen_blocks/nutrition_blocks/list_questions_with_choices_block.dart';
import '../../../../../resourses/managers_files/color_manager.dart';
import '../../../../../resourses/managers_files/font_manager.dart';
import '../../../../../resourses/managers_files/string_manager.dart';
import '../../../../../resourses/managers_files/style_manager.dart';
import '../../../../../resourses/managers_files/toast_massage_manager.dart';
import '../../../../../resourses/models/nutrition_models/meal_plan_requests_model.dart';
import '../../../../../resourses/models/setting_models/question_model.dart';

class AnswerQuestionsScreen extends StatelessWidget {
  final String userNickName;
  final String collection;
  final ProfileModel? profileModel;
  final Function(Map<String, dynamic>)? finishProfileSetupFunction;
  const AnswerQuestionsScreen(
      {super.key,
      required this.userNickName,
      required this.collection,
        this.profileModel,
      this.finishProfileSetupFunction});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>getCubit(collection: collection),
      child: BlocConsumer<SettingCubit, SettingState>(
        listener: (context, state) {},
        builder: (context, state) {
          var settCubit = SettingCubit.get(context);
          return Scaffold(
            appBar: GeneralAppBarBlock(
              title: collection == StringManager.collectionQuestionsOfMealPlan
                  ? S.of(context).mealPlan
                  : S.of(context).questions,
            ),
            body: Column(
              children: [
                ListOfQuestionsWithChoicesBlock(
                  model: settCubit.questionModels,
                  collection: collection,
                  isClientView: true,
                ),
                state is CreateProfileLoadingState
                    ? const CircularProgressIndicator(
                        color: ColorManager.kPurpleColor,
                      )
                    : GeneralButtonBlock(
                        lable: S.of(context).create,
                        function: () async {
                          if (collection ==
                              StringManager.collectionQuestionsOfMealPlan) {
                            settCubit.createMealPlanRequestProcess(
                                nickName: userNickName, context: context);
                          } else if (StringManager
                                  .collectionQuestionsOfProfile ==
                              collection) {
                            if (settCubit.validateRequests()) {
                              await finishProfileSetupFunction!(
                                  getQuestionsAnswerMap(
                                      questions: settCubit.questionModels));
                              //update profile
                            } else {
                              getToastMessage(
                                  message: S
                                      .of(context)
                                      .mealPlanRequestsErrorMassage);
                            }
                          }
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

  getQuestionsAnswerMap({required List<QuestionModel> questions}) {
    return {
      StringManager.questionsWithAnswer:
          List<dynamic>.from(questions.map((x) => x.toJson()))
    };
  }
 SettingCubit getCubit({required String collection}){
    if(collection==StringManager.collectionUserProfiles) {
      return SettingCubit()..setQuestionsWithAnswers(models: profileModel!.questionModels);
    } else{
   return   SettingCubit()..getAllQuestions(collection: collection);
    }
  }
}
