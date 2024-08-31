import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/nutrition_screens/answers_of_questions_screen.dart';

import '../../../../../../cubits/profile_cubit/profile_cubit.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../screens/navigation_bar_screens/home_screen/home_subscreens/nutrition_screens/daily_recipe_screen.dart';
import '../../../../../managers_files/alert_box_manager.dart';
import '../../../../general_blocks/daily_activity_block.dart';
import '../../../../general_blocks/option_list_block.dart';


class AdminViewBlock extends StatelessWidget {
  const AdminViewBlock({super.key});

  @override
  Widget build(BuildContext context) {
    final TabBar dailyRecipeCategoryTabBar = TabBar(
      tabs: [
        Tab(text: S.of(context).englishWord),
        Tab(text: S.of(context).arabicWord)
      ],
      indicatorColor: Colors.blue,
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
    );
    var nutCubit=NutritionCubit.get(context);
    return BlocProvider.value(
      value: nutCubit..getAllMealPlanRequests(),
      child: BlocConsumer<NutritionCubit, NutritionState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    return Expanded(
        child: state is GetAllMealPlanRequestsLoadingState?
      const Center(child: CircularProgressIndicator(color: ColorManager.kPurpleColor,)):
        Column(
          children: [
            state is GetDailyRecipeCardLoadingState
                ? SizedBox(
              height: AppVerticalSize.s5,
            )
                : Padding(
              padding:
              EdgeInsets.symmetric(vertical: AppVerticalSize.s22),
              child: InkWell(
                onTap: () {
                  nutCubit.changeCurrentMealType(
                      index: 0, isDailyRecipe: true);
                  Get.to(DailyRecipeScreen(
                    profileModel: ProfileCubit.get(context).profileModel!,
                    nutCubit: nutCubit,
                  ));
                },
                onLongPress:(ProfileCubit.get(context).profileModel!.isClient==false)? () {
                  nutCubit.setDailyRecipeCategoryAttributes();
                  showAlertDailyRecipeCategoryBox(
                      context: context,
                      tabBar: dailyRecipeCategoryTabBar,
                      tabBarView:
                      nutCubit.getDailyRecipeCategoryTabBarViews(
                          nutritionCubit: nutCubit),
                      title: S.of(context).recipeOfDay,
                      buttonLable: S.of(context).edit,
                      buttonFunction: () {
                        nutCubit.editDailyRecipeCategory();
                      });
                }:null,
                child: DailyActivityBlock(
                  title: S.of(context).recipeOfDay,
                  isDailyTraining: false,
                  dailyRecipeCardModel: nutCubit.dailyRecipeCardModel,
                ),
              ),
            ),
            SizedBox(height: AppVerticalSize.s10,),
            Expanded(
              child: OptionsListBlock(
                icons: List<IconData>.generate(nutCubit.requestsModels.length, (index) => Icons.person,growable: true),
                lables: List<String>.generate(nutCubit.requestsModels.length, (index) => nutCubit.requestsModels[index].userNickName,growable: true),
                onClickFunction: (index, context) {
                         Get.to(AnswersOfQuestionsScreen(model: nutCubit.requestsModels[index].questions,
                         requestDocId: nutCubit.requestsModels[index].docId,
                         clientDocId: nutCubit.requestsModels[index].userDocId,
                         nutCubit: NutritionCubit.get(context),
                         ));
                },
              ),
            ),
          ],
        ),
      );
  },
),
    );
  }
}
