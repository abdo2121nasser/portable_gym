import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../managers_files/color_manager.dart';
import '../../../managers_files/google_drive_function_manager.dart';
import '../../../managers_files/values_manager.dart';
import '../../general_blocks/general_video_block.dart';

class ExerciseVideoBlock extends StatelessWidget {
  final String videoUrl;

  const ExerciseVideoBlock({Key? key, required this.videoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          padding:  EdgeInsets.symmetric(horizontal: AppHorizontalSize.s30,vertical: AppVerticalSize.s30),  // Use hardcoded values for simplicity
          height: MediaQuery.of(context).size.height*0.55,
          color: ColorManager.kLightPurpleColor,// Replace with your ColorManager.kLightPurpleColor
          child:  ClipRRect(
          borderRadius: BorderRadius.circular(AppRadiusSize.s20),
              child: GeneralVideoBlock(videoLink: videoUrl,isViewOnly: false)),
        ),
      ],
    );
  }
}
