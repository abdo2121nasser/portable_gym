import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../managers_files/color_manager.dart';
import '../../../managers_files/values_manager.dart';

class ExerciseVideoBlock extends StatefulWidget {
  final String videoUrl;

  const ExerciseVideoBlock({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _ExerciseVideoBlockState createState() => _ExerciseVideoBlockState();
}

class _ExerciseVideoBlockState extends State<ExerciseVideoBlock> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

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
          child:    _controller.value.isInitialized ? Stack(
            alignment: Alignment.topRight,
            children: [
              InkWell(
                onTap: _togglePlayPause,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadiusSize.s20),
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),  // Replace with your ImageManager.kSmileManImage
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(AppVerticalSize.s12),
                child: Icon(Icons.star_rounded,color: ColorManager.kLimeGreenColor,size: AppVerticalSize.s44,),
              )
            ],
          ):CircularProgressIndicator(),
        ),
      ],
    );
  }
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(convertGoogleDriveLinkToStreamable(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});  // Ensure the first frame is shown after the video is initialized
      });
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }
  String convertGoogleDriveLinkToStreamable(String originalLink) {
    final RegExp regExp = RegExp(r'd/([a-zA-Z0-9_-]+)/');
    final match = regExp.firstMatch(originalLink);
    if (match != null) {
      final fileId = match.group(1);
      return 'https://drive.google.com/uc?export=download&id=$fileId';
    } else {
      throw FormatException('Invalid Google Drive link');
    }
  }

}
