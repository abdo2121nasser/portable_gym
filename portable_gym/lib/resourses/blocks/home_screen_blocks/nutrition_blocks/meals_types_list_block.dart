import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:portable_gym/resourses/models/nutrition_models/meal_plan_model.dart';

import '../../../managers_files/color_manager.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';
import '../../../models/nutrition_models/recipe_model.dart';
import '../../general_blocks/horizontal_square_block.dart';

class MealsTypesListBlock extends StatelessWidget {
  final List<String> lables;
  final MealPlanModel model;

  const MealsTypesListBlock(
      {super.key, required this.lables, required this.model});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s22),
          itemBuilder: (context, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lables[index],
                    style: getSemiBoldStyle(
                        fontSize: FontSize.s20,
                        color: ColorManager.kLimeGreenColor,
                        fontFamily: FontFamily.kPoppinsFont),
                  ),
                  SizedBox(
                      height: AppVerticalSize.s160,
                      child: Row(
                        children: [
                          HorizontalSquareBlock(
                            recipes: getMealModel(index: index),
                          ),
                        ],
                      )),
                ],
              ),
          separatorBuilder: (context, index) => SizedBox(
                height: AppVerticalSize.s5,
              ),
          itemCount: lables.length),
    );
  }

  List<RecipeModel> getMealModel({required int index}) {
    switch (index) {
      case 0:
        return model.breakfast;
      case 1:
        return model.lunch;
      case 2:
        return model.dinner;
      default:
        return model.snacks;
    }
  }
}
