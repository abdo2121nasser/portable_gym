import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/work_out_block/round_item_block.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';
import 'package:portable_gym/screens/navigation_bar_screens/home_screen/home_subscreens/work_out_screens/exercise_screen.dart';

import '../../../../generated/l10n.dart';
import '../../../managers_files/color_manager.dart';
import '../../../managers_files/font_manager.dart';
import '../../../managers_files/style_manager.dart';

class RoundsBlock extends StatelessWidget {
  final int roundNumber;

  RoundsBlock({required this.roundNumber});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          S.of(context).round+roundNumber.toString(),
          style: getMeduimStyle(
              fontSize: FontSize.s20,
              color: ColorManager.kLimeGreenColor,
              fontFamily: FontFamily.kPoppinsFont),
        ),
        SizedBox(
        height: MediaQuery.of(context).size.height*0.3,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(vertical: AppVerticalSize.s5),
            shrinkWrap: true,
              itemBuilder: (context, index) =>  InkWell(
                  onTap: (){
                    Get.to(ExerciseScreen());
                  },
                  child: RoundItemBlock()),
              separatorBuilder:  (context, index) => SizedBox(height: AppVerticalSize.s10,),
              itemCount: 5),
        )
      ],
    );
  }
}
