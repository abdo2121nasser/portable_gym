import 'package:flutter/material.dart';

import '../../../managers_files/color_manager.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';
import '../../../managers_files/values_manager.dart';
import '../../general_blocks/check_box_block.dart';



class GridMealTypesBlock extends StatelessWidget {
  final List<String> lables;
  final List<bool> values;
  final bool isArabic;
  final Function(int,bool) function;

  GridMealTypesBlock({required this.lables,required this.values,this.isArabic=false,required this.function});

  @override
  Widget build(BuildContext context) {
    return   SizedBox(
      height: AppVerticalSize.s100,
      child: GridView.builder(
        padding: EdgeInsets.symmetric(
            horizontal: AppHorizontalSize.s10,
            vertical: AppVerticalSize.s14),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            // mainAxisExtent: 140,
            crossAxisSpacing: 0,
            childAspectRatio: (1.5 / 0.3),
            mainAxisSpacing: 15),
        itemBuilder: (context, index) => CheckBoxBlock(
          value: values[index],
          checkBoxFunction: (bool? value){
            function(index,value!);
          },
          lable: lables[index],
          textStyle: getSemiBoldStyle(
              fontSize: FontSize.s16,
              color: ColorManager.kBlackColor,
              fontFamily: FontFamily.kPoppinsFont),
        isArabic: isArabic,),
        itemCount: lables.length,
      ),
    );
  }
}
