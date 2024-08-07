import 'package:flutter/material.dart';

import '../../../../managers_files/color_manager.dart';
import '../../../../managers_files/string_manager.dart';
import '../../../general_blocks/full_input_block.dart';




class EnglishQuestionTabBarView extends StatelessWidget {
  final List<String> lables;
  final List<TextEditingController> controllers;
  const EnglishQuestionTabBarView({super.key,
  required this.lables,
    required this.controllers
  });

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        FullInputBlock(lable: lables[0],
            color: ColorManager.kBlackColor,
            enableBorder: true,
            controller: controllers[0]),
        FullInputBlock(
            lable: lables[1],
            color: ColorManager.kBlackColor,
            enableBorder: true,
            controller: controllers[1]),
      ],
    );
  }
}
