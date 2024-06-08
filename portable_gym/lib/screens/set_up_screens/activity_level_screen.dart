import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portable_gym/resourses/blocks/weight_ruler_block.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import '../../generated/l10n.dart';
import '../../resourses/blocks/age_picker_block.dart';
import '../../resourses/blocks/general_button_block.dart';
import '../../resourses/blocks/general_text_form_field.dart';
import '../../resourses/blocks/goal_choice_block.dart';
import '../../resourses/blocks/levels_block.dart';
import '../../resourses/blocks/weight_type_block.dart';
import '../../resourses/managers_files/color_manager.dart';
import '../../resourses/managers_files/font_manager.dart';
import '../../resourses/managers_files/style_manager.dart';
import '../../resourses/managers_files/values_manager.dart';

class ActivityLevelScreen extends StatelessWidget {
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
          Text(S.of(context).physicalActivityLevel,
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
          SizedBox(
            height: AppVerticalSize.s253,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s20),
                itemBuilder: (context, index) => LevelsBlock(),
                separatorBuilder: (context, index) => SizedBox(height: AppVerticalSize.s22,),
                itemCount: 3),
          ),
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
