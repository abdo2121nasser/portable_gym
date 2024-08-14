import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:portable_gym/cubits/nutrition_cubit/nutrition_cubit.dart';
import 'package:portable_gym/cubits/profile_cubit/profile_cubit.dart';

import '../../../../../generated/l10n.dart';
import '../../../../managers_files/color_manager.dart';
import '../../../../managers_files/font_manager.dart';
import '../../../../managers_files/style_manager.dart';
import '../../../../managers_files/values_manager.dart';
import '../../../../models/nutrition_models/recipe_model.dart';
import '../../../general_blocks/general_app_bar_block.dart';
import '../../../general_blocks/general_button_block.dart';
import '../../work_out_block/horizontal_category_list_block.dart';
import '../recipe_grid_square_block.dart';
import '../select_square_grid_view_block.dart';



class MealSelectionScreen extends StatelessWidget {
  final String requestDocId;
  final NutritionCubit nutCubit;
  const MealSelectionScreen({super.key,required this.nutCubit,required this.requestDocId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: nutCubit..getFilteredRecipes(),
  child: BlocConsumer<NutritionCubit, NutritionState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    return Scaffold(
      appBar: GeneralAppBarBlock(
        title:'${S.of(context).create} ${S.of(context).mealPlan}',
      ),
    body: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: AppVerticalSize.s14),
          child: HorizontalCategoryListBlock(
              currentLevel: nutCubit.currentMealType,
              numberOfLevels:
              nutCubit.getMealTypeLables(context: context).length,
              lables: nutCubit.getMealTypeLables(context: context),
              changeLevel: (index) {
                nutCubit.changeCurrentMealType(index: index);
              }),

        ),
        state is GetFilteredRecipesLoadingState
            ? Expanded(
          child: Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: ColorManager.kBlue,
              )),
        )
            :
        const SelectSquareGridViewBlock(),
        GeneralButtonBlock(lable: S.of(context).create,
            function:(){
          nutCubit.createMealPlan(requestDocId: requestDocId);
            },
            backgroundColor: ColorManager.kPurpleColor,
            textStyle:  getMediumStyle(
                fontSize: FontSize.s20,
                color: ColorManager.kWhiteColor,
                fontFamily: FontFamily.kPoppinsFont))

      ],
    ),
      
    );
  },
),
);
  }
}
