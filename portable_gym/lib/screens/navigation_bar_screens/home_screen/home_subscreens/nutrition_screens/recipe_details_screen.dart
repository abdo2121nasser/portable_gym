import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/general_app_bar_block.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/recorded_unit_block.dart';
import 'package:portable_gym/resourses/models/nutrition_models/recipe_model.dart';
import 'package:vertical_weight_slider/vertical_weight_slider.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../resourses/blocks/home_screen_blocks/nutrition_blocks/grid_recipe_mesuarments_block.dart';
import '../../../../../resourses/blocks/home_screen_blocks/nutrition_blocks/recipe_image_block.dart';
import '../../../../../resourses/managers_files/color_manager.dart';
import '../../../../../resourses/managers_files/font_manager.dart';
import '../../../../../resourses/managers_files/style_manager.dart';
import '../../../../../resourses/managers_files/values_manager.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final RecipeModel recipeModel;

  RecipeDetailsScreen({required this.recipeModel});

  @override
  Widget build(BuildContext context) {
    var languageModel = recipeModel.getLanguageClass(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorManager.kBlackColor,
      appBar: GeneralAppBarBlock(title: languageModel.name!),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridRecipeMeasurementsBlock(languageModel: recipeModel.getLanguageClass(context),),
          RecipeImageBlock(image: recipeModel.imageLink,),
        Expanded(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: AppHorizontalSize.s22,vertical: AppVerticalSize.s22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).advantage,
                  style: getSemiBoldStyle(
                      fontSize: FontSize.s16,
                      color: ColorManager.kLimeGreenColor,
                      fontFamily: FontFamily.kPoppinsFont),
                ),
                Expanded(
                  child: ListView.builder(itemBuilder: (context, index) =>
                 Text(
                      languageModel.advantage!,
                      style: getLightStyle(
                          fontSize: FontSize.s16,
                          color: ColorManager.kWhiteColor,
                          fontFamily: FontFamily.kLeagueSpartanFont),
                      textAlign: TextAlign.start,
                    ),
                    itemCount: 1,
                  ),
                )
              ],
            ),
          ),
        )
        ],
      ),
    );
  }
}
