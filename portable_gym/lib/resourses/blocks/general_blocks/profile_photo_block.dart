import 'dart:io';
import 'package:flutter/material.dart';
import '../../managers_files/color_manager.dart';
import '../../managers_files/image_manager.dart';
import '../../managers_files/values_manager.dart';

class ProfilePhotoBlock extends StatelessWidget {
  final ImageProvider image;
  final bool isEditable;

  const ProfilePhotoBlock(
      {super.key, required this.image, this.isEditable = true});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Store the width and height of the first container in variables
        final double containerWidth = constraints.maxWidth;
        final double containerHeight = constraints.maxHeight;

        return Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: image,
                  // fit: BoxFit.fill,
                ),
              ),
            ),
            if (isEditable)
              Positioned(
                left: containerWidth * 0.59, // Adjust as needed
                bottom: containerHeight * 0.02, // Adjust as needed
                child: Container(
                  padding: EdgeInsets.all(AppVerticalSize.s5),
                  decoration: const BoxDecoration(
                    color: ColorManager.kLimeGreenColor,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    ImageManager.kPenIconImage,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
