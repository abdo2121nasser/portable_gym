import 'package:flutter/material.dart';
import 'package:portable_gym/cubits/profile_cubit/profile_cubit.dart';
import 'package:portable_gym/resourses/blocks/profile_blocks/log_out_bottom_sheet_block.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/option_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';

import '../../managers_files/values_manager.dart';




class OptionsListBlock extends StatelessWidget {

  final List<String> lables;
  final List<String?>? subValues;
  final List<IconData> icons;
  final Function(int,BuildContext) onClickFunction;
   const OptionsListBlock({super.key,
     required this.lables,
     this.subValues,
     required this.icons,
     required this.onClickFunction});



  @override
  Widget build(BuildContext context) {
    return  ListView.separated(
      shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s22,vertical: AppVerticalSize.s5),
        itemBuilder: (context, index) => InkWell(
            onTap: (){
              onClickFunction(index,context);
            },
            child: OptionBlock(lable: lables[index],
            subValue: subValues?[index],
            icon: icons[index],)),
        separatorBuilder: (context, index) => SizedBox(height: AppVerticalSize.s16,),
        itemCount: lables.length)
    ;
  }

}
