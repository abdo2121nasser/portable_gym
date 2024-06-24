import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/image_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';



class ExerciseVideoBlock extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          alignment: Alignment.center,
           padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s30,vertical: AppVerticalSize.s30),
          height: MediaQuery.of(context).size.height*0.55,
          color: ColorManager.kLightPurpleColor,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadiusSize.s20),

                  child: Image.asset(ImageManager.kSmileManImage,fit: BoxFit.fill,)),
              Padding(
                padding:  EdgeInsets.all(AppVerticalSize.s12),
                child: Icon(Icons.star_rounded,color: ColorManager.kLimeGreenColor,size: AppVerticalSize.s44,),
              )

            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: ColorManager.kPurpleColor,
              shape: BoxShape.circle
          ),
          child: Icon(Icons.play_arrow_rounded,color: ColorManager.kWhiteColor,size: AppVerticalSize.s120,),
        ),


      ],
    );
  }
}
