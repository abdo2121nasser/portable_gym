import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/blocks/general_button_block.dart';
import 'package:portable_gym/resourses/blocks/general_text_form_field.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/font_manager.dart';
import 'package:portable_gym/resourses/managers_files/style_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: ColorManager.kBlackColor,
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_left,
          color: ColorManager.kLimeGreenColor,
        ),
        centerTitle: true,
        title: Text(
          'Login',
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
          Text('Welcome',
              style: getBoldStyle(
                  fontSize: FontSize.s20,
                  color: ColorManager.kWhiteColor,
                  fontFamily: FontFamily.kPoppinsFont)),
          Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
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
                Text('Username or email',
                    style: getSemiBoldStyle(
                        fontSize: FontSize.s16,
                        color: ColorManager.kBlackColor,
                        fontFamily: FontFamily.kPoppinsFont)),
                GeneralTextFormField(),
                Text('Password',
                    style: getSemiBoldStyle(
                        fontSize: FontSize.s16,
                        color: ColorManager.kBlackColor,
                        fontFamily: FontFamily.kPoppinsFont)),
                GeneralTextFormField(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Forger Password ?',
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
            lable: 'Login',
            width: AppHorizontalSize.s178,
            hight: AppVerticalSize.s44,
            function: () {},
            backgroundColor: ColorManager.kBlackColor,
            textStyle: getBoldStyle(fontSize:FontSize.s18, color: ColorManager.kWhiteColor, fontFamily: FontFamily.kPoppinsFont),
          ),
          Text('or sign up with',
              style: getLightStyle(
                  fontSize: FontSize.s12,
                  color: ColorManager.kWhiteColor,
                  fontFamily: FontFamily.kPoppinsFont)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Don’t have an account?',
                  style: getLightStyle(
                      fontSize: FontSize.s12,
                      color: ColorManager.kWhiteColor,
                      fontFamily: FontFamily.kPoppinsFont)),
              Text(' Sign Up',
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
