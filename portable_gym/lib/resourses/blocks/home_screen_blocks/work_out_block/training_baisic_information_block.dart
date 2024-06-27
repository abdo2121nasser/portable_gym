import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../../managers_files/color_manager.dart';
import '../../general_blocks/full_input_block.dart';

class TrainingBaisicInformationBlock extends StatelessWidget {
  List<String> trainingLables;
  List<TextEditingController> trainingControllers;
  final bool isLableAtEnd;
  TrainingBaisicInformationBlock(
      {required this.trainingLables, required this.trainingControllers,this.isLableAtEnd=false});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(bottom: AppVerticalSize.s55),shrinkWrap: true,
        itemBuilder: (context, index) => FullInputBlock(
              lable: trainingLables[index],
              color: ColorManager.kBlackColor,
              controller: trainingControllers[index],
              enableBorder: true,
        isAtEnd: isLableAtEnd,),
        separatorBuilder: (context, index) => SizedBox(
              height: AppVerticalSize.s5,
            ),
        itemCount: 5);
  }
}
