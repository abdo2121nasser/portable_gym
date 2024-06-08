import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portable_gym/cubits/set_up_cubit/set_up_cubit.dart';

import '../../generated/l10n.dart';
import '../../resourses/blocks/general_button_block.dart';
import '../../resourses/managers_files/color_manager.dart';
import '../../resourses/managers_files/font_manager.dart';
import '../../resourses/managers_files/style_manager.dart';
import '../../resourses/managers_files/values_manager.dart';



class SetUpScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var setCubit= SetUpCubit.get(context);
    return BlocConsumer<SetUpCubit, SetUpState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        //backgroundColor: ColorManager.kBlackColor,
        appBar: AppBar(
          leadingWidth: AppHorizontalSize.s100,
          leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Row(
              children: [
                const Icon(
                  Icons.arrow_left,
                  color: ColorManager.kLimeGreenColor,
                ),
                Text(
                  S.of(context).back,
                  style: getSemiBoldStyle(
                      fontSize: FontSize.s14,
                      color: ColorManager.kLimeGreenColor,
                      fontFamily: FontFamily.kPoppinsFont),
                ),
              ],
            ),
          ),
          elevation: 0,
          backgroundColor: ColorManager.kBlackColor,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(S.of(context).fillYourProfile,
                style: getBoldStyle(
                    fontSize: FontSize.s24,
                    color: ColorManager.kWhiteColor,
                    fontFamily: FontFamily.kPoppinsFont)),
            //todo list of strings
            Text(
              S.of(context).welcomeDescription,
              style: getLightStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.kWhiteColor,
                  fontFamily: FontFamily.kLeagueSpartanFont),
              textAlign: TextAlign.center,
            ),

       setCubit.pageBody[0],


            GeneralButtonBlock(
              lable: S.of(context).start,
              function: () {},
              backgroundColor: ColorManager.kLimeGreenColor,
              textStyle: getMeduimStyle(
                  fontSize: FontSize.s24,
                  color: ColorManager.kBlackColor,
                  fontFamily: FontFamily.kLeagueSpartanFont),
            ),

          ],
        ),

      );
  },
);
  }
}
