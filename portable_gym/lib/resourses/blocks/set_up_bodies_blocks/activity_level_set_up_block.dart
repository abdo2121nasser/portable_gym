import 'package:flutter/material.dart';

import '../../managers_files/image_manager.dart';
import '../../managers_files/values_manager.dart';
import '../set_up_blocks/gender_block.dart';
import '../set_up_blocks/levels_block.dart';





class ActivityLevelSetUpBlock extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
        height: AppVerticalSize.s253,
        child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s20),
            itemBuilder: (context, index) => LevelsBlock(),
            separatorBuilder: (context, index) => SizedBox(height: AppVerticalSize.s22,),
            itemCount: 3),
      );
  }
}
