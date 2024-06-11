import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:portable_gym/cubits/auth_cubit/authentication_cubit.dart';
import 'package:portable_gym/cubits/auth_cubit/authentication_cubit.dart';
import 'package:portable_gym/resourses/blocks/general_button_block.dart';
import 'package:portable_gym/resourses/blocks/general_text_form_field.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/font_manager.dart';
import 'package:portable_gym/resourses/managers_files/style_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../cubits/set_up_cubit/set_up_cubit.dart';
import '../../generated/l10n.dart';
import '../../resourses/blocks/full_input_block.dart';
import '../set_up_screen.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var authCubit = AuthenticationCubit.get(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,

      //backgroundColor: ColorManager.kBlackColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
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
          Text(S.of(context).letsStart,
              style: getBoldStyle(
                  fontSize: FontSize.s20,
                  color: ColorManager.kWhiteColor,
                  fontFamily: FontFamily.kPoppinsFont)),
          Container(
            width: MediaQuery.of(context).size.width,
            // height: AppVerticalSize.s394,
            color: ColorManager.kLightPurpleColor,
            padding: EdgeInsets.symmetric(
                horizontal: AppHorizontalSize.s20,
                vertical: AppVerticalSize.s5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FullInputBlock(
                  lable: S.of(context).fullName,
                  color: ColorManager.kBlackColor,
                  controller: authCubit.registerName,
                ),
                SizedBox(
                  height: AppVerticalSize.s14,
                ),
                FullInputBlock(
                  lable: S.of(context).email,
                  color: ColorManager.kBlackColor,
                  controller: authCubit.registerEmail,
                ),
                SizedBox(
                  height: AppVerticalSize.s14,
                ),
                FullInputBlock(
                  lable: S.of(context).password,
                  color: ColorManager.kBlackColor,
                  controller: authCubit.registerPassword,
                ),
                SizedBox(
                  height: AppVerticalSize.s14,
                ),
                FullInputBlock(
                  lable: S.of(context).confirmPassword,
                  color: ColorManager.kBlackColor,
                  controller: authCubit.registerConfirmPassword,
                ),
                SizedBox(
                  height: AppVerticalSize.s14,
                ),
              ],
            ),
          ),
          GeneralButtonBlock(
            lable: S.of(context).signUp,
            width: AppHorizontalSize.s178,
            hight: AppVerticalSize.s44,
            function: () {
              // authCubit.registerPreprocess(context: context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
  create: (context) => SetUpCubit(),
  child: SetUpScreen(),
),
                  ));
            },
            backgroundColor: ColorManager.kBlackColor,
            textStyle: getBoldStyle(
                fontSize: FontSize.s18,
                color: ColorManager.kWhiteColor,
                fontFamily: FontFamily.kPoppinsFont),
          ),
          // Text(S.of(context).loginOtherOptions,
          //     style: getLightStyle(
          //         fontSize: FontSize.s12,
          //         color: ColorManager.kWhiteColor,
          //         fontFamily: FontFamily.kPoppinsFont)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(S.of(context).loginSignUpOption,
                  style: getLightStyle(
                      fontSize: FontSize.s12,
                      color: ColorManager.kWhiteColor,
                      fontFamily: FontFamily.kPoppinsFont)),
              GestureDetector(
                onTap: () {
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
  },
);
  }
}
