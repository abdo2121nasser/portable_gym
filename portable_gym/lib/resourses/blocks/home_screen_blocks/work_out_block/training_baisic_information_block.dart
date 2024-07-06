import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/string_manager.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

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
        Row(
          mainAxisAlignment:isArabicTabView? MainAxisAlignment.end:MainAxisAlignment.start,
          children: [
            isArabicTabView?CheckBoxBlock(value: isPaidValue,function: isPaidSetter,):SizedBox(),
            //handling the arrangement of the check box and the text in arabic tabview
            Text(
             isArabicTabView?
              StringManager.trainingArabicLableIsPaid:
              StringManager.trainingEnglishLableIsPaid,
              style: getSemiBoldStyle(
                  fontSize: FontSize.s16,
                  color: ColorManager.kBlackColor,
                  fontFamily: FontFamily.kPoppinsFont),
              textAlign: isArabicTabView?TextAlign.end:TextAlign.start,
            ),
            //handling the arrangement of the check box and the text in english tabview
            isArabicTabView?SizedBox():
            CheckBoxBlock(value: isPaidValue,function: isPaidSetter,),
          ],
        ):
        FullInputBlock(
              lable: trainingLables[index],
              color: ColorManager.kBlackColor,
              controller: trainingControllers[index],
              enableBorder: true,
        onlyInteger: index==1|| index==2?true:false,
        isArabicTabView: isArabicTabView,),
        separatorBuilder: (context, index) => SizedBox(
              height: AppVerticalSize.s5,
            ),
        itemCount: trainingControllers.length+1);
  }
}
