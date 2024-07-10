import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/square_element%20_block.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../../general_blocks/grid_square_block.dart';
import '../../work_out_block/horizontal_category_list_block.dart';

class MealIdeaBodyBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NutritionCubit, NutritionState>(
      listener: (context, state) {
      },
      builder: (context, state) {
     var nutCubit=NutritionCubit.get(context);
        return Expanded(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: AppVerticalSize.s14),
                child: HorizontalCategoryListBlock(
                    currentLevel: nutCubit.currentMealType,
                    numberOfLevels: nutCubit.getMealTypeLables(context: context).length,
                    lables: nutCubit.getMealTypeLables(context: context),
                    changeLevel: (index) {
                       nutCubit.changeCurrentMealType(index: index);
                    }),
              ),

              GridSquareBlock(),
            ],
          ),
        );
      },
    );
  }
}
