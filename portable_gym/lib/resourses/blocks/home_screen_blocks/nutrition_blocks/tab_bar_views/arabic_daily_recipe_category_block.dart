import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cubits/nutrition_cubit/nutrition_cubit.dart';
import '../../../../managers_files/color_manager.dart';
import '../../../../managers_files/string_manager.dart';
import '../../../general_blocks/full_input_block.dart';

class ArabicDailyRecipeCategoryBlock extends StatelessWidget {
  ArabicDailyRecipeCategoryBlock({super.key, required this.nutCubit});
  NutritionCubit nutCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: nutCubit,
        child: Column(
          children: [
            FullInputBlock(
                lable: StringManager.arabicRecipeNameLable,
                color: ColorManager.kBlackColor,
                enableBorder: true,
                isArabicTabView: true,
                controller: nutCubit.arabicDailyRecipeCategoryNameController),
            FullInputBlock(
                lable: StringManager.arabicRecipeCaloriesLable,
                color: ColorManager.kBlackColor,
                enableBorder: true,
                isArabicTabView: true,
                controller:
                    nutCubit.arabicDailyRecipeCategoryCaloriesController),
            FullInputBlock(
                lable: StringManager.arabicRecipeImageLinkLable,
                color: ColorManager.kBlackColor,
                enableBorder: true,
                isArabicTabView: true,
                controller: nutCubit.dailyRecipeCategoryImageLinkController),
          ],
        ));
  }
}
