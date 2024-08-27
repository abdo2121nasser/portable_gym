import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:portable_gym/resourses/models/progress_models/activity_model.dart';

import '../../../../generated/l10n.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';


class ProgressActivityBlock extends StatelessWidget {
     final Activity activity;
  const ProgressActivityBlock({super.key,required this.activity});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.kWhiteColor,
        borderRadius: BorderRadius.circular(AppRadiusSize.s22)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
           Icon(Icons.run_circle,color: ColorManager.kPurpleColor,size: AppVerticalSize.s65,),
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'upper body work out',
                  style: getMediumStyle(
                      fontSize: FontSize.s14,
                      color: ColorManager.kBlackColor,
                      fontFamily: FontFamily.kPoppinsFont),
                ),
                Text(
                  'june 09',
                  style: getMediumStyle(
                      fontSize: FontSize.s14,
                      color: ColorManager.kLightPurpleColor,
                      fontFamily: FontFamily.kPoppinsFont),
                ),
              ],
            ),
          ),
          SizedBox(
            child: Row(
              children: [
                const Icon(Icons.access_time_filled_outlined,color: ColorManager.kPurpleColor,),
              SizedBox(width: AppHorizontalSize.s5,),
                Text(
                  'Duration\n25 min',
                  style: getMediumStyle(
                      fontSize: FontSize.s14,
                      color: ColorManager.kPurpleColor,
                      fontFamily: FontFamily.kPoppinsFont),
                ),

              ],
            ),
          )

        ],
      ),
    );
  }
}
