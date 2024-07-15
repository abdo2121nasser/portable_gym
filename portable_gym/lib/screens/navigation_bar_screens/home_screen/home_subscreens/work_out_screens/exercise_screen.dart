import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portable_gym/resourses/models/work_out_models/training_model.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../resourses/managers_files/color_manager.dart';
import '../../../../../resourses/managers_files/font_manager.dart';
import '../../../../../resourses/managers_files/style_manager.dart';
import '../../../../../resourses/blocks/home_screen_blocks/work_out_block/exercise_detail_block.dart';
import '../../../../../resourses/blocks/home_screen_blocks/work_out_block/exercise_video_block.dart';



class ExerciseScreen extends StatelessWidget {
  final TrainingModel trainingModel;


  ExerciseScreen({required this.trainingModel});

  @override
  Widget build(BuildContext context) {
    var languageModel=trainingModel.getLanguageClass(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        backgroundColor: ColorManager.kBlackColor,
        leadingWidth: MediaQuery.of(context).size.width ,
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
                  languageModel.name.toString(),
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
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
             ExerciseVideoBlock(videoUrl:trainingModel.videoLink.toString(),),
             ExerciseDetailBlock(trainingModel: trainingModel,)
           ],
         ),
    );
  }
}
