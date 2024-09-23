import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_coach/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:my_coach/cubits/profile_cubit/profile_cubit.dart';
import 'package:my_coach/resourses/blocks/home_screen_blocks/nutrition_blocks/body_block/views_block/has_meal_plan_block.dart';
import 'package:my_coach/resourses/managers_files/color_manager.dart';
import 'package:my_coach/resourses/managers_files/image_manager.dart';

import 'has_no_meal_plan_block.dart';

class UserViewBlock extends StatelessWidget {
  const UserViewBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NutritionCubit, NutritionState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var nutCubit=NutritionCubit.get(context);
        return
        ProfileCubit.get(context).profileModel!.isPremium?
          state is HasMealPlanLoadingState?
          const Expanded(child: Center(child: CircularProgressIndicator(color: ColorManager.kPurpleColor,))):
              nutCubit.hasMealPlan?
                  const HasMealPlanBlock():
              const HasNoMealPlanBlock():
          Expanded(child: Center(child: Image.asset(ImageManager.kLockImage,color: ColorManager.kLightPurpleColor,)))
          ;
      },
    );
  }
}
