import 'package:flutter/material.dart';
import 'package:my_coach/cubits/profile_cubit/profile_cubit.dart';
import 'package:my_coach/resourses/blocks/general_blocks/option_block.dart';
import 'package:my_coach/resourses/managers_files/color_manager.dart';

import '../../managers_files/values_manager.dart';

class OptionsListBlock extends StatelessWidget {

  final List<String> lables;
  final List<String?>? subValues;
  final List<String?>? images;
  final List<IconData> icons;
  final Function(int,BuildContext) onClickFunction;
   const OptionsListBlock({super.key,
     required this.lables,
     this.subValues,
     this.images,
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
            image: images?[index],
            icon: icons.isNotEmpty? icons[index]:Icons.ice_skating,)),
        separatorBuilder: (context, index) => SizedBox(height: AppVerticalSize.s16,),
        itemCount: lables.length)
    ;
  }

}
