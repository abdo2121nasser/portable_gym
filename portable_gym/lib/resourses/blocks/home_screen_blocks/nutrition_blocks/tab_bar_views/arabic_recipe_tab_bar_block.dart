import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';

import '../grid_meal_types_block.dart';
import '../list_recipe_input_block.dart';

class ArabicRecipeTabBarBlock extends StatelessWidget {
  NutritionCubit nutCubit;

  ArabicRecipeTabBarBlock({required this.nutCubit});

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
                controllers: nutCubit.getArabicRecipeControllers(),
                lables: nutCubit.getArabicRecipeLables(),
                isArabicTabView: true,
              ),
              GridMealTypesBlock(
                lables: nutCubit.getArabicMealTypeCheckBoxesLables(),
                values: nutCubit.mealTypeCheckBoxes,
                isArabic: true,
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
