import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/progress_tracking_blocks/vertical_measurement_block.dart';
import 'package:portable_gym/resourses/managers_files/image_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../../managers_files/color_manager.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';



class VerticalInformationBlock extends StatelessWidget {
  const VerticalInformationBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SizedBox(
               width: AppHorizontalSize.s178,
              child: Row(
                children: [
                  Text(
                    'madison',
                    style: getBoldStyle(
                        fontSize: FontSize.s22,
                        color: ColorManager.kWhiteColor,
                        fontFamily: FontFamily.kPoppinsFont),
                  ),
                  SizedBox(width: AppHorizontalSize.s10,),
                  Image.asset(ImageManager.kMaleImage,width: AppHorizontalSize.s22,color: ColorManager.kLimeGreenColor,)
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  'age: ',
                  style: getSemiBoldStyle(
                      fontSize: FontSize.s14,
                      color: ColorManager.kWhiteColor,
                      fontFamily: FontFamily.kLeagueSpartanFont),
                ),
                Text(
                  '28',
                  style: getLightStyle(
                      fontSize: FontSize.s14,
                      color: ColorManager.kWhiteColor,
                      fontFamily: FontFamily.kLeagueSpartanFont),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            VerticalMeasurementBlock(value: '75 KG',measurement: 'weight',),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.1,
            ),
            VerticalMeasurementBlock(value: '75 KG',measurement: 'weight',)
          ],
        )
      ],
    );
  }
}
