import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/general_button_block.dart';
import '../../resourses/blocks/general_text_form_field.dart';
import '../../resourses/managers_files/color_manager.dart';
import '../../resourses/managers_files/font_manager.dart';
import '../../resourses/managers_files/style_manager.dart';
import '../../resourses/managers_files/values_manager.dart';




class ForgetPasswordScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      //backgroundColor: ColorManager.kBlackColor,
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_left,
          color: ColorManager.kLimeGreenColor,
        ),
        centerTitle: true,
        title: Text(
          S.of(context).forgottenPassword,
          style: getBoldStyle(
              fontSize: FontSize.s20,
              color: ColorManager.kLimeGreenColor,
              fontFamily: FontFamily.kPoppinsFont),
        ),
        elevation: 0,
        backgroundColor: ColorManager.kBlackColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text( S.of(context).forgetPassword,
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
          Container(
            width: MediaQuery.of(context).size.width,
            //   height: AppVerticalSize.s253,
            color: ColorManager.kLightPurpleColor,
            padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s20,vertical: AppVerticalSize.s5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).enterYourEmail,
                    style: getSemiBoldStyle(
                        fontSize: FontSize.s16,
                        color: ColorManager.kBlackColor,
                        fontFamily: FontFamily.kPoppinsFont)),
                GeneralTextFormField(),
                SizedBox(
                  height: AppVerticalSize.s14,
                ),

                SizedBox(
                  height: AppVerticalSize.s14,
                ),
                // Text('Welcome',
                //     style: getBoldStyle(fontSize: FontSize.s20, color: ColorManager.kWhiteColor, fontFamily: FontFamily.kPoppinsFont)),
              ],
            ),
          ),
          GeneralButtonBlock(
            lable: S.of(context).resetPassword,
            function: () {},
            backgroundColor: ColorManager.kBlackColor,
            textStyle: getBoldStyle(fontSize:FontSize.s18, color: ColorManager.kWhiteColor, fontFamily: FontFamily.kPoppinsFont),
          ),

        ],
      ),
    );
  }
}
