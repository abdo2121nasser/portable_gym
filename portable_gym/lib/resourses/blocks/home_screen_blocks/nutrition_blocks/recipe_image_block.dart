import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';




class RecipeImageBlock extends StatelessWidget {
        final String image;

        RecipeImageBlock({required this.image});

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
        child: Image.network(
          image,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppHorizontalSize.s30),
                  child: CircularProgressIndicator(
                    color: ColorManager.kBlue,
                  ),
                ),
              );
            }
          },
          fit: BoxFit.fill,
        ),
      ),

    );
  }
}
