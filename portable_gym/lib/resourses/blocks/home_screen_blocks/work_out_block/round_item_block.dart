import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/blocks/resource_screen_blocks/recorded_unit_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:vertical_weight_slider/vertical_weight_slider.dart';

import '../../../../generated/l10n.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';


class RoundItemBlock extends StatelessWidget {
  const RoundItemBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppVerticalSize.s10,horizontal: AppHorizontalSize.s16),
      decoration: BoxDecoration(
        color: ColorManager.kWhiteColor,
        borderRadius: BorderRadius.circular(AppRadiusSize.s36)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorManager.kLightPurpleColor,
                  shape: BoxShape.circle
                ),
                child: Icon(Icons.play_arrow_rounded,color: ColorManager.kWhiteColor,size: AppVerticalSize.s55,),
              ),
              SizedBox(width: AppHorizontalSize.s5,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height:AppVerticalSize.s16 ,
                    width: AppHorizontalSize.s178,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Dumbbell Rows',
                            style: getMeduimStyle(
                                fontSize: FontSize.s12,
                                color: ColorManager.kBlackColor,
                                fontFamily: FontFamily.kPoppinsFont),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppVerticalSize.s5,),
                  SizedBox(
                      width: MediaQuery.of(context).size.width*0.19,
                      child: RecordedUnitBlock(textColor: ColorManager.kLightPurpleColor,iconColor: ColorManager.kLightPurpleColor,)),

                ],
              ),

            ],
          ),
          Text(
            S.of(context).reputation+'3x',
            style: getMeduimStyle(
                fontSize: FontSize.s12,
                color: ColorManager.kBlackColor,
                fontFamily: FontFamily.kPoppinsFont),
          ),

        ],
      ),
    );
  }
}
