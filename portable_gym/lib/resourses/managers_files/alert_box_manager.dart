
import 'package:flutter/material.dart';
import 'package:portable_gym/cubits/work_out_cubit/work_out_cubit.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/general_button_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/font_manager.dart';
import 'package:portable_gym/resourses/managers_files/style_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../blocks/home_screen_blocks/work_out_block/period_picker_block.dart';

class AlertBodyCategoryBox extends StatelessWidget {
  final WorkOutCubit workOutCubit;
  final TabBar tabBar;
  final TabBarView tabBarView;
  final VoidCallback buttonFunction;
  final String title;
  final String buttonLable;
  const AlertBodyCategoryBox({super.key,
    required context,
    required this.workOutCubit,
    required this.tabBar,
    required this.tabBarView,
    required this.buttonFunction,
    required this.title,
    required this.buttonLable,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DefaultTabController(
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
          content: SizedBox(
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
                      PeriodPickerBlock(
                        isTrainingDate: false,
                        workCubit: workOutCubit,
                      ),
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
}

class AlertTrainingBox extends StatelessWidget {
  final WorkOutCubit workOutCubit;
  final TabBar tabBar;
  final TabBarView tabBarView;
  final DateTime trainingPeriod;
  final VoidCallback buttonFunction;
  final String title;
  final String buttonLable;
  const AlertTrainingBox({super.key,
    required context,
    required this.workOutCubit,
    required this.tabBar,
    required this.tabBarView,
    required this.trainingPeriod,
    required this.buttonFunction,
    required this.title,
    required this.buttonLable,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DefaultTabController(
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
          content: SizedBox(
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
                      PeriodPickerBlock(workCubit: workOutCubit),
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
}

class AlertRecipeBox extends StatelessWidget {
  final TabBar tabBar;
  final TabBarView tabBarView;
  final VoidCallback buttonFunction;
  final String title;
  final String buttonLable;
  const AlertRecipeBox({super.key,
    required context,
    required this.tabBar,
    required this.tabBarView,
    required this.buttonFunction,
    required this.title,
    required this.buttonLable,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DefaultTabController(
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
          
          content: SizedBox(
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
}

class AlertFoodMainElementBox extends StatelessWidget {
  final TabBar tabBar;
  final TabBarView tabBarView;
  final VoidCallback buttonFunction;
  final String title;
  final String buttonLable;
  const AlertFoodMainElementBox({super.key,
    required context,
    required this.tabBar,
    required this.tabBarView,
    required this.buttonFunction,
    required this.title,
    required this.buttonLable,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DefaultTabController(
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
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                tabBar,
                SizedBox(
                  height: AppVerticalSize.s265,
                  child: Column(
                    children: [
                      SizedBox(
                        height: AppVerticalSize.s10,
                      ),
                      Expanded(child: tabBarView),
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
}

showAlertBodyCategoryBox({
  required context,
  required WorkOutCubit workOutCubit,
  required TabBar tabBar,
  required TabBarView tabBarView,
  required VoidCallback buttonFunction,
  required String title,
  required String buttonLable,
}) {
  return showDialog(
      context: context,
      builder: (context) => AlertBodyCategoryBox(
            context: context,
            workOutCubit: workOutCubit,
            tabBar: tabBar,
            tabBarView: tabBarView,
            buttonFunction: buttonFunction,
            title: title,
            buttonLable: buttonLable,
          ));
}

showAlertTrainingBox({
  required context,
  required WorkOutCubit workOutCubit,
  required TabBar tabBar,
  required TabBarView tabBarView,
  required DateTime trainingPeriod,
  required VoidCallback buttonFunction,
  required String title,
  required String buttonLable,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertTrainingBox(
      context: context,
      workOutCubit: workOutCubit,
      tabBar: tabBar,
      tabBarView: tabBarView,
      buttonFunction: buttonFunction,
      title: title,
      buttonLable: buttonLable,
      trainingPeriod: trainingPeriod,
    ),
  );
}

showAlertRecipeBox({
  required context,
  required TabBar tabBar,
  required TabBarView tabBarView,
  required VoidCallback buttonFunction,
  required String title,
  required String buttonLable,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertRecipeBox(
        context: context,
        tabBar: tabBar,
        tabBarView: tabBarView,
        buttonFunction: buttonFunction,
        title: title,
        buttonLable: buttonLable),
  );
}
showAlertFoodMainElementBox({
  required context,
  required TabBar tabBar,
  required TabBarView tabBarView,
  required VoidCallback buttonFunction,
  required String title,
  required String buttonLable,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertFoodMainElementBox(
        context: context,
        tabBar: tabBar,
        tabBarView: tabBarView,
        buttonFunction: buttonFunction,
        title: title,
        buttonLable: buttonLable),
  );
}
