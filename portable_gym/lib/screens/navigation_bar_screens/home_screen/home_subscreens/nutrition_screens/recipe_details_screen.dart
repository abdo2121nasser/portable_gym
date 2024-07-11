import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      appBar: AppBar(
        backgroundColor: ColorManager.kBlackColor,
        leadingWidth: AppHorizontalSize.s150,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Row(
            children: [
              const Icon(
                Icons.arrow_left,
                color: ColorManager.kLimeGreenColor,
              ),
              Expanded(
                child: Text(
                  languageModel.name,
                  style: getBoldStyle(
                      fontSize: FontSize.s20,
                      color: ColorManager.kPurpleColor,
                      fontFamily: FontFamily.kPoppinsFont),
                ),
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s22),
            child: Icon(
              Icons.star_rounded,
              color: ColorManager.kWhiteColor,
            ),
          )
        ],
      ),
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
                  child: Text(
                    languageModel.advantage,
                    style: getLightStyle(
                        fontSize: FontSize.s16,
                        color: ColorManager.kWhiteColor,
                        fontFamily: FontFamily.kLeagueSpartanFont),
                    textAlign: TextAlign.start,
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
