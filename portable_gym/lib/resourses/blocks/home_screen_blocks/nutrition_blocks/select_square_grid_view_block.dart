import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/resourses/managers_files/google_drive_function_manager.dart';

import '../../../managers_files/values_manager.dart';
import '../../general_blocks/square_element _block.dart';


class SelectSquareGridViewBlock extends StatelessWidget {
  const SelectSquareGridViewBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NutritionCubit, NutritionState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var nutCubit=NutritionCubit.get(context);
        return Expanded(child:
        GridView.builder(
          padding: EdgeInsets.symmetric(
              horizontal: AppHorizontalSize.s22,
              vertical: AppVerticalSize.s14),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              childAspectRatio: (1 / .8),
              mainAxisSpacing: 15),
          itemBuilder: (context, index) {
            var model = nutCubit.recipeModels[nutCubit.currentMealType][index].getLanguageClass(context);
            var isSelectedRecipe = nutCubit.isMealPlanRecipeSelected(
                model: nutCubit.recipeModels[nutCubit.currentMealType][index]);
            return InkWell(
                onTap: () {
                  if (!isSelectedRecipe) {
                    nutCubit.addMealPlanRecipe(
                        model: nutCubit.recipeModels[nutCubit.currentMealType][index]);
                  }
                  else {
                    nutCubit.deleteMealPlanRecipe(
                        model: nutCubit.recipeModels[nutCubit.currentMealType][index]);
                  }
                },
                child: SquareElementBlock(
                  title: model.name!,
                  subValue: model.calories!,
                  imageLink: nutCubit.recipeModels[nutCubit.currentMealType][index].imageLink,
                  canBeDeleted: true,
                  hasFavouriteIcon: false,
                  hasSelectIcon: true,
                  isSelected: isSelectedRecipe,
                ));
          },
          itemCount: nutCubit.recipeModels.length,
        )
        );
      },
    );
  }
}
