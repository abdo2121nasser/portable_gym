import 'package:flutter/material.dart';

import '../../../managers_files/color_manager.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';
import '../../../managers_files/values_manager.dart';


class VerticalMeasurementBlock extends StatelessWidget {
    final String value;
    final String measurement;
    VerticalMeasurementBlock({required this.value,required this.measurement});

    @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width:AppHorizontalSize.s10,
            height: AppVerticalSize.s50,
            child: LinearProgressIndicator(color: ColorManager.kLimeGreenColor,value: 100,borderRadius: BorderRadius.circular(AppRadiusSize.s22),)),
        SizedBox(
          width: AppHorizontalSize.s5,
        ),
        Column(
          children: [
            Text(
              value,
              style: getSemiBoldStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.kWhiteColor,
                  fontFamily: FontFamily.kLeagueSpartanFont),
            ),
            Text(
              measurement,
              style: getLightStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.kWhiteColor,
                  fontFamily: FontFamily.kLeagueSpartanFont),
            ),

          ],
        )
      ],
    );
  }

}
