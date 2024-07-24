import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portable_gym/resourses/blocks/general_blocks/general_app_bar_block.dart';
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

      appBar: GeneralAppBarBlock(title: languageModel.name.toString(),),
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
