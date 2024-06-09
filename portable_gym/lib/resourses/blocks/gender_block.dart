import 'package:flutter/material.dart';

import '../managers_files/color_manager.dart';
import '../managers_files/image_manager.dart';
import '../managers_files/values_manager.dart';

class GenderBlock extends StatelessWidget {
  final String image;
  final bool isChosed;

  GenderBlock({required this.image, required this.isChosed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: AppHorizontalSize.s30, vertical: AppVerticalSize.s30),
      decoration: BoxDecoration(
          color: isChosed
              ? ColorManager.kLimeGreenColor
              : ColorManager.kBlackColor,
          shape: BoxShape.circle,
          border: Border.all(
              width: AppHorizontalSize.s2,
              color: isChosed
                  ? ColorManager.kLimeGreenColor
                  : ColorManager.kWhiteColor)),
      child: Image.asset(
        image,
        color: isChosed ? ColorManager.kBlackColor : ColorManager.kWhiteColor,
        width: AppHorizontalSize.s70,
        height: AppVerticalSize.s120,
      ),
    );
  }
}
