import 'package:flutter/material.dart';

import '../../managers_files/color_manager.dart';
import '../../managers_files/font_manager.dart';
import '../../managers_files/image_manager.dart';
import '../../managers_files/style_manager.dart';
import '../../managers_files/values_manager.dart';
import '../age_picker_block.dart';
import '../gender_block.dart';





class AgeSetUpBlock extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
          child:
Column(
  children: [
    Column(
      children: [
        Text(
          '16',
          style: getBoldStyle(
              fontSize: FontSize.s64,
              color: ColorManager.kWhiteColor,
              fontFamily: FontFamily.kPoppinsFont),
          textAlign: TextAlign.center,
        ),
        Icon(
          Icons.arrow_drop_up_rounded,
          color: ColorManager.kLimeGreenColor,
          size: AppVerticalSize.s120,
        ),
      ],
    ),

    const AgePickerBlock(),
  ],
)
      ) ;
  }
}
