import 'package:flutter/material.dart';
import 'package:my_coach/resourses/blocks/general_blocks/full_input_block.dart';

import '../../../managers_files/color_manager.dart';
import '../../../managers_files/values_manager.dart';

class ListRecipeInputBlock extends StatelessWidget {
   final List<TextEditingController> controllers;
   final List<String> lables;
   final bool  isArabicTabView;

   const ListRecipeInputBlock({super.key, required this.controllers,required this.lables,this.isArabicTabView=false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) => FullInputBlock(
              lable: lables[index],
              color: ColorManager.kBlackColor,
              controller: controllers[index],
          enableBorder: true,
          isArabicTabView: isArabicTabView,
            multiLine: true,
            onlyInteger: index==1||index==2||index==3?true:false,
          ),
          separatorBuilder: (context, index) => SizedBox(
                height: AppVerticalSize.s5,
              ),
          itemCount: controllers.length),
    );
  }
}
