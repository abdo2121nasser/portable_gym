import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/auth_cubit/authentication_cubit.dart';
import 'package:portable_gym/cubits/set_up_cubit/set_up_cubit.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/general_app_bar_block.dart';

import '../generated/l10n.dart';
import '../resourses/blocks/general_blocks/general_button_block.dart';
import '../resourses/managers_files/color_manager.dart';
import '../resourses/managers_files/font_manager.dart';
import '../resourses/managers_files/style_manager.dart';
import '../resourses/managers_files/values_manager.dart';

class SetUpScreen extends StatelessWidget {
  final String email;
  final bool isAdmin;

  const SetUpScreen({super.key, required this.email,required this.isAdmin});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SetUpCubit(email: email,isAdmin: isAdmin),
      child: BlocConsumer<SetUpCubit, SetUpState>(
        listener: (context, state) {},
        builder: (context, state) {
          var setCubit = SetUpCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            //backgroundColor: ColorManager.kBlackColor,
            appBar: GeneralAppBarBlock(
              title: S.of(context).back,
              titleFunction: () {
                setCubit.setUpBackWardNavigation(context: context);
              },
            ),

            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(setCubit.getTitle(context: context),
                    style: getBoldStyle(
                        fontSize: FontSize.s24,
                        color: ColorManager.kWhiteColor,
                        fontFamily: FontFamily.kPoppinsFont)),
                // Text(
                //   S.of(context).welcomeDescription,
                //   style: getLightStyle(
                //       fontSize: FontSize.s14,
                //       color: ColorManager.kWhiteColor,
                //       fontFamily: FontFamily.kLeagueSpartanFont),
                //   textAlign: TextAlign.center,
                // ),
                SizedBox(width: MediaQuery.of(context).size.width,),

                setCubit.getPageBody(setUpCubit: setCubit)[setCubit.currentPageBodyIndex],
                    state is CreateProfileLoadingState? const CircularProgressIndicator(color: ColorManager.kLightPurpleColor,):
                GeneralButtonBlock(
                  lable: setCubit.getButtonText(context: context),
                  function: () {
                    setCubit.setUpForwardNavigation(context: context);
                  },
                  backgroundColor: setCubit.getButtonColor(context: context),
                  textStyle: getMediumStyle(
                      fontSize: FontSize.s24,
                      color: setCubit.getTextColor(context: context),
                      fontFamily: FontFamily.kLeagueSpartanFont),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
