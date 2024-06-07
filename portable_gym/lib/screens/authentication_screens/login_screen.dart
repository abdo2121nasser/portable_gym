import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/blocks/general_button_block.dart';
import 'package:portable_gym/resourses/blocks/general_text_form_field.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/font_manager.dart';
import 'package:portable_gym/resourses/managers_files/style_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../generated/l10n.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: ColorManager.kBlackColor,
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_left,
          color: ColorManager.kLimeGreenColor,
        ),
        centerTitle: true,
        title: Text(
          S.of(context).loginWord,
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
          Text( S.of(context).loginWelcome,
              style: getBoldStyle(
                  fontSize: FontSize.s20,
                  color: ColorManager.kWhiteColor,
                  fontFamily: FontFamily.kPoppinsFont)),
          Text(
          S.of(context).loginWelcomeDescription,
              style: getLightStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.kWhiteColor,
                  fontFamily: FontFamily.kPoppinsFont),
          textAlign: TextAlign.center,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: AppVerticalSize.s253,
            color: ColorManager.kLightPurpleColor,
            padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).loginUserNameOrPassword,
                    style: getSemiBoldStyle(
                        fontSize: FontSize.s16,
                        color: ColorManager.kBlackColor,
                        fontFamily: FontFamily.kPoppinsFont)),
                GeneralTextFormField(),
                Text(S.of(context).loginPassword,
                    style: getSemiBoldStyle(
                        fontSize: FontSize.s16,
                        color: ColorManager.kBlackColor,
                        fontFamily: FontFamily.kPoppinsFont)),
                GeneralTextFormField(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(S.of(context).loginForgetPassword,
                        style: getMeduimStyle(
                            fontSize: FontSize.s12,
                            color: ColorManager.kBlackColor,
                            fontFamily: FontFamily.kPoppinsFont)),
                  ],
                )
                // Text('Welcome',
                //     style: getBoldStyle(fontSize: FontSize.s20, color: ColorManager.kWhiteColor, fontFamily: FontFamily.kPoppinsFont)),
              ],
            ),
          ),
          GeneralButtonBlock(
            lable: S.of(context).loginWord,
            width: AppHorizontalSize.s178,
            hight: AppVerticalSize.s44,
            function: () {},
            backgroundColor: ColorManager.kBlackColor,
            textStyle: getBoldStyle(fontSize:FontSize.s18, color: ColorManager.kWhiteColor, fontFamily: FontFamily.kPoppinsFont),
          ),
          Text( S.of(context).loginOtherOptions,
              style: getLightStyle(
                  fontSize: FontSize.s12,
                  color: ColorManager.kWhiteColor,
                  fontFamily: FontFamily.kPoppinsFont)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(S.of(context).loginSignUpOption,
                  style: getLightStyle(
                      fontSize: FontSize.s12,
                      color: ColorManager.kWhiteColor,
                      fontFamily: FontFamily.kPoppinsFont)),
              Text(' ${S.of(context).signUpWord} ',
                  style: getLightStyle(
                      fontSize: FontSize.s12,
                      color: ColorManager.kLimeGreenColor,
                      fontFamily: FontFamily.kPoppinsFont)),
            ],
          ),
        ],
      ),
    );
  }
}
