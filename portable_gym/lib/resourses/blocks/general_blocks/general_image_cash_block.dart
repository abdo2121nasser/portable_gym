import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path/path.dart' as path;
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';

import '../../managers_files/color_manager.dart';

class GeneralImageCacheBlock extends StatefulWidget {
  final String link;
  const GeneralImageCacheBlock({super.key, required this.link});

  @override
  State<GeneralImageCacheBlock> createState() => _GeneralImageCacheBlockState();
}

class _GeneralImageCacheBlockState extends State<GeneralImageCacheBlock> {
  String? _imagePath;
  String? _thumbnailPath;

  @override
  Widget build(BuildContext context) {
    // Display thumbnail if it's a video, otherwise display the image
    return _thumbnailPath != null
        ? Image.file(
      File(_thumbnailPath!),
      fit: BoxFit.cover,
    )
        : _imagePath != null
        ? Image.file(
      File(_imagePath!),
      fit: BoxFit.cover,
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
    _processFile(); // Process file based on its type
  }

  Future<void> _processFile() async {
    final cacheManager = DefaultCacheManager();
    final fileInfo = await cacheManager.getFileFromCache(widget.link);
    File? file;

    if (fileInfo != null && fileInfo.file.existsSync()) {
      file = fileInfo.file;
    } else {
      file = await cacheManager.getSingleFile(widget.link);
    }

    if (_isImageFile(file)) {
      // If it's an image, just set the image path
      if (mounted) {
        setState(() {
          _imagePath = file?.path;
        });
      }
    } else if (_isVideoFile(file)) {
      // If it's a video, generate a thumbnail using FFmpeg
      await _generateVideoThumbnail(file!);
    } else {
      // Handle unsupported file types if needed
      print('Unsupported file type.');
    }
  }

  Future<void> _generateVideoThumbnail(File videoFile) async {
    final thumbnailPath = '${videoFile.path}_thumb.jpg';

    // Execute FFmpeg to generate the thumbnail
    await FFmpegKit.execute(
      '-i ${videoFile.path} -ss 00:00:01 -vframes 1 $thumbnailPath',
    );

    if (mounted) {
      setState(() {
        _thumbnailPath = thumbnailPath;
      });
    }
  }

  bool _isImageFile(File file) {
    final extension = path.extension(file.path).toLowerCase();
    return extension == '.jpg' ||
        extension == '.jpeg' ||
        extension == '.png' ||
        extension == '.gif' ||
        extension == '.webp';
  }

  bool _isVideoFile(File file) {
    final extension = path.extension(file.path).toLowerCase();
    return extension == '.mp4' ||
        extension == '.mov' ||
        extension == '.avi'; // Add other video formats if needed
  }

  @override
  void dispose() {
    _imagePath = null;
    _thumbnailPath = null;
    super.dispose();
  }
}
