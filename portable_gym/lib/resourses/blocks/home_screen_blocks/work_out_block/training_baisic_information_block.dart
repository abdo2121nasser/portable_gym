import 'package:flutter/material.dart';
import 'package:my_coach/resourses/managers_files/string_manager.dart';
import 'package:my_coach/resourses/managers_files/values_manager.dart';

import '../../../managers_files/color_manager.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';
import '../../general_blocks/check_box_block.dart';
import '../../general_blocks/full_input_block.dart';

class TrainingBaisicInformationBlock extends StatelessWidget {
  List<String> trainingLables;
  List<TextEditingController> trainingControllers;
  final bool isArabicTabView;
  final bool isPaidValue;
  final Function(bool?) isPaidSetter;
  TrainingBaisicInformationBlock(
      {required this.trainingLables, required this.trainingControllers,
        required this.isPaidValue,
        required this.isPaidSetter,
        this.isArabicTabView=false,});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
     // padding: EdgeInsets.only(bottom: AppVerticalSize.s10),
        shrinkWrap: true,
        itemBuilder: (context, index) =>index== trainingControllers.length?
            //handling the is paid condition lable
      CheckBoxBlock(value: isPaidValue,checkBoxFunction: isPaidSetter,
      lable: isArabicTabView?
      StringManager.trainingArabicLableIsPaid:
      StringManager.trainingEnglishLableIsPaid,
      textStyle: getSemiBoldStyle(
          fontSize: FontSize.s16,
          color: ColorManager.kBlackColor,
          fontFamily: FontFamily.kPoppinsFont),
      isArabic: isArabicTabView,
      ):
        FullInputBlock(
              lable: trainingLables[index],
              color: ColorManager.kBlackColor,
              controller: trainingControllers[index],
              enableBorder: true,
        multiLine: true,
        onlyInteger: index==1|| index==2 || index==3?true:false,
        isArabicTabView: isArabicTabView,),
        separatorBuilder: (context, index) => SizedBox(
              height: AppVerticalSize.s5,
            ),
        itemCount: trainingControllers.length+1);
  }
}
