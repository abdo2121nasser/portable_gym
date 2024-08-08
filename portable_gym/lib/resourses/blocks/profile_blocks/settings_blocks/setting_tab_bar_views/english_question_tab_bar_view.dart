import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../../../managers_files/color_manager.dart';
import '../../../../managers_files/string_manager.dart';
import '../../../general_blocks/full_input_block.dart';

class EnglishQuestionTabBarView extends StatelessWidget {
  final List<String> lables;
  final List<TextEditingController> controllers;
  const EnglishQuestionTabBarView(
      {super.key, required this.lables, required this.controllers});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) =>
        FullInputBlock(lable: lables[index],
color: ColorManager.kBlackColor,
enableBorder: true,
controller: controllers[index]),
        separatorBuilder: (context, index) => SizedBox(height: AppVerticalSize.s2),
        itemCount: controllers.length);
  }
}


