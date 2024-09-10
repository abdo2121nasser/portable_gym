import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../managers_files/values_manager.dart';

class GeneralVideoCashBlock extends StatefulWidget {
  final String videoLink;
  const GeneralVideoCashBlock(
      {super.key, required this.videoLink,});

  @override
  State<GeneralVideoCashBlock> createState() => _GeneralVideoCashBlockState();
}

class _GeneralVideoCashBlockState extends State<GeneralVideoCashBlock> {
  VideoPlayerController? _controller;
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {

    // Display video player if not in view-only mode
    return _controller != null && _controller!.value.isInitialized
        ? InkWell(
      onTap: _togglePlayPause, // Disable interaction if in view-only mode
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

  @override
  void initState() {
    super.initState();
      _initializeVideo(); // Initialize the video player if not in view-only mode
  }

  // Generate video thumbnail

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
        if (mounted) {
          setState(() {}); // Refresh the UI once the video is initialized
        }
      });
    _controller?.setLooping(true);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_controller != null && _controller!.value.isInitialized) {
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
  }
}
