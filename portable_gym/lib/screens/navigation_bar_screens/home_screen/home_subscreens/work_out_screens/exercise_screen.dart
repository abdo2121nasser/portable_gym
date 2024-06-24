import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../resourses/managers_files/color_manager.dart';
import '../../../../../resourses/managers_files/font_manager.dart';
import '../../../../../resourses/managers_files/style_manager.dart';
import 'exercise_video_block.dart';



class ExerciseScreen extends StatelessWidget {

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
           children: [
             ExerciseVideoBlock()
           ],
         ),
    );
  }
}
