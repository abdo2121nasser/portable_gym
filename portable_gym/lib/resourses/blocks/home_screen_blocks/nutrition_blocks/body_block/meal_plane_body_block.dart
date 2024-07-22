import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';

import '../../../../../generated/l10n.dart';
import '../../../../managers_files/values_manager.dart';
import '../../../general_blocks/daily_activity_block.dart';
import '../../work_out_block/horizontal_category_list_block.dart';
import '../meals_types_list_block.dart';


class MealPlaneBodyBlock extends StatelessWidget {
  const MealPlaneBodyBlock({super.key});

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
                padding: EdgeInsets.symmetric(vertical: AppVerticalSize.s22),
                child: DailyActivityBlock(title: S
                    .of(context)
                    .recipeOfDay, isDailyTraining: false,),
                //todo finish the daily recipe
              ),
              MealsTypesListBlock(
                lables: nutCubit.getMealTypeLables(context: context),),
            ],
          ),
        );
      },
    );
  }
}
