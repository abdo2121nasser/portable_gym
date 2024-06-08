import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portable_gym/resourses/blocks/general_button_block.dart';
import 'package:portable_gym/resourses/blocks/general_text_form_field.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/font_manager.dart';
import 'package:portable_gym/resourses/managers_files/style_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:portable_gym/screens/set_up_screens/gender_screen.dart';

import '../../generated/l10n.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,

      //backgroundColor: ColorManager.kBlackColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_left,
            color: ColorManager.kLimeGreenColor,
          ),
        ),
        centerTitle: true,
        title: Text(
          S.of(context).createAccount,
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
          Text( S.of(context).letsStart,
              style: getBoldStyle(
                  fontSize: FontSize.s20,
                  color: ColorManager.kWhiteColor,
                  fontFamily: FontFamily.kPoppinsFont)),
          Container(
            width: MediaQuery.of(context).size.width,
           // height: AppVerticalSize.s394,
            color: ColorManager.kLightPurpleColor,
            padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s20,vertical: AppVerticalSize.s5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).fullName,
                    style: getSemiBoldStyle(
                        fontSize: FontSize.s16,
                        color: ColorManager.kBlackColor,
                        fontFamily: FontFamily.kPoppinsFont)),
                GeneralTextFormField(),
                SizedBox(
                  height: AppVerticalSize.s14,
                ),
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

                Text(S.of(context).confirmPassword,
                    style: getSemiBoldStyle(
                        fontSize: FontSize.s16,
                        color: ColorManager.kBlackColor,
                        fontFamily: FontFamily.kPoppinsFont)),
                GeneralTextFormField(),
                SizedBox(
                  height: AppVerticalSize.s14,
                ),

                // Text('Welcome',
                //     style: getBoldStyle(fontSize: FontSize.s20, color: ColorManager.kWhiteColor, fontFamily: FontFamily.kPoppinsFont)),
              ],
            ),
          ),

          GeneralButtonBlock(
            lable: S.of(context).signUp,
            width: AppHorizontalSize.s178,
            hight: AppVerticalSize.s44,
            function: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => GenderScreen(),));
            },
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
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Text(' ${S.of(context).login} ',
                    style: getLightStyle(
                        fontSize: FontSize.s12,
                        color: ColorManager.kLimeGreenColor,
                        fontFamily: FontFamily.kPoppinsFont)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
