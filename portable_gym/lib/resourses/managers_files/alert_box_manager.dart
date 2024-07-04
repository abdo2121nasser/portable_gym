import 'dart:io';
import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:portable_gym/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/full_input_block.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/general_button_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/font_manager.dart';
import 'package:portable_gym/resourses/managers_files/style_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:video_player/video_player.dart';

import '../../generated/l10n.dart';
import '../blocks/home_screen_blocks/work_out_block/period_picker_block.dart';
import '../blocks/home_screen_blocks/work_out_block/video_show_block.dart';



showAlertBodyCategoryBox(
    {required context,
      required TabBar tabBar,
      required TabBarView tabBarView,
      required VoidCallback buttonFunction,
      required String title,
      required String buttonLable,
    }

    ) {
  return showDialog(
    context: context,
    builder: (context) => DefaultTabController(
      length: 2,
      child: AlertDialog(
        // insetPadding: EdgeInsets.symmetric(
        //     horizontal: AppHorizontalSize.s22, vertical: AppVerticalSize.s55),
        backgroundColor: Colors.white,
        //titlePadding:const EdgeInsets.only(top: ,left: 80,bottom: 10),
        title: Text(
          title,
          style: getBoldStyle(
              fontSize: FontSize.s20,
              color: ColorManager.kBlackColor,
              fontFamily: FontFamily.kLeagueSpartanFont),
          textAlign: TextAlign.center,
        ),
        alignment: Alignment.center,
        scrollable: true,
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              tabBar,
              SizedBox(
                height: AppVerticalSize.s650,
                child: Column(
                  children: [
                    SizedBox(
                      height: AppVerticalSize.s10,
                    ),
                    Expanded(child: tabBarView),
                    PeriodPickerBlock(isTrainingDate: false,),
                    GeneralButtonBlock(
                        lable: buttonLable,
                        function: buttonFunction,
                        backgroundColor: ColorManager.kLightPurpleColor,
                        textStyle: getSemiBoldStyle(
                            fontSize: FontSize.s20,
                            color: ColorManager.kBlackColor,
                            fontFamily: FontFamily.kLeagueSpartanFont))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}



showAlertTrainingBox(
    {required context,
    required TabBar tabBar,
    required TabBarView tabBarView,
    required DateTime trainingPeriod,
      required VoidCallback buttonFunction,
      required String title,
      required String buttonLable,
    }

    ) {
  return showDialog(
    context: context,
    builder: (context) => DefaultTabController(
      length: 2,
      child: AlertDialog(
        insetPadding: EdgeInsets.symmetric(
            horizontal: AppHorizontalSize.s22, vertical: AppVerticalSize.s55),
        backgroundColor: Colors.white,
        //titlePadding:const EdgeInsets.only(top: ,left: 80,bottom: 10),
        title: Text(
          title,
          style: getBoldStyle(
              fontSize: FontSize.s20,
              color: ColorManager.kBlackColor,
              fontFamily: FontFamily.kLeagueSpartanFont),
          textAlign: TextAlign.center,
        ),
        alignment: Alignment.center,
        scrollable: true,
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              tabBar,
              SizedBox(
                height: AppVerticalSize.s650,
                child: Column(
                  children: [
                    SizedBox(
                      height: AppVerticalSize.s10,
                    ),
                    Expanded(child: tabBarView),
                    PeriodPickerBlock(),
                    GeneralButtonBlock(
                        lable:buttonLable,
                        function: buttonFunction,
                        backgroundColor: ColorManager.kLightPurpleColor,
                        textStyle: getSemiBoldStyle(
                            fontSize: FontSize.s20,
                            color: ColorManager.kBlackColor,
                            fontFamily: FontFamily.kLeagueSpartanFont))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


