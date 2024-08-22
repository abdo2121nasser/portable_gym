import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/check_box_block.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../grid_meal_types_block.dart';
import '../list_recipe_input_block.dart';

class EnglishRecipeTabBarBlock extends StatelessWidget {
  NutritionCubit nutCubit;

  EnglishRecipeTabBarBlock({super.key, required this.nutCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: nutCubit,
      child: BlocConsumer<NutritionCubit, NutritionState>(
        listener: (context, state) {},
        builder: (context, state) {
          var nutCubit = NutritionCubit.get(context);
          return Column(
            children: [
              ListRecipeInputBlock(
                controllers: nutCubit.getEnglishRecipeControllers(),
                lables: nutCubit.getEnglishRecipeLables(),
              ),
              GridMealTypesBlock(
                lables: nutCubit.getEnglishMealTypeCheckBoxesLables(),
                values: nutCubit.mealTypeCheckBoxes,
                function: (int index, bool value) {
                  nutCubit.changeMealTypeCheckBoxesValues(
                      index: index, value: value);
                },
              )
            ],
          );
        },
      ),
    );
  }
}
