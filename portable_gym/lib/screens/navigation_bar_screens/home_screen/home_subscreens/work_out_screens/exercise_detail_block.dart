import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../../../../resourses/blocks/resource_screen_blocks/recorded_unit_block.dart';
import '../../../../../resourses/managers_files/font_manager.dart';
import '../../../../../resourses/managers_files/style_manager.dart';


class ExerciseDetailBlock extends StatelessWidget {
  const ExerciseDetailBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s22 ),
      padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s22),
      height: MediaQuery.of(context).size.height*0.2,
width: MediaQuery.of(context).size.width,
decoration: BoxDecoration(
  color: ColorManager.kLimeGreenColor,
  borderRadius: BorderRadius.circular(AppRadiusSize.s22)
),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: AppVerticalSize.s30,
            child: Text(
              'squats',
              style: getMeduimStyle(
                  fontSize: FontSize.s20,
                  color: ColorManager.kBlackColor,
                  fontFamily: FontFamily.kPoppinsFont),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: AppVerticalSize.s44,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed cursus libero eget.',
                    style: getMeduimStyle(
                        fontSize: FontSize.s12,
                        color: ColorManager.kBlackColor,
                        fontFamily: FontFamily.kPoppinsFont),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: ColorManager.kWhiteColor,
                borderRadius: BorderRadius.circular(AppRadiusSize.s36)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    height:  MediaQuery.of(context).size.height*0.05,
                    width: MediaQuery.of(context).size.width*0.2,
                    child: RecordedUnitBlock(textColor: ColorManager.kBlackColor,iconColor: ColorManager.kBlackColor,)),
                SizedBox(
                    height:  MediaQuery.of(context).size.height*0.05,
                    width: MediaQuery.of(context).size.width*0.2,
                    child: RecordedUnitBlock(textColor: ColorManager.kBlackColor,iconColor: ColorManager.kBlackColor,)),
                SizedBox(
                    height:  MediaQuery.of(context).size.height*0.05,
                    width: MediaQuery.of(context).size.width*0.2,
                    child: RecordedUnitBlock(textColor: ColorManager.kBlackColor,iconColor: ColorManager.kBlackColor,)),

              ],
            ),
          )

        ],
      ),
    );
  }
}
