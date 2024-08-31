import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cubits/nutrition_cubit/nutrition_cubit.dart';
import '../../../../managers_files/color_manager.dart';
import '../../../../managers_files/string_manager.dart';
import '../../../general_blocks/full_input_block.dart';

class EnglishDailyRecipeCategoryBlock extends StatelessWidget {
  EnglishDailyRecipeCategoryBlock({super.key, required this.nutCubit});

  NutritionCubit nutCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: nutCubit,
        child: Column(
          children: [
            FullInputBlock(
                lable: StringManager.englishRecipeNameLable,
                color: ColorManager.kBlackColor,
                enableBorder: true,
                controller: nutCubit.englishDailyRecipeCategoryNameController),
            FullInputBlock(
                lable: StringManager.englishRecipeCaloriesLable,
                color: ColorManager.kBlackColor,
                enableBorder: true,
                controller:
                    nutCubit.englishDailyRecipeCategoryCaloriesController),
            FullInputBlock(
                lable: StringManager.englishRecipeImageLinkLable,
                color: ColorManager.kBlackColor,
                enableBorder: true,
                multiLine: false,
                controller:
                    nutCubit.dailyRecipeCategoryImageLinkController),
          ],
        ));
  }
}
