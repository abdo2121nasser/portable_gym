import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:my_coach/cubits/auth_cubit/authentication_cubit.dart';
import 'package:my_coach/resourses/blocks/general_blocks/check_box_block.dart';
import 'package:my_coach/resourses/blocks/general_blocks/general_app_bar_block.dart';
import 'package:my_coach/resourses/managers_files/color_manager.dart';
import 'package:my_coach/resourses/managers_files/font_manager.dart';
import 'package:my_coach/resourses/managers_files/style_manager.dart';
import 'package:my_coach/resourses/managers_files/values_manager.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/general_blocks/full_input_block.dart';
import '../../resourses/blocks/general_blocks/general_button_block.dart';

class SignUpScreen extends StatelessWidget {
  final AuthenticationCubit authCubit;
  const SignUpScreen({super.key, required this.authCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: authCubit,
      child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,

            //backgroundColor: ColorManager.kBlackColor,
            appBar: GeneralAppBarBlock(
              title: S.of(context).signUp,
              centerTitle: true,
              titleColor: ColorManager.kLimeGreenColor,
              haveReturnArrow: false,
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
                  color: ColorManager.kLightPurpleColor,
                  padding: EdgeInsets.symmetric(
                      horizontal: AppHorizontalSize.s20,
                      vertical: AppVerticalSize.s5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: AppVerticalSize.s14,
                      ),
                      FullInputBlock(
                        lable: S.of(context).email,
                        color: ColorManager.kBlackColor,
                        controller: authCubit.registerEmail,
                        isNormalInput: true,
                      ),
                      SizedBox(
                        height: AppVerticalSize.s14,
                      ),
                      FullInputBlock(
                        lable: S.of(context).password,
                        color: ColorManager.kBlackColor,
                        controller: authCubit.registerPassword,
                        suffixIcon: Icon(authCubit.isVisibleRegisterPassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        suffixIconFunction: () {
                          authCubit.changePasswordVisibility(
                              passwordLable: 'register password');
                        },
                        isVisible: authCubit.isVisibleRegisterPassword,
                        isNormalInput: true,
                      ),
                      SizedBox(
                        height: AppVerticalSize.s14,
                      ),
                      FullInputBlock(
                        lable: S.of(context).confirmPassword,
                        color: ColorManager.kBlackColor,
                        controller: authCubit.registerConfirmPassword,
                        suffixIcon: Icon(
                            authCubit.isVisibleRegisterConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                        suffixIconFunction: () {
                          authCubit.changePasswordVisibility(
                              passwordLable: 'register confirm password');
                        },
                        isVisible: authCubit.isVisibleRegisterConfirmPassword,
                        isNormalInput: true,
                      ),
                      SizedBox(
                        height: AppVerticalSize.s14,
                      ),
                      SizedBox(
                        height: AppVerticalSize.s35,
                        child: CheckBoxBlock(
                            value: authCubit.isAdmin,
                            lable: S.of(context).admin,
                            checkBoxFunction: (x) {
                              authCubit.changeIsAdminValue();
                            },
                            isArabic:
                                Get.locale!.languageCode.toString() == 'ar',
                            textStyle: getBoldStyle(
                              fontSize: FontSize.s14,
                              color: ColorManager.kBlackColor,
                              fontFamily: FontFamily.kLeagueSpartanFont,
                            )),
                      ),
                      if (authCubit.isAdmin)
                        FullInputBlock(
                          lable: S.of(context).registrationCode,
                          color: ColorManager.kBlackColor,
                          controller: authCubit.registrationCodeController,
                          isNormalInput: true,
                        ),
                      if (authCubit.isAdmin)
                        SizedBox(
                          height: AppVerticalSize.s14,
                        ),
                    ],
                  ),
                ),
                state is RegisterLoadingState ||
                        state is EmailVerificationLoadingState
                    ? const CircularProgressIndicator()
                    : GeneralButtonBlock(
                        lable: S.of(context).signUp,
                        width: AppHorizontalSize.s178,
                        hight: AppVerticalSize.s44,
                        function: () {
                          authCubit.registerProcess(context: context);
                          //  Get.to(SetUpScreen());
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
                state is RegisterLoadingState
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
                              Get.back();
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
      ),
    );
  }
}
