import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/auth_cubit/authentication_cubit.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/general_app_bar_block.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/general_blocks/full_input_block.dart';
import '../../resourses/blocks/general_blocks/general_button_block.dart';
import '../../resourses/managers_files/color_manager.dart';
import '../../resourses/managers_files/font_manager.dart';
import '../../resourses/managers_files/style_manager.dart';
import '../../resourses/managers_files/values_manager.dart';

class ForgetPasswordScreen extends StatelessWidget {

  const ForgetPasswordScreen({super.key, });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {},
      builder: (context, state) {
          var authCubit = AuthenticationCubit.get(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          //backgroundColor: ColorManager.kBlackColor,
          appBar: GeneralAppBarBlock(
            title: S.of(context).forgottenPassword,
            titleColor: ColorManager.kLimeGreenColor,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(S.of(context).forgetPassword,
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
                      lable: S.of(context).enterYourEmail,
                      color: ColorManager.kBlackColor,
                      controller: authCubit.forgetPasswordEmail,
                    ),

                    SizedBox(
                      height: AppVerticalSize.s30,
                    ),


                    // Text('Welcome',
                    //     style: getBoldStyle(fontSize: FontSize.s20, color: ColorManager.kWhiteColor, fontFamily: FontFamily.kPoppinsFont)),
                  ],
                ),
              ),
            state is ForgetPasswordLoadingState?const CircularProgressIndicator():
              GeneralButtonBlock(
                lable: S.of(context).resetPassword,
                function: () {
                  authCubit.forgetPasswordPreprocess(context: context);
                },
                backgroundColor: ColorManager.kBlackColor,
                textStyle: getBoldStyle(
                    fontSize: FontSize.s18,
                    color: ColorManager.kWhiteColor,
                    fontFamily: FontFamily.kPoppinsFont),
              ),
            ],
          ),
        );
      },
    );
  }
}
