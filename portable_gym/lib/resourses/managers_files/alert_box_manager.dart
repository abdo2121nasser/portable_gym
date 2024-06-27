import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/full_input_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:portable_gym/resourses/managers_files/font_manager.dart';
import 'package:portable_gym/resourses/managers_files/style_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

showAlertBox({required context,required TabBar tabBar,required TabBarView tabBarVeiw}) {
  return showDialog(
    context: context,
    builder: (context) =>  DefaultTabController(
      length: 2,
      child: AlertDialog(
          insetPadding:  EdgeInsets.symmetric(horizontal:AppHorizontalSize.s22),
          backgroundColor: Colors.white,
          //titlePadding:const EdgeInsets.only(top: ,left: 80,bottom: 10),
          title: Text('add new tainning',
              style: getBoldStyle(
                  fontSize: FontSize.s20,
                  color: ColorManager.kBlackColor,
                  fontFamily: FontFamily.kLeagueSpartanFont),
          textAlign: TextAlign.center,),
          alignment: Alignment.center,
          scrollable: true,
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              tabBar,
              SizedBox(
               height: MediaQuery.of(context).size.height*0.57,
                child: Column(
                  children: [
                    SizedBox(height: AppVerticalSize.s10,),
                    Expanded(child: tabBarVeiw),
                    SizedBox(height: AppVerticalSize.s5,),
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
