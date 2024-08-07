import 'package:flutter/material.dart';
import 'package:portable_gym/cubits/profile_cubit/profile_cubit.dart';
import 'package:portable_gym/resourses/blocks/profile_blocks/log_out_bottom_sheet_block.dart';
import 'package:portable_gym/resourses/blocks/profile_blocks/profile_options_block.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';

import '../../managers_files/values_manager.dart';




class OptionsListBlock extends StatelessWidget {

  final List<String> lables;
  final Function(int,BuildContext) onClickFunction;
   const OptionsListBlock({super.key,
     required this.lables,
     required this.onClickFunction});



  @override
  Widget build(BuildContext context) {
    var profCubit= ProfileCubit.get(context);
    return  Expanded(
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s22),
          itemBuilder: (context, index) => InkWell(
              onTap: (){
                onClickFunction(index,context);
              },
              child: ProfileOptionBlock(lable: lables[index],)),
          separatorBuilder: (context, index) => SizedBox(height: AppVerticalSize.s10,),
          itemCount: lables.length),
    )
    ;
  }

}
