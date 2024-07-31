import 'package:flutter/material.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:video_player/video_player.dart';

import '../../managers_files/values_manager.dart';



class GeneralVideoBlock extends StatefulWidget {
  final String videoLink;
  final bool isViewOnly;
  const GeneralVideoBlock({super.key,required this.videoLink,this.isViewOnly=true});

  @override
  State<GeneralVideoBlock> createState() => _GeneralVideoBlockState();
}

class _GeneralVideoBlockState extends State<GeneralVideoBlock> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized? InkWell(
      onTap:widget.isViewOnly? null:_togglePlayPause,
      child: ClipRRect(
        // borderRadius: BorderRadius.circular(AppRadiusSize.s20),
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
      ),
    ) :const Center(child: CircularProgressIndicator(color: ColorManager.kPurpleColor,));
  }
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoLink)
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
}