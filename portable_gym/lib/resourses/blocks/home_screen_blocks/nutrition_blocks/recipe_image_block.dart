import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../general_blocks/general_image_cash_block.dart';




class RecipeImageBlock extends StatelessWidget {
        final String image;

        const RecipeImageBlock({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppHorizontalSize.s22,
        vertical: AppVerticalSize.s22
      ),
      height: MediaQuery.of(context).size.height*0.3,
      width: double.infinity,
      color: ColorManager.kLightPurpleColor,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
           AppRadiusSize.s22,),
        child: GeneralImageCacheBlock(link: image),
      ),

    );
  }
}
