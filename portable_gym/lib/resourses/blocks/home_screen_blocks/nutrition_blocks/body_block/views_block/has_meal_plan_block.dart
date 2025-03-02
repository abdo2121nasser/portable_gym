import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:my_coach/cubits/profile_cubit/profile_cubit.dart';
import 'package:my_coach/resourses/managers_files/color_manager.dart';

import '../../../../../../cubits/nutrition_cubit/nutrition_cubit.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../screens/navigation_bar_screens/home_screen/home_subscreens/nutrition_screens/daily_recipe_screen.dart';
import '../../../../../managers_files/alert_box_manager.dart';
import '../../../../../managers_files/values_manager.dart';
import '../../../../general_blocks/daily_activity_block.dart';
import '../../meals_types_list_block.dart';


class HasMealPlanBlock extends StatelessWidget {
  const HasMealPlanBlock({super.key});

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
    return BlocConsumer<NutritionCubit, NutritionState>(
      listener: (context, state) {},
      builder: (context, state) {
        var nutCubit = NutritionCubit.get(context);
        return
          Expanded(
          child: Column(
            children: [
              state is GetDailyRecipeCardLoadingState ||nutCubit.dailyRecipeCardModel==null
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
              nutCubit.mealPlanModel==null?
              const Expanded(child: Center(child: CircularProgressIndicator(color: ColorManager.kPurpleColor,),)):
              MealsTypesListBlock(
                lables: nutCubit.getMealTypeLables(context: context),
                model: nutCubit.mealPlanModel!,
              ),
            ],
          ),
        );
      },
    );
  }

}
