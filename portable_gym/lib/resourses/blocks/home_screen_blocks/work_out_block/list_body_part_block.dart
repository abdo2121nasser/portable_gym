import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:portable_gym/resourses/models/work_out_models/body_category_model.dart';
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/work_out_screens/level_screen.dart';

import 'body_parts_block.dart';

class ListBodyPartBlock extends StatelessWidget {
  final List<BodyCategoryModel> bodyCategoryModel;

  ListBodyPartBlock({required this.bodyCategoryModel});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: AppVerticalSize.s16),
          itemBuilder: (context, index) => InkWell(
              onTap: (){
                Get.to(LevelScreen(bodyCategory: bodyCategoryModel[index].english!.title!,));
              },
              child: BodyPartBlock(bodyCategoryModel: bodyCategoryModel[index],)),
          separatorBuilder: (context, index) => SizedBox(height: AppVerticalSize.s22,),
          itemCount: bodyCategoryModel.length),
    );
  }
}
