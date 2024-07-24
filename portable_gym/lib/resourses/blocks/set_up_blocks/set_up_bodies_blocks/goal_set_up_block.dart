import 'package:flutter/material.dart';


import '../../../managers_files/color_manager.dart';
import '../../../managers_files/values_manager.dart';
import '../set_up_blocks/age_picker_block.dart';
import '../set_up_blocks/gender_block.dart';
import '../set_up_blocks/goal_choice_block.dart';

class GoalSetUpBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: AppVerticalSize.s394,
      color: ColorManager.kLightPurpleColor,
      padding: EdgeInsets.symmetric(
          horizontal: AppHorizontalSize.s20,
          vertical: AppVerticalSize.s5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: AppVerticalSize.s20),
                itemBuilder: (context, index) => GoalChoiceBlock(),
                separatorBuilder: (context, index) => SizedBox(height: AppVerticalSize.s16,),
                itemCount: 5),
          )
        ],
      ),
    );
  }
}
