import 'package:flutter/material.dart';

import '../managers_files/color_manager.dart';
import '../managers_files/image_manager.dart';
import '../managers_files/values_manager.dart';




class GenderBlock extends StatelessWidget {
      final String image;

      GenderBlock({required this.image});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s30,vertical: AppVerticalSize.s30),
      decoration: BoxDecoration(

          shape: BoxShape.circle,
          border: Border.all(width: AppHorizontalSize.s2,color: ColorManager.kWhiteColor)
      ),
      child: Image.asset(image,color: ColorManager.kWhiteColor,width: AppHorizontalSize.s70,height: AppVerticalSize.s120,),
    )
    ;
  }
}
