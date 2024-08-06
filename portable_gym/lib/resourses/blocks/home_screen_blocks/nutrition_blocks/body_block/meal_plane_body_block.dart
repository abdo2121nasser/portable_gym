import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/general_button_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/nutrition_screens/daily_recipe_screen.dart';
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/nutrition_screens/meal_plan_creation_screen.dart';

import '../../../../../generated/l10n.dart';
import '../../../../managers_files/alert_box_manager.dart';
import '../../../../managers_files/font_manager.dart';
import '../../../../managers_files/style_manager.dart';
import '../../../../managers_files/values_manager.dart';
import '../../../general_blocks/daily_activity_block.dart';
import '../../work_out_block/horizontal_category_list_block.dart';
import '../meals_types_list_block.dart';

class MealPlaneBodyBlock extends StatelessWidget {
  const MealPlaneBodyBlock({super.key});

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
    return BlocProvider.value(
      value: NutritionCubit.get(context)..getDailyRecipeCategory(),
      child: BlocConsumer<NutritionCubit, NutritionState>(
        listener: (context, state) {},
        builder: (context, state) {
          var nutCubit = NutritionCubit.get(context);

          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // state is GetDailyRecipeCardLoadingState
                //     ? SizedBox(height: AppVerticalSize.s5,)
                //     : Padding(
                //         padding:
                //             EdgeInsets.symmetric(vertical: AppVerticalSize.s22),
                //         child: InkWell(
                //           onTap: (){
                //             nutCubit.changeCurrentMealType(index: 0,isDailyRecipe: true);
                //           Get.to(DailyRecipeScreen(nutCubit: nutCubit,));
                //           },
                //           onLongPress: (){
                //             nutCubit.setDailyRecipeCategoryAttributes();
                //             showAlertDailyRecipeCategoryBox(
                //               context: context,
                //               tabBar: dailyRecipeCategoryTabBar,
                //               tabBarView: nutCubit.getDailyRecipeCategoryTabBarViews(nutritionCubit: nutCubit),
                //               title: S.of(context).recipeOfDay,
                //               buttonLable: S.of(context).edit,
                //               buttonFunction: (){
                //                 nutCubit.editDailyRecipeCategory();
                //               }
                //             );
                //           },
                //           child: DailyActivityBlock(
                //             title: S.of(context).recipeOfDay,
                //             isDailyTraining: false,
                //             dailyRecipeCardModel: nutCubit.dailyRecipeCardModel,
                //           ),
                //         ),
                //       ),
                // MealsTypesListBlock(
                //   lables: nutCubit.getMealTypeLables(context: context),
                // ),
                //todo uncommite it when it ready to have meal plan
                Text(S.of(context).createMealPlanMassage,
                    style: getMediumStyle(
                        fontSize: FontSize.s20,
                        color: ColorManager.kWhiteColor,
                        fontFamily: FontFamily.kPoppinsFont)),
                GeneralButtonBlock(
                    lable: S.of(context).create,
                    function: () {
                      Get.to(()=> MealPlanCreationScreen());
                    },
                    backgroundColor: ColorManager.kPurpleColor,
                    textStyle: getMediumStyle(
                        fontSize: FontSize.s20,
                        color: ColorManager.kWhiteColor,
                        fontFamily: FontFamily.kPoppinsFont)),
              ],
            ),
          );
        },
      ),
    );
  }
}
