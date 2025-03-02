import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:my_coach/cubits/auth_cubit/authentication_cubit.dart';
import 'package:my_coach/resourses/blocks/general_blocks/general_app_bar_block.dart';
import 'package:my_coach/resourses/managers_files/color_manager.dart';
import 'package:my_coach/resourses/managers_files/font_manager.dart';
import 'package:my_coach/resourses/managers_files/style_manager.dart';
import 'package:my_coach/resourses/managers_files/values_manager.dart';
import 'package:my_coach/screens/authentication_screens/forget_password_screen.dart';
import 'package:my_coach/screens/authentication_screens/sign_up_screen.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/general_blocks/full_input_block.dart';
import '../../resourses/blocks/general_blocks/general_button_block.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit(),
      child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {},
        builder: (context, state) {
          var authCubit = AuthenticationCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,

            //backgroundColor: ColorManager.kBlackColor,
            appBar: GeneralAppBarBlock(
              title: S.of(context).login,
              centerTitle: true,
              titleColor: ColorManager.kLimeGreenColor,
              haveReturnArrow: false,
            ),
            backgroundColor: ColorManager.kBlackColor,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(S.of(context).welcome,
                    style: getBoldStyle(
                        fontSize: FontSize.s20,
                        color: ColorManager.kWhiteColor,
                        fontFamily: FontFamily.kPoppinsFont)),
                // Flexible(
                //   child: Text(
                //     S.of(context).welcomeDescription,
                //     style: getLightStyle(
                //         fontSize: FontSize.s14,
                //         color: ColorManager.kWhiteColor,
                //         fontFamily: FontFamily.kLeagueSpartanFont),
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                Container(
                  width: MediaQuery.of(context).size.width,
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
                        isNormalInput: true,
                      ),
                      SizedBox(
                        height: AppVerticalSize.s14,
                      ),

                      FullInputBlock(
                        lable: S.of(context).password,
                        color: ColorManager.kBlackColor,
                        controller: authCubit.loginPassword,
                        suffixIcon: Icon(authCubit.isVisibleLoginPassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        suffixIconFunction: () {
                          authCubit.changePasswordVisibility(
                              passwordLable: 'login password');
                        },
                        isVisible: authCubit.isVisibleLoginPassword,
                        isNormalInput: true,
                      ),

                      SizedBox(
                        height: AppVerticalSize.s14,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(const ForgetPasswordScreen());
                            },
                            child: Text(S.of(context).forgetPassword,
                                style: getMediumStyle(
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
                state is LoginLoadingState ||
                        state is EmailVerificationLoadingState
                    ? const CircularProgressIndicator()
                    : GeneralButtonBlock(
                        lable: S.of(context).login,
                        width: AppHorizontalSize.s178,
                        hight: AppVerticalSize.s44,
                        backgroundColor: ColorManager.kBlackColor,
                        textStyle: getBoldStyle(
                            fontSize: FontSize.s18,
                            color: ColorManager.kWhiteColor,
                            fontFamily: FontFamily.kPoppinsFont),
                        function: () {
                          authCubit.loginProcess(context: context);
                        },
                      ),

                // Text(S.of(context).loginOtherOptions,
                //     style: getLightStyle(
                //         fontSize: FontSize.s12,
                //         color: ColorManager.kWhiteColor,
                //         fontFamily: FontFamily.kPoppinsFont)),
                state is LoginLoadingState
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(S.of(context).loginSignUpOption,
                              style: getLightStyle(
                                  fontSize: FontSize.s12,
                                  color: ColorManager.kWhiteColor,
                                  fontFamily: FontFamily.kPoppinsFont)),
                          GestureDetector(
                            onTap: () {
                              Get.to(SignUpScreen(authCubit: authCubit));
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
      ),
    );
  }
}
