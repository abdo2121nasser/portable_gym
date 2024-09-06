import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:portable_gym/resourses/managers_files/color_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../managers_files/values_manager.dart';

class GeneralVideoBlock extends StatefulWidget {
  final String videoLink;
  final bool isViewOnly;
  const GeneralVideoBlock(
      {super.key, required this.videoLink, this.isViewOnly = true});

  @override
  State<GeneralVideoBlock> createState() => _GeneralVideoBlockState();
}

class _GeneralVideoBlockState extends State<GeneralVideoBlock> {
  VideoPlayerController? _controller;
  bool _isPlaying = false;
  String? _thumbnailPath; // To store the thumbnail path

  @override
  Widget build(BuildContext context) {
    // Display thumbnail if in view-only mode
    if (widget.isViewOnly) {
      return _thumbnailPath != null
          ? Image.file(
              File(_thumbnailPath!),
              fit: BoxFit.cover,
            )
          : const Center(
              child: CircularProgressIndicator(
                color: ColorManager.kPurpleColor,
              ),
            );
    }

    // Display video player if not in view-only mode
    return _controller != null && _controller!.value.isInitialized
        ? InkWell(
            onTap: widget.isViewOnly
                ? null
                : _togglePlayPause, // Disable interaction if in view-only mode
            child: ClipRRect(
              child: AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: Stack(
                  children: [
                    VideoPlayer(_controller!), // Display the video
                    if (widget.isViewOnly)
                      Positioned.fill(
                        child: Container(
                          color: Colors.black.withOpacity(
                              0.3), // A slight overlay to indicate view-only mode
                        ),
                      ),
                  ],
                ),
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
    if (widget.isViewOnly) {
      _generateThumbnail(); // Generate thumbnail if in view-only mode
    } else {
      _initializeVideo(); // Initialize the video player if not in view-only mode
    }
  }

  // Generate video thumbnail
  Future<void> _generateThumbnail() async {
    final cacheManager = DefaultCacheManager();
    final fileInfo = await cacheManager.getFileFromCache(widget.videoLink);
    File? videoFile;

    if (fileInfo != null && fileInfo.file.existsSync()) {
      videoFile = fileInfo.file;
    } else {
      videoFile = await cacheManager.getSingleFile(widget.videoLink);
    }

    // Generate a thumbnail image from the video file
    final thumbnail = await VideoThumbnail.thumbnailFile(
      video: videoFile.path,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 128, // Adjust thumbnail height as needed
      quality: 75, // Adjust thumbnail quality
    );

    setState(() {
      _thumbnailPath = thumbnail;
    });
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
