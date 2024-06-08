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
      resizeToAvoidBottomInset : false,

      //backgroundColor: ColorManager.kBlackColor,
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_left,
          color: ColorManager.kLimeGreenColor,
        ),
        centerTitle: true,
        title: Text(
          S.of(context).login,
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
          Text( S.of(context).welcome,
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
                Text(S.of(context).email,
                    style: getSemiBoldStyle(
                        fontSize: FontSize.s16,
                        color: ColorManager.kBlackColor,
                        fontFamily: FontFamily.kPoppinsFont)),
                GeneralTextFormField(),
                SizedBox(
                  height: AppVerticalSize.s14,
                ),

                Text(S.of(context).password,
                    style: getSemiBoldStyle(
                        fontSize: FontSize.s16,
                        color: ColorManager.kBlackColor,
                        fontFamily: FontFamily.kPoppinsFont)),
                GeneralTextFormField(),
                SizedBox(
                  height: AppVerticalSize.s14,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(S.of(context).forgetPassword,
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
            lable: S.of(context).login,
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
              Text(' ${S.of(context).signUp} ',
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
