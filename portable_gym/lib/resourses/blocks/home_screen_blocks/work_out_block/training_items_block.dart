import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/work_out_block/round_item_block.dart';

import '../../../../screens/navigation_bar_screens/home_screen/home_subscreens/work_out_screens/exercise_screen.dart';
import '../../../managers_files/values_manager.dart';
import '../../../models/work_out_models/training_model.dart';



class TrainingItemsBlock extends StatelessWidget {
    final List<TrainingModel> trainingModel;

    TrainingItemsBlock({required this.trainingModel});

  @override
  Widget build(BuildContext context) {
    return   Expanded(
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s20, vertical: AppVerticalSize.s10),
          itemBuilder: (context, index) => InkWell(
              onTap: (){
                Get.to(ExerciseScreen(trainingModel: trainingModel[index],));
              },
              child: RoundItemBlock(trainingModel: trainingModel[index],)),
          separatorBuilder: (context, index) => SizedBox(height: AppVerticalSize.s5,),
          itemCount: trainingModel.length),
    );
  }
}
