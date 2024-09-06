import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:video_player/video_player.dart';

import '../../managers_files/values_manager.dart';

class GeneralVideoBlock extends StatefulWidget {
  final String videoLink;
  final bool isViewOnly;
  const GeneralVideoBlock({super.key, required this.videoLink, this.isViewOnly = true});

  @override
  State<GeneralVideoBlock> createState() => _GeneralVideoBlockState();
}

class _GeneralVideoBlockState extends State<GeneralVideoBlock> {
  VideoPlayerController? _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    final cacheManager = DefaultCacheManager();
    final fileInfo = await cacheManager.getFileFromCache(widget.videoLink);
    File? videoFile;

    if (fileInfo != null && fileInfo.file.existsSync()) {
      videoFile = fileInfo.file;
    } else {
      videoFile = await cacheManager.getSingleFile(widget.videoLink);
    }

    // Initialize the VideoPlayerController with the cached file
    _controller = VideoPlayerController.file(videoFile)
      ..initialize().then((_) {
        setState(() {}); // Refresh the UI once the video is initialized
      });
    _controller?.setLooping(true);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller!.value.isPlaying) {
        _controller?.pause();
        _isPlaying = false;
      } else {
        _controller?.play();
        _isPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _controller != null && _controller!.value.isInitialized
        ? InkWell(
      onTap: widget.isViewOnly ? null : _togglePlayPause,
      child: ClipRRect(
        child: AspectRatio(
          aspectRatio: _controller!.value.aspectRatio,
          child: VideoPlayer(_controller!),
        ),
      ),
    )
        : const Center(
      child: CircularProgressIndicator(
        color: ColorManager.kPurpleColor,
      ),
    );
  }
}
