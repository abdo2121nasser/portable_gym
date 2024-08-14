import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/floating_action_button_block.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/general_app_bar_block.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/work_out_block/horizontal_category_list_block.dart';
import 'package:portable_gym/resourses/managers_files/alert_box_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/nutrition_screens/food_main_element_screen.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../resourses/blocks/home_screen_blocks/nutrition_blocks/meals_types_list_block.dart';
import '../../../../../resourses/blocks/general_blocks/daily_activity_block.dart';
import '../../../../../resourses/blocks/home_screen_blocks/nutrition_blocks/recipe_grid_square_block.dart';
import '../../../../../resourses/managers_files/color_manager.dart';
import '../../../../../resourses/managers_files/font_manager.dart';
import '../../../../../resourses/managers_files/style_manager.dart';
import '../../../../../resourses/models/nutrition_models/recipe_model.dart';

class DailyRecipeScreen extends StatelessWidget {
  NutritionCubit nutCubit;
   DailyRecipeScreen({super.key,required this.nutCubit});

  @override
  Widget build(BuildContext context) {
    final TabBar dailyRecipeTabBar = TabBar(
      tabs: [
        Tab(text: S.of(context).englishWord),
        Tab(text: S.of(context).arabicWord)
      ],
      indicatorColor: Colors.blue,
      labelColor: Colors.blue,
      unselectedLabelColor: Colors.grey,
    );
    return BlocProvider.value(
      value: nutCubit,
      child: BlocConsumer<NutritionCubit, NutritionState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorManager.kBlackColor,
            appBar: GeneralAppBarBlock(title:S.of(context).recipeOfDay,
              titleFunction: (){
              nutCubit.changeCurrentMealType(index: 0,);
              Get.back();
              },

            ),
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: AppVerticalSize.s14),
                  child: HorizontalCategoryListBlock(
                      currentLevel: nutCubit.currentMealType,
                      numberOfLevels:
                      nutCubit.getMealTypeLables(context: context).length,
                      lables: nutCubit.getMealTypeLables(context: context),
                      changeLevel: (index) {
                        nutCubit.changeCurrentMealType(index: index,isDailyRecipe: true);
                      }),

                ),
                state is GetFilteredRecipesLoadingState
                    ? Expanded(
                  child: Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        color: ColorManager.kBlue,
                      )),
                )
                    :
                Expanded(
                  child: RecipeGridSquareBlock(
                    recipeModels: nutCubit.recipeModels,
                    editFunction: (docId) {
                      nutCubit.editRecipe(docId: docId,isDailyRecipe: true);
                    },
                    setAttributes: (RecipeModel model){
                      nutCubit.setRecipeAttributes(model: model);
                    },
                    deleteFunction: (docId){
                      nutCubit.deleteRecipe(docId: docId,isDailyRecipe: true);
                    },
                    tabBarView: nutCubit.getRecipeTabBarViews(nutritionCubit: nutCubit),
                    hasFavouriteIcon: false,

                  ),
                ),
              ],
            ),
            floatingActionButton:FloatingActionButtonBlock(
                function: (){
                  showAlertRecipeBox(
                      context: context,
                      tabBar: dailyRecipeTabBar,
                      tabBarView: nutCubit.getRecipeTabBarViews(nutritionCubit: nutCubit),
                      buttonFunction: (){
                        nutCubit.processOfAddRecipes(isDailyRecipe: true);
                      },
                      title: S.of(context).recipe,
                      buttonLable:  S.of(context).addRecipe);
                }
            )
          );
        },
      ),
    );
  }
}
