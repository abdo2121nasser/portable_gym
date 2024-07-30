import 'package:flutter/material.dart';
import 'package:portable_gym/cubits/profile_cubit/profile_cubit.dart';
import 'package:portable_gym/resourses/blocks/profile_blocks/profile_options_block.dart';

import '../../managers_files/values_manager.dart';




class ProfileOptionListBlock extends StatelessWidget {
  const ProfileOptionListBlock({super.key});



  @override
  Widget build(BuildContext context) {
    var profCubit= ProfileCubit.get(context);
    return  Expanded(
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s22),
          itemBuilder: (context, index) => InkWell(
              onTap: (){
                ProfileCubit.get(context).profileScreenNavigation(index: index);
              },
              child: ProfileOptionBlock(lable: profCubit.getProfileOptions(context: context, index: index),)),
          separatorBuilder: (context, index) => SizedBox(height: AppVerticalSize.s10,),
          itemCount: 3),
    )
    ;
  }
}
