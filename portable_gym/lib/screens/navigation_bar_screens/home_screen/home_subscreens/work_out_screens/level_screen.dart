import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portable_gym/resourses/blocks/home_screen_blocks/work_out_block/training_of_day_block.dart';
import 'package:portable_gym/resourses/managers_files/values_manager.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../resourses/blocks/home_screen_blocks/work_out_block/rounds_block.dart';
import '../../../../../resourses/managers_files/color_manager.dart';
import '../../../../../resourses/managers_files/font_manager.dart';
import '../../../../../resourses/managers_files/style_manager.dart';

class LevelScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.kBlackColor,
        leadingWidth: MediaQuery.of(context).size.width * 0.35,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Row(
            children: [
              const Icon(
                Icons.arrow_left,
                color: ColorManager.kLimeGreenColor,
              ),
              Expanded(
                child: Text(
                  S.of(context).beginner,
                  style: getBoldStyle(
                      fontSize: FontSize.s20,
                      color: ColorManager.kPurpleColor,
                      fontFamily: FontFamily.kPoppinsFont),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TrainingOfDayBlock(trainingName: 'functional trainnning'),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: AppHorizontalSize.s20, vertical: AppVerticalSize.s10),
                itemBuilder: (context, index) => RoundsBlock(roundNumber: index+1,),
                separatorBuilder: (context, index) => SizedBox(height: AppVerticalSize.s5,),
                itemCount: 2),
          ),
        ],
      ),
    );
  }
}
