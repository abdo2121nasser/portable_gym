import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:portable_gym/cubits/auth_cubit/authentication_cubit.dart';
import 'package:portable_gym/cubits/auth_cubit/authentication_cubit.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/general_text_form_field.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/font_manager.dart';
import 'package:portable_gym/resourses/managers_files/style_manager.dart';
import 'package:portable_gym/resourses/managers_files/toast_messege_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:portable_gym/screens/authentication_screens/forget_password.dart';
import 'package:portable_gym/screens/authentication_screens/sign_up_screen.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/general_blocks/full_input_block.dart';
import '../../resourses/blocks/general_blocks/general_button_block.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var authCubit = AuthenticationCubit.get(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,

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
              Text(S.of(context).welcome,
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
                padding: EdgeInsets.symmetric(
                    horizontal: AppHorizontalSize.s20,
                    vertical: AppVerticalSize.s5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FullInputBlock(
                      lable: S.of(context).email,
                      color: ColorManager.kBlackColor,
                      controller: authCubit.loginEmail,
                    ),
                    SizedBox(
                      height: AppVerticalSize.s14,
                    ),

                    FullInputBlock(
                      lable: S.of(context).password,
                      color: ColorManager.kBlackColor,
                      controller: authCubit.loginPassword,
                    ),

                    SizedBox(
                      height: AppVerticalSize.s14,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgetPasswordScreen(),
                                ));
                          },
                          child: Text(S.of(context).forgetPassword,
                              style: getMeduimStyle(
                                  fontSize: FontSize.s12,
                                  color: ColorManager.kBlackColor,
                                  fontFamily: FontFamily.kPoppinsFont)),
                        ),
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
                backgroundColor: ColorManager.kBlackColor,
                textStyle: getBoldStyle(
                    fontSize: FontSize.s18,
                    color: ColorManager.kWhiteColor,
                    fontFamily: FontFamily.kPoppinsFont),
                function: () {
                  authCubit.loginPreprocess(context: context);
                },
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ));
                    },
                    child: Text(' ${S.of(context).signUp} ',
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
