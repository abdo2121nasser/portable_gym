import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/square_element%20_block.dart';
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/nutrition_screens/recipe_details_screen.dart';

import '../../managers_files/values_manager.dart';
import '../../models/nutrition_models/recipe_model.dart';

class HorizontalSquareBlock extends StatelessWidget {
  final List<RecipeModel> recipes;

  const HorizontalSquareBlock({super.key, required this.recipes});
  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: ListView.separated(
          padding: EdgeInsets.symmetric(
              horizontal: AppHorizontalSize.s8,
              vertical: AppVerticalSize.s8),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var langModel=recipes[index].getLanguageClass(context);
            return InkWell(
              onTap: (){
                Get.to(RecipeDetailsScreen(recipeModel: recipes[index]));
              },
              child: SquareElementBlock(
title: langModel.name!,
                subValue: langModel.calories!,
                imageLink: recipes[index].imageLink,
                 hasFavouriteIcon: false,
                canBeDeleted: true,
                ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(
            width: AppHorizontalSize.s8,
          ),
          itemCount: recipes.length),
    );
  }
}
