import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/work_out_block/floating_action_button_block.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/work_out_block/horizontal_category_list_block.dart';
import 'package:portable_gym/resourses/managers_files/alert_box_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/nutrition_screens/food_main_element_screen.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../resourses/blocks/home_screen_blocks/nutrition_blocks/meals_types_list_block.dart';
import '../../../../../resourses/blocks/home_screen_blocks/work_out_block/daily_activity_block.dart';
import '../../../../../resourses/managers_files/color_manager.dart';
import '../../../../../resourses/managers_files/font_manager.dart';
import '../../../../../resourses/managers_files/style_manager.dart';

class NutritionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TabBar recipeTabBar = TabBar(
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
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorManager.kBlackColor,
          appBar: AppBar(
            backgroundColor: ColorManager.kBlackColor,
            leadingWidth: AppHorizontalSize.s150,
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.arrow_left,
                    color: ColorManager.kLimeGreenColor,
                  ),
                  Expanded(
                    child: Text(
                      S.of(context).nutraitions,
                      style: getBoldStyle(
                          fontSize: FontSize.s20,
                          color: ColorManager.kPurpleColor,
                          fontFamily: FontFamily.kPoppinsFont),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppHorizontalSize.s22),
                child: InkWell(
                    onTap: () {
                      Get.to(FoodMainElementScreen());
                    },
                    child: Icon(
                      Icons.psychology_rounded,
                      color: ColorManager.kLimeGreenColor,
                    )),
              )
            ],
          ),
          body: Column(
            children: [
              HorizontalCategoryListBlock(
                  currentLevel: nutCubit.currentPlane,
                  numberOfLevels: 2,
                  lables: nutCubit.getMealPlaneLabel(context: context),
                  changeLevel: (index) {
                    nutCubit.changeCurrentPlane(index: index);
                  }),
              nutCubit.planBodies[nutCubit.currentPlane],
            ],
          ),
          floatingActionButton:nutCubit.currentPlane==1? FloatingActionButtonBlock(
            function: (){
              showAlertRecipeBox(
                  context: context,
                  tabBar: recipeTabBar,
                  tabBarView: nutCubit.recipeTabBarViews,
                  buttonFunction: nutCubit.processOfAddRecipes,
                  title: S.of(context).recipe,
                  buttonLable:  S.of(context).addRecipe);
            }
          ):null,
        );
      },
    );
  }
}
