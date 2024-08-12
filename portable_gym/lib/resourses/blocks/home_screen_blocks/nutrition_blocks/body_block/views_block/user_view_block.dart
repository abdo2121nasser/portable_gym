import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../../screens/navigation_bar_screens/home_screen/home_subscreens/nutrition_screens/daily_recipe_screen.dart';
import '../../../../../managers_files/alert_box_manager.dart';
import '../../../../../managers_files/values_manager.dart';
import '../../../../general_blocks/daily_activity_block.dart';
import '../../meals_types_list_block.dart';

class UserViewBlock extends StatelessWidget {
  const UserViewBlock({super.key});

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
        return Expanded(
          child: Column(
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
                            nutCubit: nutCubit,
                          ));
                        },
                        onLongPress: () {
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
                        },
                        child: DailyActivityBlock(
                          title: S.of(context).recipeOfDay,
                          isDailyTraining: false,
                          dailyRecipeCardModel: nutCubit.dailyRecipeCardModel,
                        ),
                      ),
                    ),
              MealsTypesListBlock(
                lables: nutCubit.getMealTypeLables(context: context),
              ),
            ],
          ),
        );
      },
    );
  }
}
