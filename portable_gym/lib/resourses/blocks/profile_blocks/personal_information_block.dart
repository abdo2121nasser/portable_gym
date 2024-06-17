import 'package:flutter/material.dart';

import '../../managers_files/color_manager.dart';
import '../../managers_files/font_manager.dart';
import '../../managers_files/style_manager.dart';



class PersonalInformationBlock extends StatelessWidget {
  const PersonalInformationBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Madison Smith',
          style: getBoldStyle(
              fontSize: FontSize.s20,
              color: ColorManager.kWhiteColor,
              fontFamily: FontFamily.kPoppinsFont),
        ),
        Text(
          'madisons@example.com',
          style: getLightStyle(
              fontSize: FontSize.s14,
              color: ColorManager.kWhiteColor,
              fontFamily: FontFamily.kPoppinsFont),
        ),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text(
      'Birthday:',
      style: getSemiBoldStyle(
          fontSize: FontSize.s14,
          color: ColorManager.kWhiteColor,
          fontFamily: FontFamily.kPoppinsFont),
    ),
    Text(
      ' April 1st',
      style: getLightStyle(
          fontSize: FontSize.s14,
          color: ColorManager.kWhiteColor,
          fontFamily: FontFamily.kPoppinsFont),
    ),

  ],
)
      ],
    );
  }
}
