import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/cubits/profile_cubit/profile_cubit.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../../screens/navigation_bar_screens/home_screen/home_subscreens/nutrition_screens/daily_recipe_screen.dart';
import '../../../../../../screens/navigation_bar_screens/home_screen/home_subscreens/nutrition_screens/meal_plan_creation_screen.dart';
import '../../../../../managers_files/alert_box_manager.dart';
import '../../../../../managers_files/color_manager.dart';
import '../../../../../managers_files/font_manager.dart';
import '../../../../../managers_files/style_manager.dart';
import '../../../../../managers_files/values_manager.dart';
import '../../../../general_blocks/daily_activity_block.dart';
import '../../../../general_blocks/general_button_block.dart';
import '../../meals_types_list_block.dart';

class HasNoMealPlanBlock extends StatelessWidget {
  const HasNoMealPlanBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NutritionCubit, NutritionState>(
      listener: (context, state) {},
      builder: (context, state) {
        var nutCubit = NutritionCubit.get(context);
        return Expanded(
          child: FutureBuilder(
            future: nutCubit.hasMealPlanRequest(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData && snapshot.data == true) {
                return Center(
                  child: Text(
                    S.of(context).createRequestSuccessMessage,
                    style: getMediumStyle(
                      fontSize: FontSize.s20,
                      color: ColorManager.kWhiteColor,
                      fontFamily: FontFamily.kPoppinsFont,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              } else if (snapshot.hasData && snapshot.data == false) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).createMealPlanMassage,
                      style: getMediumStyle(
                        fontSize: FontSize.s20,
                        color: ColorManager.kWhiteColor,
                        fontFamily: FontFamily.kPoppinsFont,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20), // Add some spacing
                    GeneralButtonBlock(
                      lable: S.of(context).create,
                      function: () {
                        Get.to(() => MealPlanCreationScreen(
                              userNickName: ProfileCubit.get(context)
                                  .profileModel!
                                  .nickName,
                            ));
                      },
                      backgroundColor: ColorManager.kPurpleColor,
                      textStyle: getMediumStyle(
                        fontSize: FontSize.s20,
                        color: ColorManager.kWhiteColor,
                        fontFamily: FontFamily.kPoppinsFont,
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'An error occurred: ${snapshot.error}',
                    style: getMediumStyle(
                      fontSize: FontSize.s18,
                      color: Colors.red,
                      fontFamily: FontFamily.kPoppinsFont,
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Text('No data available',
                      style: getMediumStyle(
                        fontSize: FontSize.s18,
                        color: Colors.red,
                        fontFamily: FontFamily.kPoppinsFont,
                      )),
                );
              }
            },
          ),
        );
      },
    );
  }
}
