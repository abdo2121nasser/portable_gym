import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/image_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../../cubits/profile_cubit/profile_cubit.dart';
import '../../managers_files/color_manager.dart';
import '../../managers_files/font_manager.dart';
import '../../managers_files/style_manager.dart';


class TopMenuElementBlock extends StatelessWidget {
    final String lable;
    final String image;

    TopMenuElementBlock({required this.lable,required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
    Expanded(
        child: Image.asset(image,color: ColorManager.kLightPurpleColor,fit: BoxFit.fill,)),
         SizedBox(height: AppVerticalSize.s12,),
         Expanded(
           child: Text(
            lable,
            style: getLightStyle(
                fontSize: FontSize.s22,
                color: ColorManager.kLightPurpleColor,
                fontFamily: FontFamily.kLeagueSpartanFont),
             textAlign: TextAlign.center,
        ),
         ),

      ],
    );
  }
}
