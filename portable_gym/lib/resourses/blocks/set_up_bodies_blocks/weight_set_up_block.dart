import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../managers_files/color_manager.dart';
import '../../managers_files/font_manager.dart';
import '../../managers_files/image_manager.dart';
import '../../managers_files/style_manager.dart';
import '../../managers_files/values_manager.dart';
import '../age_picker_block.dart';
import '../gender_block.dart';
import '../general_text_form_field.dart';

class WeightSetUpBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   Container(
      width: MediaQuery.of(context).size.width,
      //   height: AppVerticalSize.s253,
      color: ColorManager.kLightPurpleColor,
      padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s20,vertical: AppVerticalSize.s5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(S.of(context).enterYourWeight,
              style: getSemiBoldStyle(
                  fontSize: FontSize.s16,
                  color: ColorManager.kBlackColor,
                  fontFamily: FontFamily.kPoppinsFont)),
          SizedBox(
            height: AppVerticalSize.s5,
          ),

          GeneralTextFormField(onlyInteger: true,),
          SizedBox(
            height: AppVerticalSize.s14,
          ),
        ],
    )
    );
  }
}
