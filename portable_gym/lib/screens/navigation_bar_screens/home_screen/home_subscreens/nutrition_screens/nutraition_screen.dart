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
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/nutrition_screens/meal_plan_creation_screen.dart';

import '../../../../../cubits/favourite_cubit/favourite_cubit.dart';
import '../../../../../cubits/profile_cubit/profile_cubit.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../resourses/blocks/home_screen_blocks/nutrition_blocks/meals_types_list_block.dart';
import '../../../../../resourses/blocks/general_blocks/daily_activity_block.dart';
import '../../../../../resourses/managers_files/color_manager.dart';
import '../../../../../resourses/managers_files/font_manager.dart';
import '../../../../../resourses/managers_files/style_manager.dart';

class NutritionScreen extends StatelessWidget {
  final ProfileCubit? profCubit;

  const NutritionScreen({super.key, this.profCubit});
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
    return BlocProvider.value(
      value: profCubit!,
      child: BlocProvider(
        create: (context) => NutritionCubit()..getDailyRecipeCategory(),
        child: BlocConsumer<NutritionCubit, NutritionState>(
          listener: (context, state) {},
          builder: (context, state) {
            var nutCubit = NutritionCubit.get(context);
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: ColorManager.kBlackColor,
              appBar: GeneralAppBarBlock(
                title: S.of(context).nutrition,
                actions: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: AppHorizontalSize.s8),
                    child: InkWell(
                        onTap: () {
                          Get.to(FoodMainElementScreen(
                            nutCubit: nutCubit,
                          ));
                        },
                        child: const Icon(
                          Icons.psychology_rounded,
                          color: ColorManager.kLimeGreenColor,
                        )),
                  ),
                  FutureBuilder(
                      future: nutCubit.hasMealPlanRequest(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            snapshot.data == true &&
                            profCubit!.profileModel != null) {
                          return InkWell(
                              onTap: () {
                                Get.to(MealPlanCreationScreen(
                                    userNickName:
                                        profCubit!.profileModel!.nickName));
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppHorizontalSize.s5),
                                child: const Icon(
                                  Icons.change_circle_outlined,
                                  color: ColorManager.kLimeGreenColor,
                                ),
                              ));
                        } else {
                          return const SizedBox();
                        }
                      })
                ],
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 0))
                      .then((value)  {
                    if (profCubit!.profileModel != null &&
                        !profCubit!.profileModel!.isClient) {
                      nutCubit.getAllMealPlanRequests();
                    }
                  });
                },
                child: Column(
                  children: [
                    HorizontalCategoryListBlock(
                        currentLevel: nutCubit.currentPlane,
                        numberOfLevels: nutCubit.planBodies.length,
                        lables: nutCubit.getMealPlaneLabel(context: context),
                        changeLevel: (index) {
                          nutCubit.changeCurrentPlane(index: index);
                        }),
                    nutCubit.planBodies[nutCubit.currentPlane],
                  ],
                ),
              ),
              floatingActionButton: nutCubit.currentPlane == 1
                  ? FloatingActionButtonBlock(function: () {
                      showAlertRecipeBox(
                          context: context,
                          tabBar: recipeTabBar,
                          tabBarView: nutCubit.getRecipeTabBarViews(
                              nutritionCubit: nutCubit),
                          buttonFunction: nutCubit.processOfAddRecipes,
                          title: S.of(context).recipe,
                          buttonLable: S.of(context).addRecipe);
                    })
                  : null,
            );
          },
        ),
      ),
    );
  }
}
