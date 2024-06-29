import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../managers_files/color_manager.dart';
import '../../../managers_files/values_manager.dart';




class VideoShowBlock extends StatelessWidget {
  VideoPlayerController? controller;

  VideoShowBlock({required this.controller});

  @override

  Widget build(BuildContext context) {
    return   Container(
      height: AppVerticalSize.s160,
      width: AppHorizontalSize.s220,
      margin: EdgeInsets.only(top: AppVerticalSize.s10),
      decoration: BoxDecoration(
        border: Border.all(color: ColorManager.kBlackColor,width: AppHorizontalSize.s3),
        borderRadius: BorderRadius.circular(AppRadiusSize.s22),
      ),
      child: controller!=null && controller!.value.isInitialized?AspectRatio(
          aspectRatio: controller!.value.aspectRatio,
      child: VideoPlayer(controller!),):SizedBox(),
    );
  }
}
