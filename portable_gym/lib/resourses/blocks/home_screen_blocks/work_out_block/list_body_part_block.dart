import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/work_out_screens/level_screen.dart';

import 'body_parts_block.dart';

class ListBodyPartBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: AppVerticalSize.s16),
          itemBuilder: (context, index) => InkWell(
              onTap: (){
                Get.to(LevelScreen());
              },
              child: BodyPartBlock()),
          separatorBuilder: (context, index) => SizedBox(height: AppVerticalSize.s22,),
          itemCount: 5),
    );
  }
}
