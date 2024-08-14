import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/nutrition_blocks/body_block/views_block/has_meal_plan_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../../screens/navigation_bar_screens/home_screen/home_subscreens/nutrition_screens/daily_recipe_screen.dart';
import '../../../../../managers_files/alert_box_manager.dart';
import '../../../../../managers_files/values_manager.dart';
import '../../../../general_blocks/daily_activity_block.dart';
import '../../meals_types_list_block.dart';
import 'has_no_meal_plan_block.dart';

class UserViewBlock extends StatelessWidget {
  const UserViewBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: NutritionCubit.get(context)
        ..getHasMealPlan(),
      child: BlocConsumer<NutritionCubit, NutritionState>(
        listener: (context, state) {
        },
        builder: (context, state) {
          var nutCubit=NutritionCubit.get(context);
          return
            state is HasMealPlanLoadingState?
            const Expanded(child: Center(child: CircularProgressIndicator(color: ColorManager.kPurpleColor,))):
                nutCubit.hasMealPlan?
                    const HasMealPlanBlock():
                const HasNoMealPlanBlock()
            ;
        },
      ),
    );
  }
}
