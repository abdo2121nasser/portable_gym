import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:horizontal_picker/horizontal_picker.dart';
import 'package:portable_gym/resourses/managers_files/image_manager.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/age_picker_block.dart';
import '../../resourses/blocks/general_button_block.dart';
import '../../resourses/blocks/general_text_form_field.dart';
import '../../resourses/managers_files/color_manager.dart';
import '../../resourses/managers_files/font_manager.dart';
import '../../resourses/managers_files/style_manager.dart';
import '../../resourses/managers_files/values_manager.dart';

class AgeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //backgroundColor: ColorManager.kBlackColor,
      appBar: AppBar(
        leadingWidth: AppHorizontalSize.s100,
        leading: Row(
          children: [
            const Icon(
              Icons.arrow_left,
              color: ColorManager.kLimeGreenColor,
            ),
            Text(
              S.of(context).back,
              style: getSemiBoldStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.kLimeGreenColor,
                  fontFamily: FontFamily.kPoppinsFont),
            ),

          ],
        ),
        elevation: 0,
        backgroundColor: ColorManager.kBlackColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(S.of(context).howOldAreYou,
              style: getBoldStyle(
                  fontSize: FontSize.s20,
                  color: ColorManager.kWhiteColor,
                  fontFamily: FontFamily.kPoppinsFont)),

          Text(
            S.of(context).welcomeDescription,
            style: getLightStyle(
                fontSize: FontSize.s14,
                color: ColorManager.kWhiteColor,
                fontFamily: FontFamily.kLeagueSpartanFont),
            textAlign: TextAlign.center,
          ),

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

          AgePickerBlock(),

          GeneralButtonBlock(
            lable: S.of(context).continued,
            function: () {},
            backgroundColor: ColorManager.kBlackColor,
            textStyle: getBoldStyle(
                fontSize: FontSize.s18,
                color: ColorManager.kWhiteColor,
                fontFamily: FontFamily.kPoppinsFont),
          ),
        ],
      ),
    );
  }
}

